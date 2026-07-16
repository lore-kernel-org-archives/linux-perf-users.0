Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECC33A032;
	Thu, 16 Jul 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784241337; cv=none; b=kRmw7YvHMvx6pTHJRmtYjAB0xMYval85sUi/RXbbrMb3eQuTwkH4HD64XsOSxiN54usTwxyFRYhofrCDRTo622WEm9D/5w7TVg+664xAyRNcO2QZjw7ufQFvM2lY+gF4JkBLAlrQ62APeFQ6LWDcC3DYejlRJFM/fUcPV29jKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784241337; c=relaxed/simple;
	bh=lkyXihIa10ZNHOt9QcVxNlfz4rxv0+g0lSrZJdn7gOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/LV+ajdhfILJqusfmiIlVSJ+9AR5Mu0Arb0dq5/jLB21by0gNbTMJuGDPBiJJSCcQY93SJEJ8EBTow8hIT0LMRdKjiYg6kRqmNcF/9xsbnVKKhjMTgsqUvTLvaCOpmr6O5ZSGNMr9QWRx9xBOznQNMHwPMh2Cps/zxovqoRzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ3TWhdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ3TWhdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106C91F000E9;
	Thu, 16 Jul 2026 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784241336;
	bh=/NNQsaWVgYXVJ8cpGvr2gXk/khzXmsesXByW2IxKpF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SZ3TWhdlzQJcMDWzP9li8LB1aUqBl/tU2wZH8KAhiOAdFezGUO4Ur91NpITdrkJ3E
	 i7HesmOEW0Z3oiw/7FmYbQjsvU+6eZfCxPXd4Enf0yzkmIF/ouIzdW/65Qdrh4Ei5z
	 zU5wa3h5WzSir9+tGIMQQL1pyqL6dbl03Q+EmM/O1HHqRDGmZA8dYDt7xsGbLH/O5k
	 a1O1oyFhhiuGZzm+bXTLY2JbmVDktGScPagsnGijMUZUrb+TToqtPh4YZIbeqFjce0
	 edAgVHCb0fkzWOlyYtqkszV4/BWpCKU5UhGPrOx4igTLnBqXfkpxP2pKk89Cnvc2fJ
	 iecMDy4x6Wauw==
Date: Thu, 16 Jul 2026 15:35:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ctshao@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 07/14] perf stat: Implement CSV formatting callbacks
Message-ID: <allcttQ2S7-dMkny@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716070303.507066-8-irogers@google.com>

