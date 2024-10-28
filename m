Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED620604B;
	Mon, 28 Oct 2024 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152125; cv=none; b=dvbbmK8vOz/DqBFn9zncZU92htXHPWKeVr9tTXiB8TtqOUmmvNliXhJ0IUIYxP0pRKesR2qJcj+AEtivqHi7hDxbPaHeH66GkzOhN2IdyC2lPMAJtLEJ8FMmKNQXYdc9GKkdnba7VmZK/sTAZ64Pokkr+qEwSBe8VrCUhGq/v1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152125; c=relaxed/simple;
	bh=BicEo2O0Udl64XLuU3OuWtNR3+Ob8ZlZ0QEDE8lLAZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkYS0sh+dFH+sZE3cnhYPWAjkw6NSUZz9pwpM02mFK2iCHfH6J4tMYWIQh9qe0SuGNse6XdI0HWd8q1Q4ee50zOOcIlS7L4zDP//6ej5xwpyM/cJsPwsnqr+DlKUlS+dxY7rR6g3xIvoLgtBQLJcjL7Rfq3nIna/mNRYdyIIc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmXf8jz9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmXf8jz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF38AC4CECD;
	Mon, 28 Oct 2024 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152125;
	bh=BicEo2O0Udl64XLuU3OuWtNR3+Ob8ZlZ0QEDE8lLAZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmXf8jz9idLbzNCVQSyprk7ktAQd3vVc6Cf4N2twS+zMV6kF8J3V+dqrqnNbuL/Vi
	 gE1SJ65/PyiyO4cvJ7TUxe482rLQLA2ZDXhzIry1X2abAHp55mYDvLdnEIV9PN1Y/f
	 uD1neLw7St4HXt5CUwJzBi0alOFO13ujgy0DpPlzxxdYL3qW8IbRpihJNjRpxYyUI+
	 pWsB6GGHrN0mDPd0rAotoXlRpdLk1tXcGBei9cYoqajS5sbVSDboT6Xj+sGfg5lr9c
	 e8I939IeYTcCrKiL2na8+tNp8mqLJhYFgyI0fTgdvhWbF/IAn3BCCUCg9MJLj7nHQe
	 WsxiwhlQhGSKw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 15/19] perf: Add deferred user callchains
Date: Mon, 28 Oct 2024 14:48:02 -0700
Message-ID: <1ce857387c781afa66efaa61eb88ff596b352500.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20241028214802.cvv5IW-Ty7flsvaHpls0an4IzN7UbgW2vJxpPhOanH8@z>

Instead of attempting to unwind user space from the NMI handler, defer
it to run in task context by sending a self-IPI and then scheduling the
unwind to run in the IRQ's exit task work before returning to user space.

This allows the user stack page to be paged in if needed, avoids
duplicate unwinds for kernel-bound workloads, and prepares for SFrame
unwinding (so .sframe sections can be paged in on demand).

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                          |  3 ++
 include/linux/perf_event.h            | 10 ++++-
 include/uapi/linux/perf_event.h       | 22 +++++++++-
 kernel/bpf/stackmap.c                 |  6 +--
 kernel/events/callchain.c             | 11 ++++-
 kernel/events/core.c                  | 63 ++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h | 22 +++++++++-
 7 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e769c39dd221..33449485eafd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -446,6 +446,9 @@ config HAVE_UNWIND_USER_SFRAME
 	bool
 	select UNWIND_USER
 
+config HAVE_PERF_CALLCHAIN_DEFERRED
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 788f6971d32d..2193b3d16820 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -808,9 +808,11 @@ struct perf_event {
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
 	struct irq_work			pending_disable_irq;
+	struct irq_work			pending_unwind_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 	struct rcuwait			pending_work_wait;
+	unsigned int			pending_unwind;
 
 	atomic_t			event_limit;
 
@@ -1569,12 +1571,18 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool add_mark);
+		   u32 max_stack, bool add_mark, bool defer_user);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
 extern void put_callchain_entry(int rctx);
 
