Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A11773D;
	Tue, 30 Jul 2024 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305394; cv=none; b=PLW5EP01mAwC9cdZSOutY+NBDEO37a2+wdNxnPMnXqI4VuEVBN6ei9MGjvt6V2K9m0bdrBfUo8ridUU5iuKIZ2pJLRWVp18mhN6pYAyJbmL612X3D9HR5vz9lfOFbMYjHWiZzlb/XIIjnD5vU59kdRoa9uwfvOdqwfthg0uA4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305394; c=relaxed/simple;
	bh=M1AzgA+O8CKFtzCP2VkdIQ3xs3VxBhk5kXKmJJNDWyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZRpmQWDP7u5M3+OtMxP5w4BM5x3QoIho0+0P2Ofwi44ospw+f8CAgd/aYoLZn19NOflQUzFB5Ai2kW1Npv1eCNeo096YV33D11nSl0nv4OjcJsWfby4F38EFFB2oAV1MTczSkq3y0btzR844BBUfMEnRcQTqwPFumv4h0J2wPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WXz8F3dxkz28fvb;
	Tue, 30 Jul 2024 10:05:17 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 82149180043;
	Tue, 30 Jul 2024 10:09:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 10:09:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<will@kernel.org>, <arnd@arndb.de>, <afd@ti.com>,
	<rmk+kernel@armlinux.org.uk>, <linus.walleij@linaro.org>,
	<akpm@linux-foundation.org>, <masahiroy@kernel.org>,
	<eric.devolder@oracle.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] ARM: stacktrace: Add USER_STACKTRACE support
Date: Tue, 30 Jul 2024 10:15:32 +0800
Message-ID: <20240730021532.1752582-1-ruanjinjie@huawei.com>
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
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently, userstacktrace is unsupported for ARM. So use the
perf_callchain_user() code as blueprint to implement the
arch_stack_walk_user() which add userstacktrace support on ARM.
Meanwhile, we can use arch_stack_walk_user() to simplify the implementation
of perf_callchain_user().

A ftrace test case is shown as below:
	# cd /sys/kernel/debug/tracing
	# echo 1 > options/userstacktrace
	# echo 1 > options/sym-userobj
	# echo 1 > events/sched/sched_process_fork/enable
	# cat trace

	......
	              sh-100     [000] .....    51.779261: sched_process_fork: comm=sh pid=100 child_comm=sh child_pid=108
	              sh-100     [000] .....    51.779285: <user stack trace>
	 => /lib/libc.so.6[+0xb3c8c]
	 => /bin/busybox[+0xffb901f1]

Also a simple perf test is ok as below:
	# perf record -e cpu-clock --call-graph fp top
	# perf report --call-graph

	.....
	  [[31m  65.00%[[m     0.00%  top      [kernel.kallsyms]  [k] __ret_fast_syscall

	            |
	            ---__ret_fast_syscall
	               |
	               |--[[31m30.00%[[m--__se_sys_getdents64
	               |          iterate_dir
	               |          |
	               |          |--[[31m25.00%[[m--proc_pid_readdir

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Update the wrong patch title.
- Take off the merged bugfix patch.
- Remove the Tested-by.
---
 arch/arm/Kconfig                 |  1 +
 arch/arm/kernel/perf_callchain.c | 70 +++-----------------------------
 arch/arm/kernel/stacktrace.c     | 65 +++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 64 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54b2bb817a7f..eb9a587935ef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -152,6 +152,7 @@ config ARM
 	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	select USE_OF if !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
+	select USER_STACKTRACE_SUPPORT
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 1d230ac9d0eb..cdb7aa31c6ec 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -12,70 +12,6 @@
 
 #include <asm/stacktrace.h>
 
-/*
- * The registers we're interested in are at the end of the variable
- * length saved register structure. The fp points at the end of this
- * structure so the address of this struct is:
- * (struct frame_tail *)(xxx->fp)-1
- *
- * This code has been adapted from the ARM OProfile support.
- */
-struct frame_tail {
-	struct frame_tail __user *fp;
-	unsigned long sp;
-	unsigned long lr;
-} __attribute__((packed));
-
-/*
- * Get the return address for a single stackframe and return a pointer to the
- * next frame tail.
- */
-static struct frame_tail __user *
-user_backtrace(struct frame_tail __user *tail,
-	       struct perf_callchain_entry_ctx *entry)
-{
-	struct frame_tail buftail;
-	unsigned long err;
-
-	if (!access_ok(tail, sizeof(buftail)))
-		return NULL;
-
-	pagefault_disable();
-	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
-	pagefault_enable();
-
-	if (err)
-		return NULL;
-
-	perf_callchain_store(entry, buftail.lr);
-
-	/*
-	 * Frame pointers should strictly progress back up the stack
-	 * (towards higher addresses).
-	 */
-	if (tail + 1 >= buftail.fp)
-		return NULL;
-
-	return buftail.fp - 1;
-}
-
-void
-perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
-{
-	struct frame_tail __user *tail;
-
-	perf_callchain_store(entry, regs->ARM_pc);
-
-	if (!current->mm)
-		return;
-
-	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
-
-	while ((entry->nr < entry->max_stack) &&
-	       tail && !((unsigned long)tail & 0x3))
-		tail = user_backtrace(tail, entry);
-}
-
 /*
  * Gets called by walk_stackframe() for every stackframe. This will be called
  * whist unwinding the stackframe and is like a subroutine return so we use
@@ -88,6 +24,12 @@ callchain_trace(void *data, unsigned long pc)
 	return perf_callchain_store(entry, pc) == 0;
 }
 
+void
+perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+{
+	arch_stack_walk_user(callchain_trace, entry, regs);
+}
+
 void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 620aa82e3bdd..b744792755b5 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -194,4 +194,69 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 
 	walk_stackframe(&frame, consume_entry, cookie);
 }
+
+/*
+ * The registers we're interested in are at the end of the variable
+ * length saved register structure. The fp points at the end of this
+ * structure so the address of this struct is:
+ * (struct frame_tail *)(xxx->fp)-1
+ *
+ * This code has been adapted from the ARM OProfile support.
+ */
+struct frame_tail {
+	struct frame_tail __user *fp;
+	unsigned long sp;
+	unsigned long lr;
+} __packed;
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static struct frame_tail __user *
+unwind_user_frame(struct frame_tail __user *tail, void *cookie,
+		  stack_trace_consume_fn consume_entry)
+{
+	struct frame_tail buftail;
+	unsigned long err;
+
+	if (!access_ok(tail, sizeof(buftail)))
+		return NULL;
+
+	pagefault_disable();
+	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
+	pagefault_enable();
+
+	if (err)
+		return NULL;
+
+	if (!consume_entry(cookie, buftail.lr))
+		return NULL;
+
+	/*
+	 * Frame pointers should strictly progress back up the stack
+	 * (towards higher addresses).
+	 */
+	if (tail + 1 >= buftail.fp)
+		return NULL;
+
+	return buftail.fp - 1;
+}
+
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
+{
+	struct frame_tail __user *tail;
+
+	if (!consume_entry(cookie, regs->ARM_pc))
+		return;
+
+	if (!current->mm)
+		return;
+
+	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
+
+	while (tail && !((unsigned long)tail & 0x3))
+		tail = unwind_user_frame(tail, cookie, consume_entry);
+}
 #endif
-- 
2.34.1

