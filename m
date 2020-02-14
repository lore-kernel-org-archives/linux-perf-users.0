From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/23] tools include UAPI: Sync x86's syscalls_64.tbl, generic unistd.h and fcntl.h to pick up openat2 and pidfd_getfd
Date: Fri, 14 Feb 2020 16:10:38 -0300
Message-ID: <20200214191057.26266-5-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian.brauner@ubuntu.com>, Sargun Dhillon <sargun@sargun.me>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  fddb5d430ad9 ("open: introduce openat2(2) syscall")
  9a2cef09c801 ("arch: wire up pidfd_getfd syscall")

We also need to grab a copy of uapi/linux/openat2.h since it is now
needed by fcntl.h, add it to tools/perf/check_headers.h.

  $ diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  --- tools/perf/arch/x86/entry/syscalls/syscall_64.tbl	2019-12-20 16:43:57.662429958 -0300
  +++ arch/x86/entry/syscalls/syscall_64.tbl	2020-02-10 16:36:22.070012468 -0300
  @@ -357,6 +357,8 @@
   433	common	fspick			__x64_sys_fspick
   434	common	pidfd_open		__x64_sys_pidfd_open
   435	common	clone3			__x64_sys_clone3/ptregs
  +437	common	openat2			__x64_sys_openat2
  +438	common	pidfd_getfd		__x64_sys_pidfd_getfd

   #
   # x32-specific system call numbers start at 512 to avoid cache impact
  $

Update tools/'s copy of that file:

  $ cp arch/x86/entry/syscalls/syscall_64.tbl tools/perf/arch/x86/entry/syscalls/syscall_64.tbl

See the result:

  $ diff -u /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
  --- /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before	2020-02-10 16:42:59.010636041 -0300
  +++ /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c	2020-02-10 16:43:24.149958337 -0300
  @@ -346,5 +346,7 @@
   	[433] = "fspick",
   	[434] = "pidfd_open",
   	[435] = "clone3",
  +	[437] = "openat2",
  +	[438] = "pidfd_getfd",
   };
  -#define SYSCALLTBL_x86_64_MAX_ID 435
  +#define SYSCALLTBL_x86_64_MAX_ID 438
  $

Now one can use:

  perf trace -e openat2,pidfd_getfd

To get just those syscalls or use in things like:

  perf trace -e open*

To get all the open variant (open, openat, openat2, etc) or:

  perf trace pidfd*

To get the pidfd syscalls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h       |  7 +++-
 tools/include/uapi/linux/fcntl.h              |  2 +-
 tools/include/uapi/linux/openat2.h            | 39 +++++++++++++++++++
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 tools/perf/check-headers.sh                   |  1 +
 5 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/uapi/linux/openat2.h

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 1fc8faa6e973..3a3201e4618e 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -851,8 +851,13 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
 
+#define __NR_openat2 437
+__SYSCALL(__NR_openat2, sys_openat2)
+#define __NR_pidfd_getfd 438
+__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 439
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 1f97b33c840e..ca88b7bce553 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FCNTL_H
 
 #include <asm/fcntl.h>
+#include <linux/openat2.h>
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
@@ -100,5 +101,4 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
-
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/tools/include/uapi/linux/openat2.h b/tools/include/uapi/linux/openat2.h
new file mode 100644
index 000000000000..58b1eb711360
--- /dev/null
+++ b/tools/include/uapi/linux/openat2.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_OPENAT2_H
+#define _UAPI_LINUX_OPENAT2_H
+
+#include <linux/types.h>
+
+/*
+ * Arguments for how openat2(2) should open the target path. If only @flags and
+ * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
+ *
+ * However, unlike openat(2), unknown or invalid bits in @flags result in
+ * -EINVAL rather than being silently ignored. @mode must be zero unless one of
+ * {O_CREAT, O_TMPFILE} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @resolve: RESOLVE_* flags.
+ */
+struct open_how {
+	__u64 flags;
+	__u64 mode;
+	__u64 resolve;
+};
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+
+#endif /* _UAPI_LINUX_OPENAT2_H */
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c29976eca4a8..44d510bc9b78 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,8 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+437	common	openat2			__x64_sys_openat2
+438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 68039a96c1dc..bfb21d049e6c 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -13,6 +13,7 @@ include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
 include/uapi/linux/mount.h
+include/uapi/linux/openat2.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
-- 
2.21.1
