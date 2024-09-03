Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069681CA6B5;
	Tue,  3 Sep 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377228; cv=none; b=CM23Y3vqrAJUn73uejhxhOI8ILVLIfqGPrU4Pk6qg/92jFtB4TZ8dk6v5sW/z6b9MZeYEBqw3O98seQNzF0ax6cFoVUG98QALokg2/ffCOOROivaWQA1YbJprWwaC89Jm4L6oJ1PQwC5y2w2W14hAnACOrcHNXs8V9h3fvYN86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377228; c=relaxed/simple;
	bh=DlGOTVSV/G3oaEgB3bm66biB+sxeCZWjwowa+b8SjRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZsfcofbwuXELb0EK2X6WbiIL184B6LND0ylBvr1H/ezf63bINFK29WXCdtKLetRUpVPFaZo354WzkhO31agT1O2t6haswps2+KXzA17mCs4jxSrLo/q0RZk5WK8UPZjr+5UF4ZD4SnzT5+3AflYK1BavfnonQSny1ZBB+C1/nOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLzeDYYJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLzeDYYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725377227; x=1756913227;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DlGOTVSV/G3oaEgB3bm66biB+sxeCZWjwowa+b8SjRw=;
  b=bLzeDYYJAwf0KvavWU5Jc+AunnOzf2DKGOV1+HR0BNtcQk4S6iST2L4s
   UNzKxTFAYmI9OyvGFJQCATiJM5sKilbxuHdVOBD7CEbzVJVck+PGJplMH
   In596GODlg9eZaTKYjXnBjfyRRdKkArvxyYR9c7aFNjVrSlKVdPYy1hA9
   OutE8K2vYSUpVz259mI4jhAsmMBHcRk6Vq0qMjGOOIAZJho6Yvu61XSDj
   Xm8n2XfM17vDjOSOo1QNUP4FLYtBQisGeHvN8HnXww0ykgJFrrNerBaFm
   ZValmOonbu2kkTdomi46Dx9CTrBuYD6TRfK0XFtU3CQPF7ufBMdjgqVUa
   A==;
X-CSE-ConnectionGUID: haJUtbRpR868tuiDqHjVIg==
X-CSE-MsgGUID: w3U77jqORp+akiRDp+4j1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24173524"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24173524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:27:06 -0700
X-CSE-ConnectionGUID: GpOdiqPQSDCV9B/UTmYJEw==
X-CSE-MsgGUID: x88LGf/0S5KWcBCFdx1yqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="102361667"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:27:00 -0700
Message-ID: <3f03541e-6dab-472f-bad9-4cdc0c0dc061@intel.com>
Date: Tue, 3 Sep 2024 18:26:54 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] perf auxtrace: Introduce
 auxtrace_record__validate_events()
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20240823113306.2310957-1-leo.yan@arm.com>
 <20240823113306.2310957-5-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240823113306.2310957-5-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/24 14:33, Leo Yan wrote:
> A prerequisite for multiple AUX events is that the AUX events cannot
> overlap CPU maps. The reason is that every CPU has only one AUX trace
> buffer and maps it to an unique buffer index for CPU and system tracing
> mode.
> 
> To prevent the case of CPU maps overlapping occurring within multiple
> AUX events, the auxtrace_record__validate_events() function is
> introduced. It iterates through all AUX events and returns failure if
> it detects CPU maps overlapping.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/builtin-record.c |  4 +++
>  tools/perf/util/auxtrace.c  | 64 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/auxtrace.h  |  7 ++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index adbaf80b398c..2c618efba97d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -862,6 +862,10 @@ static int record__auxtrace_init(struct record *rec)
>  
>  	auxtrace_regroup_aux_output(rec->evlist);
>  
> +	err = auxtrace_validate_events(rec->evlist);
> +	if (err)
> +		return err;
> +
>  	return auxtrace_parse_filters(rec->evlist);
>  }
>  
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index ca8682966fae..87e4f21b6edf 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -2828,6 +2828,70 @@ int auxtrace_parse_filters(struct evlist *evlist)
>  	return 0;
>  }
>  
> +int auxtrace_validate_events(struct evlist *evlist)

'auxtrace_validate_aux_events' would better indicate that it is
looking only at AUX area events.

