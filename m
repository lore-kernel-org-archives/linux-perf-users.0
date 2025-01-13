Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FA145B00;
	Mon, 13 Jan 2025 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736738718; cv=none; b=gcOaGThIAnBn/Za9f5QtNsuVIw3QECF605Ex6/JdIABkse98zi54Emd+qXEf6zG0SycKu6HkF2XdVzNj4OcBhPxcqgkjIplcT0prSfDQVPkw+0uPjGz00P0ZC3aNCOO0E/YzxPmK5O4zeAf2d93EGXegLxOo7nr8HOQLnXhZfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736738718; c=relaxed/simple;
	bh=ZROcNkPL+PIui2Olv9okK5m2o/TQQDxJRJ6EDjzHyF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fh83hrziUU5cFwWDjHW1XEXCUZgtaJIQLde07ZOaWjzXzK3JRbBpc/a8A25vx3heX4TOBkAH9gL4kez9dlZp9yPo+RReGNb2Cw/1cnK6wrXaPl+0Exh/CxddJwegrap8YXVZAJr0g/VboY7ciAq9Co5UGRdNtG1RC1sxGcEVijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YWd0s2gngz4f3kFr;
	Mon, 13 Jan 2025 11:24:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ACE411A0AD1;
	Mon, 13 Jan 2025 11:25:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+Oh4Rn7Cs+Aw--.57391S4;
	Mon, 13 Jan 2025 11:25:03 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [RFC PATCH] perf/core: Fix warning in perf_cgroup_set_timestamp
Date: Mon, 13 Jan 2025 03:34:09 +0000
Message-Id: <20250113033409.1874607-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+Oh4Rn7Cs+Aw--.57391S4
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWxAFy8XFWrtFWfAw43Wrg_yoWfGw1fpw
	4UJF47Cr48tr1DJ345Jr15A3yUJr48Aa1UXr17Jr1rAF15Ww1UXF1UGr4UJrn8Jr1IqFy7
	tws8Xw40qr17JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Hello, syzkaller trigger a warning shown below.

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6936 at kernel/events/core.c:838 perf_cgroup_set_timestamp kernel/events/core.c:838 [inline]
WARNING: CPU: 1 PID: 6936 at kernel/events/core.c:838 ctx_sched_in+0x4c2/0x620 kernel/events/core.c:3911
Modules linked in:
CPU: 1 PID: 6936 Comm: syz.2.1408 Not tainted 6.6.0+ #41
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:perf_cgroup_set_timestamp kernel/events/core.c:838 [inline]
RIP: 0010:ctx_sched_in+0x4c2/0x620 kernel/events/core.c:3911
Code: 00 00 44 8b 6b 70 e9 9d fc ff ff e8 88 dd cb ff 40 0f b6 d5 48 8d 73 38 48 89 df e8 78 f9 ff ff e9 b7 fc ff ff e8 6e dd cb ff <0f> 0b 48 8b 0c 24 e9 11 fe ff ff e8 ce 4c 2b 00 48 8b 0c 24 e9 4b
RSP: 0018:ffff88800ac5f8c8 EFLAGS: 00010012
RAX: 0000000040000000 RBX: ffff88800c814600 RCX: ffffffffa447acc2
RDX: ffff88810913a340 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed100158bf1b
R10: 0000000000000000 R11: 1ffff110201dc18c R12: ffff88800c814670
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8881190bf7c0
FS:  00007f803d1276c0(0000) GS:ffff888119080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000065b8b0 CR3: 000000003492e005 CR4: 0000000000772ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 80000000
Call Trace:
 <TASK>
 perf_event_sched_in kernel/events/core.c:2678 [inline]
 perf_event_context_sched_in kernel/events/core.c:3984 [inline]
 __perf_event_task_sched_in+0x26c/0x450 kernel/events/core.c:4013
 perf_event_task_sched_in include/linux/perf_event.h:1515 [inline]
 finish_task_switch.isra.0+0x3af/0x7b0 kernel/sched/core.c:5508
 context_switch kernel/sched/core.c:5642 [inline]
 __schedule+0xd2a/0x2000 kernel/sched/core.c:6964
 schedule+0x134/0x2f0 kernel/sched/core.c:7040
 futex_wait_queue+0xc8/0x170 kernel/futex/waitwake.c:355
 futex_wait+0x29e/0x680 kernel/futex/waitwake.c:656
 do_futex+0x194/0x360 kernel/futex/syscalls.c:106
 __do_sys_futex kernel/futex/syscalls.c:183 [inline]
 __se_sys_futex+0xf7/0x390 kernel/futex/syscalls.c:164
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x78/0xe2
RIP: 0033:0x54d2cd
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f803d1270e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000796088 RCX: 000000000054d2cd
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000796088
RBP: 0000000000796080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000079608c
R13: 0000000000000000 R14: 00007ffd609954a0 R15: 00007f803d107000
 </TASK>

I check other cpu callstack, and I found that cpu2 was closing an event and
event->ctx is pointer to cpu1 perf_cpu_context->ctx.

