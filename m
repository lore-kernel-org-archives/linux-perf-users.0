Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8C1922FD;
	Thu,  5 Sep 2024 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518706; cv=none; b=WK1PK0GzmoTUMmyBO7KMJiLMWu+Gapq1lir34kfLODlyOaXJOt/5bAQYuZVbvU6KfDo4LdhKKNFkLqoRSG+nv7rbZsB9Ph/0oDvGeuoJVomu8hSBEVBJKpMsgw+/fecQ+WR75wVNaKXGkBMPsJptk2WpZ8X9H78sR8nkQAPzA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518706; c=relaxed/simple;
	bh=LCGL7vwew473xxNLZVNKy/1l+M8TqmCJBI5QzXlv0tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HlgTb4xHLQweq9U0+DKufmouyrmQYs5EKzw034v3SAlcQM2vQOA+7q2DDzHgdeTvP9uU/+roUD/n8VfB/YCuMnSEeH2D2RDqdHoNAHvEkhwC5i6Vgcl7XZvCq4estsIx45JrdU4YsYG1h5QHmaDws5fGaFU621LmRbP7TBGq+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHlzyYfE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHlzyYfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725518703; x=1757054703;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LCGL7vwew473xxNLZVNKy/1l+M8TqmCJBI5QzXlv0tk=;
  b=hHlzyYfE9Fm058r3rb96qNWWXyHBMy8I4GPB+E+phVvY2Mn/7Eyg77b1
   6uWd8kW3geCHH6GIgbjJMyo8+nKqszmqnUBedofID8blO2JtevkfUSL/h
   cvwRC0knhhAM47ikyA1ikZJNQomrQIWnkNtAF1LJxqQ1SSRE/8ub70Fba
   aRI6Yp3l2jbG2A0L9guUS/D1Ut62eH4RYgZkUMgNdq9AzG6LN3ooOlBMB
   KbZzXP4HHAc2+VZ4E/SAKeM40oUqt5EZ2hYVjpS8oRSu/QUPAyhd7u8jg
   lR9kIlGbGN3XiJP666dMvjb69SjzNEC89IQw2t/0lFSwz6+w3TA1x9u2o
   A==;
X-CSE-ConnectionGUID: DUMno9ZsSZu185m+ZndhWQ==
X-CSE-MsgGUID: +FdqnukURLeop/hJJzQetw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="41719145"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="41719145"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 23:45:01 -0700
X-CSE-ConnectionGUID: CL8d2KbuT/iD/DTtOcgAYA==
X-CSE-MsgGUID: /iV5Z3DbQAinTbGpYKJW/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70325566"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 23:44:56 -0700
Message-ID: <81e3ef63-06d5-492a-8c82-da941d014ffb@intel.com>
Date: Thu, 5 Sep 2024 09:44:51 +0300
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
 <3f03541e-6dab-472f-bad9-4cdc0c0dc061@intel.com>
 <a25103a1-47e3-472a-bfa8-abdfbc843cd3@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <a25103a1-47e3-472a-bfa8-abdfbc843cd3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/09/24 00:13, Leo Yan wrote:
> On 9/3/2024 4:26 PM, Adrian Hunter wrote:
>> On 23/08/24 14:33, Leo Yan wrote:
>>> A prerequisite for multiple AUX events is that the AUX events cannot
>>> overlap CPU maps. The reason is that every CPU has only one AUX trace
>>> buffer and maps it to an unique buffer index for CPU and system tracing
>>> mode.
>>>
>>> To prevent the case of CPU maps overlapping occurring within multiple
>>> AUX events, the auxtrace_record__validate_events() function is
>>> introduced. It iterates through all AUX events and returns failure if
>>> it detects CPU maps overlapping.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>> ---
>>>  tools/perf/builtin-record.c |  4 +++
>>>  tools/perf/util/auxtrace.c  | 64 +++++++++++++++++++++++++++++++++++++
>>>  tools/perf/util/auxtrace.h  |  7 ++++
>>>  3 files changed, 75 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index adbaf80b398c..2c618efba97d 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -862,6 +862,10 @@ static int record__auxtrace_init(struct record *rec)
>>>
>>>       auxtrace_regroup_aux_output(rec->evlist);
>>>
>>> +     err = auxtrace_validate_events(rec->evlist);
>>> +     if (err)
>>> +             return err;
>>> +
>>>       return auxtrace_parse_filters(rec->evlist);
>>>  }
>>>
>>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>>> index ca8682966fae..87e4f21b6edf 100644
>>> --- a/tools/perf/util/auxtrace.c
>>> +++ b/tools/perf/util/auxtrace.c
>>> @@ -2828,6 +2828,70 @@ int auxtrace_parse_filters(struct evlist *evlist)
>>>       return 0;
>>>  }
>>>
>>> +int auxtrace_validate_events(struct evlist *evlist)
>>
>> 'auxtrace_validate_aux_events' would better indicate that it is
>> looking only at AUX area events.
> 
> Will fix.
> 
>>> +{
>>> +     struct evsel *evsel;
>>> +     struct perf_cpu_map *cpu_map = NULL;
>>> +     struct perf_cpu_map *cpu_map_intersect = NULL;
>>> +     struct perf_cpu_map *cpu_map_merged = NULL;
>>> +     int ret = 0;
>>> +
>>> +     if (!evlist)
>>> +             return 0;
>>
>> Elsewhere we assume it is not NULL, might as well here too.
> 
> Sure, will drop this checking.
> 
>>> +
>>> +     /*
>>> +      * Currently the tool only supports multiple AUX events without
>>> +      * overlapping CPU maps and every CPU has its unique AUX buffer
>>> +      * for CPU or system mode tracing.
>>> +      *
>>> +      * Returns failure if detects CPU maps overlapping.
>>> +      */
>>> +     evlist__for_each_entry(evlist, evsel) {
>>> +             if (!evsel__is_aux_event(evsel))
>>> +                     continue;
>>> +
>>> +             if (perf_cpu_map__is_empty(evsel->pmu->cpus))
>>> +                     continue;
>>
>> Unless perf_cpu_map__intersect() is broken, the empty check
>> should not be needed.
> 
> Perf's CPU map implementation is tricky. IIRC, if without this checking, it
> will break the tool.
> 
> In below code, we invokes perf_cpu_map__merge() for merging maps. It does
> _not_ always allocate a new map for merging. Based on testing, it only
> allocates a new map if two passed map pointers are not NULL. If a passed CPU
> map pointer is NULL, then it will directly return the another map's pointer.
> 
> This leads the difficulty for releasing the merged map. If the returned merged
> map is a new allocated one, it is safe us to release it. Otherwise, we might
> release a CPU map unexpectedly - though it is returned by
> perf_cpu_map__merge(), but the CPU map comes from a PMU and should not be
> released.

If it returns a different map, it adjusts the reference counts
accordingly.  perf_cpu_map__merge() is still a problem though.
See below.

> 
> Anyway, I will remove the empty check and see if fix the perf CPU map issue.
> 
>> Shouldn't we be looking at evsel->cpus ?
> 
> I don't find the field `evsel->cpus`, I assume you are referring to
> evsel__cpus(evsel)?  If so, I will change to use the CPU map from evsel.
> 
>> Possibly need to consider the perf_cpu_map__has_any_cpu() case?
>> e.g.
>>                 if (cpu_map && (perf_cpu_map__has_any_cpu(evsel->cpus) ||
>>                                 perf_cpu_map__has_any_cpu(cpu_map)) {
>>                         ret = -EINVAL;
>>                         break;
>>                 }
> 
> Will add.
> 
>>> +
>>> +             cpu_map_intersect = perf_cpu_map__intersect(cpu_map, evsel->pmu->cpus);
>>> +             if (cpu_map_intersect) {
>>> +                     perf_cpu_map__put(cpu_map_intersect);
>>> +                     pr_err("Doesn't support AUX events with overlapping CPU masks\n");
>>> +                     ret = -EINVAL;
>>> +                     break;
>>> +             }
>>> +             perf_cpu_map__put(cpu_map_intersect);
>>
>> Maybe add a helper:
>>
>> static bool perf_cpu_map__do_maps_intersect(struct perf_cpu_map *a, struct perf_cpu_map *b)
>> {
>>         struct perf_cpu_map *intersection = perf_cpu_map__intersect(a, b);
>>         bool ret = !perf_cpu_map__is_empty(intersection);
>>
>>         perf_cpu_map__put(intersection);
>>
>>         return ret;
>> }
> 
> Will do.
> 
>>> +
>>> +             cpu_map_merged = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);
>>> +             if (!cpu_map_merged) {
>>> +                     ret = -ENOMEM;
>>> +                     break;
>>> +             }
>>> +
>>> +             /* Update the CPU maps after merging */
>>> +             perf_cpu_map__put(cpu_map);
>>> +             cpu_map = cpu_map_merged;
>>
>> perf_cpu_map__merge() is a bit tricky - see its comments.  This
>> should probably all just be:
>>
>>                 cpu_map = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);
> 
> This might lead to memory leak for the 'old' cpu_map after merging.
> 
> We cannot assume the `cpu_map` variable is extended from its old value, a new
> CPU map is allocated during the merging. This is why the patch always release
> the old cpu_map (perf_cpu_map__put(cpu_map)) and then assign the new merged
> CPU map.

I agree, perf_cpu_map__merge() is a bit broken.  Maybe add
another helper like:

static int perf_cpu_map__merge_in(struct perf_cpu_map **orig, struct perf_cpu_map *other)
{
	struct perf_cpu_map *merged;

	/* Avoid being unable to tell if perf_cpu_map__merge() failed */
	if (perf_cpu_map__is_empty(*orig) && perf_cpu_map__is_empty(other))
		return 0;

	merged = perf_cpu_map__merge(*orig, other);
	if (!merged)
		return -ENOMEM;

	*orig = merged;

	return 0;
}

Then it can be:

	ret = perf_cpu_map__merge_in(&cpu_map, evsel__cpus(evsel));
	if (ret)
		break;

> 
>>> +     }
>>> +
>>> +     if (!ret)
>>> +             goto out;
>>
>> Could we put the error path last i.e.
>>
>>         perf_cpu_map__put(cpu_map);
>>
>>         if (ret)
>>                 goto out_err;
>>
>>         return 0;
>>
>> out_err:
> 
> Makes sense. Will fix.
> 
>>> +
>>> +     /* If fails, dump CPU maps for debugging */
>>> +     evlist__for_each_entry(evlist, evsel) {
>>> +             char buf[200];
>>> +
>>> +             if (!evsel__is_aux_event(evsel))
>>> +                     continue;
>>> +
>>> +             cpu_map__snprint(evsel->pmu->cpus, buf, sizeof(buf));
>>> +             pr_debug("AUX event [%s]'s cpu map is: %s\n", evsel->pmu->name, buf);
>>
>> Could probably use cpu_map__fprintf(pmu->cpus, debug_file()) and
>> not need buf.
> 
> Will do.
> 
> Thanks for suggestions!
> 
> Leo
> 
>>> +     }
>>> +
>>> +out:
>>> +     perf_cpu_map__put(cpu_map);
>>> +     return ret;
>>> +}
>>> +
>>>  int auxtrace__process_event(struct perf_session *session, union perf_event *event,
>>>                           struct perf_sample *sample, const struct perf_tool *tool)
>>>  {
>>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>>> index a1895a4f530b..67a74ad0c383 100644
>>> --- a/tools/perf/util/auxtrace.h
>>> +++ b/tools/perf/util/auxtrace.h
>>> @@ -636,6 +636,7 @@ void addr_filters__exit(struct addr_filters *filts);
>>>  int addr_filters__parse_bare_filter(struct addr_filters *filts,
>>>                                   const char *filter);
>>>  int auxtrace_parse_filters(struct evlist *evlist);
>>> +int auxtrace_validate_events(struct evlist *evlist);
>>>
>>>  int auxtrace__process_event(struct perf_session *session, union perf_event *event,
>>>                           struct perf_sample *sample, const struct perf_tool *tool);
>>> @@ -875,6 +876,12 @@ int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
>>>       return 0;
>>>  }
>>>
>>> +static inline
>>> +int auxtrace_validate_events(struct evlist *evlist __maybe_unused)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>>>                       struct auxtrace_mmap_params *mp,
>>>                       void *userpg, int fd);
>>

