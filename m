Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2543C1A
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110675; cv=none; b=FAALT9olGv1EmKh2/lZrjCHz0R5QMVqrAIZwlu8nl8aDqJc5xxadyc9nBROSkFXR9e4FsJ6ZoIcGmrDWjz90wuHRH4fm6Uy9xCv8yOEORr+QV1zP2LRCCz1nIZOQh4aW18X6z8YAypIE6WhszgBgHfaEw8jkjiq2urXbCVLjpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110675; c=relaxed/simple;
	bh=6kJyIpPc8nSM2AfHFqk184Rqn2v0QZqN/PJEaoLu9AI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CaxHDTCtrh7iFHGtaZ+wp8Sse1qUgBWBq6D0R646sZkUXDOMO75E1tb0alwr+P+zJt2WOIjz3nGZR+/zKXNXM2BT6DoGAEHrTAtg4gll2J6u8YNEr3MzvCXZ70aVkxedQ7djW/MU+OG/RGsvIZroRdZtykQFJGm0YTeksarafP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQpmiuYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQpmiuYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73CE1F000C4;
	Fri, 16 Oct 2026 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110674;
	bh=ZqEjDTvc73wVklY3RafMM7ntxG59gtRMAnVHYJsr5yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQpmiuYW409K1d93ObxWzvQwiVCKHIr4/FIm6MO9z4cxr9XVwIkCk/RUMmX+K1N8D
	 HfmKD+d/CYI1qADJxQrCClNF8KL6hFBIez/UWVp1UKGFtj2ICEuBW1Tsh5rWKhSbLP
	 fX68dG+78RuNe51Z1/rGBczoCFbQ7MHtw0Exh17geZNvpIqKvSNHXznkPWn8uHe2aa
	 5wj8jQPRQIJDTTYgnidRcSwgpnjMIgQxjIYam/qQIra2Eqk1hVDjWBnrqFMAQpdbYp
	 QPABPg6v0BOxoQVmhYrnuCMcjBL6ufT7LktJw2sgBe3KbO97xMfMClDwez6lC/6GM8
	 lB5QqvN6Pg8DQ==
Message-ID: <sashiko-outbox-173532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/19] perf evsel: Don't dump probe events to
 PERF_TEST_ATTR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-9-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:31:13 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: fd leak in evsel__open_cpu() on missing feature fallback
--

commit 4b54c2ca3d287fefa4e358bd15bc06b547bbe8da
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf evsel: Don't dump probe events to PERF_TEST_ATTR

This commit prevents support probe events from being dumped into the
$PERF_TEST_ATTR event files. It introduces a support_probe flag to identify
events opened strictly to query supported features.

Link: https://lore.kernel.org/linux-perf-users/asWQvXRdqp_RK85c@google.com/

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index e61f309e93dcc..59318fef03cb1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3104,7 +3104,11 @@ static int evsel__open_cpu(struct evsel *evsel, st=
ruct perf_cpu_map *cpus,
> =20
>  			bpf_counter__install_pe(evsel, idx, fd);
> =20
> -			if (unlikely(test_attr__enabled())) {
> +			/*
> +			 * Support probes aren't what was asked for, leave them
> +			 * out of the PERF_TEST_ATTR dump.
> +			 */
> +			if (unlikely(test_attr__enabled() && !evsel->support_probe)) {

[Severity: Medium]
Does this code leak file descriptors when a missing feature fallback is
triggered on a subsequent loop iteration?

If sys_perf_event_open() succeeds on a capable CPU and records the file
descriptor, but then fails on an incapable CPU, the code jumps to restart
the loop:

evsel__open_cpu() {
    ...
fallback_missing_features:
    evsel__disable_missing_features(evsel);
    ...
    for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
        ...
        for (thread =3D 0; thread < nthreads; thread++) {
            ...
            fd =3D sys_perf_event_open(...);
            FD(evsel, idx, thread) =3D fd;
            if (fd < 0) {
                err =3D -errno;
                goto try_fallback;
            }
            ...
try_fallback:
    ...
    if (err =3D=3D -EINVAL && evsel__detect_missing_features(evsel, cpu))
        goto fallback_missing_features;
}

When evsel__detect_missing_features() triggers the jump back to
fallback_missing_features, it appears the loop restarts from
start_cpu_map_idx without routing through out_close to clean up the
previously opened file descriptors. Can this leak the file descriptors when
the array entries are overwritten?

>  				test_attr__open(&evsel->core.attr, pid, cpu,
>  						fd, group_fd, evsel->open_flags);
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D8
