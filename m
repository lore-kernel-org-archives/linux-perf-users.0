Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756BF154445;
	Wed,  4 Sep 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484396; cv=none; b=o/VR5scEqTMF+Rfy0cIxsDhHOIHn8LA1G8i3Ra1h8GHTZ6FzMA2XWuUZNkHBXkvkyR7EhmvWYOC0lgS9btP9CukMazAlrbGt8suElf0jB7Ch9Njh5AoXlgucig1ht3gIcMGxVqGA8km+0bgOvSvpVDr0j2BOqvEnZvuX0xgHRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484396; c=relaxed/simple;
	bh=60TeuMnpfB13HnAaI1nDlQN8xQaPq3nXkxbwmi32LwI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=DkWi/z11Vmq2ueQc1glMawJ6LgHHt6mflfTSiTluIN2er0mC/k5X4gL6yah0azQkONNiz/2KNhxheCCjOUgUqYNeXOF+yvF88OJLH1rU+s7h02iEkQkpjA9uf5pk3xjKflmi8ryJZLmp7pxa+OVhhKDN94g321hP7tdVSf3HPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B5CFEC;
	Wed,  4 Sep 2024 14:13:38 -0700 (PDT)
Received: from [10.57.81.194] (unknown [10.57.81.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6A9E3F73F;
	Wed,  4 Sep 2024 14:13:09 -0700 (PDT)
Message-ID: <a25103a1-47e3-472a-bfa8-abdfbc843cd3@arm.com>
Date: Wed, 4 Sep 2024 22:13:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v6 4/8] perf auxtrace: Introduce
 auxtrace_record__validate_events()
To: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
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
Content-Language: en-US
In-Reply-To: <3f03541e-6dab-472f-bad9-4cdc0c0dc061@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2024 4:26 PM, Adrian Hunter wrote:
> On 23/08/24 14:33, Leo Yan wrote:
>> A prerequisite for multiple AUX events is that the AUX events cannot
>> overlap CPU maps. The reason is that every CPU has only one AUX trace
>> buffer and maps it to an unique buffer index for CPU and system tracing
>> mode.
>>
>> To prevent the case of CPU maps overlapping occurring within multiple
>> AUX events, the auxtrace_record__validate_events() function is
>> introduced. It iterates through all AUX events and returns failure if
>> it detects CPU maps overlapping.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>  tools/perf/builtin-record.c |  4 +++
>>  tools/perf/util/auxtrace.c  | 64 +++++++++++++++++++++++++++++++++++++
>>  tools/perf/util/auxtrace.h  |  7 ++++
>>  3 files changed, 75 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index adbaf80b398c..2c618efba97d 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -862,6 +862,10 @@ static int record__auxtrace_init(struct record *rec)
>>
>>       auxtrace_regroup_aux_output(rec->evlist);
>>
>> +     err = auxtrace_validate_events(rec->evlist);
>> +     if (err)
>> +             return err;
>> +
>>       return auxtrace_parse_filters(rec->evlist);
>>  }
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index ca8682966fae..87e4f21b6edf 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -2828,6 +2828,70 @@ int auxtrace_parse_filters(struct evlist *evlist)
>>       return 0;
>>  }
>>
>> +int auxtrace_validate_events(struct evlist *evlist)
> 
> 'auxtrace_validate_aux_events' would better indicate that it is
> looking only at AUX area events.

Will fix.

