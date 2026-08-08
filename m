Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88437238C2A
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194774; cv=none; b=Oh7UBy+y294CnTPAVEGPj2SM3Ykm2pPJMXpU2QGKhZPJ65Il01ygW474auD77IMKk4va7bIyGOUMr8ptNX6VvMFgLWDxk0KmkXIjI9n2EJwacI6RXfts8Durl0dwnbw8cVg6dCXsJ4YUdyNMl9zrAlhD9yl4BFiMJoMgQfP4TLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194774; c=relaxed/simple;
	bh=QzXFBMaHoG1Ygn0F4hpymvsHoWpFRLr8ibZrPK7Sjvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HZi0TmIM8SQjZbuzuLmQdUyqJu3uqhfCrSZA1Aw1SYx3qj+ZkbcdEnVf9YdpQK/r9B667ZHok0fYLhlgu+hfsnCvP+8o3n+eDufnFl5/J0YFbOPQd+6mNornO8h5aqz1unHZJ4xd18DQ3WXmAIWeLeDrc/G3/sHm6ZQfKkFT2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbYrkcps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbYrkcps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107781F000E9;
	Sat,  8 Aug 2026 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194773;
	bh=k2axW0+3/u+4XGLGV7A21sa/1HGbuZVcncQrzof+PHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbYrkcpsy8jqkTbxQDVhmWWooF65ZW20nlsB2FbW4xj4CPLBFQ+NJGTAaDWkywvWw
	 OqNfEnitLiVClNGgnMFCtW/gcXHPmyuy/+Q86+j1dImsTG/5RzORV3p9H8dIOMQu5I
	 GFq4SVGO2sRLkxx0P7cq5M7aaCjFDh0xug/qg8q7Rd4lL5iK67ULHBjo8QznNwQ3CU
	 JuqWwXlIEmCDWvV6xkY/9EE4kOTIm0LYo1zx7IS5q2UQI8mqYsz9MNRaL7UrgEa5Sq
	 3cHkVCAzaGUZStVx0vZ5TfHpt01C/TYr4THKXUvVsH2EG3QZf9NjYpUSQLK3y9o4D4
	 eFypkfx5wdSTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/23] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-6-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-6-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:12:52 +0000
Message-Id: <20260808131253.107781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The programmatic DWARF register lookup __get_dwarf_regnum_arm64(=
) fails to support the standard AArch64 'lr' (link register) and 'fp' (fram=
e pointer) aliases.
--

--- Patch [5]: [PATCH v4 05/23] perf dwarf-regs: Adapt get_dwarf_regnum() f=
or arm64 ---
commit 7e82be98e18ee79f31ad73b727e21d33b0a6f30d
Author: Tengda Wu <wutengda@huaweicloud.com>

perf dwarf-regs: Adapt get_dwarf_regnum() for arm64

This patch replaces the static string table lookup for arm64 DWARF registers
with a programmatic implementation. This change allows resolving arm64
register names directly into their corresponding DWARF register numbers
during annotation parsing.

> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/p=
erf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> index 593ca7d4fccca..720c863d18696 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c

[ ... ]

> @@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_=
regnum)
> =20
>  	return perf_regnum;
>  }
> +
> +int __get_dwarf_regnum_arm64(const char *name)
> +{
> +	int reg;
> +
> +	if (!strcmp(name, "sp"))
> +		return 31;
> +
> +	if (*name !=3D 'x' && *name !=3D 'w')
> +		return -ENOENT;

[Severity: Medium]
Will this strict prefix check inadvertently reject standard AArch64 aliases
like lr and fp?

These architectural aliases are frequently emitted by objdump and were
previously handled by the old static table. When perf annotate attempts
to look up lr or fp, this programmatic DWARF register lookup in
__get_dwarf_regnum_arm64() will fail because the name does not start with
x or w.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D5
