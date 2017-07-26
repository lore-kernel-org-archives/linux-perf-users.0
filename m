From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/40] tools include uapi: Grab a copy of linux/sched.h
Date: Wed, 26 Jul 2017 11:17:00 -0300
Message-ID: <20170726141730.30750-11-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we make sure we have recent enough defines for things
such as 'perf trace' system call argument beautifiers.

For instance, the 'clone' syscall argument 'flag' needs to use
CLONE_NEWCGROUP, and that is not available in RHEL7.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-81sln0ng4a2lcxrth14vcov4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 52 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/MANIFEST              |  1 +
 tools/perf/check-headers.sh      |  1 +
 3 files changed, 54 insertions(+)
 create mode 100644 tools/include/uapi/linux/sched.h

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
new file mode 100644
index 000000000000..e2a6c7b3510b
--- /dev/null
+++ b/tools/include/uapi/linux/sched.h
@@ -0,0 +1,52 @@
+#ifndef _UAPI_LINUX_SCHED_H
+#define _UAPI_LINUX_SCHED_H
+
+/*
+ * cloning flags:
+ */
+#define CSIGNAL		0x000000ff	/* signal mask to be sent at exit */
+#define CLONE_VM	0x00000100	/* set if VM shared between processes */
+#define CLONE_FS	0x00000200	/* set if fs info shared between processes */
+#define CLONE_FILES	0x00000400	/* set if open files shared between processes */
+#define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
+#define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
+#define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
+#define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
+#define CLONE_THREAD	0x00010000	/* Same thread group? */
+#define CLONE_NEWNS	0x00020000	/* New mount namespace group */
+#define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
+#define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
+#define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
+#define CLONE_CHILD_CLEARTID	0x00200000	/* clear the TID in the child */
+#define CLONE_DETACHED		0x00400000	/* Unused, ignored */
+#define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
+#define CLONE_NEWCGROUP		0x02000000	/* New cgroup namespace */
+#define CLONE_NEWUTS		0x04000000	/* New utsname namespace */
+#define CLONE_NEWIPC		0x08000000	/* New ipc namespace */
+#define CLONE_NEWUSER		0x10000000	/* New user namespace */
+#define CLONE_NEWPID		0x20000000	/* New pid namespace */
+#define CLONE_NEWNET		0x40000000	/* New network namespace */
+#define CLONE_IO		0x80000000	/* Clone io context */
+
+/*
+ * Scheduling policies
+ */
+#define SCHED_NORMAL		0
+#define SCHED_FIFO		1
+#define SCHED_RR		2
+#define SCHED_BATCH		3
+/* SCHED_ISO: reserved but not implemented yet */
+#define SCHED_IDLE		5
+#define SCHED_DEADLINE		6
+
+/* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
+#define SCHED_RESET_ON_FORK     0x40000000
+
+/*
+ * For the sched_{set,get}attr() calls
+ */
+#define SCHED_FLAG_RESET_ON_FORK	0x01
+#define SCHED_FLAG_RECLAIM		0x02
+
+#endif /* _UAPI_LINUX_SCHED_H */
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index a29da46d180f..9f2267b82eb2 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -78,6 +78,7 @@ tools/include/uapi/linux/fcntl.h
 tools/include/uapi/linux/hw_breakpoint.h
 tools/include/uapi/linux/mman.h
 tools/include/uapi/linux/perf_event.h
+tools/include/uapi/linux/sched.h
 tools/include/uapi/linux/stat.h
 tools/include/linux/poison.h
 tools/include/linux/rbtree.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 47abd3325190..9b6295809a3b 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -3,6 +3,7 @@
 HEADERS='
 include/uapi/linux/fcntl.h
 include/uapi/linux/perf_event.h
+include/uapi/linux/sched.h
 include/uapi/linux/stat.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
-- 
2.9.4