On Thu, Jul 16, 2026 at 12:02:56AM -0700, Ian Rogers wrote:
> This patch implements CSV output formatting callbacks inside
> util/stat-print-csv.c, replacing the empty stubs introduced in Commit 1.
> 
> Defines the format-private `struct queued_event` and `struct
> queued_metric` DOM nodes to buffer traversal streams, and fully
> encapsulates CSV queued lists lifecycle and deallocations inside
> csv_print_start() and csv_print_end().
> 
> Utilizes the newly centralized unified aggregation helpers to format CPU
> and thread column prefixes cleanly, fixes metrics separators padding,
> and incorporates full interval-mode timestamp printing support.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Acked-by: Chun-Tse Shao <ctshao@google.com>
> ---
[SNIP]
> +/**
> + * print_aggr_id_csv - Print the aggregation prefix for CSV format.
> + *
> + * Copied and adapted from stat-display.c.
> + */
> +static void print_aggr_id_csv(const struct perf_stat_config *config, FILE *output,
> +			      struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
> +{
> +	const char *sep = config->csv_sep;
> +
> +	switch (config->aggr_mode) {
> +	case AGGR_CORE:
> +		fprintf(output, "S%d-D%d-C%d%s%d%s", id.socket, id.die, id.core, sep, aggr_nr, sep);
> +		break;
> +	case AGGR_CACHE:
> +		fprintf(output, "S%d-D%d-L%d-ID%d%s%d%s", id.socket, id.die, id.cache_lvl, id.cache,
> +			sep, aggr_nr, sep);
> +		break;
> +	case AGGR_CLUSTER:
> +		fprintf(output, "S%d-D%d-CLS%d%s%d%s", id.socket, id.die, id.cluster, sep, aggr_nr,
> +			sep);
> +		break;
> +	case AGGR_DIE:
> +		fprintf(output, "S%d-D%d%s%d%s", id.socket, id.die, sep, aggr_nr, sep);
> +		break;
> +	case AGGR_SOCKET:
> +		fprintf(output, "S%d%s%d%s", id.socket, sep, aggr_nr, sep);
> +		break;
> +	case AGGR_NODE:
> +		fprintf(output, "N%d%s%d%s", id.node, sep, aggr_nr, sep);
> +		break;
> +	case AGGR_NONE:
> +		if (evsel->percore && !config->percore_show_thread)
> +			fprintf(output, "S%d-D%d-C%d%s", id.socket, id.die, id.core, sep);
> +		else if (id.cpu.cpu > -1)
> +			fprintf(output, "CPU%d%s", id.cpu.cpu, sep);
> +		break;
> +	case AGGR_THREAD: {
> +		const char *comm = "unknown";
> +		int pid = -1;
> +
> +		if (evsel && evsel->core.threads && id.thread_idx >= 0 &&
> +		    id.thread_idx < perf_thread_map__nr(evsel->core.threads)) {
> +			comm = perf_thread_map__comm(evsel->core.threads,
> +						      id.thread_idx);
> +			pid = perf_thread_map__pid(evsel->core.threads,
> +						    id.thread_idx);
> +		}
> +		fprintf(output, "%s-%d%s", comm, pid, sep);
> +		break;
> +	}

Can you use the type-agnostic helper here?


> +	case AGGR_GLOBAL:
> +	case AGGR_UNSET:
> +	case AGGR_MAX:
> +	default:
> +		break;
> +	}
> +}
[SNIP]
> +static int csv_print_end(void *ctx, struct perf_stat_config *config)
> +{
> +	struct csv_print_state *ps = ctx;
> +	struct queued_event *ev, *tmp_ev;
> +	struct queued_metric *met, *tmp_met;
> +	FILE *output = ps->fp;
> +	const char *sep = ps->sep;
> +	bool has_metrics;
> +
> +	list_for_each_entry_safe(ev, tmp_ev, &ps->events_list, list) {
> +		struct evsel *evsel = ev->evsel;
> +		bool ok = (ev->run != 0 && ev->ena != 0);
> +		const char *bad_count = ev->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
> +		double enabled_percent = 100;
> +
> +		/* Print interval timestamp first if configured */
> +		if (config->interval && ps->timestamp[0])
> +			fprintf(output, "%s", ps->timestamp);

Doesn't it need a separator?


> +
> +		/* Print aggregation prefix first in CSV normal mode */
> +		if (config->aggr_map && ev->aggr_idx >= 0) {
> +			struct aggr_cpu_id id = config->aggr_map->map[ev->aggr_idx];
> +			int aggr_nr = 0;
> +
> +			if (evsel->stats && evsel->stats->aggr)
> +				aggr_nr = evsel->stats->aggr[ev->aggr_idx].nr;
> +
> +			print_aggr_id_csv(config, output, evsel, id, aggr_nr);
> +		}
> +
> +		/* 1. Print Value, Unit, Name (Columns 1, 2, 3) */
> +		if (ok) {
> +			double sc = ev->scale;
> +			double avg = ev->val * sc;
> +			const char *fmt = floor(sc) != sc ? "%.2f%s" : "%.0f%s";
> +
> +			fprintf(output, fmt, avg, sep);
> +		} else {
> +			fprintf(output, "%s%s", bad_count, sep);
> +		}
>  
> -int perf_stat__print_csv(struct evlist *evlist __maybe_unused,
> -			 const struct perf_stat_config *config __maybe_unused,
> -			 const struct target *target __maybe_unused,
> -			 const struct timespec *ts __maybe_unused,
> -			 int argc __maybe_unused,
> -			 const char **argv __maybe_unused)
> +		if (ev->unit)
> +			fprintf(output, "%s%s", ev->unit, sep);
> +		else
> +			fprintf(output, "%s", sep);
> +
> +		fprintf(output, "%s", ev->name);
> +
> +		/* 2. Print Runtime and Enabled Percentage (Columns 4, 5) */
> +		if (ev->run != ev->ena)
> +			enabled_percent = 100.0 * ev->run / ev->ena;
> +		fprintf(output, "%s%" PRIu64 "%s%.2f", sep, ev->run, sep,
> +			enabled_percent);

Cgroups?

Thanks,
Namhyung

> +
> +		/* 3. Print Metrics (Columns 6, 7) */
> +		has_metrics = false;
> +		list_for_each_entry_safe(met, tmp_met, &ev->metrics_list, list) {
> +			if (!has_metrics) {
> +				has_metrics = true;
> +			} else {
> +				fprintf(output, "\n");
> +				if (config->interval && ps->timestamp[0])
> +					fprintf(output, "%s", ps->timestamp);
> +				if (config->aggr_map && ev->aggr_idx >= 0) {
> +					struct aggr_cpu_id id = config->aggr_map->map[ev->aggr_idx];
> +					int aggr_nr = 0;
> +
> +					if (evsel->stats && evsel->stats->aggr)
> +						aggr_nr = evsel->stats->aggr[ev->aggr_idx].nr;
> +
> +					print_aggr_id_csv(config, output, evsel, id, aggr_nr);
> +				}
> +				/*
> +				 * Pad exactly 4 commas (Value, Unit, Name, Run, Enabled)
> +				 * to line up with the Metric Value column.
> +				 */
> +				fprintf(output, "%s%s%s%s", sep, sep, sep, sep);
> +			}
> +			fprintf(output, "%s%.2f%s", sep, met->val, sep);
> +			if (met->name && met->name[0])
> +				fprintf(output, "%s", met->name);
> +
> +			list_del(&met->list);
> +			free(met->name);
> +			free(met->unit);
> +			free(met);
> +		}
> +		if (!has_metrics)
> +			fprintf(output, "%s%s", sep, sep);
> +		fprintf(output, "\n");
> +
> +		list_del(&ev->list);
> +		free(ev->name);
> +		free(ev->unit);
> +		free(ev->cgrp);
> +		free(ev);
> +	}
> +	return 0;
> +}

