Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121321;
	b=dENpyMviZOURpSLWN969OoSiS3zH1gATzZNdo6MAT1vxviBxj64irU7U8mfngB5XoswW
	 Wt1fUvbVSpt5D5A73An82oZlKQu9FnlewI3TYHpNEGSCCiAJ+wZCWYeO+0NqoX0aqcEB2
	 rZLwa8TlqQ85Y9J5zqjPaCGKxC6Cbvfwgkqirrjh+jEKynyIPiUP4xao++aS6w6rHXB5K
	 fsb2xKwq2qV1o/+quScY10fPagoRsx4lRZlWGGYIWNYFCw4qszhYWKsrCPWlVEtEpHZkk
	 g0+zgDRrW9db5qlcxaw/mKrqlytJ2E0xpmtVbY0+wNKpcRs6govGkk/5nown3A5DD+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PCB28u1OajNoRYRYQ8NkMwsOgcifcfI7TvW+XU28YV8=;
	b=PPGSs0ifpaIAo2QWRWcg2XIh9bm/uPMk+9wNJxT/SFiJaE3heQCTWInsJtybOwmvosdo
	 2yzh6abLYfWrGM6bWDxwGCXFjA+nBLUhCfWvUAERk07wqUWd+wNbDr1EVZPRt+SXe/Tsi
	 Bxz17zWCnbF94y0xwAV0gJFATEvYUUs12DKmv5IZlH5iLal4yYFC6lJZ4KaxPpYeiUarD
	 GqR0TvLVtefxn6DHLIAzv72BOvaXa3TF49RyVO3PHv/0uUIGuxrCCkwaT/I48meNZ9Ze6
	 5+3F5LsKH5vLfx1cuXInHVB7QpvTQgKDhGIoeUFzcQ/WXLri/5cNL8idCxEeiLu7vjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4JTUuV1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103A606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4JTUuV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535141F01825;
	Tue, 27 Oct 2026 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121320;
	bh=PCB28u1OajNoRYRYQ8NkMwsOgcifcfI7TvW+XU28YV8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=C4JTUuV1rRkihcIPcnne0EgO/gNx7E8SqjGmV4i7EuDjoO3PBKWg+mxxFQ7i6KDn8
	 yosJ+IPGiAA2IIjKaxfYY0z8UFVKUHgVZ4hE3q8xtLZ58GSSKAiHu4PGcDjeWh4+3t
	 UZ8sbOsBYjgl+glct2+708KgMmb/cGnMI36+JsWX5+xnA58ok0Rqen+09noFHT1bDk
	 NbKweYj3FpnMVXR/ty6BqGWbd65SO3sFPN4/mwhgLnXjF8s9qYbNeg+fUjcGqB872d
	 3XMv2iDy9VYgPZK1oSaMb8Q7EtFkyFm9swCEncPZWZXrJG0WI/XGKLCFUa7QXtiYwZ
	 /djVJd5/w2E6A==
Message-ID: <sashiko-outbox-186978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] libperf evlist: Recompute CPU map when an evsel
 goes system wide
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261027170415.2815859-4-irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
 <20261027170415.2815859-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:15:19 +0000
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
- [Medium] libperf evlist: stale CPUs left in evlist->all_cpus by perf_evli=
st__go_system_wide()
--

commit 03b9925431ed73d3588b37d9c3ef20e7a5b73d9c
Author: Ian Rogers <irogers@google.com>

libperf evlist: Recompute CPU map when an evsel goes system wide

This patch drops the existing evsel->cpus map in
perf_evlist__go_system_wide() before calling __perf_evlist__propagate_maps()
so that an evsel added after map creation gets its PMU's CPUs instead of
retaining the user-requested CPUs.

> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 1f210dadd666f..c48425d4933dc 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -834,7 +834,10 @@ void perf_evlist__go_system_wide(struct perf_evlist =
*evlist, struct perf_evsel *
>  {
>  	if (!evsel->system_wide) {
>  		evsel->system_wide =3D true;
> -		if (evlist->needs_map_propagation)
> +		if (evlist->needs_map_propagation) {
> +			perf_cpu_map__put(evsel->cpus);
> +			evsel->cpus =3D NULL;
>  			__perf_evlist__propagate_maps(evlist, evsel);
> +		}

[Severity: Medium]
Does calling __perf_evlist__propagate_maps() on only this evsel leave stale
CPUs in evlist->all_cpus?

When an evsel is added via perf_evlist__add() after the evlist's maps were
created in per-thread or workload mode, __perf_evlist__propagate_maps() sets
evsel->cpus to the user-requested {-1} map and merges {-1} into
evlist->all_cpus:

tools/lib/perf/evlist.c:__perf_evlist__propagate_maps() {
	...
	perf_cpu_map__merge(&evlist->all_cpus, evsel->cpus);
}

When perf_evlist__go_system_wide() subsequently drops evsel->cpus and calls
__perf_evlist__propagate_maps(evlist, evsel) again, the PMU CPUs are merged
into evlist->all_cpus, but the old -1 entry is never removed. In contrast,
perf_evlist__propagate_maps() clears and rebuilds evlist->all_cpus across a=
ll
evsels:

tools/lib/perf/evlist.c:perf_evlist__propagate_maps() {
	evlist->needs_map_propagation =3D true;

	/* Clear the all_cpus set which will be merged into during propagation. */
	perf_cpu_map__put(evlist->all_cpus);
	evlist->all_cpus =3D NULL;
	...
}

If no remaining evsel in the evlist uses CPU -1 (for instance, this evsel is
the only event, or all other events are system-wide or have requires_cpu se=
t),
evlist->all_cpus retains the stale -1 entry. When perf_evlist__mmap_ops()
runs, perf_cpu_map__has_any_cpu_or_is_empty(cpus) then evaluates to true and
selects mmap_per_thread() instead of mmap_per_cpu():

tools/lib/perf/evlist.c:perf_evlist__mmap_ops() {
	...
	if (perf_cpu_map__has_any_cpu_or_is_empty(cpus))
		return mmap_per_thread(evlist, ops, mp);

	return mmap_per_cpu(evlist, ops, mp);
}

In mmap_per_thread(), cpu_idx 0 (for CPU -1 in evlist->all_cpus) matches no
evsel->cpus, so idx 0 is never mmapped, perf_evlist__set_mmap_first() is
skipped, and nr_mmaps is miscounted.

Should perf_evlist__go_system_wide() call perf_evlist__propagate_maps(evlis=
t)
to rebuild evlist->all_cpus instead of only re-propagating the single evsel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027170415.2815=
859-1-irogers@google.com?part=3D4
