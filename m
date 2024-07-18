Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D429140394
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311807; cv=none; b=PD+XR25asytO++XEdZOPpjNZSjQMagKkwpz8V7ombBtUxpbFFWpAWj3lKNwViDG84MZ4bx76/9gRofZA1xcTVUY4NnCi2RMRK90bHL84W54D3cnx+CkIATPQjlpO2Jr+yQG+fsKYXvDaahkeWD4T6hIF9toYHt1oBU+dT9/VMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311807; c=relaxed/simple;
	bh=/5hrE0Byw7TGuPGa152e1g2S14Kjq8AQeciBSPWzoB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=sR9EW7FvkfGQY/YmTwCdCOykV6IepHGZq19sWJ637c5frBfvWGT9Q6pTqnwRshFUyJa2Bl0y1ya3spWsWSgkY28apSedPpuX266YnJlinXtmsCw6q0TlqFLkTRvIvWOQ/fBN9Bpii0NBz8lagF39J94ctTPQZx6w3SNTjDfHKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UsNxqHSi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsNxqHSi"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso653089e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721311803; x=1721916603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smElxFhoKDzB9xwKqiAX5sqsOje3rKpyiXuv97FwRUQ=;
        b=UsNxqHSiZBgHdtAdyH9EhjjRjD1lfOOjp+l0EcVJRHXJ/ZPSnepHDrlFM4bq9LdGZ/
         6xxp2QL1Va2oh3gZbDrPYSF4Ca73nH4QijkRI/IoqDZapVcXdl7Fvt2yFrWrErTqru/V
         +LvGopsj8m8V+sKqVBPiXzzGzKrG51Oa1PA8hBpYtzzSVj8QdqDKPp6C269b8LtLy5kW
         yuOQjcjqfrf/e0WrmILyeJdzDYg4Jh7qdmPx7QVWtXVsEfNwwM4+u1LLHewgBTZ4uq+7
         N+hWg2e6HVGsZeHu6o7uIMwAvrSAnVK1xkj9ceD5FOWwJYvumHe3h6g0LIBMtw8/yxLp
         dPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311803; x=1721916603;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smElxFhoKDzB9xwKqiAX5sqsOje3rKpyiXuv97FwRUQ=;
        b=KsBTaNszB265sPPMPJAEKL1l2JqtyQ/9tJNbIu+4rZ4d0Lt+fBuJgjjhKGHzkjFVwl
         nEBGdMhue2N/0H5d5xZc8XwV0/bDXMP0QA3mktZZt7zwun9MQ4Cq2mvlVZ1yKJFB2q7l
         fsgaKs7gTikSB0icXjnBpyWgvOKt/V7iucBtZLNvQCdZI14Ya0yphYTZIm775b+69z9h
         cIjBz0GrTYk/Ht80AfhXEfEMYLl1LY7xfxN1xV6bOIWMVafMAQLDtyuPX0YuZ7tEoia4
         VkqWuShVGt6FutpIoTE4ZUD5Sf4WfBSBsd00GQysvE+mAZpOJlfrplwtOZ+Nf+IN6ueM
         Q6/w==
X-Forwarded-Encrypted: i=1; AJvYcCUE2Req+fw51N7/tTRCQmgCUAxCKObU7lzftSYuhrl+wqHkZEXr9wN8PuWxKcd5kThf/0X5l0lHoK0qZVyD+CNj438CEzGw3Y7wHruWRFO2Lw==
X-Gm-Message-State: AOJu0YwnNvsqC5kkrpxAddUUGbvRzoLkJigMANfqbdupJdCSiLbXS/Zh
	DXOJPQxKMSzm76YTJ4Ss+RLk+BS9qLy41Nf40CMtAQ/zjY3W1xHtXtMFnRwwsCk=
X-Google-Smtp-Source: AGHT+IGYQDHmYfX7fOblli3G7W6YHnaFxirSo7MecCrWZRdvAJ+b2ELkMOke4I0Q0d1CoPriZuHptQ==
X-Received: by 2002:a05:6512:1082:b0:52c:df77:6507 with SMTP id 2adb3069b0e04-52ee53cc016mr4038439e87.37.1721311803024;
        Thu, 18 Jul 2024 07:10:03 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef0773d17sm105031e87.197.2024.07.18.07.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:10:02 -0700 (PDT)
Message-ID: <ecca73c3-3260-4e95-b9d6-6f6875258fb9@linaro.org>
Date: Thu, 18 Jul 2024 15:09:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
To: Ian Rogers <irogers@google.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-7-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240718003025.1486232-7-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/07/2024 1:30 am, Ian Rogers wrote:
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

