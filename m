From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/21] perf trace beauty: Add beautifiers for 'socket''s 'protocol' arg
Date: Wed,  1 Aug 2018 18:36:34 -0300
Message-ID: <20180801213648.4814-8-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll be wired to 'perf trace' in the next cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2i9vkvm1ik8yu4hgjmxhsyjv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf         | 10 ++++++++++
 tools/perf/trace/beauty/Build    |  1 +
 tools/perf/trace/beauty/beauty.h |  3 +++
 tools/perf/trace/beauty/socket.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 tools/perf/trace/beauty/socket.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ecc9fc952655..b3d1b12a5081 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -384,6 +384,8 @@ export INSTALL SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
+linux_uapi_dir := $(srctree)/tools/include/uapi/linux
+
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
 drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
@@ -431,6 +433,12 @@ kvm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
 $(kvm_ioctl_array): $(kvm_hdr_dir)/kvm.h $(kvm_ioctl_tbl)
 	$(Q)$(SHELL) '$(kvm_ioctl_tbl)' $(kvm_hdr_dir) > $@
 
+socket_ipproto_array := $(beauty_outdir)/socket_ipproto_array.c
+socket_ipproto_tbl := $(srctree)/tools/perf/trace/beauty/socket_ipproto.sh
+
+$(socket_ipproto_array): $(linux_uapi_dir)/in.h $(socket_ipproto_tbl)
+	$(Q)$(SHELL) '$(socket_ipproto_tbl)' $(linux_uapi_dir) > $@
+
 vhost_virtio_ioctl_array := $(beauty_ioctl_outdir)/vhost_virtio_ioctl_array.c
 vhost_virtio_hdr_dir := $(srctree)/tools/include/uapi/linux
 vhost_virtio_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
@@ -566,6 +574,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(sndrv_ctl_ioctl_array) \
 	$(kcmp_type_array) \
 	$(kvm_ioctl_array) \
+	$(socket_ipproto_array) \
 	$(vhost_virtio_ioctl_array) \
 	$(madvise_behavior_array) \
 	$(perf_ioctl_array) \
@@ -860,6 +869,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
 		$(OUTPUT)$(kvm_ioctl_array) \
 		$(OUTPUT)$(kcmp_type_array) \
+		$(OUTPUT)$(socket_ipproto_array) \
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 66330d4b739b..f528ba35e140 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -7,4 +7,5 @@ endif
 libperf-y += kcmp.o
 libperf-y += pkey_alloc.o
 libperf-y += prctl.o
+libperf-y += socket.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 984a504d335c..9615af5d412b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -106,6 +106,9 @@ size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_a
 size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG3 syscall_arg__scnprintf_prctl_arg3
 
+size_t syscall_arg__scnprintf_socket_protocol(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SK_PROTO syscall_arg__scnprintf_socket_protocol
+
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
 
diff --git a/tools/perf/trace/beauty/socket.c b/tools/perf/trace/beauty/socket.c
new file mode 100644
index 000000000000..65227269384b
--- /dev/null
+++ b/tools/perf/trace/beauty/socket.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace/beauty/socket.c
+ *
+ *  Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <sys/types.h>
+#include <sys/socket.h>
+
+static size_t socket__scnprintf_ipproto(int protocol, char *bf, size_t size)
+{
+#include "trace/beauty/generated/socket_ipproto_array.c"
+	static DEFINE_STRARRAY(socket_ipproto);
+
+	return strarray__scnprintf(&strarray__socket_ipproto, bf, size, "%d", protocol);
+}
+
+size_t syscall_arg__scnprintf_socket_protocol(char *bf, size_t size, struct syscall_arg *arg)
+{
+	int domain = syscall_arg__val(arg, 0);
+
+	if (domain == AF_INET || domain == AF_INET6)
+		return socket__scnprintf_ipproto(arg->val, bf, size);
+
+	return syscall_arg__scnprintf_int(bf, size, arg);
+}
-- 
2.14.4
