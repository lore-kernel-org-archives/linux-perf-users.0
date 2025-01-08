Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4119DFA7;
	Wed,  8 Jan 2025 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365889; cv=none; b=jO7ABoPLx1B0HDi9QliBtC03U0UKahpEDUkOh+815V47faQI1kWBcUeJBHdT8pHlA1BMcKGxH5jQW0ET56vtccwwqtpA9kVy2UnUlJlg0zvK3o9SAmM9iJ5sTwiTVg69OHNbSdgefcmj9r7qj5dyeYQp6rc4V9Kl1JHx0y8GBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365889; c=relaxed/simple;
	bh=maLCHuSEp6vhEkt4c/aOJ5OesGrXWRyHTPH+1tuHjVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX32wLnXeHUvR0Y1fjzFIrcQXi5vLgJH5SSFApGw7dW81H7WDYyBKrDpLXd+5fZLiRH68ti/1Fy2BtTYXoDElfo5xzzuIvpPtQdozrMyQouUwJUwUfuHFPlxhVVQE+Nzam8BXx/+DZpTZwDQeMGTKp+skMkgJaJ7Ud6pVgWytqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVSp0SEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVSp0SEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA34C4CED3;
	Wed,  8 Jan 2025 19:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365887;
	bh=maLCHuSEp6vhEkt4c/aOJ5OesGrXWRyHTPH+1tuHjVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVSp0SEosF0UBJeMsBgkkZUstn8yZLU10bwgmVZlx1BtN+90nqAI6AbM0Yh7Zb9Q7
	 cdWE90YfT4aTMCkdRWahFG+dHYQ+se8fl2a/4VT65arDQzGHWWQAcxaV0AQhNyEy1M
	 pHQh2L2j03EDgjsyK4xLN03EYbU57F+IQEsMeXkp1Y8MH39PvuGGMBFrv9c5qPJN1c
	 ITmFOInJ7tQfqnJrzMrHEw+mA7r//sQ3KQ0FyvTNPVpkHqM9rA2nOSoShCxxTEb8p+
	 yQ0jMgFGCiAQ1XuLWD5zIS+lEJzsZsQV+zkMs+6Tht/ocQN3sLBhyU7DXULUORC5or
	 l6KE9To2PajBA==
Date: Wed, 8 Jan 2025 11:51:25 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
Message-ID: <Z37XPa2J9uus3FDD@google.com>
References: <20250108053428.1724490-1-irogers@google.com>
 <20250108053428.1724490-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108053428.1724490-5-irogers@google.com>

On Tue, Jan 07, 2025 at 09:34:28PM -0800, Ian Rogers wrote:
> The -C option allows the CPUs for a list of events to be specified but
> its not possible to set the CPU for a single event. Add a term to
> allow this. The term isn't a general CPU list due to ',' already being
> a special character in event parsing instead multiple cpu= terms may
> be provided and they will be merged/unioned together.

It'd be nice if you could add a description why it's needed and/or some
use cases.  I'm afraid it'd make the CPU map handling more complicated.

Thanks,
Namhyung

