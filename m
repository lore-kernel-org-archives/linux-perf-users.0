From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/19] perf trace beauty kcmp: Beautify arguments
Date: Fri,  3 Nov 2017 10:55:01 -0300
Message-ID: <20171103135503.4921-18-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andrey Vagin <avagin@openvz.org>, Cyrill Gorcunov <gorcunov@openvz.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For some unknown reason there is no entry in tracefs's syscalls for
kcmp, i.e. no tracefs/events/syscalls/sys_{enter,exit}_kcmp, so we need
to provide a data dictionary for the fields.

To beautify the 'type' argument we automatically generate a strarray
from tools/include/uapi/kcmp.h, the idx1 and idx2 args, nowadays used
only if type == KCMP_FILE, are masked for all the other types and a
lookup is made for the thread and fd to show the path, if possible,
getting it from the probe:vfs_getname if in place or from procfs, races
allowing.

A system wide strace like tracing session, with callchains shows just
one user so far in this fedora 25 machine:

  # perf trace --max-stack 5 -e kcmp
  <SNIP>
  1502914.400 ( 0.001 ms): systemd/1 kcmp(pid1: 1 (systemd), pid2: 1 (systemd), type: FILE, idx1: 271<socket:[4723475]>, idx2: 25<socket:[4788686]>) = -1 ENOSYS Function not implemented
                                         syscall (/usr/lib64/libc-2.25.so)
                                         same_fd (/usr/lib/systemd/libsystemd-shared-233.so)
                                         service_add_fd_store (/usr/lib/systemd/systemd)
                                         service_notify_message.lto_priv.127 (/usr/lib/systemd/systemd)
  1502914.407 ( 0.001 ms): systemd/1 kcmp(pid1: 1 (systemd), pid2: 1 (systemd), type: FILE, idx1: 270<socket:[4726396]>, idx2: 25<socket:[4788686]>) = -1 ENOSYS Function not implemented
                                         syscall (/usr/lib64/libc-2.25.so)
                                         same_fd (/usr/lib/systemd/libsystemd-shared-233.so)
                                         service_add_fd_store (/usr/lib/systemd/systemd)
                                         service_notify_message.lto_priv.127 (/usr/lib/systemd/systemd)
  <SNIP>

The backtraces seem to agree this is really kcmp(), but this system
doesn't have the sys_kcmp(), bummer:

  # uname -a
  Linux jouet 4.14.0-rc3+ #1 SMP Fri Oct 13 12:21:12 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # grep kcmp /proc/kallsyms
  ffffffffb60b8890 W sys_kcmp
  $ grep CONFIG_CHECKPOINT_RESTORE ../build/v4.14.0-rc3+/.config
  # CONFIG_CHECKPOINT_RESTORE is not set
  $

So systemd uses it, good fedora kernel config has it:

  $ grep CONFIG_CHECKPOINT_RESTORE /boot/config-4.13.4-200.fc26.x86_64
  CONFIG_CHECKPOINT_RESTORE=y
  [acme@jouet linux]$

/me goes to rebuild a kernel...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrey Vagin <avagin@openvz.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-gz5fca968viw8m7hryjqvrln@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf             |  9 ++++++++
 tools/perf/builtin-trace.c           |  6 +++++
 tools/perf/trace/beauty/Build        |  1 +
 tools/perf/trace/beauty/beauty.h     |  6 +++++
 tools/perf/trace/beauty/kcmp.c       | 44 ++++++++++++++++++++++++++++++++++++
 tools/perf/trace/beauty/kcmp_type.sh | 10 ++++++++
 6 files changed, 76 insertions(+)
 create mode 100644 tools/perf/trace/beauty/kcmp.c
 create mode 100755 tools/perf/trace/beauty/kcmp_type.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c872ca607b39..68cf1360a3f3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -420,6 +420,13 @@ sndrv_pcm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
 $(sndrv_pcm_ioctl_array): $(sndrv_pcm_hdr_dir)/asound.h $(sndrv_pcm_ioctl_tbl)
 	$(Q)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(sndrv_pcm_hdr_dir) > $@
 
+kcmp_type_array := $(beauty_outdir)/kcmp_type_array.c
+kcmp_hdr_dir := $(srctree)/tools/include/uapi/linux/
+kcmp_type_tbl := $(srctree)/tools/perf/trace/beauty/kcmp_type.sh
+
+$(kcmp_type_array): $(kcmp_hdr_dir)/kcmp.h $(kcmp_type_tbl)
+	$(Q)$(SHELL) '$(kcmp_type_tbl)' $(kcmp_hdr_dir) > $@
+
 kvm_ioctl_array := $(beauty_ioctl_outdir)/kvm_ioctl_array.c
 kvm_hdr_dir := $(srctree)/tools/include/uapi/linux
 kvm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
