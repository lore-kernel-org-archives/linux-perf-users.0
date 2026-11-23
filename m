Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419401;
	b=rrnZqIOv6+4GZuKy5J/XaQYijGWLMixEZ4Zjegmixo/2MiRhJN9sz2rxQyBmsEFXf87/
	 TmU4k7q5GbEpN829aq7toORo6GEMi5uqjWKIWQgGiSgq2Tf53A88dnSj+IAALtqKnDgBz
	 ALhuQSA2KNfwbrOrqWirMYiElOjQ1lrYzsvczgXn+NA5+rTHID1OUSYgiy1fSuS6vp9aY
	 nEpG/OXd2ffG5nCivNc3NcubzTeStKXb3C/K1G5VQzSztEOx3sIeNYn6UGXB2RJz3XhLQ
	 XbKi0bTMt64ge5SwNd7qECLndCTlD90LsKX78SmBHnhX465aKq2Bdi6qwaINU4ASoPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419401;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sq9I9+N+bkHjCRmzgeTj6YsCm/t37OQzQV1O01m7c4A=;
	b=LbeCs9k3Ky+ENwwXPygJ/vWvUsdoRetl39qZvoO0ptEgAXVl44iiydDp7jQdzv65CpXf
	 Jutas+jfDDtr+OIxB0bIUOhW2ELnHfevs484sfu4atugvcJwAATlDKu+94Gj/hyRw5K/b
	 SKeFQNm3JGd5LBsGYaxxXWLyqwK6ZPmNbElkCnlAJHk8Vb3UJ/JKJMoTcpebCyhAY2hLk
	 avPdxtcVb3dQqxYGLtW3z09P95AMm6Be3vY9Ee2pAVK+hPlaHq7mo60zn74i+zj5Ja6VL
	 Ix16z7JjR+R7Y2cz+VRaogWKoGP8/TnUrevQca4rk5xFfpgruZm1wxK2cFnVLTYM3hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ip/79lY2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B716606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ip/79lY2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AF41F000C6;
	Mon, 23 Nov 2026 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795419400;
	bh=Sq9I9+N+bkHjCRmzgeTj6YsCm/t37OQzQV1O01m7c4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ip/79lY2081u6uBM4iK9bcJxg/5I4Od6gLrJexEyzcoIb007tSqj4TXEBM/YhaqUi
	 qBpYC8Cvi/gGHDo7spR6FEVoWChBXIxv3CtyGFZkCOxUCBTP+0xJf4gCeR6xwWdLdJ
	 /xaNyrn+FAczwEC4oEfXuBXqMHW1gSENBESTJvTHImcaN+xgG8/TqsTtmsfofqiqYw
	 OYjcpaCjo86nq/Hwx2IuEeiutiZnOIvjqGuZpv8t6tQzZYVPTtEANKMBWiL9DxJv96
	 juZ6y4kxc/exT3qod2hJb4V7ELpsjQ4hKcUlzpVOqcjfBAtnRStW6WECMSwfCjsD2t
	 tv2WaMERV4usA==
Message-ID: <sashiko-outbox-228822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/13] perf bpf-filter: Copy bpf_filters in
 evsel__clone() and close on evsel__close()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123071913.653315-12-irogers@google.com>
References: <20261123071913.653315-1-irogers@google.com>
 <20261123071913.653315-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:36:40 +0000
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
- [Medium] perf bpf-filter: evsel->bpf_skel leak when
  bpf_program_profiler_ops is active
--

commit d719c3b8be630c9ad40c9c5d575ea564cff11cd7
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Copy bpf_filters in evsel__clone() and close on evsel__clo=
se()

This commit adds perf_bpf_filter__copy() to duplicate BPF filter expressions
during evsel__clone(), and introduces perf_bpf_filter__close() to tear down
BPF skeleton and pinned filter state when closing an evsel or evlist.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 638d501a75316..5bcb5d0905ea7 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1708,6 +1708,8 @@ void evlist__close(struct evlist *evlist)
>  	}
> =20
>  	evlist__for_each_entry_reverse(evlist, evsel) {
> +		if (!evsel__is_bpf(evsel))
> +			perf_bpf_filter__close(evsel);
>  		perf_evsel__free_fd(&evsel->core);
>  		perf_evsel__free_id(&evsel->core);
>  	}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 64a9318554ee7..e7ceeb46e06c6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -3261,6 +3263,8 @@ void evsel__close(struct evsel *evsel)
>  {
>  	if (evsel__is_retire_lat(evsel))
>  		evsel__tpebs_close(evsel);
> +	if (!evsel__is_bpf(evsel))
> +		perf_bpf_filter__close(evsel);
>  	perf_evsel__close(&evsel->core);
>  	perf_evsel__free_id(&evsel->core);
>  }

[Severity: Medium]
Should these checks in evlist__close() and evsel__close() test
!evsel__is_bperf(evsel) instead of !evsel__is_bpf(evsel) so that
evsel->bpf_skel is not leaked when profiling a BPF program?

Only bperf shares the evsel->bpf_skel union member with leader_skel and
follower_skel.  When perf stat runs with both -b and --filter,
bpf_counter__load() sets evsel->bpf_counter_ops to
&bpf_program_profiler_ops (with a non-empty evsel->bpf_counter_list, so
evsel__is_bperf(evsel) is false while evsel__is_bpf(evsel) is true) and
perf_bpf_filter__prepare() populates evsel->bpf_skel (or pinned_filters).

Because evsel__is_bpf(evsel) is true, evlist__close() and evsel__close()
skip perf_bpf_filter__close(evsel).  This leaks the sample_filter_bpf
skeleton or pinned_filter_idx entries across repeat runs (perf stat -r),
and at final teardown in evsel__exit(), bpf_counter__destroy() sets
evsel->bpf_skel =3D NULL before perf_bpf_filter__destroy() runs, leaking
the sample_filter_bpf skeleton on single runs as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123071913.6533=
15-1-irogers@google.com?part=3D11
