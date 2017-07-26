From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/40] perf trace beauty clone: Beautify syscall arguments
Date: Wed, 26 Jul 2017 11:17:01 -0300
Message-ID: <20170726141730.30750-12-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now, syswide tracing, selected entries:

  # trace -e clone
  24417.203 ( 0.158 ms): bash/11323 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, parent_tidptr: 0, child_tidptr: 0x7f0778e5c9d0, tls: 0x7f0778e5c700) = 11325 (bash)
          ? (     ?   ): bash/11325  ... [continued]: clone()) = 0
  24419.355 ( 0.093 ms): bash/10586 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, parent_tidptr: 0, child_tidptr: 0x7f0778e5c9d0, tls: 0x7f0778e5c700) = 11326 (bash)
          ? (     ?   ): bash/11326  ... [continued]: clone()) = 0
  24419.744 ( 0.102 ms): bash/11326 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, parent_tidptr: 0, child_tidptr: 0x7f0778e5c9d0, tls: 0x7f0778e5c700) = 11327 (bash)
          ? (     ?   ): bash/11327  ... [continued]: clone()) = 0
  24420.138 ( 0.105 ms): bash/11327 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, parent_tidptr: 0, child_tidptr: 0x7f0778e5c9d0, tls: 0x7f0778e5c700) = 11328 (bash)
          ? (     ?   ): bash/11328  ... [continued]: clone()) = 0
  35747.722 ( 0.044 ms): gpg-agent/18087 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ff0755f6ff0, parent_tidptr: 0x7ff0755f79d0, child_tidptr: 0x7ff0755f79d0, tls: 0x7ff0755f7700) = 11329 (gpg-agent)
          ? (     ?   ): gpg-agent/11329  ... [continued]: clone()) = 0
  35748.359 ( 0.022 ms): gpg-agent/18087 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ff075df7ff0, parent_tidptr: 0x7ff075df89d0, child_tidptr: 0x7ff075df89d0, tls: 0x7ff075df8700) = 11330 (gpg-agent)
          ? (     ?   ): gpg-agent/11330  ... [continued]: clone()) = 0
  35781.422 ( 0.452 ms): NetworkManager/1112 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f2f1fffedb0, parent_tidptr: 0x7f2f1ffff9d0, child_tidptr: 0x7f2f1ffff9d0, tls: 0x7f2f1ffff700) = 11331 (NetworkManager)
          ? (     ?   ): NetworkManager/11331  ... [continued]: clone()) = 0

Need to improve the formatting of the second return, to the child, this
cset only focused on the argument formatting.

If we trace just one pid:

  # trace -e clone -p 19863
     0.349 ( 0.025 ms): Chrome_IOThrea/19863 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ffb84eaac70, parent_tidptr: 0x7ffb84eab9d0, child_tidptr: 0x7ffb84eab9d0, tls: 0x7ffb84eab700) = 11637 (Chrome_IOThread)
     0.392 ( 0.013 ms): Chrome_IOThrea/19863 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ffb664b8c70, parent_tidptr: 0x7ffb664b99d0, child_tidptr: 0x7ffb664b99d0, tls: 0x7ffb664b9700) = 11638 (Chrome_IOThread)
     0.573 ( 0.015 ms): Chrome_IOThrea/19863 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ffb6046cc70, parent_tidptr: 0x7ffb6046d9d0, child_tidptr: 0x7ffb6046d9d0, tls: 0x7ffb6046d700) = 11639 (Chrome_IOThread)
     0.617 ( 0.014 ms): Chrome_IOThrea/19863 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ffb730dcc70, parent_tidptr: 0x7ffb730dd9d0, child_tidptr: 0x7ffb730dd9d0, tls: 0x7ffb730dd700) = 11640 (Chrome_IOThread)
     4.350 ( 0.065 ms): Chrome_IOThrea/19863 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ffb720d9c70, parent_tidptr: 0x7ffb720da9d0, child_tidptr: 0x7ffb720da9d0, tls: 0x7ffb720da700) = 11642 (Chrome_IOThread)
     5.642 ( 0.079 ms): Chrome_IOThrea/19863 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7ffb718d8c70, parent_tidptr: 0x7ffb718d99d0, child_tidptr: 0x7ffb718d99d0, tls: 0x7ffb718d9700) = 11643 (Chrome_IOThread)
