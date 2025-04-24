Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1928BA8D;
	Thu, 24 Apr 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511878; cv=none; b=bKDkNRNvm2fsf4iMrXGNrg+tKPApXOvBfqWfspZbm+JwqAt8s7yL9pxuomc/jzAJk/NISt+EUrtnS8NUe+vWUi2UGGhXmrj/eWaF5/JYovpPMaH+SgUtjI83SQxIC6OHsA7iuccN0X5gBZVyT0G8TNXd5MXV5HdvphHv2V4Vul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511878; c=relaxed/simple;
	bh=MEWmhckYlLGstocM9vrnNN4ILcWh4OlfSfCcgqaOxxE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gLq3JSZx03X5eE3Y/EmEhzRc2+VRyX83I78/kokbPPPfh/M0FyVQWNCwa/7090uegOcKkJJUonYi8idFFpwt1EXPv/0ggD/lR688PMGbKaYO4pdOuba/l/zxwakB+qvPj1/4JBs2WeLe0P0TbP+JKkPLe743R1qRfTl2ZYlEC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892A0C4AF1A;
	Thu, 24 Apr 2025 16:24:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7zPF-0000000Gybe-2GeK;
	Thu, 24 Apr 2025 12:26:33 -0400
Message-ID: <20250424162633.390748816@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 12:25:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
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
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>
Subject: [PATCH v5 13/17] perf: Support deferred user callchains
References: <20250424162529.686762589@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use the new unwind_deferred_trace() interface (if available) to defer
unwinds to task context.  This will allow the use of .sframe (when it
becomes available) and also prevents duplicate userspace unwinds.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                          |   3 +
 include/linux/perf_event.h            |  13 +-
 include/uapi/linux/perf_event.h       |  19 ++-
 kernel/bpf/stackmap.c                 |   4 +-
 kernel/events/callchain.c             |  11 +-
 kernel/events/core.c                  | 163 +++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |  19 ++-
 7 files changed, 224 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index dbb1cc89e040..681946b5f2c4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -446,6 +446,9 @@ config HAVE_UNWIND_USER_COMPAT_FP
 	bool
 	depends on HAVE_UNWIND_USER_FP
 
+config HAVE_PERF_CALLCHAIN_DEFERRED
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3cc0b0ea0afa..564594548d82 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -62,6 +62,7 @@ struct perf_guest_info_callbacks {
 #include <linux/security.h>
 #include <linux/static_call.h>
 #include <linux/lockdep.h>
+#include <linux/unwind_deferred.h>
 #include <asm/local.h>
 
 struct perf_callchain_entry {
@@ -830,6 +831,10 @@ struct perf_event {
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 
+	unsigned int			pending_unwind_callback;
+	struct callback_head		pending_unwind_work;
+	struct rcuwait			pending_unwind_wait;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
@@ -1652,12 +1657,18 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask, bool add_mark, bool defer_user);
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
index 5fc753c23734..65fe495c012e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -462,7 +462,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1228,6 +1229,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1258,6 +1274,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ec3a57a5fba1..339f7cbbcf36 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		max_depth = sysctl_perf_event_max_stack;
 
 	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+				   false, false, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+					   crosstask, false, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index bba7f8540ade..6645b2a76ba9 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -218,7 +218,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool crosstask, bool add_mark, bool defer_user)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -251,6 +251,15 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
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
index 40b98b05fb7c..69dd13c62b1d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5537,6 +5537,31 @@ static bool exclusive_event_installable(struct perf_event *event,
 	return true;
 }
 
+static void perf_pending_unwind_sync(struct perf_event *event)
+{
+	might_sleep();
+
+	if (!event->pending_unwind_callback)
+		return;
+
+	/*
+	 * If the task is queued to the current task's queue, we
+	 * obviously can't wait for it to complete. Simply cancel it.
+	 */
+	if (task_work_cancel(current, &event->pending_unwind_work)) {
+		event->pending_unwind_callback = 0;
+		local_dec(&event->ctx->nr_no_switch_fast);
+		return;
+	}
+
+	/*
+	 * All accesses related to the event are within the same RCU section in
+	 * perf_event_callchain_deferred(). The RCU grace period before the
+	 * event is freed will make sure all those accesses are complete by then.
+	 */
+	rcuwait_wait_event(&event->pending_unwind_wait, !event->pending_unwind_callback, TASK_UNINTERRUPTIBLE);
+}
+
 static void perf_free_addr_filters(struct perf_event *event);
 
 /* vs perf_event_alloc() error */
@@ -5604,6 +5629,7 @@ static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
+	perf_pending_unwind_sync(event);
 
 	unaccount_event(event);
 
@@ -7248,6 +7274,65 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
+
+struct perf_callchain_deferred_event {
+	struct perf_event_header	header;
+	u64				nr;
+	u64				ips[];
+};
+
+static void perf_event_callchain_deferred(struct callback_head *work)
+{
+	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
+	struct perf_callchain_deferred_event deferred_event;
+	u64 callchain_context = PERF_CONTEXT_USER;
+	struct unwind_stacktrace trace;
+	struct perf_output_handle handle;
+	struct perf_sample_data data;
+	u64 nr;
+
+	if (!event->pending_unwind_callback)
+		return;
+
+	if (unwind_deferred_trace(&trace) < 0)
+		goto out;
+
+	/*
+	 * All accesses to the event must belong to the same implicit RCU
+	 * read-side critical section as the ->pending_unwind_callback reset.
+	 * See comment in perf_pending_unwind_sync().
+	 */
+	guard(rcu)();
+
+	if (!current->mm)
+		goto out;
+
+	nr = trace.nr + 1 ; /* '+1' == callchain_context */
+
+	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
+	deferred_event.header.misc = PERF_RECORD_MISC_USER;
+	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
+
+	deferred_event.nr = nr;
+
+	perf_event_header__init_id(&deferred_event.header, &data, event);
+
+	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
+		goto out;
+
+	perf_output_put(&handle, deferred_event);
+	perf_output_put(&handle, callchain_context);
+	perf_output_copy(&handle, trace.entries, trace.nr * sizeof(u64));
+	perf_event__output_id_sample(event, &handle, &data);
+
+	perf_output_end(&handle);
+
+out:
+	event->pending_unwind_callback = 0;
+	local_dec(&event->ctx->nr_no_switch_fast);
+	rcuwait_wake_up(&event->pending_unwind_wait);
+}
+
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
@@ -8097,6 +8182,61 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
+/* Returns the same as deferred_request() below */
+static int deferred_request_nmi(struct perf_event *event)
+{
+	struct callback_head *work = &event->pending_unwind_work;
+	int ret;
+
+	if (event->pending_unwind_callback)
+		return 1;
+
+	ret = task_work_add(current, work, TWA_NMI_CURRENT);
+	if (ret)
+		return ret;
+
+	event->pending_unwind_callback = 1;
+	return 0;
+}
+
+/*
+ * Returns:
+*     > 0 : if already queued.
+ *      0 : if it performed the queuing
+ *    < 0 : if it did not get queued.
+ */
+static int deferred_request(struct perf_event *event)
+{
+	struct callback_head *work = &event->pending_unwind_work;
+	int pending;
+	int ret;
+
+	if (!current->mm || !user_mode(task_pt_regs(current)))
+		return -EINVAL;
+
+	if (in_nmi())
+		return deferred_request_nmi(event);
+
+	guard(irqsave)();
+
+        /* callback already pending? */
+        pending = READ_ONCE(event->pending_unwind_callback);
+        if (pending)
+                return 1;
+
+        /* Claim the work unless an NMI just now swooped in to do so. */
+        if (!try_cmpxchg(&event->pending_unwind_callback, &pending, 1))
+                return 1;
+
+        /* The work has been claimed, now schedule it. */
+        ret = task_work_add(current, work, TWA_RESUME);
+        if (WARN_ON_ONCE(ret)) {
+                WRITE_ONCE(event->pending_unwind_callback, 0);
+                return ret;
+        }
+	return 0;
+}
+
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -8106,12 +8246,27 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
+			  event->attr.defer_callchain;
 
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+	/* Disallow cross-task callchains. */
+	if (event->ctx->task && event->ctx->task != current)
+		return &__empty_callchain;
+
+	if (defer_user) {
+		int ret = deferred_request(event);
+		if (!ret)
+			local_inc(&event->ctx->nr_no_switch_fast);
+		else if (ret < 0)
+			defer_user = false;
+	}
+
+	callchain = get_perf_callchain(regs, kernel, user, max_stack,
+				       crosstask, true, defer_user);
+
 	return callchain ?: &__empty_callchain;
 }
 
@@ -12943,6 +13098,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		return ERR_PTR(err);
 
+	if (event->attr.defer_callchain)
+		init_task_work(&event->pending_unwind_work,
+			       perf_event_callchain_deferred);
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 5fc753c23734..65fe495c012e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -462,7 +462,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1228,6 +1229,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1258,6 +1274,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
-- 
2.47.2


