Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A153288A8;
	Wed,  7 May 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644421; cv=none; b=EP80GBLObcDVdyMcyGw0qqlREiiD2ggv3VzHpydcKVttpQI5NWehkAMpSrlB6Y0X8prmql407CvbRKwRZhaavtQw3SzFwDT2cuessKUASao8UrdIPxMc0lA5WAbdyn98Ls93eCK9irmi1txu9G5DCKVKVLWyDjSs1+ZyqByQuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644421; c=relaxed/simple;
	bh=USX6FAqWSVkUvdozW1YSUNHnrgBTtmTgFmQVyOR+QyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgOyt4c8r+YygEe2olK/EYaFLZSTX/YyurdIqfn+42D+EirUyngLHm296+kv0yVu2mpv82Un0nZZQ8/nesOn0cWj8rTASloQsA3FXVo93NOdpGUskhBuG4DjYW6sHPMCEmQheCuzENSACpaJKE+ObWQ1gsh5JXzFIOYCuvNMTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVdEAGob; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVdEAGob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746644419; x=1778180419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=USX6FAqWSVkUvdozW1YSUNHnrgBTtmTgFmQVyOR+QyI=;
  b=OVdEAGobjFs/8rbZ75GvDB+CBI9ndHHEcWIaniY1YIP00qiN1uqtvp+9
   KiZgkv2HhKAj6OttZGKKDeubdNgAUJlnsd0ByRUIEijfJS/oyP+PwOUFt
   sYJjHgTR7tMryi6f203NgvTiHtqjDuluoPw8KvORqdUQogVr4im73YQov
   +7dcjRxDgA4UJ5X5FYTF6OHHr4qSwwKzts3tpUXu5rNoSMiCVPl9GL+5+
   k4dq48bBMiIOWLhAGF7eDzcvZMuRXNY+xmiS8L/OPgL73++P523Jge2UZ
   57YjQULItYxUrraVaj8fxygh07hjGnZrXyhXAWf4y7puBeHOn5d2dXfqV
   A==;
X-CSE-ConnectionGUID: SvoR9Z9BRhaTWk9HVi4lIQ==
X-CSE-MsgGUID: CUOqI4mhRr+Be3ZZ6Tt3pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59751716"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="59751716"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:00:15 -0700
X-CSE-ConnectionGUID: 56oCpVE4RmaODxm5zq1IkA==
X-CSE-MsgGUID: ua2mQBpMS9CNcZFkzpc1uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="141248740"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:00:15 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 32C8920B5736;
	Wed,  7 May 2025 12:00:14 -0700 (PDT)
Message-ID: <3b088d08-2c01-4290-8497-2855935bf8af@linux.intel.com>
Date: Wed, 7 May 2025 15:00:13 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/15] perf: Fix the throttle logic for a group
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
 <20250506164740.1317237-2-kan.liang@linux.intel.com>
 <CAP-5=fXgLJR2EQoK3SVrGWOKVWuZ4+ZVWFHLU8B_w2ibWtFzwg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXgLJR2EQoK3SVrGWOKVWuZ4+ZVWFHLU8B_w2ibWtFzwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-05-07 12:52 p.m., Ian Rogers wrote:
> On Tue, May 6, 2025 at 9:48 AM <kan.liang@linux.intel.com> wrote:
>>
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
>> events. However, for all ARCHs, the implementation is similar. It only
>> disable the event, rather than the group.
>>
>> The logic to disable the group should be generic for all ARCHs. Add the
>> logic in the generic code. The following patch will remove the buggy
>> driver-specific implementation.
>>
>> The throttle only happens when an event is overflowed. Stop the entire
>> group when any event in the group triggers the throttle. Set the
>> MAX_INTERRUPTS to the leader event to indicate the group is throttled.
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
> Thanks Kan! The patches look good to me. As I understand it patches 2
> to 15 are just removing the logic where an event is unnecessarily
> stopped twice, so is it possible to test just this patch in isolation?
> Given the logic is generic it is applied to software events, so you
> should be able to repeat the problem with `perf record -e
> "{cpu-clock,cpu-clock}:S" ...` possibly by reducing the period or
> increasing the frequency. 

I don't think the exact same value between the two cpu-clock events in a
group can be got.
The SW clock events work differently. It relies on per-event hrtimer
rather than the overflow interrupt. I don't think there is a global
control for SW events. Strictly, it doesn't support "group".

