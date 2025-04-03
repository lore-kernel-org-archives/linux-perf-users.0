Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FE2566F1;
	Thu,  3 Apr 2025 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708358; cv=none; b=KrPZAfIv2vaJEywwHfp+/sUsxZWLCHXrtiuSVrSZEpGzQXGzf4HJUgCrR77o6otbPE/lEhl6sPlzeb6stX7l+p4zEIbsjAsPkrMAuRK9MXCFtVoH5FSLzjGQzN/eQ8XMsu8LKLX6A1UPt/6lpHKRwLNfnjWPqySjh4Nxfmfplao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708358; c=relaxed/simple;
	bh=C0ehoIQq/WHXKzxhpF7epWCQyX/+IdlwnDgzPYdMsMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYIHriS3oSMQNvsHvdtxtXUIb3JauRNa7zWVkQsIEBpLQtmzUVzYxXmC7Z/zT1CyXQDT9HxAC9GdXaEYA1plQg2wacSYDidg9GZKQlw07q39z6hTGcb3wgxKWNjGI/yWuYSewqMIyBXw8kJTfiJy0thwojnBGG9F+DfyF7Uw31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHSoctoH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHSoctoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743708357; x=1775244357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C0ehoIQq/WHXKzxhpF7epWCQyX/+IdlwnDgzPYdMsMc=;
  b=BHSoctoH6zTNH2QBiwJvQPoXMR0pYyIuXXP3uV2s8V+iqi0SCWhfwePN
   Sw9DDAg0+NvShUOx4uxqiLHAgYo3ixQ6v+bCZSqHvncxs19LRlQyMrDXw
   Azv1d+KLMmwp+SqUXCyx4no1QtvvfN/BfndjOqODUATogRrhFDuSaVUvh
   4YF+nngtrcPq7NG8Ka5OsMCAjK3rp2pwPM2sR31xH8xN9nkW5reyH85D0
   Nej7UTJsk95augVnWpn4sxt2Q+A1+WcVIiuQtXji5DtCb5dPLnVZaNNnd
   +rKTwl/Gom3uklWSaGk1nwMF1XUjSJeuP5oaWO/OtIV7fQKkfN/CzqkAx
   w==;
X-CSE-ConnectionGUID: 0XH3YMYFRsi9QcgcxIvwYA==
X-CSE-MsgGUID: l1+Tut9vQJe59gz/AgAiBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45279292"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="45279292"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 12:25:55 -0700
X-CSE-ConnectionGUID: SZPrSAU9QTyHAvzRUnHYtQ==
X-CSE-MsgGUID: M7mgXRMjSzq2GLtlB06Dwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="127093370"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 12:25:54 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id EF05420B5736;
	Thu,  3 Apr 2025 12:25:51 -0700 (PDT)
Message-ID: <fc8e6ede-af8b-4777-a003-585886eff897@linux.intel.com>
Date: Thu, 3 Apr 2025 15:25:50 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] perf parse-events: Set is_pmu_core for legacy
 hardware events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250210183808.130522-1-irogers@google.com>
 <20250210183808.130522-4-irogers@google.com>
 <0924de97-67ec-4c8a-8c5c-66264bdd2748@linux.intel.com>
 <CAP-5=fVU1A+faRRCJjNsZuO5-0ifpT1C=846qpL_fjfUgVO1bw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVU1A+faRRCJjNsZuO5-0ifpT1C=846qpL_fjfUgVO1bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-04-03 11:44 a.m., Ian Rogers wrote:
> On Thu, Apr 3, 2025 at 8:17 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2025-02-10 1:38 p.m., Ian Rogers wrote:
>>> Also set the CPU map to all online CPU maps. This is done so the
>>> behavior of legacy hardware and hardware cache events better matches
>>> that of sysfs and json events during
>>> __perf_evlist__propagate_maps. Fix missing cpumap put in "Synthesize
>>> attr update" test.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/tests/event_update.c |  1 +
>>>  tools/perf/util/parse-events.c  | 37 ++++++++++++++++++++-------------
>>>  2 files changed, 24 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
>>> index d6b4ce3ef4ee..9301fde11366 100644
>>> --- a/tools/perf/tests/event_update.c
>>> +++ b/tools/perf/tests/event_update.c
>>> @@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>>>       TEST_ASSERT_VAL("failed to synthesize attr update name",
>>>                       !perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
>>>
>>> +     perf_cpu_map__put(evsel->core.own_cpus);
>>>       evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
>>>
>>>       TEST_ASSERT_VAL("failed to synthesize attr update cpus",


The above change should have been merged.
2c744f38da7a ("perf test: Fix leak in "Synthesize attr update" test").

It makes the patch failed to be applied to perf-tools-next.


>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>> index 6c36b98875bc..8cccf1e22cdf 100644
>>> --- a/tools/perf/util/parse-events.c
>>> +++ b/tools/perf/util/parse-events.c
>>> @@ -231,21 +231,30 @@ __add_event(struct list_head *list, int *idx,
>>>           struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
>>>  {
>>>       struct evsel *evsel;
>>> -     struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
>>> +     bool is_pmu_core;
>>> +     struct perf_cpu_map *cpus;
>>>
>>> -     cpus = perf_cpu_map__get(cpus);
>>> -     if (pmu)
>>> +     if (pmu) {
>>> +             is_pmu_core = pmu->is_core;
>>> +             cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
>>>               perf_pmu__warn_invalid_formats(pmu);
>>> -
>>> -     if (pmu && (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX)) {
>>> -             perf_pmu__warn_invalid_config(pmu, attr->config, name,
>>> -                                           PERF_PMU_FORMAT_VALUE_CONFIG, "config");
>>> -             perf_pmu__warn_invalid_config(pmu, attr->config1, name,
>>> -                                           PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
>>> -             perf_pmu__warn_invalid_config(pmu, attr->config2, name,
>>> -                                           PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
>>> -             perf_pmu__warn_invalid_config(pmu, attr->config3, name,
>>> -                                           PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
>>> +             if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
>>> +                     perf_pmu__warn_invalid_config(pmu, attr->config, name,
>>> +                                             PERF_PMU_FORMAT_VALUE_CONFIG, "config");
>>> +                     perf_pmu__warn_invalid_config(pmu, attr->config1, name,
>>> +                                             PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
>>> +                     perf_pmu__warn_invalid_config(pmu, attr->config2, name,
>>> +                                             PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
>>> +                     perf_pmu__warn_invalid_config(pmu, attr->config3, name,
>>> +                                             PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
>>> +             }
>>> +     } else {
>>> +             is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
>>> +                            attr->type == PERF_TYPE_HW_CACHE);
>>> +             if (perf_cpu_map__is_empty(cpu_list))
>>> +                     cpus = is_pmu_core ? perf_cpu_map__new_online_cpus() : NULL;
>>
>> All online CPUs? Is there a problem for hybrid?
> 
> For hybrid if you do cpu_atom/cycles/ then the PMU is found by
> perf_pmus__find here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n1651
>
> The wildcard case (e.g. perf stat -e cycles ...) scans all the PMUs>
passing the respective pmu into __add_event:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n1382

Yes, the pmu should always be available for hybrid case.

> 
> For non-hybrid the PMU is given by perf_pmus__find_by_type which only
> returns a PMU if there is an exact match on the type, ie it won't
> return perf_pmus__find_core_pmu  when asked to lookup the PMU for a
> legacy type, evsel__find_pmu will do this though.
> 
> Anyway, the assumption in this legacy configuration no PMU case is
> that the event is heading to all CPUs, which is true for software and
> tracepoint. For hybrid we could get into this kind of problem is sysfs
> isn't mounted, but I think we're pretty generally broken in that case
> anyway.
> 
> Fwiw, I'm carrying these changes in google's tree and test it on my
> hybrid desktop:
> https://github.com/googleprodkernel/linux-perf

OK. I will do some tests then.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan> +          else
>>> +                     cpus = perf_cpu_map__get(cpu_list);
>>>       }
>>>       if (init_attr)
>>>               event_attr_init(attr);
>>> @@ -260,7 +269,7 @@ __add_event(struct list_head *list, int *idx,
>>>       evsel->core.cpus = cpus;
>>>       evsel->core.own_cpus = perf_cpu_map__get(cpus);
>>>       evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
>>> -     evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
>>> +     evsel->core.is_pmu_core = is_pmu_core;
>>>       evsel->auto_merge_stats = auto_merge_stats;
>>>       evsel->pmu = pmu;
>>>       evsel->alternate_hw_config = alternate_hw_config;
>>
> 

