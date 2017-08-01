From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/18] perf trace beautify ioctl: Beautify KVM ioctl's 'cmd' arg
Date: Tue,  1 Aug 2017 16:56:41 -0300
Message-ID: <20170801195645.16986-15-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Also trying a new approach, using a copy of uapi/linux/kvm.h we auto
generate the string tables, then include it in the ioctl cmd beautifier.

This way either the KVM developers will add the new commands to the
tools/ copy, like is happening with other areas of tools/include/ (bpf.h
comes to mind), or we'll be notified when building perf that our copy
drifted.

E.g., a tracing a process and its threads, but would work for system wide as
well, just drop that '-p 21238', to see ioctls for DRM, tty, sound, etc:

  # perf trace -e ioctl -p 21238 2>&1 | grep -v KVM_RUN
    7801.536 ( 0.003 ms): CPU 0/KVM/21276 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQ_LINE_STATUS, arg: 0x7f484c6c73c0) = 0
  <SNIP lots of the last one>
    7801.715 ( 0.001 ms): CPU 0/KVM/21276 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQ_LINE_STATUS, arg: 0x7f484c6c73e0) = 0
   11001.051 ( 0.008 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SIGNAL_MSI, arg: 0x563c83379d70) = 1
   11001.225 ( 0.005 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SIGNAL_MSI, arg: 0x563c83379d70) = 1
   10750.377 (249.963 ms): CPU 0/KVM/21276  ... [continued]: ioctl()) = 0
   11011.780 ( 0.015 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SIGNAL_MSI, arg: 0x563c83379d90) = 1
   11011.929 ( 0.005 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SIGNAL_MSI, arg: 0x7fff053e1000) = 1
   11012.090 ( 0.004 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SIGNAL_MSI, arg: 0x563c83379d70) = 1
   11023.127 ( 0.020 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SIGNAL_MSI, arg: 0x563c83379d90) = 1
   11000.483 (249.807 ms): CPU 0/KVM/21276  ... [continued]: ioctl()) = 0
   25620.877 ( 0.042 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQ_LINE_STATUS, arg: 0x7fff053e1080) = 0
  <SNIP several of the last one>
   25621.025 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQ_LINE_STATUS, arg: 0x7fff053e10a0) = 0
   25500.803 (120.186 ms): CPU 0/KVM/21276  ... [continued]: ioctl()) = 0
   25621.078 ( 0.005 ms): CPU 0/KVM/21276 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQ_LINE_STATUS, arg: 0x7f484c6c73c0) = 0
  <SNIP lots of the last one>
   25621.346 ( 0.001 ms): CPU 0/KVM/21276 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQ_LINE_STATUS, arg: 0x7f484c6c73e0) = 0
   40456.997 ( 0.100 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x30, 0x8), arg: 0x7fff053dffe0) = 0
   40457.100 ( 0.019 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x30, 0x8), arg: 0x7fff053dffe0) = 0
   40457.133 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (READ|WRITE, 0xaf, 0x12, 0x8), arg: 0x7fff053dff60) = 0
   40457.139 ( 0.001 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (READ|WRITE, 0xaf, 0x12, 0x8), arg: 0x7fff053dff60) = 0
   40458.503 ( 0.027 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfc80) = 0
   40458.601 ( 0.030 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfc80) = 0
   40458.649 ( 0.003 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x21, 0x8), arg: 0x7fff053dff20) = 0
   40458.654 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x21, 0x8), arg: 0x7fff053dff20) = 0
   40458.657 ( 0.018 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQFD, arg: 0x7fff053dff00  ) = 0
   40459.077 ( 0.017 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQFD, arg: 0x7fff053dff00  ) = 0
   40459.123 ( 0.017 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfd20) = 0
  <SNIP lots of the last one>
   40463.477 ( 0.013 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfd20) = 0
   40464.874 ( 0.010 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_GET_VCPU_EVENTS, arg: 0x7fff053e0000) = 0
   40464.892 ( 0.048 ms): qemu-system-x8/21238 ioctl(fd: 12</dev/kvm>, cmd: KVM_CHECK_EXTENSION, arg: 0x4c           ) = 1
   40464.991 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_GET_CLOCK, arg: 0x7fff053e0040) = 0
   40464.962 ( 0.013 ms): CPU 0/KVM/21276 ioctl(fd: 20<anon_inode:kvm-vcpu>, cmd: KVM_GET_MSRS, arg: 0x7f484c6c7670) = 1
   44540.437 ( 0.103 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SET_GSI_ROUTING, arg: 0x563c7c93c000) = 0
   44540.544 ( 0.008 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQFD, arg: 0x7fff053dfea0  ) = 0
   44540.555 ( 0.029 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SET_GSI_ROUTING, arg: 0x563c7c93c000) = 0
   44540.586 ( 0.003 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IRQFD, arg: 0x7fff053dfea0  ) = 0
   44540.592 ( 0.027 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SET_GSI_ROUTING, arg: 0x563c7c93c000) = 0
   44540.625 ( 0.005 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x21, 0x8), arg: 0x7fff053dfe20) = 0
   44540.639 ( 0.018 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SET_GSI_ROUTING, arg: 0x563c7c93c000) = 0
   44540.658 ( 0.003 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x21, 0x8), arg: 0x7fff053dfe20) = 0
   44540.686 ( 0.015 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfbe0) = 0
   44540.727 ( 0.014 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfbe0) = 0
   44540.748 ( 0.005 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0, 0x8), arg: 0x7fff053dfe88) = 0
   44540.754 ( 0.026 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x3, 0x8), arg: 0x563c7c906870) = 0
   44540.783 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x10, 0x8), arg: 0x7fff053dff00) = 0
   44540.787 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x12, 0x8), arg: 0x7fff053dff00) = 0
   44540.793 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x11, 0x28), arg: 0x7fff053dfe70) = 0
   44540.796 ( 0.010 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x20, 0x8), arg: 0x7fff053dfef0) = 0
   44540.811 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x10, 0x8), arg: 0x7fff053dff00) = 0
   44540.814 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x12, 0x8), arg: 0x7fff053dff00) = 0
   44540.819 ( 0.002 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x11, 0x28), arg: 0x7fff053dfe70) = 0
   44540.822 ( 0.005 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x20, 0x8), arg: 0x7fff053dfef0) = 0
   44540.837 ( 0.006 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x30, 0x8), arg: 0x7fff053dff80) = 0
   44540.862 ( 0.004 ms): qemu-system-x8/21238 ioctl(fd: 27</dev/vhost-net>, cmd: (WRITE, 0xaf, 0x30, 0x8), arg: 0x7fff053dff80) = 0
   44540.887 ( 0.014 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfd00) = 0
  <SNIP lots of the last one>
   44542.756 ( 0.020 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_IOEVENTFD, arg: 0x7fff053dfd00) = 0
   44542.809 ( 0.007 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SET_VCPU_EVENTS, arg: 0x7fff053dffb0) = 0
   44542.819 ( 0.003 ms): qemu-system-x8/21238 ioctl(fd: 12</dev/kvm>, cmd: KVM_CHECK_EXTENSION, arg: 0x4c           ) = 1
   44543.016 ( 0.004 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SET_CLOCK, arg: 0x7fff053dfff0) = 0
   44543.022 ( 0.008 ms): qemu-system-x8/21238 ioctl(fd: 20<anon_inode:kvm-vcpu>, cmd: KVM_KVMCLOCK_CTRL             ) = 0
   46952.502 ( 0.010 ms): qemu-system-x8/21238 ioctl(fd: 13<anon_inode:kvm-vm>, cmd: KVM_SIGNAL_MSI, arg: 0x563c83379d70) = 1
   46829.292 (249.860 ms): CPU 0/KVM/21276  ... [continued]: ioctl()) = 0
  ^C