^C#

We'll also have to fix the argument ordering in different arches,
probably having multiple syscall_fmt entries with each possible order
and then use perf_evsel__env_arch() (if dealing with a perf.data file)
or the current system info, for live sessions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-am068uyubgj83snepolwhbfe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       |  7 ++++-
 tools/perf/trace/beauty/Build    |  1 +
 tools/perf/trace/beauty/beauty.h |  3 +++
 tools/perf/trace/beauty/clone.c  | 58 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/trace/beauty/clone.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6664293584df..9e74e675d7cb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -626,7 +626,12 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_HEX, /* brk */ }, }, },
 	{ .name     = "clock_gettime",
 	  .arg = { [0] = STRARRAY(clk_id, clockid), }, },
-	{ .name	    = "clone",	    .errpid = true, },
+	{ .name	    = "clone",	    .errpid = true, .nr_args = 5,
+	  .arg = { [0] = { .name = "flags",	    .scnprintf = SCA_CLONE_FLAGS, },
+		   [1] = { .name = "child_stack",   .scnprintf = SCA_HEX, },
+		   [2] = { .name = "parent_tidptr", .scnprintf = SCA_HEX, },
+		   [3] = { .name = "child_tidptr",  .scnprintf = SCA_HEX, },
+		   [4] = { .name = "tls",	    .scnprintf = SCA_HEX, }, }, },
 	{ .name	    = "close",
 	  .arg = { [0] = { .scnprintf = SCA_CLOSE_FD, /* fd */ }, }, },
 	{ .name	    = "epoll_ctl",
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index c9e215b806f1..eaa1e8e8e100 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,2 +1,3 @@
+libperf-y += clone.o
 libperf-y += fcntl.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index f75ef7d0b303..69a5c8a2d420 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -66,6 +66,9 @@ size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *ar
 size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PID syscall_arg__scnprintf_pid
 
+size_t syscall_arg__scnprintf_clone_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_CLONE_FLAGS syscall_arg__scnprintf_clone_flags
+
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_CMD syscall_arg__scnprintf_fcntl_cmd
 
diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
new file mode 100644
index 000000000000..ab982a7c63bb
--- /dev/null
+++ b/tools/perf/trace/beauty/clone.c
@@ -0,0 +1,58 @@
+/*
+ * trace/beauty/cone.c
+ *
+ *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ *
+ * Released under the GPL v2. (and only v2, not any later version)
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
+#include <sys/types.h>
+#include <uapi/linux/sched.h>
+
+static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size)
+{
+	int printed = 0;
+
+#define	P_FLAG(n) \
+	if (flags & CLONE_##n) { \
+		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
+		flags &= ~CLONE_##n; \
+	}
+
+	P_FLAG(VM);
+	P_FLAG(FS);
+	P_FLAG(FILES);
+	P_FLAG(SIGHAND);
+	P_FLAG(PTRACE);
+	P_FLAG(VFORK);
+	P_FLAG(PARENT);
+	P_FLAG(THREAD);
+	P_FLAG(NEWNS);
+	P_FLAG(SYSVSEM);
+	P_FLAG(SETTLS);
+	P_FLAG(PARENT_SETTID);
+	P_FLAG(CHILD_CLEARTID);
+	P_FLAG(DETACHED);
+	P_FLAG(UNTRACED);
+	P_FLAG(CHILD_SETTID);
+	P_FLAG(NEWCGROUP);
+	P_FLAG(NEWUTS);
+	P_FLAG(NEWIPC);
+	P_FLAG(NEWUSER);
+	P_FLAG(NEWPID);
+	P_FLAG(NEWNET);
+	P_FLAG(IO);
+#undef P_FLAG
+
+	if (flags)
+		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
+
+	return printed;
+}
+
+size_t syscall_arg__scnprintf_clone_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	return clone__scnprintf_flags(arg->val, bf, size);
+}
-- 
2.9.4