> 
> An example of mixing different types of events counted on different CPUs:
> ```
> $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1
> 
>  Performance counter stats for 'system wide':
> 
> CPU0            6,979,225      instructions/cpu=0/              #    0.89  insn per cycle
> CPU4               75,138      cpu/l1d-misses/
> CPU5            1,418,939      cpu/l1d-misses/
> CPU8              797,553      cpu/inst_retired.any,cpu=8/
> CPU0            7,845,302      cycles
> CPU4            6,546,859      cycles
> CPU5          185,915,438      cycles
> CPU8            2,065,668      cycles
> 
>        0.112449242 seconds time elapsed
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-list.txt |  9 +++
>  tools/perf/util/evsel_config.h         |  1 +
>  tools/perf/util/parse-events.c         | 76 +++++++++++++++++++++-----
>  tools/perf/util/parse-events.h         |  3 +-
>  tools/perf/util/parse-events.l         |  1 +
>  tools/perf/util/pmu.c                  |  3 +-
>  6 files changed, 76 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index d0c65fad419a..d98de9adc515 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -289,6 +289,15 @@ Sums up the event counts for all hardware threads in a core, e.g.:
>  
>    perf stat -e cpu/event=0,umask=0x3,percore=1/
>  
> +cpu:
> +
> +Specifies the CPU to open the event upon. The value may be repeated to
> +specify opening the event on multiple CPUs:
> +
> +
> +  perf stat -e instructions/cpu=0,cpu=2/,cycles/cpu=1,cpu=2/ -a sleep 1
> +  perf stat -e data_read/cpu=0/,data_write/cpu=1/ -a sleep 1
> +
>  
>  EVENT GROUPS
>  ------------
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index af52a1516d0b..94a1e9cf73d6 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -48,6 +48,7 @@ struct evsel_config_term {
>  		u32	      aux_sample_size;
>  		u64	      cfg_chg;
>  		char	      *str;
> +		int	      cpu;
>  	} val;
>  	bool weak;
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 4bda4141e9e7..ec8429f0cf6d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -7,6 +7,7 @@
>  #include <errno.h>
>  #include <sys/ioctl.h>
>  #include <sys/param.h>
> +#include "cpumap.h"
>  #include "term.h"
>  #include "env.h"
>  #include "evlist.h"
> @@ -178,6 +179,26 @@ static char *get_config_name(const struct parse_events_terms *head_terms)
>  	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
>  }
>  
> +static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head_terms)
> +{
> +	struct parse_events_term *term;
> +	struct perf_cpu_map *cpus = NULL;
> +
> +	if (!head_terms)
> +		return NULL;
> +
> +	list_for_each_entry(term, &head_terms->terms, list) {
> +		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
> +			struct perf_cpu_map *cpu = perf_cpu_map__new_int(term->val.num);
> +
> +			perf_cpu_map__merge(&cpus, cpu);
> +			perf_cpu_map__put(cpu);
> +		}
> +	}
> +
> +	return cpus;
> +}
> +
>  /**
>   * fix_raw - For each raw term see if there is an event (aka alias) in pmu that
>   *           matches the raw's string value. If the string value matches an
> @@ -441,11 +462,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>  	bool found_supported = false;
>  	const char *config_name = get_config_name(parsed_terms);
>  	const char *metric_id = get_config_metric_id(parsed_terms);
> +	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms);
> +	int ret = 0;
>  
>  	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>  		LIST_HEAD(config_terms);
>  		struct perf_event_attr attr;
> -		int ret;
>  
>  		if (parse_events__filter_pmu(parse_state, pmu))
>  			continue;
> @@ -460,7 +482,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>  						   perf_pmu__auto_merge_stats(pmu),
>  						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
>  			if (ret)
> -				return ret;
> +				goto out_err;
>  			continue;
>  		}
>  
> @@ -480,21 +502,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>  
>  		if (parsed_terms) {
>  			if (config_attr(&attr, parsed_terms, parse_state->error,
> -					config_term_common))
> -				return -EINVAL;
> -
> -			if (get_config_terms(parsed_terms, &config_terms))
> -				return -ENOMEM;
> +					config_term_common)) {
> +				ret = -EINVAL;
> +				goto out_err;
> +			}
> +			if (get_config_terms(parsed_terms, &config_terms)) {
> +				ret = -ENOMEM;
> +				goto out_err;
> +			}
>  		}
>  
>  		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
>  				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
> -				/*cpu_list=*/NULL,
> -				/*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
> -			return -ENOMEM;
> +				cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
> +			ret = -ENOMEM;
>  
>  		free_config_terms(&config_terms);
> +		if (ret)
> +			goto out_err;
>  	}
> +out_err:
> +	perf_cpu_map__put(cpus);
>  	return found_supported ? 0 : -EINVAL;
>  }
>  
> @@ -808,6 +836,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
>  		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
>  		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
>  		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
> +		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
>  	};
>  	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
>  		return "unknown term";
> @@ -837,6 +866,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
>  	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
>  	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>  	case PARSE_EVENTS__TERM_TYPE_PERCORE:
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
>  		return true;
>  	case PARSE_EVENTS__TERM_TYPE_USER:
>  	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> @@ -984,6 +1014,15 @@ do {									   \
>  			return -EINVAL;
>  		}
>  		break;
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
> +		CHECK_TYPE_VAL(NUM);
> +		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
> +			parse_events_error__handle(err, term->err_val,
> +						strdup("too big"),
> +						NULL);
> +			return -EINVAL;
> +		}
> +		break;
>  	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>  	case PARSE_EVENTS__TERM_TYPE_USER:
>  	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> @@ -1111,6 +1150,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
>  	case PARSE_EVENTS__TERM_TYPE_RAW:
>  	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
>  	default:
>  		if (err) {
>  			parse_events_error__handle(err, term->err_term,
> @@ -1245,6 +1285,7 @@ do {								\
>  		case PARSE_EVENTS__TERM_TYPE_RAW:
>  		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +		case PARSE_EVENTS__TERM_TYPE_CPU:
>  		default:
>  			break;
>  		}
> @@ -1299,6 +1340,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
>  		case PARSE_EVENTS__TERM_TYPE_RAW:
>  		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +		case PARSE_EVENTS__TERM_TYPE_CPU:
>  		default:
>  			break;
>  		}
> @@ -1343,6 +1385,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>  	struct perf_event_attr attr;
>  	LIST_HEAD(config_terms);
>  	const char *name, *metric_id;
> +	struct perf_cpu_map *cpus;
>  	int ret;
>  
>  	memset(&attr, 0, sizeof(attr));
> @@ -1364,10 +1407,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>  
>  	name = get_config_name(head_config);
>  	metric_id = get_config_metric_id(head_config);
> +	cpus = get_config_cpu(head_config);
>  	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
> -			  metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
> -			  /*cpu_list=*/NULL, /*alternate_hw_config=*/PERF_COUNT_HW_MAX
> -		) == NULL ? -ENOMEM : 0;
> +			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
> +			cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) ? 0 : -ENOMEM;
> +	perf_cpu_map__put(cpus);
>  	free_config_terms(&config_terms);
>  	return ret;
>  }
> @@ -1427,6 +1471,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	LIST_HEAD(config_terms);
>  	struct parse_events_terms parsed_terms;
>  	bool alias_rewrote_terms = false;
> +	struct perf_cpu_map *term_cpu = NULL;
>  
>  	if (verbose > 1) {
>  		struct strbuf sb;
> @@ -1521,11 +1566,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		return -EINVAL;
>  	}
>  
> +	term_cpu = get_config_cpu(&parsed_terms);
>  	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
>  			    get_config_name(&parsed_terms),
>  			    get_config_metric_id(&parsed_terms), pmu,
> -			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
> -			    alternate_hw_config);
> +			    &config_terms, auto_merge_stats, term_cpu, alternate_hw_config);
> +	perf_cpu_map__put(term_cpu);
>  	if (!evsel) {
>  		parse_events_terms__exit(&parsed_terms);
>  		return -ENOMEM;
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index e176a34ab088..ab242f671031 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -80,7 +80,8 @@ enum parse_events__term_type {
>  	PARSE_EVENTS__TERM_TYPE_RAW,
>  	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
>  	PARSE_EVENTS__TERM_TYPE_HARDWARE,
> -#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
> +	PARSE_EVENTS__TERM_TYPE_CPU,
> +#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
>  };
>  
>  struct parse_events_term {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index bf7f73548605..14bff6f9731c 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -324,6 +324,7 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
>  aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
>  aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
>  metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
> +cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
>  cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
>  stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
>  stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6206c8fe2bf9..cffb4eb2696b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1400,7 +1400,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
>  			return -EINVAL;
> -		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
>  			/* Skip non-config terms. */
>  			break;
>  		default:
> @@ -1775,6 +1775,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
>  		"aux-output",
>  		"aux-action=(pause|resume|start-paused)",
>  		"aux-sample-size=number",
> +		"cpu=number",
>  	};
>  	struct perf_pmu_format *format;
>  	int ret;
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
