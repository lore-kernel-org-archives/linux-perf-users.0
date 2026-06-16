Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665143E4A1;
	Tue, 16 Jun 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623032; cv=none; b=eSwCiUx7t4nyTeBOcKOhCV0JPsJ8PIJKcok4lx/H3W5638rV97H4FAKlsTeBWkm8NJ9T4Ocmls5tukNiwZSg295f9g6lo2r1frXE7h2nwabnehiCHKsUDeOys39QYw22uq3B5ZpBlz9q4yvZdx/sVBnnfx7Syxhi1fFtoDKrD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623032; c=relaxed/simple;
	bh=ui98S0UqHi7J5WQOJKldjKg+fn5pT+sKF+N+LMR3iF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orHmVCHYVoA8OyhX9staNDhv2ICs09LkD22cqq4RzKIQxOMz7yS5n/feb/B8yyq7SYhvmvXkRtWbGMd8LVKCefVo8Qj0dkxhhjoTP7JvmjFHuLIx1VI+Mb1VkgjzYbQFosXKbvdE3tQnPP86xGejvN8xyNJQzHHTEaS3OC/purI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMGmNCtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMGmNCtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B61F000E9;
	Tue, 16 Jun 2026 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623030;
	bh=trmOiWa9bB86+EhYopYW33obWafDz1c3Y133mQbYMhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iMGmNCtIoQiwGOQsj/GxSMqkSlQspyBjtcisaeZlKv6i0xzyX5a9TMEtFi2tE6s0x
	 7rWCcCMB2EKvt7LngV8jNqwr1a0NwUCoavEJrr74AHwhkEPZ8xcUgpAv4No8plQ8Lb
	 ZRyIzdH91+N7a4Jk/bju6A5uRXLCUv62DMEGjAy3O/HZfLvwkDr5pTccmeWqASv8r+
	 sxv5NiOI62X006Qd2ornAictIR/rg6PlNVYjMUQgmzuhPfKWykkqKvjIvXOmg3LHd+
	 bRbJ7cpn3LYD4Nho9V1t+BkT0w0ILm20y48m9FiuIATjUm+6nXlItqlzNeyS/EWPT/
	 H4/qgDAw1jWiw==
Date: Tue, 16 Jun 2026 12:17:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, thomas.falcon@intel.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v2 01/12] perf parse-events: Restrict core PMU bypass to
 --cputype option
Message-ID: <ajFo85OEFvvFidNi@x1>
References: <20260616012744.4049193-1-irogers@google.com>
 <20260616061404.41929-1-irogers@google.com>
 <20260616061404.41929-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616061404.41929-2-irogers@google.com>

