Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763969;
	b=tniREitIXB5sZY1B5J9gzCd+nfeN6vD6luS5xcxFxLcCn+P6Gl8JQ1wZ1o4hndFSgMp9
	 yErOHEAb6b73nylc6RWGtnVqAbT7JmFEKagEPg1sifWQP0RYNt5LoZhoKAQtKZTNPTnS2
	 HQzd+Sowd/D9FPXecMmyF2gmCNGVLRTjoQeNYxWFNdzXTy2c48neFlLHjCx1ERp9XWELn
	 /Xye7cUo80CEGlgc8S2TZVl3Cp2PIqS3TnVlBiaOlkJYHk7JRIK1Q6CHyeYViUk0mi6dg
	 ePB0HUACWzw17zRzO1W49GiOYCkj6eY599x542V+tA2Y0fHHz3BAdpHjc6vsrs2PU+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cd0615ZcJzOUwmOSyBuJVIv1mKpmKHtryRIlmOuV6JE=;
	b=oYM0lvx4fP/dYRGKX/xxDAtpQDdnOh3zo1mcPSOFig1X8Ry3p+Jd9yjjcq0bVbGgxzZY
	 E8l+68mYEgw/UmjvfJ7CPcclJ/0GxllCA2vKjX2yuqWqKA2TGFSoRYkkhT+TRLUotYFyD
	 F705njb9kqjVvNnDpTngCt7yUzr6FXSio8Ht9lSvwr5kJg1PCyotayxxC1pY2atcM2jEC
	 IUnH/Im8GXCrbWyD4SY6p/a/ymW+HsANV+h8Q9POSPlKD01FAGBXTdhBOw5YNXnQQPUvR
	 4ThFfNfsqmYxMj/IvH64J/Q+2S+qJH1GErMvuGz5jEeLaOAPDjxwVnmhSZUSC5XIgVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cH0nAMtl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6E606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cH0nAMtl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7BB1F000C1;
	Wed,  4 Nov 2026 03:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763968;
	bh=Cd0615ZcJzOUwmOSyBuJVIv1mKpmKHtryRIlmOuV6JE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cH0nAMtlX8/btNSuf+KThKLesRaLz/eghoCXpusVrtnkCTlRsPkQWndC/x/Z8TsfT
	 nxLoMUZcqbrDzhixZ3t59GAaCrIV58cYa4oAN7xyeub2cQAIAJ9w54LpjQspVOrrzr
	 /I3QHUHGH4AZrsmfyuhlU5U6IAhaKiTU+2YLefZ4hk6bJFpqCcVtrBwHuqYfNnBk8D
	 zPxvjpCMiVBZGVv+uBbUQuJd4MO5QXkfwYLLej9SIVxrklYCqvsdp4RY+Kuwox1RVN
	 zYUw1PhpExv7i2JApGM5HRnbfF8RB60qYksS7RrnZ6lJrqS/dQIgwghNWiJDlgui04
	 hNjMWizxcu2/g==
Message-ID: <sashiko-outbox-196634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 19/41] perf metricgroup: Improve matching of metrics
 to recorded events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-20-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:46:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf metricgroup: duplicate data_evsel in metric_expr__dup_for_d=
ata()
- [Medium] perf metricgroup: metric_no_group=3Dtrue inverts group score in =
matching
- [Medium] perf metricgroup: all-PMU check and partial mutation break PMU m=
atching
- [Medium] perf metricgroup: wildcard PMU match in counter_key__equal() whe=
n pmu is NULL
--

commit 0dda1611167f07ce9d5277e31daf8894a0250f02
Author: Ian Rogers <irogers@google.com>

perf metricgroup: Improve matching of metrics to recorded events

This commit improves how metrics are matched to recorded events in perf.data
by comparing events using a counter key (PMU name, counter encoding, and
exclude modifiers), converting legacy hardware events to sysfs encodings,
duplicating metric expressions per PMU, and scoring candidate events.

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index e87da791fd1e4..90d22c67bfaeb 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c

[ ... ]

