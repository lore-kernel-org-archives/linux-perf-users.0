Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4873AFD11
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523006; cv=none; b=O6N2cLNmU14z/Tw5P4UC0VapwEZGQ69OzMLCtOUJ+AA4T5pXRocYpsTMjwSblSJhX8+N6/hfeuRSW46ckkxZh+2U7Lg0hRIZMlCV4JR/QsJSYZ0dZadr58uPSEJw4R7lnB+n8AXRRnKGcxHWOHptfWGZUvj6CBKZf8OuGPkggQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523006; c=relaxed/simple;
	bh=EWFX14S5S4AwJhY0cKfVE1HGE0N3vqzkadD0+/GQaKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YlfOSDjoE9sKPxtaUfzY1EUquEDbdjpsNsH1KsCyvWyM9VYiXH66lO5R6y+lTWhkT1YdPnmwfw48cTEwaZVOZ9qCQcSSbT+QNguBOSyygeEPHhi+ywvYlV4KFJaENX707yIZlgRQ6sogtZsfBJUXK5gsmpVDydVdIQIw+oYuzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Igk+pq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Igk+pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881781F00899;
	Wed, 16 Sep 2026 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522984;
	bh=AcFERlgsrYgga3QGrFZYvimJsbj2G+IuJ9cqAQlmeR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O8Igk+pqbwhQFPW9Tzdzfzte0FeiHV61UyOtIu3SaItrXlqPgXlLKKtPvJxstkq1X
	 1fZGqzEaozVqKwX/EZ3Nv2m7acKh9A5MjsIO2fAr1V0coXppmlfIfmc7uRwg0XZB9e
	 MgqmTHLheyyx09Nx/iNedgtll8gRMjHbtBIMXMMxNRz0VSyyD6PUn0ZoL/MopJzQKj
	 obM8znIYju4Io5RWg7Qqt6C4+sp6k5LRDJ7Zizt9twVpEVTT/lAvC9C1qRPGpDB9/d
	 P7Y9B5jlU/XUmafPxtAKkO3sihHTqBuhWK/GtAcmA8+w7kw3krjoKDE+ulLV95VELb
	 Eg9OkpryL9ZQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/26] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <3115e9c4253d6710aa995a2052e5b73da395726b.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <3115e9c4253d6710aa995a2052e5b73da395726b.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:43:04 +0000
Message-Id: <20260916014304.881781F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: arm64 DWARF register parser misses 'lr' and 'fp' aliases
--

commit 7f62b33196a65173a3a904647c4eb49f9a4b65f8
Author: Tengda Wu <wutengda@huaweicloud.com>

perf dwarf-regs: Adapt get_dwarf_regnum() for arm64

This commit replaces the static string table lookup for AArch64 DWARF
registers with a programmatic implementation in __get_dwarf_regnum_arm64().
This change allows resolving arm64 register names directly from raw
instructions during annotation.

> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/p=
erf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> index 593ca7d4fccca..425c8aa2e9840 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
[ ... ]
> @@ -10,3 +12,26 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_=
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
Does this prefix check erroneously reject the standard AArch64 aliases 'lr'
and 'fp'?

When perf annotate parses instructions where AArch64 objdump outputs 'lr'
and 'fp' instead of 'x30' and 'x29', extract_op_location_arm64() passes the=
se
names to __get_dwarf_regnum_arm64(). By strictly requiring an 'x' or 'w'
prefix (or exactly 'sp'), this rejects 'lr' or 'fp' with -ENOENT.

Can this effectively disable data type tracking for variables accessed via =
the
link register or frame pointer, resulting in incomplete profiling output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D7
