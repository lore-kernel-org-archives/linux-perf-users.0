Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A221A5B8F;
	Tue, 20 May 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752447; cv=none; b=UzPzaYsFkL7fSZVOwnoaghtobuIu+i+XxM8Hvk87wnG1nex/NkEcYms919xifZ1kp1I9COiA3SUSfIBiefx6lno/C4IzqDPHyxWrbzEArbB+hD+RdJY45OSL5xM3mXPxd7H5IcQVXhxyqIHowTqN1mjBzvbVFlQdL9GEb4+u//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752447; c=relaxed/simple;
	bh=fwCsx5WLt3ZQeFdDnvmckZt7EDQG19hnTJU+XiWf8Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+yw8cbn/QdEdbkSsEnbmJONzoy0LNNnGVlHv1/X/GIVU/4Keb5/HT/KL4DemDowcZIhXRtbB9vmun4FdcFuPqGsGiYFOTTE9W0iB/NCNwGMTapoOdGF2D7ITLnQUtKbVRw7+DUkygzfKtrh5BwOY+TaU4Ta0B7zCTNuTYmCEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/OpS6Rd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/OpS6Rd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747752446; x=1779288446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fwCsx5WLt3ZQeFdDnvmckZt7EDQG19hnTJU+XiWf8Q4=;
  b=O/OpS6RdPv4toNgoyiptUMTGjiVqQONpo2H0dDoHhQslvgVMqUHLvqYE
   EadWApTvcP3wkr6sEvay2dltQOh0PT9lZNqzCf9sLAGQ4tgp2TnQDcZwy
   sl4XyTt/TFq44AwRU5KCNG5mUmeZxegEvJrIDBvYw2m5DJzZjSqbluweV
   qU9NSm267jRSyXZw/JWH0NaSY4rTCHt+wS3L+dHLnRkjoop4886Wqqif+
   3Y8L6Au45WAs7LRoXkH4QH3FpTXlMFrRUbO1aVUJc7NWD97j6nYv5Iik9
   smGLHeWRPyA1GYe9EwS+S9xf/FD8B6Rax/6G3WCbvE2Yo8/3/LvikgLpQ
   Q==;
X-CSE-ConnectionGUID: ZqYishBvQ5uI8LI2lCK2nQ==
X-CSE-MsgGUID: 56Pn+RlxQPiqnwgslAXTDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="72204919"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72204919"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 07:47:25 -0700
X-CSE-ConnectionGUID: H9dQgZVPS8CRHosJ0NPvsQ==
X-CSE-MsgGUID: CfcfUXyxRMi+OQEaxPM92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="143708067"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 07:47:24 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A768120B5736;
	Tue, 20 May 2025 07:47:22 -0700 (PDT)
Message-ID: <8e2c5349-571d-4436-a10e-ae1a50ed6b1f@linux.intel.com>
Date: Tue, 20 May 2025 10:47:21 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 02/16] perf: Fix the throttle logic for a group
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, irogers@google.com,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, leo.yan@arm.com
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
 <20250516182853.2610284-3-kan.liang@linux.intel.com>
 <aCoynoKRbpnOZ7QE@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aCoynoKRbpnOZ7QE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-18 3:18 p.m., Namhyung Kim wrote:
> Hi Kan,
> 
> On Fri, May 16, 2025 at 11:28:39AM -0700, kan.liang@linux.intel.com wrote:
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
> 
> Thanks for working on this!
> 
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  kernel/events/core.c | 60 ++++++++++++++++++++++++++++++++------------
>>  1 file changed, 44 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index af78ec118e8f..52490c2ce45b 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2739,6 +2739,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
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
>> +static void perf_event_unthrottle_group(struct perf_event *event, bool skip_start_event)
>> +{
>> +	struct perf_event *sibling, *leader = event->group_leader;
>> +
>> +	perf_event_unthrottle(leader, skip_start_event ? leader != event : true);
>> +	for_each_sibling_event(sibling, leader)
>> +		perf_event_unthrottle(sibling, skip_start_event ? sibling != event : true);
> 
> This will add more PERF_RECORD_THROTTLE records for sibling events.

Yes

> Maybe we can generate it for the actual target event only?

The current code cannot track the actual target event for unthrottle.
Because the MAX_INTERRUPTS are set for all events when event_throttle.

But I think we can only add a PERF_RECORD_THROTTLE record for the leader
event, which can reduce the number of THROTTLE records.

The sample right after the THROTTLE record must be generated by the
actual target event. I think it should be good enough for the perf tool
to locate the event.

I will add the below patch as a separate improvement in V4.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 52490c2ce45b..cd559501cfbd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2744,14 +2744,16 @@ static void perf_event_unthrottle(struct
perf_event *event, bool start)
  	event->hw.interrupts = 0;
  	if (start)
  	event->pmu->start(event, 0);
-	perf_log_throttle(event, 1);
+	if (event == event->group_leader)
+		perf_log_throttle(event, 1);
  }

  static void perf_event_throttle(struct perf_event *event)
  {
  	event->pmu->stop(event, 0);
  	event->hw.interrupts = MAX_INTERRUPTS;
-	perf_log_throttle(event, 0);
+	if (event == event->group_leader)
+		perf_log_throttle(event, 0);
  }


> 
> Also the condition for skip_start_event is if it's a freq event.
> I think we can skip pmu->start() if the sibling is also a freq event.

The skip_start_event is if it will be start later separately. It intends
to avoid the double start.

In the perf_adjust_freq_unthr_events(), it will only adjust and start
the leader event, not group. If we skip pmu->start() for a freq sibling
event, it will not start until the next context switch.

Thanks,
Kan

> I remember KVM folks concern about the number of PMU accesses as it
> can cause VM exits.
> 
> Thanks,
> Namhyung
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
>> @@ -4393,12 +4426,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>  
>>  		hwc = &event->hw;
>>  
>> -		if (hwc->interrupts == MAX_INTERRUPTS) {
>> -			hwc->interrupts = 0;
>> -			perf_log_throttle(event, 1);
>> -			if (!is_event_in_freq_mode(event))
>> -				event->pmu->start(event, 0);
>> -		}
>> +		if (hwc->interrupts == MAX_INTERRUPTS)
>> +			perf_event_unthrottle_group(event, is_event_in_freq_mode(event));
>>  
>>  		if (!is_event_in_freq_mode(event))
>>  			continue;
>> @@ -6426,14 +6455,6 @@ static void __perf_event_period(struct perf_event *event,
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
>> @@ -6441,6 +6462,14 @@ static void __perf_event_period(struct perf_event *event,
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
>> +			perf_event_unthrottle_group(event, true);
>>  		perf_pmu_enable(event->pmu);
>>  	}
>>  }
>> @@ -10331,8 +10360,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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
> 