I ran into cpu=N having no effect unless -C is also used. For example:

  $ perf stat -vv -e branch-misses/cpu=1/ -- true

  sys_perf_event_open: pid 10233  cpu -1  group_fd -1  flags 0x8 = 3

Vs:

  $ perf stat -C 0,1 -vv -e branch-misses/cpu=1/ -- true

  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 3

Is it possible to have a warning or error in that case? Seems like it's 
quite likely to confuse a user.

Other than that it seems to work ok.

WRT the RAPL issue [1], I didn't quite follow how these two things will 
join up. Doesn't this only end up setting the cpu argument to 
perf_event_open(), which already aggregates per package rather than per 
core, even if the cpu is set? And the fix for that behavior was rejected 
because it would break Intel metrics [2].

Maybe I'm missing a piece.

[1]: 
https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
[2]: 
https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/

James

>   Performance counter stats for 'system wide':
> 
> CPU0              368,647      instructions/cpu=0/              #    0.26  insn per cycle
> CPU4        <not counted>      instructions/cpu=0/
> CPU5        <not counted>      instructions/cpu=0/
> CPU8        <not counted>      instructions/cpu=0/
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
>         0.102925309 seconds time elapsed
> ```
> 
> Note, the event name of inst_retired.any is missing, reported as
> cpu/cpu=8/, as there are unmerged uniquify fixes:
> https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.com/
> 
> An example of spreading uncore overhead across two CPUs:
> ```
> $ perf stat -A -e "data_read/cpu=0/,data_write/cpu=1/" -a sleep 0.1
> 
>   Performance counter stats for 'system wide':
> 
> CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=0/
> CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=0/
> CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=1/
> CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=1/
> CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=1/
> CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=1/
> ```
> 
> Manually fixing the output it should be:
> ```
> CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cpu=0/
> CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cpu=0/
> CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,cpu=1/
> CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,cpu=1/
> ```
> 
> That is data_read from 2 PMUs was counted on CPU0 and data_write was
> counted on CPU1.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/Documentation/perf-list.txt |  9 ++++
>   tools/perf/util/evsel_config.h         |  1 +
>   tools/perf/util/parse-events.c         | 73 ++++++++++++++++++++++----
>   tools/perf/util/parse-events.h         |  3 +-
>   tools/perf/util/parse-events.l         |  1 +
>   tools/perf/util/pmu.c                  |  1 +
>   6 files changed, 77 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 6bf2468f59d3..15511afe94a1 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -273,6 +273,15 @@ Sums up the event counts for all hardware threads in a core, e.g.:
>   
>     perf stat -e cpu/event=0,umask=0x3,percore=1/
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
>   EVENT GROUPS
>   ------------
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index aee6f808b512..9630c4a24721 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -47,6 +47,7 @@ struct evsel_config_term {
>   		u32	      aux_sample_size;
>   		u64	      cfg_chg;
>   		char	      *str;
> +		int	      cpu;
>   	} val;
>   	bool weak;
>   };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 8c0c33361c5e..85faef85b8de 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -7,6 +7,7 @@
>   #include <errno.h>
>   #include <sys/ioctl.h>
>   #include <sys/param.h>
> +#include "cpumap.h"
>   #include "term.h"
>   #include "evlist.h"
>   #include "evsel.h"
> @@ -177,6 +178,26 @@ static char *get_config_name(const struct parse_events_terms *head_terms)
>   	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
>   }
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
>   /**
>    * fix_raw - For each raw term see if there is an event (aka alias) in pmu that
>    *           matches the raw's string value. If the string value matches an
> @@ -468,11 +489,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>   	bool found_supported = false;
>   	const char *config_name = get_config_name(parsed_terms);
>   	const char *metric_id = get_config_metric_id(parsed_terms);
> +	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms);
> +	int ret = 0;
>   
>   	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>   		LIST_HEAD(config_terms);
>   		struct perf_event_attr attr;
> -		int ret;
>   
>   		if (parse_events__filter_pmu(parse_state, pmu))
>   			continue;
> @@ -486,7 +508,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>   						   parsed_terms,
>   						   perf_pmu__auto_merge_stats(pmu));
>   			if (ret)
> -				return ret;
> +				goto out_err;
>   			continue;
>   		}
>   
> @@ -506,20 +528,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>   
>   		if (parsed_terms) {
>   			if (config_attr(&attr, parsed_terms, parse_state->error,
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
>   		}
>   
>   		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
>   				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
> -				/*cpu_list=*/NULL) == NULL)
> -			return -ENOMEM;
> +				cpus) == NULL)
> +			ret = -ENOMEM;
>   
>   		free_config_terms(&config_terms);
> +		if (ret)
> +			goto out_err;
>   	}
> +out_err:
> +	perf_cpu_map__put(cpus);
>   	return found_supported ? 0 : -EINVAL;
>   }
>   
> @@ -814,6 +843,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
>   		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
>   		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
>   		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
> +		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
>   	};
>   	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
>   		return "unknown term";
> @@ -843,6 +873,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
>   	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
>   	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>   	case PARSE_EVENTS__TERM_TYPE_PERCORE:
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
>   		return true;
>   	case PARSE_EVENTS__TERM_TYPE_USER:
>   	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> @@ -986,6 +1017,15 @@ do {									   \
>   			return -EINVAL;
>   		}
>   		break;
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
> +		CHECK_TYPE_VAL(NUM);
> +		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
> +			parse_events_error__handle(err, term->err_val,
> +						strdup("too big"),
> +						NULL);
> +			return -EINVAL;
> +		}
> +		break;
>   	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>   	case PARSE_EVENTS__TERM_TYPE_USER:
>   	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> @@ -1112,6 +1152,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
>   	case PARSE_EVENTS__TERM_TYPE_RAW:
>   	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>   	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +	case PARSE_EVENTS__TERM_TYPE_CPU:
>   	default:
>   		if (err) {
>   			parse_events_error__handle(err, term->err_term,
> @@ -1243,6 +1284,7 @@ do {								\
>   		case PARSE_EVENTS__TERM_TYPE_RAW:
>   		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>   		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +		case PARSE_EVENTS__TERM_TYPE_CPU:
>   		default:
>   			break;
>   		}
> @@ -1296,6 +1338,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
>   		case PARSE_EVENTS__TERM_TYPE_RAW:
>   		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>   		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +		case PARSE_EVENTS__TERM_TYPE_CPU:
>   		default:
>   			break;
>   		}
> @@ -1350,6 +1393,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>   	struct perf_event_attr attr;
>   	LIST_HEAD(config_terms);
>   	const char *name, *metric_id;
> +	struct perf_cpu_map *cpus;
>   	int ret;
>   
>   	memset(&attr, 0, sizeof(attr));
> @@ -1371,9 +1415,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>   
>   	name = get_config_name(head_config);
>   	metric_id = get_config_metric_id(head_config);
> +	cpus = get_config_cpu(head_config);
>   	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
>   			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
> -			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
> +			cpus) ? 0 : -ENOMEM;
> +	perf_cpu_map__put(cpus);
>   	free_config_terms(&config_terms);
>   	return ret;
>   }
> @@ -1440,6 +1486,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>   	LIST_HEAD(config_terms);
>   	struct parse_events_terms parsed_terms;
>   	bool alias_rewrote_terms = false;
> +	struct perf_cpu_map *term_cpu = NULL;
>   	int ret = 0;
>   
>   	if (verbose > 1) {
> @@ -1531,6 +1578,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>   		goto out_err;
>   	}
>   
> +	term_cpu = get_config_cpu(&parsed_terms);
> +	if (!perf_cpu_map__is_empty(term_cpu)) {
> +		perf_cpu_map__put(info.cpus);
> +		info.cpus = term_cpu;
> +		term_cpu = NULL;
> +	}
>   	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
>   			    get_config_name(&parsed_terms),
>   			    get_config_metric_id(&parsed_terms), pmu,
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index e13de2c8b706..b03857499030 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -79,7 +79,8 @@ enum parse_events__term_type {
>   	PARSE_EVENTS__TERM_TYPE_RAW,
>   	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
>   	PARSE_EVENTS__TERM_TYPE_HARDWARE,
> -#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
> +	PARSE_EVENTS__TERM_TYPE_CPU,
> +#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
>   };
>   
>   struct parse_events_term {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 16045c383ada..e06097a62796 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -330,6 +330,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
>   aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
>   aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
>   metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
> +cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
>   cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
>   stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
>   stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 280b2499c861..27e2ff23799e 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1767,6 +1767,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
>   		"percore",
>   		"aux-output",
>   		"aux-sample-size=number",
> +		"cpu=number",
>   	};
>   	struct perf_pmu_format *format;
>   	int ret;
