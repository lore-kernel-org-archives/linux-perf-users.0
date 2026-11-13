Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603566;
	b=cdepuXLvPTT2Ezd47zoYBRqMGKi0/4mJ4w3aWQ9iOEUZMF4F8Zb0zKxCr77xKl5GdvmG
	 T6qePTInLxlrqD9jUso0oxJxfeIXnwPuRXMAIqu/bW7I9+klQl/t1ss/OjJvjMSIPFUz6
	 EirpC/oLwbP8DKrLljj8vmkR3XBXv+tQaLAtBUVKqCxmEi7KvqT0A6WPJzS/xgqD8f/lI
	 ADDerhx3mvgsXN3CB8rrSNXc2PdhbV/9K1+YW6JpvIxN/Ty6CvMtzNuCNFVpcxUbuTaxm
	 3PLBTRMhD/nG7e/FXq9MzlqTafwaQ7/Zk7ohZWB2sKcLJdSlKmvWJKuO2T2kNZGKjHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UfId8b9KIxm2xUBWjRCiKM1xN/+GzZMrclrPJFLov/s=;
	b=er5i2wDCaAJisOcxjL9DS7DTxnzXW9H4XU7rivRy92bEhMkHzy4Pg9ANZl65lEY9ounj
	 6Yll/9QQoLqgmVkKfQ0lM1EhjndAzR4lLoeCpm9Pq4S3ZV0MSXKnNNTikyQl1l1vMyti+
	 acJMTnwtrrv3GPFiB9tDx0F7U/SmgJDRCD92xzvN3Za8sc/S3AcNns37IYeM98iUdPepT
	 DIcUVR50nqS2xczTopMfCaKMrcK+hvRgyy5At+VokOMMjp48k5Kl9b4jyHwLkDat09dwa
	 E/PMA4+ENcX09GL9BgjVSFgp18Rt/EcIMrQi4JwqwPVaLvolffCgYFPpGiUqsIuGyQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPtbCoVw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BD606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPtbCoVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CEE1F000C4;
	Fri, 13 Nov 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603566;
	bh=UfId8b9KIxm2xUBWjRCiKM1xN/+GzZMrclrPJFLov/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPtbCoVwUUWnsDC8oAipZyB+JZKyUdSSyhhLiJ3uX1IrensaIL7bva2rdVFSpYlpn
	 1reMrOPnRcMmZKdPXRk9tODDfKtzZQnt4nwBIj26bRa88W1btpwMcKGb4ZYJJueMTO
	 07GY2vOuN/6GYt5+qq7DNGVjbN/DeJ2/DF+epHtyOMEBAZ1+tIIHa8FGhtuC4MkNLr
	 zAsBU4jS8rVfoGY1YPwE8EyHNpkf33K1ea2TmA7aP0zQlCl8AP30cIf567PgbDwm7R
	 KyOAtfH8DC6bFATKWVZDpqTFshP60vTLOCbwIE8fu852EOWUe9bnhJdosuNhwuUpjP
	 m2PchJzesY28A==
Message-ID: <sashiko-outbox-213687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/30] perf metricgroup: Share metric events by their
 counter encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-24-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:59:25 +0000
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
- [Medium] perf metricgroup: counter_key__equal() ignores evsel CPU mask
--

commit 0da7bf02bed3bcc6d69ab37b6322595a7c6b2573
Author: Ian Rogers <irogers@google.com>

perf metricgroup: Share metric events by their counter encoding

This commit replaces identifier-name metric event sharing with an evsel
matcher that compares counter encodings, modifiers, and cgroups so metrics
can share equivalent events across expressions and with events already in
the evlist.

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index f25709750c3e1..f4a2b280091cd 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c

[ ... ]

> @@ -471,6 +479,512 @@ int metricgroup__for_each_metric(struct perf_pmus *=
pmus, const struct pmu_metric
>  	return pmu_for_each_sys_metric(metricgroup__sys_event_iter, &sys_data);
>  }
> =20
> +/*
> + * A key identifying the counter an evsel programs, used to find evsels =
counting
> + * the same thing, such as when metrics share events.
> + */
> +struct counter_key {
> +	/** @pmu_name: Name of the evsel's PMU, or NULL if unknown. */
> +	const char *pmu_name;
> +	/** @cgrp: The cgroup the evsel counts. */
> +	const struct cgroup *cgrp;

[ ... ]

> +static void evsel_matcher__key(struct evsel_matcher *matcher, struct evs=
el *evsel,
> +			       struct counter_key *key)
> +{
> +	struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> +
> +	counter_key__init_attr(key, pmu ? pmu->name : NULL, &evsel->core.attr);
> +	key->cgrp =3D evsel->cgrp;
> +	if (evsel->percore)
> +		key->modifiers |=3D COUNTER_KEY_MOD_PERCORE;
> +	if (evsel__is_retire_lat(evsel))
> +		key->modifiers |=3D COUNTER_KEY_MOD_RETIRE_LAT;
> +	if (evsel->precise_max)
> +		key->modifiers |=3D COUNTER_KEY_MOD_PRECISE_MAX;
> +	if (evsel->bpf_counter)
> +		key->modifiers |=3D COUNTER_KEY_MOD_BPF;
> +	if (key->type =3D=3D PERF_TYPE_HARDWARE && pmu && pmu->is_core)
> +		legacy_hw_key(matcher, pmu->name, key->config, key);
> +}
> +
> +/* Do @a and @b count the same thing? */
> +static bool counter_key__equal(const struct counter_key *a, const struct=
 counter_key *b)
> +{
> +	if (a->type !=3D b->type || a->config !=3D b->config ||
> +	    a->config1 !=3D b->config1 || a->config2 !=3D b->config2 ||
> +	    a->config3 !=3D b->config3 || a->config4 !=3D b->config4)
> +		return false;
> +
> +	if ((a->type =3D=3D PERF_TYPE_RAW || a->type >=3D PERF_TYPE_MAX) &&
> +	    !a->pmu_name !=3D !b->pmu_name)
> +		return false;
> +
> +	if (a->pmu_name && b->pmu_name && strcmp(a->pmu_name, b->pmu_name))
> +		return false;
> +
> +	return a->exclude =3D=3D b->exclude && a->modifiers =3D=3D b->modifiers=
 &&
> +	       a->precise_ip =3D=3D b->precise_ip && a->cgrp =3D=3D b->cgrp;
> +}

[Severity: Medium]
Should counter_key also compare evsel->core.cpus (for example with
perf_cpu_map__equal())?

On Intel hybrid platforms, JSON metrics specify per-PMU CPU restrictions
on shared PMUs, such as msr/tsc,cpu=3Dcpu_core/, msr/tsc,cpu=3Dcpu_atom/, a=
nd
unrestricted msr/tsc/.  Because parse_events_add_pmu() stores the cpu=3D
term in evsel->core.cpus without changing perf_event_attr or pmu_name,
counter_key__equal() treats these events as identical and
metric__adopt_events() merges them into whichever evsel was added first,
causing the second metric to read counts from the wrong CPU subset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D23
