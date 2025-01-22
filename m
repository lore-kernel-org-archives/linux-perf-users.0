Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD601F9ABC;
	Wed, 22 Jan 2025 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513149; cv=none; b=OrjwMebuzpjfCpF/wHSKF+xSZdF7OvBx71uthBcEgQ4/bAypwRGzVP8y1e8DGQ0jFi7+N9+0la1hOlQll2fDBLGuTGChWD2hPnwC0A2nKbA8arSwdh2X66dQSYcLMCWVQ3GZjmrEIubvlDDG+IL3NDVkD7vf1UUYb0mPnrPt3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513149; c=relaxed/simple;
	bh=XpQOuYi9nm9uhjXgWVCWnmhCnpsXTHRms5GB5/calVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGnUn1muuthG0b01NEJR2/Z5svzMTAZy1mt1YESTC1qZ8SNeKf8PaE5kF9ytHNENvIUUq0DjOND6kWhwAYEElWTZZ36CJyyDVdRhbAlEGbcI6T/twAjMfZ6Z4adQcRZeDqyQR29+wa80iK+0UQisF+jwaEXSZu3PaQ16AMlfScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNMFkKj8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNMFkKj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9226BC4CEE8;
	Wed, 22 Jan 2025 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513148;
	bh=XpQOuYi9nm9uhjXgWVCWnmhCnpsXTHRms5GB5/calVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNMFkKj8gsl5/5CzHyjloKCc0zP/QY3VoLBINjvFCQYJFYepcKlk0pojN8NvsbDGe
	 yQQF7Mp3WL8HbfL24pvlqq8eOb4uwECyRkEjx5/tLWqsiTjOw4r/u7v8G6ANzlfYJb
	 zuGbJcxp48uE8E3esi6H+iBUwmowzpUszPEMcYgLeMbQSGS3X2fJ0jQPMNFcmXvTZI
	 gYYBVYBZ7O2jKT5Sh3lapZMOJhzx7HpM9+4cpRadEOeOeOxgVzI9ha1C8tQgWlqDBS
	 lu67pLZSwqpjCcAcTqgENGY73Vz7ntqgyH83JQPS7LO8ATH5jVdxNCpxLVWnwqiV4S
	 l8jzaASp2qvKg==
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
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 35/39] perf: Support deferred user callchains
Date: Tue, 21 Jan 2025 18:31:27 -0800
Message-ID: <2e54e6f1c914b219b889fbb47bc33d4749c3ad87.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new unwind_deferred_request() interface (if available) to defer
unwinds to task context.  This allows the use of .sframe (if available)
and also prevents duplicate userspace unwinds.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                          |   3 +
 include/linux/perf_event.h            |  13 +++-
 include/uapi/linux/perf_event.h       |  19 ++++-
 kernel/bpf/stackmap.c                 |   6 +-
 kernel/events/callchain.c             |  11 ++-
 kernel/events/core.c                  | 103 +++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |  19 ++++-
 7 files changed, 166 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b3676605bab6..83ab94af46ca 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -472,6 +472,9 @@ config SFRAME_VALIDATION
 
 	  If unsure, say N.
 
+config HAVE_PERF_CALLCHAIN_DEFERRED
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1563dc2cd979..7fd54e4d2084 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -62,6 +62,7 @@ struct perf_guest_info_callbacks {
 #include <linux/security.h>
 #include <linux/static_call.h>
 #include <linux/lockdep.h>
+#include <linux/unwind_deferred.h>
 #include <asm/local.h>
 
 struct perf_callchain_entry {
@@ -833,6 +834,10 @@ struct perf_event {
 	unsigned int			pending_work;
 	struct rcuwait			pending_work_wait;
 
+	struct unwind_work		pending_unwind_work;
+	struct rcuwait			pending_unwind_wait;
+	unsigned int			pending_unwind_callback;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
@@ -1590,12 +1595,18 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
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
index 0524d541d4e3..16307be57de9 100644
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
@@ -1226,6 +1227,21 @@ enum perf_event_type {
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
 
@@ -1256,6 +1272,7 @@ enum perf_callchain_context {
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
index a886bb83f4d0..32603bbd797d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/unwind_deferred.h>
 
 #include "internal.h"
 
@@ -5312,11 +5313,37 @@ static void perf_pending_task_sync(struct perf_event *event)
 	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
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
+	if (unwind_deferred_cancel(current, &event->pending_unwind_work)) {
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
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
 	perf_pending_task_sync(event);
+	perf_pending_unwind_sync(event);
 
 	unaccount_event(event);
 
@@ -6933,6 +6960,61 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
+
+struct perf_callchain_deferred_event {
+	struct perf_event_header	header;
+	u64				nr;
+	u64				ips[];
+};
+
+static void perf_event_callchain_deferred(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie)
+{
+	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
+	struct perf_callchain_deferred_event deferred_event;
+	u64 callchain_context = PERF_CONTEXT_USER;
+	struct perf_output_handle handle;
+	struct perf_sample_data data;
+	u64 nr = trace->nr +1 ; /* +1 == callchain_context */
+
+	if (WARN_ON_ONCE(!event->pending_unwind_callback))
+		return;
+
+	/*
+	 * All accesses to the event must belong to the same implicit RCU
+	 * read-side critical section as the ->pending_unwind_callback reset.
+	 * See comment in perf_pending_unwind_sync().
+	 */
+	rcu_read_lock();
+
+	if (!current->mm)
+		goto out;
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
+	perf_output_copy(&handle, trace->entries, trace->nr * sizeof(u64));
+	perf_event__output_id_sample(event, &handle, &data);
+
+	perf_output_end(&handle);
+
+out:
+	event->pending_unwind_callback = 0;
+	local_dec(&event->ctx->nr_no_switch_fast);
+	rcuwait_wake_up(&event->pending_unwind_wait);
+
+	rcu_read_unlock();
+}
+
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
@@ -7795,6 +7877,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool user   = !event->attr.exclude_callchain_user && current->mm;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
+			  event->attr.defer_callchain;
 
 	if (!kernel && !user)
 		return &__empty_callchain;
@@ -7803,7 +7887,21 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (event->ctx->task && event->ctx->task != current)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
+	if (defer_user && !event->pending_unwind_callback) {
+		u64 cookie;
+
+		if (!unwind_deferred_request(&event->pending_unwind_work, &cookie)) {
+			event->pending_unwind_callback = 1;
+			local_inc(&event->ctx->nr_no_switch_fast);
+		}
+
+		if (!cookie)
+			defer_user = false;
+	}
+
+	callchain = get_perf_callchain(regs, kernel, user, max_stack, true,
+				       defer_user);
+
 	return callchain ?: &__empty_callchain;
 }
 
@@ -12225,6 +12323,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_task_work(&event->pending_task, perf_pending_task);
 	rcuwait_init(&event->pending_work_wait);
 
+	unwind_deferred_init(&event->pending_unwind_work, perf_event_callchain_deferred);
+	rcuwait_init(&event->pending_unwind_wait);
+
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0524d541d4e3..16307be57de9 100644
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
@@ -1226,6 +1227,21 @@ enum perf_event_type {
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
 
@@ -1256,6 +1272,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
-- 
2.48.1

