Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46823130A73;
	Sun,  1 Jun 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748799429; cv=none; b=K0wIdDgwdtMvMD53C4VQgQu8uHBl7QMxlxij+TH4vb+8KyfYuWRtkKhLhbasXUOL2e2LrMgvvnXblA9jxTLhe4FJBXZPFO4Uql35Wpv0C2YxJJYXVZ401Vf508eP7zOxkSlyqOoG854CqyqLCXCu2XQh9/M64rvChXvjWkgajX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748799429; c=relaxed/simple;
	bh=NVjc1Vhtb1ux3Cw7s+ruy1up4JfJkPlZ0G7owI/j2IM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIVHJ8zE30L8u0Cv8noiOwvkD6JeNhB/TuZNwZwymatxVQkrkLP/MMPwVo6itUhOkGjeXJ2zxoPFu5J8DNgf9m8KL3wNOZTemvPG8z73sKEtnOyMIW95v53N2I4aJ+qTRcJp4loQBL7XniapmvjBngsYufhQV4HyU+rXQ3J3z2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WTFPE3EL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WTFPE3EL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QS
	Abk8u6Isf18mdwu+1NVxO1zb8ggOWJU6i8G8rJ7uQ=; b=WTFPE3EL6Z7Hoyd70/
	8SSU0Zd3wBOtm6URW5ZVnvv/mNcfF/1fCAWGz8iVq9uj1c2xJR8xX6TjxGVTYEoM
	fZ2juCc0XW7avYA01vxyAHiDZWkhH+6Pl0ENsm/gUGUfu1t8/We72gzsGikIuL7I
	wdKdjxuYkiwevgLo5yQEmVHPc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnt7yGjzxokb0uFg--.4965S4;
	Mon, 02 Jun 2025 01:36:22 +0800 (CST)
From: David Wang <00107082@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mingo@kernel.org,
	yeoreum.yun@arm.com,
	leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [BUG][6.15][perf] Kernel panic not syncing: Fatal exception in interrupt 
Date: Mon,  2 Jun 2025 01:36:03 +0800
Message-Id: <20250601173603.3920-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt7yGjzxokb0uFg--.4965S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWUXFW3Wr48tw1xJF4DCFg_yoWrtr1rpr
	WDKrnxKw4vqryDX3W5J3WUXw15GrW8AFs8XF1kJr1xZF1Yg3W5JF18trWYvr45tr9xXa47
	twsYqw1Iq3srJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ5rxUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqANfqmg8hNWvRAAAsw

Hi,

Caught a kernel panic when rebooting, system stuck until pressing power button.
I have only a screenshot when it happens, following logs were extracted from a
captured picture.

863.881960] sysved_call_function_sing le+0x4c/0xc0
863.881301] asm_sysvec_call_function_single+0x16/0x20
869.881344] RIP: 0633:0x7f9alcea3367
663.681373] Code: 00 66 99 b8 ff ff ff ff c3 66 ....
863.881524] RSP: 002b:00007fffa526fcf8 EFLAGS: 00000246
869.881567] RAX: 0000562060c962d0 RBX: 0000000000000002 RCX: 00007f9a1cff1c60
863.881625] RDX: 00007f9a0c000030 RSI: 00007f9alcff1c60 RDI: 00007f9a1ca91c20
863.081682] RBP: 0000000000000001 R08: 0000000000000000 R09: 00007f9a1d6217a0
869.881740] R10: 00007f9alca91c10 R11: 0000000000000246 R12: 00007f9a1d70c020
869.881798] R13: 00007fffa5270030 R14: 00007fffa526fd00 R15: 0000000000000000
863.881860] </TASK>
863.881876) Modules linked in: snd_seq_dummy (E) snd_hrtimer (E)...
...
863.887142] button (E)
863.912127] CR2: ffffe4afcc079650
863.914593] --- [ end trace 0000000000000000 1--
864.042750] RIP: 0010:ctx_sched_out+0x1ce/0x210
864.045214] Code: 89 c6 4c 8b b9 de 00 00 00 48 ...
864.050343] RSP: 0000:ffffaa4ec0f3fe60 EFLAGS: 00010086
864.052929] RAX: 0000000000000002 RBX: ffff8e8eeed2a580 RCX: ffff8e8bded9bf00
864.055518] RDX: 000000c92340b051 RSI: 000000c92340b051 RDI: ffff
864.058093] RBP: 0000000000000000 R08: 0000000000000002 R09: 00
864.060654] R10: 0000000000000000 R11: 0000000000000000 R12: 000
864.063183] R13: ffff8e8eeed2a580 R14: 0000000000000007 R15: ffffe4afcc079650
864.065729] FS: 00007f9a1ca91940 (0000) GS:ffff8e8f6b1c3000(0000) knIGS:0000000000000000
864.068312] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
864.070898] CR2: ffffe4afcc079650 CR3: 00000001136d8000 CR4: 0000000000350ef0
864.673523] Kernel panic - not syncing: Fatal exception in interrupt
864.076410] Kernel Offset: 0xc00000 from 0xffffffff81000000 (relocation range: 0xff
864.205401] --- [ end Kernel panic - not syncing: Fatal exception in interrupt ]---

This happens ever since 6.15-rc1, from time to time, I would get kernel panic when
reboot; it is only recently that I figured out a precedure reproducing
this with *high* probability:

1. create a cgroup.
2. perf_event_open(PERF_FLAG_FD_CLOEXEC|PERF_FLAG_PID_CGROUP) for each cpu with following attrs:
	attr.type = PERF_TYPE_SOFTWARE;
	attr.size = sizeof(attr);
	attr.config = PERF_COUNT_SW_CPU_CLOCK;
	attr.sample_freq = 9999;
	attr.freq = 1;
	attr.wakeup_events = 16;
	attr.sample_type = PERF_SAMPLE_CALLCHAIN;
	attr.sample_max_stack = 32;
	attr.exclude_callchain_user = 1;
3. close all perf_event_open after several minutes
4. reboot

And after an exhausting bisect on events/core.c, (I need 5 rounds to conclude a good bisect)
I think I reach the conclusion, with very high probability, that this is caused by

commit a3c3c66670cee11eb13aa43905904bf29cb92d32
Author: Yeoreum Yun <yeoreum.yun@arm.com>
Date:   Wed Mar 26 08:20:03 2025 +0000

    perf/core: Fix child_total_time_enabled accounting bug at task exit

Reverting this can fix it: I run the test 10 rounds, no kernel panic observed.

The changes made to __perf_remove_from_context by commit a3c3c6667("perf/core:
Fix child_total_time_enabled accounting bug at task exit") has wider effect
than the callchain mentioned in commit message, and I think an esay fix would
be just restricting the effect to that callchain only, and restore other changes back.

I have test the patch below several rounds, and so far so good, and I will have
more tests on it.

Signed-off-by: David Wang <00107082@163.com>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95e703891b24..95d15105e0e7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2482,12 +2482,15 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
-	perf_event_set_state(event, min(event->state, state));
+	if (flags & DETACH_EXIT)
+		perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
+	if (flags & DETACH_DEAD)
+		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
-- 
2.39.2




Thanks
David

