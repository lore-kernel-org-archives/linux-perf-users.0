Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795403512;
	b=imGAVm/gPlvkC9k44v0Sblt5uMCiQi74EPGCfreciyD+TOdMMT7QxOI8NNwxTKFzeie8
	 Db9/9vAbJyFC9WxvN5aswpyx0jxWjBzl8H1LFphH8ZzgZHJLEfA8ONr9uhbyAPD4cx6Vi
	 S0xWEKLANz8eVvgZMPMBlJcVvB7M3tXpl4RCtPJ1TkK1kOXTej4fS5tY5w+bZLaPznoIe
	 zYkTouWm4KdNLDW55QBZs2wQZ7Q4vi5pa1TCGEHMCQkQYxXgkt6zCYSqCCDNqY24KKZPb
	 IUtfwfvmhLviXVZkaCT51kpsUffYpbvgVM67ZUB3JMAWcBuEmHSyYyETS/BFjNa2pMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403512;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=TWaKkN5KqIc9iT2eIz1MqM1KYeNvSrvlFhxO9KhB+Go=;
	b=hgbnzx3amDVqM0CDLdck2rt3zUWBRdPXg8d0gFEzUA+rxAhVCB+Pddhq/L+COl4ayNo4
	 wde2cmVlqQ5YLBMrkR0PBeCjy51rzZ0KV/RD264tE/bU2eAVQGb2BfnRJmxW0v8Z4n7AG
	 2K3JDxrMcT1ErggHPDYAdKshlv0xP9TBhj2rDVBwUzXZw68vcEu87ngrT5353djKqnm0r
	 5Y0X+cGxtTw+pTMzjP76mdCV6kGZnm0gcgf+fCNF4ksaJlijRb3HBKxQbovuRoA4g8hh4
	 IimBwam63EqPB/dt4HVypPZBTxBf9JujhRWAhYgo0NW4QRjjQR9XfkqlDL8PmUtn6fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17F606A31A;
	Mon, 23 Nov 2026 03:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C17F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jXrZV1YLVz1c0pY;
	Mon, 23 Nov 2026 11:11:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 002414056B;
	Mon, 23 Nov 2026 11:11:46 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCXyunxrgNrAFDCFQ--.55588S2;
	Mon, 23 Nov 2026 11:11:46 +0800 (CST)
Message-ID: <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
Date: Mon, 23 Nov 2026 11:11:45 +0800
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
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXyunxrgNrAFDCFQ--.55588S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKryUJr48Kr13ZFWUAw45GFg_yoW7KrWDpF
	W7AF1vkr40qr1jvw17tr1UAw1Utr4fAF4kXw18KrySy3W5Wrn8XF1UJr4j9Fn5JrnxAa47
	tw4qqw4SkryUtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/21 1:46, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 06:37:06PM +0100, Peter Zijlstra wrote:
