From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/44] perf trace: Beautify 'fspick' arguments
Date: Mon, 27 May 2019 19:36:58 -0300
Message-ID: <20190527223730.11474-13-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Use existing beautifiers for the first 2 args (dfd, path) and wire up
the recently introduced fspick flags table generator.

Now it should be possible to just use:

   perf trace -e fspick

As root and see all move_mount syscalls with its args beautified, either
using the vfs_getname perf probe method or using the
augmented_raw_syscalls.c eBPF helper to get the pathnames, the other
args should work in all cases, i.e. all that is needed can be obtained
directly from the raw_syscalls:sys_enter tracepoint args.

  # cat sys_fspick.c
  #define _GNU_SOURCE        /* See feature_test_macros(7) */
  #include <unistd.h>
  #include <sys/syscall.h>   /* For SYS_xxx definitions */
  #include <fcntl.h>

  #define __NR_fspick 433

  #define FSPICK_CLOEXEC          0x00000001
  #define FSPICK_SYMLINK_NOFOLLOW 0x00000002
  #define FSPICK_NO_AUTOMOUNT     0x00000004
  #define FSPICK_EMPTY_PATH       0x00000008

  static inline int sys_fspick(int fd, const char *path, int flags)
  {
  	syscall(__NR_fspick, fd, path, flags);
  }

  int main(int argc, char *argv[])
  {
  	int flags = 0, fd = 0;

  	open("/foo", 0);
  	sys_fspick(fd++, "/foo1", flags);
  	flags |= FSPICK_CLOEXEC;
  	sys_fspick(fd++, "/foo2", flags);
  	flags |= FSPICK_SYMLINK_NOFOLLOW;
  	sys_fspick(fd++, "/foo3", flags);
  	flags |= FSPICK_NO_AUTOMOUNT;
  	sys_fspick(fd++, "/foo4", flags);
  	flags |= FSPICK_EMPTY_PATH;
  	return sys_fspick(fd++, "/foo5", flags);
  }
  # perf trace -e fspick ./sys_fspick
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  fspick(0, "/foo1", 0)                   = -1 ENOENT (No such file or directory)
  fspick(1, "/foo2", FSPICK_CLOEXEC)      = -1 ENOENT (No such file or directory)
  fspick(2, "/foo3", FSPICK_CLOEXEC|FSPICK_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
  fspick(3, "/foo4", FSPICK_CLOEXEC|FSPICK_SYMLINK_NOFOLLOW|FSPICK_NO_AUTOMOUNT) = -1 ENOENT (No such file or directory)
  fspick(4, "/foo5", FSPICK_CLOEXEC|FSPICK_SYMLINK_NOFOLLOW|FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = -1 ENOENT (No such file or directory)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-erau5xjtt8wvgnhvdbchstuk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                      |  8 +++++++
 tools/perf/builtin-trace.c                    |  4 ++++
 .../examples/bpf/augmented_raw_syscalls.c     |  2 ++
 tools/perf/trace/beauty/Build                 |  1 +
 tools/perf/trace/beauty/beauty.h              |  3 +++
 tools/perf/trace/beauty/fspick.c              | 24 +++++++++++++++++++
 6 files changed, 42 insertions(+)
 create mode 100644 tools/perf/trace/beauty/fspick.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 20448d8cc162..fe93f8c46080 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -419,6 +419,12 @@ fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
 $(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
 	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(linux_uapi_dir) > $@
 
+fspick_arrays := $(beauty_outdir)/fspick_arrays.c
+fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
+
+$(fspick_arrays): $(linux_uapi_dir)/fs.h $(fspick_tbls)
+	$(Q)$(SHELL) '$(fspick_tbls)' $(linux_uapi_dir) > $@
+
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
 asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
 pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -634,6 +640,7 @@ build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
 	$(fadvise_advice_array) \
+	$(fspick_arrays) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
@@ -929,6 +936,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(fadvise_advice_array) \
+		$(OUTPUT)$(fspick_arrays) \
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
 		$(OUTPUT)$(mount_flags_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b76c950e4393..1643da631699 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -713,6 +713,10 @@ static struct syscall_fmt {
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
 	{ .name	    = "flock",
 	  .arg = { [1] = { .scnprintf = SCA_FLOCK, /* cmd */ }, }, },
+	{ .name     = "fspick",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dfd */ },
+		   [1] = { .scnprintf = SCA_FILENAME,	  /* path */ },
+		   [2] = { .scnprintf = SCA_FSPICK_FLAGS, /* flags */ }, }, },
 	{ .name	    = "fstat", .alias = "newfstat", },
 	{ .name	    = "fstatat", .alias = "newfstatat", },
 	{ .name	    = "futex",
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 8d0c0976696e..68a3d61752ce 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -118,6 +118,7 @@ struct augmented_filename {
 #define SYS_EXECVEAT           322
 #define SYS_STATX              332
 #define SYS_MOVE_MOUNT         429
+#define SYS_FSPICK             433
 
 pid_filter(pids_filtered);
 
@@ -253,6 +254,7 @@ int sys_enter(struct syscall_enter_args *args)
 	case SYS_FINIT_MODULE:
 	case SYS_FREMOVEXATTR:
 	case SYS_FSETXATTR:
+	case SYS_FSPICK:
 	case SYS_FUTIMESAT:
 	case SYS_INOTIFY_ADD_WATCH:
 	case SYS_LINKAT:
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index d84812c094ba..c2d38b2b606b 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,6 +1,7 @@
 perf-y += clone.o
 perf-y += fcntl.o
 perf-y += flock.o
+perf-y += fspick.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 perf-y += ioctl.o
 endif
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index dfb84032d8eb..90c1ee708dc9 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -141,6 +141,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_flock(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FLOCK syscall_arg__scnprintf_flock
 
+size_t syscall_arg__scnprintf_fspick_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FSPICK_FLAGS syscall_arg__scnprintf_fspick_flags
+
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_IOCTL_CMD syscall_arg__scnprintf_ioctl_cmd
 
diff --git a/tools/perf/trace/beauty/fspick.c b/tools/perf/trace/beauty/fspick.c
new file mode 100644
index 000000000000..c402479c96f0
--- /dev/null
+++ b/tools/perf/trace/beauty/fspick.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/fspick.c
+ *
+ *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/log2.h>
+
+static size_t fspick__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+#include "trace/beauty/generated/fspick_arrays.c"
+       static DEFINE_STRARRAY(fspick_flags, "FSPICK_");
+
+       return strarray__scnprintf_flags(&strarray__fspick_flags, bf, size, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_fspick_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return fspick__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
+}
-- 
2.20.1
