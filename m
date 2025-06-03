Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D73221FB1;
	Tue,  3 Jun 2025 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982172; cv=none; b=tntBeCXsIemwSl2RWvgyv99O12H2cb1jTIwouUXnOgvzFAg8gPRM6zYnFbS59/9+WxhmdFpMnqt5H7ireyfpUZ7u3KZ4Mh92+VP4T3JnMq7vxL3GSHzcgnlkAhgC7+oxDAuSngLwezaV+y6jXeTE5/+oszgoR/7Z0lZXvmgv0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982172; c=relaxed/simple;
	bh=N89cRnHvv1Hm7SUg0rGql42+3NsIqu7kNkk+aRE7gPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me6aStX4XDMY3/zEIDyvzbelL+4AYJB2c4T0+f0ofKFISnHstV+2933csIq3fTlUr1yUeFDSCR/EYJWu3bg7XXBifHcZ6wDp/B/QTiU/X8xaQ9Pw3mdJ8dE2sCT6Eatw4MWLYH27E/N4Lga5g+fQZhX8sY8gZUs4g4Fq0NIvzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUShLuT6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUShLuT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748982171; x=1780518171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N89cRnHvv1Hm7SUg0rGql42+3NsIqu7kNkk+aRE7gPg=;
  b=JUShLuT6dhf7IdtZggoPIJqoF3mwoJ5BtQCHe4fX5PFI3qPm8D8ObTn6
   8z4bJmj0N4NISTtqXRZvAuo2vE6k3dXr+cbMnJ3HhD8iREJwJUa7RVaF+
   x+LYFNyPEmvZUBAxLP25TtvFSnrdipm+U/DGOXwTxh9RV2B9D4RdxXPg+
   cTZoOoR0s8zKOg8yaumL3MNBUIiGu675NEA7+VA8Oy0n0iX3C381ijqlL
   VHhrgBC6Z0KwocFtg6ldx2AjDy3tL3ITe2DEZZLX2U9+Z8UlqYRvuABML
   rt0XMcGuzG3n3NezmkDI9+exl34NiNOJGsLHZbaJF2NmlmOOArGq2JHlZ
   g==;
X-CSE-ConnectionGUID: xTqoz7+WTOO1CtDfXu0rgg==
X-CSE-MsgGUID: di5ZClMFRRiX/bQ5m8iMVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54703808"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="54703808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 13:22:50 -0700
X-CSE-ConnectionGUID: FWzugVgRQ9Kyypvn0HHYjA==
X-CSE-MsgGUID: J9eBQXsDQy2R5Fxnn6KLVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="175908057"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 13:22:50 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4CA4720B5736;
	Tue,  3 Jun 2025 13:22:48 -0700 (PDT)
Message-ID: <50ed4910-381a-40cf-bdc5-e008a5b28efb@linux.intel.com>
Date: Tue, 3 Jun 2025 16:22:47 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf: Fix the throttle error of some clock events
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, leo.yan@arm.com, Aishwarya TCV <aishwarya.tcv@arm.com>
References: <20250528175832.2999139-1-kan.liang@linux.intel.com>
 <CAP-5=fUr0nqZ9KNsATeN64GHwUkHA4+uFpy34woOnboAVnOHgg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUr0nqZ9KNsATeN64GHwUkHA4+uFpy34woOnboAVnOHgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-06-03 12:35 p.m., Ian Rogers wrote:
> On Wed, May 28, 2025 at 10:59 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The Arm CI reports RCU stall, which can be reproduced by the below perf
>> command.
>>   perf record -a -e cpu-clock -- sleep 2
>>
>> The cpu-clock and task_clock are two special SW events, which rely on
>> the hrtimer. Instead of invoking the stop(), the HRTIMER_NORESTART is
>> returned to stop the timer. Because the hrtimer interrupt handler cannot
>> cancel itself, which causes infinite loop.
> 
> I'm having a hard time understanding this. Currently in the code we
> have two PMUs for cpu_clock and task_clock:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/kernel/events/core.c#n10729
> ```
> static struct pmu perf_cpu_clock; /* fwd declaration */
> static struct pmu perf_task_clock;
> ```
> This is weird as both of them are programmed using type
> PERF_TYPE_SOFTWARE (1) and there is a corresponding sysfs PMU at
> `/sys/bus/event_source/devices/software/type` so wouldn't it make
> sense for there to be 1 PMU? 

No, they don't use the type PERF_TYPE_SOFTWARE.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n14729

They need different operators from the regular software events. I guess
that's why they have a dedicated PMU.

> Anyway, the stop functions are similar:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/kernel/events/core.c#n11804
> ```
> static void cpu_clock_event_stop(struct perf_event *event, int flags)
> {
>         perf_swevent_cancel_hrtimer(event);
>         cpu_clock_event_update(event);
> }
> ...
> static void task_clock_event_stop(struct perf_event *event, int flags)
> {
>         perf_swevent_cancel_hrtimer(event);
>         task_clock_event_update(event, event->ctx->time);
> }
> ```
> and I think you are talking about perf_swevent_cancel_hrtimer:
> ```
> static void perf_swevent_cancel_hrtimer(struct perf_event *event)
> {
>         struct hw_perf_event *hwc = &event->hw;
> 
>         if (is_sampling_event(event)) {
>                 ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
>                 local64_set(&hwc->period_left, ktime_to_ns(remaining));
> 
>                 hrtimer_cancel(&hwc->hrtimer);
>         }
> }
> ```
> but I'm not seeing where HRTIMER_NORESTART comes into this.

