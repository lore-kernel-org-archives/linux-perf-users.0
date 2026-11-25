Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601351;
	b=iKXafCP1mghLFwsVU7fAuah+/8Wfk5TNQBUccfNHkAVtaI5wJalKFxiNKMgwjtUmSmKX
	 iBbr9dmvDqtftiR6dillNxI5UIVjlToZmqsC9s2Ld0G6kCMp0XeQaN5flQeetPskvnCft
	 f92Nq5s4R1LfJHzbyps/g386P9Ww7Sxg0QZUCfnwKVzhkPcUixaP3kJkaYF6peXc7FQuF
	 S49TrXHloaj/j6QMUP26mG1RcktxDRFrgApDgCCPqCOeRFofGENW6RpnaxUF1LN1w+kmZ
	 CJsyGTu9SdH5ZRE3eQuj3lyrrZv+RO45THLLAsLQA3EnwbgdvBOcPk1rtzckg1yibqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601351;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=xhZB0AAeSQ6w4yu2gADO6Wiz6xUUSHaNfKxMYEK+Eqw=;
	b=2Y2FeRfORDlHE8llicVDXQUxog8frxRkjyJ3K9zSahcexuzF0eo4Vkuf8YPP6MdNXetg
	 J59xcDpmobDjsb12qOX7HvX+9nb+G36Lhuyt9LCYyCg9/Fd8SkemKWMQ4GcBoTKExMLR0
	 RfMFfAlV9b9FVmgMtSkgkDWUdsv+p2xN+Dr4RFI214RHiMdFVHNTay0m3fctQjIP1TxKs
	 RYrKaIrXfOK5iIcfzcVXzv1Fpui/d8oIpMdqEw2tH4Q69fmiNpOvswMxfuVfq8I/17sbm
	 8eTaIUGk3TiRDOxBqG+d/4/oLX5XL4sJy0J520eS7Vs8HEr9wBgt5BqFf3YLdGI9uMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0A606A32A;
	Wed, 25 Nov 2026 10:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB0A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jZFl21gF1z20FZ;
	Wed, 25 Nov 2026 18:09:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 995EF405C1;
	Wed, 25 Nov 2026 18:09:05 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAXGfzAswZrH6OiFg--.15498S2;
	Wed, 25 Nov 2026 18:09:05 +0800 (CST)
Message-ID: <6493eae2-9b36-4574-83ca-a139f4fbfb25@huaweicloud.com>
Date: Wed, 25 Nov 2026 18:09:04 +0800
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
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
 <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
 <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
 <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
 <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>
 <20261125093836.GX2668804@noisy.programming.kicks-ass.net>
 <c9c2c4df-a748-4787-b686-1fe6bc6564db@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c9c2c4df-a748-4787-b686-1fe6bc6564db@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXGfzAswZrH6OiFg--.15498S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWrGFWktFWDGF48Cw4UArb_yoW5XFW7pr
	Z3AF45trWDtr42gwsFyw1DZFy5trW7tr4DWw1kG3yxAr90vry2qF4xJrW5CF9I9w18Aay3
	tr42qa47W34jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/25 18:03, Tengda Wu wrote:
> 
> 
> On 2026/11/25 17:38, Peter Zijlstra wrote:
>> On Wed, Nov 25, 2026 at 05:29:38PM +0800, Tengda Wu wrote:
>>>
>>>
>>> On 2026/11/25 17:08, Peter Zijlstra wrote:
>>>> On Tue, Nov 24, 2026 at 04:42:34PM +0800, Tengda Wu wrote:
>>>>
>>>>> From the stack, we can see:
>>>>>
>>>>> perf_event_context_sched_out
>>>>>         // fast path
>>>>>         perf_ctx_enable(ctx, 0);
>>>>>                 perf_pmu_enable
>>>>>                         if (!--(*count))  // equals 0
>>>>>                                 pmu->pmu_enable(pmu);
>>>>>                                         __intel_pmu_enable_all.constprop
>>>>>                                                 do_trace_write_msr
>>>>>                                                         perf_tp_event
>>>>>
>>>>> In perf_tp_event():
>>>>>         if (perf_tp_event_match(event, &raw, regs)) {
>>>>>                 if (!perf_pmu_enabled(event->pmu)) return 0; // not satisfied, continue downward
>>>>>                 perf_swevent_event
>>>>>                         __perf_event_overflow
>>>>>                                 task_work_add  // event->ctx->task mismatches 'current'
>>>>>         }
>>>>>
>>>>> Because pmu_disable_count is already 0, the subsequent perf_tp_event_match()
>>>>> cannot block it via perf_pmu_enabled(), so the problem can be reproduced.
>>>>
>>>> Right, but at this point there isn't really a problem, all the pointers
>>>> have been swapped already and state should be consistent again.
>>>>
>>>> I *think* the problem is that task_work_add() is using current while it
>>>> should be using ctx->task. In that case the above will enqueue on the
>>>> next task, which is correct.
>>>>
>>>
>>> I considered this before, but it involves the issue of whether the count
>>> overflow in the sched_out stage should be attributed to the current or next
>>> task, and I wasn't very confident about it, so I didn't adopt it.
>>
>> All of switch_fast suffers that problem. Mostly we've ignored it since
>> kernel events around a context switch are hard to attribute to any one
>> particular task, so a little fuzz left or right of the switch doesn't
>> matter too much, as long as its consistent.
>>
> 
> Thanks for the clarification.
> 
>>>> Disabling switch_fast really hurts performance; doing that should be a
>>>> last resort. I think I can fix this. Let me try and see if the
>>>> reproducer works for me so I can more easily poke at this.
>>>>
>>>
>>> OK. Just a reminder that the PoC I provided needs to be run in an Intel
>>> environment, so that the tracepoint can be hit when pmu_enable is executed.
>>
>> Ah, I'm currently running it on an SPR Xeon; do I need to use
>> non-default arguments or just run the thing in a loop and drink tea
>> until it goes pop?
> 
> No need to pass any other arguments; running it as follows should be enough:
> 
>   for i {1..100}; do ./fast_swap ; done
> 

Correction: for i in {1..100}

One more detail: I also specified a boot parameter (which might make it
easier to reproduce?):
  
  preempt=none

Thanks,
Tengda

