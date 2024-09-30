Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B6186E56;
	Mon, 30 Sep 2024 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732545; cv=none; b=fP5cWsKWgrrs3iy6nLiaPYlbOS8O0wmJvqmO/tNbCnI+48KwAs9LhuLRLKId5G8dG9FOJDpouCbXFBr9EsCtwKhSrt+qeAGU/lIv2PuV3LiQ7L1CkgxNCiw6fctVjzbmSfHqe2JWGQHuwcLdCyowtV9rYSRYLOeq99rNA0AF6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732545; c=relaxed/simple;
	bh=XRk3YPKu+egClHpxdgHIQq49OJgc8UqkVWGIz2lFp6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE5/TyPmpn6W04dkPGJ60y0RwrYrXiGHX6KhW1YJxzBZgAK97ZICNyND0R6bgqSkFgbZ2fNfl8gGJn9I7N2M/bPT5fEmUHjErK4ZKNq1gIWD1LJcWWRp1teVwIS2gMPKjApDEiIhLo+h17t9HyEqi4ZfTfZs0LiWQPECAJxUaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGYvnGT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGYvnGT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC3EC4CEC7;
	Mon, 30 Sep 2024 21:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732545;
	bh=XRk3YPKu+egClHpxdgHIQq49OJgc8UqkVWGIz2lFp6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGYvnGT8qY4QdPR35WGgrRjOJeXyjmrC17z9Z6cVGIe+XEDfN260oe8Vb+binuD6A
	 w7oqcnwvyChXfky+Pid6Rpu71V9gZq4Fe+BrF9DeTx9+9tCPktNlJKGO6CFFQ7RfCx
	 6dwNMLyDPR1haab1i7BqrczoHu/WhaPxQ0U89VPVKcUZDUVUCeExXd3YYPF4+uiIgx
	 x4awbt1ng3y+8LeB8OuRVANcYpWoauXRYw5huPOj4XHlWMeUuOIJSrf631vwJpZzMe
	 ztTvAyDUkBsopxrlakA54vVpEFpY4SnzAwBzayJxeB79cIRYPv8GUbbAqA0wCAXzoD
	 wlgidL1ze3yeA==
Date: Mon, 30 Sep 2024 14:42:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
Message-ID: <ZvsbP2ex-wIlJaqk@google.com>
References: <20240918220133.102964-1-irogers@google.com>
 <20240918220133.102964-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240918220133.102964-4-irogers@google.com>

