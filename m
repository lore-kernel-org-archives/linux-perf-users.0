Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB153148C9;
	Fri, 25 Sep 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333610; cv=none; b=c88ZMKVBnJwZGtpyoCorPKyCf0/KRSuaqoWidvSKTWV8uxAaP0wvtdovdDkNgygnL56zFKwDlPFbKDAVur4U/H49dUXTYyAIFlV/2/i7WtG6wbIguRKG1eF0YWVwFhzo4Xu20tSkyBCzaIjPUJ4p9kHrbcP51Eg7qEFariw0c9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333610; c=relaxed/simple;
	bh=74M8WMfSK3tXPdmAwZp5Fjj2BU8muBNPryU5DHx+BhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnGwHISXfLtSgxM3twNOebO28Ox64YEyazmZ+I3cFq0kQgJ8GPSwT9zXe4BiQaqFiwbNv1ZWbFZf/r909AKubDeztr5HBkI7LA/cwZt09EPOcyDnIlHAN7fgMFSxjF/8MXHYN12gbKvVkKw9W4SkhxDVWGh0Jk+gCiwjeOnV0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii3M8jd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii3M8jd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DB41F00893;
	Fri, 25 Sep 2026 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333608;
	bh=Kqd4k3+YghzJLEW4DKMD6Gk6e5UXEXrK9UZa6/7H/M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ii3M8jd+fOFo0PTByllXH6G5V0OkmPJqMXBiru/7rEcg0bRBm+pY051LPW9KvEnIO
	 HviGNO81m3+zmPOvT2q9y2ty1Rsv+2lr8tiLvGlfluvlHm0xZRXwXWmbaoj1/j9NJT
	 GkqzABIhckvD0YDWkgR8DhzdlWTzsSzVsSJD2wKAHPOAchck5VDUVJLSudrWigzVGW
	 5s57YIqFLhhnAhDKwWsKG5RRIA/9elQNro/+kV3cKyxXNMD7nYIqDn6iflc3/byx1i
	 82WMnrSXFIyRDLXN/3BXupA1NjqE4x0Cu6ssqxBM/U+Qwg4ZGqigwcMy/CBjopSbY1
	 ErF8LxrPh8QwQ==
Date: Fri, 25 Sep 2026 12:53:25 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Qinxin Xia <xiaqinxin@huawei.com>, Yu Peng <pengyu@kylinos.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Fix PMU metric parsing tests for unknown
 literals
Message-ID: <arZSpXYtyUW_UhDr@x2>
References: <20260923224106.3268925-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923224106.3268925-1-irogers@google.com>

On Wed, Sep 23, 2026 at 03:41:06PM -0700, Ian Rogers wrote:
> On ARM the #slots literal may or may not be present, it won't be
> present on x86. As it is missing it causes the ampereone and
> ampereonex PMU metric tests to fail when run say on x86. Extend the
> fake_pmu logic so that in these test cases we fake the unknown
> literals like #slots as 1.0. When building with JEVENTS_ARCH=all the
> ampere metric tests no longer fail.
 
> Signed-off-by: Ian Rogers <irogers@google.com>



Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo

