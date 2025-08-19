Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113B25B31B;
	Tue, 19 Aug 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590555; cv=none; b=jQBCX49OeNpUczT4RM1kP8Idx3CznGkxaZbOJTbAXqKRcnRyTv6iR7uOD78q/AeZnG9iHWY/X66ywI8RwBe3YzSh9m1NEzYcL624ddxApO647uoUfc/zRx5htkLYtd386B693iRG/szPkvIuqO8EbDdGv82eQPSc3R6OvRTBDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590555; c=relaxed/simple;
	bh=cXL9TU6/agYXs4DquylvZ1/p0j64IgxmSKmfAy1S2Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhVJtVgs/NGzKPre6xEgHNF3Gda26VLnnQf8Q3sFRFkJCXHXBf7jVawuUlOIKw/wY/vbMqmWphIkXozl0Nj0VDALo0lOlgzwpCPrLCnyNaD4wu9a0KYox2DBIs+ud134Y60MDCe1s5cb4H88A8WS5hlqQszD7MkkMcCBhj9Ck7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvDeb3cp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvDeb3cp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755590553; x=1787126553;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cXL9TU6/agYXs4DquylvZ1/p0j64IgxmSKmfAy1S2Gc=;
  b=nvDeb3cpHz7ulSFrotoKfcysrMH6Rkk+Gy/UH1zW+lOOEE5KpbrmGJ+t
   Gy3PQdCKwWspoARR3zZ6u1WqT10uXsUGAhgI7LP3//raCSz7RBK8fUKac
   pk+hqJEQhQ0CNIhLWZ+I8ziEpl9BsmXvnLCZ/umztF6wXO9Cm28uTXzjx
   mFzFzeGRPtYTDdQ+UtCNklwxIOnLFo6dv/QXBDyruLyDxyJ4VTW+CtWwH
   ReuN5bcGXNQAe5/o2iA8PelwaOfeVnaFMta+eGsWpZUPE4EDkKlev1j8u
   uwI40ZMqVSZsjwQyUj/9nbnlTt+yJvrbR/P01tYM+tl2Uk/TT5TM+jjEC
   g==;
X-CSE-ConnectionGUID: m3IX8kifSrmubu2+ON01NA==
X-CSE-MsgGUID: kOHENk+9SiSGYFDA23b7fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57029725"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57029725"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 01:02:32 -0700
X-CSE-ConnectionGUID: rqpw0/BFRU6aVZYkUz2L8A==
X-CSE-MsgGUID: uCHS4aAHT7q6sleN8GoqsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167019851"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.36]) ([10.124.240.36])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 01:02:27 -0700
Message-ID: <70002004-34fa-4853-8e53-0edd71a32fc4@linux.intel.com>
Date: Tue, 19 Aug 2025 16:02:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/6] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, kernel test robot <oliver.sang@intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
 <20250811090034.51249-4-dapeng1.mi@linux.intel.com>
 <17298e98-1a2d-4cdd-9156-73e77cc4eb5b@linux.intel.com>
 <0c546386-dde8-4aac-b499-9c18221ad981@linux.intel.com>
 <3b3644d5-f1c3-4f4b-94a7-fb12568a909e@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <3b3644d5-f1c3-4f4b-94a7-fb12568a909e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/13/2025 2:16 AM, Liang, Kan wrote:
>
> On 2025-08-11 7:33 p.m., Mi, Dapeng wrote:
>> On 8/12/2025 7:32 AM, Liang, Kan wrote:
>>> On 2025-08-11 2:00 a.m., Dapeng Mi wrote:
>>>> The PMI handler could disable some events as the interrupt throttling
>>>> and clear the corresponding items in cpuc->events[] array.
>>>>
>>>> perf_event_overflow()
>>>>   -> __perf_event_overflow()
>>>>     ->__perf_event_account_interrupt()
>>>>       -> perf_event_throttle_group()
>>>>         -> perf_event_throttle()
>>>>           -> event->pmu->stop()
>>>>             -> x86_pmu_stop()
>>>>
>>>> Moreover PMI is NMI on x86 platform and it could interrupt other perf
>>>> code like setup_pebs_adaptive_sample_data(). 
>>> The PMU is disabled when draining the PEBS records. I don't think a PMI
>>> can be triggered in the setup_pebs_adaptive_sample_data().
>> Besides in NMI handler, the drain_pebs helper intel_pmu_drain_pebs_buffer()
>> could be called in many places, like context switch and PEBS event
>> disabling. 
> Yes
>
>> All these places could be interrupted by the NMI handler, and
> No. Before draining the buffer, the PMU must be stopped. No NMI could be
> triggered.
>
>> then the trigger this NULL pointer access issue.
>>
>>
>>>> So once PMI handling
>>>> finishes and returns into setup_pebs_adaptive_sample_data() and it could
>>>> find the cpuc->events[*] becomes NULL and accessing this NULL pointer
>>>> triggers an invalid memory access and leads to kernel crashes eventually.
>>> The commit 9734e25fbf5a stops all events in a group when processing the
>>> last records of the leader event. For large PEBS, it's possible that
>>> there are still some records for member events left. It should be the
>>> root cause of the NULL pointer. If so, we should drain those records as
>>> well.
>> The left PEBS record would always be cleared by
>> intel_pmu_drain_large_pebs() when disabling PEBS event.
> When stopping the event.
>
> Then you should only need the check in intel_pmu_drain_pebs_icl(), since
> the stop only happens when handling the last event.

