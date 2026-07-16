Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782B311C15;
	Thu, 16 Jul 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784241035; cv=none; b=FaBT/gXEMW1u37O4Hsgm+tlGG03O918wVigB5IR1xaL5Z1xMxY1eqTIzoLG0qmvGxgbV+i/q36thzCchHa2mKY97kM3qIJGyUU6Dsa/P87ObBSTgq+MiqUmhhXOOP+Cxj5eLrs1HKn9hEp3sDYNhldCHEr9ZZG9AiK3zVD8vA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784241035; c=relaxed/simple;
	bh=q9rODVfIq5f/0D6ShvfZXcMG5tmLvvGUgrgiAtLo8PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3TKES2j6mzPHsmUbKGDDrVoQkTpi+oJSMrp1Sjvk9Hs/f+WBvLSJR2+0lMUIPePf6DyMQiYNbh6e9X71+PKJl841tRn9digQLP9MoDbih+7ZFy4nUw9ao+pZwSGbWuEKc1w2hhwVwnA/7bBJILBuVpTfKowmmPr/ljGZ20kTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPTNL9vN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPTNL9vN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C53F1F000E9;
	Thu, 16 Jul 2026 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784241034;
	bh=ZSJjdoM2aF5tiUZR22O8+V1Sk1dLwY3MxnVkPC0qzAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPTNL9vNwP8lZC8TZiGXMXFqGGTorNQkjS3XmqZ0pORk04knbtddG3WdaEfeaVwrO
	 +bfAXPxq5LIeXMLpn6oyCbSqHKoOVm4TMdxc8a4jPummDKgsTdbCymmjyAiMkCDoXW
	 4jgwbtnXf0SP/NEtwrnQD7CFP6Foju97k8xIgSXe/8EIB+y8JHony722QY87jRoSiV
	 fnnL4lwix6pelagzVUHoRtrkLrQ+zI6uILwwv1Q2W1tV3+0xKIRSwfcgoHnT79NQ2E
	 nK31Ri51ojmLYelCtiZBw4LqdgnjyhV/UQ5gq0JdDpBgaNYwvOvY/dXFyEqvPbt94E
	 9rtVTzJFMML7A==
Date: Thu, 16 Jul 2026 15:30:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ctshao@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 02/14] perf stat: Implement standard console (STD)
 formatting callbacks
Message-ID: <allbiFCS2o5TFxPi@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716070303.507066-3-irogers@google.com>

