Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE9291169;
	Thu, 24 Apr 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522657; cv=none; b=tX7v0/fvyA5W52CuOv/idWqxsYKpsfZ1qix0BzTJQN1MsWcpVHx5Bvyww2kLLefonl+RBGI4QYXrnbpsF5p//SNG948g0ksqfwUtsyj0Subvxp/yyE5VaK+h3aLWNoq0mK4Hrr8/kPtmdCnlGV9qmCrQ2TLtDe113b8PAR+Rlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522657; c=relaxed/simple;
	bh=4H8Z9MeLJNwl9dY9CuXoH9JBExAzmjxaiL9XMCbuDd8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ikcrJGrASbn8YMaHtDkXSXKT5+ZpyOk26eTfXCRmfadlN5tL2jW+KC/cmUs7KaFxAZr3XTafU1FrGNVhHCPkqVpPUf8jLMKWbESHyZrSzghcc2v3zt6RdmMGVwDzcQ7B5LQDo1bovupYqPY9Honjuvlc+VFYFTwRkJEBOUCQLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB89C4CEEA;
	Thu, 24 Apr 2025 19:24:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u82D6-0000000H2Oh-2itF;
	Thu, 24 Apr 2025 15:26:12 -0400
Message-ID: <20250424192612.505622711@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 15:24:57 -0400
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
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 1/9] unwind_user/deferred: Add deferred unwinding interface
References: <20250424192456.851953422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add an interface for scheduling task work to unwind the user space stack
before returning to user space. This solves several problems for its
callers:

  - Ensure the unwind happens in task context even if the caller may be
    running in NMI or interrupt context.

  - Avoid duplicate unwinds, whether called multiple times by the same
    caller or by different callers.

  - Create a "context cookie" which allows trace post-processing to
    correlate kernel unwinds/traces with the user unwind.

A concept of a "cookie" is created to detect when the stacktrace is the
same. A cookie is generated the first time a user space stacktrace is
requested after the task enters the kernel. As the stacktrace is saved on
the task_struct while the task is in the kernel, if another request comes
in, if the cookie is still the same, it will use the saved stacktrace,
and not have to regenerate one.

The cookie is passed to the caller on request, and when the stacktrace is
generated upon returning to user space, it call the requester's callback
with the cookie as well as the stacktrace.

Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/all/6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org/

- Fixed comment where it said 12 bits but it should have been 16
 (Peter Zijlstra)

- Made the cookie LSB always set to 1 to make sure it never returns zero
 (Peter Zijlstra)

