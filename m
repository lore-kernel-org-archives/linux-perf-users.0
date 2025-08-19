Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7A311584;
	Tue, 19 Aug 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595620; cv=none; b=JwAlvOvvbxZ41rYp/d2hGXrjfI+0qW+eEV0vwfj6KbGDy7KmjAvoyo8Y2CHItY87JO5lViG7LqDp3A2PrDo4JtYFJxYba7hTO4NKr1NGGj1pffgafkotojSrYDJTx9PQj0cVDg3lqxw//x6ifvLjE0zrdc7v3hXzXll9bL04SEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595620; c=relaxed/simple;
	bh=U8DmyOBMiH/TPUekD8zVfK/dWQN0kajcnpXGLIP/6qs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dw5SIj+9gFOLo5882UMP1n5y/y3FGuFIAWMrBy71k/PGp8nxy5zEYHITGVQ7Ey0SLk8KoS50h09S6iml8uKIQKs8dP/Y6si/b5gMoNmeyjjfliTRfQUhY3NoeloKWIabTpP+l9znXVO5aTCeF/oEMsLZ81pdHZjsjInmVqLGz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMRA8hat; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMRA8hat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755595619; x=1787131619;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=U8DmyOBMiH/TPUekD8zVfK/dWQN0kajcnpXGLIP/6qs=;
  b=FMRA8hat2mMKnB8eoYrawUzAgwdkqiB4dM780Gfu2KYhgyxetkesBOHX
   NoBYL9QjQWSbWVb6X4dWJn48fqsYSFIP5KzihWip7ouwu9wRCmImXr63L
   hmhQGx2hI/sf7MlmYsKkd89LaK4mcXQT7gCR/Gn6xfAQPO6TlrPkqV35k
   VNUTqC1wxd0+6hDg58+nxAAqlZlA4Go4IjR6xel28Bf9v2Xf/SfBjuuGR
   RIq+/3cLxUMPmiEk7KnBGFiRCVPqcZnzppoB1Wxp5UM8pV+kkxMFUwuxx
   8it6JmTCscjnSJCI34mWBjyuaM3yBJk28T52/lAIg3rie2Mp48MCK3ynT
   g==;
X-CSE-ConnectionGUID: 1TEyxSdRSHOUPO/9uwXmcw==
X-CSE-MsgGUID: CtmF3PSDR56ZsQALCGlcmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="45406966"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="45406966"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 02:26:58 -0700
X-CSE-ConnectionGUID: uNy7zEt4QD+kf/ElVlRpSg==
X-CSE-MsgGUID: 3KCZXN55S9Kkp+9ZAesGVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168046932"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.36]) ([10.124.240.36])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 02:26:54 -0700
Message-ID: <40af9ef5-26f5-4796-8cd1-b9da882d2e7e@linux.intel.com>
Date: Tue, 19 Aug 2025 17:26:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/6] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 kernel test robot <oliver.sang@intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
 <20250811090034.51249-4-dapeng1.mi@linux.intel.com>
 <20250819084542.GG3245006@noisy.programming.kicks-ass.net>
 <efa3039a-0d79-4e8a-bb97-647c625197b5@linux.intel.com>
Content-Language: en-US
In-Reply-To: <efa3039a-0d79-4e8a-bb97-647c625197b5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/19/2025 5:21 PM, Mi, Dapeng wrote:
> On 8/19/2025 4:45 PM, Peter Zijlstra wrote:
>> On Mon, Aug 11, 2025 at 05:00:31PM +0800, Dapeng Mi wrote:
>>> The PMI handler could disable some events as the interrupt throttling
>>> and clear the corresponding items in cpuc->events[] array.
>>>
>>> perf_event_overflow()
>>>   -> __perf_event_overflow()
>>>     ->__perf_event_account_interrupt()
>>>       -> perf_event_throttle_group()
>>>         -> perf_event_throttle()
>>>           -> event->pmu->stop()
>>>             -> x86_pmu_stop()
>>>
>>> Moreover PMI is NMI on x86 platform and it could interrupt other perf
>>> code like setup_pebs_adaptive_sample_data(). 
>> Uhh, how? AFAICT we only do drain_pebs() from the PMI itself, or disable
>> the PMU first by clearing GLOBAL_CTRL.
>>
>>> So once PMI handling
>>> finishes and returns into setup_pebs_adaptive_sample_data() and it could
>>> find the cpuc->events[*] becomes NULL and accessing this NULL pointer
>>> triggers an invalid memory access and leads to kernel crashes eventually.
>>>
>>> Thus add NULL check before accessing cpuc->events[*] pointer.
>> This doesn't seem fully thought through.
>>
>> If we do this NULL check, then the active_mask bittest is completely
>> superfluous and can be removed, no?
>>
>> Also, what about this race:
>>
>> 	event = cpuc->events[idx]; // !NULL;
>> 	<PMI>
>> 		x86_pmu_stop()
>> 		  cpuc->events[idx] = NULL;
>> 	</PMI>
>> 	... uses event
>>
>> Worse, since it is a 'normal' load, it is permitted for the compiler to
>> re-issue the load, at which point it will still explode. IOW, it should
>> be READ_ONCE(), *if* we can live with the above race at all. Can we?
>>
>> First though, you need to explain how we get here. Because drain_pebs()
>> nesting would be *BAD*.
> I suppose I made a mistake on explaining why the issue happens. Since I
> can't reproduce this issue locally (Synced with Oliver and the issue seems
> can be produced on a specific SPR model), I can only guess the root case. I
> originally thought drain_pebs() helper could be interrupted by PMI and then
> cause the issue, but as Kan said, it's not true as PMU is always disabled
> before draining PEBS buffer.
>
> So after thinking twice,  I suppose the reason should be
>
>     When intel_pmu_drain_pebs_icl() is called to drain PEBS records, the
>     perf_event_overflow() could be called to process the last PEBS record.
>
>     While perf_event_overflow() could trigger the interrupt throttle and
>     stop all events of the group, like what the below call-chain shows.
>
>     perf_event_overflow()
>       -> __perf_event_overflow()
>         ->__perf_event_account_interrupt()
>           -> perf_event_throttle_group()
>             -> perf_event_throttle()
>               -> event->pmu->stop()
>                 -> x86_pmu_stop()
>
>     The side effect of stopping the events is that all corresponding event
>     pointers in cpuc->events[] array are cleared to NULL.
>
>     Assume there are two PEBS events (event a and event b) in a group. When
>     intel_pmu_drain_pebs_icl() calls perf_event_overflow() to process the
>     last PEBS record of PEBS event a, interrupt throttle is triggered and
>     all pointers of event a and event b are cleared to NULL. Then
>     intel_pmu_drain_pebs_icl() tries to process the last PEBS record of
>     event b and encounters NULL pointer access.
>
> I would cook a v3 patch to update the commit message and code. Thanks.