> @@ -471,151 +483,581 @@ int metricgroup__for_each_metric(struct perf_pmus=
 *pmus, const struct pmu_metric
> +static void counter_key__init_attr(struct counter_key *key, const char *=
pmu_name,
> +				   const struct perf_event_attr *attr)
> +{
> +	key->pmu_name =3D pmu_name;
> +	key->type =3D attr->type;
> +	key->config =3D attr->config;
> +	key->config1 =3D attr->config1;
> +	key->config2 =3D attr->config2;
> +	key->exclude =3D (attr->exclude_user ? COUNTER_KEY_EXCLUDE_USER : 0) |
> +		       (attr->exclude_kernel ? COUNTER_KEY_EXCLUDE_KERNEL : 0) |
> +		       (attr->exclude_hv ? COUNTER_KEY_EXCLUDE_HV : 0) |
> +		       (attr->exclude_host ? COUNTER_KEY_EXCLUDE_HOST : 0) |
> +		       (attr->exclude_guest ? COUNTER_KEY_EXCLUDE_GUEST : 0);
> +	if (attr->type =3D=3D PERF_TYPE_HARDWARE || attr->type =3D=3D PERF_TYPE=
_HW_CACHE)
> +		key->config &=3D PERF_HW_EVENT_MASK;
> +	else if (attr->type >=3D PERF_TYPE_MAX)
> +		key->type =3D PERF_TYPE_RAW;
> +}

[ ... ]

> +static bool counter_key__equal(const struct counter_key *a, const struct=
 counter_key *b)
> +{

[ ... ]

> +	if (a->pmu_name && b->pmu_name)
> +		return !strcmp(a->pmu_name, b->pmu_name);
> +
> +	return true;
> +}

[Severity: Medium]
Can an unresolved dynamic PMU or tool PMU event act as a wildcard that
matches metric events from any PMU with the same config values?

When evsel__find_pmu(data_evsel) returns NULL for a recorded event with
attr.type >=3D PERF_TYPE_MAX (such as PERF_PMU_TYPE_TOOL or a dynamic PMU t=
ype
when HEADER_PMU_MAPPINGS in perf.data is absent or incomplete while
env->pmus.read_pmu_types =3D=3D PERF_TOOL_PMU_TYPE_ALL_MASK),
counter_key__init_attr() sets key->pmu_name =3D NULL and overwrites key->ty=
pe
with PERF_TYPE_RAW.

When counter_key__equal() then compares this recorded event against a parsed
metric event from any PMU (which also has key->type =3D=3D PERF_TYPE_RAW an=
d a
non-NULL pmu_name), the pmu_name comparison is skipped because one pmu_name
is NULL, returning true whenever config, config1, and config2 happen to mat=
ch.

[ ... ]

> +static struct evsel *map_metric_evsel_to_evlist(struct find_matching_met=
rics_args *args,
>  						struct evsel *metric_evsel)
>  {
> -	struct evsel *data_evsel;
> +	struct evsel *data_evsel, *best =3D NULL;
> +	struct counter_key metric_key;
> +	bool metric_grouped =3D evsel__leader(metric_evsel)->core.nr_members > =
1;
> +	int best_score =3D -1;
> +
> +	evsel__counter_key(args, metric_evsel, &metric_key);
> +	evlist__for_each_entry(args->evlist, data_evsel) {
> +		bool data_grouped;
> +		int score;
> =20
> -	evlist__for_each_entry(data_evlist, data_evsel) {
> -		/* Skip if perf_event_attr differ. */
> -		if (metric_evsel->core.attr.type !=3D data_evsel->core.attr.type)
> +		if (!data_evsel->supported)
>  			continue;
> -		if (metric_evsel->core.attr.config !=3D data_evsel->core.attr.config)
> +
> +		/* Skip if the evsels don't program the same counter. */
> +		if (data_evsel->core.idx >=3D args->nr_keys ||
> +		    !counter_key__equal(&metric_key, &args->keys[data_evsel->core.idx]=
))
>  			continue;
> -		return data_evsel;
> +
> +		data_grouped =3D evsel__leader(data_evsel)->core.nr_members > 1 ||
> +			       (data_evsel->core.attr.read_format & PERF_FORMAT_GROUP);
> +		score =3D (!strcmp(evsel__name(metric_evsel), evsel__name(data_evsel))=
 ? 16 : 0) +
> +			(metric_key.exclude =3D=3D args->keys[data_evsel->core.idx].exclude ?=
 8 : 0) +
> +			evsel__count_score(data_evsel) * 2 +
> +			(metric_grouped =3D=3D data_grouped ? 1 : 0);
> +		if (score > best_score) {
> +			best =3D data_evsel;
> +			best_score =3D score;
> +		}
>  	}
> +	return best;
> +}

[Severity: Medium]
Does passing metric_no_group =3D true in find_matching_metrics_cb() invert =
the
(metric_grouped =3D=3D data_grouped) scoring heuristic here?

In find_matching_metrics_cb(), metricgroup__parse_groups() is called with
metric_no_group set to true, which causes metric__new() to set
m->group_events =3D false. As a result, the parsed metric_evsel entries in
metric_evlist are not placed in groups, so core.nr_members is 1 and
metric_grouped evaluates to false.

When map_metric_evsel_to_evlist() then scores candidate events,
(metric_grouped =3D=3D data_grouped ? 1 : 0) evaluates to (!data_grouped ? =
1 : 0),
which penalizes grouped data_evsel entries and favors ungrouped ones even f=
or
metrics that normally group their events when recorded.

[ ... ]

> +static struct metric_expr *metric_expr__dup_for_data(struct find_matchin=
g_metrics_args *args,
> +						     struct evlist *metric_evlist,
> +						     const struct metric_expr *expr,
> +						     const struct perf_pmu *pmu)
> +{

[ ... ]

> +	while (expr->metric_events[nr])
> +		nr++;
> +	copy->metric_events =3D calloc(nr + 1, sizeof(*copy->metric_events));
> +	if (!copy->metric_events)
> +		goto err;
> +
> +	for (int i =3D 0; i < nr; i++) {
> +		struct evsel *ev =3D metric_evsel_on_pmu(metric_evlist, expr->metric_e=
vents[i], pmu);
> +
> +		if (!ev)
> +			goto err;
> +		copy->metric_events[i] =3D map_metric_evsel_to_evlist(args, ev);
> +		if (!copy->metric_events[i])
> +			goto err;
> +		if (evsel__copy_metric_ids(copy->metric_events[i], expr->metric_events=
[i]))
> +			goto err;
> +		/*
> +		 * As in setup_metric_events(), a matched event without a metric
> +		 * leader leads itself so that evsel__source_count() counts it.
> +		 */
> +		if (!copy->metric_events[i]->metric_leader)
> +			copy->metric_events[i]->metric_leader =3D copy->metric_events[i];
> +	}
> +	return copy;
> +err:
> +	metric_expr__delete(copy);
>  	return NULL;
>  }

[Severity: Medium]
What happens when two entries in expr->metric_events[] map to the same
recorded data_evsel in copy->metric_events[]?

For example, in tma_info_system_mux
(cpu_core@CPU_CLK_UNHALTED.THREAD_P@ / cpu_core@CPU_CLK_UNHALTED.THREAD@),
or when a metric references both an unqualified event and a :u event while
the recorded event had exclude_kernel/exclude_hv set by evsel__fallback(),
multiple expr->metric_events[i] resolve to the same data_evsel.

Because copy->metric_events[] is not deduplicated while all metric_ids are
copied onto that shared data_evsel via evsel__copy_metric_ids(),
prepare_metric() in tools/perf/util/stat-shadow.c visits the same data_evsel
multiple times:

tools/perf/util/stat-shadow.c:prepare_metric() {
    ...
		args.val =3D val;
		args.source_count =3D source_count;
		args.aggr_nr =3D aggr_nr;
		ret =3D evsel__for_each_metric_id(metric_events[i], add_metric_id_val_cb,=
 &args);
    ...
}

On each repeat visit, expr__add_id_val_source_count_aggr_nr() finds old_data
for every metric_id on that data_evsel and accumulates val, source_count, a=
nd
aggr_nr again:

tools/perf/util/expr.c:expr__add_id_val_source_count_aggr_nr() {
    ...
	} else if (old_data) {
		data_ptr->val.val +=3D old_data->val.val;
		data_ptr->val.source_count +=3D old_data->val.source_count;
		data_ptr->val.aggr_nr +=3D old_data->val.aggr_nr;
	}
    ...
}

Won't this multiply the event counts, source_count, and aggr_nr by the numb=
er
of times data_evsel appears in copy->metric_events[], as well as match
multi-counter comparison metrics against a single recorded counter?

[ ... ]

> @@ -523,99 +965,97 @@ static int find_matching_metrics_cb(const struct pm=
u_metric *pm,
>  				    const struct pmu_metrics_table *table __maybe_unused,
>  				    void *data)
>  {
>  	struct find_matching_metrics_args *args =3D data;
> -	struct evlist *data_evlist =3D args->evlist;
>  	struct evlist *metric_evlist =3D evlist__new();
>  	struct evsel *metric_evsel;
> -	int ret =3D metricgroup__parse_groups(metric_evlist,
> +	int ret;
> +
> +	if (!metric_evlist)
> +		return -ENOMEM;
> +
> +	evlist__set_session(metric_evlist, evlist__session(args->evlist));
> +	/*
> +	 * Event grouping doesn't affect the matching and avoids warnings about
> +	 * grouping constraints.
> +	 */
> +	ret =3D metricgroup__parse_groups(metric_evlist,
>  					/*pmu=3D*/"all",
>  					/*cputype_filter=3D*/false,
>  					pm->metric_name,
> -					/*metric_no_group=3D*/false,
> +					/*metric_no_group=3D*/true,
>  					/*metric_no_merge=3D*/false,
>  					/*metric_no_threshold=3D*/true,
>  					/*user_requested_cpu_list=3D*/NULL,
>  					args->system_wide,
>  					/*hardware_aware_grouping=3D*/false);
> -
>  	if (ret) {
>  		/* Metric parsing failed but continue the search. */
> +		ret =3D 0;
>  		goto out;
>  	}
> =20
> -	/*
> -	 * Check the data_evlist has an entry for each metric_evlist entry. If
> -	 * the data evsel was already set up avoid changing data that may
> -	 * break it.
> -	 */
> +	/* Check the data_evlist has an entry for each metric_evlist entry. */
>  	evlist__for_each_entry(metric_evlist, metric_evsel) {
> -		struct evsel *data_evsel =3D
> -			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
> -		struct evsel *new_metric_leader;
> -
> -		if (!data_evsel) {
> +		if (!map_metric_evsel_to_evlist(args, metric_evsel)) {
>  			pr_debug("Skipping metric '%s' as evsel '%s' is missing\n",
> -				pm->metric_name, evsel__name(metric_evsel));
> -			goto out;
> -		}
> -
> -		if (data_evsel->metric_leader =3D=3D NULL)
> -			continue;
> -
> -		if (metric_evsel->metric_leader =3D=3D metric_evsel) {
> -			new_metric_leader =3D data_evsel;
> -		} else {
> -			new_metric_leader =3D
> -				map_metric_evsel_to_evlist(data_evlist,
> -								 metric_evsel->metric_leader);
> -		}
> -		/* Mismatching evsel leaders. */
> -		if (data_evsel->metric_leader !=3D new_metric_leader) {
> -			pr_debug("Skipping metric '%s' due to mismatching evsel metric leader=
s '%s' vs '%s'\n",
> -				pm->metric_name, evsel__name(metric_evsel),
> -				evsel__name(data_evsel));
> +				 pm->metric_name, evsel__name(metric_evsel));
>  			goto out;
>  		}
>  	}
> -	/*
> -	 * Metric events match those in the data evlist, copy metric evsel
> -	 * data into the data evlist.
> -	 */
> -	evlist__for_each_entry(metric_evlist, metric_evsel) {
> -		struct evsel *data_evsel =3D
> -			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
> -		struct metric_event *metric_me =3D
> -			metricgroup__lookup(evlist__metric_events(metric_evlist),
> -					    metric_evsel,
> -					    /*create=3D*/false);
> =20
> -		if (evsel__copy_metric_ids(data_evsel, metric_evsel))
> -			goto out;
> +	ret =3D add_matching_metric_evlist(args, metric_evlist,
> +					 /*default_metricgroup=3D*/false);

[Severity: Medium]
On a hybrid or multi-PMU system where events were recorded on only one PMU
(for example, only cpu_core on Alder Lake), won't this check skip valid
per-PMU metrics?

Because metricgroup__parse_groups() is called with pmu set to "all" rather
than pm->pmu, default_core metrics (like insn_per_cycle) and metrics sharing
the same name across PMUs (like tma_retiring) expand into evsels for both
cpu_core and cpu_atom in metric_evlist. Requiring every metric_evsel in
metric_evlist to match before calling add_matching_metric_evlist() causes t=
he
entire metric to be skipped when cpu_atom events were not recorded, even
though all cpu_core events for the metric are present.

Also, in metric_expr__dup_for_data(), evsel__copy_metric_ids() and
copy->metric_events[i]->metric_leader are updated inside the loop before
verifying that all nr events in the expression resolve on pmu and match in
args->evlist. If an earlier event in the expression matches and a later eve=
nt
fails (taking goto err), won't the earlier matched data_evsel be left with
partially mutated metric_ids and metric_leader?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D19
