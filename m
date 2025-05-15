Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C22E29995C;
	Thu, 15 May 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313759; cv=none; b=Nf3OcWm5t3WbVfdY2Q9jhSuTV8U6IjDx/LtQFymhVMrY4h4F9bYbIWx7B/mGqgs5WTZqDTAX0Nb+7CFZ2mUOxAkLAQuXXH9cwOxi1+O6vixNGelmSEMIQnOs7ARVukACp5i3vIxj/S4WHsgWyptzlZVML+0DDqfUx/eGPU/KyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313759; c=relaxed/simple;
	bh=/UPaLoHrddNLbUn4Gl4Qnrk7JCOj1PaZElu2uhtUnBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEOfwm8lEuiaAKEHSJYyqAXjpedqp0k/98lF7ig/kMzgqZ+Pu+84JECsGiI1l2IxosnDZ65Wbc7fin1rYkHbjx0q0G+IGVQ0mgSSd+6O0zSVQ96aZ/ee9n42nKuwPb4/Nh+rrFoLyzTedd9mOMmgCkD4Z2lGONY6NLYhQOgrPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=givRzcZf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="givRzcZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747313758; x=1778849758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/UPaLoHrddNLbUn4Gl4Qnrk7JCOj1PaZElu2uhtUnBM=;
  b=givRzcZflhELqhy+hl5Z7OezqrfbYVTlpqYW3u6TnSx7xbs5p8HSnYSn
   dP+hg3hHmWzLeAAy8BbGlQJx8zOkVIF7tVdlGdbd3Yn0HE9d7LZLpKhgy
   ZvPQHm76XtgYJ2V5EypR3fVs2ekb5D75txWYJsAvepkaZjCaJ1DzRdEax
   n489xWN/jN8jkr4lWF5o79XncErxmFg8hurhg8JJXSKVLWu7yLlPid00o
   lRspS53Bbigp8QNjpsYjo2jFe1YjY2ZX8gu15fXDiRtIhA+Jg+DfB+mju
   SSnLdt8VJDZaUjNsjYa8NOlbCVbNoFePCuafMdlZAXb+LszEXup6aIeuN
   A==;
X-CSE-ConnectionGUID: 3VGrFW+5Tjet9bEPpap8Ug==
X-CSE-MsgGUID: +VaPTpjFSPycXqj9cwqU1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49383691"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="49383691"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:55:57 -0700
X-CSE-ConnectionGUID: m5Tos1AaRqm1HtzVEP/+qw==
X-CSE-MsgGUID: SiOtB6pBT2mpVjmCiYL4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138862525"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:55:57 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 413C720B5736;
	Thu, 15 May 2025 05:55:06 -0700 (PDT)
Message-ID: <4a44b8cb-7c73-4926-8b9f-1f63929ea48f@linux.intel.com>
Date: Thu, 15 May 2025 08:55:05 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/15] perf: Fix the throttle logic for a group
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-2-kan.liang@linux.intel.com>
 <20250515094300.GC412060@e132581.arm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250515094300.GC412060@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-15 5:43 a.m., Leo Yan wrote:
> On Wed, May 14, 2025 at 08:13:47AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The current throttle logic doesn't work well with a group, e.g., the
>> following sampling-read case.
>>
>> $ perf record -e "{cycles,cycles}:S" ...
>>
>> $ perf report -D | grep THROTTLE | tail -2
>>             THROTTLE events:        426  ( 9.0%)
>>           UNTHROTTLE events:        425  ( 9.0%)
>>
>> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
>> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
>> ... sample_read:
>> .... group nr 2
>> ..... id 0000000000000327, value 000000000cbb993a, lost 0
>> ..... id 0000000000000328, value 00000002211c26df, lost 0
>>
>> The second cycles event has a much larger value than the first cycles
>> event in the same group.
>>
>> The current throttle logic in the generic code only logs the THROTTLE
>> event. It relies on the specific driver implementation to disable
>> events. For all ARCHs, the implementation is similar. Only the event is
>> disabled, rather than the group.
>>
>> The logic to disable the group should be generic for all ARCHs. Add the
>> logic in the generic code. The following patch will remove the buggy
>> driver-specific implementation.
>>
>> The throttle only happens when an event is overflowed. Stop the entire
>> group when any event in the group triggers the throttle.
>> The MAX_INTERRUPTS is set to all throttle events.
>>
>> The unthrottled could happen in 3 places.
>> - event/group sched. All events in the group are scheduled one by one.
>>   All of them will be unthrottled eventually. Nothing needs to be
>>   changed.
>> - The perf_adjust_freq_unthr_events for each tick. Needs to restart the
>>   group altogether.
>> - The __perf_event_period(). The whole group needs to be restarted
>>   altogether as well.
>>
>> With the fix,
>> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
>> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
>> ... sample_read:
>> .... group nr 2
>> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
>> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> Changes since V1:
>> - Apply the suggested throttle/unthrottle functions from Peter.
>>   The MAX_INTERRUPTS and throttle logs are applied to all events.
>> - Update the description and comments accordingly
>>
>>  kernel/events/core.c | 58 +++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 44 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a84abc2b7f20..a270fcda766d 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2734,6 +2734,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
>>  static void perf_log_throttle(struct perf_event *event, int enable);
>>  static void perf_log_itrace_start(struct perf_event *event);
>>  
>> +static void perf_event_unthrottle(struct perf_event *event, bool start)
>> +{
>> +	event->hw.interrupts = 0;
>> +	if (start)
>> +		event->pmu->start(event, 0);
>> +	perf_log_throttle(event, 1);
>> +}
>> +
>> +static void perf_event_throttle(struct perf_event *event)
>> +{
>> +	event->pmu->stop(event, 0);
>> +	event->hw.interrupts = MAX_INTERRUPTS;
>> +	perf_log_throttle(event, 0);
>> +}
>> +
>> +static void perf_event_unthrottle_group(struct perf_event *event, bool start)
>> +{
>> +	struct perf_event *sibling, *leader = event->group_leader;
>> +
>> +	perf_event_unthrottle(leader, leader != event || start);
>> +	for_each_sibling_event(sibling, leader)
>> +		perf_event_unthrottle(sibling, sibling != event || start);
> 
> Seems to me that the condition "leader != event || start" is bit tricky
> (similarly for the check "sibling != event || start").
> 
> If a session sets the frequency (with option -F in perf tool), the
> following flow is triggered:
> 
>   perf_adjust_freq_unthr_events()
>     `> perf_event_unthrottle_group(event, false);
> 
> The argument "start" is false, so all sibling events will be enabled,
> but the event pointed by the "event" argument remains disabled.  

Right. Because the following code will adjust the period of the event
and start it.
The PMU is disabled at the moment. There is no difference in starting
the leader first or the member first.

> Though
> the __perf_event_period() function will enables all events with adjusted
> period, but it is still risky for counting discrepancy caused by the
> flow described above.

The __perf_event_period() is similar. The event in both cases has to
adjust the period before re-start the event, which has to be done
outside of the perf_event_unthrottle_group().

Thanks,
Kan>
> Thanks,
> Leo
> 
>> +}
>> +
>> +static void perf_event_throttle_group(struct perf_event *event)
>> +{
>> +	struct perf_event *sibling, *leader = event->group_leader;
>> +
>> +	perf_event_throttle(leader);
>> +	for_each_sibling_event(sibling, leader)
>> +		perf_event_throttle(sibling);
>> +}
>> +
>>  static int
>>  event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
>>  {
>> @@ -4389,10 +4422,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>  		hwc = &event->hw;
>>  
>>  		if (hwc->interrupts == MAX_INTERRUPTS) {
>> -			hwc->interrupts = 0;
>> -			perf_log_throttle(event, 1);
>> -			if (!event->attr.freq || !event->attr.sample_freq)
>> -				event->pmu->start(event, 0);
>> +			perf_event_unthrottle_group(event,
>> +				!event->attr.freq || !event->attr.sample_freq);
>>  		}
>>  
>>  		if (!event->attr.freq || !event->attr.sample_freq)
>> @@ -6421,14 +6452,6 @@ static void __perf_event_period(struct perf_event *event,
>>  	active = (event->state == PERF_EVENT_STATE_ACTIVE);
>>  	if (active) {
>>  		perf_pmu_disable(event->pmu);
>> -		/*
>> -		 * We could be throttled; unthrottle now to avoid the tick
>> -		 * trying to unthrottle while we already re-started the event.
>> -		 */
>> -		if (event->hw.interrupts == MAX_INTERRUPTS) {
>> -			event->hw.interrupts = 0;
>> -			perf_log_throttle(event, 1);
>> -		}
>>  		event->pmu->stop(event, PERF_EF_UPDATE);
>>  	}
>>  
>> @@ -6436,6 +6459,14 @@ static void __perf_event_period(struct perf_event *event,
>>  
>>  	if (active) {
>>  		event->pmu->start(event, PERF_EF_RELOAD);
>> +		/*
>> +		 * Once the period is force-reset, the event starts immediately.
>> +		 * But the event/group could be throttled. Unthrottle the
>> +		 * event/group now to avoid the next tick trying to unthrottle
>> +		 * while we already re-started the event/group.
>> +		 */
>> +		if (event->hw.interrupts == MAX_INTERRUPTS)
>> +			perf_event_unthrottle_group(event, false);
>>  		perf_pmu_enable(event->pmu);
>>  	}
>>  }
>> @@ -10326,8 +10357,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>>  	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
>>  		__this_cpu_inc(perf_throttled_count);
>>  		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
>> -		hwc->interrupts = MAX_INTERRUPTS;
>> -		perf_log_throttle(event, 0);
>> +		perf_event_throttle_group(event);
>>  		ret = 1;
>>  	}
>>  
>> -- 
>> 2.38.1
>>
>>
> 

