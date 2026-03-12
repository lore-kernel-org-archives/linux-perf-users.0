Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9463FEB17;
	Thu, 12 Mar 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338841; cv=none; b=DrjpPNUbEPNleJm0a8SaIRwRp8Su3JI2PBeO92xH0DXk2GBnS7hcojPQkiLRWYptXNAux8E/QiOuNUL5Ur8WbtPuxD3LWHvhxYnIqSitLf+1cllGrVmz2FbLag3zBQEVbjDTFP72lIMP7kIVDe6aZlZYPLA9vM2ewJlJtobrxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338841; c=relaxed/simple;
	bh=wyNOBHqwBUwItLpJ2BwrL+sv1o2rbPVO9/0lAqCfh04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtZ2VCCBVpgDVAHLIjwc4rZJ3Y/CT8Sdsl4qFu7XLO1RLpfLdFebOI8jZOs1PfK4wolY/WWIlgVkS4DBinfF/ufMT2LhJBTNYNsH1t1hALY5oLp1TLtgZkqai/ZynRfNv4yS/yutHeidEYsy6RaI5B74xnSbw85TfGCk9wDdh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyUDjW8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyUDjW8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9297AC4CEF7;
	Thu, 12 Mar 2026 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773338841;
	bh=wyNOBHqwBUwItLpJ2BwrL+sv1o2rbPVO9/0lAqCfh04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyUDjW8xu/sAV9hL95nAfiG7IhxB0cZO/9mvSvZYmhrg5b8ywrmZs0XllT7+dRUwS
	 cn8wECE3i4ISx/YP96ngyAYzHnQYq0lUhebCifR29ruSEnKW30ekkdKFIMhqyAtZgA
	 DoICOOejcXEeT1A92rBls30/IETU8eO69ENWYuGrLbGgxrsK98oj3ZhtUPj6sRbmK0
	 jAt9gJsrCC2TyeTnkH5FZ9tRtt0+0NY3y21CU1HDTIkXJTMdQ+h2pdPDfzRy0clyox
	 L0EZM2ZyiUggFpiuxVz0bWyd2G+I61rsQPOTWkSPvkWUZYjnl9iDDoT40u2t8AMgP2
	 O2ZmQYctiXjHA==
Date: Thu, 12 Mar 2026 11:07:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Qinxin Xia <xiaqinxin@huawei.com>, irogers@google.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	wangyushan12@huawei.com, hejunhao3@h-partners.com,
	jonathan.cameron@huawei.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	linuxarm@huawei.com
Subject: Re: [PATCH v2 1/1] perf: Add --pmu-filter option for filtering PMUs
Message-ID: <abMA1UTdr7k16_IK@google.com>
References: <20260310040607.1780971-1-xiaqinxin@huawei.com>
 <20260310040607.1780971-2-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310040607.1780971-2-xiaqinxin@huawei.com>

On Tue, Mar 10, 2026 at 12:06:07PM +0800, Qinxin Xia wrote:
> This patch adds a new --pmu-filter option to perf-stat command to allow
> filtering events on specific PMUs. This is useful when there are
> multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cpa0).
> 
> [root@localhost tmp]# perf stat -M cpa_p0_avg_bw
>  Performance counter stats for 'system wide':
> 
>     19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>                  0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
>                  0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
>     19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p0_avg_bw
>                  0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
>                  0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
>     19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p0_avg_bw
>         75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
>         18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
>     19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
>                  0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
>                  0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/
> 
>       19.417734480 seconds time elapsed
> 
> [root@localhost tmp]# perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_p0_avg_bw
>  Performance counter stats for 'system wide':
> 
>      6,234,093,559      cpa_cycles                       #     0.60 cpa_p0_avg_bw
>         50,548,465      cpa_p0_wr_dat
>          7,552,182      cpa_p0_rd_dat_64b
>                  0      cpa_p0_rd_dat_32b
> 
>        6.234139320 seconds time elapsed

Ian, can you please take a look at this?

Thanks,
Namhyung

