Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726325D54E;
	Thu,  6 Mar 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287198; cv=none; b=r/rFYvFBuKnOqWwuZcycTTnZRRbgntdalvIUOtNsYvpRjCFG0gihMe/vWCqXQz/6fzTmH340dNCyDlC3nfKFSbVJUNy589CV4K1QmLAescTO6a+o0bVXcbGqKNKGzKv6RSMT01ie261bsHzPbppvJTG6D71tgD3xR5BX+0T9h/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287198; c=relaxed/simple;
	bh=HdDCCx5gwVucxugrX/FKfQDpJMt6R/cht/U/5Z0AgDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fQRumhR62bsHye+N6MmtKqh9EnJyZ9QaeVhwpRiQiLZwLfD2MDAtXcQWHiE6w15TugGP3pMaIkkGO7t91yjBXYiPhz0d0uBs51zlr+VNE1AGl9pVsOFnkqrQGxNDPm9+uRN41jwhUSou10R1Aw5fUANTORWPphB+axYBlpusx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNrsniVJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNrsniVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741287196; x=1772823196;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=HdDCCx5gwVucxugrX/FKfQDpJMt6R/cht/U/5Z0AgDU=;
  b=GNrsniVJvW8hUJZICZSZovEZRs92259dkg4bZAP5BxEebpb5EjFuK1US
   zBTfIPXWiTZ8TVBwbNjegIRWLf/A8sQuqA0YRWKz/x9mpi3rflnMt5Itl
   fRVwf+IDEqLLFQUXCyBupdtO9l9o5N9AUW5uS/HyP894PJyRLci9Oy3lx
   7lJk87ccP2yvP8GR98F23IeL0L/NJedTwzklXMfiB1sqWtTSgV6LLck+I
   t9XMVrk0a6Nx/etFlhd6yWdt46QYAV3JbScoasQC/3otJ+BXUYHUg9ZfW
   6f7JV96DkI7Aj9wOdHwW70aXWY5xxMtlRTOY3O6mtnM73PyIpCylb72LK
   g==;
X-CSE-ConnectionGUID: /tXZMGn5Q4WbADxAsYHLZw==
X-CSE-MsgGUID: j8K8lxGDTm6OE8lRr9PvXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42175617"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42175617"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:53:14 -0800
X-CSE-ConnectionGUID: uHLTloLSSCOx0kjPCcuqSw==
X-CSE-MsgGUID: q/Ub8q8hSsWlB9RyybGltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119116316"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:53:13 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7311120B5736;
	Thu,  6 Mar 2025 10:53:12 -0800 (PST)
Message-ID: <2213a8a8-cc3b-4135-90a4-7f9455375825@linux.intel.com>
Date: Thu, 6 Mar 2025 13:53:11 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf mem: Don't leak mem event names
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, Thomas Falcon <thomas.falcon@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306175408.852130-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250306175408.852130-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-06 12:54 p.m., Ian Rogers wrote:
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
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-c2c.c     |  4 ++-
>  tools/perf/builtin-mem.c     | 12 ++++---
>  tools/perf/util/mem-events.c | 64 +++++++++++++++++++++---------------
>  tools/perf/util/mem-events.h |  3 +-
>  4 files changed, 50 insertions(+), 33 deletions(-)
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
> index 0277d3e1505c..1d18a5015eea 100644
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
> @@ -238,55 +236,66 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu)
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

if (!event_name_storage)
	return -ENOMEM

Others look good to me.

Thanks,
Kan

> +	char *event_name_storage_ptr = event_name_storage;
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
> @@ -301,6 +310,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
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

