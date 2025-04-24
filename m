Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD0289369;
	Thu, 24 Apr 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511877; cv=none; b=uikAXD9TJYyvU6yz/05o6uqtnVMgm4sCgTpk7YvVGlbeLypnNvNPhf7KyNa72ODFSJuEFQBKtED/0SjTyl0iyMuFp2QiJw6t/rrDde/uh0AqBcsuhRlIjpabetag7HO2k37Rp3VKgzCLFVQglNupBk1N0CIBI+qrya+bu5TD8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511877; c=relaxed/simple;
	bh=tNH2uR6qN8/NVJJ1/7JEq4VAEja1tKtQWU+m53I8ULk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GKIZYDmMEXp4lf9HCsn6Y4LvNW/dwJOg0Rs29hK97EEmA28nvMHDJNxuHPGuFLPiy+9OiDuk6QL1pnvGGnZa6lSWYZBe7AXZ7dYrdBfeQEE1mNREVoQVMlQCh/d7pju+wfVZHh2/n3s1Nv3JfrxQmHgTUf3BadU/0RMi7PY2lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A563BC4CEE8;
	Thu, 24 Apr 2025 16:24:36 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7zPE-0000000GyZ9-2rK0;
	Thu, 24 Apr 2025 12:26:32 -0400
Message-ID: <20250424162632.532889212@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 12:25:37 -0400
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
Subject: [PATCH v5 08/17] unwind_user/deferred: Add unwind cache
References: <20250424162529.686762589@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Cache the results of the unwind to ensure the unwind is only performed
once, even when called by multiple tracers.

The cache nr_entries gets cleared every time the task enters the kernel.
When a stacktrace is requested, nr_entries gets set to the number of
entries in the stacktrace. If another stacktrace is requested, if
nr_entries is not zero, then it contains the same stacktrace that would be
retrieved so it is not processed again and the entries is given to the
caller.

Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/all/51855c0902486060cd6e1ccc6b22fd092a2e676d.1737511963.git.jpoimboe@kernel.org/

- Instead of using a cookie to determine if the cached stacktrace is the
  same, use nr_entries. By clearing it every time the task enters the
  kernel, if it's not zero, then that means the stacktrace is still in the
  cache. (Peter Zijlstra)

 include/linux/entry-common.h          |  2 ++
 include/linux/unwind_deferred.h       |  7 +++++++
 include/linux/unwind_deferred_types.h |  7 ++++++-
 kernel/unwind/deferred.c              | 27 ++++++++++++++++++++-------
 4 files changed, 35 insertions(+), 8 deletions(-)

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
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 5064ebe38c4f..54f1aa6caf29 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -12,6 +12,11 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_deferred_trace(struct unwind_stacktrace *trace);
 
+static __always_inline void unwind_enter_from_user_mode(void)
+{
+	current->unwind_info.cache.nr_entries = 0;
+}
+
 #else /* !CONFIG_UNWIND_USER */
 
 static inline void unwind_task_init(struct task_struct *task) {}
@@ -19,6 +24,8 @@ static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
 
+static inline void unwind_enter_from_user_mode(void) {}
+
 #endif /* !CONFIG_UNWIND_USER */
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_H */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index aa32db574e43..b3b7389ee6eb 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,8 +2,13 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
-struct unwind_task_info {
+struct unwind_cache {
 	unsigned long		*entries;
+	unsigned int		nr_entries;
+};
+
+struct unwind_task_info {
+	struct unwind_cache	cache;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 6a4cec4877c5..99d4d9e049cd 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,6 +12,7 @@
 int unwind_deferred_trace(struct unwind_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_cache *cache = &info->cache;
 
 	/* Should always be called from faultable context */
 	might_fault();
@@ -20,17 +21,29 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	if (!current->mm)
 		return -EINVAL;
 
-       if (!info->entries) {
-               info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
-                                             GFP_KERNEL);
-               if (!info->entries)
-		       return -ENOMEM;
+	if (!cache->entries) {
+		cache->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
+					       GFP_KERNEL);
+		if (!cache->entries)
+			return -ENOMEM;
+        }
+
+	trace->entries = cache->entries;
+
+	if (cache->nr_entries) {
+               /*
+                * The user stack has already been previously unwound in this
+                * entry context.  Skip the unwind and use the cache.
+                */
+               trace->nr = cache->nr_entries;
+               return 0;
        }
 
 	trace->nr = 0;
-	trace->entries = info->entries;
 	unwind_user(trace, UNWIND_MAX_ENTRIES);
 
+	cache->nr_entries = trace->nr;
+
 	return 0;
 }
 
@@ -45,5 +58,5 @@ void unwind_task_free(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
-	kfree(info->entries);
+	kfree(info->cache.entries);
 }
-- 
2.47.2