> 
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  tools/perf/Documentation/perf-stat.txt |  4 ++++
>  tools/perf/builtin-stat.c              | 19 +++++++++++++++++++
>  tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
>  tools/perf/util/parse-events.c         |  2 +-
>  4 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 7cccc3a847d1..b72a29c9223c 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -578,6 +578,10 @@ $ perf config stat.no-csv-summary=true
>  Only enable events on applying cpu with this type for hybrid platform
>  (e.g. core or atom)"
>  
> +--pmu-filter::
> +Only enable events on applying pmu with specified for multiple
> +pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
> +
>  EXAMPLES
>  --------
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 73c2ba7e3076..69c83a5beb71 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1214,6 +1214,21 @@ static int parse_cputype(const struct option *opt,
>  	return 0;
>  }
>  
> +static int parse_pmu_filter(const struct option *opt,
> +			   const char *str,
> +			   int unset __maybe_unused)
> +{
> +	struct evlist *evlist = *(struct evlist **)opt->value;
> +
> +	if (!list_empty(&evlist->core.entries)) {
> +		fprintf(stderr, "Must define pmu-filter before events/metrics\n");
> +		return -1;
> +	}
> +
> +	parse_events_option_args.pmu_filter = str;
> +	return 0;
> +}
> +
>  static int parse_cache_level(const struct option *opt,
>  			     const char *str,
>  			     int unset __maybe_unused)
> @@ -2561,6 +2576,10 @@ int cmd_stat(int argc, const char **argv)
>  			"Only enable events on applying cpu with this type "
>  			"for hybrid platform (e.g. core or atom)",
>  			parse_cputype),
> +		OPT_CALLBACK(0, "pmu-filter", &evsel_list, "pmu",
> +			"Only enable events on applying pmu with specified "
> +			"for multiple pmus with same type(e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)",
> +			parse_pmu_filter),
>  #ifdef HAVE_LIBPFM
>  		OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>  			"libpfm4 event selector. use 'perf list' to list available events",
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 46bf4dfeebc8..89b83ca38483 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
>  				      const char *metric_or_groups)
>  {
>  	const char *pm_pmu = pm->pmu ?: "cpu";
> +	struct perf_pmu *perf_pmu = NULL;
>  
> -	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
> +	if (pm->pmu)
> +		perf_pmu = perf_pmus__find(pm->pmu);
> +
> +	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
> +	   (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
>  		return false;
>  
>  	return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
> @@ -1259,7 +1264,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
>  static int parse_ids(bool metric_no_merge, bool fake_pmu,
>  		     struct expr_parse_ctx *ids, const char *modifier,
>  		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
> -		     struct evlist **out_evlist)
> +		     struct evlist **out_evlist,
> +		     const char *filter_pmu)
>  {
>  	struct parse_events_error parse_error;
>  	struct evlist *parsed_evlist;
> @@ -1313,7 +1319,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>  	}
>  	pr_debug("Parsing metric events '%s'\n", events.buf);
>  	parse_events_error__init(&parse_error);
> -	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
> +	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
>  			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
>  			     /*fake_tp=*/false);
>  	if (ret) {
> @@ -1416,7 +1422,8 @@ static int parse_groups(struct evlist *perf_evlist,
>  					/*modifier=*/NULL,
>  					/*group_events=*/false,
>  					tool_events,
> -					&combined_evlist);
> +					&combined_evlist,
> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>  		}
>  		if (combined)
>  			expr__ctx_free(combined);
> @@ -1471,7 +1478,8 @@ static int parse_groups(struct evlist *perf_evlist,
>  		}
>  		if (!metric_evlist) {
>  			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
> -					m->group_events, tool_events, &m->evlist);
> +					m->group_events, tool_events, &m->evlist,
> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>  			if (ret)
>  				goto out;
>  
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index b9efb296bba5..789ff4d15e47 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -429,7 +429,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
>  	if (parse_state->pmu_filter == NULL)
>  		return false;
>  
> -	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
> +	return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) == 0;
>  }
>  
>  static int parse_events_add_pmu(struct parse_events_state *parse_state,
> -- 
> 2.33.0
> 