Forgot to say, for this scenario, suppose we can directly skip to process
the last PEBS record if the event pointer is NULL since the last PEBS
record has been processed when stopping the event previously.


>
>
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
>>> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Tested-by: kernel test robot <oliver.sang@intel.com>
>>> ---
>>>  arch/x86/events/core.c       |  3 +++
>>>  arch/x86/events/intel/core.c |  6 +++++-
>>>  arch/x86/events/intel/ds.c   | 13 ++++++-------
>>>  3 files changed, 14 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index 7610f26dfbd9..f0a3bc57157d 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -1711,6 +1711,9 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>>>  			continue;
>>>  
>>>  		event = cpuc->events[idx];
>>> +		if (!event)
>>> +			continue;
>>> +
>>>  		last_period = event->hw.last_period;
>>>  
>>>  		val = static_call(x86_pmu_update)(event);
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 15da60cf69f2..386717b75a09 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -2718,6 +2718,8 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
>>>  		if (!is_topdown_idx(idx))
>>>  			continue;
>>>  		other = cpuc->events[idx];
>>> +		if (!other)
>>> +			continue;
>>>  		other->hw.saved_slots = slots;
>>>  		other->hw.saved_metric = metrics;
>>>  	}
>>> @@ -2761,6 +2763,8 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end,
>>>  		if (!is_topdown_idx(idx))
>>>  			continue;
>>>  		other = cpuc->events[idx];
>>> +		if (!other)
>>> +			continue;
>>>  		__icl_update_topdown_event(other, slots, metrics,
>>>  					   event ? event->hw.saved_slots : 0,
>>>  					   event ? event->hw.saved_metric : 0);
>>> @@ -3138,7 +3142,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
>>>  
>>>  	for_each_set_bit(bit, (unsigned long *)&guest_pebs_idxs, X86_PMC_IDX_MAX) {
>>>  		event = cpuc->events[bit];
>>> -		if (!event->attr.precise_ip)
>>> +		if (!event || !event->attr.precise_ip)
>>>  			continue;
>>>  
>>>  		perf_sample_data_init(data, 0, event->hw.last_period);
>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>> index c0b7ac1c7594..b23c49e2e06f 100644
>>> --- a/arch/x86/events/intel/ds.c
>>> +++ b/arch/x86/events/intel/ds.c
>>> @@ -2480,6 +2480,8 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
>>>  	 */
>>>  	for_each_set_bit(bit, (unsigned long *)&pebs_enabled, X86_PMC_IDX_MAX) {
>>>  		event = cpuc->events[bit];
>>> +		if (!event)
>>> +			continue;
>>>  		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>>>  			intel_pmu_save_and_restart_reload(event, 0);
>>>  	}
>>> @@ -2579,10 +2581,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>>  			continue;
>>>  
>>>  		event = cpuc->events[bit];
>>> -		if (WARN_ON_ONCE(!event))
>>> -			continue;
>>> -
>>> -		if (WARN_ON_ONCE(!event->attr.precise_ip))
>>> +		if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
>>>  			continue;
>>>  
>>>  		/* log dropped samples number */
>>> @@ -2645,9 +2644,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>>  		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
>>>  		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
>>>  			event = cpuc->events[bit];
>>> -
>>> -			if (WARN_ON_ONCE(!event) ||
>>> -			    WARN_ON_ONCE(!event->attr.precise_ip))
>>> +			if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
>>>  				continue;
>>>  
>>>  			if (counts[bit]++) {
>>> @@ -2663,6 +2660,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>>  			continue;
>>>  
>>>  		event = cpuc->events[bit];
>>> +		if (!event)
>>> +			continue;
>>>  
>>>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>>>  					    counts[bit], setup_pebs_adaptive_sample_data);
>>> -- 
>>> 2.34.1
>>>
