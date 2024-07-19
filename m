Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2013C679;
	Fri, 19 Jul 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397367; cv=none; b=jK/Jh1/LkzfaFiR3oMHmxmQQS4/R1h4BRKo1ksQAkB6AkH2iCOq/oq5SeWMO0ytY8Inu4GW1pTdFQJIXjPUqopwNIwEDqS+Q4Ctc7sGVxgP4nFZ0seUXXvYQOgNhbGBLCReowAr+1Grj7RWKFh8eZ+e5LwJ4FJWNg/8fdfyUhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397367; c=relaxed/simple;
	bh=uGRqzljmM2/LI4ME3k5gWDt5e+freuDNSITQGCJ/Smo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCeyTUHBOz2CmNqmb/Y/N9HLg6x8+8n+qw8l9bcYSrJimv3zsfvhAX4e/AiGyfyovjb3P/+I01yF8VIWcttkm1NpVby82G2dXqyyT2yDUXkZ/fkSn81NNOv/zpc2zYlbAJuI320XwH2+XcagDtbRyW5MLl93R8aLJBS9fMTAjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPam6hh7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPam6hh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721397367; x=1752933367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uGRqzljmM2/LI4ME3k5gWDt5e+freuDNSITQGCJ/Smo=;
  b=NPam6hh7Aau6yitJZa775JG2Xf596voAGI4qiF/IFfnPRpXsGHxtRIVX
   7XEc9gHuXN2CKNdbeAf09lsWTWJwByfukJxsEdPtJQaeKptlusBp7HDIa
   G3ho58G5OoU6HqLr9TCZ8cr9fOVI21LoRAPRQPw4TEAmNYvRhhjDzlzhf
   gfuvhiN83vVzoh12SVWaXYRpOViH7q1bXWXsI1Gh8G3AcGEcx3tCrOLHj
   DiM0oy4fnCz6fvl2lzTslF8hWv6D5XWAjJUQX+rx6oCjuzJR3QSN+8LIn
   mrmW+akS3aYeb/UUl7CBSZGEiz6DRChs4gKDJ1x4ezPzFlLPnw1/uQOFS
   A==;
