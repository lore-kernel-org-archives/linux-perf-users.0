Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073256;
	b=4Cw0Hz7SA+YOWy7uHNXA8nEEImSGjIC/HINKrXay8bfTiNRD8HQN1Oe9AXMjtQ1V+tTf
	 hIV696ZchaNX3XFbgoQMPW2cpHJwTN7D8JzeX22RweLpe11HHaBWxdJh8LdcPB3oDCrvu
	 r9cXX4liPKtaHr+MAz4IivZg+pX9G47X5u5yL6+9QjWMnigxMsqj3Zu1SEkBQIcWUNtyt
	 5GQSQqnqYXKCXXvhHKbBOleigDPEUguVeulkQOlEWe+xkV2mfU9nk4ZUq2C0EhlgN+r9j
	 Tlo7jd6zRDfqmovtcjn6Z3hQKpvlwki+QlAGumHViEsAJCB7NgyJNBlPIpQ5VPyOYww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073256;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jIc4HeBdmwON8M0w3KkiPM2NOWu3OhKIemIwmO5a27I=;
	b=ec5BENMXy/nD16ghVpgyfDsRB2Wpy8dWF7O6jAzJOHbspUBxtemIHcdh7kJFquBeyPPk
	 Im493NcYRZiKqLoUTLFQcn8spKIu46VM4wH7m4Ylrel1AjXLhmKVJIl5AFyGhKTbRSN7s
	 GcR2kNtCz8AyH2bOIAJAvZmU/pb7cRQ7o4s8JSuclu0wtGXcmABL3qXtUCG/p3H8K3u5g
	 f2yECpsgz3yxjh8+2vLIYbXtia5qTmTxqYcZ3oUt0JdbkgyxSgULFakgcyRddCzb8B7tY
	 wmPNbXjkF/pZtlG+Rvp79LgasOsyG9ae/cduxIMudGCxpZtowgfSx1u/O2fX4g3OIJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUff2YrU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D525606A320;
	Thu, 19 Nov 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUff2YrU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659051F000C4;
	Thu, 19 Nov 2026 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073255;
	bh=jIc4HeBdmwON8M0w3KkiPM2NOWu3OhKIemIwmO5a27I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MUff2YrU/OX9lzmUiYZLgBIy7IUvsZqFWd7XXOTo9BxcstDKh0GqVKX6hdogx/fVf
	 TF4SWxV3X9/Gy5vh4XoWs9BzbOKAWrPChq3AK16M0KKmfcI8a756WLDgWS8KLTkOuY
	 Fsx91TYtt2SyQa/ksVgiFgta/3NqSLTUbJFc56ulrHQNuF7sS7Zttv6bS50PwcBxaC
	 VyAzXcZL3VCuGKhu0SsxlUAANgKceOflVgpIOqvHttvyaH5toXHo8tmhgC+rvi3Tdz
	 201cG1zYCFDzsZZgTN6JMVR4rumQxfQpcFbNb5VaoCocvdPIZXOYSGO6XxOoFes2c0
	 ZC7jCJda1o8sA==
Date: Wed, 18 Nov 2026 23:27:33 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Message-ID: <av6k5QSkHPLjCyp7@google.com>
References: <20261111183209.1892421-1-ctshao@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111183209.1892421-1-ctshao@google.com>

Hi CT,

On Wed, Nov 11, 2026 at 10:32:09AM -0800, Chun-Tse Shao wrote:
> When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> JSON output mode (`-j`), `perf stat` evaluates metric expressions
> across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> `uncore_iio_1`, etc.).

What about other outputs like stdio and csv?

Thanks,
Namhyung