On Mon, Jun 15, 2026 at 11:13:53PM -0700, Ian Rogers wrote:
> Commit b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware
> and cache parsing") introduced a bypass to PMU filtering to prevent uncore PMUs
> from being filtered out during event parsing, which was required for resolving
> `duration_time` and `uncore_freq` when running with `--cputype`. However, this
> bypass was active whenever `pmu_filter` was set, which also incorrectly bypassed
> filtering for the `--pmu-filter` option.
> 
> Introduce a `cputype_filter` boolean flag in `parse_events_state` and
> `parse_events_option_args` to distinguish filtering initiated by `--cputype`
> from that initiated by `--pmu-filter`. Restrict the core-only check in
> `parse_events__filter_pmu()` to when `cputype_filter` is true.
> 
> Fixes: b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware and cache parsing")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c      |  1 +
>  tools/perf/builtin-stat.c        | 12 +++++++-----
>  tools/perf/tests/expand-cgroup.c |  2 +-
>  tools/perf/tests/parse-events.c  | 11 +++++++----
>  tools/perf/tests/parse-metric.c  |  2 +-
>  tools/perf/tests/pmu-events.c    |  8 +++++---
>  tools/perf/util/metricgroup.c    | 23 +++++++++++++++--------
>  tools/perf/util/metricgroup.h    |  4 +++-
>  tools/perf/util/parse-events.c   | 22 ++++++++++++++--------
>  tools/perf/util/parse-events.h   | 17 +++++++++++------
>  tools/perf/util/python.c         |  2 +-
>  11 files changed, 66 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9ac29bdc3cd5..6bd4d8627704 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2174,6 +2174,7 @@ static int script_find_metrics(const struct pmu_metric *pm,
>  	struct evsel *metric_evsel;
>  	int ret = metricgroup__parse_groups(metric_evlist,
>  					/*pmu=*/"all",
> +					/*cputype_filter=*/false,
>  					pm->metric_name,
>  					/*metric_no_group=*/false,
>  					/*metric_no_merge=*/false,
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a04466ea3b0a..2505bc604e53 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1210,6 +1210,7 @@ static int parse_cputype(const struct option *opt,
>  		return -1;
>  	}
>  	parse_events_option_args.pmu_filter = pmu->name;
> +	parse_events_option_args.cputype_filter = true;
>  
>  	return 0;
>  }
> @@ -1226,6 +1227,7 @@ static int parse_pmu_filter(const struct option *opt,
>  	}
>  
>  	parse_events_option_args.pmu_filter = str;
> +	parse_events_option_args.cputype_filter = false;
>  	return 0;
>  }
>  
> @@ -1999,7 +2001,7 @@ static int add_default_events(void)
>  			ret = -1;
>  			goto out;
>  		}
> -		ret = metricgroup__parse_groups(evlist, pmu, "transaction",
> +		ret = metricgroup__parse_groups(evlist, pmu, false, "transaction",
>  						stat_config.metric_no_group,
>  						stat_config.metric_no_merge,
>  						stat_config.metric_no_threshold,
> @@ -2036,7 +2038,7 @@ static int add_default_events(void)
>  		if (!force_metric_only)
>  			stat_config.metric_only = true;
>  
> -		ret = metricgroup__parse_groups(evlist, pmu, "smi",
> +		ret = metricgroup__parse_groups(evlist, pmu, false, "smi",
>  						stat_config.metric_no_group,
>  						stat_config.metric_no_merge,
>  						stat_config.metric_no_threshold,
> @@ -2073,7 +2075,7 @@ static int add_default_events(void)
>  		}
>  		str[8] = stat_config.topdown_level + '0';
>  		if (metricgroup__parse_groups(evlist,
> -						pmu, str,
> +					      pmu, false, str,
>  						/*metric_no_group=*/false,
>  						/*metric_no_merge=*/false,
>  						/*metric_no_threshold=*/true,
> @@ -2112,7 +2114,7 @@ static int add_default_events(void)
>  				ret = -ENOMEM;
>  				break;
>  			}
> -			if (metricgroup__parse_groups(metric_evlist, pmu, default_metricgroup_names[i],
> +			if (metricgroup__parse_groups(metric_evlist, pmu, false, default_metricgroup_names[i],
>  							/*metric_no_group=*/false,
>  							/*metric_no_merge=*/false,
>  							/*metric_no_threshold=*/true,
> @@ -2848,7 +2850,7 @@ int cmd_stat(int argc, const char **argv)
>  	 */
>  	if (metrics) {
>  		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
> -		int ret = metricgroup__parse_groups(evsel_list, pmu, metrics,
> +		int ret = metricgroup__parse_groups(evsel_list, pmu, parse_events_option_args.cputype_filter, metrics,
>  						stat_config.metric_no_group,
>  						stat_config.metric_no_merge,
>  						stat_config.metric_no_threshold,
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index dd547f2f77cc..be6d7feeb38e 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -179,7 +179,7 @@ static int expand_metric_events(void)
>  	TEST_ASSERT_VAL("failed to get evlist", evlist);
>  
>  	pme_test = find_core_metrics_table("testarch", "testcpu");
> -	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str);
> +	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str, false);
>  	if (ret < 0) {
>  		pr_debug("failed to parse '%s' metric\n", metric_str);
>  		goto out;
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 05c3e899b425..2cbe81b9c886 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2556,8 +2556,10 @@ static int test_event(const struct evlist_test *e)
>  		return TEST_FAIL;
>  	}
>  	parse_events_error__init(&err);
> -	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/false,
> -			     /*warn_if_reordered=*/true, /*fake_tp=*/true);
> +	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL,
> +			     /*cputype_filter=*/false, &err, /*fake_pmu=*/false,
> +			     /*warn_if_reordered=*/true,
> +			     /*fake_tp=*/true);
>  	if (ret) {
>  		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
>  		parse_events_error__print(&err, e->name);
> @@ -2584,8 +2586,9 @@ static int test_event_fake_pmu(const char *str)
>  		return -ENOMEM;
>  
>  	parse_events_error__init(&err);
> -	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
> -			     /*fake_pmu=*/true, /*warn_if_reordered=*/true,
> +	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL,
> +			     /*cputype_filter=*/false, &err, /*fake_pmu=*/true,
> +			     /*warn_if_reordered=*/true,
>  			     /*fake_tp=*/true);
>  	if (ret) {
>  		pr_debug("failed to parse event '%s', err %d\n",
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 7c7f489a5eb0..fd9d0cae580e 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -92,7 +92,7 @@ static int __compute_metric(const char *name, struct value *vals,
>  
>  	/* Parse the metric into metric_events list. */
>  	pme_test = find_core_metrics_table("testarch", "testcpu");
> -	err = metricgroup__parse_groups_test(evlist, pme_test, name);
> +	err = metricgroup__parse_groups_test(evlist, pme_test, name, false);
>  	if (err)
>  		goto out;
>  
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index fd5630f0a13c..df8806d8a8fd 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -794,8 +794,10 @@ static int check_parse_id(const char *id, struct parse_events_error *error)
>  	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
>  		*cur = '/';
>  
> -	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, /*fake_pmu=*/true,
> -			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
> +	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL,
> +			     /*cputype_filter=*/false, error, /*fake_pmu=*/true,
> +			     /*warn_if_reordered=*/true,
> +			     /*fake_tp=*/false);
>  	free(dup);
>  
>  	evlist__delete(evlist);
> @@ -871,7 +873,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
>  
>  	perf_evlist__set_maps(&evlist->core, cpus, NULL);
>  
> -	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name);
> +	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name, false);
>  	if (err) {
>  		if (is_expected_broken_metric(pm)) {
>  			(*failures)--;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index c2ce3e53aaee..9c9b04883841 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1262,7 +1262,8 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>  		     struct expr_parse_ctx *ids, const char *modifier,
>  		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
>  		     struct evlist **out_evlist,
> -		     const char *filter_pmu)
> +		     const char *filter_pmu,
> +		     bool cputype_filter)
>  {
>  	struct parse_events_error parse_error;
>  	struct evlist *parsed_evlist;
> @@ -1317,7 +1318,9 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>  	pr_debug("Parsing metric events '%s'\n", events.buf);
>  	parse_events_error__init(&parse_error);
>  	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
> -			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
> +			     cputype_filter,
> +			     &parse_error, fake_pmu,
> +			     /*warn_if_reordered=*/false,
>  			     /*fake_tp=*/false);
>  	if (ret) {
>  		parse_events_error__print(&parse_error, events.buf);
> @@ -1382,7 +1385,7 @@ static struct evsel *pick_display_evsel(struct list_head *metric_list,
>  }
>  
>  static int parse_groups(struct evlist *perf_evlist,
> -			const char *pmu, const char *str,
> +			const char *pmu, bool cputype_filter, const char *str,
>  			bool metric_no_group,
>  			bool metric_no_merge,
>  			bool metric_no_threshold,
> @@ -1420,7 +1423,8 @@ static int parse_groups(struct evlist *perf_evlist,
>  					/*group_events=*/false,
>  					tool_events,
>  					&combined_evlist,
> -					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
> +					cputype_filter);
>  		}
>  		if (combined)
>  			expr__ctx_free(combined);
> @@ -1476,7 +1480,8 @@ static int parse_groups(struct evlist *perf_evlist,
>  		if (!metric_evlist) {
>  			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
>  					m->group_events, tool_events, &m->evlist,
> -					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
> +					cputype_filter);
>  			if (ret)
>  				goto out;
>  
> @@ -1557,6 +1562,7 @@ static int parse_groups(struct evlist *perf_evlist,
>  
>  int metricgroup__parse_groups(struct evlist *perf_evlist,
>  			      const char *pmu,
> +			      bool cputype_filter,
>  			      const char *str,
>  			      bool metric_no_group,
>  			      bool metric_no_merge,
> @@ -1570,16 +1576,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  	if (hardware_aware_grouping)
>  		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
>  
> -	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
> +	return parse_groups(perf_evlist, pmu, cputype_filter, str, metric_no_group, metric_no_merge,
>  			    metric_no_threshold, user_requested_cpu_list, system_wide,
>  			    /*fake_pmu=*/false, table);
>  }
>  
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>  				   const struct pmu_metrics_table *table,
> -				   const char *str)
> +				   const char *str,
> +				   bool cputype_filter)
>  {
> -	return parse_groups(evlist, "all", str,
> +	return parse_groups(evlist, "all", cputype_filter, str,
>  			    /*metric_no_group=*/false,
>  			    /*metric_no_merge=*/false,
>  			    /*metric_no_threshold=*/false,
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 4be6bfc13c46..6a66f14dd01b 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -71,6 +71,7 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>  					 bool create);
>  int metricgroup__parse_groups(struct evlist *perf_evlist,
>  			      const char *pmu,
> +			      bool cputype_filter,
>  			      const char *str,
>  			      bool metric_no_group,
>  			      bool metric_no_merge,
> @@ -80,7 +81,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  			      bool hardware_aware_grouping);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>  				   const struct pmu_metrics_table *table,
> -				   const char *str);
> +				   const char *str,
> +				   bool cputype_filter);
>  
>  int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
>  				 void *data);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 943569e82b82..9f64d5197b8a 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -429,6 +429,9 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
>  	if (parse_state->pmu_filter == NULL)
>  		return false;
>  
> +	if (parse_state->cputype_filter && !pmu->is_core)
> +		return false;
> +
>  	return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) == 0;
>  }
>  
> @@ -2288,18 +2291,20 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  	return (idx_changed || num_leaders != orig_num_leaders) ? 1 : 0;
>  }
>  
> -int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
> +int __parse_events(struct evlist *evlist, const char *str,
> +		   const char *pmu_filter, bool cputype_filter,
>  		   struct parse_events_error *err, bool fake_pmu,
>  		   bool warn_if_reordered, bool fake_tp)
>  {
>  	struct parse_events_state parse_state = {
> -		.list	  = LIST_HEAD_INIT(parse_state.list),
> -		.idx	  = evlist->core.nr_entries,
> -		.error	  = err,
> -		.stoken	  = PE_START_EVENTS,
> +		.list = LIST_HEAD_INIT(parse_state.list),
> +		.idx = evlist->core.nr_entries,
> +		.error = err,
> +		.stoken = PE_START_EVENTS,

Nit: usually we touch unchanged lines to make it align, this time it was
in reverse? Why not keep it aligned? 

>  		.fake_pmu = fake_pmu,
> -		.fake_tp  = fake_tp,
> +		.fake_tp = fake_tp,
>  		.pmu_filter = pmu_filter,
> +		.cputype_filter = cputype_filter,
>  		.match_legacy_cache_terms = true,
>  	};
>  	int ret, ret2;
> @@ -2518,8 +2523,9 @@ int parse_events_option(const struct option *opt, const char *str,
>  	int ret;
>  
>  	parse_events_error__init(&err);
> -	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
> -			     /*fake_pmu=*/false, /*warn_if_reordered=*/true,
> +	ret = __parse_events(*args->evlistp, str, args->pmu_filter,
> +			     args->cputype_filter, &err, /*fake_pmu=*/false,
> +			     /*warn_if_reordered=*/true,
>  			     /*fake_tp=*/false);
>  
>  	if (ret) {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 3577ab213730..b14c832b03a1 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -26,20 +26,23 @@ const char *event_type(size_t type);
>  struct parse_events_option_args {
>  	struct evlist **evlistp;
>  	const char *pmu_filter;
> +	bool cputype_filter;
>  };
>  int parse_events_option(const struct option *opt, const char *str, int unset);
>  int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
> -__attribute__((nonnull(1, 2, 4)))
> -int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
> -		   struct parse_events_error *error, bool fake_pmu,
> -		   bool warn_if_reordered, bool fake_tp);
> +__attribute__((nonnull(1, 2, 5))) int
> +__parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
> +	       bool cputype_filter, struct parse_events_error *error,
> +	       bool fake_pmu, bool warn_if_reordered, bool fake_tp);
>  
>  __attribute__((nonnull(1, 2, 3)))
>  static inline int parse_events(struct evlist *evlist, const char *str,
>  			       struct parse_events_error *err)
>  {
> -	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/false,
> -			      /*warn_if_reordered=*/true, /*fake_tp=*/false);
> +	return __parse_events(evlist, str, /*pmu_filter=*/NULL,
> +			      /*cputype_filter=*/false, err, /*fake_pmu=*/false,
> +			      /*warn_if_reordered=*/true,
> +			      /*fake_tp=*/false);
>  }
>  
>  int parse_event(struct evlist *evlist, const char *str);
> @@ -161,6 +164,8 @@ struct parse_events_state {
>  	bool			   fake_tp;
>  	/* If non-null, when wildcard matching only match the given PMU. */
>  	const char		  *pmu_filter;
> +	/* If true, the pmu_filter was set by --cputype option. */
> +	bool cputype_filter;
>  	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
>  	bool			   match_legacy_cache_terms;
>  	/* Were multiple PMUs scanned to find events? */
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc1019d29a5d..fd9095aa4430 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2104,7 +2104,7 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
>  	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
>  
>  	evlist__init(&evlist, cpus, threads);
> -	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", input,
> +	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", false, input,
>  					/*metric_no_group=*/ false,
>  					/*metric_no_merge=*/ false,
>  					/*metric_no_threshold=*/ true,
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
