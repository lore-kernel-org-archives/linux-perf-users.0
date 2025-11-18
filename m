Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E405326D65;
	Tue, 18 Nov 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433007; cv=none; b=aEry2SoXMyIWHUno+nBS+7xav2sFZf7MsPDOm7WG1cxuZYMGVDC29kQLXG3gv+O18Dy6MHDdLqA7v6E+p0G6Mk3nm0oCzRgtGRb8AwiRYl875sHEyHW44Pz1aV5bVB/8c1UD6SOGphHwcdwEVMOHyy+Hz3gWQUn5Doz0gJlberQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433007; c=relaxed/simple;
	bh=GRoBbQtF2411pFOi4Hn7rRqZu41b/g6654YuaxvYlsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPX9Tcp91uBGiRL0hXXJthhbjyY2IbUkWMQV8UthJNXV5liLlXgRh16aaWF+duVyMCM+TU9TQ4LF1xkMUTS//pFDoEES9G9yUu7mrrULmEsiVL33V49EJqRaXF2tpvqaLv+4p2GdWQDJSDc3FCEEHZ98Fc5TXVDtHmlrw5/jae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5OZXbXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5OZXbXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3858C116B1;
	Tue, 18 Nov 2025 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763433007;
	bh=GRoBbQtF2411pFOi4Hn7rRqZu41b/g6654YuaxvYlsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5OZXbXJdgQH41clItlwobZZFnYGk3ttbtDiwKMSY+UkBFIVsq+Iiuw1cv7vCXQRA
	 vth8ASNM4GOrly95RuN9rA26ebrq5gM4XSRx++x+Y62sOCLrLTG4XTxg51c1OTKoe8
	 vlvhpQd/MYpAjQkMfELun8XJCtyG0LSMUobbm9zo9cp/fMQL/IYhUgpmNcPzdx93kq
	 5CHc6zsb4z5ts1sWS7yEehO0rP4fK77poeRVzgB8UopCBIT9K3DYl8pOIuO/GNq+gC
	 kPU3sHfkB9IgVcxaA6uAAut+ti8OJSTUiO++Lopd1dFa9ngc2nyNSIzIIZExlv2X4U
	 QR0Xbj1FVXs8Q==
Date: Mon, 17 Nov 2025 18:30:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 04/10] perf stat-shadow: Read tool events directly
Message-ID: <aRvaK32xmC8XUA-k@google.com>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113180517.44096-5-irogers@google.com>

On Thu, Nov 13, 2025 at 10:05:10AM -0800, Ian Rogers wrote:
> When reading time values for metrics don't use the globals updated in
> builtin-stat, just read the events as regular events. The only
> exception is for time events where nanoseconds need converting to
> seconds as metrics assume time metrics are in seconds.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-shadow.c | 149 +++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 83 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index b3b482e1808f..6c1ad78604e1 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -26,7 +26,32 @@ void perf_stat__reset_shadow_stats(void)
>  	memset(&ru_stats, 0, sizeof(ru_stats));
>  }
>  
> -static int prepare_metric(const struct metric_expr *mexp,
> +static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
> +				   const struct evsel *evsel, int *tool_aggr_idx)
> +{
> +	enum tool_pmu_event event = evsel__tool_event(evsel);
> +	int aggr_idx;
> +
> +	if (event != TOOL_PMU__EVENT_DURATION_TIME &&
> +	    event != TOOL_PMU__EVENT_USER_TIME &&
> +	    event != TOOL_PMU__EVENT_SYSTEM_TIME)
> +		return false;
> +
> +	if (config) {
> +		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> +			if (config->aggr_map->map[aggr_idx].cpu.cpu == 0) {
> +				*tool_aggr_idx = aggr_idx;
> +				return true;
> +			}
> +		}
> +		pr_debug("Unexpected CPU0 missing in aggregation for tool event.\n");
> +	}
> +	*tool_aggr_idx = 0; /* Assume the first aggregation index works. */
> +	return true;
> +}
> +
> +static int prepare_metric(struct perf_stat_config *config,
> +			  const struct metric_expr *mexp,
>  			  const struct evsel *evsel,
>  			  struct expr_parse_ctx *pctx,
>  			  int aggr_idx)
> @@ -36,93 +61,51 @@ static int prepare_metric(const struct metric_expr *mexp,
>  	int i;
>  
>  	for (i = 0; metric_events[i]; i++) {
> +		int source_count = 0, tool_aggr_idx;
> +		bool is_tool_time =
> +			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
> +		struct perf_stat_evsel *ps = metric_events[i]->stats;
> +		struct perf_stat_aggr *aggr;
>  		char *n;
>  		double val;
> -		int source_count = 0;
>  
> -		if (evsel__is_tool(metric_events[i])) {
> -			struct stats *stats;
> -			double scale;
> -
> -			switch (evsel__tool_event(metric_events[i])) {
> -			case TOOL_PMU__EVENT_DURATION_TIME:
> -				stats = &walltime_nsecs_stats;
> -				scale = 1e-9;
> -				break;
> -			case TOOL_PMU__EVENT_USER_TIME:
> -				stats = &ru_stats.ru_utime_usec_stat;
> -				scale = 1e-6;
> +		/*
> +		 * If there are multiple uncore PMUs and we're not reading the
> +		 * leader's stats, determine the stats for the appropriate
> +		 * uncore PMU.
> +		 */
> +		if (evsel && evsel->metric_leader &&
> +		    evsel->pmu != evsel->metric_leader->pmu &&
> +		    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
> +			struct evsel *pos;
> +
> +			evlist__for_each_entry(evsel->evlist, pos) {
> +				if (pos->pmu != evsel->pmu)
> +					continue;
> +				if (pos->metric_leader != mexp->metric_events[i])
> +					continue;
> +				ps = pos->stats;
> +				source_count = 1;
>  				break;
> -			case TOOL_PMU__EVENT_SYSTEM_TIME:
> -				stats = &ru_stats.ru_stime_usec_stat;
> -				scale = 1e-6;
> -				break;

I think this was broken as it seems to be converted to nsec in the
update_rusage_stats().


> -			case TOOL_PMU__EVENT_NONE:
> -				pr_err("Invalid tool event 'none'");
> -				abort();
> -			case TOOL_PMU__EVENT_MAX:
> -				pr_err("Invalid tool event 'max'");
> -				abort();
> -			case TOOL_PMU__EVENT_HAS_PMEM:
> -			case TOOL_PMU__EVENT_NUM_CORES:
> -			case TOOL_PMU__EVENT_NUM_CPUS:
> -			case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
> -			case TOOL_PMU__EVENT_NUM_DIES:
> -			case TOOL_PMU__EVENT_NUM_PACKAGES:
> -			case TOOL_PMU__EVENT_SLOTS:
> -			case TOOL_PMU__EVENT_SMT_ON:
> -			case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
> -			case TOOL_PMU__EVENT_CORE_WIDE:
> -			case TOOL_PMU__EVENT_TARGET_CPU:
> -			default:
> -				pr_err("Unexpected tool event '%s'", evsel__name(metric_events[i]));
> -				abort();
>  			}
> -			val = avg_stats(stats) * scale;
> -			source_count = 1;
> -		} else {
> -			struct perf_stat_evsel *ps = metric_events[i]->stats;
> -			struct perf_stat_aggr *aggr;
> -
> +		}
> +		/* Time events are always on CPU0, the first aggregation index. */
> +		aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
> +		if (!aggr || !metric_events[i]->supported) {
>  			/*
> -			 * If there are multiple uncore PMUs and we're not
> -			 * reading the leader's stats, determine the stats for
> -			 * the appropriate uncore PMU.
> +			 * Not supported events will have a count of 0, which
> +			 * can be confusing in a metric. Explicitly set the
> +			 * value to NAN. Not counted events (enable time of 0)
> +			 * are read as 0.
>  			 */
> -			if (evsel && evsel->metric_leader &&
> -			    evsel->pmu != evsel->metric_leader->pmu &&
> -			    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
> -				struct evsel *pos;
> -
> -				evlist__for_each_entry(evsel->evlist, pos) {
> -					if (pos->pmu != evsel->pmu)
> -						continue;
> -					if (pos->metric_leader != mexp->metric_events[i])
> -						continue;
> -					ps = pos->stats;
> -					source_count = 1;
> -					break;
> -				}
> -			}
> -			aggr = &ps->aggr[aggr_idx];
> -			if (!aggr)
> -				break;
> -
> -			if (!metric_events[i]->supported) {
> -				/*
> -				 * Not supported events will have a count of 0,
> -				 * which can be confusing in a
> -				 * metric. Explicitly set the value to NAN. Not
> -				 * counted events (enable time of 0) are read as
> -				 * 0.
> -				 */
> -				val = NAN;
> -				source_count = 0;
> -			} else {
> -				val = aggr->counts.val;
> -				if (!source_count)
> -					source_count = evsel__source_count(metric_events[i]);
> -			}
> +			val = NAN;
> +			source_count = 0;
> +		} else {
> +			val = aggr->counts.val;
> +			if (is_tool_time)
> +				val *= 1e-9; /* Convert time event nanoseconds to seconds. */

And this code treats all time events are in nsec now.

Thanks,
Namhyung


> +			if (!source_count)
> +				source_count = evsel__source_count(metric_events[i]);
>  		}
>  		n = strdup(evsel__metric_id(metric_events[i]));
>  		if (!n)
> @@ -168,7 +151,7 @@ static void generic_metric(struct perf_stat_config *config,
>  		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
>  	pctx->sctx.runtime = runtime;
>  	pctx->sctx.system_wide = config->system_wide;
> -	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
> +	i = prepare_metric(config, mexp, evsel, pctx, aggr_idx);
>  	if (i < 0) {
>  		expr__ctx_free(pctx);
>  		return;
> @@ -229,7 +212,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
>  	if (!pctx)
>  		return NAN;
>  
> -	if (prepare_metric(mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
> +	if (prepare_metric(/*config=*/NULL, mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
>  		goto out;
>  
>  	if (expr__parse(&ratio, pctx, mexp->metric_expr))
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