Yes, it's enough to only add NULL check in intel_pmu_drain_pebs_icl(). Thanks.


>
> Thanks,
> Kan>
>>> Thanks,
>>> Kan>
>>>> Thus add NULL check before accessing cpuc->events[*] pointer.
>>>>
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
>>>> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> Tested-by: kernel test robot <oliver.sang@intel.com>
>>>> ---
>>>>  arch/x86/events/core.c       |  3 +++
>>>>  arch/x86/events/intel/core.c |  6 +++++-
>>>>  arch/x86/events/intel/ds.c   | 13 ++++++-------
>>>>  3 files changed, 14 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>>> index 7610f26dfbd9..f0a3bc57157d 100644
>>>> --- a/arch/x86/events/core.c
>>>> +++ b/arch/x86/events/core.c
>>>> @@ -1711,6 +1711,9 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>>>>  			continue;
>>>>  
>>>>  		event = cpuc->events[idx];
>>>> +		if (!event)
>>>> +			continue;
>>>> +
>>>>  		last_period = event->hw.last_period;
>>>>  
>>>>  		val = static_call(x86_pmu_update)(event);
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 15da60cf69f2..386717b75a09 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -2718,6 +2718,8 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
>>>>  		if (!is_topdown_idx(idx))
>>>>  			continue;
>>>>  		other = cpuc->events[idx];
>>>> +		if (!other)
>>>> +			continue;
>>>>  		other->hw.saved_slots = slots;
>>>>  		other->hw.saved_metric = metrics;
>>>>  	}
>>>> @@ -2761,6 +2763,8 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end,
>>>>  		if (!is_topdown_idx(idx))
>>>>  			continue;
>>>>  		other = cpuc->events[idx];
>>>> +		if (!other)
>>>> +			continue;
>>>>  		__icl_update_topdown_event(other, slots, metrics,
>>>>  					   event ? event->hw.saved_slots : 0,
>>>>  					   event ? event->hw.saved_metric : 0);
>>>> @@ -3138,7 +3142,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
>>>>  
>>>>  	for_each_set_bit(bit, (unsigned long *)&guest_pebs_idxs, X86_PMC_IDX_MAX) {
>>>>  		event = cpuc->events[bit];
>>>> -		if (!event->attr.precise_ip)
>>>> +		if (!event || !event->attr.precise_ip)
>>>>  			continue;
>>>>  
>>>>  		perf_sample_data_init(data, 0, event->hw.last_period);
>>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>>> index c0b7ac1c7594..b23c49e2e06f 100644
>>>> --- a/arch/x86/events/intel/ds.c
>>>> +++ b/arch/x86/events/intel/ds.c
>>>> @@ -2480,6 +2480,8 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
>>>>  	 */
>>>>  	for_each_set_bit(bit, (unsigned long *)&pebs_enabled, X86_PMC_IDX_MAX) {
>>>>  		event = cpuc->events[bit];
>>>> +		if (!event)
>>>> +			continue;
>>>>  		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>>>>  			intel_pmu_save_and_restart_reload(event, 0);
>>>>  	}
>>>> @@ -2579,10 +2581,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>>>  			continue;
>>>>  
>>>>  		event = cpuc->events[bit];
>>>> -		if (WARN_ON_ONCE(!event))
>>>> -			continue;
>>>> -
>>>> -		if (WARN_ON_ONCE(!event->attr.precise_ip))
>>>> +		if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
>>>>  			continue;
>>>>  
>>>>  		/* log dropped samples number */
>>>> @@ -2645,9 +2644,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>>>  		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
>>>>  		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
>>>>  			event = cpuc->events[bit];
>>>> -
>>>> -			if (WARN_ON_ONCE(!event) ||
>>>> -			    WARN_ON_ONCE(!event->attr.precise_ip))
>>>> +			if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
>>>>  				continue;
>>>>  
>>>>  			if (counts[bit]++) {
>>>> @@ -2663,6 +2660,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>>>  			continue;
>>>>  
>>>>  		event = cpuc->events[bit];
>>>> +		if (!event)
>>>> +			continue;
>>>>  
>>>>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>>>>  					    counts[bit], setup_pebs_adaptive_sample_data);
>