> 
> However, `perf stat` previously formatted JSON output by printing only
> "cpu" : "<id>" and grouping all metric values on a single line per CPU
> without identifying which PMU instance evaluated each metric. As a
> result, when an uncore event spans multiple PMU boxes, `perf stat`
> printed repeated, ambiguous metric keys without PMU names.
> 
> Fix this by:
> 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json in metric-only
>    AGGR_NONE mode (-A) when evsel->pmu is a non-core hardware or hybrid
>    PMU. Software and tool events don't belong to a hardware PMU instance
>    and so are not labeled.
> 2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
>    PMU name changes, so that a line only has metrics from the PMU it is
>    labeled with.
> 3. Opening a metric line only for events that have a metric, as other
>    events print nothing in metric-only mode. This avoids spurious lines
>    like {"cpu" : "0", "pmu" : "tool"} for events like user_time, while
>    metrics on tool events, like tma_info_system_time (duration_time),
>    are still printed with the line prefix.
> 4. Updating perf_json_output_lint.py to recognize the new "pmu" key in
>    the JSON test suite.
> 
> Before the fix:
>   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
>   {"interval" : 1.001017947, "cpu" : "0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "22.5", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.2", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0"}
> 
> There is no way to determine which uncore device generated the metrics.
> 
> After:
>   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.1"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}
>   ...
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> v8:
>   - Gate "pmu" output in print_aggr_id_json() on metric-only mode and
>     skip software PMUs via perf_pmu__is_software(), keeping plain
>     `perf stat -a -A -j` unchanged and avoiding splitting default
>     metrics onto a separate "software" line. (Hang Zhengyang)
>   - Rebase onto the latest perf-tools-next.
> v7: lore.kernel.org/20261030192537.3079368-1-ctshao@google.com
>   - Pass the evsel to print_metric_begin() explicitly from all callers
>     instead of falling back to evlist__first(). (Ian)
> v6: lore.kernel.org/20261027203115.2647914-1-ctshao@google.com
>   - Open metric lines for events that have a metric instead of skipping
>     tool events, so metrics on tool events (e.g. tma_info_system_time)
>     keep the line prefix and are terminated properly. (Sashiko)
>   - Split JSON lines only when the shown PMU name changes. Tool event
>     metrics are no longer mislabeled with an uncore PMU name, and the
>     STD and CSV output are no longer split.
>   - Rebase onto the latest perf-tools-next.
> v5: lore.kernel.org/20260811230518.3360-2-ctshao@google.com
>   - Fix perf test "perf stat JSON output linter" failure.
> v4: lore.kernel.org/20260804210659.112192-1-ctshao@google.com
>   - Fix the line splitting issue, causing spurious empty {"pmu": "tool"}
>     objects and order-dependent PMU mislabeling.
> v3: lore.kernel.org/20260729170416.41904-1-ctshao@google.com
>   - Add before the fix output.
> v2: lore.kernel.org/20260715203055.2981363-1-ctshao@google.com
>   - Fix print_metric_begin() initialization in print_no_aggr_metric()
>     to ensure tool events always open lines cleanly.
> 
>  .../tests/shell/lib/perf_json_output_lint.py  |  1 +
>  tools/perf/util/stat-display.c                | 79 ++++++++++++++++---
>  2 files changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> index 8cde22ac9d97..0a16cae92766 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -65,6 +65,7 @@ def check_json_output(expected_count):
>        'metricgroup': lambda x: True,
>        'node': lambda x: True,
>        'pcnt-running': isfloat,
> +      'pmu': lambda x: True,
>        'socket': lambda x: True,
>        'thread': lambda x: True,
>        'unit': lambda x: True,
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b337cc23f413..6c9358b64b38 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1,6 +1,7 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <inttypes.h>
> +#include <string.h>
>  #include <linux/string.h>
>  #include <linux/time64.h>
>  #include <math.h>
> @@ -23,6 +24,7 @@
>  #include "pmu.h"
>  #include "pmus.h"
>  #include "tool_pmu.h"
> +#include "metricgroup.h"
>  
>  #define CNTR_NOT_SUPPORTED	"<not supported>"
>  #define CNTR_NOT_COUNTED	"<not counted>"
> @@ -361,9 +363,34 @@ static void print_aggr_id_csv(struct perf_stat_config *config,
>  	}
>  }
>  
> +/*
> + * In no-aggregation metric-only mode, JSON output includes the PMU name of
> + * non-core hardware and hybrid events so that metrics from different PMU
> + * instances, like uncore_iio_0 and uncore_iio_1, can be told apart. Software
> + * and tool events don't belong to a hardware PMU instance and so are not
> + * labeled.
> + */
> +static const char *json_pmu_name(const struct evsel *evsel)
> +{
> +	if (!evsel || !evsel->pmu || perf_pmu__is_software(evsel->pmu))
> +		return NULL;
> +	if (evsel->pmu->is_core && !evsel__is_hybrid(evsel))
> +		return NULL;
> +	return evsel->pmu->name;
> +}
> +
> +static bool json_pmu_name_changed(const char *name, const char *prev)
> +{
> +	if (!name || !prev)
> +		return name != prev;
> +	return strcmp(name, prev) != 0;
> +}
> +
>  static void print_aggr_id_json(struct perf_stat_config *config, struct outstate *os,
>  			       struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
>  {
> +	const char *pmu_name;
> +
>  	switch (config->aggr_mode) {
>  	case AGGR_CORE:
>  		json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : %d",
> @@ -397,6 +424,11 @@ static void print_aggr_id_json(struct perf_stat_config *config, struct outstate
>  			json_out(os, "\"cpu\" : \"%d\"",
>  				id.cpu.cpu);
>  		}
> +		if (config->metric_only) {
> +			pmu_name = json_pmu_name(evsel);
> +			if (pmu_name)
> +				json_out(os, "\"pmu\" : \"%s\"", pmu_name);
> +		}
>  		break;
>  	case AGGR_THREAD:
>  		json_out(os, "\"thread\" : \"%s-%d\"",
> @@ -1010,13 +1042,16 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>  		fputc('\n', output);
>  }
>  
> +/*
> + * Start a metric-only line. @evsel only provides the line prefix: the
> + * aggregation id, the PMU name in JSON (see json_pmu_name()) and the cgroup.
> + */
>  static void print_metric_begin(struct perf_stat_config *config,
> -			       struct evlist *evlist,
> +			       struct evsel *evsel,
>  			       struct outstate *os, int aggr_idx)
>  {
>  	struct perf_stat_aggr *aggr;
>  	struct aggr_cpu_id id;
> -	struct evsel *evsel;
>  
>  	os->first = true;
>  	if (!config->metric_only)
> @@ -1031,7 +1066,6 @@ static void print_metric_begin(struct perf_stat_config *config,
>  		else
>  			fprintf(config->output, "%s", os->timestamp);
>  	}
> -	evsel = evlist__first(evlist);
>  	id = config->aggr_map->map[aggr_idx];
>  	aggr = &evsel->stats->aggr[aggr_idx];
>  	aggr_printout(config, os, evsel, id, aggr->nr);
> @@ -1069,7 +1103,7 @@ static void print_aggr(struct perf_stat_config *config,
>  	 * Without each counter has its own line.
>  	 */
>  	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> -		print_metric_begin(config, evlist, os, aggr_idx);
> +		print_metric_begin(config, evlist__first(evlist), os, aggr_idx);
>  
>  		evlist__for_each_entry(evlist, counter) {
>  			print_counter_aggrdata(config, counter, aggr_idx, os);
> @@ -1095,7 +1129,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>  		os->cgrp = evsel->cgrp;
>  
>  		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> -			print_metric_begin(config, evlist, os, aggr_idx);
> +			print_metric_begin(config, evsel, os, aggr_idx);
>  
>  			evlist__for_each_entry(evlist, counter) {
>  				if (counter->cgrp != os->cgrp)
> @@ -1131,7 +1165,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  
>  	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->user_requested_cpus) {
>  		struct evsel *counter;
> -		bool first = true;
> +		const char *line_pmu = NULL;
> +		bool line_open = false;
>  
>  		evlist__for_each_entry(evlist, counter) {
>  			u64 ena, run, val;
> @@ -1146,12 +1181,32 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  				if (config->aggr_map->map[aggr_idx].cpu.cpu == cpu.cpu)
>  					break;
>  			}
> +			if (aggr_idx >= config->aggr_map->nr)
> +				continue;
>  
>  			os->evsel = counter;
>  			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> -			if (first) {
> -				print_metric_begin(config, evlist, os, aggr_idx);
> -				first = false;
> +
> +			/*
> +			 * Only events with a metric print something in metric-only
> +			 * mode, so let the first of them open the line. For JSON,
> +			 * start a new line when the PMU name changes so that all
> +			 * metrics on a line share the same "cpu" and "pmu" prefix.
> +			 */
> +			if (config->iostat_run ||
> +			    metricgroup__lookup(evlist__metric_events(evlist), counter, false)) {
> +				const char *pmu_name = json_pmu_name(counter);
> +
> +				if (line_open && config->json_output &&
> +				    json_pmu_name_changed(pmu_name, line_pmu)) {
> +					print_metric_end(config, os);
> +					line_open = false;
> +				}
> +				if (!line_open) {
> +					print_metric_begin(config, counter, os, aggr_idx);
> +					line_pmu = pmu_name;
> +					line_open = true;
> +				}
>  			}
>  			val = ps->aggr[aggr_idx].counts.val;
>  			ena = ps->aggr[aggr_idx].counts.ena;
> @@ -1160,7 +1215,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  			uval = val * counter->scale;
>  			printout(config, os, uval, run, ena, 1.0, aggr_idx);
>  		}
> -		if (!first)
> +		if (line_open)
>  			print_metric_end(config, os);
>  	}
>  }
> @@ -1523,7 +1578,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
>  				print_metric_end(config, os);
>  
>  			os->cgrp = counter->cgrp;
> -			print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
> +			print_metric_begin(config, counter, os, /*aggr_idx=*/0);
>  		}
>  
>  		print_counter(config, counter, os);
> @@ -1573,7 +1628,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>  		} else if (config->cgroup_list) {
>  			print_cgroup_counter(config, evlist, &os);
>  		} else {
> -			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
> +			print_metric_begin(config, evlist__first(evlist), &os, /*aggr_idx=*/0);
>  			evlist__for_each_entry(evlist, counter) {
>  				print_counter(config, counter, &os);
>  			}
> -- 
> 2.56.0.542.g3ef89b7020-goog
> 
