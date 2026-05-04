Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8191F5825
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777876064; cv=none; b=SpcZ8c7jR/fClNy/IHRHCDL5qupLOQ96FaCkGBYeJALbrcqF/PhVHamiYH3mgN1cs/zyL7Cn8a2Cfoppd+vOi9Z+xFOq8FLErctmq7wgbRd2ssKhCVI7asK9deL/k8BJnWKxV2wcs6BiTygt/BxLwyeaDouuzUQm6M2Q1xJG4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777876064; c=relaxed/simple;
	bh=RDz7+7/4MCo5MYCX1Nogfjhhl1MhgBng/luqFhvxDqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VA91qbxtfS7+enh/HqC0LdC6Mge52SBy9SJ0TKT7SKYK6b68GYwFdsSbc89fkGNvre3vCteQmtxnpLXjpNd+unb1Y44z2O4myBqrBrePJp8LCV8lGMNZh/9QFDFiPUv6DSpXN9Q0Ot3Z0GpFg9xFugdP5sJjEAsSrDU33zbB+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH9TqmK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH9TqmK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE73C2BCB8;
	Mon,  4 May 2026 06:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777876064;
	bh=RDz7+7/4MCo5MYCX1Nogfjhhl1MhgBng/luqFhvxDqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BH9TqmK/9y1Dh8gC88I1CFKj0nJDhTZ0Pbn6xbfLiZPxxVb/NPca1sjet21ivao9q
	 ArdaeWtrb1YM3uKQqhxrR0dCwIkPiZePd1w/n4SZaPwi3ixsDZVpLEDqHKyv84LDoD
	 CWZeHPHUntw8suVD9tygARHgYAbK+ymplDa39SYesI6Sf70RU28aglNazfqcWoBXID
	 u4XpLsvy70TTSXnl4c29NdQuISTSH74zLo2gHnvvgAkKf148964S1+4G1GhCDRkbv2
	 l40metFrKePOzpGpGJ4riyUYCVsHs2AMwVBf6YBof5CvFsbocdysT83LaaFByVf3ka
	 sUwxAiKjKBEKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf lock contention: Allow 'mmap_lock' in
 -L/--lock-filter
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504060859.84987-1-namhyung@kernel.org>
References: <20260504060859.84987-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 06:27:43 +0000
Message-Id: <20260504062743.CCE73C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Combining `mmap_lock` with other lock names in the `-L/--lock-filt=
er` option drops all events.
- [High] Specifying only an unknown lock symbol in `-L/--lock-filter` silen=
tly traces all locks in the system instead of aborting.
--

commit ba21190eae512a9060154fb29ca23ce62c636cc2
Author: Namhyung Kim <namhyung@kernel.org>
Subject: perf lock contention: Allow 'mmap_lock' in -L/--lock-filter

This commit adds support for filtering lock contention events specifically =
for
the 'mmap_lock' using the -L/--lock-filter option. It introduces a special
flag to bypass the usual address-based filtering for mmap_lock.

> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index cbd7435579fe..cd7ee5d1d1dd 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c

[ ... ]

> @@ -264,7 +270,10 @@ int lock_contention_prepare(struct lock_contention *=
con)
>  			con->filters->addrs =3D addrs;
>  		}
>  		naddrs =3D con->filters->nr_addrs;
> -		skel->rodata->has_addr =3D 1;
> +		if (naddrs > 0)
> +			skel->rodata->has_addr =3D 1;
> +		else
> +			naddrs =3D 1;
>  	}

Prior to this patch, providing an unknown symbol (e.g., -L non_existent)
resulted in naddrs =3D 0 and has_addr =3D 1, which correctly caused libbpf =
to
fail creating the map with 0 entries, gracefully aborting the process.

With this change, if naddrs is 0, has_addr remains 0 but naddrs is
artificially set to 1. The BPF map creation succeeds, but since has_addr
and has_mmap_lock are both 0, the BPF program skips the address filter
entirely.

Does this unintentionally trace all locks in the system instead of graceful=
ly
aborting when an unknown lock name is provided?

> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 96e7d853b9ed..45ec2fb73984 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c

[ ... ]

> @@ -295,6 +298,14 @@ static inline int can_record(u64 *ctx)
>  			return 0;
>  	}
> =20
> +	if (has_mmap_lock) {
> +		__u64 lock =3D ctx[0];
> +		__u32 flag =3D ctx[1];
> +
> +		if (check_lock_type(lock, flag) !=3D LCD_F_MMAP_LOCK)
> +			return 0;
> +	}
> +
>  	return 1;
>  }

The -L option allows filtering by multiple lock names, but can_record()
evaluates active filters sequentially. If a user specifies
-L mmap_lock,other_lock, both has_mmap_lock =3D 1 and has_addr =3D 1 will be
set in the BPF rodata.

In this scenario:

1. An other_lock event passes the has_addr check but then reaches the
has_mmap_lock check. Since its type is not LCD_F_MMAP_LOCK, the function
returns 0.

2. An mmap_lock event is evaluated against the has_addr check first.
Because its dynamic address isn't in addr_filter, the lookup fails, and the
function returns 0 before even reaching the has_mmap_lock check.

Will this cause all valid events to be silently dropped when combining
mmap_lock with other lock names?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504060859.8498=
7-1-namhyung@kernel.org?part=3D1