>> On Thu, Nov 19, 2026 at 09:51:01AM +0000, Tengda Wu wrote:
>>> perf_sigtrap() contains:
>>>
>>> 	WARN_ON_ONCE(event->ctx->task != current)
>>>
>>> The warning assumes that an event's ctx->task always matches the task
>>> that ends up running the pending task_work. That assumption can be
>>> broken by the context fast-swap path.
>>>
>>> The failure sequence is:
>>>
>>>   1. A -> B switch, perf_event_context_sched_out() takes the fast path
>>>      and does WRITE_ONCE(ctx->task, next) / WRITE_ONCE(next_ctx->task, task).
>>>      An NMI then hits while the context is swapped, and
>>>      __perf_event_overflow() queues pending task_work on the *current*
>>>      task (A), even though the event now belongs to B's swapped-in
>>>      context view.
>>>
>>>   2. B -> A switch. Because A now has pending task_work,
>>>      nr_no_switch_fast is non-zero, so the slow path is taken and
>>>      ctx->task is *not* swapped back.
>>>
>>>   3. A returns to user mode, task_work runs perf_pending_task() ->
>>>      perf_sigtrap(), and event->ctx->task no longer equals current,
>>>      tripping the WARN_ON_ONCE().
>>>
>>> The context fast-swap path was already excluded for events that need
>>> stable task association (inherit + sample read). sigtrap events have
>>> the same requirement: the SIGTRAP is targeted at ctx->task and must not
>>> be delivered after ctx->task has been swapped to another task.
>>
>> Oh gawd, let me guess, another one of those tracepoint events, right?
>>
>> Must be someone that doesn't respect perf_ctx_disable(). Fixing that
>> will close this hole.
> 
> Here, does this work?
> 
> The clue is right in perf_event_context_sched_out():
> 
>                           perf_ctx_disable(ctx, 0);
> 
>                           /* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
>                           if (local_read(&ctx->nr_no_switch_fast) ||
>                               local_read(&next_ctx->nr_no_switch_fast)) {
> 
> There must be no overflow after perf_ctx_disable().
> 
> 
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1236,6 +1236,7 @@ extern const struct perf_event_attr *per
>  extern void perf_event_print_debug(void);
>  extern void perf_pmu_disable(struct pmu *pmu);
>  extern void perf_pmu_enable(struct pmu *pmu);
> +extern bool perf_pmu_enabled(struct pmu *pmu);
>  extern void perf_sched_cb_dec(struct pmu *pmu);
>  extern void perf_sched_cb_inc(struct pmu *pmu);
>  extern int perf_event_task_disable(void);
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1366,6 +1366,12 @@ void perf_pmu_enable(struct pmu *pmu)
>  		pmu->pmu_enable(pmu);
>  }
>  
> +bool perf_pmu_enabled(struct pmu *pmu)
> +{
> +	int *count = &this_cpc(pmu)->pmu_disable_count;
> +	return *count == 0;
> +}
> +
>  static void perf_assert_pmu_disabled(struct pmu *pmu)
>  {
>  	int *count = &this_cpc(pmu)->pmu_disable_count;
> @@ -11151,6 +11157,9 @@ static int perf_swevent_match(struct per
>  				struct perf_sample_data *data,
>  				struct pt_regs *regs)
>  {
> +	if (!perf_pmu_enabled(event->pmu))
> +		return 0;
> +
>  	if (event->attr.type != type)
>  		return 0;
>  
> @@ -11531,6 +11540,9 @@ static int perf_tp_event_match(struct pe
>  				struct perf_raw_record *raw,
>  				struct pt_regs *regs)
>  {
> +	if (!perf_pmu_enabled(event->pmu))
> +		return 0;
> +
>  	if (event->hw.state & PERF_HES_STOPPED)
>  		return 0;
>  	/*

This patch does not fix the issue; it can still be reproduced after testing.
The PoC is still the one mentioned in the cover letter:

  https://lore.kernel.org/all/d1b24bbf-9111-4766-87c8-ff97adcac727@huaweicloud.com/

[  191.663702] ------------[ cut here ]------------
[  191.663827] WARNING: kernel/events/core.c:7679 at perf_pending_task+0x2e4/0x370, CPU#1: fastswap/1419
[  191.667014] Modules linked in:
[  191.667731] CPU: 1 UID: 0 PID: 1419 Comm: fastswap Not tainted 7.4.0-rc2-next-20261113+ #10 PREEMPT(lazy) 
[  191.669103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/4
[  191.670736] RIP: 0010:perf_pending_task+0x2e4/0x370
[  191.671441] Code: 4c 8b ab c8 fe ff ff 49 ff 8d e8 00 00 00 e9 02 fe ff ff 4c 89 ef e8 6b f9 24 00 e9 b1 fd ff ff e8 c1 9
[  191.674022] RSP: 0000:ffff88810ff9fe08 EFLAGS: 00010202
[  191.674782] RAX: ffff88811844ed80 RBX: ffff888107575f98 RCX: 0000000000000000
[  191.675791] RDX: 1ffff11020eaeb95 RSI: 0000000000000004 RDI: ffff888107575ca8
[  191.676792] RBP: ffff888107575c00 R08: 0000000000000001 R09: ffffed1021ff3fbf
[  191.677800] R10: 0000000000000003 R11: ffffe8ffffc832a0 R12: 0000000000000000
[  191.678803] R13: ffff888105b19200 R14: ffff888107575e60 R15: ffff888118928000
[  191.679809] FS:  00007f39079c6600(0000) GS:ffff88826fd58000(0000) knlGS:0000000000000000
[  191.680939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  191.681768] CR2: 00007f3907145000 CR3: 000000010fe7a006 CR4: 0000000000170ef0
[  191.682774] Call Trace:
[  191.683139]  <TASK>
[  191.683525]  task_work_run+0x13d/0x200
[  191.684111]  ? __pfx_task_work_run+0x10/0x10
[  191.684750]  irqentry_exit+0x3a8/0x700
[  191.685291]  asm_exc_page_fault+0x26/0x30
[  191.685884] RIP: 0033:0x00000000d25df49d
[  191.686560] Code: c6 bf 2a 01 00 00 b8 00 00 00 00 e8 14 fe ff ff c9 c3 55 48 89 e5 89 7d fc 48 89 75 f0 48 89 55 e8 8b d
[  191.689089] RSP: 002b:00007ffd422628b0 EFLAGS: 00010202
[  191.689842] RAX: 000000000000002c RBX: 0000000000000001 RCX: 00007f390789cd13
[  191.690847] RDX: 00007ffd422628c0 RSI: 00007ffd422629f0 RDI: 0000000000000005
[  191.691849] RBP: 00007ffd422628b0 R08: 0000000000000000 R09: 00007ffd42262c27
[  191.692857] R10: 00007f39079c68d0 R11: 0000000000000246 R12: 00007ffd422631b8
[  191.693857] R13: 0000000000401a8a R14: 00007f39079ffaa0 R15: 0000000000403e08
[  191.694866]  </TASK>
[  191.695196] ---[ end trace 0000000000000000 ]---

Thanks,
Tengda

