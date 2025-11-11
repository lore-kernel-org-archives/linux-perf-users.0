Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A752D23A6;
	Tue, 11 Nov 2025 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844365; cv=none; b=BOfDi4rCslBjZWB4w8jDbvTrzaWglk5+RssppwxXGPUkUEAA53Lv4UsQA5tT+aW2Uebh/HK1N6s63tihZYCokFru949P/8QQRCR0G1LjAjiiJjzgeuugAtdazMp3gyOy3LcDeiBpw/0eBWsm0DEYehSlgN5Up38hzkC5Rgm+vSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844365; c=relaxed/simple;
	bh=GwqOK7aNSGdBPGdkkMWNQoTo1BWpZUs35vnBNkSNfis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RavGRR5d2l4SU0NvaeATgCvtxpTtdRDCQfajXy9N6PcZsiRVFlSTS2v/C9ejGuROkflI7pY0uaSRi83vbdPidBdQ+VuSVuBGFrsWyZ4AWP6jAlIuTd9zJuok0CqIC4eTMAVrOw/IgDDQpxJ1rdshSb5ui5N3UUC4wLfwcESNn/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awbIHS1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awbIHS1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2E6C4CEF7;
	Tue, 11 Nov 2025 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762844364;
	bh=GwqOK7aNSGdBPGdkkMWNQoTo1BWpZUs35vnBNkSNfis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awbIHS1PDbjULdy//eyzrvAJgvY8GWHR/o9zwRUby0D0Y59+MhFKOr8uHKbq9RYyw
	 rEMpb/EAfxgY5mRZk3TZHgc+0EJ43tgAtS6kYgOt/aJBYX88K7QCu9n5H8TpHFVgId
	 NfkKpP7cpBMS0UOD104kqGY7bxiEp6ZgemkgQekUWrMB9y1gSzHDTateHXybp2EOqd
	 KJt5GqewP5MUEb11J7+fEFJHq9tyokPIEpCGYWGac1PsrzguzUANRuF3IeoCSAiV0v
	 ZjYs5wHwPzDfqhj4PAfVAlw/KDEsVR3n3O2+ifUklyh0xfGLMOeFICyyYhdi5iQHYc
	 wermkJc02f2/g==
Date: Mon, 10 Nov 2025 22:59:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v3 06/18] perf script: Change metric format to use json
 metrics
Message-ID: <aRLeyoCQVG46KKEv@google.com>
References: <20251111040417.270945-1-irogers@google.com>
 <20251111040417.270945-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111040417.270945-7-irogers@google.com>

On Mon, Nov 10, 2025 at 08:04:05PM -0800, Ian Rogers wrote:
> The metric format option isn't properly supported. This change
> improves that by making the sample events update the counts of an
> evsel, where the shadow metric code expects to read the values.  To
> support printing metrics, metrics need to be found. This is done on
> the first attempt to print a metric. Every metric is parsed and then
> the evsels in the metric's evlist compared to those in perf script
> using the perf_event_attr type and config. If the metric matches then
> it is added for printing. As an event in the perf script's evlist may
> have >1 metric id, or different leader for aggregation, the first
> metric matched will be displayed in those cases.
> 
> An example use is:
> ```
> $ perf record -a -e '{instructions,cpu-cycles}:S' -a -- sleep 1
> $ perf script -F period,metric
> ...
>      867817
>          metric:    0.30  insn per cycle
>      125394
>          metric:    0.04  insn per cycle
>      313516
>          metric:    0.11  insn per cycle
>          metric:    1.00  insn per cycle
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> @@ -2150,23 +2296,72 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  			 },
>  		.force_header = false,
>  	};
> -	struct evsel *ev2;
> -	u64 val;
> +	struct perf_counts_values *count, *old_count;
> +	int cpu_map_idx, thread_map_idx, aggr_idx;
> +	struct evsel *pos;
> +
> +	if (!init_metrics) {
> +		/* One time initialization of stat_config and metric data. */
> +		struct script_find_metrics_args args = {
> +			.evlist = evsel->evlist,
> +			/* TODO: Determine system-wide based on evlist.. */
> +			.system_wide = true,

Probably you can check if the thread_map has an entry for -1.


> +		};
> +		if (!stat_config.output)
> +			stat_config.output = stdout;
> +
> +		if (!stat_config.aggr_map) {
> +			/* TODO: currently only global aggregation is supported. */
> +			assert(stat_config.aggr_mode == AGGR_GLOBAL);

IIUC there's no option or config to set different aggregation mode for
perf script.

Thanks,
Namhyung


> +			stat_config.aggr_get_id = script_aggr_cpu_id_get;
> +			stat_config.aggr_map =
> +				cpu_aggr_map__new(evsel->evlist->core.user_requested_cpus,
> +						  aggr_cpu_id__global, /*data=*/NULL,
> +						  /*needs_sort=*/false);
> +		}
>  
> -	if (!evsel->stats)
> -		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
> -	if (evsel_script(leader)->gnum++ == 0)
> -		perf_stat__reset_shadow_stats();
> -	val = sample->period * evsel->scale;
> -	evsel_script(evsel)->val = val;
> -	if (evsel_script(leader)->gnum == leader->core.nr_members) {
> -		for_each_group_member (ev2, leader) {
> -			perf_stat__print_shadow_stats(&stat_config, ev2,
> -						      evsel_script(ev2)->val,
> -						      sample->cpu,
> -						      &ctx);
> +		metricgroup__for_each_metric(pmu_metrics_table__find(), script_find_metrics, &args);
> +		init_metrics = true;
> +	}
> +
> +	if (!evsel->stats) {
> +		if (evlist__alloc_stats(&stat_config, evsel->evlist, /*alloc_raw=*/true) < 0)
> +			return;
> +	}
> +	if (!evsel->stats->aggr) {
> +		if (evlist__alloc_aggr_stats(evsel->evlist, stat_config.aggr_map->nr) < 0)
> +			return;
> +	}
> +
> +	/* Update the evsel's count using the sample's data. */
> +	cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){sample->cpu});
> +	thread_map_idx = perf_thread_map__idx(evsel->core.threads, sample->tid);
> +	if (thread_map_idx < 0) {
> +		/* Missing thread, check for any thread. */
> +		if (perf_thread_map__pid(evsel->core.threads, /*idx=*/0) == -1) {
> +			thread_map_idx = 0;
> +		} else {
> +			pr_info("Missing thread map entry for thread %d\n", sample->tid);
> +			return;
> +		}
> +	}
> +	count = perf_counts(evsel->counts, cpu_map_idx, thread_map_idx);
> +	old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread_map_idx);
> +	count->val = old_count->val + sample->period;
> +	count->run = old_count->run + 1;
> +	count->ena = old_count->ena + 1;
> +
> +	/* Update the aggregated stats. */
> +	perf_stat_process_counter(&stat_config, evsel);
> +
> +	/* Display all metrics. */
> +	evlist__for_each_entry(evsel->evlist, pos) {
> +		cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
> +			perf_stat__print_shadow_stats(&stat_config, pos,
> +						count->val,
> +						aggr_idx,
> +						&ctx);
>  		}
> -		evsel_script(leader)->gnum = 0;
>  	}
>  }
>  
> @@ -2348,7 +2543,7 @@ static void process_event(struct perf_script *script,
>  	}
>  
>  	if (PRINT_FIELD(METRIC))
> -		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
> +		perf_sample__fprint_metric(thread, evsel, sample, fp);
>  
>  	if (verbose > 0)
>  		fflush(fp);
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
