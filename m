Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C314F9DB;
	Fri, 31 May 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144486; cv=none; b=WiswGNGJg8ChOgt+qAeZdVDEFH8ljlhlT7wE5LdfM4TyQeb2kusMyc9W+LFGcI8UQOeCZ5JHQxFPiOfk8v5XGOeryzeOMjThowIkXzfIgZEKuajdIXpLfbOgApg4LPA6NHK3wCeGDp9QNBSegd9AGxq610pCLr7zPwL8lph6Ic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144486; c=relaxed/simple;
	bh=eIVXzHRFToQAaXvDbgK2nzuzwdy+VosqLVYFeNHHK60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RuV2qzKZmPx5mAu/7Yk6sgi5vUjJCQiRCgnK1f79FTanwvbc4UOCJsSyYOftvElRVkp8IoPvSxsjcNU/PlHoh5L+XHNXmHBkEXUpWP2x7xpyaIdvuI2SqUaNaJ4mF1HgkXM4MylcbZ5+63vfLFPkWVpPauLfYmWWjQ3LRDGbfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VrGbH0bhjz1HCrM;
	Fri, 31 May 2024 16:32:59 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id D689514011F;
	Fri, 31 May 2024 16:34:40 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 May
 2024 16:34:40 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<dev.mbstr@gmail.com>, <samuel.holland@sifive.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] riscv: stacktrace: Add USER_STACKTRACE support
Date: Fri, 31 May 2024 08:32:57 +0000
Message-ID: <20240531083258.386709-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Currently, userstacktrace is unsupported for riscv. So use the
perf_callchain_user() code as blueprint to implement the
arch_stack_walk_user() which add userstacktrace support on riscv.
Meanwhile, we can use arch_stack_walk_user() to simplify the implementation
of perf_callchain_user().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/Kconfig                 |  1 +
 arch/riscv/kernel/perf_callchain.c | 46 ++----------------------------
 arch/riscv/kernel/stacktrace.c     | 43 ++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..4a7ba6a08dee 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -193,6 +193,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
+	select USER_STACKTRACE_SUPPORT
 	select ZONE_DMA32 if 64BIT
 
 config CLANG_SUPPORTS_DYNAMIC_FTRACE
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 3348a61de7d9..c7468af77c66 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -6,37 +6,9 @@
 
 #include <asm/stacktrace.h>
 
-/*
- * Get the return address for a single stackframe and return a pointer to the
- * next frame tail.
- */
-static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
-				    unsigned long fp, unsigned long reg_ra)
+static bool fill_callchain(void *entry, unsigned long pc)
 {
-	struct stackframe buftail;
-	unsigned long ra = 0;
-	unsigned long __user *user_frame_tail =
-		(unsigned long __user *)(fp - sizeof(struct stackframe));
-
-	/* Check accessibility of one struct frame_tail beyond */
-	if (!access_ok(user_frame_tail, sizeof(buftail)))
-		return 0;
-	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
-				      sizeof(buftail)))
-		return 0;
-
-	if (reg_ra != 0)
-		ra = reg_ra;
-	else
-		ra = buftail.ra;
-
-	fp = buftail.fp;
-	if (ra != 0)
-		perf_callchain_store(entry, ra);
-	else
-		return 0;
-
-	return fp;
+	return perf_callchain_store(entry, pc) == 0;
 }
 
 /*
@@ -56,19 +28,7 @@ static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
-	unsigned long fp = 0;
-
-	fp = regs->s0;
-	perf_callchain_store(entry, regs->epc);
-
-	fp = user_backtrace(entry, fp, regs->ra);
-	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
-		fp = user_backtrace(entry, fp, 0);
-}
-
-static bool fill_callchain(void *entry, unsigned long pc)
-{
-	return perf_callchain_store(entry, pc) == 0;
+	arch_stack_walk_user(fill_callchain, entry, regs);
 }
 
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 528ec7cc9a62..e0f556b680d8 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -161,3 +161,46 @@ noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie
 {
 	walk_stackframe(task, regs, consume_entry, cookie);
 }
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static unsigned long unwind_user_frame(stack_trace_consume_fn consume_entry,
+				       void *cookie, unsigned long fp,
+				       unsigned long reg_ra)
+{
+	struct stackframe buftail;
+	unsigned long ra = 0;
+	unsigned long __user *user_frame_tail =
+		(unsigned long __user *)(fp - sizeof(struct stackframe));
+
+	/* Check accessibility of one struct frame_tail beyond */
+	if (!access_ok(user_frame_tail, sizeof(buftail)))
+		return 0;
+	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
+				      sizeof(buftail)))
+		return 0;
+
+	ra = reg_ra ? : buftail.ra;
+
+	fp = buftail.fp;
+	if (!ra || (ra && !consume_entry(cookie, ra)))
+		return 0;
+
+	return fp;
+}
+
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
+{
+	unsigned long fp = 0;
+
+	fp = regs->s0;
+	if (!consume_entry(cookie, regs->epc))
+		return;
+
+	fp = unwind_user_frame(consume_entry, cookie, fp, regs->ra);
+	while (fp && !(fp & 0x3))
+		fp = unwind_user_frame(consume_entry, cookie, fp, 0);
+}
-- 
2.34.1

