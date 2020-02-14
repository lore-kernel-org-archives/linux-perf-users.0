From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/23] tools headers UAPI: Sync sched.h with the kernel
Date: Fri, 14 Feb 2020 16:10:47 -0300
Message-ID: <20200214191057.26266-14-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andrei Vagin <avagin@openvz.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  769071ac9f20 ("ns: Introduce Time Namespace")

Silencing this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Which enables 'perf trace' to decode the CLONE_NEWTIME bit in the
'flags' argument to the clone syscalls.

Example of clone flags being decoded:

  [root@quaco ~]# perf trace -e clone*
       0.000 qemu-system-x8/23923 clone(clone_flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, newsp: 0x7f0dad7f9870, parent_tidptr: 0x7f0dad7fa9d0, child_tidptr: 0x7f0dad7fa9d0, tls: 0x7f0dad7fa700) = 6806 (qemu-system-x86)
           ? qemu-system-x8/6806  ... [continued]: clone())              = 0
  ^C[root@quaco ~]#

At some point this should enable things like:

  # perf trace -e 'clone*/clone_flags&NEWTIME/'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 4a0217832464..2e3bc22c6f20 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -36,6 +36,12 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 
+/*
+ * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
+ * syscalls only:
+ */
+#define CLONE_NEWTIME	0x00000080	/* New time namespace */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
-- 
2.21.1