On Thu, Jul 16, 2026 at 12:02:51AM -0700, Ian Rogers wrote:
> This patch implements standard console formatting callbacks inside
> util/stat-print-std.c, replacing the empty stubs introduced in Commit 1.
> 
> Introduces the format-private `struct queued_event` and `struct
> queued_metric` DOM nodes to buffer traversal streams, and fully
> encapsulates DOM state initialization and queue cleanups inside
> std_print_start() and std_print_end().
> 
> Utilizes the newly centralized unified aggregation helpers to resolve
> CPU and thread prefixes cleanly, and incorporates full interval-mode
> timestamp printing support across all rows.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Acked-by: Chun-Tse Shao <ctshao@google.com>
> ---
[SNIP]
> +static int std_print_event(void *ctx, struct perf_stat_config *config,
> +			   struct evsel *evsel, int aggr_idx, u64 val, u64 ena,
> +			   u64 run, double stdev_pct, const char *cgrp)
> +{
> +	struct std_print_state *ps = ctx;
> +	struct queued_event *ev;
> +	/* Skip zero counters locally in STD callbacks if they qualify */
> +	if (val == 0 && std_should_skip_zero_counter(config, evsel, aggr_idx)) {
> +		ps->current_event = NULL;
> +		return 0;
> +	}
> +
> +	ev = malloc(sizeof(*ev));
> +	if (!ev)
> +		return -ENOMEM;

I expected this function prints the event info right away.  Why we need
to save it and print later?

> +
> +	ev->name = strdup(evsel__name(evsel));
> +	if (!ev->name) {
> +		free(ev);
> +		return -ENOMEM;
> +	}
> +
> +	if (cgrp && cgrp[0]) {
> +		ev->cgrp = strdup(cgrp);
> +		if (!ev->cgrp) {
> +			free(ev->name);
> +			free(ev);
> +			return -ENOMEM;
> +		}
> +	} else {
> +		ev->cgrp = NULL;
> +	}

Do you really need this?  Why not using evsel__name() and
evsel->cgrp->name directly?


> +
> +	ev->evsel = evsel;
> +	ev->val = val;
> +	ev->ena = ena;
> +	ev->run = run;
> +	ev->stdev_pct = stdev_pct;
> +	ev->aggr_idx = aggr_idx;
> +	INIT_LIST_HEAD(&ev->metrics_list);
> +
> +	list_add_tail(&ev->list, &ps->events_list);
> +	ps->current_event = ev;
> +
> +	return 0;
> +}
[SNIP]
> +static int std_print_end(void *ctx, struct perf_stat_config *config)
>  {
> +	struct std_print_state *ps = ctx;
> +	struct queued_event *ev, *tmp_ev;
> +	struct queued_metric *met, *tmp_met;
> +	FILE *out = ps->fp;
> +	bool first;
> +	const char *last_mg_name = NULL;
> +	const struct perf_pmu *last_pmu = NULL;
> +	int last_aggr_idx = -1;
> +
> +	/* Print the formatted header prefix (only in non-interval mode) */
> +	if (!config->interval)
> +		print_header_std(config, ps->target, ps->argc, ps->argv);
> +
> +	list_for_each_entry_safe(ev, tmp_ev, &ps->events_list, list) {
> +		struct evsel *evsel = ev->evsel;
> +		double sc = evsel->scale;
> +		const char *fmt;
> +		const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
> +		struct metric_event *me =
> +			metricgroup__lookup(&evsel->evlist->metric_events, evsel, false);
> +		bool is_metricgroup = false;
> +		bool skip_header = false;
> +		char full_name[128] = "";
> +
> +		if (me && me->is_default && !evsel->default_show_events) {
> +			struct metric_expr *mexp =
> +				list_first_entry(&me->head, struct metric_expr, nd);
> +			const char *mg_name = mexp->default_metricgroup_name;
> +			bool need_full_name = perf_pmus__num_core_pmus() > 1;
> +
> +			if (need_full_name && evsel->pmu)
> +				scnprintf(full_name, sizeof(full_name), "%s (%s)", mg_name,
> +					  evsel->pmu->name);
> +			else
> +				scnprintf(full_name, sizeof(full_name), "%s", mg_name);
> +			is_metricgroup = true;
> +
> +			if (last_mg_name && !strcmp(last_mg_name, mg_name) &&
> +			    last_pmu == evsel->pmu && last_aggr_idx == ev->aggr_idx) {
> +				skip_header = true;
> +			}
> +			last_mg_name = mg_name;
> +			last_pmu = evsel->pmu;
> +			last_aggr_idx = ev->aggr_idx;
> +		}
> +
> +		/* Print interval timestamp if configured */
> +		if (config->interval && ps->timestamp[0] && !skip_header)
> +			fprintf(out, "%s", ps->timestamp);
> +
> +		/* 1. Print aggregation prefix first (if we don't skip header) */
> +		if (!skip_header && config->aggr_map && ev->aggr_idx >= 0) {
> +			struct aggr_cpu_id id = config->aggr_map->map[ev->aggr_idx];
> +			int aggr_nr = 0;
> +
> +			if (evsel->stats && evsel->stats->aggr)
> +				aggr_nr = evsel->stats->aggr[ev->aggr_idx].nr;
> +
> +			print_aggr_id_std(config, out, evsel, id, aggr_nr);
> +		}
> +
> +		/* 2. Print event value (scaled) or spaces if metricgroup */
> +		if (is_metricgroup) {
> +			if (!skip_header) {
> +				int n = fprintf(out, " %*s", EVNAME_LEN, full_name);
> +				int pad = MGROUP_LEN + config->unit_width + 2 - n;
> +
> +				fprintf(out, "%*s", pad > 0 ? pad : 0, "");
> +			}
> +		} else {
> +			if (config->big_num)
> +				fmt = floor(sc) != sc ? "%'*.2f " : "%'*.0f ";
> +			else
> +				fmt = floor(sc) != sc ? "%*.2f " : "%*.0f ";
> +
> +			if (ev->run == 0 || ev->ena == 0) {
> +				fprintf(out, "%*s ", COUNTS_LEN, bad_count);
> +			} else {
> +				double scaled = (double)ev->val;
> +				double avg;
> +
> +				if (ev->ena < ev->run)
> +					scaled = (double)ev->val * ev->run / ev->ena;

I think the value is already scaled in process_counter_values().

Thanks,
Namhyung

> +
> +				avg = scaled * sc;
> +				fprintf(out, fmt, COUNTS_LEN, avg);
> +			}
