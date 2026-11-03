Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668899;
	b=NDnRFTY+2BfKmvHFSllMbHGqM07FbVs6aKJ9ga3BN9iCzeDFeK7EhR30PlhBql3PSFdq
	 2HiU1gGxKBGYf6pmNTHvDKU5dhcOZj5/KZ23qCZEMhp4qOJUAMN6Fll2EdVaBSVxHKULm
	 SbvJ50R/y+J4d4ZFItPhC86ihn67/91qS4iBm487oU0teVNlttMlJJpTW+aE9qFuSrEUF
	 fBKvnbbYZT72G0AbpJ35Y9slDTMK8w24TWzQK+MpuV/cfVenOEc5JDgcnCJ8uaDZogMY4
	 XXbkMpAM3wgv7YFwye106Gy0H1I3q8OugvYXbko5PoA294GpjDRSUlHtt7kWvvtO8cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668899;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=XIZl8PKldKeXcfMGbxis8MjrNoHoUOe4+gARG5AmC1k=;
	b=OaFDBQGqgRQ+R+JoWKhT3Bdv67qVqPN0kzGjEaOW2eOBgihq/2Aj+csiqFn0oyX/T+GL
	 yaOwARshWiVt5clT6+nanWIcH7ZTfalnSabH28dWeHX80en0Mg4EnCSHfIRCC9TqxvekY
	 9VjRoWmhaD7qsbSm4DSreSh0eJfYgHLqJ0HE49Q1dOXNz+OGlb2r9m0wwBtUg4jPOTUd+
	 wQk8fW8ad7iIvC3WY7d0/aK7nyKDYCKNpM2sdv+kgH2z9mbA+TiKv54SpMAADykTDYPw0
	 oX+f7RBdmhCaXR1eQc9lRPHwBohv6IaZCRuddhGeItoV9QFCDs4f/0rBRkRaNmtB7rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7ED606A324;
	Tue,  3 Nov 2026 01:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB7ED606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jJW4062FWz201q;
	Tue,  3 Nov 2026 09:21:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 53AEA40B68;
	Tue,  3 Nov 2026 09:21:28 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAHXNEWN+lqj0FSCw--.4894S2;
	Tue, 03 Nov 2026 09:21:28 +0800 (CST)
Message-ID: <7eda59a0-3131-4f3d-a3fa-7b7f95e5cd75@huaweicloud.com>
Date: Tue, 3 Nov 2026 09:21:26 +0800
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
Subject: Re: [PATCH] perf/core: Prevent duplicate sigtrap task work enqueue
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261031114520.642476-1-wutengda@huaweicloud.com>
 <20261102163540.4WF7hhhW@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261102163540.4WF7hhhW@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAHXNEWN+lqj0FSCw--.4894S2
X-Coremail-Antispam: 1UD129KBjvAXoWfCrW7Jr4DCF45AFyUtr4xWFg_yoW8uFW8Go
	WxXa18Ka1xGw15G3yxXF1xJa1Du3W0yF1xtr1vkr45JFn7XrWUZFyfJr18t3yUGr45GFnx
	Zrn7Kr18uw15t393n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYc7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/3 0:35, Sebastian Andrzej Siewior wrote:
> On 2026-10-31 11:45:20 [+0000], Tengda Wu wrote:
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
> 
> How was the issue identified?
> 
> Sebastian

This issue was discovered by syzkaller, and the warning and the reproducer
(named "gpt", because I used GPT to convert the syzkaller program into C code)
are as follows:

Warning
=======

