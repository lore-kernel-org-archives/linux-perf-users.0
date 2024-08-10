Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8344436E;
	Sat, 10 Aug 2024 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282017; cv=none; b=SWvlwI54CMJciHotduaXxPeSe6oivw+zC9cwHkn9isT6EHIAgZpQku8QzX1e6vqQhc42pzvwhwuuXHmweV4u0Uk0rkgia2cGH+lkID9tNHsz7dudRVXayxk2p94EKmeX+LQFZf90PUjqE9Fdzfq+jU+z1PUSJ4m/F++jmS1xQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282017; c=relaxed/simple;
	bh=p67J4cnCtmhNvEViQKDJTVDy6UzW7J9LJfdxocgUhK8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C80eJ47YOqcf3ObFEKyrFEZxThSvNZMZxqxmVJOZ1cfvwVGOESjJP7QdNlhYVrbeCTmrzFzmllpdffIwTqaQOdowp/nIjZi91s106XdfYWi4Ddtq8qq68v0/Y+R46TCNMyptYCgX4Uoeay5zAWfXlrdDsGcog/ypzXrstkwWOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WgwQT39Xwz4f3jk0;
	Sat, 10 Aug 2024 17:26:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9326A1A0359;
	Sat, 10 Aug 2024 17:26:50 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4VZMrdms_AnBQ--.13757S3;
	Sat, 10 Aug 2024 17:26:50 +0800 (CST)
Message-ID: <bc22c777-2f9e-4673-80c7-6b51e4e8ba08@huaweicloud.com>
Date: Sat, 10 Aug 2024 17:26:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/2] perf/core: Fix incorrected time diff in
 tick adjust period
Content-Language: en-US
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: Adrian Hunter <adrian.hunter@intel.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
 <20240417115446.2908769-3-luogengkun@huaweicloud.com>
 <7c667516-b5a2-48e1-afd8-e45906e69053@intel.com>
 <4633334d-7b23-40a1-8b9d-183b0261a092@huaweicloud.com>
In-Reply-To: <4633334d-7b23-40a1-8b9d-183b0261a092@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4VZMrdms_AnBQ--.13757S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4fXFWxGF4DtrWkuw4UJwb_yoWDGF4kpr
	ZYyF13trWkAr1kJr1UAr1rXFy5Jw48A3W7Ww1UJFW8Ar47Gr12gFyUWryjgryDCr4xAr1x
	trn0qr1avr4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2024/7/29 22:18, Luo Gengkun wrote:
>
> On 2024/6/17 21:42, Adrian Hunter wrote:
>> On 17/04/24 14:54, Luo Gengkun wrote:
>>> Adrian found that there is a probability that the number of samples
>>> is small, which is caused by the unreasonable large sampling period.
>>>
>>>   # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
>>>   [ perf record: Woken up 1 times to write data ]
>>>   [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
>>>   # perf script
>>>   ...
>>>   test   865   265.377846:         16 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.378900:         15 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.379845:         14 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.380770:         14 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.381647:         15 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.382638:         16 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.383647:         16 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.384704:         15 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.385649:         14 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.386578:        152 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.396383:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.406183:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.415839:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.425445:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.435052:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.444708:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.454314:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.463970:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   test   865   265.473577:        154 cs:  ffffffff832e927b 
>>> schedule+0x2b
>>>   ...
>>>
>>> It seems that the Timer Interrupts is not coming every TICK_NSEC when
>> No, the period is not adjusted unless the event is active i.e. 
>> scheduled in.
>> So an event in a task context where the task sleeps a lot will
>> likely not be adjusted every tick.
> Yes, your explanation makes sense.
>>> system is idle. For example, counter increase n during 2 * TICK_NSEC,
>>> and it call perf_adjust_period using n and TICK_NSEC, so the final 
>>> period
>>> we calculated will be bigger than expected one. What's more, if the
>>> the overflow time is larger than 2 * TICK_NSEC we cannot tune the 
>>> period
>>> using __perf_event_account_interrupt. To fix this problem, perf can
>>> calculate the tick interval by itself.
>> Yes, the period can get stuck being too big:
>>
>>     perf_adjust_freq_unthr_events() calculates a value that is
>>     too big because it incorrectly assumes the count has
>>     accumulated only since the last tick, whereas it can have
>>     been much longer.
>>
>>     __perf_event_account_interrupt() has an unexplained limit
>>     (2*TICK_NSEC) on the count delta, and won't adjust the
>>     period if that is exceeded.
>>
>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>> ---
>>>   include/linux/perf_event.h |  1 +
>>>   kernel/events/core.c       | 15 ++++++++++++---
>>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index afb028c54f33..2708f1d0692c 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>>        * State for freq target events, see __perf_event_overflow() and
>>>        * perf_adjust_freq_unthr_context().
>>>        */
>>> +    u64                freq_tick_stamp;
>>>       u64                freq_time_stamp;
>>>       u64                freq_count_stamp;
>>>   #endif
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index cad50d3439f1..0f2025d631aa 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -4112,7 +4112,7 @@ perf_adjust_freq_unthr_context(struct 
>>> perf_event_context *ctx, bool unthrottle)
>>>   {
>>>       struct perf_event *event;
>>>       struct hw_perf_event *hwc;
>>> -    u64 now, period = TICK_NSEC;
>>> +    u64 now, period, tick_stamp;
>>>       s64 delta;
>>>         /*
>>> @@ -4151,6 +4151,10 @@ perf_adjust_freq_unthr_context(struct 
>>> perf_event_context *ctx, bool unthrottle)
>>>            */
>>>           event->pmu->stop(event, PERF_EF_UPDATE);
>>>   +        tick_stamp = perf_clock();
>> Perhaps jiffies would work just as well, but be
>> more efficient.
>
> I tried to use jiffies as shown below.
>
>                 tick_stamp = perf_clock();
> +               printk("debug jiffies64:%llu, clock:%llu\n", 
> jiffies64_to_nsecs(get_jiffies_64()), perf_clock());
>                 period = tick_stamp - hwc->freq_tick_stamp;
>
> But the result is odd and I don't know why, the result is pasted below.
>
> [  423.646990] debug jiffies64:4295090788000000, clock:423646990256
> [  423.685989] debug jiffies64:4295090827000000, clock:423685989583
> [  423.719989] debug jiffies64:4295090861000000, clock:423719989830
> [  423.755990] debug jiffies64:4295090897000000, clock:423755990128
> [  423.766990] debug jiffies64:4295090908000000, clock:423766989901
> [  423.777990] debug jiffies64:4295090918000000, clock:423777989972
> [  423.787989] debug jiffies64:4295090929000000, clock:423787989835
> [  423.798989] debug jiffies64:4295090940000000, clock:423798989359
> [  423.833990] debug jiffies64:4295090975000000, clock:423833990057
> [  423.878989] debug jiffies64:4295091020000000, clock:423878989503
> [  423.898990] debug jiffies64:4295091040000000, clock:423898990201
> [  423.921989] debug jiffies64:4295091063000000, clock:423921989762
> [  423.967989] debug jiffies64:4295091109000000, clock:423967989325
> [  424.011989] debug jiffies64:4295091153000000, clock:424011989387
> [  424.099989] debug jiffies64:4295091241000000, clock:424099989730
> [  424.169989] debug jiffies64:4295091311000000, clock:424169989577
>
> perf_clock gets the right answer and jiffies make me confuse.
>
> Looking forward to your reply, sincerely.

Please ignore the previous problem. I try to replace perf_clock with 
jiffies, and

it still work well. The result is pasted below:

root@lgk:~# time ./a.out

real    0m3.459s
user    0m0.144s
sys     0m1.508s
root@lgk:~# perf record -e cs -F 1000  ./a.out

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.132 MB perf.data (3421 samples) ]
root@lgk:~# perf record -e cs -F 1000  ./a.out

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.128 MB perf.data (3336 samples) ]
root@lgk:~# perf record -e cs -F 1000  ./a.out

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.128 MB perf.data (3315 samples) ]
root@lgk:~# perf record -e cs -F 1000  ./a.out

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.125 MB perf.data (3262 samples) ]
root@lgk:~# perf record -e cs -F 1000  ./a.out

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.129 MB perf.data (3344 samples) ]

In addition, it looks like perf_clock is using everywhere in perf. So i 
replace

local_clock with jiffies, as shown below:

+#include <linux/jiffies.h>

  #include "internal.h"

@@ -578,7 +579,7 @@ void __weak perf_event_print_debug(void)    { }

  static inline u64 perf_clock(void)
  {
-       return local_clock();
+       return jiffies64_to_nsecs(get_jiffies_64());
  }


>
>>> +        period = tick_stamp - hwc->freq_tick_stamp;
>>> +        hwc->freq_tick_stamp = tick_stamp;
>>> +
>>>           now = local64_read(&event->count);
>>>           delta = now - hwc->freq_count_stamp;
>>>           hwc->freq_count_stamp = now;
>>> @@ -4162,8 +4166,13 @@ perf_adjust_freq_unthr_context(struct 
>>> perf_event_context *ctx, bool unthrottle)
>>>            * to perf_adjust_period() to avoid stopping it
>>>            * twice.
>>>            */
>>> -        if (delta > 0)
>>> -            perf_adjust_period(event, period, delta, false);
>>> +        if (delta > 0) {
>>> +            /*
>>> +             * we skip first tick adjust period
>>> +             */
>>> +            if (likely(period != tick_stamp))
>>> +                perf_adjust_period(event, period, delta, false);
>>> +        }
>>>             event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>>>       next:

