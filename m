Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090645;
	b=jKooAO5jZDJUVCX780VocgwvpVaSi/2A+udr+K0pUwhuem1PEG3M75Ui3r5nrHT2i2yI
	 VMhp+1mZ5YFbxx8ZiDisv5xX/uQi8ixEcvrYNa98Mi3cyCFyWciSKH43ql4/frMARw6Qk
	 SQ4xo/UtxTEj8OGa7gj63SVON0KLsEkGb/B4JW0u6mopWiKIGU6JQuZ24C8BPjuwAd0T/
	 mmEtAOzlJLTIK3pMevbjdMKcp9upoEqT5LBXLjQEVS2XRCWDU3miluxRajNBxq+8YvFje
	 1NflJMLMymVTjMyATaZPNDyfHXVkAwbato+Advuy8wBXJrWIC3fKM8xR2B/yGhu/fMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090645;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=BTmz+FTp8wqy5OGJyxvto8ewr04uLiQF8Av6XXkH6lU=;
	b=hh6kTILTqAZ52AhZmWTEVJQwXAFVEmH45IGwc9C+fHljOc42tBMmr+4P9WrCYpOm58Qu
	 jgVUmiA+Jre/jazoEvNxua/t7NxtVq1RfZtahqfmr1DpFKhyPCax+JvnaYAIYlah0YxRx
	 DXnSsW5VkweTPb1Gv1300NwHD1ydXMnymK2GTJLYL90uA5AwUv7FMjEJoFwxFcAB4dDfl
	 /FBdFy3l6gwc5yZjWJgbwE0KCm8Bdd2HaXtGH9e2/zMBKBObrtUKXSvC1zXveYIIEIxyA
	 dAMNGijWx4/hwQ65R/5cKQzacRYfOt8lUzhTm9igukJSjYbgPZDZHosszpQr2DXe2pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43A606A320;
	Thu, 19 Nov 2026 12:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B43A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jVcrp5QyXz1rr5l;
	Thu, 19 Nov 2026 20:16:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E67D340574;
	Thu, 19 Nov 2026 20:17:20 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDnN83Q6P5qv3uVEw--.57931S2;
	Thu, 19 Nov 2026 20:17:20 +0800 (CST)
Message-ID: <cc76ea5a-545a-4560-a039-ceed1de7ff3e@huaweicloud.com>
Date: Thu, 19 Nov 2026 20:17:20 +0800
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
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261119121143.pJrJE7qs@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261119121143.pJrJE7qs@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnN83Q6P5qv3uVEw--.57931S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW7JFWkAr47XF47Kr18uFg_yoW8uF1Upr
	Z3A3WrtrZ5Xr1ay3Z8Kw4qg34fGws5tr4Ygrs8XFWaya1DX3ZaqFW7t3Wj9F1DCrs7Xa4F
	y3yqqrZ7ury5Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ6p
	9UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/19 20:11, Sebastian Andrzej Siewior wrote:
> On 2026-11-19 09:51:01 [+0000], Tengda Wu wrote:
>> perf_sigtrap() contains:
>>
>> 	WARN_ON_ONCE(event->ctx->task != current)
>>
>> The warning assumes that an event's ctx->task always matches the task
>> that ends up running the pending task_work. That assumption can be
>> broken by the context fast-swap path.
>>
>> The failure sequence is:
>>
>>   1. A -> B switch, perf_event_context_sched_out() takes the fast path
>>      and does WRITE_ONCE(ctx->task, next) / WRITE_ONCE(next_ctx->task, task).
>>      An NMI then hits while the context is swapped, and
>>      __perf_event_overflow() queues pending task_work on the *current*
>>      task (A), even though the event now belongs to B's swapped-in
>>      context view.
>>
>>   2. B -> A switch. Because A now has pending task_work,
>>      nr_no_switch_fast is non-zero, so the slow path is taken and
>>      ctx->task is *not* swapped back.
>>
>>   3. A returns to user mode, task_work runs perf_pending_task() ->
>>      perf_sigtrap(), and event->ctx->task no longer equals current,
>>      tripping the WARN_ON_ONCE().
>>
>> The context fast-swap path was already excluded for events that need
>> stable task association (inherit + sample read). sigtrap events have
>> the same requirement: the SIGTRAP is targeted at ctx->task and must not
>> be delivered after ctx->task has been swapped to another task.
>>
>> Fix this by also excluding events with attr->sigtrap from the fast-swap
>> path, i.e. bump nr_no_switch_fast for sigtrap events in
>> list_add_event()/list_del_event(), and update the comment describing
>> the invariant accordingly.
>>
>> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> 
> This makes sense. How did you run into this? Is it possible to make a
> testcase out of it?
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Sebastian

There is a test case, see this:
https://lore.kernel.org/all/d1b24bbf-9111-4766-87c8-ff97adcac727@huaweicloud.com/

Thanks,
Tengda

