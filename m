Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C46377ECF
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991203; cv=none; b=kWnxl9C31uz+51lXMBHtPIf5Pjbdkzo/A76hzI5o1zy67Fcq3y4ApKDFGfqmSQVzx8ZaEtK8iDUeE9s1nZD/MFWV1KqQ3AO5NWfaPG5sDDMF89Fdx5bhY25W/oTs5ffu0Si39aCjWc1UPJ9niesIDq67pRaDXumNy65R6+1JvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991203; c=relaxed/simple;
	bh=UB+sRy6ABIkJ+1btEVXMqP94PS/PDr/VcHZZXPxVxQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0688idgJiRhR+SoGTmpQ+0UARudGt/32ULJgzjggdWNgheY+4OzMLDis2Qu5zEeS8Oa/t7L7Vzt1WBa4L2sSLL4qucWpC+u3S1s2Yk+CFd7ZS7SkT39ZN4LuyHL9MVwkyUrb1XXHIEH2AI099BzIjlFJeCWl/4URnyqvTF6LX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei511fJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei511fJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BF91F00898;
	Sat,  3 Oct 2026 01:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991201;
	bh=OlUuT5fxB6eBDsJDaA801nX185t7owHlBMZKK5oevhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ei511fJuwnAWB+roSIXvEj4Uj33aNXH4wtVlsm+uhMYVpPWnyHu/7zgYQ5uXxX0X2
	 cb5XHMEp9+UOugpWCFUIt2jFBFenuPuJwWSgVkLoasjIrLgU4LBdnemeC6ZPcFlBwy
	 uP7PeCUDGFuP4SoqWLx+sNVgogbYrAFrb8KwX5eEIJNAUt4of9WkNGcXFY3HwwqtVj
	 PXM40QPbCyPufE+Q8nFREOBVVoybaA1zo6VZdJJN/pAXIjBCzmwEs+OLCnOg9qOZUS
	 oMC8Gbzl9mtgoWruBCTbqybUv5SjCwNVmpsZK09xKXf4oHerplsgeMCr34PB6TqkIk
	 /JBC55xaVAmHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] perf event: Factor build_id out into its own
 top-level struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-2-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:21 +0000
Message-Id: <20261003013321.89BF91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/libperf: API breakage in perf_record_mmap2 due to renamed fie=
lds
--

commit cfeda23f684f7f8aa6b272dc2febc41f9f8eb93c
Author: Ian Rogers <irogers@google.com>

perf event: Factor build_id out into its own top-level struct
   =20
This commit factors the build ID structure out into its own top-level type,
struct perf_build_id, for consistency. It updates the usage of build IDs
across various perf events to use this new type.

> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include=
/perf/event.h
> index fdced574c889e..173eab43c1484 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h

[ ... ]

> @@ -39,12 +48,7 @@ struct perf_record_mmap2 {
>  			__u64	 ino;
>  			__u64	 ino_generation;
>  		};
> -		struct {
> -			__u8	 build_id_size;
> -			__u8	 __reserved_1;
> -			__u16	 __reserved_2;
> -			__u8	 build_id[20];
> -		};
> +		struct perf_build_id build_id;

[Severity: High]
Does this break the source-level API for external libperf consumers?

External user-space applications (like bpftool, pahole, or custom perf data
parsers) that rely on event->mmap2.build_id_size or treat
event->mmap2.build_id as a byte array will fail to compile against the
updated libperf headers.

While this preserves the binary ABI since the memory layout is exactly 24
bytes in both cases, the renamed fields and altered types will break the
API for existing libperf users. Could this transition be handled with an
anonymous union to preserve source compatibility during the update?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D1
