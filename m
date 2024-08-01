Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A019478;
	Thu,  1 Aug 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501195; cv=none; b=gFKpItVP69SVI31WYSF+r6XzY02fFejkVLFC/+NED1SeRwIgPGOh+7Ib0NCFDdkLlWjtrFXEZ9/Bzhc9FiTcwMU8w/XCDW14B3t+w7VmSmXFtKVZMAuS+RSq9hpeTQQUbZ22ebyTF7LUXbmFLng5JmUz+aXfJvp6oY1HS2pefW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501195; c=relaxed/simple;
	bh=lIpiNVrmuN4O95JtHnznPihjGVbvpzkeroPNt7BitXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mNS50Ab+w7IoEJ1cJitAT7xcXp9XPLODYnbtB4ft43RwZKphicLXc+/raC1pbNYJdGT3i4++mHeZVsg329LAY8xkR8yauo/2ESUCaRTv/Kr79QF5A6bQO3HLzTXpoPOtbJs/tg3AEa5C0p17xj6IYEihjDLlED6/XbYsux0Ckgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZMdc0lHYzncvB;
	Thu,  1 Aug 2024 16:32:04 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D101800A0;
	Thu,  1 Aug 2024 16:33:04 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 1 Aug
 2024 16:33:04 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
Subject: [PATCH] uprobes: Improve scalability by reducing the contention on siglock
Date: Thu, 1 Aug 2024 08:24:07 +0000
Message-ID: <20240801082407.1618451-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)

The profiling result of BPF selftest on ARM64 platform reveals the
significant contention on the current->sighand->siglock within the
handle_singlestep() is the scalability bottleneck. The reason is also
very straightforward that all producer threads of benchmark have to
contend the spinlock mentioned to resume the TIF_SIGPENDING bit in the
thread_info that might be removed in uprobe_deny_signal().

This patch introduces UTASK_SSTEP_DENY_SIGNAL to mark TIF_SIGPENDING is
suppress temporarily during the uprobe single-step. Upon uprobe single-step
is handled and UTASK_SSTEP_DENY_SIGNAL is confirmed, it could resume the
TIF_SIGPENDING directly without acquiring the siglock in most case, then
reducing contention and improving overall performance.

I've use the script developed by Andrii in [1] to run benchmark. The CPU
used was Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@2.4GHz running
upstream kernel v6.11-rc1 + my optimization [2] for get_xol_insn_slot().

before-opt
----------
uprobe-nop      ( 1 cpus):    0.907 ± 0.003M/s  (  0.907M/s/cpu)
uprobe-nop      ( 2 cpus):    1.676 ± 0.008M/s  (  0.838M/s/cpu)
uprobe-nop      ( 4 cpus):    3.210 ± 0.003M/s  (  0.802M/s/cpu)
uprobe-nop      ( 8 cpus):    4.457 ± 0.003M/s  (  0.557M/s/cpu)
uprobe-nop      (16 cpus):    3.724 ± 0.011M/s  (  0.233M/s/cpu)
uprobe-nop      (32 cpus):    2.761 ± 0.003M/s  (  0.086M/s/cpu)
uprobe-nop      (64 cpus):    1.293 ± 0.015M/s  (  0.020M/s/cpu)

uprobe-push     ( 1 cpus):    0.883 ± 0.001M/s  (  0.883M/s/cpu)
uprobe-push     ( 2 cpus):    1.642 ± 0.005M/s  (  0.821M/s/cpu)
uprobe-push     ( 4 cpus):    3.086 ± 0.002M/s  (  0.771M/s/cpu)
uprobe-push     ( 8 cpus):    3.390 ± 0.003M/s  (  0.424M/s/cpu)
uprobe-push     (16 cpus):    2.652 ± 0.005M/s  (  0.166M/s/cpu)
uprobe-push     (32 cpus):    2.713 ± 0.005M/s  (  0.085M/s/cpu)
uprobe-push     (64 cpus):    1.313 ± 0.009M/s  (  0.021M/s/cpu)

uprobe-ret      ( 1 cpus):    1.774 ± 0.000M/s  (  1.774M/s/cpu)
uprobe-ret      ( 2 cpus):    3.350 ± 0.001M/s  (  1.675M/s/cpu)
uprobe-ret      ( 4 cpus):    6.604 ± 0.000M/s  (  1.651M/s/cpu)
uprobe-ret      ( 8 cpus):    6.706 ± 0.005M/s  (  0.838M/s/cpu)
uprobe-ret      (16 cpus):    5.231 ± 0.001M/s  (  0.327M/s/cpu)
uprobe-ret      (32 cpus):    5.743 ± 0.003M/s  (  0.179M/s/cpu)
uprobe-ret      (64 cpus):    4.726 ± 0.016M/s  (  0.074M/s/cpu)