# ./gpt
msr:write_msr id=2252 cpu=1 workers=4 duration=60s
Each child opens tracepoint(sigtrap) + hardware(cache-misses), then exits without close().
[   67.536731] gpt (1697) used greatest stack depth: 24952 bytes left
[   67.686591] ------------[ cut here ]------------
[   67.686598] WARNING: kernel/events/core.c:10932 at __perf_event_overflow+0xa48/0xbf0, CPU#1: gpt/1709
[   67.688569] Modules linked in:
[   67.689017] CPU: 1 UID: 0 PID: 1709 Comm: gpt Not tainted 7.3.0-next-20261027 #2 PREEMPT(lazy) 
[   67.690194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/4
[   67.691718] RIP: 0010:__perf_event_overflow+0xa48/0xbf0
[   67.692431] Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 01 00 00 48 8b 04 24 48 8b 80 b8 00 00 00 49 89 86 50 0
[   67.694915] RSP: 0000:fffffe0000058888 EFLAGS: 00010046
[   67.695633] RAX: 0000000000000000 RBX: 1fffffc00000b119 RCX: 0000000000000001
[   67.696594] RDX: 1ffff11023118a5e RSI: 0000000000000008 RDI: ffff8881188c52f0
[   67.697552] RBP: ffff8881188c51cc R08: 0000000000000001 R09: ffffed1023118a5e
[   67.698519] R10: ffff8881188c52f7 R11: ffff8881188c5428 R12: ffff8881f70b3538
[   67.699480] R13: ffff8881188c52f0 R14: ffff8881188c5080 R15: ffff8881188c53c4
[   67.700445] FS:  00007fed98fc6600(0000) GS:ffff88826ff74000(0000) knlGS:0000000000000000
[   67.701532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.702317] CR2: 00007fed98d06000 CR3: 000000010507c004 CR4: 0000000000170ef0
[   67.703281] Call Trace:
[   67.703636]  <NMI>
[   67.703936]  ? __pfx___perf_event_overflow+0x10/0x10
[   67.704629]  ? perf_swevent_set_period+0x131/0x1c0
[   67.705288]  ? __pfx_perf_swevent_set_period+0x10/0x10
[   67.705992]  ? __pfx_perf_event_output_forward+0x10/0x10
[   67.706726]  perf_swevent_event+0x1d0/0x390
[   67.707304]  perf_tp_event+0x3b3/0x8c0
[   67.707831]  ? __perf_event_account_interrupt+0x24/0x570
[   67.708562]  ? __pfx_perf_tp_event+0x10/0x10
[   67.709158]  ? __pfx_x86_pmu_update_perf_regs+0x10/0x10
[   67.709879]  ? handle_pmi_common+0x42f/0x8a0
[   67.710475]  ? __pfx_handle_pmi_common+0x10/0x10
[   67.711118]  perf_trace_msr_trace_class+0x28e/0x450
[   67.711797]  ? __pfx_perf_trace_msr_trace_class+0x10/0x10
[   67.712532]  ? intel_bts_interrupt+0x71/0x4c0
[   67.713146]  do_trace_write_msr+0xaa/0xe0
[   67.713707]  __intel_pmu_enable_all.constprop.0+0x1db/0x350
[   67.714467]  intel_pmu_handle_irq+0x721/0xb70
[   67.715079]  ? __pfx_mce_raise_notify+0x10/0x10
[   67.715711]  ? irq_work_queue+0x7a/0xc0
[   67.716248]  perf_event_nmi_handler+0x13c/0x1a0
[   67.716885]  nmi_handle.part.0+0xb9/0x350
[   67.717443]  ? find_bug+0x3d/0x230
[   67.717931]  default_do_nmi+0x6b/0x180
[   67.718458]  exc_nmi+0xf3/0x120
[   67.718910]  end_repeat_nmi+0xf/0x53
[   67.719413] RIP: 0010:find_bug+0x3d/0x230
[   67.719975] Code: 48 89 fb 48 3d b0 65 0d 86 0f 83 8c 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 83 e0 07 48 c1 e9 4
[   67.722448] RSP: 0000:ffff888118957ae0 EFLAGS: 00000006
[   67.723166] RAX: 0000000000000003 RBX: ffffffff81a666e5 RCX: 1ffffffff0c14c80
[   67.724129] RDX: 0000000000000000 RSI: ffffffff81a666e5 RDI: ffffffff81a666e5
[   67.725098] RBP: ffffffff8713f810 R08: 0000000000000000 R09: 0000000000000000
[   67.726066] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81a666e5
[   67.727033] R13: ffff888118957c88 R14: 0000000000000000 R15: 0000000000000000
[   67.728000]  ? put_pmu_ctx+0x255/0x300
[   67.728528]  ? put_pmu_ctx+0x255/0x300
[   67.729056]  ? put_pmu_ctx+0x255/0x300
[   67.729583]  ? put_pmu_ctx+0x255/0x300
[   67.730111]  ? find_bug+0x3d/0x230
[   67.730597]  ? find_bug+0x3d/0x230
[   67.731077]  </NMI>
[   67.731383]  <TASK>
[   67.731694]  ? put_pmu_ctx+0x255/0x300
[   67.732217]  __report_bug+0x35a/0x3e0
[   67.732736]  ? put_pmu_ctx+0x255/0x300
[   67.733261]  ? __kasan_slab_free+0x43/0x70
[   67.733834]  ? __pfx___report_bug+0x10/0x10
[   67.734411]  ? task_work_run+0x13d/0x200
[   67.734962]  ? irqentry_exit+0x3a8/0x700
[   67.735507]  ? asm_exc_page_fault+0x26/0x30
[   67.736090]  ? __send_signal_locked+0x3c0/0xb40
[   67.736726]  ? __send_signal_locked+0x52f/0xb40
[   67.737358]  ? put_pmu_ctx+0x255/0x300
[   67.737886]  report_bug+0x95/0x1a0
[   67.738368]  ? put_pmu_ctx+0x255/0x300
[   67.738897]  handle_bug+0x267/0x2d0
[   67.739387]  exc_invalid_op+0x18/0x50
[   67.739904]  asm_exc_invalid_op+0x1a/0x20
[   67.740459] RIP: 0010:put_pmu_ctx+0x255/0x300
[   67.741067] Code: 75 4a 48 83 c4 68 5b 5d 41 5c 41 5d 41 5e 41 5f e9 50 8b d4 02 48 c7 c6 80 57 a6 81 e8 e4 af b1 ff eb c
[   67.743549] RSP: 0000:ffff888118957d30 EFLAGS: 00010083
[   67.744268] RAX: ffff8881188c50a0 RBX: ffff888104258f00 RCX: 1ffff110209df084
[   67.745235] RDX: 1ffff1102084b1e4 RSI: 0000000000000004 RDI: ffff888107949218
[   67.746201] RBP: 1ffff1102312afa7 R08: 0000000000000001 R09: ffffed102084b1ea
[   67.747167] R10: ffff888104258f53 R11: ffffffff810012a6 R12: ffff888104258f20
[   67.748132] R13: ffff888104258f08 R14: ffff888104ef8400 R15: ffff888104ef8420
[   67.749098]  ? asm_exc_page_fault+0x26/0x30
[   67.749680]  ? __pfx_put_pmu_ctx+0x10/0x10
[   67.750246]  ? mutex_unlock+0x82/0xd0
[   67.750763]  ? __pfx_mutex_unlock+0x10/0x10
[   67.751342]  __free_event+0x1cf/0x680
[   67.751855]  ? _raw_spin_lock_irq+0x8b/0xe0
[   67.752436]  perf_pending_task+0x101/0x330
[   67.753009]  ? count_memcg_events+0x273/0x410
[   67.753620]  task_work_run+0x13d/0x200
[   67.754146]  ? __pfx_task_work_run+0x10/0x10
[   67.754744]  ? __do_sys_rt_sigreturn+0x161/0x1b0
[   67.755385]  irqentry_exit+0x3a8/0x700
[   67.755912]  asm_exc_page_fault+0x26/0x30
[   67.756467] RIP: 0033:0x7fed98f3cd3a
[   67.756979] Code: 0f 82 0a 01 00 00 48 83 fa 40 77 7d c5 fe 7f 44 17 e0 c5 fe 7f 07 c5 f8 77 c3 66 0f 1f 44 00 00 48 89 0
[   67.759451] RSP: 002b:00007ffdb7dc7628 EFLAGS: 00010206
[   67.760168] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000119010
[   67.761133] RDX: 00007fed985c7010 RSI: 0000000000000000 RDI: 00007fed98cae000
[   67.762101] RBP: 00007ffdb7dc7690 R08: 00007fed985c7010 R09: 0000000000000000
[   67.763069] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ffdb7dc7918
[   67.764033] R13: 0000000000401976 R14: 00007fed98fffaa0 R15: 0000000000403e08
[   67.765001]  </TASK>
[   67.765320] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   67.766196] CPU: 1 UID: 0 PID: 1709 Comm: gpt Not tainted 7.3.0-next-20261027 #2 PREEMPT(lazy) 
[   67.767370] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/4
[   67.768902] Call Trace:
[   67.769254]  <NMI>
[   67.769551]  vpanic+0x4be/0x540
[   67.770012]  ? __perf_event_overflow+0xa48/0xbf0
[   67.770653]  panic+0xc2/0xd0
[   67.771068]  ? __pfx_panic+0x10/0x10
[   67.771575]  check_panic_on_warn+0x7e/0x80
[   67.772145]  __warn+0xef/0x2b0
[   67.772586]  __report_bug+0x312/0x3e0
[   67.773102]  ? __perf_event_overflow+0xa48/0xbf0
[   67.773743]  ? __pfx___report_bug+0x10/0x10
[   67.774323]  ? perf_tp_event+0x3b3/0x8c0
[   67.774872]  ? arch_irq_work_raise+0x3f/0x60
[   67.775467]  ? __irq_work_queue_local+0x16b/0x3d0
[   67.776117]  ? __perf_event_overflow+0xa48/0xbf0
[   67.776759]  report_bug+0x95/0x1a0
[   67.777241]  ? __perf_event_overflow+0xa48/0xbf0
[   67.777883]  handle_bug+0x267/0x2d0
[   67.778375]  exc_invalid_op+0x18/0x50
[   67.778895]  asm_exc_invalid_op+0x1a/0x20
[   67.779451] RIP: 0010:__perf_event_overflow+0xa48/0xbf0
[   67.780169] Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 01 00 00 48 8b 04 24 48 8b 80 b8 00 00 00 49 89 86 50 0
[   67.782645] RSP: 0000:fffffe0000058888 EFLAGS: 00010046
[   67.783359] RAX: 0000000000000000 RBX: 1fffffc00000b119 RCX: 0000000000000001
[   67.784326] RDX: 1ffff11023118a5e RSI: 0000000000000008 RDI: ffff8881188c52f0
[   67.785292] RBP: ffff8881188c51cc R08: 0000000000000001 R09: ffffed1023118a5e
[   67.786258] R10: ffff8881188c52f7 R11: ffff8881188c5428 R12: ffff8881f70b3538
[   67.787223] R13: ffff8881188c52f0 R14: ffff8881188c5080 R15: ffff8881188c53c4
[   67.788191]  ? __perf_event_overflow+0x975/0xbf0
[   67.788833]  ? __pfx___perf_event_overflow+0x10/0x10
[   67.789514]  ? perf_swevent_set_period+0x131/0x1c0
[   67.790179]  ? __pfx_perf_swevent_set_period+0x10/0x10
[   67.790888]  ? __pfx_perf_event_output_forward+0x10/0x10
[   67.791618]  perf_swevent_event+0x1d0/0x390
[   67.792197]  perf_tp_event+0x3b3/0x8c0
[   67.792726]  ? __perf_event_account_interrupt+0x24/0x570
[   67.793453]  ? __pfx_perf_tp_event+0x10/0x10
[   67.794051]  ? __pfx_x86_pmu_update_perf_regs+0x10/0x10
[   67.794770]  ? handle_pmi_common+0x42f/0x8a0
[   67.795366]  ? __pfx_handle_pmi_common+0x10/0x10
[   67.796009]  perf_trace_msr_trace_class+0x28e/0x450
[   67.796686]  ? __pfx_perf_trace_msr_trace_class+0x10/0x10
[   67.797424]  ? intel_bts_interrupt+0x71/0x4c0
[   67.798035]  do_trace_write_msr+0xaa/0xe0
[   67.798596]  __intel_pmu_enable_all.constprop.0+0x1db/0x350
[   67.799357]  intel_pmu_handle_irq+0x721/0xb70
[   67.799965]  ? __pfx_mce_raise_notify+0x10/0x10
[   67.800600]  ? irq_work_queue+0x7a/0xc0
[   67.801136]  perf_event_nmi_handler+0x13c/0x1a0
[   67.801770]  nmi_handle.part.0+0xb9/0x350
[   67.802329]  ? find_bug+0x3d/0x230
[   67.802816]  default_do_nmi+0x6b/0x180
[   67.803343]  exc_nmi+0xf3/0x120
[   67.803795]  end_repeat_nmi+0xf/0x53
[   67.804298] RIP: 0010:find_bug+0x3d/0x230
[   67.804858] Code: 48 89 fb 48 3d b0 65 0d 86 0f 83 8c 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 83 e0 07 48 c1 e9 4
[   67.807329] RSP: 0000:ffff888118957ae0 EFLAGS: 00000006
[   67.808047] RAX: 0000000000000003 RBX: ffffffff81a666e5 RCX: 1ffffffff0c14c80
[   67.809012] RDX: 0000000000000000 RSI: ffffffff81a666e5 RDI: ffffffff81a666e5
[   67.809978] RBP: ffffffff8713f810 R08: 0000000000000000 R09: 0000000000000000
[   67.810943] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81a666e5
[   67.811909] R13: ffff888118957c88 R14: 0000000000000000 R15: 0000000000000000
[   67.812877]  ? put_pmu_ctx+0x255/0x300
[   67.813401]  ? put_pmu_ctx+0x255/0x300
[   67.813930]  ? put_pmu_ctx+0x255/0x300
[   67.814453]  ? put_pmu_ctx+0x255/0x300
[   67.814984]  ? find_bug+0x3d/0x230
[   67.815465]  ? find_bug+0x3d/0x230
[   67.815948]  </NMI>
[   67.816255]  <TASK>
[   67.816567]  ? put_pmu_ctx+0x255/0x300
[   67.817092]  __report_bug+0x35a/0x3e0
[   67.817610]  ? put_pmu_ctx+0x255/0x300
[   67.818134]  ? __kasan_slab_free+0x43/0x70
[   67.818705]  ? __pfx___report_bug+0x10/0x10
[   67.819283]  ? task_work_run+0x13d/0x200
[   67.819833]  ? irqentry_exit+0x3a8/0x700
[   67.820378]  ? asm_exc_page_fault+0x26/0x30
[   67.820959]  ? __send_signal_locked+0x3c0/0xb40
[   67.821592]  ? __send_signal_locked+0x52f/0xb40
[   67.822221]  ? put_pmu_ctx+0x255/0x300
[   67.822749]  report_bug+0x95/0x1a0
[   67.823230]  ? put_pmu_ctx+0x255/0x300
[   67.823759]  handle_bug+0x267/0x2d0
[   67.824250]  exc_invalid_op+0x18/0x50
[   67.824766]  asm_exc_invalid_op+0x1a/0x20
[   67.825322] RIP: 0010:put_pmu_ctx+0x255/0x300
[   67.825932] Code: 75 4a 48 83 c4 68 5b 5d 41 5c 41 5d 41 5e 41 5f e9 50 8b d4 02 48 c7 c6 80 57 a6 81 e8 e4 af b1 ff eb c
[   67.828401] RSP: 0000:ffff888118957d30 EFLAGS: 00010083
[   67.829117] RAX: ffff8881188c50a0 RBX: ffff888104258f00 RCX: 1ffff110209df084
[   67.830083] RDX: 1ffff1102084b1e4 RSI: 0000000000000004 RDI: ffff888107949218
[   67.831046] RBP: 1ffff1102312afa7 R08: 0000000000000001 R09: ffffed102084b1ea
[   67.832011] R10: ffff888104258f53 R11: ffffffff810012a6 R12: ffff888104258f20
[   67.832978] R13: ffff888104258f08 R14: ffff888104ef8400 R15: ffff888104ef8420
[   67.833948]  ? asm_exc_page_fault+0x26/0x30
[   67.834526]  ? __pfx_put_pmu_ctx+0x10/0x10
[   67.835097]  ? mutex_unlock+0x82/0xd0
[   67.835613]  ? __pfx_mutex_unlock+0x10/0x10
[   67.836192]  __free_event+0x1cf/0x680
[   67.836707]  ? _raw_spin_lock_irq+0x8b/0xe0
[   67.837289]  perf_pending_task+0x101/0x330
[   67.837862]  ? count_memcg_events+0x273/0x410
[   67.838470]  task_work_run+0x13d/0x200
[   67.839000]  ? __pfx_task_work_run+0x10/0x10
[   67.839599]  ? __do_sys_rt_sigreturn+0x161/0x1b0
[   67.840238]  irqentry_exit+0x3a8/0x700
[   67.840767]  asm_exc_page_fault+0x26/0x30
[   67.841323] RIP: 0033:0x7fed98f3cd3a
[   67.841827] Code: 0f 82 0a 01 00 00 48 83 fa 40 77 7d c5 fe 7f 44 17 e0 c5 fe 7f 07 c5 f8 77 c3 66 0f 1f 44 00 00 48 89 0
[   67.844298] RSP: 002b:00007ffdb7dc7628 EFLAGS: 00010206
[   67.845015] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000119010
[   67.845980] RDX: 00007fed985c7010 RSI: 0000000000000000 RDI: 00007fed98cae000
[   67.846945] RBP: 00007ffdb7dc7690 R08: 00007fed985c7010 R09: 0000000000000000
[   67.847909] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ffdb7dc7918
[   67.848876] R13: 0000000000401976 R14: 00007fed98fffaa0 R15: 0000000000403e08
[   67.849845]  </TASK>
[   67.850285] Dumping ftrace buffer:
[   67.850779]    (ftrace buffer empty)
[   67.851279] Kernel Offset: disabled
[   67.851772] ---[ end Kernel panic - not syncing: kernel: panic_on_warn set ... ]---


