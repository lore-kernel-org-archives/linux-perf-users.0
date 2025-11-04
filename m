Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41B33F8A8;
	Tue,  4 Nov 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279839; cv=none; b=HVt5p1FJjeD/TxAr3NSUd46xxzaSQkFrpPMWmfpMcw0zWPakaqmYVhS4XN+N0ttYGC0P2O0KTOtgBA5/E1PA7wvYt4IOlYg2a4ZxeK+ojp6wbuZGDd1NHUGOx2b28YCOvnKE8Rv6O3eoPVyf7+Hg8CRNw/1CctjOOvZsDtuROug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279839; c=relaxed/simple;
	bh=BOEQH/InhK+EPN1Ed5pwR6+fua/wJd5n8mBh0wZnu7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvvAy63WOBppkeyMuc6LMOMkGuJ7ca0al//XoDAlXgcgS6Cjw7m+o+KPx+a2+ktXjr/5Ugh9CCUPajDC+d1gsVBN0Anz6heiPB5t92DyczHu1Okvy35N6MyPza4DLqkHbLWdqnS22ZK+BKZGrlFyhtpp2QfyIlJbINlRtcBbwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3DSD4LS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3DSD4LS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A75C4AF09;
	Tue,  4 Nov 2025 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279839;
	bh=BOEQH/InhK+EPN1Ed5pwR6+fua/wJd5n8mBh0wZnu7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3DSD4LS0V3MEKs29WXx0AkBIEzIWsUkkt03AXhK92ObSWXqbZCcia96TSev5uLiR
	 0NYMPCtNRRHwICAkJvRGFUChYXQ85DSaXuOdmNlXKVi4dsSVWhAJ2GCRrVjFJlJKPW
	 npWzgSIWn13Md5OJ7xR1Se30N1kifoCogo5K/z9HhYzgn8N986x74kQePlNtVBw1Zf
	 /dj9vH4bSnwjU8Ge2rkJeglQYSKZkwhUw3nXH7oIIpp9Bb4laHmQnGDe56Ys2LXezm
	 CYenhHk5SdYcu7dNXZhJ/BPuvVSMz5MnXr8OdTjKtTLwB20fmc10xhqDtxiFh/RP1E
	 +yYnzYWn5Xv+Q==
Date: Tue, 4 Nov 2025 10:10:32 -0800
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
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf stat-shadow: Read tool events directly
Message-ID: <aQpBmIEX8G7mTrWQ@google.com>
References: <20251104053449.1208800-1-irogers@google.com>
 <20251104053449.1208800-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104053449.1208800-2-irogers@google.com>

Hi Ian,

On Mon, Nov 03, 2025 at 09:34:48PM -0800, Ian Rogers wrote:
> When reading time values for metrics don't use the globals updated in
> builtin-stat, just read the events as regular events. The only
> exception is for time events where nanoseconds need converting to
> seconds as metrics assume time metrics are in seconds.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-shadow.c | 123 +++++++++++++---------------------
>  1 file changed, 45 insertions(+), 78 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index abaf6b579bfc..9fae3d32a519 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -371,6 +371,18 @@ static void print_nsecs(struct perf_stat_config *config,
>  	}
>  }
>  
> +static double tool_pmu__scale_for_metric(const struct evsel *evsel)
> +{
> +	enum tool_pmu_event event = evsel__tool_event(evsel);
> +
> +	if (event == TOOL_PMU__EVENT_DURATION_TIME ||
> +	    event == TOOL_PMU__EVENT_USER_TIME ||
> +	    event == TOOL_PMU__EVENT_SYSTEM_TIME)
> +		return 1e-9; /* Scale nanoseconds to seconds. */
> +
> +	return 1.0;
> +}
> +
>  static int prepare_metric(const struct metric_expr *mexp,
>  			  const struct evsel *evsel,
>  			  struct expr_parse_ctx *pctx,
> @@ -382,90 +394,45 @@ static int prepare_metric(const struct metric_expr *mexp,
>  
>  	for (i = 0; metric_events[i]; i++) {
>  		char *n;
> -		double val;
> +		double val, scale = tool_pmu__scale_for_metric(metric_events[i]);
>  		int source_count = 0;
> +		struct perf_stat_evsel *ps = metric_events[i]->stats;
> +		struct perf_stat_aggr *aggr;
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
> -				break;
> -			case TOOL_PMU__EVENT_SYSTEM_TIME:
> -				stats = &ru_stats.ru_stime_usec_stat;
> -				scale = 1e-6;

Do {USER,SYSTEM}_TIME become nanosecond now?

Thanks,
Namhyung

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
> +		aggr = &ps->aggr[aggr_idx];
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
> +			val = aggr->counts.val * scale;
> +			if (!source_count)
> +				source_count = evsel__source_count(metric_events[i]);
>  		}
>  		n = strdup(evsel__metric_id(metric_events[i]));
>  		if (!n)
> -- 
> 2.51.2.1006.ga50a493c49-goog
> 