[root@jouet linux]#

Since there are clashes in _IOC_NR() for some cases, notably ioctls with
PPC_ and ARM_ in its name and some that depend on some internal state to
be valid, but use the same number as others, those were removed in the
shell script that builds the table, tools/perf/trace/beauty/kvm_ioctl.sh.

Since so far we're supporting only x86 in the 'cmd' ioctl arg beautifier
in perf trace, we can leave fully supporting these ioctls for later.

There are some more to handle here, notably the one for /dev/vhost-net, will
come later.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-zxhebe579n338d7qrnjoctes@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf             | 15 +++++++++++++--
 tools/perf/trace/beauty/ioctl.c      | 14 +++++++++++++-
 tools/perf/trace/beauty/kvm_ioctl.sh | 11 +++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100755 tools/perf/trace/beauty/kvm_ioctl.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d49354d340fd..6c1be10c6749 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -406,6 +406,13 @@ sndrv_pcm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
 $(sndrv_pcm_ioctl_array): $(sndrv_pcm_hdr_dir)/asound.h $(sndrv_pcm_ioctl_tbl)
 	$(Q)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(sndrv_pcm_hdr_dir) > $@
 
+kvm_ioctl_array := $(beauty_ioctl_outdir)/kvm_ioctl_array.c
+kvm_hdr_dir := $(srctree)/tools/include/uapi/linux
+kvm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
+
+$(kvm_ioctl_array): $(kvm_hdr_dir)/kvm.h $(kvm_ioctl_tbl)
+	$(Q)$(SHELL) '$(kvm_ioctl_tbl)' $(kvm_hdr_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -500,7 +507,10 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
-prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) $(sndrv_pcm_ioctl_array) $(sndrv_ctl_ioctl_array)
+prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
+	$(sndrv_pcm_ioctl_array) \
+	$(sndrv_ctl_ioctl_array) \
+	$(kvm_ioctl_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -768,7 +778,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(drm_ioctl_array) \
 		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
-		$(OUTPUT)$(sndrv_pcm_ioctl_array)
+		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
+		$(OUTPUT)$(kvm_ioctl_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
 
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index ec5a5a499667..89fa4eb68247 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -77,6 +77,17 @@ static size_t ioctl__scnprintf_sndrv_ctl_cmd(int nr, char *bf, size_t size)
 	return scnprintf(bf, size, "(%#x, %#x)", 'U', nr);
 }
 
+static size_t ioctl__scnprintf_kvm_cmd(int nr, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/kvm_ioctl_array.c"
+	static DEFINE_STRARRAY(kvm_ioctl_cmds);
+
+	if (nr < strarray__kvm_ioctl_cmds.nr_entries && strarray__kvm_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "KVM_%s", strarray__kvm_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%#x, %#x)", 0xAE, nr);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 {
 	int dir	 = _IOC_DIR(cmd),
@@ -91,7 +102,8 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 			      { .type	= 'A', .scnprintf = ioctl__scnprintf_sndrv_pcm_cmd, },
 		['T' - 'A']=  { .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, },
 		['U' - 'A']=  { .type	= 'U', .scnprintf = ioctl__scnprintf_sndrv_ctl_cmd, },
-		['d' - 'A'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, }
+		['d' - 'A'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, },
+		[0xAE - 'A'] = { .type	= 0xAE, .scnprintf = ioctl__scnprintf_kvm_cmd, },
 	};
 	const int nr_types = ARRAY_SIZE(ioctl_types);
 
diff --git a/tools/perf/trace/beauty/kvm_ioctl.sh b/tools/perf/trace/beauty/kvm_ioctl.sh
new file mode 100755
index 000000000000..bd28817afced
--- /dev/null
+++ b/tools/perf/trace/beauty/kvm_ioctl.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+kvm_header_dir=$1
+
+printf "static const char *kvm_ioctl_cmds[] = {\n"
+regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
+egrep $regex ${kvm_header_dir}/kvm.h	| \
+	sed -r "s/$regex/\2 \1/g"	| \
+	egrep -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.9.4
