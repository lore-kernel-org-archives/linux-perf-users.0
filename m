Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA002D05D;
	Mon, 29 Jul 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262726; cv=none; b=tbfBg0tv9KBQESUdTK2/GSV75wzuanZLNUf7P2cKUcAL7Qqy8dKRCQrjUYViISIDxKrUZHI5teJ/VfEMv8p3sNT0JiPPsVvBCkrLiWKGDlsx8wuO6rgYQUWphEAuLO53K3/1siA0bcMRMUh5LiIhGCm9FYDAVPclJw8OLHPvQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262726; c=relaxed/simple;
	bh=Vd+TP+ne+tPizGSFxdDfsVocyn+YVjdvSfDgIqU6mLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8ZxqKR/x1/wmzfX0eY8Q7l63nKycmuD0qxTBYf4BfOJF74uRsvyWcDQFg3gAIDeUByd3rYjjkqADMCrP1dmnKGbPiAqiKwXkXyrUmZk9cgNL+0QnSx/Yxf6AhIT72XSmtym+ST24bf4eCFdiS6wrdpgWFd/4KckZrz9Hi9mCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WXgSf4dFcz4f3kkB;
	Mon, 29 Jul 2024 22:18:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A26B1A0568;
	Mon, 29 Jul 2024 22:18:35 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoS5pKdmD37KAA--.41544S3;
	Mon, 29 Jul 2024 22:18:35 +0800 (CST)
Message-ID: <4633334d-7b23-40a1-8b9d-183b0261a092@huaweicloud.com>
Date: Mon, 29 Jul 2024 22:18:33 +0800
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
To: Adrian Hunter <adrian.hunter@intel.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
 <20240417115446.2908769-3-luogengkun@huaweicloud.com>
 <7c667516-b5a2-48e1-afd8-e45906e69053@intel.com>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <7c667516-b5a2-48e1-afd8-e45906e69053@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoS5pKdmD37KAA--.41544S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4kXF4xWw43Jr4rGF1UAwb_yoWxAw47pr
	W0yr1fKrWkJr18uwnY93WF9F98Ww48A3WDWw18Ka40yw1DGr1YqF1qgFyYgFyDCFs3Za4I
	v34qgrWayr4YkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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


On 2024/6/17 21:42, Adrian Hunter wrote:
> On 17/04/24 14:54, Luo Gengkun wrote:
>> Adrian found that there is a probability that the number of samples
>> is small, which is caused by the unreasonable large sampling period.
>>
>>   # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
>>   # perf script
>>   ...
>>   test   865   265.377846:         16 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.378900:         15 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.379845:         14 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.380770:         14 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.381647:         15 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.382638:         16 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.383647:         16 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.384704:         15 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.385649:         14 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.386578:        152 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.396383:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.406183:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.415839:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.425445:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.435052:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.444708:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.454314:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.463970:        154 cs:  ffffffff832e927b schedule+0x2b
>>   test   865   265.473577:        154 cs:  ffffffff832e927b schedule+0x2b
>>   ...
>>
>> It seems that the Timer Interrupts is not coming every TICK_NSEC when
> No, the period is not adjusted unless the event is active i.e. scheduled in.
> So an event in a task context where the task sleeps a lot will
> likely not be adjusted every tick.
Yes, your explanation makes sense.
>> system is idle. For example, counter increase n during 2 * TICK_NSEC,
>> and it call perf_adjust_period using n and TICK_NSEC, so the final period
>> we calculated will be bigger than expected one. What's more, if the
>> the overflow time is larger than 2 * TICK_NSEC we cannot tune the period
>> using __perf_event_account_interrupt. To fix this problem, perf can
>> calculate the tick interval by itself.
> Yes, the period can get stuck being too big:
>
> 	perf_adjust_freq_unthr_events() calculates a value that is
> 	too big because it incorrectly assumes the count has
> 	accumulated only since the last tick, whereas it can have
> 	been much longer.
>
> 	__perf_event_account_interrupt() has an unexplained limit
> 	(2*TICK_NSEC) on the count delta, and won't adjust the
> 	period if that is exceeded.
>
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> ---
>>   include/linux/perf_event.h |  1 +
>>   kernel/events/core.c       | 15 ++++++++++++---
>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index afb028c54f33..2708f1d0692c 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>   	 * State for freq target events, see __perf_event_overflow() and
>>   	 * perf_adjust_freq_unthr_context().
>>   	 */
>> +	u64				freq_tick_stamp;
>>   	u64				freq_time_stamp;
>>   	u64				freq_count_stamp;
>>   #endif
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index cad50d3439f1..0f2025d631aa 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4112,7 +4112,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>>   {
>>   	struct perf_event *event;
>>   	struct hw_perf_event *hwc;
>> -	u64 now, period = TICK_NSEC;
>> +	u64 now, period, tick_stamp;
>>   	s64 delta;
>>   
>>   	/*
>> @@ -4151,6 +4151,10 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>>   		 */
>>   		event->pmu->stop(event, PERF_EF_UPDATE);
>>   
>> +		tick_stamp = perf_clock();
> Perhaps jiffies would work just as well, but be
> more efficient.

I tried to use jiffies as shown below.

                 tick_stamp = perf_clock();
+               printk("debug jiffies64:%llu, clock:%llu\n", 
jiffies64_to_nsecs(get_jiffies_64()), perf_clock());
                 period = tick_stamp - hwc->freq_tick_stamp;

But the result is odd and I don't know why, the result is pasted below.

[  423.646990] debug jiffies64:4295090788000000, clock:423646990256
[  423.685989] debug jiffies64:4295090827000000, clock:423685989583
[  423.719989] debug jiffies64:4295090861000000, clock:423719989830
[  423.755990] debug jiffies64:4295090897000000, clock:423755990128
[  423.766990] debug jiffies64:4295090908000000, clock:423766989901
[  423.777990] debug jiffies64:4295090918000000, clock:423777989972
[  423.787989] debug jiffies64:4295090929000000, clock:423787989835
[  423.798989] debug jiffies64:4295090940000000, clock:423798989359
[  423.833990] debug jiffies64:4295090975000000, clock:423833990057
[  423.878989] debug jiffies64:4295091020000000, clock:423878989503
[  423.898990] debug jiffies64:4295091040000000, clock:423898990201
[  423.921989] debug jiffies64:4295091063000000, clock:423921989762
[  423.967989] debug jiffies64:4295091109000000, clock:423967989325
[  424.011989] debug jiffies64:4295091153000000, clock:424011989387
[  424.099989] debug jiffies64:4295091241000000, clock:424099989730
[  424.169989] debug jiffies64:4295091311000000, clock:424169989577

perf_clock gets the right answer and jiffies make me confuse.

Looking forward to your reply, sincerely.

>> +		period = tick_stamp - hwc->freq_tick_stamp;
>> +		hwc->freq_tick_stamp = tick_stamp;
>> +
>>   		now = local64_read(&event->count);
>>   		delta = now - hwc->freq_count_stamp;
>>   		hwc->freq_count_stamp = now;
>> @@ -4162,8 +4166,13 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>>   		 * to perf_adjust_period() to avoid stopping it
>>   		 * twice.
>>   		 */
>> -		if (delta > 0)
>> -			perf_adjust_period(event, period, delta, false);
>> +		if (delta > 0) {
>> +			/*
>> +			 * we skip first tick adjust period
>> +			 */
>> +			if (likely(period != tick_stamp))
>> +				perf_adjust_period(event, period, delta, false);
>> +		}
>>   
>>   		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>>   	next:

