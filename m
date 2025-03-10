Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE8216392;
	Mon, 10 Mar 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601557; cv=none; b=hwtWZZiQUI0DTc2M5w504+eP+XhON4S0dI32uPlPa46J1P5gkihGdPua+bkLWCupPmzQlg9FEyS1MGUCZzGBBm0Z7cRKRRO9yIqyzQhFdNpQN5FE6vnuNr8ydwgh9IIlMuZE0qxZsf3JIM4qfL9BnpIQi5uZRV8OhSpUUHyrZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601557; c=relaxed/simple;
	bh=4itqZ0XMCX4rFZ6kG+9ByWJVoJi6K3Y7N/XugEuyjAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw0fhXbzVZopStc+kfvvNIJ5W+ncEgCw9TmBGGGoLv6/WnHBwAPPukMqKqnQkR/vbpxWD8iB82ifq8twEdn7dhJk5rBIJGmA+8ZSCZI0bY5CD57HaQmpzvTi3puGewrSldvRuMUMmScqhmfFRjk+2TI2NbT5wUgV9QltXj+/heU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06FC4153B;
	Mon, 10 Mar 2025 03:12:46 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197FD3F673;
	Mon, 10 Mar 2025 03:12:33 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:12:29 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf mem: Don't leak mem event names
Message-ID: <20250310101229.GA9682@e132581.arm.com>
References: <20250308012853.1384762-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308012853.1384762-1-irogers@google.com>

On Fri, Mar 07, 2025 at 05:28:53PM -0800, Ian Rogers wrote:
> When preparing the mem events for the argv copies are intentionally
> made. These copies are leaked and cause runs of perf using address
> sanitizer to fail. Rather than leak the memory allocate a chunk of
> memory for the mem event names upfront and build the strings in this -
> the storage is sized larger than the previous buffer size. The caller
> is then responsible for clearing up this memory. As part of this
> change, remove the mem_loads_name and mem_stores_name global buffers
> then change the perf_pmu__mem_events_name to write to an out argument
> buffer.
> 
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
> v2. Add return -ENOMEM suggested by Kan Liang.
> ---
>  tools/perf/builtin-c2c.c     |  4 ++-
>  tools/perf/builtin-mem.c     | 12 ++++---
>  tools/perf/util/mem-events.c | 67 +++++++++++++++++++++---------------
>  tools/perf/util/mem-events.h |  3 +-
>  4 files changed, 53 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 15e1fce71c72..5d5bb0f32334 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -3239,6 +3239,7 @@ static int perf_c2c__record(int argc, const char **argv)
>  {
>  	int rec_argc, i = 0, j;
>  	const char **rec_argv;
> +	char *event_name_storage = NULL;
>  	int ret;
>  	bool all_user = false, all_kernel = false;
>  	bool event_set = false;
> @@ -3300,7 +3301,7 @@ static int perf_c2c__record(int argc, const char **argv)
>  	rec_argv[i++] = "--phys-data";
>  	rec_argv[i++] = "--sample-cpu";
>  
> -	ret = perf_mem_events__record_args(rec_argv, &i);
> +	ret = perf_mem_events__record_args(rec_argv, &i, &event_name_storage);
>  	if (ret)
>  		goto out;
>  
> @@ -3327,6 +3328,7 @@ static int perf_c2c__record(int argc, const char **argv)
>  
>  	ret = cmd_record(i, rec_argv);
>  out:
> +	free(event_name_storage);
>  	free(rec_argv);
>  	return ret;
>  }
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 99d5e1491a28..5ec83cd85650 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -74,6 +74,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
>  	int rec_argc, i = 0, j;
>  	int start, end;
>  	const char **rec_argv;
> +	char *event_name_storage = NULL;
>  	int ret;
>  	struct perf_mem_event *e;
>  	struct perf_pmu *pmu;
> @@ -140,7 +141,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
>  		rec_argv[i++] = "--data-page-size";
>  
>  	start = i;
> -	ret = perf_mem_events__record_args(rec_argv, &i);
> +	ret = perf_mem_events__record_args(rec_argv, &i, &event_name_storage);
>  	if (ret)
>  		goto out;
>  	end = i;
> @@ -170,6 +171,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
>  
>  	ret = cmd_record(i, rec_argv);
>  out:
> +	free(event_name_storage);
>  	free(rec_argv);
>  	return ret;
>  }
> @@ -521,6 +523,7 @@ int cmd_mem(int argc, const char **argv)
>  		NULL,
>  		NULL
>  	};
> +	int ret;
>  
>  	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
>  					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> @@ -536,14 +539,15 @@ int cmd_mem(int argc, const char **argv)
>  	}
>  
>  	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
> -		return __cmd_record(argc, argv, &mem, record_options);
> +		ret = __cmd_record(argc, argv, &mem, record_options);
>  	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
> -		return __cmd_report(argc, argv, &mem, report_options);
> +		ret = __cmd_report(argc, argv, &mem, report_options);
>  	else
>  		usage_with_options(mem_usage, mem_options);
>  
>  	/* free usage string allocated by parse_options_subcommand */
>  	free((void *)mem_usage[0]);
> +	free(sort_order_help);
>  
> -	return 0;
> +	return ret;
>  }
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0277d3e1505c..9011784b950d 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -31,9 +31,6 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>  
>  bool perf_mem_record[PERF_MEM_EVENTS__MAX] = { 0 };
>  
> -static char mem_loads_name[100];
> -static char mem_stores_name[100];
> -
>  struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
>  {
>  	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
> @@ -81,7 +78,8 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu)
>  	return num;
>  }
>  
> -static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
> +static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
> +					     char *buf, size_t buf_size)
>  {
>  	struct perf_mem_event *e;
>  
> @@ -96,31 +94,31 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
>  		if (e->ldlat) {
>  			if (!e->aux_event) {
>  				/* ARM and Most of Intel */
> -				scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +				scnprintf(buf, buf_size,
>  					  e->name, pmu->name,
>  					  perf_mem_events__loads_ldlat);
>  			} else {
>  				/* Intel with mem-loads-aux event */
> -				scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +				scnprintf(buf, buf_size,
>  					  e->name, pmu->name, pmu->name,
>  					  perf_mem_events__loads_ldlat);
>  			}
>  		} else {
>  			if (!e->aux_event) {
>  				/* AMD and POWER */
> -				scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +				scnprintf(buf, buf_size,
>  					  e->name, pmu->name);
> -			} else
> +			} else {
>  				return NULL;
> +			}
>  		}
> -
> -		return mem_loads_name;
> +		return buf;
>  	}
>  
>  	if (i == PERF_MEM_EVENTS__STORE) {
> -		scnprintf(mem_stores_name, sizeof(mem_stores_name),
> +		scnprintf(buf, buf_size,
>  			  e->name, pmu->name);
> -		return mem_stores_name;
> +		return buf;
>  	}
>  
>  	return NULL;
> @@ -238,55 +236,69 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu)
>  	int j;
>  
>  	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> +		char buf[128];
>  		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
>  
>  		fprintf(stderr, "%-*s%-*s%s",
>  			e->tag ? 13 : 0,
>  			e->tag ? : "",
>  			e->tag && verbose > 0 ? 25 : 0,
> -			e->tag && verbose > 0 ? perf_pmu__mem_events_name(j, pmu) : "",
> +			e->tag && verbose > 0
> +			? perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf))
> +			: "",
>  			e->supported ? ": available\n" : "");
>  	}
>  }
>  
> -int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr, char **event_name_storage_out)
>  {
>  	const char *mnt = sysfs__mount();
>  	struct perf_pmu *pmu = NULL;
> -	struct perf_mem_event *e;
>  	int i = *argv_nr;
> -	const char *s;
> -	char *copy;
>  	struct perf_cpu_map *cpu_map = NULL;
> -	int ret;
> +	size_t event_name_storage_size =
> +		perf_pmu__mem_events_num_mem_pmus(NULL) * PERF_MEM_EVENTS__MAX * 128;
> +	size_t event_name_storage_remaining = event_name_storage_size;
> +	char *event_name_storage = malloc(event_name_storage_size);
> +	char *event_name_storage_ptr = event_name_storage;
> +
> +	if (!event_name_storage)
> +		return -ENOMEM;
>  
> +	*event_name_storage_out = NULL;
>  	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
>  		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -			e = perf_pmu__mem_events_ptr(pmu, j);
> +			const char *s;
> +			struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
> +			int ret;
>  
>  			if (!perf_mem_record[j])
>  				continue;
>  
>  			if (!e->supported) {
> +				char buf[128];
> +
>  				pr_err("failed: event '%s' not supported\n",
> -					perf_pmu__mem_events_name(j, pmu));
> +					perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf)));
> +				free(event_name_storage);
>  				return -1;
>  			}
>  
> -			s = perf_pmu__mem_events_name(j, pmu);
> +			s = perf_pmu__mem_events_name(pmu, j, event_name_storage_ptr,
> +						      event_name_storage_remaining);
>  			if (!s || !perf_pmu__mem_events_supported(mnt, pmu, e))
>  				continue;
>  
> -			copy = strdup(s);
> -			if (!copy)
> -				return -1;
> -
>  			rec_argv[i++] = "-e";
> -			rec_argv[i++] = copy;
> +			rec_argv[i++] = event_name_storage_ptr;
> +			event_name_storage_remaining -= strlen(event_name_storage_ptr) + 1;
> +			event_name_storage_ptr += strlen(event_name_storage_ptr) + 1;
>  
>  			ret = perf_cpu_map__merge(&cpu_map, pmu->cpus);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				free(event_name_storage);
>  				return ret;
> +			}
>  		}
>  	}
>  
> @@ -301,6 +313,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
>  	}
>  
>  	*argv_nr = i;
> +	*event_name_storage_out = event_name_storage;
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 8dc27db9fd52..a5c19d39ee37 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -38,7 +38,8 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu);
>  bool is_mem_loads_aux_event(struct evsel *leader);
>  
>  void perf_pmu__mem_events_list(struct perf_pmu *pmu);
> -int perf_mem_events__record_args(const char **rec_argv, int *argv_nr);
> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> +				 char **event_name_storage_out);
>  
>  int perf_mem__tlb_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
>  int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 