+#ifdef CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED
+extern void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+#else
+static inline void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs) {}
+#endif
+
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4842c36fdf80..6d0524b7d082 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -460,7 +460,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1217,6 +1218,24 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * TODO: do PERF_SAMPLE_{REGS,STACK}_USER also need deferral?
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				ctx_cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1247,6 +1266,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ee9701337912..f073ebaf9c30 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,8 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth, false);
-
+	trace = get_perf_callchain(regs, kernel, user, max_depth, false, false);
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
@@ -448,7 +447,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, kernel, user, max_depth,false);
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   false, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 2278402b7ac9..eeb15ba0137f 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool add_mark)
+		   u32 max_stack, bool add_mark, bool defer_user)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -246,6 +246,15 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 			regs = task_pt_regs(current);
 		}
 
+		if (defer_user) {
+			/*
+			 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
+			 * which can be stitched to this one.
+			 */
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
+			goto exit_put;
+		}
+
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ebf143aa427b..bf97b2fa8a9c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,11 +55,14 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/unwind_user.h>
 
 #include "internal.h"
 
 #include <asm/irq_regs.h>
 
+static struct unwind_callback perf_unwind_callback_cb;
+
 typedef int (*remote_function_f)(void *);
 
 struct remote_function_call {
@@ -6955,6 +6958,53 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
+static void perf_pending_unwind_irq(struct irq_work *entry)
+{
+	struct perf_event *event = container_of(entry, struct perf_event, pending_unwind_irq);
+
+	if (event->pending_unwind) {
+		unwind_user_deferred(&perf_unwind_callback_cb, NULL, event);
+		event->pending_unwind = 0;
+	}
+}
+
+struct perf_callchain_deferred_event {
+	struct perf_event_header	header;
+	u64				ctx_cookie;
+	u64				nr;
+	u64				ips[];
+};
+
+static void perf_event_callchain_deferred(struct unwind_stacktrace *trace,
+					  u64 ctx_cookie, void *_data)
+{
+	struct perf_callchain_deferred_event deferred_event;
+	u64 callchain_context = PERF_CONTEXT_USER;
+	struct perf_output_handle handle;
+	struct perf_event *event = _data;
+	struct perf_sample_data data;
+	u64 nr = trace->nr + 1 /* callchain_context */;
+
+	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
+	deferred_event.header.misc = PERF_RECORD_MISC_USER;
+	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
+
+	deferred_event.ctx_cookie = ctx_cookie;
+	deferred_event.nr = nr;
+
+	perf_event_header__init_id(&deferred_event.header, &data, event);
+
+	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
+		return;
+
+	perf_output_put(&handle, deferred_event);
+	perf_output_put(&handle, callchain_context);
+	perf_output_copy(&handle, trace->entries, trace->nr * sizeof(u64));
+	perf_event__output_id_sample(event, &handle, &data);
+
+	perf_output_end(&handle);
+}
+
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
@@ -7794,6 +7844,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool user   = !event->attr.exclude_callchain_user;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) &&
+			  event->attr.defer_callchain;
 
 	if (!kernel && !user)
 		return &__empty_callchain;
@@ -7802,7 +7854,14 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (event->ctx->task && event->ctx->task != current)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
+	callchain = get_perf_callchain(regs, kernel, user, max_stack, true,
+				       defer_user);
+
+	if (user && defer_user && !event->pending_unwind) {
+		event->pending_unwind = 1;
+		irq_work_queue(&event->pending_unwind_irq);
+	}
+
 	return callchain ?: &__empty_callchain;
 }
 
@@ -12171,6 +12230,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
+	event->pending_unwind_irq = IRQ_WORK_INIT_HARD(perf_pending_unwind_irq);
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
 	rcuwait_init(&event->pending_work_wait);
@@ -14093,6 +14153,7 @@ void __init perf_event_init(void)
 	perf_tp_register();
 	perf_event_init_cpu(smp_processor_id());
 	register_reboot_notifier(&perf_reboot_notifier);
+	unwind_user_register(&perf_unwind_callback_cb, perf_event_callchain_deferred);
 
 	ret = init_hw_breakpoint();
 	WARN(ret, "hw_breakpoint initialization failed with: %d", ret);
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4842c36fdf80..6d0524b7d082 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -460,7 +460,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1217,6 +1218,24 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * TODO: do PERF_SAMPLE_{REGS,STACK}_USER also need deferral?
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				ctx_cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1247,6 +1266,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
-- 
2.47.0