after-opt
---------
uprobe-nop      ( 1 cpus):    0.985 ± 0.002M/s  (  0.985M/s/cpu)
uprobe-nop      ( 2 cpus):    1.773 ± 0.005M/s  (  0.887M/s/cpu)
uprobe-nop      ( 4 cpus):    3.304 ± 0.001M/s  (  0.826M/s/cpu)
uprobe-nop      ( 8 cpus):    5.328 ± 0.002M/s  (  0.666M/s/cpu)
uprobe-nop      (16 cpus):    6.475 ± 0.002M/s  (  0.405M/s/cpu)
uprobe-nop      (32 cpus):    4.831 ± 0.082M/s  (  0.151M/s/cpu)
uprobe-nop      (64 cpus):    2.564 ± 0.053M/s  (  0.040M/s/cpu)

uprobe-push     ( 1 cpus):    0.964 ± 0.001M/s  (  0.964M/s/cpu)
uprobe-push     ( 2 cpus):    1.766 ± 0.002M/s  (  0.883M/s/cpu)
uprobe-push     ( 4 cpus):    3.290 ± 0.009M/s  (  0.823M/s/cpu)
uprobe-push     ( 8 cpus):    4.670 ± 0.002M/s  (  0.584M/s/cpu)
uprobe-push     (16 cpus):    5.197 ± 0.004M/s  (  0.325M/s/cpu)
uprobe-push     (32 cpus):    5.068 ± 0.161M/s  (  0.158M/s/cpu)
uprobe-push     (64 cpus):    2.605 ± 0.026M/s  (  0.041M/s/cpu)

uprobe-ret      ( 1 cpus):    1.833 ± 0.001M/s  (  1.833M/s/cpu)
uprobe-ret      ( 2 cpus):    3.384 ± 0.003M/s  (  1.692M/s/cpu)
uprobe-ret      ( 4 cpus):    6.677 ± 0.004M/s  (  1.669M/s/cpu)
uprobe-ret      ( 8 cpus):    6.854 ± 0.005M/s  (  0.857M/s/cpu)
uprobe-ret      (16 cpus):    6.508 ± 0.006M/s  (  0.407M/s/cpu)
uprobe-ret      (32 cpus):    5.793 ± 0.009M/s  (  0.181M/s/cpu)
uprobe-ret      (64 cpus):    4.743 ± 0.016M/s  (  0.074M/s/cpu)

Above benchmark results demonstrates a obivious improvement in the
scalability of trig-uprobe-nop and trig-uprobe-push, the peak throughput
of which are from 4.5M/s to 6.4M/s and 3.3M/s to 5.1M/s individually.

[1] https://lore.kernel.org/all/20240731214256.3588718-1-andrii@kernel.org
[2] https://lore.kernel.org/all/20240727094405.1362496-1-liaochang1@huawei.com

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b503fafb7fb3..50acbf96bccd 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -53,6 +53,7 @@ enum uprobe_task_state {
 	UTASK_SSTEP,
 	UTASK_SSTEP_ACK,
 	UTASK_SSTEP_TRAPPED,
+	UTASK_SSTEP_DENY_SIGNAL,
 };
 
 /*
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 76a51a1f51e2..4f9c10b3c7b9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1980,6 +1980,7 @@ bool uprobe_deny_signal(void)
 
 	if (task_sigpending(t)) {
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
+		utask->state = UTASK_SSTEP_DENY_SIGNAL;
 
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
 			utask->state = UTASK_SSTEP_TRAPPED;
@@ -2276,22 +2277,25 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	int err = 0;
 
 	uprobe = utask->active_uprobe;
-	if (utask->state == UTASK_SSTEP_ACK)
+	switch (utask->state) {
+	case UTASK_SSTEP_ACK:
 		err = arch_uprobe_post_xol(&uprobe->arch, regs);
-	else if (utask->state == UTASK_SSTEP_TRAPPED)
+		break;
+	case UTASK_SSTEP_TRAPPED:
 		arch_uprobe_abort_xol(&uprobe->arch, regs);
-	else
+		fallthrough;
+	case UTASK_SSTEP_DENY_SIGNAL:
+		set_tsk_thread_flag(current, TIF_SIGPENDING);
+		break;
+	default:
 		WARN_ON_ONCE(1);
+	}
 
 	put_uprobe(uprobe);
 	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(current);
 
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* see uprobe_deny_signal() */
-	spin_unlock_irq(&current->sighand->siglock);
-
 	if (unlikely(err)) {
 		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
 		force_sig(SIGILL);
-- 
2.34.1