Reproducer (named "gpt")
========================

/*
 * Reproducer for the perf_trace_event_unreg -> _free_event -> put_pmu_ctx()
 * path reached from perf_pending_task() on Linux 6.6 x86.
 *
 * Run only in a disposable VM with the Intel PMU exposed to the guest.
 * The test intentionally exits short-lived children without explicitly
 * closing the perf fds: exit_files() tears them down, then exit task_work
 * can drop the pending reference held by perf_pending_task().
 */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include "perf_event.h"
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static volatile sig_atomic_t sigtrap_count;

static void sigtrap_handler(int sig, siginfo_t *info, void *ctx)
{
	(void)sig;
	(void)info;
	(void)ctx;
	sigtrap_count++;
}

static int perf_open(struct perf_event_attr *attr, pid_t pid, int cpu)
{
	return syscall(__NR_perf_event_open, attr, pid, cpu, -1,
		       PERF_FLAG_FD_CLOEXEC);
}

static int read_msr_tracepoint_id(void)
{
	static const char * const paths[] = {
		"/sys/kernel/tracing/events/msr/write_msr/id",
		"/sys/kernel/debug/tracing/events/msr/write_msr/id",
	};
	char buf[64];
	unsigned int i;

	for (i = 0; i < sizeof(paths) / sizeof(paths[0]); i++) {
		int fd = open(paths[i], O_RDONLY | O_CLOEXEC);
		ssize_t n;

		if (fd < 0)
			continue;
		n = read(fd, buf, sizeof(buf) - 1);
		close(fd);
		if (n <= 0)
			continue;
		buf[n] = '\0';
		return (int)strtol(buf, NULL, 10);
	}
	return -1;
}

