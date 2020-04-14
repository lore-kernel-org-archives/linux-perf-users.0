From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/15] tools headers UAPI: Sync sched.h with the kernel
Date: Tue, 14 Apr 2020 13:48:44 -0300
Message-ID: <20200414164854.26026-6-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Christian Brauner <christian.brauner@ubuntu.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")

Add that to 'perf trace's clone 'flags' decoder.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 5 +++++
 tools/perf/trace/beauty/clone.c  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 2e3bc22c6f20..3bac0a8ceab2 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -35,6 +35,7 @@
 
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
+#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
@@ -81,6 +82,8 @@
  * @set_tid_size: This defines the size of the array referenced
  *                in @set_tid. This cannot be larger than the
  *                kernel's limit of nested PID namespaces.
+ * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
+ *                a file descriptor for the cgroup.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -97,11 +100,13 @@ struct clone_args {
 	__aligned_u64 tls;
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
 
 /*
  * Scheduling policies
diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index 062ca849c8fd..f4db894e0af6 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -46,6 +46,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 	P_FLAG(NEWNET);
 	P_FLAG(IO);
 	P_FLAG(CLEAR_SIGHAND);
+	P_FLAG(INTO_CGROUP);
 #undef P_FLAG
 
 	if (flags)
-- 
2.21.1
