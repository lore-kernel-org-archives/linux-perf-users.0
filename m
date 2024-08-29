Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65542A96;
	Thu, 29 Aug 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941193; cv=none; b=U2Cbzs9f3zWdXrcWHaWcs5AjZjmXQF/W6Irjb1FR85NIwQzk9sT6bMw+Py2aWElh0LHoM22aAZv8jUrd4xQC8UqRoqFY3+NjIQ1ssRTF97p/9EsUFOGZMcFfVFFwYHXPSHzIrVQnp3iN3dWE+UpB2YdvMIosI4YJZyY5ZpjlAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941193; c=relaxed/simple;
	bh=cQ+Yytpsq6B15Gxw8y+wWSg9HZED+7ysWVFrZmzZZR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rA1k7mKJItxZczOWDtEotvw5gt5dnETlYalkfoQz0MfktLz8ffgQaG/Ll6N6TyvtEpewDl5zUNNU0ZFcnWiqdgYwBausbZ9aEoHysA/AhVcAk1BHvklDw3JVImU2Ri14vRIssXj7nhPhrLFzBIpc/5FuvCsQjTl46+nvd+5YR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wvk1h4S3xz4f3jtv;
	Thu, 29 Aug 2024 22:19:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9F1741A018D;
	Thu, 29 Aug 2024 22:19:46 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4WBg9Bm7Pw6DA--.21461S3;
	Thu, 29 Aug 2024 22:19:46 +0800 (CST)
Message-ID: <eb37b77d-58ed-4b79-a942-7c249cb5050b@huaweicloud.com>
Date: Thu, 29 Aug 2024 22:19:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/core: Fix incorrect time diff in tick adjust
 period
Content-Language: en-US
To: "Liang, Kan" <kan.liang@linux.intel.com>,
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
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <63bcac23-e650-41c8-9c9e-93e258355777@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4WBg9Bm7Pw6DA--.21461S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1xAFy5AFyfJrWfCrWfXwb_yoWxAF47pr
	WkAF15trWkJr18ur1jyw1ktry8tw1kJw1DWF15Ga4xAwn8trn2qF47XF1Y9r1qyrs7JFyj
	ya1jqry7urWjqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2024/8/29 21:46, Liang, Kan wrote:
