From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/19] perf trace beauty prctl: Generate 'option' string table from kernel headers
Date: Fri,  3 Nov 2017 10:54:51 -0300
Message-ID: <20171103135503.4921-8-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756214AbdKCNzx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Nov 2017 09:55:53 -0400
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andy Lutomirski <luto@kernel.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is one more case where the way that syscall parameter values are
defined in kernel headers are easy to parse using a shell script that
will then generate the string table that gets used by the prctl 'option'
argument beautifier.

This way as soon as the header syncronization mechanism in perf's build
system detects a change in a copy of a kernel ABI header and that file
is syncronized, we get 'perf trace' updated automagically.

Further work needed for the PR_SET_ values, as well for using eBPF to
copy the non-integer arguments to/from the kernel.

E.g.: System wide prctl tracing:

  # perf trace -e prctl
  1668.028 ( 0.025 ms): TaskSchedulerR/10649 prctl(option: SET_NAME, arg2: 0x2b61d5db15d0) = 0
  3365.663 ( 0.018 ms): chrome/10650 prctl(option: SET_SECCOMP, arg2: 2, arg4: 8         ) = -1 EFAULT Bad address
  3366.585 ( 0.010 ms): chrome/10650 prctl(option: SET_NO_NEW_PRIVS, arg2: 1             ) = 0
  3367.173 ( 0.009 ms): TaskSchedulerR/10652 prctl(option: SET_NAME, arg2: 0x2b61d2aaa300) = 0
  3367.222 ( 0.003 ms): TaskSchedulerR/10653 prctl(option: SET_NAME, arg2: 0x2b61d2aaa1e0) = 0
  3367.244 ( 0.002 ms): TaskSchedulerR/10654 prctl(option: SET_NAME, arg2: 0x2b61d2aaa0c0) = 0
  3367.265 ( 0.002 ms): TaskSchedulerR/10655 prctl(option: SET_NAME, arg2: 0x2b61d2ac7f90) = 0
  3367.281 ( 0.002 ms): Chrome_ChildIO/10656 prctl(option: SET_NAME, arg2: 0x7efbe406bb11) = 0
  3367.220 ( 0.004 ms): TaskSchedulerS/10651 prctl(option: SET_NAME, arg2: 0x2b61d2ac1be0) = 0
  3370.906 ( 0.010 ms): GpuMemoryThrea/10657 prctl(option: SET_NAME, arg2: 0x7efbe386ab11) = 0
  3370.983 ( 0.003 ms): File/10658 prctl(option: SET_NAME, arg2: 0x7efbe3069b11          ) = 0
  3384.272 ( 0.020 ms): Compositor/10659 prctl(option: SET_NAME, arg2: 0x7efbe2868b11    ) = 0
  3612.091 ( 0.012 ms): DOM Worker/11489 prctl(option: SET_NAME, arg2: 0x7f49ab97ebf2    ) = 0
<SNIP>
  4512.437 ( 0.004 ms): (sa1)/11490 prctl(option: SET_NAME, arg2: 0x7ffca15af844         ) = 0
  4512.468 ( 0.002 ms): (sa1)/11490 prctl(option: SET_MM, arg2: ARG_START, arg3: 0x7f5cb7c81000) = 0
  4512.472 ( 0.001 ms): (sa1)/11490 prctl(option: SET_MM, arg2: ARG_END, arg3: 0x7f5cb7c81006) = 0
  4514.667 ( 0.002 ms): (sa1)/11490 prctl(option: GET_SECUREBITS                         ) = 0

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-q0s2uw579o5ei6xlh2zjirgz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                | 13 +++++-
 tools/perf/builtin-trace.c              |  5 +-
 tools/perf/trace/beauty/Build           |  1 +
 tools/perf/trace/beauty/beauty.h        |  9 ++++
 tools/perf/trace/beauty/prctl.c         | 82 +++++++++++++++++++++++++++++++++
 tools/perf/trace/beauty/prctl_option.sh | 17 +++++++
 6 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/trace/beauty/prctl.c
 create mode 100755 tools/perf/trace/beauty/prctl_option.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5f7408118a2d..c872ca607b39 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -448,6 +448,13 @@ madvise_behavior_tbl := $(srctree)/tools/perf/trace/beauty/madvise_behavior.sh
 $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_tbl)
 	$(Q)$(SHELL) '$(madvise_behavior_tbl)' $(madvise_hdr_dir) > $@
 
