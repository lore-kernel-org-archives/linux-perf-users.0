Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AD548F7;
	Mon, 29 Jul 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262104; cv=none; b=MqVQFxZqqedpvDwTvsd328S71gnjbWldVo4OKq35VqsCNMBtBZpve27vGonl9uLGhxGUKJJ6a1SCUVVMLDW7tJX4U+EHkjDMdK+Y2h+IKHP9+s3qmnVZvKTi2WLRUnbirKDHbmSzndkLmeIBwxAHeaBqH0hlXG35S5rvQOrYQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262104; c=relaxed/simple;
	bh=0GOu/YbkMnIvifKpKHaITdjDgfDP9/b3yuL++b1FOsE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hg03rARuYX46YIuoW+xdovl/r+bsVwDeUcyNHSNEO/5weMpRDQruUJZ4mS0w/Xef5TVvsFH99tdlbtmUJ984Yg+pK7E8KxGJM3PDKChMmH2EaoPIEA/37X/jglhQWdE70lZH0HWchuRwbs40nXnE+5YmZkyjm3eEgicc7OrH/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WXgDj1lzdzxVgs;
	Mon, 29 Jul 2024 22:08:05 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 613791402CA;
	Mon, 29 Jul 2024 22:08:14 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 22:08:13 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <kan.liang@linux.intel.com>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <ak@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH v2] perf/x86: Fix smp_processor_id()-in-preemptible warnings
Date: Tue, 30 Jul 2024 06:09:28 +0800
Message-ID: <20240729220928.325449-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)

The following bug was triggered on a system built with
CONFIG_DEBUG_PREEMPT=y:

 # echo p > /proc/sysrq-trigger

 BUG: using smp_processor_id() in preemptible [00000000] code: sh/117
 caller is perf_event_print_debug+0x1a/0x4c0
 CPU: 3 UID: 0 PID: 117 Comm: sh Not tainted 6.11.0-rc1 #109
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4f/0x60
  check_preemption_disabled+0xc8/0xd0
  perf_event_print_debug+0x1a/0x4c0
  __handle_sysrq+0x140/0x180
  write_sysrq_trigger+0x61/0x70
  proc_reg_write+0x4e/0x70
  vfs_write+0xd0/0x430
  ? handle_mm_fault+0xc8/0x240
  ksys_write+0x9c/0xd0
  do_syscall_64+0x96/0x190
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

This is because the commit d4b294bf84db ("perf/x86: Hybrid PMU support
for counters") took smp_processor_id() outside the irq critical section.
If a preemption occurs in perf_event_print_debug() and the task is
migrated to another cpu, we may get incorrect pmu debug information.
Move smp_processor_id() back inside the irq critical section to fix this
issue.

Fixes: d4b294bf84db ("perf/x86: Hybrid PMU support for counters")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
v2:
 - "cpu" and "idx" are defined together.
 - Use guard(irqsave)() instead of local_irq_save{restore}() to avoid
   forgetting to restore irq when returning early.
---
 arch/x86/events/core.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 12f2a0c14d33..2cadfdd8dd99 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1521,19 +1521,22 @@ void perf_event_print_debug(void)
 {
 	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
 	u64 pebs, debugctl;
-	int cpu = smp_processor_id();
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
-	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
-	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
-	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
-	unsigned long flags;
-	int idx;
+	int cpu, idx;
+	struct cpu_hw_events *cpuc;
+	unsigned long *cntr_mask, *fixed_cntr_mask;
+	struct event_constraint *pebs_constraints;
+
+	guard(irqsave)();
+
+	cpu = smp_processor_id();
+	cpuc = &per_cpu(cpu_hw_events, cpu);
+	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
+	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
+	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
 
 	if (!*(u64 *)cntr_mask)
 		return;
 
-	local_irq_save(flags);
-
 	if (x86_pmu.version >= 2) {
 		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
 		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
@@ -1577,7 +1580,6 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
 	}
-	local_irq_restore(flags);
 }
 
 void x86_pmu_stop(struct perf_event *event, int flags)
-- 
2.25.1