static int open_msr_sigtrap_event(int tracepoint_id, int cpu)
{
	struct perf_event_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.size = sizeof(attr);
	attr.type = PERF_TYPE_TRACEPOINT;
	attr.config = tracepoint_id;
	attr.sample_period = 4;
	attr.sample_type = PERF_SAMPLE_IP;
	attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
			   PERF_FORMAT_TOTAL_TIME_RUNNING;
	attr.pinned = 1;
	attr.exclusive = 1;
	attr.exclude_idle = 1;
	attr.exclude_user = 0;
	attr.exclude_kernel = 0;
	attr.remove_on_exec = 1;
	attr.sigtrap = 1;
	attr.sig_data = 7;

	/* pid=0 makes this a current-task event constrained to @cpu. */
	return perf_open(&attr, 0, cpu);
}

static int open_cache_miss_event(int cpu)
{
	struct perf_event_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.size = sizeof(attr);
	attr.type = PERF_TYPE_HARDWARE;
	attr.config = PERF_COUNT_HW_CACHE_MISSES; /* original config == 3 */
	attr.sample_period = 100;
	attr.sample_type = PERF_SAMPLE_IP;
	attr.pinned = 1;
	attr.exclusive = 1;
	attr.exclude_idle = 1;
	attr.exclude_user = 0;
	attr.exclude_kernel = 0;
	/* Do not set sigtrap here: the tracepoint event must own pending_task. */

	return perf_open(&attr, 0, cpu);
}

