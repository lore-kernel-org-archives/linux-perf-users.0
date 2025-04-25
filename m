Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD325A34F;
	Fri, 25 Apr 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592975; cv=none; b=YIKF9TSFWktuh/YFlC02qpeErcHjBFujLxJ/3uq/+SCXQZt4PtCE7HitLWVKhUBHZ60r7oLAYQEKzj2SHBcJIb7TNgi+Rxb12yPeF1K7Rj6L48V1efxiYNdZQiL1Y2u+l/9mlsBqrEAKX/pP3CeDTtFbDV6/qzVfcMuaJrJ0pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592975; c=relaxed/simple;
	bh=qc703TKW10UUobUNB+GqNSMBLEqtyrL8oQuhFwLott0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GL7dMtfScBxtSiNH/WBrUPviO5mhCbmdEaZcbsthzKny1ByBE9J9oSEyVmS3/3uW6BSM3wFBkoq1QAS2S02o7Tn9x3a8glt64N3aRKDoVyEuPj2++PKxcOsjrq7aMlz21X33IA+EEtuckej0V8k4YIma+Zhrz3UjKg/5ckWmN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F416EC4AF0D;
	Fri, 25 Apr 2025 14:56:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u8KVI-0000000HSjL-48ZU;
	Fri, 25 Apr 2025 10:58:12 -0400
Message-ID: <20250425145812.835672647@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Apr 2025 10:54:29 -0400
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
Subject: [PATCH v6 07/18] unwind_user/deferred: Add unwind_deferred_trace()
References: <20250425145422.132820147@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a function that must be called inside a faultable context that will
retrieve a user space stack trace. The function unwind_deferred_trace()
can be called by a tracer when a task is about to enter user space, or has
just come back from user space and has interrupts enabled.

This code is based on work by Josh Poimboeuf's deferred unwinding code:

Link: https://lore.kernel.org/all/6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h                 |  5 +++
 include/linux/unwind_deferred.h       | 24 +++++++++++++
 include/linux/unwind_deferred_types.h |  9 +++++
 kernel/fork.c                         |  4 +++
 kernel/unwind/Makefile                |  2 +-
 kernel/unwind/deferred.c              | 49 +++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 kernel/unwind/deferred.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4ecc0c6b1cb0..a1e1c07cadfb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -47,6 +47,7 @@
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/unwind_deferred_types.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1646,6 +1647,10 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_UNWIND_USER
+	struct unwind_task_info		unwind_info;
+#endif
+
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
new file mode 100644
index 000000000000..5064ebe38c4f
--- /dev/null
+++ b/include/linux/unwind_deferred.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_DEFERRED_H
+#define _LINUX_UNWIND_USER_DEFERRED_H
+
+#include <linux/unwind_user.h>
+#include <linux/unwind_deferred_types.h>
+
+#ifdef CONFIG_UNWIND_USER
+
+void unwind_task_init(struct task_struct *task);
+void unwind_task_free(struct task_struct *task);
+
+int unwind_deferred_trace(struct unwind_stacktrace *trace);
+
+#else /* !CONFIG_UNWIND_USER */
+
+static inline void unwind_task_init(struct task_struct *task) {}
+static inline void unwind_task_free(struct task_struct *task) {}
+
+static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
+
+#endif /* !CONFIG_UNWIND_USER */
+
+#endif /* _LINUX_UNWIND_USER_DEFERRED_H */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
new file mode 100644
index 000000000000..aa32db574e43
--- /dev/null
+++ b/include/linux/unwind_deferred_types.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
+#define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
+
+struct unwind_task_info {
+	unsigned long		*entries;
+};
+
+#endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b..8c79c7c2c553 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -991,6 +992,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	unwind_task_free(tsk);
 	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
@@ -2395,6 +2397,8 @@ __latent_entropy struct task_struct *copy_process(
 	p->bpf_ctx = NULL;
 #endif
 
+	unwind_task_init(p);
+
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index 349ce3677526..6752ac96d7e2 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1 @@
- obj-$(CONFIG_UNWIND_USER) += user.o
+ obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
new file mode 100644
index 000000000000..6a4cec4877c5
--- /dev/null
+++ b/kernel/unwind/deferred.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Deferred user space unwinding
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/unwind_deferred.h>
+
+#define UNWIND_MAX_ENTRIES 512
+
+int unwind_deferred_trace(struct unwind_stacktrace *trace)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+
+	/* Should always be called from faultable context */
+	might_fault();
+
+	/* Check for task exit path. */
+	if (!current->mm)
+		return -EINVAL;
+
+       if (!info->entries) {
+               info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
+                                             GFP_KERNEL);
+               if (!info->entries)
+		       return -ENOMEM;
+       }
+
+	trace->nr = 0;
+	trace->entries = info->entries;
+	unwind_user(trace, UNWIND_MAX_ENTRIES);
+
+	return 0;
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
2.47.2


