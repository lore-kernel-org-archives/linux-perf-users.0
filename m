From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/44] perf bpf: Add 'syscall_enter' probe helper for syscall enter tracepoints
Date: Thu,  9 Aug 2018 11:57:50 -0300
Message-ID: <20180809145822.21391-13-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Allowing one to hook into the syscalls:sys_enter_NAME tracepoints,
an example is provided that hooks into the 'openat' syscall.

Using it with the probe:vfs_getname probe into getname_flags to get the
filename args as it is copied from userspace:

  # perf probe -l
  probe:vfs_getname    (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  # perf trace -e probe:*getname,tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
     0.000 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/ld.so.preload"
     0.022 syscalls:sys_enter_openat:dfd: CWD, filename: 0xafbe8da8, flags: CLOEXEC
     0.027 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/ld.so.cache"
     0.054 syscalls:sys_enter_openat:dfd: CWD, filename: 0xafdf0ce0, flags: CLOEXEC
     0.057 probe:vfs_getname:(ffffffffbd2a8983) pathname="/lib64/libc.so.6"
     0.316 probe:vfs_getname:(ffffffffbd2a8983) pathname="/usr/lib/locale/locale-archive"
     0.375 syscalls:sys_enter_openat:dfd: CWD, filename: 0xe2b2b0b4
     0.379 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/passwd"
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2po9jcqv1qgj0koxlg8kkg30@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/sys_enter_openat.c | 33 ++++++++++++++++++++++++++++++
 tools/perf/include/bpf/bpf.h               |  3 +++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/perf/examples/bpf/sys_enter_openat.c

diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
new file mode 100644
index 000000000000..9cd124b09392
--- /dev/null
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hook into 'openat' syscall entry tracepoint
+ *
+ * Test it with:
+ *
+ * perf trace -e tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
+ *
+ * It'll catch some openat syscalls related to the dynamic linked and
+ * the last one should be the one for '/etc/passwd'.
+ *
+ * The syscall_enter_openat_args can be used to get the syscall fields
+ * and use them for filtering calls, i.e. use in expressions for
+ * the return value.
+ */
+
+#include <bpf.h>
+
+struct syscall_enter_openat_args {
+	unsigned long long unused;
+	long		   syscall_nr;
+	long		   dfd;
+	char		   *filename_ptr;
+	long		   flags;
+	long		   mode;
+};
+
+int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+{
+	return 1;
+}
+
+license(GPL);
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index a63aa6241b7f..2873cdde293f 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -9,6 +9,9 @@
 #define probe(function, vars) \
 	SEC(#function "=" #function " " #vars) function
 
+#define syscall_enter(name) \
+	SEC("syscalls:sys_enter_" #name) syscall_enter_ ## name
+
 #define license(name) \
 char _license[] SEC("license") = #name; \
 int _version SEC("version") = LINUX_VERSION_CODE;
-- 
2.14.4