> +{
> +	struct evsel *evsel;
> +	struct perf_cpu_map *cpu_map = NULL;
> +	struct perf_cpu_map *cpu_map_intersect = NULL;
> +	struct perf_cpu_map *cpu_map_merged = NULL;
> +	int ret = 0;
> +
> +	if (!evlist)
> +		return 0;

Elsewhere we assume it is not NULL, might as well here too.

> +
> +	/*
> +	 * Currently the tool only supports multiple AUX events without
> +	 * overlapping CPU maps and every CPU has its unique AUX buffer
> +	 * for CPU or system mode tracing.
> +	 *
> +	 * Returns failure if detects CPU maps overlapping.
> +	 */
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (!evsel__is_aux_event(evsel))
> +			continue;
> +
> +		if (perf_cpu_map__is_empty(evsel->pmu->cpus))
> +			continue;

Unless perf_cpu_map__intersect() is broken, the empty check
should not be needed.

Shouldn't we be looking at evsel->cpus ?

Possibly need to consider the perf_cpu_map__has_any_cpu() case?
e.g.
		if (cpu_map && (perf_cpu_map__has_any_cpu(evsel->cpus) || 
				perf_cpu_map__has_any_cpu(cpu_map)) {
			ret = -EINVAL;
			break;
		}

> +
> +		cpu_map_intersect = perf_cpu_map__intersect(cpu_map, evsel->pmu->cpus);
> +		if (cpu_map_intersect) {
> +			perf_cpu_map__put(cpu_map_intersect);
> +			pr_err("Doesn't support AUX events with overlapping CPU masks\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +		perf_cpu_map__put(cpu_map_intersect);

Maybe add a helper:

static bool perf_cpu_map__do_maps_intersect(struct perf_cpu_map *a, struct perf_cpu_map *b)
{
	struct perf_cpu_map *intersection = perf_cpu_map__intersect(a, b);
	bool ret = !perf_cpu_map__is_empty(intersection);

	perf_cpu_map__put(intersection);

	return ret;
}

> +
> +		cpu_map_merged = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);
> +		if (!cpu_map_merged) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		/* Update the CPU maps after merging */
> +		perf_cpu_map__put(cpu_map);
> +		cpu_map = cpu_map_merged;

perf_cpu_map__merge() is a bit tricky - see its comments.  This
should probably all just be:

		cpu_map = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);


> +	}
> +
> +	if (!ret)
> +		goto out;

Could we put the error path last i.e.

	perf_cpu_map__put(cpu_map);

	if (ret)
		goto out_err;

	return 0;

out_err:
> +
> +	/* If fails, dump CPU maps for debugging */
> +	evlist__for_each_entry(evlist, evsel) {
> +		char buf[200];
> +
> +		if (!evsel__is_aux_event(evsel))
> +			continue;
> +
> +		cpu_map__snprint(evsel->pmu->cpus, buf, sizeof(buf));
> +		pr_debug("AUX event [%s]'s cpu map is: %s\n", evsel->pmu->name, buf);

Could probably use cpu_map__fprintf(pmu->cpus, debug_file()) and
not need buf.

> +	}
> +
> +out:
> +	perf_cpu_map__put(cpu_map);
> +	return ret;
> +}
> +
>  int auxtrace__process_event(struct perf_session *session, union perf_event *event,
>  			    struct perf_sample *sample, const struct perf_tool *tool)
>  {
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index a1895a4f530b..67a74ad0c383 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -636,6 +636,7 @@ void addr_filters__exit(struct addr_filters *filts);
>  int addr_filters__parse_bare_filter(struct addr_filters *filts,
>  				    const char *filter);
>  int auxtrace_parse_filters(struct evlist *evlist);
> +int auxtrace_validate_events(struct evlist *evlist);
>  
>  int auxtrace__process_event(struct perf_session *session, union perf_event *event,
>  			    struct perf_sample *sample, const struct perf_tool *tool);
> @@ -875,6 +876,12 @@ int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
>  	return 0;
>  }
>  
> +static inline
> +int auxtrace_validate_events(struct evlist *evlist __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>  			struct auxtrace_mmap_params *mp,
>  			void *userpg, int fd);