static int set_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	return sched_setaffinity(0, sizeof(set), &set);
}

static void workload(unsigned int ms)
{
	struct timespec start, now;
	uint64_t elapsed;
	const size_t bytes = 8 * 1024 * 1024;
	volatile unsigned char *buf = malloc(bytes);
	volatile uint64_t x = 1;
	uint32_t index = 0x12345678;

	if (buf)
		memset((void *)buf, 0, bytes);
	clock_gettime(CLOCK_MONOTONIC, &start);
	do {
		for (unsigned int i = 0; i < 100000; i++) {
			x = x * 1664525 + 1013904223;
			/* Pseudo-random cache-line accesses over an 8 MiB set. */
			index = index * 1664525 + 1013904223;
			if (buf)
				buf[(index & (bytes - 1)) & ~63U]++;
		}
		clock_gettime(CLOCK_MONOTONIC, &now);
		elapsed = (uint64_t)(now.tv_sec - start.tv_sec) * 1000;
		if (now.tv_nsec >= start.tv_nsec)
			elapsed += (uint64_t)(now.tv_nsec - start.tv_nsec) / 1000000;
		else
			elapsed -= (uint64_t)(start.tv_nsec - now.tv_nsec) / 1000000;
	} while (elapsed < ms);
	free((void *)buf);
	(void)x;
}

