Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4B43933E
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554167; cv=none; b=XdjK9viZ/HrXVz4rpJocsr5n17fFVAKDDQiM+zk65FcmKgpg95X/OWoIp7zXuiXQwrt/HyC0qJVkAVnkwzqAKsMO44Pq/T4SxlBic7XGYInpnbO90dv5jLNNM9Z9kFwhRUvtUI0j8D1gIcKI/2c2cWKmIR8bBRmPUbvMT+1qfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554167; c=relaxed/simple;
	bh=xww+1ZiqVFDUz4jTIBprU83fellfjAmGMoMIqMLeEBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=twHaoMPH9KLY12mwodAxW7AV5R3zUnZH9OccntrouU72NvexH8bAtUWpQByZwuDBWjTKKg9vx9BjPROI9bvtgkSVwZFX5sYQih546akfR1y44eKDAfN8E3fT4R/fEAX4UyKQvUZpLzDY/h2ZsjJovYgyNLQAgZbKEH97Wu1m2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQk+Np/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQk+Np/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66011F000E9;
	Wed,  8 Jul 2026 23:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783554166;
	bh=v4mVlkHBonMi35cCkLwMyJGb+rd4kCUJZkB0FaG/FDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQk+Np/8a80sf7U6eouCy08aNpzYVV6qp3v73vicMpvpp+LcfyJnOuuTF8qu/wyuZ
	 1gxGNDjsIY5K3du7Mf3xMNc9d2zOHH2T/AZNsiV9EeZ0IAiQ2Fvg6wPG9Xp4yQGPmo
	 +zWbLg1wtYQRkxLbr6pGPr9qrDZZPN0ov5sgEJH8btER+lyNwnyvExvBWdZyZBMiDh
	 HtScEPxDR75IfRNHKAS/Ttql9cgU7WhSdRZ13h0cwi2OxESInWXvLDqbNYEWucHpTs
	 zLJAgkeXEh/736ADKAttcFuYMwb9toe7Urf+H8kBhFbdkY3HMw7qFgbAcXh2Dbp2pw
	 VqF9HNgf2UBVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf stat: Fix duplicate output with
 --for-each-cgroup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708233103.1359713-1-namhyung@kernel.org>
References: <20260708233103.1359713-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:42:45 +0000
Message-Id: <20260708234245.C66011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete state cloning in `evsel__clone()` breaks TPEBS latenc=
y fallback metrics and BPF counters for duplicated events.
--

--- Patch [1]: [PATCH v1 1/2] perf stat: Fix duplicate output with --for-ea=
ch-cgroup ---
commit 10359224b851cd21a00edee0e074af745faf63be
Author: Namhyung Kim <namhyung@kernel.org>

perf stat: Fix duplicate output with --for-each-cgroup

This commit fixes duplicate event output in perf stat when using the
--for-each-cgroup option. It addresses the issue by copying several
fields that were previously missed during evsel__clone().

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ea9fa04429f08..ee0b5b4c536c8 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -610,12 +610,18 @@ struct evsel *evsel__clone(struct evsel *dest, stru=
ct evsel *orig)
>  	evsel->percore =3D orig->percore;
>  	evsel->precise_max =3D orig->precise_max;
>  	evsel->is_libpfm_event =3D orig->is_libpfm_event;
> +	evsel->skippable =3D orig->skippable;
> +	evsel->retire_lat =3D orig->retire_lat;

[Severity: Medium]
When copying the retire_lat flag, do we also need to copy the associated
retirement_latency struct and the bpf_counter flag to avoid a regression?

Without copying the retirement_latency struct (mean, min, max), a cloned
event falling back to TPEBS might use a zeroed struct and incorrectly
calculate 0.0 latency instead of using the parsed values.=20

Similarly, omitting the bpf_counter flag might cause cloned BPF events
to silently bypass BPF counting.

> +	evsel->dont_regroup =3D orig->dont_regroup;
> =20
>  	evsel->exclude_GH =3D orig->exclude_GH;
>  	evsel->sample_read =3D orig->sample_read;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708233103.1359=
713-1-namhyung@kernel.org?part=3D1
