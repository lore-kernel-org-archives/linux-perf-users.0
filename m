Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1211917F0;
	Thu, 29 Aug 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941815; cv=none; b=jOHiwSbBYfOf+SW7WgTrxHao03a4GJ8MA77WJD3xHsAFfi+9/gTJxO1//jneNVWMbUuNj/rotvHkOGXxx3RMH30kW4RNCTqUoV8fHSHwfd+UIc/yvNDhemfDlQi0HFM1gwO982poawsL5EVgTDqE1LOS9ihlDlmykn4rFyxPl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941815; c=relaxed/simple;
	bh=ngze0lQ9CYE1yFfPkAlzEc92VHhFsT4mm6rpznvd5t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyHe5COr+C1hNVh/yXVYxqRTUxWSa4VAQqO+UHATWPDtmDH91tT4QMJibLWeHNqG+Ay/tIC0a198Mn0+inx9xtuqrTA1M53TFfJnmKMYqRS2HIY1M9kHcfUwmv9R3ErbEtP9mrDl4t0YTf63e70P1TxxC1WklLIfQOLyqPL22ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVisgsBm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVisgsBm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724941813; x=1756477813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ngze0lQ9CYE1yFfPkAlzEc92VHhFsT4mm6rpznvd5t8=;
  b=dVisgsBmiLW7NF+MU+1jboL+s9UaDzDG3rFFS1TIE/OEmKAD5laterJ0
   dha0eU7mmhWpMtnnIa/8dV4c9Q4xI051ltVhhMIRbBW9aLBkudsWw4RTw
   nXmThCENrcYNaDjqxOLpwkZYEV6uiipIpARUb8m3opw+Xe83H8UFIy5ID
   s3WJdM1XmlE/DoBIIOteU71y5Dj5BnbecwXhO+oqYRg6gfSJi8HdtfJdB
   qeMM0jYpft1nbDsqLUBGBnO4AlkBgtk3W1GOsKggsgW93weYWsoM190kE
   KuSMFV2YDQopB/22ICjkyZa+0YN5NPDAUaQRejbtCP753ZBS37WipcNSJ
   A==;
