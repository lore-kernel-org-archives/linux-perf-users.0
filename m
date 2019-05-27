From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/44] perf trace: Beautify 'sync_file_range' arguments
Date: Mon, 27 May 2019 19:37:09 -0300
Message-ID: <20190527223730.11474-24-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Amir Goldstein <amir73il@gmail.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Use existing beautifiers for the first arg, fd, assigned using the
heuristic that looks for syscall arg names and associates SCA_FD with
'fd' named argumes, and wire up the recently introduced sync_file_range
flags table generator.

Now it should be possible to just use:

   perf trace -e sync_file_range

As root and see all sync_file_range syscalls with its args beautified.

  Doing a syscall strace like session looking for this syscall, then run
  postgresql's initdb command:

  # perf trace -e sync_file_range
  <SNIP>
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(7</var/lib/pgsql/data/base/1/2682>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(7</var/lib/pgsql/data/base/1/2682>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(4</var/lib/pgsql/data>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(4</var/lib/pgsql/data>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8tqy34xhpg8gwnaiv74xy93w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                  | 12 +++++++--
 tools/perf/builtin-trace.c                |  2 ++
 tools/perf/trace/beauty/Build             |  1 +
 tools/perf/trace/beauty/beauty.h          |  3 +++
 tools/perf/trace/beauty/sync_file_range.c | 31 +++++++++++++++++++++++
 5 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/trace/beauty/sync_file_range.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 326ca5d6a7ef..92b5236c0000 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -549,6 +549,12 @@ arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 $(arch_errno_name_array): $(arch_errno_tbl)
 	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
 
+sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
+sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
+
+$(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
+	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 # Create python binding output directory if not already present
@@ -671,7 +677,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(usbdevfs_ioctl_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
-	$(arch_errno_name_array)
+	$(arch_errno_name_array) \
+	$(sync_file_range_arrays)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -970,7 +977,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(usbdevfs_ioctl_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
-		$(OUTPUT)$(arch_errno_name_array)
+		$(OUTPUT)$(arch_errno_name_array) \
+		$(OUTPUT)$(sync_file_range_arrays)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 
 #
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3a2ab68a8b85..54b2d0fd0d02 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -912,6 +912,8 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* specialfile */ }, }, },
 	{ .name	    = "symlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	{ .name	    = "sync_file_range",
+	  .arg = { [3] = { .scnprintf = SCA_SYNC_FILE_RANGE_FLAGS, /* flags */ }, }, },
 	{ .name	    = "tgkill",
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 338c61b8ed22..afa75a76f6b8 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -16,3 +16,4 @@ perf-y += renameat.o
 perf-y += sockaddr.o
 perf-y += socket.o
 perf-y += statx.o
+perf-y += sync_file_range.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 9385d1cb121a..7e06605f7c76 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -201,6 +201,9 @@ size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_MASK syscall_arg__scnprintf_statx_mask
 
+size_t syscall_arg__scnprintf_sync_file_range_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SYNC_FILE_RANGE_FLAGS syscall_arg__scnprintf_sync_file_range_flags
+
 size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix);
 
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
diff --git a/tools/perf/trace/beauty/sync_file_range.c b/tools/perf/trace/beauty/sync_file_range.c
new file mode 100644
index 000000000000..1c425f04047d
--- /dev/null
+++ b/tools/perf/trace/beauty/sync_file_range.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/sync_file_range.c
+ *
+ *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/log2.h>
+#include <uapi/linux/fs.h>
+
+static size_t sync_file_range__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+#include "trace/beauty/generated/sync_file_range_arrays.c"
+       static DEFINE_STRARRAY(sync_file_range_flags, "SYNC_FILE_RANGE_");
+       size_t printed = 0;
+
+       if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) == SYNC_FILE_RANGE_WRITE_AND_WAIT) {
+               printed += scnprintf(bf + printed, size - printed, "%s%s", show_prefix ? "SYNC_FILE_RANGE_" : "", "WRITE_AND_WAIT");
+	       flags &= ~SYNC_FILE_RANGE_WRITE_AND_WAIT;
+       }
+
+       return printed + strarray__scnprintf_flags(&strarray__sync_file_range_flags, bf + printed, size - printed, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_sync_file_range_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return sync_file_range__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
+}
-- 
2.20.1
