Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752309;
	b=VqKCrhbtmgtwTiVcAZCYLfP4g54dNPE33iqqcp3iaL6neX9RliAbPPWorCES2ALsRz3Q
	 EShpeMYy6uvUsiI15/GRvY0eANFZyZhk9WVrEdXUAm4sWzk1tuLsv/iApnYVov1EZLWaM
	 KWuYe0JzXy589HivcCzo0ISUaRCC5zq4d4pd9H7jMTsfqUH9zP1L4Z+hshm8almToIkmt
	 r1LivfXGM1ziGUZUm46hlMU3jyl0zTcN3Yr3tvcd8YHPphs5EcFG9e4neL3l+gmEhuyaX
	 lBwDPmRFtvrkO0dxYeMcr33B/30ccbgtxYFbJdA6VX41h9tyrK6m7h3m0ewy3rClW4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D0eLPxBuw+3Y2usQ6dFyzPbC7U4wn6SiX7Aa9yB7dJI=;
	b=T+AqWuqbMbJEwz8VPD6hOvQhKxjLGusyQa7Jj34SAo/EsAnppvLZH60eiFfX+qO215gA
	 MyfwaRfY5oK/yKBeOs2O90BLd8+Km3BYhKlaeXXjv+ZT0Vzyo6L4yRqgL+fwsSsYr0oO/
	 xklE2ypnOT+5l3c3W0mh7jN7kFQhjfnyTI7fKul0i7aTC2jRJ+cMbYbsT7+ga2GJ8lcCP
	 368q7MM9ucVPC5imTkvpOzNhoWfk5+wHFOXX0lU3dVpWFfsmTkZwhAWmwZ7dgEmXha4FL
	 xsJtG5MqAiWdI1uKUNtGVtSp1S1zb+SpvbYIjuyx5Kzmb9bPVxFJyEYodwjf0GCCm5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnKhVFJf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA47606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnKhVFJf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCEC1F000C1;
	Wed,  4 Nov 2026 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793752308;
	bh=D0eLPxBuw+3Y2usQ6dFyzPbC7U4wn6SiX7Aa9yB7dJI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KnKhVFJfYILxokxMt6VhNLq8kuu83L++Q0wZiUWiBn8jQJDXb/z65rLpA6Tl3LZ6J
	 EAV0wrhp+rIsiUA3yA4K6Ul2ZKl1GKDYJ6I6feSMW+DKPahCPmbbo6JOvE6e6xdIZ8
	 1yDaOGZSmD+vvObi0lXozMhuyhcOKb+JMXwOoQquhSMEpHuQZzxtOZQ1qES3r6Merv
	 1C+g2SpKsjF2elzVcoRrk+DH861XxgyPeSsMKyo7U+mV4aHc3Pt92l4MClPVrgB10N
	 VFWjFlzITygz1uqArNyE+zi/qjzbdvBmleo8zOgB7FaWxSNnFI8RAOTyp6WrPYIgxo
	 SJFVWU6ub1aeg==
Message-ID: <sashiko-outbox-196314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/41] perf pmu: Add from_env parameter to
 perf_pmu__init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-4-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:31:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf pmu: evsel__is_drm() and evsel__is_hwmon() bypass open/read=
 on from_env
--

commit ba6ab0f45b9bb32deca7319cf88953bc1e7ecb4b
Author: Ian Rogers <irogers@google.com>

perf pmu: Add from_env parameter to perf_pmu__init()

This commit adds a from_env boolean field to struct perf_pmu initialized via
perf_pmu__init() to distinguish PMUs reconstructed from perf_env headers fr=
om
live host PMUs, and guards tp_pmu, hwmon_pmu, and drm_pmu callbacks on
!pmu->from_env.

> diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
> index b8badae7015c6..cbbd5aafd24b8 100644
> --- a/tools/perf/util/drm_pmu.c
> +++ b/tools/perf/util/drm_pmu.c
> @@ -68,7 +68,7 @@ bool perf_pmu__is_drm(const struct perf_pmu *pmu)
> =20
>  bool evsel__is_drm(const struct evsel *evsel)
>  {
> -	return perf_pmu__is_drm(evsel->pmu);
> +	return perf_pmu__is_drm(evsel->pmu) && !evsel->pmu->from_env;
>  }

[ ... ]

