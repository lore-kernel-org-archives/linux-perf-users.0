Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A046D0A6
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656066; cv=none; b=pFj1ki0ymagkw1X5woRi4WRKtJiazSvHv9cGCe0d7yRHiyQAW3oYI4H5CZec+1CbtzQZpet6SJcMbdp1G7TO+qRBRbA97/Qrt6eSSVcIK/ThHfEwfBtwggn9g2h/MnnctyuziXmbN4V0getbev8yNsHi+cyTKZmv8Arsoz/Rfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656066; c=relaxed/simple;
	bh=IbX8/G4CCFbJk8PcnO9D4qD5s4jTxNeCsGl7NWExTHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNLtcYF+3NvFWAWXqsRqPhWt+77ocmh0KTtrjeN2EizGoN2S4j2TqyYzrgf5vxHMAWbK+u+YxVxTzQODeJyziUlcC7bGl7DTKXBdjfruIbGEQy92oJ8p9XAgbAMSS56dfBs576yNS5OR9ifCkiy5E5zrmJDdYV5lm1nWguJu08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUDhWtqX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUDhWtqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715211F000E9;
	Tue, 21 Jul 2026 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656064;
	bh=DmCK3JWD9/wNDwD1H2hcHWhhGDk2+ulcxYqkMrp+1LE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUDhWtqX3HvY5xQjviYiwvuJDJ1+NywaAvAeMjqomvlQPjg85SX8O1tGbswRzWZp/
	 BPKU3BOya7ttOmKn/p2nMi7a3KxekkTY13l4Bqs/mMtVQ1SO5lgseEnFKsf1m9WtBD
	 Cbg67I/g1aomFYSdxW8hV7Jf9s7bwchPo7mFRFZrbRe9oUMnt7HoEWtshSa1aBZX4Q
	 D2sTi0W18S6SWFdN0ruUOF4/ymkw7pfcoX3wSin1ET+ICal3bNs9NdcEGd1wEMwslP
	 hULzUxPlqm9eWLH+j+9s98VD8YGIpnH0bQWszgrvO+uvuaKqYX0K3fXuIDgARFO6V4
	 Kk+LLov43lMzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf synthetic-events: Fix bounds, stale state,
 and misc flags in kernel module synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721173347.9163-4-irogers@google.com>
References: <20260720225200.3810501-1-irogers@google.com>
 <20260721173347.9163-1-irogers@google.com>
 <20260721173347.9163-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:47:43 +0000
Message-Id: <20260721174744.715211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The memset used to clear the filename padding and ID header traile=
r will trigger a _FORTIFY_SOURCE runtime abort when a DSO name length appro=
aches PATH_MAX.
--

--- Patch [3]: [PATCH v3 3/4] perf synthetic-events: Fix bounds, stale stat=
e, and misc flags in kernel module synthesis ---
commit e862d233381463bc8c1e84b7d335152fe0a7c118
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix bounds, stale state, and misc flags in kernel mo=
dule synthesis

This commit clamps long DSO names to mmap/mmap2 filename boundaries to prev=
ent
buffer overruns in perf_event__synthesize_modules_maps_cb(). It also explic=
itly
clears misc flags and union padding to prevent stale Build-ID state from le=
aking
between module synthesis events.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c

[ ... ]

> @@ -761,49 +762,78 @@ static int perf_event__synthesize_modules_maps_cb(s=
truct map *map, void *data)
>  	if (!symbol_conf.no_buildid_mmap2) {
>  		const char *long_name =3D dso__long_name(dso);
> =20
> -		size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
> +		size =3D strlen(long_name);
> +		if (size >=3D sizeof(event->mmap2.filename))
> +			size =3D sizeof(event->mmap2.filename) - 1;
> +
> +		strlcpy(event->mmap2.filename, long_name,
> +			sizeof(event->mmap2.filename));
> +
> +		aligned_size =3D PERF_ALIGN(size + 1, sizeof(u64));
>  		event->mmap2.header.type =3D PERF_RECORD_MMAP2;
> -		event->mmap2.header.size =3D (sizeof(event->mmap2) -
> -					(sizeof(event->mmap2.filename) - size));
> -		memset(event->mmap2.filename + size, 0, args->machine->id_hdr_size);
> +		event->mmap2.header.misc =3D args->misc;
> +		event->mmap2.header.size =3D
> +			offsetof(struct perf_record_mmap2, filename) +
> +			aligned_size;
> +
> +		/* Zero the padding and ID header trailer safely! */
> +		memset(event->mmap2.filename + size, 0,
> +		       (aligned_size - size) + args->machine->id_hdr_size);

[Severity: High]
This is a pre-existing issue, but can this memset trigger a _FORTIFY_SOURCE
runtime abort when a DSO name length approaches PATH_MAX?

The event->mmap2.filename field is declared as a fixed-size array of
PATH_MAX (4096 bytes). If a kernel module path is very long, size is clamped
to 4095 and aligned_size evaluates to 4096. The memset then attempts to wri=
te
(1 + args->machine->id_hdr_size) bytes starting at event->mmap2.filename + =
4095.

Because the memset is anchored to the filename member array, _FORTIFY_SOURCE
dynamically tracks that there is only 1 byte remaining in that specific mem=
ber.
Since 1 + id_hdr_size > 1, this exceeds the compiler-enforced array bound,
triggering __chk_fail() and terminating perf, even though the underlying
allocation is large enough.

> +
>  		event->mmap2.header.size +=3D args->machine->id_hdr_size;
>  		event->mmap2.start =3D map__start(map);

[ ... ]

>  		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
>  	} else {
> -		size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
> +		const char *long_name =3D dso__long_name(dso);
> +
> +		size =3D strlen(long_name);
> +		if (size >=3D sizeof(event->mmap.filename))
> +			size =3D sizeof(event->mmap.filename) - 1;
> +
> +		strlcpy(event->mmap.filename, long_name,
> +			sizeof(event->mmap.filename));
> +
> +		aligned_size =3D PERF_ALIGN(size + 1, sizeof(u64));
>  		event->mmap.header.type =3D PERF_RECORD_MMAP;
> -		event->mmap.header.size =3D (sizeof(event->mmap) -
> -					(sizeof(event->mmap.filename) - size));
> -		memset(event->mmap.filename + size, 0, args->machine->id_hdr_size);
> +		event->mmap.header.misc =3D args->misc;
> +		event->mmap.header.size =3D
> +			offsetof(struct perf_record_mmap, filename) +
> +			aligned_size;
> +
> +		/* Zero the padding and ID header trailer safely! */
> +		memset(event->mmap.filename + size, 0,
> +		       (aligned_size - size) + args->machine->id_hdr_size);

[Severity: High]
This is a pre-existing issue, but this memset is subject to the same
_FORTIFY_SOURCE abort as the mmap2 case above when the DSO name approaches
PATH_MAX and sample IDs are enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721173347.9163=
-1-irogers@google.com?part=3D3
