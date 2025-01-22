Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4C1DE4D5;
	Wed, 22 Jan 2025 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513141; cv=none; b=lty2fzsEL5GEm90jUynB4T+1XkhOZ5mkrTckH/gTSZxFDsnzpt0UetQ7+Q+hPyiyodmBwf32NDQ13fgdStSFvpAA81eT/YclS2H034es2dxM77XQpyHnSnZu9fMVnqH5XBMOnlJxpfK8U/HYq2DKuV/4rzr8PzZn0CtVdgHHZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513141; c=relaxed/simple;
	bh=IdqqeJrVDkIMyiK2xCT50O3cV1WwFa2oFCLdnnAcnr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9da9ehVTjUqDaePmi8PFV8OyO/9egtEb94uD6P3cXbLaQ9uNAyRYD2JliQ+g2980q2C+yjVSvcStlbmxmcrl91y20alj8xff2XaP8flzwsjrgNx8DbdrfmTxPSHjixiHkqQuOkaneBszOStYSqCSvxAV7FxGfLBslyACnIfjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJecxHLL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJecxHLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C05BC4CEE0;
	Wed, 22 Jan 2025 02:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513141;
	bh=IdqqeJrVDkIMyiK2xCT50O3cV1WwFa2oFCLdnnAcnr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJecxHLLqyCc442LgwaEF22hAJru4gqbgBVERPhwbk+1B3V62Rys6U0SwpPfEtKMg
	 cgmdh33OQZlp8i9M+ViIOHdcDKKTrLE+dkBXsruKoJfN0E2U4+zepTWdVKRLhloH76
	 QAeuuzTGG1WkUm2QIq5Dx2yaa+104IgdEAToiWAeVRFxBdlt2XMD0r4NUEmsdQD/3J
	 HtXCBGzqSMC+KoDfQKAjPnYQVtbjkTavOdsKrP0jWpKQFOmHHyRwrbUacjP2LcSBqE
	 VUoT5v20D2KBM76rWtxbd6WsKXl6Dip75EXZC3TdhAhCNsO0Wq6g2X+2BdSKgaz4Ny
	 8hYfgPvBWt5hg==
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
Subject: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding interface
Date: Tue, 21 Jan 2025 18:31:20 -0800
Message-ID: <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
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

Add an interface for scheduling task work to unwind the user space stack
before returning to user space.  This solves several problems for its
callers:

  - Ensure the unwind happens in task context even if the caller may be
    running in NMI or interrupt context.

  - Avoid duplicate unwinds, whether called multiple times by the same
    caller or by different callers.

  - Create a "context cookie" which allows trace post-processing to
    correlate kernel unwinds/traces with the user unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/entry-common.h          |   2 +
 include/linux/sched.h                 |   5 +
 include/linux/unwind_deferred.h       |  46 +++++++
 include/linux/unwind_deferred_types.h |  10 ++
 kernel/fork.c                         |   4 +
 kernel/unwind/Makefile                |   2 +-
 kernel/unwind/deferred.c              | 178 ++++++++++++++++++++++++++
 7 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 kernel/unwind/deferred.c

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fc61d0205c97..fb2b27154fee 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -12,6 +12,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
 #include <linux/kmsan.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/entry-common.h>
 
@@ -111,6 +112,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 
 	CT_WARN_ON(__ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
+	unwind_enter_from_user_mode();
 
 	instrumentation_begin();
 	kmsan_unpoison_entry_regs(regs);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 64934e0830af..042a95f4f6e6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -46,6 +46,7 @@
 #include <linux/rv.h>
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
+#include <linux/unwind_deferred_types.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1603,6 +1604,10 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_UNWIND_USER
+	struct unwind_task_info		unwind_info;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
new file mode 100644
index 000000000000..741f409f0d1f
--- /dev/null
+++ b/include/linux/unwind_deferred.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_DEFERRED_H
+#define _LINUX_UNWIND_USER_DEFERRED_H
+
+#include <linux/task_work.h>
+#include <linux/unwind_user.h>
+#include <linux/unwind_deferred_types.h>
+
+struct unwind_work;
+
+typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
+
+struct unwind_work {
+	struct callback_head		work;
+	unwind_callback_t		func;
+	int				pending;
+};
+
+#ifdef CONFIG_UNWIND_USER
+
+void unwind_task_init(struct task_struct *task);
+void unwind_task_free(struct task_struct *task);
+
+void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
+int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
+bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work);
+
+static __always_inline void unwind_enter_from_user_mode(void)
+{
+	current->unwind_info.cookie = 0;
+}
+
+#else /* !CONFIG_UNWIND_USER */
+
+static inline void unwind_task_init(struct task_struct *task) {}
+static inline void unwind_task_free(struct task_struct *task) {}
+
+static inline void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) {}
+static inline int unwind_deferred_request(struct task_struct *task, struct unwind_work *work, u64 *cookie) { return -ENOSYS; }
+static inline bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work) { return false; }
+
+static inline void unwind_enter_from_user_mode(void) {}
+
+#endif /* !CONFIG_UNWIND_USER */
+
+#endif /* _LINUX_UNWIND_USER_DEFERRED_H */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
new file mode 100644
index 000000000000..9749824aea09
--- /dev/null
+++ b/include/linux/unwind_deferred_types.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
+#define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
+
+struct unwind_task_info {
+	unsigned long		*entries;
+	u64			cookie;
+};
+
+#endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 88753f8bbdd3..c9a954af72a1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -106,6 +106,7 @@
 #include <linux/pidfs.h>
 #include <linux/tick.h>
 #include <linux/sframe.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -973,6 +974,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	unwind_task_free(tsk);
 	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
@@ -2370,6 +2372,8 @@ __latent_entropy struct task_struct *copy_process(
 	p->bpf_ctx = NULL;
 #endif
 
+	unwind_task_init(p);
+
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index f70380d7a6a6..146038165865 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1,2 +1,2 @@
- obj-$(CONFIG_UNWIND_USER)		+= user.o
+ obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
  obj-$(CONFIG_HAVE_UNWIND_USER_SFRAME)	+= sframe.o
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
new file mode 100644
index 000000000000..f0dbe4069247
--- /dev/null
+++ b/kernel/unwind/deferred.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Deferred user space unwinding
+*/
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/sframe.h>
+#include <linux/slab.h>
+#include <linux/task_work.h>
+#include <linux/mm.h>
+#include <linux/unwind_deferred.h>
+
+#define UNWIND_MAX_ENTRIES 512
+
+/* entry-from-user counter */
+static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
+
+/*
+ * The context cookie is a unique identifier which allows post-processing to
+ * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU
+ * id; the lower 48 bits are a per-CPU entry counter.
+ */
+static u64 ctx_to_cookie(u64 cpu, u64 ctx)
+{
+	BUILD_BUG_ON(NR_CPUS > 65535);
+	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);
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
+
+	cpu = raw_smp_processor_id();
+	ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
+	info->cookie = ctx_to_cookie(cpu, ctx_ctr);
+
+	return cookie;
+
+}
+
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	struct unwind_work *work = container_of(head, struct unwind_work, work);
+	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_stacktrace trace;
+	u64 cookie;
+
+	if (WARN_ON_ONCE(!work->pending))
+		return;
+
+	/*
+	 * From here on out, the callback must always be called, even if it's
+	 * just an empty trace.
+	 */
+
+	cookie = get_cookie(info);
+
+	/* Check for task exit path. */
+	if (!current->mm)
+		goto do_callback;
+
+	if (!info->entries) {
+		info->entries = kmalloc(UNWIND_MAX_ENTRIES * sizeof(long),
+					GFP_KERNEL);
+		if (!info->entries)
+			goto do_callback;
+	}
+
+	trace.entries = info->entries;
+	trace.nr = 0;
+	unwind_user(&trace, UNWIND_MAX_ENTRIES);
+
+do_callback:
+	work->func(work, &trace, cookie);
+	work->pending = 0;
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
+ * the same task entry context.  Each call will return the same cookie.  If the
+ * callback is already pending, an error will be returned along with the
+ * cookie.  If the callback is not pending because it has already been
+ * previously called for the same entry context, it will be called again with
+ * the same stack trace and cookie.
+ *
+ * Thus are three possible return scenarios:
+ *
+ *   * return != 0, *cookie == 0: the operation failed, no pending callback.
+ *
+ *   * return != 0, *cookie != 0: the callback is already pending. The cookie
+ *     can still be used to correlate with the pending callback.
+ *
+ *   * return == 0, *cookie != 0: the callback queued successfully.  The
+ *     callback is guaranteed to be called with the given cookie.
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
+	if (!current->mm || !user_mode(task_pt_regs(current)))
+		return -EINVAL;
+
+	guard(irqsave)();
+
+	*cookie = get_cookie(info);
+
+	/* callback already pending? */
+	if (work->pending)
+		return -EEXIST;
+
+	ret = task_work_add(current, &work->work, TWA_RESUME);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	work->pending = 1;
+
+	return 0;
+}
+
+bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work)
+{
+	bool ret;
+
+	ret = task_work_cancel(task, &work->work);
+	if (ret)
+		work->pending = 0;
+
+	return ret;
+}
+
+void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
+{
+	memset(work, 0, sizeof(*work));
+
+	init_task_work(&work->work, unwind_deferred_task_work);
+	work->func = func;
+}
+
+void unwind_task_init(struct task_struct *task)
+{
+	struct unwind_task_info *info = &task->unwind_info;
+
+	memset(info, 0, sizeof(*info));
+}
+
+void unwind_task_free(struct task_struct *task)
+{
+	struct unwind_task_info *info = &task->unwind_info;
+
+	kfree(info->entries);
+}
-- 
2.48.1