X-CSE-ConnectionGUID: oxOkDpITT3K33B7fdsGGsQ==
X-CSE-MsgGUID: OaM1+RPMQ7ieVwVRm0v0KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23699903"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23699903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 07:30:12 -0700
X-CSE-ConnectionGUID: 5zYp68CISm+ghBmzXm1x9w==
X-CSE-MsgGUID: 2KSvSzQwTmChFTihdw+c9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="94405948"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 07:30:12 -0700
Received: from [10.212.67.83] (kliang2-mobl1.ccr.corp.intel.com [10.212.67.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5B53720CFEE4;
	Thu, 29 Aug 2024 07:30:10 -0700 (PDT)
Message-ID: <11099a9e-7006-4372-82b5-f35232a63c8c@linux.intel.com>
Date: Thu, 29 Aug 2024 10:30:08 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/core: Fix incorrect time diff in tick adjust
 period
To: Luo Gengkun <luogengkun@huaweicloud.com>,
 Adrian Hunter <adrian.hunter@intel.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821134227.577544-1-luogengkun@huaweicloud.com>
 <20240821134227.577544-3-luogengkun@huaweicloud.com>
 <c5b73b4f-b257-4847-a213-741889d89159@linux.intel.com>
 <c1b2a1b6-8b6d-40b4-84d4-d007c024fc84@intel.com>
 <e15110af-c2f2-47ff-99fd-649cf5b46e46@linux.intel.com>
 <30884874-848a-40ef-9e02-7cdb7b1a029a@intel.com>
 <63bcac23-e650-41c8-9c9e-93e258355777@linux.intel.com>
 <eb37b77d-58ed-4b79-a942-7c249cb5050b@huaweicloud.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <eb37b77d-58ed-4b79-a942-7c249cb5050b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-08-29 10:19 a.m., Luo Gengkun wrote:
> 
> On 2024/8/29 21:46, Liang, Kan wrote:
>>
>> On 2024-08-27 9:10 p.m., Adrian Hunter wrote:
>>> On 27/08/24 23:06, Liang, Kan wrote:
>>>>
>>>> On 2024-08-27 1:16 p.m., Adrian Hunter wrote:
>>>>> On 27/08/24 19:42, Liang, Kan wrote:
>>>>>>
>>>>>> On 2024-08-21 9:42 a.m., Luo Gengkun wrote:
>>>>>>> Perf events has the notion of sampling frequency which is
>>>>>>> implemented in
>>>>>>> software by dynamically adjusting the counter period so that
>>>>>>> samples occur
>>>>>>> at approximately the target frequency.  Period adjustment is done
>>>>>>> in 2
>>>>>>> places:
>>>>>>>   - when the counter overflows (and a sample is recorded)
>>>>>>>   - each timer tick, when the event is active
>>>>>>> The later case is slightly flawed because it assumes that the
>>>>>>> time since
>>>>>>> the last timer-tick period adjustment is 1 tick, whereas the
>>>>>>> event may not
>>>>>>> have been active (e.g. for a task that is sleeping).
>>>>>>>
>>>>>> Do you have a real-world example to demonstrate how bad it is if the
>>>>>> algorithm doesn't take sleep into account?
>>>>>>
>>>>>> I'm not sure if introducing such complexity in the critical path is
>>>>>> worth it.
>>>>>>
>>>>>>> Fix by using jiffies to determine the elapsed time in that case.
>>>>>>>
>>>>>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>>>>>> ---
>>>>>>>   include/linux/perf_event.h |  1 +
>>>>>>>   kernel/events/core.c       | 11 ++++++++---
>>>>>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>>>>> index 1a8942277dda..d29b7cf971a1 100644
>>>>>>> --- a/include/linux/perf_event.h
>>>>>>> +++ b/include/linux/perf_event.h
>>>>>>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>>>>>>        * State for freq target events, see
>>>>>>> __perf_event_overflow() and
>>>>>>>        * perf_adjust_freq_unthr_context().
>>>>>>>        */
>>>>>>> +    u64                freq_tick_stamp;
>>>>>>>       u64                freq_time_stamp;
>>>>>>>       u64                freq_count_stamp;
>>>>>>>   #endif
>>>>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>>>>> index a9395bbfd4aa..86e80e3ef6ac 100644
>>>>>>> --- a/kernel/events/core.c
>>>>>>> +++ b/kernel/events/core.c
>>>>>>> @@ -55,6 +55,7 @@
>>>>>>>   #include <linux/pgtable.h>
>>>>>>>   #include <linux/buildid.h>
>>>>>>>   #include <linux/task_work.h>
>>>>>>> +#include <linux/jiffies.h>
>>>>>>>     #include "internal.h"
>>>>>>>   @@ -4120,7 +4121,7 @@ static void
>>>>>>> perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>>>   {
>>>>>>>       struct perf_event *event;
>>>>>>>       struct hw_perf_event *hwc;
>>>>>>> -    u64 now, period = TICK_NSEC;
>>>>>>> +    u64 now, period, tick_stamp;
>>>>>>>       s64 delta;
>>>>>>>         list_for_each_entry(event, event_list, active_list) {
>>>>>>> @@ -4148,6 +4149,10 @@ static void
>>>>>>> perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>>>            */
>>>>>>>           event->pmu->stop(event, PERF_EF_UPDATE);
>>>>>>>   +        tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
>>>>>> Seems it only needs to retrieve the time once at the beginning,
>>>>>> not for
>>>>>> each event.
>>>>>>
>>>>>> There is a perf_clock(). It's better to use it for the consistency.
>>>>> perf_clock() is much slower, and for statistical sampling it doesn't
>>>>> have to be perfect.
>>>> Because of rdtsc?
>>> Yes
>> OK. I'm not worry about it too much as long as it's only invoked once in
>> each tick.
>>
>>>> If it is only used here, it should be fine. What I'm worried about is
>>>> that someone may use it with other timestamp in perf later. Anyway,
>>>> it's
>>>> not a big deal.
>>>>
>>>> The main concern I have is that do we really need the patch?
>>> The current code is wrong.
>>>
>>>> It seems can only bring us a better guess of the period for the sleep
>>>> test. Then we have to do all the calculate for each tick.
>>> Or any workload that sleeps periodically.
>>>
>>> Another option is to remove the period adjust on tick entirely.
>>> Although arguably the calculation at a tick is better because
>>> it probably covers a longer period.
>> Or we may remove the period adjust on overflow.
>>
>> As my understanding, the period adjust on overflow is to handle the case
>> while the overflow happens very frequently (< 2 ticks). It is mainly
>> caused by the very low start period (1).
>> I'm working on a patch to set a larger start period, which should
>> minimize the usage of the period adjust on overflow.
> I think it's hard to choose a nice initial period, it may require a lot
> of testing, good luck.
>>
>> Anyway, based on the current code, I agree that adding a new
>> freq_tick_stamp should be required. But it doesn't need to read the time
>> for each event. I think reading the time once at the beginning should be
>> good enough for the period adjust/estimate algorithm.
> 
> That's a good idea, do you think it's appropriate to move this line here?
> 
> 
> Thanks,
> 
> Gengkun
> 
> @@ -4126,6 +4126,8 @@ perf_adjust_freq_unthr_context(struct
> perf_event_context *ctx, bool unthrottle)
> 
>         raw_spin_lock(&ctx->lock);
> 
> +       tick_stamp = jiffies64_to_nsecs(get_jiffies_64());

Yes, the place looks good.

I'm still not a big fan of jiffies. Anyway, I guess we can leave it to
Peter to decide.

Thanks,
Kan
> +
>         list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
>                 if (event->state != PERF_EVENT_STATE_ACTIVE)
>                         continue;
> @@ -4152,7 +4154,6 @@ perf_adjust_freq_unthr_context(struct
> perf_event_context *ctx, bool unthrottle)
>                  */
>                 event->pmu->stop(event, PERF_EF_UPDATE);
> 
> -               tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
>                 period = tick_stamp - hwc->freq_tick_stamp;
>                 hwc->freq_tick_stamp = tick_stamp;
> 
>>
>> Thanks,
>> Kan
>>
>>>> Thanks,
>>>> Kan
>>>>>> Thanks,
>>>>>> Kan
>>>>>>> +        period = tick_stamp - hwc->freq_tick_stamp;
>>>>>>> +        hwc->freq_tick_stamp = tick_stamp;
>>>>>>> +
>>>>>>>           now = local64_read(&event->count);
>>>>>>>           delta = now - hwc->freq_count_stamp;
>>>>>>>           hwc->freq_count_stamp = now;
>>>>>>> @@ -4157,9 +4162,9 @@ static void
>>>>>>> perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>>>            * reload only if value has changed
>>>>>>>            * we have stopped the event so tell that
>>>>>>>            * to perf_adjust_period() to avoid stopping it
>>>>>>> -         * twice.
>>>>>>> +         * twice. And skip if it is the first tick adjust period.
>>>>>>>            */
>>>>>>> -        if (delta > 0)
>>>>>>> +        if (delta > 0 && likely(period != tick_stamp))
>>>>>>>               perf_adjust_period(event, period, delta, false);>
>>>>>>>           event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>>>>>
>>>
> 