+prctl_option_array := $(beauty_outdir)/prctl_option_array.c
+prctl_hdr_dir := $(srctree)/tools/include/uapi/linux/
+prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
+
+$(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
+	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -549,7 +556,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(kvm_ioctl_array) \
 	$(vhost_virtio_ioctl_array) \
 	$(madvise_behavior_array) \
-	$(perf_ioctl_array)
+	$(perf_ioctl_array) \
+	$(prctl_option_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -829,7 +837,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
 		$(OUTPUT)$(kvm_ioctl_array) \
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
-		$(OUTPUT)$(perf_ioctl_array)
+		$(OUTPUT)$(perf_ioctl_array) \
+		$(OUTPUT)$(prctl_option_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 
 #
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8b23982dd9f2..78855916f4b0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -578,7 +578,6 @@ static struct syscall_fmt {
 } syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
-	{ .name	    = "arch_prctl", .alias = "prctl", },
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
@@ -703,6 +702,10 @@ static struct syscall_fmt {
 		   [3] = { .scnprintf = SCA_INT,	/* pkey */ }, }, },
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
+	{ .name	    = "prctl", .alias = "arch_prctl",
+	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */ },
+		   [1] = { .scnprintf = SCA_PRCTL_ARG2, /* arg2 */ },
+		   [2] = { .scnprintf = SCA_PRCTL_ARG3, /* arg3 */ }, }, },
 	{ .name	    = "pread", .alias = "pread64", },
 	{ .name	    = "preadv", .alias = "pread", },
 	{ .name	    = "prlimit64",
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 175d633c6b49..2f68b76ec39b 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -4,4 +4,5 @@ ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 libperf-y += ioctl.o
 endif
 libperf-y += pkey_alloc.o
+libperf-y += prctl.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 4b58581a6053..b29f94ef5d6a 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -84,6 +84,15 @@ size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, st
 size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_OPEN_FLAGS syscall_arg__scnprintf_open_flags
 
+size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PRCTL_OPTION syscall_arg__scnprintf_prctl_option
+
+size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PRCTL_ARG2 syscall_arg__scnprintf_prctl_arg2
+
+size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PRCTL_ARG3 syscall_arg__scnprintf_prctl_arg3
+
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
 
diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
new file mode 100644
index 000000000000..246130dad6c4
--- /dev/null
+++ b/tools/perf/trace/beauty/prctl.c
@@ -0,0 +1,82 @@
+/*
+ * trace/beauty/prctl.c
+ *
+ *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ *
+ * Released under the GPL v2. (and only v2, not any later version)
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
+#include <uapi/linux/prctl.h>
+
+#include "trace/beauty/generated/prctl_option_array.c"
+
+static size_t prctl__scnprintf_option(int option, char *bf, size_t size)
+{
+	static DEFINE_STRARRAY(prctl_options);
+	return strarray__scnprintf(&strarray__prctl_options, bf, size, "%d", option);
+}
+
+static size_t prctl__scnprintf_set_mm(int option, char *bf, size_t size)
+{
+	static DEFINE_STRARRAY(prctl_set_mm_options);
+	return strarray__scnprintf(&strarray__prctl_set_mm_options, bf, size, "%d", option);
+}
+
+size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_arg *arg)
+{
+	int option = syscall_arg__val(arg, 0);
+
+	if (option == PR_SET_MM)
+		return prctl__scnprintf_set_mm(arg->val, bf, size);
+	/*
+	 * We still don't grab the contents of pointers on entry or exit,
+	 * so just print them as hex numbers
+	 */
+	if (option == PR_SET_NAME)
+		return syscall_arg__scnprintf_hex(bf, size, arg);
+
+	return syscall_arg__scnprintf_long(bf, size, arg);
+}
+
+size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg)
+{
+	int option = syscall_arg__val(arg, 0);
+
+	if (option == PR_SET_MM)
+		return syscall_arg__scnprintf_hex(bf, size, arg);
+
+	return syscall_arg__scnprintf_long(bf, size, arg);
+}
+
+size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long option = arg->val;
+	enum {
+                SPO_ARG2 = (1 << 1),
+                SPO_ARG3 = (1 << 2),
+                SPO_ARG4 = (1 << 3),
+                SPO_ARG5 = (1 << 4),
+                SPO_ARG6 = (1 << 5),
+        };
+	const u8 all_but2 = SPO_ARG3 | SPO_ARG4 | SPO_ARG5 | SPO_ARG6;
+	const u8 all = SPO_ARG2 | all_but2;
+	const u8 masks[] = {
+		[PR_GET_DUMPABLE]	 = all,
+		[PR_SET_DUMPABLE]	 = all_but2,
+		[PR_SET_NAME]		 = all_but2,
+		[PR_GET_CHILD_SUBREAPER] = all_but2,
+		[PR_SET_CHILD_SUBREAPER] = all_but2,
+		[PR_GET_SECUREBITS]	 = all,
+		[PR_SET_SECUREBITS]	 = all_but2,
+		[PR_SET_MM]		 = SPO_ARG4 | SPO_ARG5 | SPO_ARG6,
+		[PR_GET_PDEATHSIG]	 = all,
+		[PR_SET_PDEATHSIG]	 = all_but2,
+	};
+
+	if (option < ARRAY_SIZE(masks))
+		arg->mask |= masks[option];
+
+	return prctl__scnprintf_option(option, bf, size);
+}
diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
new file mode 100755
index 000000000000..0be4138fbe71
--- /dev/null
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+header_dir=$1
+
+printf "static const char *prctl_options[] = {\n"
+regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
+egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort -n | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
+
+printf "static const char *prctl_set_mm_options[] = {\n"
+regex='^#[[:space:]]+define[[:space:]]+PR_SET_MM_(\w+)[[:space:]]*([[:digit:]]+).*'
+egrep $regex ${header_dir}/prctl.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort -n | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.13.6