X-CSE-ConnectionGUID: UOyIgyQNRuWWFCjNWOMfJA==
X-CSE-MsgGUID: Y9MrmNfUQnevGITlBjMaqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="30161491"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="30161491"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 06:56:06 -0700
X-CSE-ConnectionGUID: wWB3lJEWSiaJ4a73X2rrVQ==
X-CSE-MsgGUID: xaw0AZ2RT8e5DDzVAbNLqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="50860659"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 06:56:04 -0700
Received: from [10.209.176.79] (kliang2-mobl1.ccr.corp.intel.com [10.209.176.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2D57920CFED5;
	Fri, 19 Jul 2024 06:56:01 -0700 (PDT)
Message-ID: <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
Date: Fri, 19 Jul 2024 09:55:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in
 sysfs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
 <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
 <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-18 4:50 p.m., Ian Rogers wrote:
> On Thu, Jul 18, 2024 at 10:48 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-07-18 11:39 a.m., Ian Rogers wrote:
>>> On Thu, Jul 18, 2024 at 7:33 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
>>>>> If an event file exists in sysfs, check if a event.cpus file exists
>>>>> and read a perf_cpu_map from it if it does. This allows particular
>>>>> events to have a different set of CPUs compared to the PMU.
>>>>>
>>>>> One scenario where this could be useful is when a PMU is set up with a
>>>>> cpumask/events per SMT thread but some events record for all SMT
>>>>> threads. Programming an event on each SMT thread will cause
>>>>> unnecessary counters to be programmed and the aggregate value to be
>>>>> too large.
>>>>
>>>> If I understand the scenario correctly, I think the issue should have
>>>> been addressed since ICX, with the introduction of  the "SMT-aware
>>>> events". Is there a specific event which still has the issue on newer
>>>> platforms?
>>>
>>> Nothing comes to mind, but it is there on popular machines like Skylake.
>>>
>>>>>
>>>>> Another scenario where this could be useful if when a PMU has
>>>>> historically had a cpumask at the package level, but now newer per
>>>>> die, core or CPU information is available.
>>>>
>>>> The traditional way to support new counters with a different scope is to
>>>> add a new PMU.
>>>>
>>>>>
>>>>> Additional context for the motivation is in these patches and
>>>>> conversation:
>>>>> https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/
>>>>
>>>> I don't see the advantages of the new event.cpus way.
>>>> The aggregation should be the same.
>>>
>>> Agreed. My concern is that we may end up with a pattern of
>>> <pmu>_per_pkg, <pmu>_per_core, <pmu>_per_cpu, <pmu>_per_l3, etc. just
>>> for the sake of the cpumask.
>>
>> The cstate PMUs already do so, e.g., cstate_core, cstate_pkg.
>>
>> From another perspective, it discloses the scope information in a PMU
>> name. If a user only cares about the information of a package, they just
>> need to focus on everything under <pmu>_pkg. Otherwise, they have to go
>> through all the events.
>>
>>>
>>>> The RAPL counters are free-running counters. So there is no difference
>>>> whether grouping or not grouping.
>>>
>>> Should the RAPL counters return true for perf_pmu__is_software? In the
>>> tool we currently return false and won't allow grouping, these events
>>> with other hardware events. The intent in perf_pmu__is_software was to
>>> emulate the way the kernel allows/disallows groups - software context
>>> events can be in a hardware context but otherwise I don't believe the
>>> grouping is allowed.
>>
>> No, it's not allowed for the RAPL counters.
>>
>> If the motivation is to find another way to group counters with
>> different scope, it may not work.
>>
>> We once tried to mix the perf_invalid_context PMUs in a group. But it's
>> denied.
>> https://yhbt.net/lore/all/20150415172856.GA5029@twins.programming.kicks-ass.net/
>>
>> The event.cpus still faces the same issues.
> 
> Why so? The events would share the same perf_event_context, I thought
> the perf_event_open would succeed.

I think it breaks what groups are as well. At least, you cannot
guarantee that two events can be co-scheduled on the same CPU. Even
worse, there could be no events on some CPU.
The first thing that pops up is the sample read feature. On CPU_A, the
event_A is the leader event, but on CPU_B, the event_B could be the
leader event if event_A's cpumask doesn't include the CPU_B.
There could be more similar features we have to special handle.

> 
>>>
>>>> But it makes the kernel driver complex, since it has to maintain at
>>>> least two different cpumasks.
>>>
>>> Two drivers each maintaining a cpumask or 1 driver maintaining 2
>>> cpumasks, it seems like there is chance for code reuse in both cases.
>>> I'm not seeing how it adds to complexity particularly.
>>
>> Yes, there are some cleanup opportunities for the cpumask/hotplug codes.
>>
>> We may even abstracts some generic interfaces for pkg or core level PMUs.
>>
>> Eventually, the complexity/duplication should be able to be reduced.
>>
>>>
>>>> The tool becomes complex either, since it has to take care of the
>>>> per-event CPU override case.
>>>
>>> I'm not sure I agree with this. What we need for perf_event_open is a
>>> perf_event_attr, we dress these up as evsels which also have the
>>> ability to be for >1 CPU or thread. Longer term I think evsels can
>>> also have >1 PMU, for the wildcard cases like uncore memory
>>> controllers - this would remove the need for resorting evsels except
>>> for topdown events which have thrown us a giant bundle of challenges.
>>> Anyway, so an evsel is perf_event_attr information paired with CPU
>>> information, it makes sense to me that the parser should do this
>>> pairing. What's harder in the evsel/evlist setup is trying to fix CPU
>>> maps up not in parsing, like with __perf_evlist__propagate_maps where
>>> the parsing is trying to leave crumbs around (like system_wide,
>>> has_user_cpus, is_pmu_core) so the map propagation works properly.
>>>
>>>> The json file must also be updated to add a
>>>> new field cpumask.
>>>
>>> Yeah, I don't like this as it means we end up putting CPU information
>>> into the json that isn't the same for every CPU variant of the same
>>> architecture model. Maybe we can have some kind of "scope" enum value
>>> in the json and then when the scope differs from the PMU's, core scope
>>> vs the PMU's hyperthread scope, then in the tool we can figure out the
>>> cpumask from the topology in sysfs. Maybe we should just always use
>>> the topology and get rid of cpumask files in sysfs, replacing them
>>> with "scope" files. Will Deacon pushed back on having ARM PMUs
>>> supporting hot plugging
>>> (https://lore.kernel.org/lkml/20240701142222.GA2691@willie-the-truck/)
>>> where the main thing hot plugging handler needs to maintain is set the
>>> cpumask.
>>
>> Not just the cpumask but also migrate the context for some PMUs, see
>> perf_pmu_migrate_context().
> 
> Will do, thanks.
> 
>> It seems we really need a shared cpumask in the generic code, so the
>> drivers don't need to handle the hotplug everywhere. I will think about it.
> 
> Thanks. There are other problems on ARM PMUs like having no or empty
> cpumasks, which the tool take to mean open the event on every online
> CPU (there is no cpus or cpumask file on core PMUs historically, so we
> adopt this behavior when the cpumask is empty or not present). 

The no cpus/cpumasks and empty cpumasks should be different.
No cpus/cpumasks file means that the counters/events are available for
all the CPUs.
But if it's an empty cpus/cpumasks file, it means that there are no
proper CPUs. It may happen on a hybrid machine when all e-core CPUs are
hot-removed. Since it's possible that the CPUs can be hot-added later,
the kernel driver doesn't unregister the cpu_atom PMU.

> I've
> been thinking to expand `tools/perf/tests/pmu.c` with basic PMU sanity
> tests. Some ideas:
> 

Thanks.

> 1) some kind of cpumask sanity check - we could open an event with the
> cpumask and see if it yields multiplexing.. which would highlight the
> ARM no cpumask bug

The multiplexing is triggered when there are not enough counters. It
should not related to the cpumask.

For the PMU without cpumask, I think the test case should try to open an
event on all CPUs and check if the open succeeds.
For the PMU with cpumask, the test case should try to open an event on
the masked CPUs and check if the open succeeds.

The behavior of opening an event on unmasked CPUs seems not defined.
For uncore, it's OK. The kernel treats the CPUs from the same socket
exactly the same. But I'm not sure about the other PMUs.

> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
> files parse correctly and have a corresponding event.
> 3) keep adding opening events on the PMU to a group to make sure that
> when counters are exhausted the perf_event_open fails (I've seen this
> bug on AMD)
> 4) are the values in the type file unique
> 

The rest sounds good to me.

Thanks,
Kan