>> +{
>> +     struct evsel *evsel;
>> +     struct perf_cpu_map *cpu_map = NULL;
>> +     struct perf_cpu_map *cpu_map_intersect = NULL;
>> +     struct perf_cpu_map *cpu_map_merged = NULL;
>> +     int ret = 0;
>> +
>> +     if (!evlist)
>> +             return 0;
> 
> Elsewhere we assume it is not NULL, might as well here too.

Sure, will drop this checking.

>> +
>> +     /*
>> +      * Currently the tool only supports multiple AUX events without
>> +      * overlapping CPU maps and every CPU has its unique AUX buffer
>> +      * for CPU or system mode tracing.
>> +      *
>> +      * Returns failure if detects CPU maps overlapping.
>> +      */
>> +     evlist__for_each_entry(evlist, evsel) {
>> +             if (!evsel__is_aux_event(evsel))
>> +                     continue;
>> +
>> +             if (perf_cpu_map__is_empty(evsel->pmu->cpus))
>> +                     continue;
> 
> Unless perf_cpu_map__intersect() is broken, the empty check
> should not be needed.

Perf's CPU map implementation is tricky. IIRC, if without this checking, it
will break the tool.

In below code, we invokes perf_cpu_map__merge() for merging maps. It does
_not_ always allocate a new map for merging. Based on testing, it only
allocates a new map if two passed map pointers are not NULL. If a passed CPU
map pointer is NULL, then it will directly return the another map's pointer.

This leads the difficulty for releasing the merged map. If the returned merged
map is a new allocated one, it is safe us to release it. Otherwise, we might
release a CPU map unexpectedly - though it is returned by
perf_cpu_map__merge(), but the CPU map comes from a PMU and should not be
released.

Anyway, I will remove the empty check and see if fix the perf CPU map issue.

> Shouldn't we be looking at evsel->cpus ?

I don't find the field `evsel->cpus`, I assume you are referring to
evsel__cpus(evsel)?  If so, I will change to use the CPU map from evsel.

> Possibly need to consider the perf_cpu_map__has_any_cpu() case?
> e.g.
>                 if (cpu_map && (perf_cpu_map__has_any_cpu(evsel->cpus) ||
>                                 perf_cpu_map__has_any_cpu(cpu_map)) {
>                         ret = -EINVAL;
>                         break;
>                 }

Will add.

>> +
>> +             cpu_map_intersect = perf_cpu_map__intersect(cpu_map, evsel->pmu->cpus);
>> +             if (cpu_map_intersect) {
>> +                     perf_cpu_map__put(cpu_map_intersect);
>> +                     pr_err("Doesn't support AUX events with overlapping CPU masks\n");
>> +                     ret = -EINVAL;
>> +                     break;
>> +             }
>> +             perf_cpu_map__put(cpu_map_intersect);
> 
> Maybe add a helper:
> 
> static bool perf_cpu_map__do_maps_intersect(struct perf_cpu_map *a, struct perf_cpu_map *b)
> {
>         struct perf_cpu_map *intersection = perf_cpu_map__intersect(a, b);
>         bool ret = !perf_cpu_map__is_empty(intersection);
> 
>         perf_cpu_map__put(intersection);
> 
>         return ret;
> }

Will do.

>> +
>> +             cpu_map_merged = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);
>> +             if (!cpu_map_merged) {
>> +                     ret = -ENOMEM;
>> +                     break;
>> +             }
>> +
>> +             /* Update the CPU maps after merging */
>> +             perf_cpu_map__put(cpu_map);
>> +             cpu_map = cpu_map_merged;
> 
> perf_cpu_map__merge() is a bit tricky - see its comments.  This
> should probably all just be:
> 
>                 cpu_map = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);

This might lead to memory leak for the 'old' cpu_map after merging.

We cannot assume the `cpu_map` variable is extended from its old value, a new
CPU map is allocated during the merging. This is why the patch always release
the old cpu_map (perf_cpu_map__put(cpu_map)) and then assign the new merged
CPU map.

>> +     }
>> +
>> +     if (!ret)
>> +             goto out;
> 
> Could we put the error path last i.e.
> 
>         perf_cpu_map__put(cpu_map);
> 
>         if (ret)
>                 goto out_err;
> 
>         return 0;
> 
> out_err:

Makes sense. Will fix.

>> +
>> +     /* If fails, dump CPU maps for debugging */
>> +     evlist__for_each_entry(evlist, evsel) {
>> +             char buf[200];
>> +
>> +             if (!evsel__is_aux_event(evsel))
>> +                     continue;
>> +
>> +             cpu_map__snprint(evsel->pmu->cpus, buf, sizeof(buf));
>> +             pr_debug("AUX event [%s]'s cpu map is: %s\n", evsel->pmu->name, buf);
> 
> Could probably use cpu_map__fprintf(pmu->cpus, debug_file()) and
> not need buf.

Will do.

Thanks for suggestions!

Leo

>> +     }
>> +
>> +out:
>> +     perf_cpu_map__put(cpu_map);
>> +     return ret;
>> +}
>> +
>>  int auxtrace__process_event(struct perf_session *session, union perf_event *event,
>>                           struct perf_sample *sample, const struct perf_tool *tool)
>>  {
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index a1895a4f530b..67a74ad0c383 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -636,6 +636,7 @@ void addr_filters__exit(struct addr_filters *filts);
>>  int addr_filters__parse_bare_filter(struct addr_filters *filts,
>>                                   const char *filter);
>>  int auxtrace_parse_filters(struct evlist *evlist);
>> +int auxtrace_validate_events(struct evlist *evlist);
>>
>>  int auxtrace__process_event(struct perf_session *session, union perf_event *event,
>>                           struct perf_sample *sample, const struct perf_tool *tool);
>> @@ -875,6 +876,12 @@ int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
>>       return 0;
>>  }
>>
>> +static inline
>> +int auxtrace_validate_events(struct evlist *evlist __maybe_unused)
>> +{
>> +     return 0;
>> +}
>> +
>>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>>                       struct auxtrace_mmap_params *mp,
>>                       void *userpg, int fd);
> 