crash> bt -c2
PID: 6935     TASK: ffff88800f062340  CPU: 2    COMMAND: "syz.2.1408"
    [exception RIP: stop_this_cpu+219]
    RIP: ffffffffa3ba29bb  RSP: fffffe651efe1e30  RFLAGS: 00000046
    RAX: 0000000080110001  RBX: 0000000080000008  RCX: ffffffffa3ba29ba
    RDX: ffff88800f062340  RSI: 0000000000000008  RDI: ffffffffb9505720
    RBP: 0000000000000002   R8: 0000000000000001   R9: fffffbfff72a0ae4
    R10: ffffffffb9505727  R11: 0000000000000000  R12: 0000000000000000
    R13: 0000005fe3697e1e  R14: dffffc0000000000  R15: ffffffffb39191b0
    CS: 0010  SS: 0018
 #0 [fffffe651efe1e40] smp_stop_nmi_callback at ffffffffa3c1db02
 #1 [fffffe651efe1e58] nmi_handle at ffffffffa3b831f9
 #2 [fffffe651efe1eb0] default_do_nmi at ffffffffaf334415
 #3 [fffffe651efe1ed0] exc_nmi at ffffffffaf3345f4
 #4 [fffffe651efe1ef0] end_repeat_nmi at ffffffffaf401dae
    [exception RIP: kvm_wait+259]
    RIP: ffffffffa3c5c423  RSP: ffff88802d2b7a68  RFLAGS: 00000093
    RAX: 0000000000000000  RBX: 0000000000000003  RCX: ffffffffa3c5c422
    RDX: ffff88800f062340  RSI: 0000000000000003  RDI: 0000000000000000
    RBP: ffff8881190bf7c0   R8: 0000000000000001   R9: ffffed1023217ef8
    R10: 0000000000000003  R11: 0000000000000000  R12: 0000000000000003
    R13: 0000000000000003  R14: ffff8881190bf7c0  R15: ffff888119146940
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffff88802d2b7a68] kvm_wait at ffffffffa3c5c423
 #6 [ffff88802d2b7a88] __pv_queued_spin_lock_slowpath at ffffffffaf370e53
 #7 [ffff88802d2b7b60] _raw_spin_lock_irqsave at ffffffffaf36eb0b
 #8 [ffff88802d2b7be0] _atomic_dec_and_raw_lock_irqsave at ffffffffaf24ae15
 #9 [ffff88802d2b7c20] put_pmu_ctx at ffffffffa4453f04
 #10 [ffff88802d2b7cc8] _free_event at ffffffffa4480ed0
 #11 [ffff88802d2b7d10] perf_event_release_kernel at ffffffffa4484f61
 #12 [ffff88802d2b7dd8] perf_release at ffffffffa44851cc
 #13 [ffff88802d2b7de8] __fput at ffffffffa4845e96
 #14 [ffff88802d2b7e60] task_work_run at ffffffffa3e2de14
 #15 [ffff88802d2b7f08] syscall_exit_to_user_mode at ffffffffaf338044
 #16 [ffff88802d2b7f28] do_syscall_64 at ffffffffaf330306
 #17 [ffff88802d2b7f50] entry_SYSCALL_64_after_hwframe at ffffffffaf400134
    RIP: 000000000054d2cd  RSP: 00007f803d148048  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: 0000000000795fa0  RCX: 000000000054d2cd
    RDX: 0000000000000000  RSI: ffffffffffffffff  RDI: 000000000000000f
    RBP: 0000000000000000   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000246  R12: 0000000000795fac
    R13: 0000000000000000  R14: 0000000000795fa0  R15: 00007f803d128000
    ORIG_RAX: 00000000000001b4  CS: 0033  SS: 002b

From above callstack, cpu2 has removed the event from perf_cpu_context. So
the warning should not be trigger. Most of the places that operate cgrp
are lock protected. But I found that perf_cgroup_switch might be the
problem.

static void perf_cgroup_switch(struct task_struct *task)
{
	...
	// step 1 check cgrp info
	if (READ_ONCE(cpuctx->cgrp) == NULL)
		return;

	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);

	cgrp = perf_cgroup_from_task(task, NULL);
	if (READ_ONCE(cpuctx->cgrp) == cgrp)
		return;

	// step 2 get cpuctx lock
	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
	...

	// step 3 update cgrp info
	cpuctx->cgrp = cgrp;
	...

	// step 4 release cpuctx lock
	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
	...
}

The step 1 and step 2 look like unreasonable. Because when it check the
cgrp info, it is not under lock protect, so after it acquire the
cpuctx->ctx.lock, the cgrp info may already changed to NULL. So I think it
should change the sequence of steps 1 and 2. But I can't reproduce the this
problem, please help if have any suggestions.

Thanks
Gengkun

Fixes: facc43071cc0 ("perf: Optimize event scheduling locking")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..bca64889069b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -885,20 +885,21 @@ static void perf_cgroup_switch(struct task_struct *task)
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cgroup *cgrp;
 
+	cgrp = perf_cgroup_from_task(task, NULL);
+
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	/*
 	 * cpuctx->cgrp is set when the first cgroup event enabled,
 	 * and is cleared when the last cgroup event disabled.
 	 */
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
-		return;
+		goto unlock;
 
 	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
 
-	cgrp = perf_cgroup_from_task(task, NULL);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
-		return;
+		goto unlock;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
@@ -916,6 +917,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
+unlock:
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
-- 
2.34.1

