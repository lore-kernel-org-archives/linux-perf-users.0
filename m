From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/18] perf trace beautify ioctl: Beautify vhost virtio ioctl's 'cmd' arg
Date: Tue,  1 Aug 2017 16:56:44 -0300
Message-ID: <20170801195645.16986-18-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Also trying a new approach, using a copy of uapi/linux/vhost.h we auto
generate the string tables, then include it in the ioctl cmd beautifier.

This way either the KVM developers will add the new commands to the
tools/ copy, like is happening with other areas of tools/include/ (bpf.h
comes to mind), or we'll be notified when building perf that our copy
drifted.

E.g., doing syswide tracing grepping for the newly beautified VHOST
ioctls:

  # perf trace -e ioctl 2>&1 | grep VHOST
  3873.064 ( 0.099 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_NET_SET_BACKEND, arg: 0x7fff053dffe0) = 0
  3873.168 ( 0.019 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_NET_SET_BACKEND, arg: 0x7fff053dffe0) = 0
  3873.226 ( 0.006 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_GET_VRING_BASE, arg: 0x7fff053dff60) = 0
  3873.244 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_GET_VRING_BASE, arg: 0x7fff053dff60) = 0
  3873.817 ( 0.014 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_CALL, arg: 0x7fff053dff20) = 0
  3873.838 ( 0.004 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_CALL, arg: 0x7fff053dff20) = 0
  4701.372 ( 0.006 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_CALL, arg: 0x7fff053dfe20) = 0
  4701.417 ( 0.007 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_CALL, arg: 0x7fff053dfe20) = 0
  4701.563 ( 0.004 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_FEATURES, arg: 0x7fff053dfe88) = 0
  4701.571 ( 0.028 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_MEM_TABLE, arg: 0x563c7c906870) = 0
  4701.604 ( 0.003 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_NUM, arg: 0x7fff053dff00) = 0
  4701.609 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_BASE, arg: 0x7fff053dff00) = 0
  4701.615 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_ADDR, arg: 0x7fff053dfe70) = 0
  4701.619 ( 0.008 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_KICK, arg: 0x7fff053dfef0) = 0
  4701.634 ( 0.004 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_NUM, arg: 0x7fff053dff00) = 0
  4701.640 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_BASE, arg: 0x7fff053dff00) = 0
  4701.644 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_ADDR, arg: 0x7fff053dfe70) = 0
  4701.648 ( 0.009 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_SET_VRING_KICK, arg: 0x7fff053dfef0) = 0
  4701.665 ( 0.005 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_NET_SET_BACKEND, arg: 0x7fff053dff80) = 0
  4701.672 ( 0.004 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: VHOST_NET_SET_BACKEND, arg: 0x7fff053dff80) = 0
^C

 '-e ioctl' uses tracepoint filters, in time this will be replaces by
eBPF filters hooked at the syscall tracepoints and that "grep VHOST"
will also be done with eBPF, right at the kernel, to reduce overhead.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-2gthnhpliunvakywjterrzz3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                      | 13 +++++++++++--
 tools/perf/trace/beauty/ioctl.c               | 14 ++++++++++++++
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh | 17 +++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100755 tools/perf/trace/beauty/vhost_virtio_ioctl.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6c1be10c6749..606358d67f8a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -413,6 +413,13 @@ kvm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
 $(kvm_ioctl_array): $(kvm_hdr_dir)/kvm.h $(kvm_ioctl_tbl)
 	$(Q)$(SHELL) '$(kvm_ioctl_tbl)' $(kvm_hdr_dir) > $@
 
+vhost_virtio_ioctl_array := $(beauty_ioctl_outdir)/vhost_virtio_ioctl_array.c
+vhost_virtio_hdr_dir := $(srctree)/tools/include/uapi/linux
+vhost_virtio_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
+
+$(vhost_virtio_ioctl_array): $(vhost_virtio_hdr_dir)/vhost.h $(vhost_virtio_ioctl_tbl)
+	$(Q)$(SHELL) '$(vhost_virtio_ioctl_tbl)' $(vhost_virtio_hdr_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -510,7 +517,8 @@ build-dir   = $(if $(__build-dir),$(__build-dir),.)
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
-	$(kvm_ioctl_array)
+	$(kvm_ioctl_array) \
+	$(vhost_virtio_ioctl_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -779,7 +787,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(drm_ioctl_array) \
 		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
 		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
-		$(OUTPUT)$(kvm_ioctl_array)
+		$(OUTPUT)$(kvm_ioctl_array) \
+		$(OUTPUT)$(vhost_virtio_ioctl_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
 
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 8633d96ed131..95434b27873d 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -88,6 +88,19 @@ static size_t ioctl__scnprintf_kvm_cmd(int nr, int dir, char *bf, size_t size)
 	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAE, nr, dir);
 }
 
+static size_t ioctl__scnprintf_vhost_virtio_cmd(int nr, int dir, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c"
+	static DEFINE_STRARRAY(vhost_virtio_ioctl_cmds);
+	static DEFINE_STRARRAY(vhost_virtio_ioctl_read_cmds);
+	struct strarray *s = (dir & _IOC_READ) ? &strarray__vhost_virtio_ioctl_read_cmds : &strarray__vhost_virtio_ioctl_cmds;
+
+	if (nr < s->nr_entries && s->entries[nr] != NULL)
+		return scnprintf(bf, size, "VHOST_%s", s->entries[nr]);
+
+	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAF, nr, dir);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 {
 	int dir	 = _IOC_DIR(cmd),
@@ -104,6 +117,7 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 		['U' - 'A']=  { .type	= 'U', .scnprintf = ioctl__scnprintf_sndrv_ctl_cmd, },
 		['d' - 'A'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, },
 		[0xAE - 'A'] = { .type	= 0xAE, .scnprintf = ioctl__scnprintf_kvm_cmd, },
+		[0xAF - 'A'] = { .type	= 0xAF, .scnprintf = ioctl__scnprintf_vhost_virtio_cmd, },
 	};
 	const int nr_types = ARRAY_SIZE(ioctl_types);
 
diff --git a/tools/perf/trace/beauty/vhost_virtio_ioctl.sh b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
new file mode 100755
index 000000000000..76f1de697787
--- /dev/null
+++ b/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+vhost_virtio_header_dir=$1
+
+printf "static const char *vhost_virtio_ioctl_cmds[] = {\n"
+regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
+egrep $regex ${vhost_virtio_header_dir}/vhost.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
+
+printf "static const char *vhost_virtio_ioctl_read_cmds[] = {\n"
+regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?R\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
+egrep $regex ${vhost_virtio_header_dir}/vhost.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.9.4