That's an issue introduced by the generic throttle patch set, which
unconditionally invoke the event_stop() when throttle is triggered.

It's wrong to call the hrtimer_cancel() to stop the timer in the timer
handler. Because the hrtimer_cancel() waits for the handler to finish,
which is a deadlock.

The correct way (or original way) is to set a HRTIMER_NORESTART.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n11717

So we need a method to specially handle the cpu_clock and task_clock.

> 
>> There may be two ways to fix it.
>> - Add a check of MAX_INTERRUPTS in the event_stop. Return immediately if
>> the stop is invoked by the throttle.
>> - Introduce a PMU flag to track the case. Avoid the event_stop in
>> perf_event_throttle() if the flag is detected.
> 
> I'm not sure what the issue is with the hrtimer_cancel from the
> explanation up to here. If we can't cancel the timer can we have the
> timer callback perf_swevent_hrtimer drop the event?

A callback is not required. Just ignore the
perf_swevent_cancel_hrtimer() when it's invoked from
perf_swevent_hrtimer(). It's similar to the first method (way) above.

> 
> I can see how the patch is working around the problem but from an API
> point-of-view having PERF_PMU_CAP_NO_THROTTLE_STOP seems to be adding
> more possible complexity to PMUs. Possibly if the software event stop
> worked better it would help other future users too.
>

The PERF_PMU_CAP_NO_THROTTLE_STOP should only be useful if there are
some future special PMUs which doesn't want to stop by the generic code.
To be honest, I have no idea if there will be such PMUs.
If no such PMUs, we should not need the flag.
> Sorry for my ignorance in this and I'm likely missing the reason this
> is the best solution. I think improving the commit message would help
> other future people and not just me.I will send a V3 to drop the flag and only apply the fix for the two
clock events. We can have a comparison then.

Thanks,
Kan>
> Thanks,
> Ian
> 
>> The latter looks more generic. It may be used if there are more other
>> cases that want to avoid the stop later. The latter is implemented.
>>
>> Reported-by: Leo Yan <leo.yan@arm.com>
>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> Changes since V1:
>> - Rebase on top of the latest tip.git
>> - Add Tested-by from Leo
>>
>>  include/linux/perf_event.h |  1 +
>>  kernel/events/core.c       | 23 ++++++++++++++++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 52dc7cfab0e0..97a747a97a50 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -305,6 +305,7 @@ struct perf_event_pmu_context;
>>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE  0x0100
>>  #define PERF_PMU_CAP_AUX_PAUSE         0x0200
>>  #define PERF_PMU_CAP_AUX_PREFER_LARGE  0x0400
>> +#define PERF_PMU_CAP_NO_THROTTLE_STOP  0x0800
>>
>>  /**
>>   * pmu::scope
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f34c99f8ce8f..abd19bb571e3 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2656,7 +2656,22 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>>
>>  static void perf_event_throttle(struct perf_event *event)
>>  {
>> -       event->pmu->stop(event, 0);
>> +       /*
>> +        * Some PMUs, e.g., cpu-clock and task_clock, may rely on
>> +        * a special mechanism (hrtimer) to manipulate counters.
>> +        * The regular stop doesn't work, since the hrtimer interrupt
>> +        * handler cannot cancel itself.
>> +        *
>> +        * The stop should be avoided for such cases. Let the
>> +        * driver-specific code handle it.
>> +        *
>> +        * The counters will eventually be disabled in the driver-specific
>> +        * code. In unthrottle, they still need to be re-enabled.
>> +        * There is no handling for PERF_PMU_CAP_NO_THROTTLE_STOP in
>> +        * the perf_event_unthrottle().
>> +        */
>> +       if (!(event->pmu->capabilities & PERF_PMU_CAP_NO_THROTTLE_STOP))
>> +               event->pmu->stop(event, 0);
>>         event->hw.interrupts = MAX_INTERRUPTS;
>>         if (event == event->group_leader)
>>                 perf_log_throttle(event, 0);
>> @@ -11848,7 +11863,8 @@ static int cpu_clock_event_init(struct perf_event *event)
>>  static struct pmu perf_cpu_clock = {
>>         .task_ctx_nr    = perf_sw_context,
>>
>> -       .capabilities   = PERF_PMU_CAP_NO_NMI,
>> +       .capabilities   = PERF_PMU_CAP_NO_NMI |
>> +                         PERF_PMU_CAP_NO_THROTTLE_STOP,
>>         .dev            = PMU_NULL_DEV,
>>
>>         .event_init     = cpu_clock_event_init,
>> @@ -11930,7 +11946,8 @@ static int task_clock_event_init(struct perf_event *event)
>>  static struct pmu perf_task_clock = {
>>         .task_ctx_nr    = perf_sw_context,
>>
>> -       .capabilities   = PERF_PMU_CAP_NO_NMI,
>> +       .capabilities   = PERF_PMU_CAP_NO_NMI |
>> +                         PERF_PMU_CAP_NO_THROTTLE_STOP,
>>         .dev            = PMU_NULL_DEV,
>>
>>         .event_init     = task_clock_event_init,
>> --
>> 2.38.1
>>
> 

