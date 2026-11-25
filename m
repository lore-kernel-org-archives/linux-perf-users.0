Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598991;
	b=u20D14yN0Aoh2oRZ8OWE7xMYmSnFOskASnuJ0PJunS4SN0H2uubxONsZWmaaaRktD9zi
	 Dz59HazdHeoG8BG954D2GQCd+MkXUkU64y6LcOqyz3ZRx/qpVkEevT9lIygyqTncIcBCQ
	 eyFBew00lFqQPZzMwcyH+U1lgrQ74QoKQOx2jPHsxHWd3UCiEM7sWI3VHxbZZFRo1q8XS
	 tdO05j03aUZcXKrZaw3NJsbm8PiBhXQCAoIkuoegCXhylbG0+hktzrbQ1Sq4inDBJdbTj
	 QSRNnK4+n2i9lanoBJHH5RS/CBlSmEYVUeJChEjEduWK5Kzns6IgM+afKuF/v80SuJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598991;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=0kjnxhX7Mjr0qZi9Y/p154s/PWkUYvXrF8AnmobQrvE=;
	b=N5rrZYlktlEQXap+GQN+8ZIq2tB+PdhxbWAq3WaXNFB/qUjhqimra2C1NJzrL44Zl2M0
	 NKkiPtnZWX/Av2ViOdxcrs77JTwoPwOpJyR/GdR1enIIEzfWXtl5wLAN5CRzC6KmT89bR
	 jDCZ2dKvlVvNQvkxXoDOM4VexL+zN5rpDU+/Ulac9M6B5+ynorla8lXQzXeyBMh1dMkyx
	 KC1tPjjziRnrooy8sHTCs6PJjYioum/v/nq2NFzwNOT5o/NCxCw5RTandkoXMV/h6biZC
	 7nTBVvF+7U8jVrrVQiOC+F0593MyZwLxFe2I2VsdLtop4mTF8AxGH59keSRZfKlULMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10E606A31E;
	Wed, 25 Nov 2026 09:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E10E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jZDsW203Cz1c0Xj;
	Wed, 25 Nov 2026 17:29:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 240EE40561;
	Wed, 25 Nov 2026 17:29:40 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHC_6CqgZrngWfFg--.55758S2;
	Wed, 25 Nov 2026 17:29:39 +0800 (CST)
Message-ID: <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>
Date: Wed, 25 Nov 2026 17:29:38 +0800
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
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHC_6CqgZrngWfFg--.55758S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1ktw4furWDCF4DGFWktFb_yoW8uFy5pr
	s3CFs0yrWDtrZ7Xan7t3Wqva43JrW8tFs0qwn0kay8ArW5ZryaqF4xJ3y5GF93uw18Aaya
	yws29asrX3yjva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/25 17:08, Peter Zijlstra wrote:
> On Tue, Nov 24, 2026 at 04:42:34PM +0800, Tengda Wu wrote:
> 
>> From the stack, we can see:
>>
>> perf_event_context_sched_out
>>         // fast path
>>         perf_ctx_enable(ctx, 0);
>>                 perf_pmu_enable
>>                         if (!--(*count))  // equals 0
>>                                 pmu->pmu_enable(pmu);
>>                                         __intel_pmu_enable_all.constprop
>>                                                 do_trace_write_msr
>>                                                         perf_tp_event
>>
>> In perf_tp_event():
>>         if (perf_tp_event_match(event, &raw, regs)) {
>>                 if (!perf_pmu_enabled(event->pmu)) return 0; // not satisfied, continue downward
>>                 perf_swevent_event
>>                         __perf_event_overflow
>>                                 task_work_add  // event->ctx->task mismatches 'current'
>>         }
>>
>> Because pmu_disable_count is already 0, the subsequent perf_tp_event_match()
>> cannot block it via perf_pmu_enabled(), so the problem can be reproduced.
> 
> Right, but at this point there isn't really a problem, all the pointers
> have been swapped already and state should be consistent again.
> 
> I *think* the problem is that task_work_add() is using current while it
> should be using ctx->task. In that case the above will enqueue on the
> next task, which is correct.
> 

I considered this before, but it involves the issue of whether the count
overflow in the sched_out stage should be attributed to the current or next
task, and I wasn't very confident about it, so I didn't adopt it.

> But also, we could probably write this to do:
> 
> 	if (*count == 1) {
> 		pmu->pmu_enable(pmu);
> 		barrier();
> 		(*count)--;
> 	}
> 

Yeah, that's one approach.

>> Maybe my original nr_no_switch_fast approach is still worth considering.
>> -- it would account for sigtrap events at attach time and keep them off
>> the fast path entirely, rather than trying to filter the overflow after
>> the swap has already happened.
> 
> Disabling switch_fast really hurts performance; doing that should be a
> last resort. I think I can fix this. Let me try and see if the
> reproducer works for me so I can more easily poke at this.
> 

OK. Just a reminder that the PoC I provided needs to be run in an Intel
environment, so that the tracepoint can be hit when pmu_enable is executed.

Thank,
Tengda

