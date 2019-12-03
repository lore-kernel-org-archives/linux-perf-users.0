From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/23] tools headers UAPI: Sync sched.h with the kernel
Date: Tue,  3 Dec 2019 10:56:01 -0300
Message-ID: <20191203135606.24902-19-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Adrian Reber <areber@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  0acefef58451 ("Merge tag 'threads-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux")
  49cb2fc42ce4 ("fork: extend clone3() to support setting a PID")
  fa729c4df558 ("clone3: validate stack arguments")
  b612e5df4587 ("clone3: add CLONE_CLEAR_SIGHAND")

This file gets rebuilt, but no changes ensues:

   CC       /tmp/build/perf/trace/beauty/clone.o

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.

The CLONE_CLEAR_SIGHAND one will be used in tools/perf/trace/beauty/clone.c
in a followup patch to show that string when this bit is set in the
syscall arg. Keeping a copy of this file allows us to build this in
older systems and have the binary support printing that flag whenever
that system gets its kernel updated to one where this feature is
present.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Adrian Reber <areber@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nprqsvvzbhzoy64cbvos6c5b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 60 ++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 99335e1f4a27..4a0217832464 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -33,27 +33,48 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/* Flags for the clone3() syscall. */
+#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
- * @flags:       Flags for the new process as listed above.
- *               All flags are valid except for CSIGNAL and
- *               CLONE_DETACHED.
- * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
- *               returned in this argument.
- * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
- *               child process will be returned in the child's
- *               memory.
- * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
- *               the child process will be returned in the
- *               parent's memory.
- * @exit_signal: The exit_signal the parent process will be
- *               sent when the child exits.
- * @stack:       Specify the location of the stack for the
- *               child process.
- * @stack_size:  The size of the stack for the child process.
- * @tls:         If CLONE_SETTLS is set, the tls descriptor
- *               is set to tls.
+ * @flags:        Flags for the new process as listed above.
+ *                All flags are valid except for CSIGNAL and
+ *                CLONE_DETACHED.
+ * @pidfd:        If CLONE_PIDFD is set, a pidfd will be
+ *                returned in this argument.
+ * @child_tid:    If CLONE_CHILD_SETTID is set, the TID of the
+ *                child process will be returned in the child's
+ *                memory.
+ * @parent_tid:   If CLONE_PARENT_SETTID is set, the TID of
+ *                the child process will be returned in the
+ *                parent's memory.
+ * @exit_signal:  The exit_signal the parent process will be
+ *                sent when the child exits.
+ * @stack:        Specify the location of the stack for the
+ *                child process.
+ *                Note, @stack is expected to point to the
+ *                lowest address. The stack direction will be
+ *                determined by the kernel and set up
+ *                appropriately based on @stack_size.
+ * @stack_size:   The size of the stack for the child process.
+ * @tls:          If CLONE_SETTLS is set, the tls descriptor
+ *                is set to tls.
+ * @set_tid:      Pointer to an array of type *pid_t. The size
+ *                of the array is defined using @set_tid_size.
+ *                This array is used to select PIDs/TIDs for
+ *                newly created processes. The first element in
+ *                this defines the PID in the most nested PID
+ *                namespace. Each additional element in the array
+ *                defines the PID in the parent PID namespace of
+ *                the original PID namespace. If the array has
+ *                less entries than the number of currently
+ *                nested PID namespaces only the PIDs in the
+ *                corresponding namespaces are set.
+ * @set_tid_size: This defines the size of the array referenced
+ *                in @set_tid. This cannot be larger than the
+ *                kernel's limit of nested PID namespaces.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -68,10 +89,13 @@ struct clone_args {
 	__aligned_u64 stack;
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
+#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
 
 /*
  * Scheduling policies
-- 
2.21.0