>
> On 2024-08-27 9:10 p.m., Adrian Hunter wrote:
>> On 27/08/24 23:06, Liang, Kan wrote:
>>>
>>> On 2024-08-27 1:16 p.m., Adrian Hunter wrote:
>>>> On 27/08/24 19:42, Liang, Kan wrote:
>>>>>
>>>>> On 2024-08-21 9:42 a.m., Luo Gengkun wrote:
>>>>>> Perf events has the notion of sampling frequency which is implemented in
>>>>>> software by dynamically adjusting the counter period so that samples occur
>>>>>> at approximately the target frequency.  Period adjustment is done in 2
>>>>>> places:
>>>>>>   - when the counter overflows (and a sample is recorded)
>>>>>>   - each timer tick, when the event is active
>>>>>> The later case is slightly flawed because it assumes that the time since
>>>>>> the last timer-tick period adjustment is 1 tick, whereas the event may not
>>>>>> have been active (e.g. for a task that is sleeping).
>>>>>>
>>>>> Do you have a real-world example to demonstrate how bad it is if the
>>>>> algorithm doesn't take sleep into account?
>>>>>
>>>>> I'm not sure if introducing such complexity in the critical path is
>>>>> worth it.
>>>>>
>>>>>> Fix by using jiffies to determine the elapsed time in that case.
>>>>>>
>>>>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>>>>> ---
>>>>>>   include/linux/perf_event.h |  1 +
>>>>>>   kernel/events/core.c       | 11 ++++++++---
>>>>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>>>> index 1a8942277dda..d29b7cf971a1 100644
>>>>>> --- a/include/linux/perf_event.h
>>>>>> +++ b/include/linux/perf_event.h
>>>>>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>>>>>   	 * State for freq target events, see __perf_event_overflow() and
>>>>>>   	 * perf_adjust_freq_unthr_context().
>>>>>>   	 */
>>>>>> +	u64				freq_tick_stamp;
>>>>>>   	u64				freq_time_stamp;
>>>>>>   	u64				freq_count_stamp;
>>>>>>   #endif
>>>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>>>> index a9395bbfd4aa..86e80e3ef6ac 100644
>>>>>> --- a/kernel/events/core.c
>>>>>> +++ b/kernel/events/core.c
>>>>>> @@ -55,6 +55,7 @@
>>>>>>   #include <linux/pgtable.h>
>>>>>>   #include <linux/buildid.h>
>>>>>>   #include <linux/task_work.h>
>>>>>> +#include <linux/jiffies.h>
>>>>>>   
>>>>>>   #include "internal.h"
>>>>>>   
>>>>>> @@ -4120,7 +4121,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>>   {
>>>>>>   	struct perf_event *event;
>>>>>>   	struct hw_perf_event *hwc;
>>>>>> -	u64 now, period = TICK_NSEC;
>>>>>> +	u64 now, period, tick_stamp;
>>>>>>   	s64 delta;
>>>>>>   
>>>>>>   	list_for_each_entry(event, event_list, active_list) {
>>>>>> @@ -4148,6 +4149,10 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>>   		 */
>>>>>>   		event->pmu->stop(event, PERF_EF_UPDATE);
>>>>>>   
>>>>>> +		tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
>>>>> Seems it only needs to retrieve the time once at the beginning, not for
>>>>> each event.
>>>>>
>>>>> There is a perf_clock(). It's better to use it for the consistency.
>>>> perf_clock() is much slower, and for statistical sampling it doesn't
>>>> have to be perfect.
>>> Because of rdtsc?
>> Yes
> OK. I'm not worry about it too much as long as it's only invoked once in
> each tick.
>
>>> If it is only used here, it should be fine. What I'm worried about is
>>> that someone may use it with other timestamp in perf later. Anyway, it's
>>> not a big deal.
>>>
>>> The main concern I have is that do we really need the patch?
>> The current code is wrong.
>>
>>> It seems can only bring us a better guess of the period for the sleep
>>> test. Then we have to do all the calculate for each tick.
>> Or any workload that sleeps periodically.
>>
>> Another option is to remove the period adjust on tick entirely.
>> Although arguably the calculation at a tick is better because
>> it probably covers a longer period.
> Or we may remove the period adjust on overflow.
>
> As my understanding, the period adjust on overflow is to handle the case
> while the overflow happens very frequently (< 2 ticks). It is mainly
> caused by the very low start period (1).
> I'm working on a patch to set a larger start period, which should
> minimize the usage of the period adjust on overflow.
I think it's hard to choose a nice initial period, it may require a lot 
of testing, good luck.
>
> Anyway, based on the current code, I agree that adding a new
> freq_tick_stamp should be required. But it doesn't need to read the time
> for each event. I think reading the time once at the beginning should be
> good enough for the period adjust/estimate algorithm.

That's a good idea, do you think it's appropriate to move this line here?


Thanks,

Gengkun

@@ -4126,6 +4126,8 @@ perf_adjust_freq_unthr_context(struct 
perf_event_context *ctx, bool unthrottle)

         raw_spin_lock(&ctx->lock);

+       tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
+
         list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
                 if (event->state != PERF_EVENT_STATE_ACTIVE)
                         continue;
@@ -4152,7 +4154,6 @@ perf_adjust_freq_unthr_context(struct 
perf_event_context *ctx, bool unthrottle)
                  */
                 event->pmu->stop(event, PERF_EF_UPDATE);

-               tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
                 period = tick_stamp - hwc->freq_tick_stamp;
                 hwc->freq_tick_stamp = tick_stamp;

>
> Thanks,
> Kan
>
>>> Thanks,
>>> Kan
>>>>> Thanks,
>>>>> Kan
>>>>>> +		period = tick_stamp - hwc->freq_tick_stamp;
>>>>>> +		hwc->freq_tick_stamp = tick_stamp;
>>>>>> +
>>>>>>   		now = local64_read(&event->count);
>>>>>>   		delta = now - hwc->freq_count_stamp;
>>>>>>   		hwc->freq_count_stamp = now;
>>>>>> @@ -4157,9 +4162,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>>   		 * reload only if value has changed
>>>>>>   		 * we have stopped the event so tell that
>>>>>>   		 * to perf_adjust_period() to avoid stopping it
>>>>>> -		 * twice.
>>>>>> +		 * twice. And skip if it is the first tick adjust period.
>>>>>>   		 */
>>>>>> -		if (delta > 0)
>>>>>> +		if (delta > 0 && likely(period != tick_stamp))
>>>>>>   			perf_adjust_period(event, period, delta, false);>
>>>>>>   		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>>>>
>>