/* One short-lived task, matching syzkaller's fork/execute/exit pattern. */
static void one_child(int cpu, int tracepoint_id)
{
	struct sigaction sa;
	int tp_fd, hw_fd;

	memset(&sa, 0, sizeof(sa));
	sa.sa_sigaction = sigtrap_handler;
	sa.sa_flags = SA_SIGINFO | SA_RESTART;
	sigemptyset(&sa.sa_mask);
	if (sigaction(SIGTRAP, &sa, NULL))
		_exit(10);

	/* As in the original POC, constrain the task after opening events. */
        if (set_cpu(cpu)) {
                dprintf(2, "[%d] sched_setaffinity failed: %s\n",
                        getpid(), strerror(errno));
                _exit(13);
        }
	/*
	 * Open the hardware event first (lower fd), then the tracepoint event
	 * (higher fd). Linux 6.6 close_files() walks fds upward during exit:
	 *
	 *   1. hardware fd closes first and PMU teardown writes MSRs;
	 *   2. msr:write_msr is still subscribed and can queue task_work;
	 *   3. tracepoint fd closes, dropping its file reference;
	 *   4. exit_task_work() runs perf_pending_task(); put_event() can now
	 *      be the final reference and reach perf_trace_event_unreg().
	 *
	 * This ordering is intentional and is the main difference from the
	 * earlier reproducer.
	 */
	hw_fd = open_cache_miss_event(cpu);
	if (hw_fd < 0) {
		dprintf(2, "[%d] open cache-misses failed: %s\n",
			getpid(), strerror(errno));
		_exit(11);
	}

	tp_fd = open_msr_sigtrap_event(tracepoint_id, cpu);
	if (tp_fd < 0) {
		dprintf(2, "[%d] open msr tracepoint failed: %s\n",
			getpid(), strerror(errno));
		_exit(12);
	}

	workload(5);

	/* Do not close either fd here. Exit path ordering is part of the test. */
	_exit(0);
}

