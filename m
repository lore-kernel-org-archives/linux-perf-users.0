Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32233361650;
	Thu, 16 Jul 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784241813; cv=none; b=H7X0s2SgiqgCHjXKN49UxE24SFjshNb6Mg56yQRbRavXnbnk1ZSZcxCeaR+VGgAHg/LmMLthHy66siKOWGnEzfD8AwObssJgqCv4BZBrR9TyiUdNYHtmJ70UYVUIDp/Tj/+djowJO7B8Y8pLzxyuvJeKCAMJoSmA65lCgwGuvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784241813; c=relaxed/simple;
	bh=uvOYz+BShLVm3lnkyR1WzNjGDUH+GpG5cIx2fJ8OsWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV4exF2PjNDOhlwKxvdNP0KNQOu6ylvVSQx39r8SaYE7MuyVjcqhFxvWqT203DSwbLNeB8/eipoDk9hv+omBz0gAgGpqU1W1E1HwNo+gga5NljT4AU9dDAtY+hfDtg1scf5djbIn5PP39PlLdiOHdHkZR9FCL0rTmLlYScQM1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZSxeymA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZSxeymA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD171F000E9;
	Thu, 16 Jul 2026 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784241811;
	bh=sbl6yLxlk8c3ZhpEp6QaPA8umuHA5hyUrNnF460SpwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZSxeymAalBqu5wVaZjYICSW/syXdBPqKRYvhZYi2poIyq+TVVUtWt+e8sFTTL5lY
	 sXTOfuwUofVBGuMpCFhrsE4YNUPbZZ0vkMCEEODo0mg1jwyN5+GuY/guGjYwuTSqAC
	 /+uRWAAwzV0EvJkEQE90MyDa54d+8oITR8mtO6cxY1obRNkTTL7oKbNwnDcXRs1m8Q
	 Vl6X8voHj4nhKZ58CBkYEA7g8OsUUpZ9zhEO+bdZNpt2UMUig9MmHLd51YCf5uTje7
	 GFORV6356UzZobFidLXsU1YNSh18twfHAD/iMOCDV4ZxYyxgdPhwH2NWMh0dNNPXxr
	 wlJqIf9SCcEFw==
Date: Thu, 16 Jul 2026 15:43:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ctshao@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 10/14] perf stat: Implement streaming JSON formatting
 callbacks
Message-ID: <allekmOL6CIjYrEt@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716070303.507066-11-irogers@google.com>

