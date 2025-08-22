Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15359198A11;
	Fri, 22 Aug 2025 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840391; cv=none; b=eBw++XevICdrP6auuydbDgUZZ3xUUKySxw2s/9LsCAm/YOaNCHitWGys38fbmLTXV8wuxkk4vYuDpYo0AAzX5Z8ZxxFNzN5ac6gN6DsFNBEXaNuIvSBnScCSEvYfqMgzNzPb+n5miqkEqvDfjPEWN8r4Muuw/3PW9eeb3eCyrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840391; c=relaxed/simple;
	bh=hv4ee5TJub+glJha2W37KTbYuOGPiCe6LOnDorSPvqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dab2RmwtYcwdSPgmWfiGn5Zt8VVebJ4zvQpRG5Xb6FZeq9T0cfKnRgNpAi6qQpYlXnRWddCce9X+yfwhCJXG6a1sX2FyBPXUD7iI+X7swU+Vnv/Flrubnb5lxpGYL45a5jlZpsmiRTaUE4EVEcazTTesC0/TMD/BfqYv9iRlvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWIwXN7m; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWIwXN7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755840389; x=1787376389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hv4ee5TJub+glJha2W37KTbYuOGPiCe6LOnDorSPvqo=;
  b=mWIwXN7mtoRV/gWlZGa6eIKsZEhzugNXQ5KiJc/PersBH/nezCkuoFC3
   71SU2ebKFg/RRVFSA0H9FoS4bMnY6vg0dKbmJ4fAH1EXZLN2s0J5B8zHy
   hpItanhHzxQgK+oz3vUae/3TxqL4v1vqRNi+wVEbsk+9Po4FKavaR/lMG
   C8g1HUpVdQpPTu3VUaMU7Iei8ugVsnVWTCQIh6Sd0Kaa2Brv/V0t9jRSX
   r5E/lNLd9/DNUrQ+yR92HRM/p+hpL6ZIHBCzLD4uFh96onKny2eGMjhdz
   LK9b4vyNma976CrwWml5mJeoKbfdJDUwu1fpoSHviG540NUO9jS+rAXJg
   w==;
X-CSE-ConnectionGUID: lx2qGbxuQ+OLFXKXk/e7kQ==
X-CSE-MsgGUID: Dfd9va2rQMWb040iU7WxVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60771401"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60771401"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 22:26:29 -0700
X-CSE-ConnectionGUID: N5z1rdvXQjyfULYXn/Gqyg==
X-CSE-MsgGUID: 7SXXW3lKRXeoGy/j1TSTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199578767"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.125]) ([10.124.233.125])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 22:26:25 -0700
Message-ID: <683367fc-4295-41f5-b10d-3c120f54ca0f@linux.intel.com>
Date: Fri, 22 Aug 2025 13:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/7] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 kernel test robot <oliver.sang@intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <20250820023032.17128-4-dapeng1.mi@linux.intel.com>
 <20250821133514.GP4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250821133514.GP4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/21/2025 9:35 PM, Peter Zijlstra wrote:
> On Wed, Aug 20, 2025 at 10:30:28AM +0800, Dapeng Mi wrote:
>> When intel_pmu_drain_pebs_icl() is called to drain PEBS records, the
>> perf_event_overflow() could be called to process the last PEBS record.
>>
>> While perf_event_overflow() could trigger the interrupt throttle and
>> stop all events of the group, like what the below call-chain shows.
>>
>> perf_event_overflow()
>>   -> __perf_event_overflow()
>>     ->__perf_event_account_interrupt()
>>       -> perf_event_throttle_group()
>>         -> perf_event_throttle()
>>           -> event->pmu->stop()
>>             -> x86_pmu_stop()
>>
>> The side effect of stopping the events is that all corresponding event
>> pointers in cpuc->events[] array are cleared to NULL.
>>
>> Assume there are two PEBS events (event a and event b) in a group. When
>> intel_pmu_drain_pebs_icl() calls perf_event_overflow() to process the
>> last PEBS record of PEBS event a, interrupt throttle is triggered and
>> all pointers of event a and event b are cleared to NULL. Then
>> intel_pmu_drain_pebs_icl() tries to process the last PEBS record of
>> event b and encounters NULL pointer access.
>>
>> Since the left PEBS records have been processed when stopping the event,
>> check and skip to process the last PEBS record if cpuc->events[*] is
>> NULL.
>>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
>> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Tested-by: kernel test robot <oliver.sang@intel.com>
>> ---
>>  arch/x86/events/intel/ds.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index c0b7ac1c7594..dcf29c099ad2 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2663,6 +2663,16 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>  			continue;
>>  
>>  		event = cpuc->events[bit];
>> +		/*
>> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
>> +		 * could trigger interrupt throttle and clear all event pointers of the
>> +		 * group in cpuc->events[] to NULL. So need to re-check if cpuc->events[*]
>> +		 * is NULL, if so it indicates the event has been throttled (stopped) and
>> +		 * the corresponding last PEBS records have been processed in stopping
>> +		 * event, don't need to process it again.
>> +		 */
>> +		if (!event)
>> +			continue;
>>  
>>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>>  					    counts[bit], setup_pebs_adaptive_sample_data);
>
> So if this is due to __intel_pmu_pebs_last_event() calling into
> perf_event_overflow(); then isn't intel_pmu_drain_pebs_nhm() similarly
> affected?
>
> And worse, the _nhm() version would loose all events for that counter,
> not just the last.

hmm, Yes. After double check, I suppose I made a mistake for the answer to
Andi. It indeed has data loss since the "ds->pebs_index" is reset at the
head of _nhm()/_icl() these drain_pebs helper instead of the end of the
drain_pebs helper.  :(

> I'm really thinking this isn't the right thing to do.
>
>
> How about we audit the entirety of arch/x86/events/ for cpuc->events[]
> usage and see if we can get away with changing x86_pmu_stop() to simply
> not clearing that field.

Checking current code, I suppose it's fine that we don't clear
cpuc->events[] in x86_pmu_stop() since we already have another variable
"cpuc->active_mask" which is used to indicate if the corresponding
cpuc->events[*] is active. But in current code, the cpuc->active_mask is
not always checked.

So if we select not to clear cpuc->events[] in x86_pmu_stop(), then it's a
must to check cpuc->active_mask before really accessing cpuc->events[]
represented event. Maybe we can add an inline function got check this.

bool inline x86_pmu_cntr_event_active(int idx)
{
    struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);

    return cpuc->events[idx] && test_bit(idx, cpuc->active_mask);
}

>
> Or perhaps move the setting and clearing into x86_pmu_{add,del}() rather
> than x86_pmu_{start,stop}(). After all, the latter don't affect the
> counter placement, they just stop/start the event.

IIUC, we could not move the setting into x86_pmu_add() from x86_pmu_stop()
since the counter index is not finalized at x86_pmu_add() is called. The
counter index could change for each adding a new event.


>
>