@@ -553,6 +560,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
+	$(kcmp_type_array) \
 	$(kvm_ioctl_array) \
 	$(vhost_virtio_ioctl_array) \
 	$(madvise_behavior_array) \
@@ -836,6 +844,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
 		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
 		$(OUTPUT)$(kvm_ioctl_array) \
+		$(OUTPUT)$(kcmp_type_array) \
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array)
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0c1461416ef1..505b871fdc82 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -633,6 +633,12 @@ static struct syscall_fmt {
 #else
 		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
 #endif
+	{ .name	    = "kcmp",	    .nr_args = 5,
+	  .arg = { [0] = { .name = "pid1",	.scnprintf = SCA_PID, },
+		   [1] = { .name = "pid2",	.scnprintf = SCA_PID, },
+		   [2] = { .name = "type",	.scnprintf = SCA_KCMP_TYPE, },
+		   [3] = { .name = "idx1",	.scnprintf = SCA_KCMP_IDX, },
+		   [4] = { .name = "idx2",	.scnprintf = SCA_KCMP_IDX, }, }, },
 	{ .name	    = "keyctl",
 	  .arg = { [0] = STRARRAY(option, keyctl_options), }, },
 	{ .name	    = "kill",
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 2f68b76ec39b..066bbf0f4a74 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -3,6 +3,7 @@ libperf-y += fcntl.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 libperf-y += ioctl.o
 endif
+libperf-y += kcmp.o
 libperf-y += pkey_alloc.o
 libperf-y += prctl.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 365bb6fecc1c..3f067bdab84f 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -81,6 +81,12 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_IOCTL_CMD syscall_arg__scnprintf_ioctl_cmd
 
+size_t syscall_arg__scnprintf_kcmp_type(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_KCMP_TYPE syscall_arg__scnprintf_kcmp_type
+
+size_t syscall_arg__scnprintf_kcmp_idx(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_KCMP_IDX syscall_arg__scnprintf_kcmp_idx
+
 size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PKEY_ALLOC_ACCESS_RIGHTS syscall_arg__scnprintf_pkey_alloc_access_rights
 
diff --git a/tools/perf/trace/beauty/kcmp.c b/tools/perf/trace/beauty/kcmp.c
new file mode 100644
index 000000000000..f62040eb9d5c
--- /dev/null
+++ b/tools/perf/trace/beauty/kcmp.c
@@ -0,0 +1,44 @@
+/*
+ * trace/beauty/kcmp.c
+ *
+ *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ *
+ * Released under the GPL v2. (and only v2, not any later version)
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
+#include <sys/types.h>
+#include <machine.h>
+#include <uapi/linux/kcmp.h>
+
+#include "trace/beauty/generated/kcmp_type_array.c"
+
+size_t syscall_arg__scnprintf_kcmp_idx(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long fd = arg->val;
+	int type = syscall_arg__val(arg, 2);
+	pid_t pid;
+
+	if (type != KCMP_FILE)
+		return syscall_arg__scnprintf_long(bf, size, arg);
+
+	pid = syscall_arg__val(arg, arg->idx == 3 ? 0 : 1); /* idx1 -> pid1, idx2 -> pid2 */
+	return pid__scnprintf_fd(arg->trace, pid, fd, bf, size);
+}
+
+static size_t kcmp__scnprintf_type(int type, char *bf, size_t size)
+{
+	static DEFINE_STRARRAY(kcmp_types);
+	return strarray__scnprintf(&strarray__kcmp_types, bf, size, "%d", type);
+}
+
+size_t syscall_arg__scnprintf_kcmp_type(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long type = arg->val;
+
+	if (type != KCMP_FILE)
+		arg->mask |= (1 << 3) | (1 << 4); /* Ignore idx1 and idx2 */
+
+	return kcmp__scnprintf_type(type, bf, size);
+}
diff --git a/tools/perf/trace/beauty/kcmp_type.sh b/tools/perf/trace/beauty/kcmp_type.sh
new file mode 100755
index 000000000000..40d063b8c082
--- /dev/null
+++ b/tools/perf/trace/beauty/kcmp_type.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+header_dir=$1
+
+printf "static const char *kcmp_types[] = {\n"
+regex='^[[:space:]]+(KCMP_(\w+)),'
+egrep $regex ${header_dir}/kcmp.h | grep -v KCMP_TYPES, | \
+	sed -r "s/$regex/\1 \2/g" | \
+	xargs printf "\t[%s]\t= \"%s\",\n"
+printf "};\n"
-- 
2.13.6
