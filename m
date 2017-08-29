From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/18] perf trace beauty: Beautify pkey_{alloc,free,mprotect} arguments
Date: Tue, 29 Aug 2017 16:42:52 -0300
Message-ID: <20170829194254.1338-17-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reuse 'mprotect' beautifiers for 'pkey_mprotect'.

System wide tracing pkey_alloc, pkey_free and pkey_mprotect calls, with
backtraces:

  # perf trace -e pkey_alloc,pkey_mprotect,pkey_free --max-stack=5
     0.000 ( 0.011 ms): pkey/7818 pkey_alloc(init_val: DISABLE_ACCESS|DISABLE_WRITE) = -1 EINVAL Invalid argument
                                       syscall (/usr/lib64/libc-2.25.so)
                                       pkey_alloc (/home/acme/c/pkey)
     0.022 ( 0.003 ms): pkey/7818 pkey_mprotect(start: 0x7f28c3890000, len: 4096, prot: READ|WRITE, pkey: -1) = 0
                                       syscall (/usr/lib64/libc-2.25.so)
                                       pkey_mprotect (/home/acme/c/pkey)
     0.030 ( 0.002 ms): pkey/7818 pkey_free(pkey: -1                               ) = -1 EINVAL Invalid argument
                                       syscall (/usr/lib64/libc-2.25.so)
                                       pkey_free (/home/acme/c/pkey)

The tools/include/uapi/asm-generic/mman-common.h file is used to find
the access rights defines for the pkey_alloc syscall second argument.

Since we have the detector of changes for the tools/include header files
versus its kernel origin (include/uapi/asm-generic/mman-common.h), we'll
get whatever new flag appears for that argument automatically.

This method should be used in other cases where it is easy to generate
those flags tables because the header has properly namespaced defines
like PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-3xq5312qlks7wtfzv2sk3nct@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                           | 12 +++++-
 tools/perf/builtin-trace.c                         |  8 ++++
 tools/perf/trace/beauty/Build                      |  1 +
 tools/perf/trace/beauty/beauty.h                   |  3 ++
 tools/perf/trace/beauty/pkey_alloc.c               | 50 ++++++++++++++++++++++
 .../perf/trace/beauty/pkey_alloc_access_rights.sh  | 10 +++++
 6 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/trace/beauty/pkey_alloc.c
 create mode 100755 tools/perf/trace/beauty/pkey_alloc_access_rights.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a5bf3100f812..91ef44bfaf3e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -387,7 +387,8 @@ export INSTALL SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
-beauty_ioctl_outdir := $(OUTPUT)trace/beauty/generated/ioctl
+beauty_outdir := $(OUTPUT)trace/beauty/generated
+beauty_ioctl_outdir := $(beauty_outdir)/ioctl
 drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
 drm_hdr_dir := $(srctree)/tools/include/uapi/drm
 drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
@@ -398,6 +399,13 @@ _dummy := $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_ou
 $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
 	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
 
+pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
+asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
+pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
+
+$(pkey_alloc_access_rights_array): $(asm_generic_hdr_dir)/mman-common.h $(pkey_alloc_access_rights_tbl)
+	$(Q)$(SHELL) '$(pkey_alloc_access_rights_tbl)' $(asm_generic_hdr_dir) > $@
+
 sndrv_ctl_ioctl_array := $(beauty_ioctl_outdir)/sndrv_ctl_ioctl_array.c
 sndrv_ctl_hdr_dir := $(srctree)/tools/include/uapi/sound
 sndrv_ctl_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
@@ -528,6 +536,7 @@ __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
+	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
 	$(kvm_ioctl_array) \
@@ -803,6 +812,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(drm_ioctl_array) \
+		$(OUTPUT)$(pkey_alloc_access_rights_array) \
 		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
 		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
 		$(OUTPUT)$(kvm_ioctl_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 91905839e386..d59cdadf3a79 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -693,6 +693,14 @@ static struct syscall_fmt {
 		   [4] = { .scnprintf = SCA_PERF_FLAGS, /* flags */ }, }, },
 	{ .name	    = "pipe2",
 	  .arg = { [1] = { .scnprintf = SCA_PIPE_FLAGS, /* flags */ }, }, },
+	{ .name	    = "pkey_alloc",
+	  .arg = { [1] = { .scnprintf = SCA_PKEY_ALLOC_ACCESS_RIGHTS,	/* access_rights */ }, }, },
+	{ .name	    = "pkey_free",
+	  .arg = { [0] = { .scnprintf = SCA_INT,	/* key */ }, }, },
+	{ .name	    = "pkey_mprotect",
+	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
+		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+		   [3] = { .scnprintf = SCA_INT,	/* pkey */ }, }, },
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
 	{ .name	    = "pread", .alias = "pread64", },
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 6f3f159f97e0..175d633c6b49 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -3,4 +3,5 @@ libperf-y += fcntl.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 libperf-y += ioctl.o
 endif
+libperf-y += pkey_alloc.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 47a36a8eb842..4b58581a6053 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -78,6 +78,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_IOCTL_CMD syscall_arg__scnprintf_ioctl_cmd
 
+size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PKEY_ALLOC_ACCESS_RIGHTS syscall_arg__scnprintf_pkey_alloc_access_rights
+
 size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_OPEN_FLAGS syscall_arg__scnprintf_open_flags
 
diff --git a/tools/perf/trace/beauty/pkey_alloc.c b/tools/perf/trace/beauty/pkey_alloc.c
new file mode 100644
index 000000000000..2ba784a3734a
--- /dev/null
+++ b/tools/perf/trace/beauty/pkey_alloc.c
@@ -0,0 +1,50 @@
+/*
+ * trace/beauty/pkey_alloc.c
+ *
+ *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ *
+ * Released under the GPL v2. (and only v2, not any later version)
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
+#include <linux/log2.h>
+
+static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, size_t size)
+{
+	int i, printed = 0;
+
+#include "trace/beauty/generated/pkey_alloc_access_rights_array.c"
+	static DEFINE_STRARRAY(pkey_alloc_access_rights);
+
+	if (access_rights == 0) {
+		const char *s = strarray__pkey_alloc_access_rights.entries[0];
+		if (s)
+			return scnprintf(bf, size, "%s", s);
+		return scnprintf(bf, size, "%d", 0);
+	}
+
+	for (i = 1; i < strarray__pkey_alloc_access_rights.nr_entries; ++i) {
+		int bit = 1 << (i - 1);
+
+		if (!(access_rights & bit))
+			continue;
+
+		if (printed != 0)
+			printed += scnprintf(bf + printed, size - printed, "|");
+
+		if (strarray__pkey_alloc_access_rights.entries[i] != NULL)
+			printed += scnprintf(bf + printed, size - printed, "%s", strarray__pkey_alloc_access_rights.entries[i]);
+		else
+			printed += scnprintf(bf + printed, size - printed, "0x%#", bit);
+	}
+
+	return printed;
+}
+
+size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long cmd = arg->val;
+
+	return pkey_alloc__scnprintf_access_rights(cmd, bf, size);
+}
diff --git a/tools/perf/trace/beauty/pkey_alloc_access_rights.sh b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
new file mode 100755
index 000000000000..62e51a02b839
--- /dev/null
+++ b/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+header_dir=$1
+
+printf "static const char *pkey_alloc_access_rights[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+PKEY_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*'
+egrep $regex ${header_dir}/mman-common.h	| \
+	sed -r "s/$regex/\2 \2 \1/g"	| \
+	sort | xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
+printf "};\n"
-- 
2.13.5