On Thu, Jul 16, 2026 at 12:02:59AM -0700, Ian Rogers wrote:
> This patch implements streaming JSON formatting callbacks inside
> util/stat-print-json.c, replacing the empty stubs introduced in Commit
> 1.
> 
> Delivers a highly optimized, zero-allocation, and 100% streaming print
> engine for JSON normal and metric-only modes. It bypasses dynamic queue
> events and metric lists entirely, formatting and streaming JSON objects
> directly onto the output file descriptor.
> 
> Utilizes the newly centralized unified aggregation helpers to format CPU
> and thread keys inside the JSON objects, and incorporates full
> interval-mode timestamp printing support.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Acked-by: Chun-Tse Shao <ctshao@google.com>
> ---
[SNIP]
> +/**
> + * print_aggr_id_json - Print the aggregation prefix for JSON format.
> + *
> + * Copied and adapted from stat-display.c.
> + */
> +static void print_aggr_id_json(const struct perf_stat_config *config, FILE *output,
> +			       struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
> +{
> +	switch (config->aggr_mode) {
> +	case AGGR_CORE:
> +		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : %d, ", id.socket,
> +			id.die, id.core, aggr_nr);
> +		break;
> +	case AGGR_CACHE:
> +		fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"counters\" : %d, ", id.socket,
> +			id.die, id.cache_lvl, id.cache, aggr_nr);
> +		break;
> +	case AGGR_CLUSTER:
> +		fprintf(output, "\"cluster\" : \"S%d-D%d-CLS%d\", \"counters\" : %d, ", id.socket,
> +			id.die, id.cluster, aggr_nr);
> +		break;
> +	case AGGR_DIE:
> +		fprintf(output, "\"die\" : \"S%d-D%d\", \"counters\" : %d, ", id.socket, id.die,
> +			aggr_nr);
> +		break;
> +	case AGGR_SOCKET:
> +		fprintf(output, "\"socket\" : \"S%d\", \"counters\" : %d, ", id.socket, aggr_nr);
> +		break;
> +	case AGGR_NODE:
> +		fprintf(output, "\"node\" : \"N%d\", \"counters\" : %d, ", id.node, aggr_nr);
> +		break;
> +	case AGGR_NONE:
> +		if (evsel->percore && !config->percore_show_thread)
> +			fprintf(output, "\"core\" : \"S%d-D%d-C%d\", ", id.socket, id.die, id.core);
> +		else if (id.cpu.cpu > -1)
> +			fprintf(output, "\"cpu\" : \"%d\", ", id.cpu.cpu);
> +		break;
> +	case AGGR_THREAD:
> +		fprintf(output, "\"thread\" : \"%s-%d\", ",
> +			perf_thread_map__comm(evsel->core.threads, id.thread_idx),
> +			perf_thread_map__pid(evsel->core.threads, id.thread_idx));
> +		break;
> +	case AGGR_GLOBAL:
> +	case AGGR_UNSET:
> +	case AGGR_MAX:
> +	default:
> +		break;
> +	}

It'd be great if you can use the format-agnostic helpers.


> +}
> +
> +/*
> + * JSON Output Callbacks - Normal Mode (100% Streaming & Zero-Allocation)
> + */
> +
> +static int json_print_start(void *ctx __maybe_unused,
> +			    struct perf_stat_config *config __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static int json_print_event(void *ctx, struct perf_stat_config *config,
> +			    struct evsel *evsel, int aggr_idx, u64 val,
> +			    u64 ena, u64 run, double stdev_pct __maybe_unused,
> +			    const char *cgrp __maybe_unused)
> +{
> +	struct json_print_state *ps = ctx;
> +	FILE *output = config->output;
> +	bool ok = (run != 0 && ena != 0);
> +	double enabled_percent = 100.0;
> +
> +	fprintf(output, "{");
> +
> +	/* Print interval timestamp first if configured */
> +	if (config->interval && ps && ps->timestamp[0])
> +		fprintf(output, "%s", ps->timestamp);

"Interval" : ?


> +
> +	/* Print aggregation JSON fields if configured */
> +	if (config->aggr_map && aggr_idx >= 0) {
> +		struct aggr_cpu_id id = config->aggr_map->map[aggr_idx];
> +		int aggr_nr = 0;
> +
> +		if (evsel->stats && evsel->stats->aggr)
> +			aggr_nr = evsel->stats->aggr[aggr_idx].nr;
> +
> +		print_aggr_id_json(config, output, evsel, id, aggr_nr);
> +	}
> +
> +	if (ok) {
> +		double sc = evsel->scale;
> +		double avg = val * sc;
> +
> +		fprintf(output, "\"counter-value\" : \"%f\"", avg);
> +	} else {
> +		const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
> +
> +		fprintf(output, "\"counter-value\" : \"%s\"", bad_count);
> +	}
> +
> +	fprintf(output, ", \"unit\" : \"%s\"", evsel->unit ?: "");
> +	/* Cast away const for legacy evsel__name */
> +	fprintf(output, ", \"event\" : \"%s\"", evsel__name((struct evsel *)evsel));

Cgroups?

> +
> +	if (run != ena)
> +		enabled_percent = 100.0 * run / ena;
> +	fprintf(output, ", \"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f", run,
> +		enabled_percent);
> +	fprintf(output, "}\n");

Now metrics are printed in a separate object/line?

Thanks,
Namhyung

> +
> +	return 0;
> +}