> @@ -658,11 +658,17 @@ static uint64_t drm_pmu__read_for_pid(struct drm_pm=
u *drm, struct evsel *evsel,
> =20
>  int evsel__drm_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
>  {
> -	struct drm_pmu *drm =3D container_of(evsel->pmu, struct drm_pmu, pmu);
> +	struct drm_pmu *drm;
>  	struct perf_counts_values *count, *old_count =3D NULL;
> -	int pid =3D perf_thread_map__pid(evsel->core.threads, thread);
> +	int pid;
>  	uint64_t counter;
> =20
> +	if (!evsel->pmu || evsel->pmu->from_env)
> +		return -EINVAL;
> +
> +	drm =3D container_of(evsel->pmu, struct drm_pmu, pmu);
> +	pid =3D perf_thread_map__pid(evsel->core.threads, thread);
> +
>  	if (pid !=3D -1)
>  		counter =3D drm_pmu__read_for_pid(drm, evsel, pid);
>  	else
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index 96aeb379e169d..fab9f09d0253d 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -132,7 +132,7 @@ bool perf_pmu__is_hwmon(const struct perf_pmu *pmu)
> =20
>  bool evsel__is_hwmon(const struct evsel *evsel)
>  {
> -	return perf_pmu__is_hwmon(evsel->pmu);
> +	return perf_pmu__is_hwmon(evsel->pmu) && !evsel->pmu->from_env;
>  }

[ ... ]

> @@ -763,12 +763,18 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
>  			  struct perf_thread_map *threads,
>  			  int start_cpu_map_idx, int end_cpu_map_idx)
>  {
> -	struct hwmon_pmu *hwm =3D container_of(evsel->pmu, struct hwmon_pmu, pm=
u);
> +	struct hwmon_pmu *hwm;
>  	union hwmon_pmu_event_key key =3D {
>  		.type_and_num =3D evsel->core.attr.config,
>  	};
>  	int idx =3D 0, thread =3D 0, nthreads, err =3D 0;
> -	int dir =3D open(hwm->hwmon_dir, O_CLOEXEC | O_DIRECTORY | O_RDONLY);
> +	int dir;
> +
> +	if (!evsel->pmu || evsel->pmu->from_env)
> +		return -EINVAL;

[Severity: Medium]
Should evsel__is_drm() in tools/perf/util/drm_pmu.c and evsel__is_hwmon() in
tools/perf/util/hwmon_pmu.c really return false when evsel->pmu->from_env is
true?

In tools/perf/util/evsel.c, evsel__is_hwmon() and evsel__is_drm() are used =
by
evsel__open_cpu() and evsel__read_counter() to dispatch to the DRM and hwmon
open/read callbacks instead of the standard perf_event_open() and fd read
paths:

tools/perf/util/evsel.c:evsel__open_cpu() {
	if (evsel__is_hwmon(evsel)) {
		err =3D evsel__hwmon_pmu_open(evsel, threads,
					    start_cpu_map_idx,
					    end_cpu_map_idx);
		goto out;
	}
	if (evsel__is_drm(evsel)) {
		err =3D evsel__drm_pmu_open(evsel, threads,
					  start_cpu_map_idx,
					  end_cpu_map_idx);
		goto out;
	}
}

tools/perf/util/evsel.c:evsel__read_counter() {
	if (evsel__is_hwmon(evsel))
		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);

	if (evsel__is_drm(evsel))
		return evsel__drm_pmu_read(evsel, cpu_map_idx, thread);
}

Because evsel__is_drm() and evsel__is_hwmon() now return false when
evsel->pmu->from_env is true, evsel__open_cpu() skips evsel__hwmon_pmu_open=
()
and evsel__drm_pmu_open() and falls through into the sys_perf_event_open()
loop with synthetic userspace PMU types (PERF_PMU_TYPE_DRM_START..END or
PERF_PMU_TYPE_HWMON_START..END), and evsel__read_counter() skips
evsel__hwmon_pmu_read() and evsel__drm_pmu_read() and falls through to
evsel__read_group() / evsel__read_one().

This also makes the new evsel->pmu->from_env checks in evsel__drm_pmu_read()
and evsel__hwmon_pmu_open() unreachable from evsel.c, and leaves
evsel__is_drm() and evsel__is_hwmon() inconsistent with perf_pmu__is_drm(),
perf_pmu__is_hwmon(), and evsel__is_non_perf_event_open_pmu().

Would it be better to keep evsel__is_drm() and evsel__is_hwmon() checking
only perf_pmu__is_drm(evsel->pmu) and perf_pmu__is_hwmon(evsel->pmu) so that
evsel__open_cpu() and evsel__read_counter() dispatch to the DRM/hwmon
callbacks and return -EINVAL on from_env?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D3
