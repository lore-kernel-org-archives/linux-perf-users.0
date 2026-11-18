Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990123;
	b=uKDpJjLWYfW9yR/qeJUape5HGqMt/l8AOWMarrwpROuAWNgvZU1jhGhuCDotxHtP2G6X
	 IDRpe/bj/nOXYvyK8EB/nL+4yBKP0xVPLhZ/2HnaE2b73RbBISo6rAmQlPcGHUaMAhCm3
	 sk2Av1Ob79aWn67v5uRWR362RHgR3wsN5HAgHgvM/jLNy8Dsx6FRbOW9ZUG9Y0hQJ2Ggu
	 jrRjTnKSc8IuzZkoFU2aKL8YihZXMfDFLrwxWYgo0xJnXg60c8x8Wc5zLDmynJhxfGz9M
	 P8DSq4+vFzUpYYPmHND5YWuZQlBJDsMrCO9xy3fTfIZrvxBTI31OiL+RcuJ0m0IaPmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DyrFx+aHriZZNFmGVyL/bUmoBEuVQZ6YrbZUub7P9K4=;
	b=vTEi8Hb99icEpE6rBqfFaPRXISPCtgsoVZKon+JbkVvhrBlPW6BX31gRbRuR3ULsVZ/H
	 7tOpkVHnqgAteyZDms1ORHK/E7fL4mtXqcDS0SpcemLzWLSqwAROYof/XgciwTltv2Lk/
	 qbkf0bCsrM5PMFepK/5zPOriDu9roCdXEINI+bG8LwJ4pcayVWA5HgV3I+pzMjp/AUGca
	 /K+ie5YVtVP05ROp3/9CFWxDzvNhkXSvDwmDmpblM/eKDXh05jCKomo1fuMaxQCJKTrZ0
	 dqpkoCFpuYgM3L66SWh8CYxlnpHNuektoSGUUdLdRCU1p1TcR1ll3fGU9FL4A3EBzSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R1Y+Y0p/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85EA606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1Y+Y0p/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D06E1F000C4;
	Wed, 18 Nov 2026 08:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990123;
	bh=DyrFx+aHriZZNFmGVyL/bUmoBEuVQZ6YrbZUub7P9K4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1Y+Y0p/AnBLe4p8fEYTbnQ2PzSYUGYshmmcD1yqWcCvMn8wit5zqO9YnILwI9ogM
	 blm8zu3I75bhD+fqPIcIByd6vipz3aDp1nc5sdo/WvzdeA9C+6glZpQ/38Mu8Vzumb
	 EUMdmbKzzq5uRgSbKyVLlalmNZ7qj1/gE+jwT+EyDuBKQjIwh4ExG6M7tdFHBMRIbZ
	 Ixr61Tu365NXZ6dJ43wuIGWAZGygbOB9mlGhL4aAh1A8xT6JFJyJowxRwAq+vdmvkW
	 8TAgHM8m3izI/cG7pQbzK9XBe/tr0gmf68g+O+/NkpRQPjJ0WgRB9HoCeZW9GbnDuh
	 EIALRCsEZ5Miw==
Message-ID: <sashiko-outbox-220428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] perf stat: Don't corrupt zero or prev_raw_counts
 on skipped per-pkg CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118075516.1278903-3-irogers@google.com>
References: <20261118075516.1278903-1-irogers@google.com>
 <20261118075516.1278903-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:22:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf stat: zero count on skipped CPUs in
  process_counter_values() fails aggr
--

commit 90a7348e9c069c01e179e728774f2e1d53d53fb3
Author: Ian Rogers <irogers@google.com>

perf stat: Don't corrupt zero or prev_raw_counts on skipped per-pkg CPUs

This commit replaces the static zero perf_counts_values structure in
process_counter_values() with a stack variable and computes interval deltas
before substituting zero for skipped per-package CPUs.

> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 6da3dbbde0e2a..267e280c5aa23 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -398,7 +398,7 @@ process_counter_values(struct perf_stat_config *confi=
g, struct evsel *evsel,
>  		       struct perf_counts_values *count)
>  {
>  	struct perf_stat_evsel *ps =3D evsel->stats;
> -	static struct perf_counts_values zero;
> +	struct perf_counts_values zero =3D {};
>  	bool skip =3D false;
> =20
>  	if (check_per_pkg(evsel, count, cpu_map_idx, &skip)) {
> @@ -406,12 +406,12 @@ process_counter_values(struct perf_stat_config *con=
fig, struct evsel *evsel,
>  		return -1;
>  	}
> =20
> -	if (skip)
> -		count =3D &zero;
> -
>  	if (!evsel->snapshot)
>  		evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
> -	perf_counts_values__scale(count, config->scale, NULL);
> +	if (skip)
> +		count =3D &zero;
> +	else
> +		perf_counts_values__scale(count, config->scale, NULL);

[Severity: Medium]
Should process_counter_values() return 0 when skip is true instead of
falling through with count =3D &zero?

In non-global aggregation modes such as AGGR_SOCKET (--per-socket) or
AGGR_DIE (--per-die), a skipped secondary CPU maps to the same ps_aggr entry
as the first CPU in that package or die:

tools/perf/util/stat.c:process_counter_values() {
    ...
			ps_aggr =3D &ps->aggr[i];
			ps_aggr->nr++;
    ...
			if (evsel__count_has_error(evsel, count, config) && !ps_aggr->failed) {
				ps_aggr->counts.val =3D 0;
				ps_aggr->counts.ena =3D 0;
				ps_aggr->counts.run =3D 0;
				ps_aggr->failed =3D true;
			}
    ...
}

Because zero has ena =3D=3D 0 and run =3D=3D 0, evsel__count_has_error() re=
turns
true for non-cgroup events, wiping out the package count accumulated from
the primary CPU and marking the bucket failed (<not counted>) while also
inflating ps_aggr->nr.  In interval mode, where underflow previously gave
the static zero structure non-zero ena and run after the first interval,
this regression causes every subsequent interval to fail too.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118075516.1278=
903-1-irogers@google.com?part=3D2