- Updated comment about unwind_ctx_ctr only being generated as needed.
  (Josh Poimboeuf)

 include/linux/entry-common.h          |   2 +-
 include/linux/unwind_deferred.h       |  22 +++-
 include/linux/unwind_deferred_types.h |   3 +
 kernel/unwind/deferred.c              | 163 +++++++++++++++++++++++++-
 4 files changed, 186 insertions(+), 4 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fb2b27154fee..725ec0e87cdd 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -112,7 +112,6 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 
 	CT_WARN_ON(__ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
-	unwind_enter_from_user_mode();
 
 	instrumentation_begin();
 	kmsan_unpoison_entry_regs(regs);
@@ -363,6 +362,7 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
+	unwind_exit_to_user_mode();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 54f1aa6caf29..d36784cae658 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -2,9 +2,19 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_H
 #define _LINUX_UNWIND_USER_DEFERRED_H
 
+#include <linux/task_work.h>
 #include <linux/unwind_user.h>
 #include <linux/unwind_deferred_types.h>
 
+struct unwind_work;
+
+typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
+
+struct unwind_work {
+	struct list_head		list;
+	unwind_callback_t		func;
+};
+
 #ifdef CONFIG_UNWIND_USER
 
 void unwind_task_init(struct task_struct *task);
@@ -12,9 +22,14 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_deferred_trace(struct unwind_stacktrace *trace);
 
-static __always_inline void unwind_enter_from_user_mode(void)
+int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
+int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
+void unwind_deferred_cancel(struct unwind_work *work);
+
+static __always_inline void unwind_exit_to_user_mode(void)
 {
 	current->unwind_info.cache.nr_entries = 0;
+	current->unwind_info.cookie = 0;
 }
 
 #else /* !CONFIG_UNWIND_USER */
@@ -23,8 +38,11 @@ static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
+static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
+static inline int unwind_deferred_request(struct unwind_work *work, u64 *cookie) { return -ENOSYS; }
+static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
-static inline void unwind_enter_from_user_mode(void) {}
+static inline void unwind_exit_to_user_mode(void) {}
 
 #endif /* !CONFIG_UNWIND_USER */
 
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index b3b7389ee6eb..33373c32c221 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -9,6 +9,9 @@ struct unwind_cache {
 
 struct unwind_task_info {
 	struct unwind_cache	cache;
+	u64			cookie;
+	struct callback_head	work;
+	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 99d4d9e049cd..dc438c5f6618 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -2,13 +2,72 @@
 /*
  * Deferred user space unwinding
  */
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_deferred.h>
+#include <linux/task_work.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/unwind_deferred.h>
+#include <linux/mm.h>
 
 #define UNWIND_MAX_ENTRIES 512
 
+/*
+ * This is a unique percpu identifier for a given task entry context.
+ * Conceptually, it's incremented every time the CPU enters the kernel from
+ * user space, so that each "entry context" on the CPU gets a unique ID.  In
+ * reality, as an optimization, it's only incremented on demand for the first
+ * deferred unwind request after a given entry-from-user.
+ *
+ * It's combined with the CPU id to make a systemwide-unique "context cookie".
+ */
+static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
+
+/* Guards adding to and reading the list of callbacks */
+static DEFINE_MUTEX(callback_mutex);
+static LIST_HEAD(callbacks);
+
+/*
+ * The context cookie is a unique identifier that is assigned to a user
+ * space stacktrace. As the user space stacktrace remains the same while
+ * the task is in the kernel, the cookie is an identifier for the stacktrace.
+ * Although it is possible for the stacktrace to get another cookie if another
+ * request is made after the cookie was cleared and before reentering user
+ * space.
+ *
+ * The high 16 bits are the CPU id; the lower 48 bits are a per-CPU entry
+ * counter shifted left by one and or'd with 1 (to prevent it from ever being
+ * zero).
+ */
+static u64 ctx_to_cookie(u64 cpu, u64 ctx)
+{
+	BUILD_BUG_ON(NR_CPUS > 65535);
+	return ((ctx << 1) & ((1UL << 48) - 1)) | (cpu << 48) | 1;
+}
+
+/*
+ * Read the task context cookie, first initializing it if this is the first
+ * call to get_cookie() since the most recent entry from user.
+ */
+static u64 get_cookie(struct unwind_task_info *info)
+{
+	u64 ctx_ctr;
+	u64 cookie;
+	u64 cpu;
+
+	guard(irqsave)();
+
+	cookie = info->cookie;
+	if (cookie)
+		return cookie;
+
+	cpu = raw_smp_processor_id();
+	ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
+	info->cookie = ctx_to_cookie(cpu, ctx_ctr);
+
+	return info->cookie;
+}
+
 int unwind_deferred_trace(struct unwind_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -47,11 +106,112 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	return 0;
 }
 
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
+	struct unwind_stacktrace trace;
+	struct unwind_work *work;
+	u64 cookie;
+
+	if (WARN_ON_ONCE(!info->pending))
+		return;
+
+	/* Allow work to come in again */
+	WRITE_ONCE(info->pending, 0);
+
+	/*
+	 * From here on out, the callback must always be called, even if it's
+	 * just an empty trace.
+	 */
+	trace.nr = 0;
+	trace.entries = NULL;
+
+	unwind_deferred_trace(&trace);
+
+	cookie = get_cookie(info);
+
+	guard(mutex)(&callback_mutex);
+	list_for_each_entry(work, &callbacks, list) {
+		work->func(work, &trace, cookie);
+	}
+	barrier();
+	/* If another task work is pending, reuse the cookie and stack trace */
+	if (!READ_ONCE(info->pending))
+		WRITE_ONCE(info->cookie, 0);
+}
+
+/*
+ * Schedule a user space unwind to be done in task work before exiting the
+ * kernel.
+ *
+ * The returned cookie output is a unique identifer for the current task entry
+ * context.  Its value will also be passed to the callback function.  It can be
+ * used to stitch kernel and user stack traces together in post-processing.
+ *
+ * It's valid to call this function multiple times for the same @work within
+ * the same task entry context.  Each call will return the same cookie.
+ * If the callback is not pending because it has already been previously called
+ * for the same entry context, it will be called again with the same stack trace
+ * and cookie.
+ *
+ * Returns 0 if the callback will be called on task to user space
+ *   Negative if there's an error.
+ */
+int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+	int ret;
+
+	*cookie = 0;
+
+	if (WARN_ON_ONCE(in_nmi()))
+		return -EINVAL;
+
+	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
+		return -EINVAL;
+
+	guard(irqsave)();
+
+	*cookie = get_cookie(info);
+
+	/* callback already pending? */
+	if (info->pending)
+		return 0;
+
+	/* The work has been claimed, now schedule it. */
+	ret = task_work_add(current, &info->work, TWA_RESUME);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	info->pending = 1;
+	return 0;
+}
+
+void unwind_deferred_cancel(struct unwind_work *work)
+{
+	if (!work)
+		return;
+
+	guard(mutex)(&callback_mutex);
+	list_del(&work->list);
+}
+
+int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
+{
+	memset(work, 0, sizeof(*work));
+
+	guard(mutex)(&callback_mutex);
+	list_add(&work->list, &callbacks);
+	work->func = func;
+	return 0;
+}
+
 void unwind_task_init(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
 	memset(info, 0, sizeof(*info));
+	init_task_work(&info->work, unwind_deferred_task_work);
 }
 
 void unwind_task_free(struct task_struct *task)
@@ -59,4 +219,5 @@ void unwind_task_free(struct task_struct *task)
 	struct unwind_task_info *info = &task->unwind_info;
 
 	kfree(info->cache.entries);
+	task_work_cancel(task, &info->work);
 }
-- 
2.47.2


