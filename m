Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B951EE009;
	Mon, 28 Oct 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152101; cv=none; b=DDXnnwbneMCbhQ7HmYPY8cueuL3zyci7xf65ZLc28TU4BnZwv2swg0cItVJpygSQn0ktY/K5ZzW+fCjnOQJztE+Vd181Pn+tuatoTyDMPY3bj0uwoMhgWuWyvWa6aqFv6gXJsLYLRAd9ZsLS12MZclyShGoq+8DklszGUTOUPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152101; c=relaxed/simple;
	bh=jD51Fu0vOpWdomX4mvhQMZ5VqCrli3vqWQMm2r9eaGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/jULpdJXdJ0SjrvQBct/eMGr0In4b2ar+rjCokdmY69bP6XpB/yLvF+Dtvm/vdIPL/LuOpIzqifeMj0yM98x7RgFyNnKOqcFE5wIfcCKpERSyqSdF5x7YOUz976fVsdfnXpNGjIrhenefpwVeIeEItWHygua23Zgx1hx04oWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFxVy60C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFxVy60C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1918C4CEE7;
	Mon, 28 Oct 2024 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152100;
	bh=jD51Fu0vOpWdomX4mvhQMZ5VqCrli3vqWQMm2r9eaGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFxVy60CEcA/5zuwtfOIreofS/R0sLwen8cwAUMkVBPLlwJhrcip6tYMUKGGUV2f+
	 ZDzOQhQjMod7etQKBIkCm4pZ9wfCfe8rtdD8dyC8i2yeDtDMA36QOsEzhUbrSx9i2K
	 Y5mvUrvIkCtL0SXXA5E4uWvHSLMWwFU6uGkYMSc9d4Ta71Oa8kb9dinOEXlrp52gaS
	 UMIzyLCsMit4T2wg5VlYROQpvj99EtLmdxE8FoTtItDZa++8zVde6AP9fmLQiwOwGC
	 07XYy3D6u8wV+W2oLgNZqifNDMNDvVXgFOL+v5SuI5WEItRHsIsJCxhObf25oOmKKb
	 eelS1JX5HWj0Q==
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
Subject: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Date: Mon, 28 Oct 2024 14:47:38 -0700
Message-ID: <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
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

Add unwind_user_deferred() which allows callers to schedule task work to
unwind the user space stack before returning to user space.  This solves
several problems for its callers:

  - Ensure the unwind happens in task context even if the caller may
    running in interrupt context.

  - Only do the unwind once, even if called multiple times either by the
    same caller or multiple callers.

  - Create a "context context" cookie which allows trace post-processing
    to correlate kernel unwinds/traces with the user unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/entry-common.h |   3 +
 include/linux/sched.h        |   5 +
 include/linux/unwind_user.h  |  56 ++++++++++
 kernel/fork.c                |   4 +
 kernel/unwind/user.c         | 199 +++++++++++++++++++++++++++++++++++
 5 files changed, 267 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1e50cdb83ae5..efbe8f964f31 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -12,6 +12,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
 #include <linux/kmsan.h>
+#include <linux/unwind_user.h>
 
 #include <asm/entry-common.h>
 
