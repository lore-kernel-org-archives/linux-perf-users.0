From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/11] tools headers UAPI: Sync sched.h with the kernel
Date: Thu, 17 Oct 2019 13:03:00 -0300
Message-ID: <20191017160301.20888-11-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <christian.brauner@ubuntu.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  78f6face5af3 ("sched: add kernel-doc for struct clone_args")
  f14c234b4bc5 ("clone3: switch to copy_struct_from_user()")

This file gets rebuilt, but no changes ensues:

   CC       /tmp/build/perf/trace/beauty/clone.o

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xqruu8wohwlbc57udg1g0xzx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index b3105ac1381a..99335e1f4a27 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -33,8 +33,31 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
-/*
- * Arguments for the clone3 syscall
+#ifndef __ASSEMBLY__
+/**
+ * struct clone_args - arguments for the clone3 syscall
+ * @flags:       Flags for the new process as listed above.
+ *               All flags are valid except for CSIGNAL and
+ *               CLONE_DETACHED.
+ * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
+ *               returned in this argument.
+ * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
+ *               child process will be returned in the child's
+ *               memory.
+ * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
+ *               the child process will be returned in the
+ *               parent's memory.
+ * @exit_signal: The exit_signal the parent process will be
+ *               sent when the child exits.
+ * @stack:       Specify the location of the stack for the
+ *               child process.
+ * @stack_size:  The size of the stack for the child process.
+ * @tls:         If CLONE_SETTLS is set, the tls descriptor
+ *               is set to tls.
+ *
+ * The structure is versioned by size and thus extensible.
+ * New struct members must go at the end of the struct and
+ * must be properly 64bit aligned.
  */
 struct clone_args {
 	__aligned_u64 flags;
@@ -46,6 +69,9 @@ struct clone_args {
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
 };
+#endif
+
+#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 
 /*
  * Scheduling policies
-- 
2.21.0