The above result should only be observed on a PMU, e.g., Intel PMU, that
strictly supports "group".

For a PMU which doesn't strictly support "group", the patch should just
minimize the impact from the throttle logic. It's hard to demonstrate.

> This would be nice to show that it fixes the
> problem more generically than just the Intel PMU.

I only have Intel machines.
Hope people from AMD, ARM, or POWER can give it a try.

Thanks,
Kan>
> Ian
> 
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  kernel/events/core.c | 55 +++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 41 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a84abc2b7f20..eb0dc871f4f1 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2734,6 +2734,38 @@ void perf_event_disable_inatomic(struct perf_event *event)
>>  static void perf_log_throttle(struct perf_event *event, int enable);
>>  static void perf_log_itrace_start(struct perf_event *event);
>>
>> +static void perf_event_group_unthrottle(struct perf_event *event, bool start_event)
>> +{
>> +       struct perf_event *leader = event->group_leader;
>> +       struct perf_event *sibling;
>> +
>> +       if (leader != event || start_event)
>> +               leader->pmu->start(leader, 0);
>> +       leader->hw.interrupts = 0;
>> +
>> +       for_each_sibling_event(sibling, leader) {
>> +               if (sibling != event || start_event)
>> +                       sibling->pmu->start(sibling, 0);
>> +               sibling->hw.interrupts = 0;
>> +       }
>> +
>> +       perf_log_throttle(leader, 1);
>> +}
>> +
>> +static void perf_event_group_throttle(struct perf_event *event)
>> +{
>> +       struct perf_event *leader = event->group_leader;
>> +       struct perf_event *sibling;
>> +
>> +       leader->hw.interrupts = MAX_INTERRUPTS;
>> +       leader->pmu->stop(leader, 0);
>> +
>> +       for_each_sibling_event(sibling, leader)
>> +               sibling->pmu->stop(sibling, 0);
>> +
>> +       perf_log_throttle(leader, 0);
>> +}
>> +
>>  static int
>>  event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
>>  {
>> @@ -4389,10 +4421,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>                 hwc = &event->hw;
>>
>>                 if (hwc->interrupts == MAX_INTERRUPTS) {
>> -                       hwc->interrupts = 0;
>> -                       perf_log_throttle(event, 1);
>> -                       if (!event->attr.freq || !event->attr.sample_freq)
>> -                               event->pmu->start(event, 0);
>> +                       perf_event_group_unthrottle(event,
>> +                               !event->attr.freq || !event->attr.sample_freq);
>>                 }
>>
>>                 if (!event->attr.freq || !event->attr.sample_freq)
>> @@ -6421,14 +6451,6 @@ static void __perf_event_period(struct perf_event *event,
>>         active = (event->state == PERF_EVENT_STATE_ACTIVE);
>>         if (active) {
>>                 perf_pmu_disable(event->pmu);
>> -               /*
>> -                * We could be throttled; unthrottle now to avoid the tick
>> -                * trying to unthrottle while we already re-started the event.
>> -                */
>> -               if (event->hw.interrupts == MAX_INTERRUPTS) {
>> -                       event->hw.interrupts = 0;
>> -                       perf_log_throttle(event, 1);
>> -               }
>>                 event->pmu->stop(event, PERF_EF_UPDATE);
>>         }
>>
>> @@ -6436,6 +6458,12 @@ static void __perf_event_period(struct perf_event *event,
>>
>>         if (active) {
>>                 event->pmu->start(event, PERF_EF_RELOAD);
>> +               /*
>> +                * We could be throttled; unthrottle now to avoid the tick
>> +                * trying to unthrottle while we already re-started the event.
>> +                */
>> +               if (event->group_leader->hw.interrupts == MAX_INTERRUPTS)
>> +                       perf_event_group_unthrottle(event, false);
>>                 perf_pmu_enable(event->pmu);
>>         }
>>  }
>> @@ -10326,8 +10354,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>>         if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
>>                 __this_cpu_inc(perf_throttled_count);
>>                 tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
>> -               hwc->interrupts = MAX_INTERRUPTS;
>> -               perf_log_throttle(event, 0);
>> +               perf_event_group_throttle(event);
>>                 ret = 1;
>>         }
>>
>> --
>> 2.38.1
>>
> 

