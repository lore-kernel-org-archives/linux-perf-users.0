Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841024;
	b=Dd943B/T0Ycu6+qBf6ZnwLSCPkj68ErK0dHfyYoSTU1Ou8FdxA9P8/dr++jLEzn5kdqe
	 pmggFQ7jlbzotnKFb9GVbzwkf2frYOtR2z8J4QlcS/Z25jVyyiC8qFJizWEE4U4jeVfT1
	 rRfmZVON2dJjb5jPNlXEyHyCp24G9MHQIioEli5ogXzJ8aAYiJ5uP2HT8czYWNMb5BRSN
	 9N559v7MF+SNbfD4MLAYL7hkRbqhhUAjkbQeDPB0aA8AdR+oPOc7HVDsKJW6xmBZwiiu3
	 bMuvx8nI+AutIUmdF4KyL2sOl+5sEzRnR2lJh/RqJkOgfj/Xu/eBPNNhEnoaxOc+FOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841024;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=eCSCfWBLYphepyujzWfO5Q8lDkGNEXJ5KW1AbtemZLw=;
	b=EANZRjXMMJXhhnNgfp3f4JqeuSCtY8W4RRAhhBo1qIuAsoVDlAj7TrgOvooHXRFeMWAb
	 m6piLkEoq1WKHuoqbftW6dXmhD03yPzoHSpd8l0WGqOhp+BoiweCCg1hVGxcO8AB/ZxaC
	 ss2G1T+oHiWrIEl8ycGzSvq+L/AyPIjntqNtqV0zEqT4fdAkCeuQ4UD53pKfSX8Sm+dMp
	 N3PDlxTIPJdau5wPijmZwKcI9FLArGgFS/mtd/Xe2eedNhZbgarTjgdjkqw81gcjUg7hp
	 M5iyMJDWr0NlXZZgNAmF6rp9l7tdexUioStPIzJJ/iTENXJsl9Ab+lPmo2qibdOIXAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632C606A31C;
	Mon, 16 Nov 2026 14:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0632C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jSrXM5fvGz1rq6w;
	Mon, 16 Nov 2026 22:56:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B925440576;
	Mon, 16 Nov 2026 22:56:52 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCnduyzGftqetMwEg--.57019S2;
	Mon, 16 Nov 2026 22:56:52 +0800 (CST)
Message-ID: <c752b9eb-9f18-4d6a-b5d9-62f3b0d3e0f6@huaweicloud.com>
Date: Mon, 16 Nov 2026 22:56:51 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1793870900.git.wutengda@huaweicloud.com>
 <ff842e802e9ecb74510a90964f8ad2c4825834b7.1793870900.git.wutengda@huaweicloud.com>
 <20261116094706.GX5vD02a@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261116094706.GX5vD02a@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnduyzGftqetMwEg--.57019S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15ZFWfKF1fCF4DGr4DArb_yoWrAry7pr
	WfJan8KayUXrnFv345tr1kAr18Ww4Fqws8Crs5Ga4fAF1YvrykXay7GF1YvFs8ArnrAayI
	vw4j9rW7u34UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/16 17:47, Sebastian Andrzej Siewior wrote:
> On 2026-11-05 09:30:43 [+0000], Tengda Wu wrote:
>> The sigtrap handling in __perf_event_overflow() checks
>> event->pending_work before calling task_work_add(), but only sets
>> pending_work after the task work has been queued.
>>
>> This leaves a window where an NMI can interrupt task_work_add()
>> and re-enter __perf_event_overflow() for the same event. Since
>> pending_work is still zero, the nested invocation can enqueue
>> the same pending_task again.
>>
>> The re-entrant call path is:
>>
>>   __perf_event_overflow()
>>     task_work_add()
>>       kasan_record_aux_stack()
>>         <NMI>
>>           __perf_event_overflow()
>>             task_work_add()
>>
>> The nested invocation can enqueue pending_task before the
>> outer invocation does. When the outer invocation resumes, it
>> inserts the same task_work entry again, potentially creating
>> a cycle in the task work list.
>>
>> This causes perf_pending_task() to be executed repeatedly
>> and leads to unbalanced event reference counting.
>>
>> Use cmpxchg() to atomically claim pending_work before calling
>> task_work_add(). This ensures that only one invocation can
>> enqueue the pending_task, even when interrupted by an NMI.
>>
>> If task_work_add() fails, clear the pending_work claim so that
>> a subsequent overflow can retry.
>>
>> Also use READ_ONCE() when checking pending_work in the
>> exclude_kernel warning path to avoid an unsynchronized read.
>>
>> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  kernel/events/core.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 457d75ea7142..ee5c59158b89 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -10925,16 +10925,17 @@ static int __perf_event_overflow(struct perf_event *event,
>>  
>>  		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
>>  
>> -		if (!event->pending_work &&
>> -		    !task_work_add(current, &event->pending_task, notify_mode)) {
>> -			event->pending_work = pending_id;
>> -			local_inc(&event->ctx->nr_no_switch_fast);
>> -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
>> -
>> -			event->pending_addr = 0;
>> -			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
>> -				event->pending_addr = data->addr;
>> -
>> +		if (cmpxchg(&event->pending_work, 0, pending_id) == 0) {
> 
> would cmpxchg_acquire() here make sense?
> 
>> +			if (!task_work_add(current, &event->pending_task, notify_mode)) {
>> +				local_inc(&event->ctx->nr_no_switch_fast);
>> +				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
>> +
>> +				event->pending_addr = 0;
>> +				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
>> +					event->pending_addr = data->addr;
>> +			} else {
>> +				cmpxchg(&event->pending_work, pending_id, 0);
> 
> if the task_work_add() fails then smp_store_release(, 0) since only the
> executed task_work can release it back to 0. The cmpxchg seems not
> needed.
> 
>> +			}
>>  		} else if (event->attr.exclude_kernel && valid_sample) {
>>  			/*
>>  			 * Should not be able to return to user space without
>> @@ -10948,7 +10949,7 @@ static int __perf_event_overflow(struct perf_event *event,
>>  			 *     To approximate progress (with false negatives),
>>  			 *     check 32-bit hash of the current IP.
>>  			 */
>> -			WARN_ON_ONCE(event->pending_work != pending_id);
>> +			WARN_ON_ONCE(READ_ONCE(event->pending_work) != pending_id);
> smp_load_acquire()
> 
> perf_pending_task() could maybe get a xchg_release(, 0). This however is
> wrong because it would reset perf_event::pending_work and make it
> available for __perf_event_overflow() again. I think it should have a
> load_acquire() first, and have the store_release() after perf_sigtrap().
> 
> Comments?
> 
>>  		}
>>  	}
>>  
> 
> Sebastian

Sounds reasonable. After switching to acquire/release, the local tests pass for now.
Will send it out later.

Thanks,
Tengda