@@ -111,6 +112,8 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	CT_WARN_ON(__ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
 
+	unwind_enter_from_user_mode();
+
 	instrumentation_begin();
 	kmsan_unpoison_entry_regs(regs);
 	trace_hardirqs_off_finish();
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5007a8e2d640..31b6f1d763ef 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -47,6 +47,7 @@
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
 #include <asm/kmap_size.h>
+#include <linux/unwind_user.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1592,6 +1593,10 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_UNWIND_USER
+	struct unwind_task_info		unwind_task_info;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index cde0fde4923e..98e236c843b1 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -3,6 +3,9 @@
 #define _LINUX_UNWIND_USER_H
 
 #include <linux/types.h>
+#include <linux/percpu-defs.h>
+
+#define UNWIND_MAX_CALLBACKS 4
 
 enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
@@ -30,6 +33,26 @@ struct unwind_user_state {
 	bool done;
 };
 
+struct unwind_task_info {
+	u64			ctx_cookie;
+	u32			pending_callbacks;
+	u64			last_cookies[UNWIND_MAX_CALLBACKS];
+	void			*privs[UNWIND_MAX_CALLBACKS];
+	unsigned long		*entries;
+	struct callback_head	work;
+};
+
+typedef void (*unwind_callback_t)(struct unwind_stacktrace *trace,
+				  u64 ctx_cookie, void *data);
+
+struct unwind_callback {
+	unwind_callback_t		func;
+	int				idx;
+};
+
+
+#ifdef CONFIG_UNWIND_USER
+
 /* Synchronous interfaces: */
 
 int unwind_user_start(struct unwind_user_state *state);
@@ -40,4 +63,37 @@ int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 #define for_each_user_frame(state) \
 	for (unwind_user_start((state)); !(state)->done; unwind_user_next((state)))
 
+
+/* Asynchronous interfaces: */
+
+void unwind_task_init(struct task_struct *task);
+void unwind_task_free(struct task_struct *task);
+
+int unwind_user_register(struct unwind_callback *callback, unwind_callback_t func);
+int unwind_user_unregister(struct unwind_callback *callback);
+
+int unwind_user_deferred(struct unwind_callback *callback, u64 *ctx_cookie, void *data);
+
+DECLARE_PER_CPU(u64, unwind_ctx_ctr);
+
+static __always_inline void unwind_enter_from_user_mode(void)
+{
+	__this_cpu_inc(unwind_ctx_ctr);
+}
+
+
+#else /* !CONFIG_UNWIND_USER */
+
+static inline void unwind_task_init(struct task_struct *task) {}
+static inline void unwind_task_free(struct task_struct *task) {}
+
+static inline int unwind_user_register(struct unwind_callback *callback, unwind_callback_t func) { return -ENOSYS; }
+static inline int unwind_user_unregister(struct unwind_callback *callback) { return -ENOSYS; }
+
+static inline int unwind_user_deferred(struct unwind_callback *callback, u64 *ctx_cookie, void *data) { return -ENOSYS; }
+
+static inline void unwind_enter_from_user_mode(void) {}
+
+#endif /* !CONFIG_UNWIND_USER */
+
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 60f14fbab956..d7580067853d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/unwind_user.h>
 #include <linux/sframe.h>
 
 #include <asm/pgalloc.h>
@@ -972,6 +973,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	unwind_task_free(tsk);
 	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
@@ -2348,6 +2350,8 @@ __latent_entropy struct task_struct *copy_process(
 	p->bpf_ctx = NULL;
 #endif
 
+	unwind_task_init(p);
+
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 8e47c80e3e54..ed7759c56551 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -10,6 +10,11 @@
 #include <linux/unwind_user.h>
 #include <linux/sframe.h>
 #include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/task_work.h>
+#include <linux/mm.h>
+
+#define UNWIND_MAX_ENTRIES 512
 
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
 #include <asm/unwind_user.h>
@@ -20,6 +25,12 @@ static struct unwind_user_frame fp_frame = {
 static struct unwind_user_frame fp_frame;
 #endif
 
+static struct unwind_callback *callbacks[UNWIND_MAX_CALLBACKS];
+static DECLARE_RWSEM(callbacks_rwsem);
+
+/* Counter for entries from user space */
+DEFINE_PER_CPU(u64, unwind_ctx_ctr);
+
 int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame _frame;
@@ -117,3 +128,191 @@ int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
 
 	return 0;
 }
+
+/*
+ * The "context cookie" is a unique identifier which allows post-processing to
+ * correlate kernel trace(s) with user unwinds.  It has the CPU id the highest
+ * 16 bits and a per-CPU entry counter in the lower 48 bits.
+ */
+static u64 ctx_to_cookie(u64 cpu, u64 ctx)
+{
+	BUILD_BUG_ON(NR_CPUS > 65535);
+	return (ctx & ((1UL << 48) - 1)) | cpu;
+}
+
+/*
+ * Schedule a user space unwind to be done in task work before exiting the
+ * kernel.
+ *
+ * The @callback must have previously been registered with
+ * unwind_user_register().
+ *
+ * The @cookie output is a unique identifer which will also be passed to the
+ * callback function.  It can be used to stitch kernel and user traces together
+ * in post-processing.
+ *
+ * If there are multiple calls to this function for a given @callback, the
+ * cookie will usually be the same and the callback will only be called once.
+ *
+ * The only exception is when the task has migrated to another CPU, *and* this
+ * is called while the task work is running (or has already run).  Then a new
+ * cookie will be generated and the callback will be called again for the new
+ * cookie.
+ */
+int unwind_user_deferred(struct unwind_callback *callback, u64 *ctx_cookie, void *data)
+{
+	struct unwind_task_info *info = &current->unwind_task_info;
+	u64 cookie = info->ctx_cookie;
+	int idx = callback->idx;
+
+	if (WARN_ON_ONCE(in_nmi()))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(!callback->func || idx < 0))
+		return -EINVAL;
+
+	if (!current->mm)
+		return -EINVAL;
+
+	guard(irqsave)();
+
+	if (cookie && (info->pending_callbacks & (1 << idx)))
+		goto done;
+
+	/*
+	 * If this is the first call from *any* caller since the most recent
+	 * entry from user space, initialize the task context cookie and
+	 * schedule the task work.
+	 */
+	if (!cookie) {
+		u64 ctx_ctr = __this_cpu_read(unwind_ctx_ctr);
+		u64 cpu = raw_smp_processor_id();
+
+		cookie = ctx_to_cookie(cpu, ctx_ctr);
+
+		/*
+		 * If called after task work has sent an unwind to the callback
+		 * function but before the exit to user space, skip it as the
+		 * previous call to the callback function should suffice.
+		 *
+		 * The only exception is if this task has migrated to another
+		 * CPU since the first call to unwind_user_deferred().  The
+		 * per-CPU context counter will have changed which will result
+		 * in a new cookie and another unwind (see comment above
+		 * function).
+		 */
+		if (cookie == info->last_cookies[idx])
+			goto done;
+
+		info->ctx_cookie = cookie;
+		task_work_add(current, &info->work, TWA_RESUME);
+	}
+
+	info->pending_callbacks |= (1 << idx);
+	info->privs[idx] = data;
+	info->last_cookies[idx] = cookie;
+
+done:
+	if (ctx_cookie)
+		*ctx_cookie = cookie;
+	return 0;
+}
+
+static void unwind_user_task_work(struct callback_head *head)
+{
+	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
+	struct task_struct *task = container_of(info, struct task_struct, unwind_task_info);
+	void *privs[UNWIND_MAX_CALLBACKS];
+	struct unwind_stacktrace trace;
+	unsigned long pending;
+	u64 cookie = 0;
+	int i;
+
+	BUILD_BUG_ON(UNWIND_MAX_CALLBACKS > 32);
+
+	if (WARN_ON_ONCE(task != current))
+		return;
+
+	if (WARN_ON_ONCE(!info->ctx_cookie || !info->pending_callbacks))
+		return;
+
+	scoped_guard(irqsave) {
+		pending = info->pending_callbacks;
+		cookie = info->ctx_cookie;
+
+		info->pending_callbacks = 0;
+		info->ctx_cookie = 0;
+		memcpy(privs, info->privs, sizeof(void *) * UNWIND_MAX_CALLBACKS);
+	}
+
+	if (!info->entries) {
+		info->entries = kmalloc(UNWIND_MAX_ENTRIES * sizeof(long),
+					GFP_KERNEL);
+		if (!info->entries)
+			return;
+	}
+
+	trace.entries = info->entries;
+	trace.nr = 0;
+	unwind_user(&trace, UNWIND_MAX_ENTRIES);
+
+	guard(rwsem_read)(&callbacks_rwsem);
+
+	for_each_set_bit(i, &pending, UNWIND_MAX_CALLBACKS) {
+		if (callbacks[i])
+			callbacks[i]->func(&trace, cookie, privs[i]);
+	}
+}
+
+int unwind_user_register(struct unwind_callback *callback, unwind_callback_t func)
+{
+	scoped_guard(rwsem_write, &callbacks_rwsem) {
+		for (int i = 0; i < UNWIND_MAX_CALLBACKS; i++) {
+			if (!callbacks[i]) {
+				callback->func = func;
+				callback->idx = i;
+				callbacks[i] = callback;
+				return 0;
+			}
+		}
+	}
+
+	callback->func = NULL;
+	callback->idx = -1;
+	return -ENOSPC;
+}
+
+int unwind_user_unregister(struct unwind_callback *callback)
+{
+	if (callback->idx < 0)
+		return -EINVAL;
+
+	scoped_guard(rwsem_write, &callbacks_rwsem)
+		callbacks[callback->idx] = NULL;
+
+	callback->func = NULL;
+	callback->idx = -1;
+
+	return 0;
+}
+
+void unwind_task_init(struct task_struct *task)
+{
+	struct unwind_task_info *info = &task->unwind_task_info;
+
+	info->entries		= NULL;
+	info->pending_callbacks	= 0;
+	info->ctx_cookie	= 0;
+
+	memset(info->last_cookies, 0, sizeof(u64) * UNWIND_MAX_CALLBACKS);
+	memset(info->privs,	   0, sizeof(u64) * UNWIND_MAX_CALLBACKS);
+
+	init_task_work(&info->work, unwind_user_task_work);
+}
+
+void unwind_task_free(struct task_struct *task)
+{
+	struct unwind_task_info *info = &task->unwind_task_info;
+
+	kfree(info->entries);
+}
-- 
2.47.0