On Thu, Sep 19, 2024 at 12:01:33AM +0200, Ian Rogers wrote:
> The -C option allows the CPUs for a list of events to be specified but
> its not possible to set the CPU for a single event. Add a term to
> allow this. The term isn't a general CPU list due to ',' already being
> a special character in event parsing instead multiple cpu= terms may
> be provided and they will be merged/unioned together.
> 
> An example of mixing different types of events counted on different CPUs:
> ```
> $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1
> 
>  Performance counter stats for 'system wide':
> 
> CPU0              368,647      instructions/cpu=0/              #    0.26  insn per cycle
> CPU4        <not counted>      instructions/cpu=0/
> CPU5        <not counted>      instructions/cpu=0/
> CPU8        <not counted>      instructions/cpu=0/

I think this should have an entry for CPU0 only.  IOW the cpu parameter
in the event specification has a higher priority than -C option.

Thanks,
Namhyung


> CPU0        <not counted>      l1d-misses [cpu]
> CPU4              203,377      l1d-misses [cpu]
> CPU5              138,231      l1d-misses [cpu]
> CPU8        <not counted>      l1d-misses [cpu]
> CPU0        <not counted>      cpu/cpu=8/
> CPU4        <not counted>      cpu/cpu=8/
> CPU5        <not counted>      cpu/cpu=8/
> CPU8              943,861      cpu/cpu=8/
> CPU0            1,412,071      cycles
> CPU4           20,362,900      cycles
> CPU5           10,172,725      cycles
> CPU8            2,406,081      cycles
> 
>        0.102925309 seconds time elapsed
> ```
> 
> Note, the event name of inst_retired.any is missing, reported as
> cpu/cpu=8/, as there are unmerged uniquify fixes:
> https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-list.txt |  9 ++++
>  tools/perf/util/evsel_config.h         |  1 +
>  tools/perf/util/parse-events.c         | 71 ++++++++++++++++++++++----
>  tools/perf/util/parse-events.h         |  3 +-
>  tools/perf/util/parse-events.l         |  1 +
>  tools/perf/util/pmu.c                  |  1 +
>  6 files changed, 74 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index dea005410ec0..e0cd9bb8283e 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -274,6 +274,15 @@ Sums up the event counts for all hardware threads in a core, e.g.:
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
> index aee6f808b512..9630c4a24721 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -47,6 +47,7 @@ struct evsel_config_term {
>  		u32	      aux_sample_size;
>  		u64	      cfg_chg;
>  		char	      *str;
> +		int	      cpu;
>  	} val;
>  	bool weak;
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 017d31d51ea4..63c31cfdd79b 100644
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
> +			cpus = perf_cpu_map__merge(cpus, cpu);
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
> @@ -469,11 +490,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
> @@ -487,7 +509,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>  						   parsed_terms,
>  						   perf_pmu__auto_merge_stats(pmu));
>  			if (ret)
> -				return ret;
> +				goto out_err;
>  			continue;
>  		}
>  
> @@ -507,20 +529,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
> -				/*cpu_list=*/NULL) == NULL)
> -			return -ENOMEM;
> +				cpus) == NULL)
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
> @@ -835,6 +864,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
>  		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
>  		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
>  		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
> +		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
>  	};
>  	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
>  		return "unknown term";
> @@ -864,6 +894,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
>  	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
>  	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>  	case PARSE_EVENTS__TERM_TYPE_PERCORE:
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
>  		return true;
>  	case PARSE_EVENTS__TERM_TYPE_USER:
>  	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> @@ -1007,6 +1038,15 @@ do {									   \
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
> @@ -1133,6 +1173,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
>  	case PARSE_EVENTS__TERM_TYPE_RAW:
>  	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
>  	default:
>  		if (err) {
>  			parse_events_error__handle(err, term->err_term,
> @@ -1264,6 +1305,7 @@ do {								\
>  		case PARSE_EVENTS__TERM_TYPE_RAW:
>  		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +		case PARSE_EVENTS__TERM_TYPE_CPU:
>  		default:
>  			break;
>  		}
> @@ -1317,6 +1359,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
>  		case PARSE_EVENTS__TERM_TYPE_RAW:
>  		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>  		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +		case PARSE_EVENTS__TERM_TYPE_CPU:
>  		default:
>  			break;
>  		}
> @@ -1371,6 +1414,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>  	struct perf_event_attr attr;
>  	LIST_HEAD(config_terms);
>  	const char *name, *metric_id;
> +	struct perf_cpu_map *cpus;
>  	int ret;
>  
>  	memset(&attr, 0, sizeof(attr));
> @@ -1392,9 +1436,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>  
>  	name = get_config_name(head_config);
>  	metric_id = get_config_metric_id(head_config);
> +	cpus = get_config_cpu(head_config);
>  	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
>  			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
> -			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
> +			cpus) ? 0 : -ENOMEM;
> +	perf_cpu_map__put(cpus);
>  	free_config_terms(&config_terms);
>  	return ret;
>  }
> @@ -1461,6 +1507,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	LIST_HEAD(config_terms);
>  	struct parse_events_terms parsed_terms;
>  	bool alias_rewrote_terms = false;
> +	struct perf_cpu_map *term_cpu = NULL;
>  
>  	if (verbose > 1) {
>  		struct strbuf sb;
> @@ -1552,10 +1599,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		return -EINVAL;
>  	}
>  
> +	term_cpu = get_config_cpu(&parsed_terms);
>  	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
>  			    get_config_name(&parsed_terms),
>  			    get_config_metric_id(&parsed_terms), pmu,
> -			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
> +			    &config_terms, auto_merge_stats, term_cpu);
> +	perf_cpu_map__put(term_cpu);
>  	if (!evsel) {
>  		parse_events_terms__exit(&parsed_terms);
>  		return -ENOMEM;
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 10cc9c433116..2532c81d4f9a 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -79,7 +79,8 @@ enum parse_events__term_type {
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
> index 5a0bcd7f166a..635d216632d7 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -331,6 +331,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
>  aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
>  aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
>  metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
> +cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
>  cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
>  stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
>  stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 61bdda01a05a..4f68026a97bb 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1738,6 +1738,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
>  		"percore",
>  		"aux-output",
>  		"aux-sample-size=number",
> +		"cpu=number",
>  	};
>  	struct perf_pmu_format *format;
>  	int ret;
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 