> ---
>  tools/perf/util/expr.c        |  5 ++++-
>  tools/perf/util/metricgroup.c | 37 ++++++++++++++++++++++++-----------
>  2 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 8aef3c7418f7..f1164c4666b1 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -431,7 +431,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>  	}
>  
>  	pr_debug2("literal: %s = %f\n", literal, result);
> -	return result;
> +	if (!ctx->is_test)
> +		return result;
> +	else
> +		return isnan(result) ? 1.0 : result;
>  }
>  
>  /* Does the event 'id' parse? Determine via ctx->ids if possible. */
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 5a60cb95e31c..779fe56fe8d0 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -224,7 +224,8 @@ static struct metric *metric__new(const struct pmu_metric *pm,
>  				  bool metric_no_threshold,
>  				  int runtime,
>  				  const char *user_requested_cpu_list,
> -				  bool system_wide)
> +				  bool system_wide,
> +				  bool fake_pmu)
>  {
>  	struct metric *m;
>  
> @@ -256,6 +257,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
>  	}
>  	m->pctx->sctx.runtime = runtime;
>  	m->pctx->sctx.system_wide = system_wide;
> +	m->pctx->sctx.is_test = fake_pmu;
>  	m->group_events = !metric_no_group && metric__group_events(pm, metric_no_threshold);
>  	m->default_show_events = pm->default_show_events;
>  	m->metric_refs = NULL;
> @@ -699,6 +701,7 @@ static int add_metric(struct list_head *metric_list,
>  		      bool metric_no_threshold,
>  		      const char *user_requested_cpu_list,
>  		      bool system_wide,
> +		      bool fake_pmu,
>  		      struct metric *root_metric,
>  		      const struct visited_metric *visited,
>  		      const struct pmu_metrics_table *table);
> @@ -724,6 +727,7 @@ static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
>   *                   user may override.
>   * @user_requested_cpu_list: Command line specified CPUs to record on.
>   * @system_wide: Are events for all processes recorded.
> + * @fake_pmu: Are PMUs and events being faked for testing?
>   * @root_metric: Metrics may reference other metrics to form a tree. In this
>   *               case the root_metric holds all the IDs and a list of referenced
>   *               metrics. When adding a root this argument is NULL.
> @@ -739,6 +743,7 @@ static int resolve_metric(struct list_head *metric_list,
>  			  bool metric_no_threshold,
>  			  const char *user_requested_cpu_list,
>  			  bool system_wide,
> +			  bool fake_pmu,
>  			  struct metric *root_metric,
>  			  const struct visited_metric *visited,
>  			  const struct pmu_metrics_table *table)
> @@ -788,7 +793,7 @@ static int resolve_metric(struct list_head *metric_list,
>  	for (i = 0; i < pending_cnt; i++) {
>  		ret = add_metric(metric_list, &pending[i].pm, modifier, metric_no_group,
>  				 metric_no_threshold, user_requested_cpu_list, system_wide,
> -				 root_metric, visited, table);
> +				 fake_pmu, root_metric, visited, table);
>  		if (ret)
>  			break;
>  	}
> @@ -809,6 +814,7 @@ static int resolve_metric(struct list_head *metric_list,
>   * @runtime: A special argument for the parser only known at runtime.
>   * @user_requested_cpu_list: Command line specified CPUs to record on.
>   * @system_wide: Are events for all processes recorded.
> + * @fake_pmu: Are PMUs and events being faked for testing?
>   * @root_metric: Metrics may reference other metrics to form a tree. In this
>   *               case the root_metric holds all the IDs and a list of referenced
>   *               metrics. When adding a root this argument is NULL.
> @@ -825,6 +831,7 @@ static int __add_metric(struct list_head *metric_list,
>  			int runtime,
>  			const char *user_requested_cpu_list,
>  			bool system_wide,
> +			bool fake_pmu,
>  			struct metric *root_metric,
>  			const struct visited_metric *visited,
>  			const struct pmu_metrics_table *table)
> @@ -851,7 +858,7 @@ static int __add_metric(struct list_head *metric_list,
>  		 * metrics that are added recursively.
>  		 */
>  		root_metric = metric__new(pm, modifier, metric_no_group, metric_no_threshold,
> -					  runtime, user_requested_cpu_list, system_wide);
> +					  runtime, user_requested_cpu_list, system_wide, fake_pmu);
>  		if (!root_metric)
>  			return -ENOMEM;
>  
> @@ -924,7 +931,7 @@ static int __add_metric(struct list_head *metric_list,
>  
>  		ret = resolve_metric(metric_list, pmu, modifier, metric_no_group,
>  				     metric_no_threshold, user_requested_cpu_list,
> -				     system_wide, root_metric, &visited_node,
> +				     system_wide, fake_pmu, root_metric, &visited_node,
>  				     table);
>  	}
>  	if (ret) {
> @@ -944,6 +951,7 @@ static int add_metric(struct list_head *metric_list,
>  		      bool metric_no_threshold,
>  		      const char *user_requested_cpu_list,
>  		      bool system_wide,
> +		      bool fake_pmu,
>  		      struct metric *root_metric,
>  		      const struct visited_metric *visited,
>  		      const struct pmu_metrics_table *table)
> @@ -955,7 +963,7 @@ static int add_metric(struct list_head *metric_list,
>  	if (!strstr(pm->metric_expr, "?")) {
>  		ret = __add_metric(metric_list, pm, modifier, metric_no_group,
>  				   metric_no_threshold, 0, user_requested_cpu_list,
> -				   system_wide, root_metric, visited, table);
> +				   system_wide, fake_pmu, root_metric, visited, table);
>  	} else {
>  		int j, count;
>  
> @@ -969,7 +977,7 @@ static int add_metric(struct list_head *metric_list,
>  		for (j = 0; j < count && !ret; j++)
>  			ret = __add_metric(metric_list, pm, modifier, metric_no_group,
>  					   metric_no_threshold, j, user_requested_cpu_list,
> -					   system_wide, root_metric, visited, table);
> +					   system_wide, fake_pmu, root_metric, visited, table);
>  	}
>  
>  	return ret;
> @@ -1030,6 +1038,7 @@ struct metricgroup__add_metric_data {
>  	bool metric_no_group;
>  	bool metric_no_threshold;
>  	bool system_wide;
> +	bool fake_pmu;
>  	bool has_match;
>  };
>  
> @@ -1047,7 +1056,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
>  		data->has_match = true;
>  		ret = add_metric(data->list, pm, data->modifier, metric_no_group,
>  				 data->metric_no_threshold, data->user_requested_cpu_list,
> -				 data->system_wide, /*root_metric=*/NULL,
> +				data->system_wide, data->fake_pmu, /*root_metric=*/NULL,
>  				 /*visited_metrics=*/NULL, table);
>  	}
>  	return ret;
> @@ -1065,6 +1074,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
>   *                   user may override.
>   * @user_requested_cpu_list: Command line specified CPUs to record on.
>   * @system_wide: Are events for all processes recorded.
> + * @fake_pmu: Are PMUs and events being faked for testing?
>   * @metric_list: The list that the metric or metric group are added to.
>   * @table: The table that is searched for metrics, most commonly the table for the
>   *       architecture perf is running upon.
> @@ -1072,7 +1082,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
>  static int metricgroup__add_metric(const char *pmu, const char *metric_name, const char *modifier,
>  				   bool metric_no_group, bool metric_no_threshold,
>  				   const char *user_requested_cpu_list,
> -				   bool system_wide,
> +				   bool system_wide, bool fake_pmu,
>  				   struct list_head *metric_list,
>  				   const struct pmu_metrics_table *table)
>  {
> @@ -1087,6 +1097,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>  		.metric_no_threshold = metric_no_threshold,
>  		.user_requested_cpu_list = user_requested_cpu_list,
>  		.system_wide = system_wide,
> +		.fake_pmu = fake_pmu,
>  		.has_match = false,
>  	};
>  
> @@ -1118,6 +1129,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>   *                   user may override.
>   * @user_requested_cpu_list: Command line specified CPUs to record on.
>   * @system_wide: Are events for all processes recorded.
> + * @fake_pmu: Are PMUs and events being faked for testing?
>   * @metric_list: The list that metrics are added to.
>   * @table: The table that is searched for metrics, most commonly the table for the
>   *       architecture perf is running upon.
> @@ -1126,7 +1138,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
>  					bool metric_no_group,
>  					bool metric_no_threshold,
>  					const char *user_requested_cpu_list,
> -					bool system_wide, struct list_head *metric_list,
> +					bool system_wide, bool fake_pmu,
> +					struct list_head *metric_list,
>  					const struct pmu_metrics_table *table)
>  {
>  	char *list_itr, *list_copy, *metric_name, *modifier;
> @@ -1145,7 +1158,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
>  		ret = metricgroup__add_metric(pmu, metric_name, modifier,
>  					      metric_no_group, metric_no_threshold,
>  					      user_requested_cpu_list,
> -					      system_wide, metric_list, table);
> +					      system_wide, fake_pmu,
> +					      metric_list, table);
>  		if (ret == -EINVAL)
>  			pr_err("Fail to parse metric or group `%s'\n", metric_name);
>  		else if (ret == -ENOENT)
> @@ -1403,7 +1417,8 @@ static int parse_groups(struct evlist *perf_evlist,
>  
>  	ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
>  					   user_requested_cpu_list,
> -					   system_wide, &metric_list, table);
> +					   system_wide, fake_pmu,
> +					   &metric_list, table);
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.56.0.rc1.310.g51773c2048-goog