static void worker(int cpu, int tracepoint_id, time_t end)
{
	unsigned long iter = 0;

	while (time(NULL) < end) {
		pid_t pid = fork();
		int status;

		if (pid < 0) {
			perror("fork");
			_exit(2);
		}
		if (!pid)
			one_child(cpu, tracepoint_id);

		while (waitpid(pid, &status, 0) < 0 && errno == EINTR)
			;
		iter++;
	}

	dprintf(2, "[worker %d] cpu=%d iterations=%lu\n",
		getpid(), cpu, iter);
	_exit(0);
}

int main(int argc, char **argv)
{
	int cpu = argc > 1 ? atoi(argv[1]) : 1;
	int workers = argc > 2 ? atoi(argv[2]) : 4;
	int duration = argc > 3 ? atoi(argv[3]) : 60;
	int tracepoint_id, ncpu;
	pid_t *pids;
	time_t end;

	if (workers < 1)
		workers = 1;
	if (duration < 1)
		duration = 1;

	ncpu = (int)sysconf(_SC_NPROCESSORS_ONLN);
	if (cpu < 0 || cpu >= ncpu) {
		fprintf(stderr, "invalid cpu %d (online cpus: %d)\n", cpu, ncpu);
		return 1;
	}

	tracepoint_id = read_msr_tracepoint_id();
	if (tracepoint_id < 0) {
		fprintf(stderr, "cannot read msr:write_msr tracepoint id; "
			"mount tracefs/debugfs and check CONFIG_X86_MSR\n");
		return 1;
	}

	fprintf(stderr, "msr:write_msr id=%d cpu=%d workers=%d duration=%ds\n",
		tracepoint_id, cpu, workers, duration);
	fprintf(stderr, "Each child opens tracepoint(sigtrap) + "
		"hardware(cache-misses), then exits without close().\n");

	pids = calloc((size_t)workers, sizeof(*pids));
	if (!pids)
		return 1;
	end = time(NULL) + duration;

	for (int i = 0; i < workers; i++) {
		pid_t pid = fork();
		if (pid < 0) {
			perror("fork worker");
			break;
		}
		if (!pid)
			worker(cpu, tracepoint_id, end);
		pids[i] = pid;
	}

	for (int i = 0; i < workers; i++)
		if (pids[i] > 0)
			waitpid(pids[i], NULL, 0);
	free(pids);
	return 0;
}

Thanks,
Tengda

