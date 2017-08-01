From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/18] perf trace beautify ioctl: Beautify perf ioctl's 'cmd' arg
Date: Tue,  1 Aug 2017 16:56:45 -0300
Message-ID: <20170801195645.16986-19-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Also trying a new approach, using the copy of uapi/linux/perf_event.h we
auto generate the string tables, then include it in the ioctl cmd
beautifier.

This way either the perf developers will add the new commands to the
tools/ copy, like is happening with other areas of tools/include/ (bpf.h
comes to mind), or we'll be notified when building perf that our copy
drifted.

E.g., looking at some of the perf ioctls issued by the 'perf test' test cases:

  # (perf trace -e perf_event_open,ioctl perf test)  2>&1 | egrep "(cmd: PERF_|perf_event_open)"
  4: Read samples using the mmap interface      :
   348.811 ( 0.062 ms): perf/23351 perf_event_open(attr_uptr: 0x414a5e8, pid: 23351 (perf), group_fd: -1, flags: FD_CLOEXEC) = 3
   348.878 ( 0.039 ms): perf/23351 perf_event_open(attr_uptr: 0x414a5e8, pid: 23351 (perf), cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 4
   348.919 ( 0.036 ms): perf/23351 perf_event_open(attr_uptr: 0x414a5e8, pid: 23351 (perf), cpu: 2, group_fd: -1, flags: FD_CLOEXEC) = 5
   348.958 ( 0.036 ms): perf/23351 perf_event_open(attr_uptr: 0x414a5e8, pid: 23351 (perf), cpu: 3, group_fd: -1, flags: FD_CLOEXEC) = 6
   349.070 ( 0.046 ms): perf/23351 perf_event_open(attr_uptr: 0x414aa38, pid: 23351 (perf), group_fd: -1, flags: FD_CLOEXEC) = 7
   349.120 ( 0.037 ms): perf/23351 perf_event_open(attr_uptr: 0x414aa38, pid: 23351 (perf), cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 8
   349.161 ( 0.036 ms): perf/23351 perf_event_open(attr_uptr: 0x414aa38, pid: 23351 (perf), cpu: 2, group_fd: -1, flags: FD_CLOEXEC) = 9
   349.201 ( 0.035 ms): perf/23351 perf_event_open(attr_uptr: 0x414aa38, pid: 23351 (perf), cpu: 3, group_fd: -1, flags: FD_CLOEXEC) = 10
   349.306 ( 0.041 ms): perf/23351 perf_event_open(attr_uptr: 0x414b2d8, pid: 23351 (perf), group_fd: -1, flags: FD_CLOEXEC) = 11
   349.611 ( 0.005 ms): perf/23351 ioctl(fd: 3<anon_inode:[perf_event]>, cmd: PERF_ID, arg: 0x7fff025999b8) = 0
   349.619 ( 0.002 ms): perf/23351 ioctl(fd: 7<anon_inode:[perf_event]>, cmd: PERF_SET_OUTPUT, arg: 0x3  ) = 0
   349.623 ( 0.002 ms): perf/23351 ioctl(fd: 7<anon_inode:[perf_event]>, cmd: PERF_ID, arg: 0x7fff025999b8) = 0
   349.627 ( 0.002 ms): perf/23351 ioctl(fd: 11<anon_inode:[perf_event]>, cmd: PERF_SET_OUTPUT, arg: 0x3 ) = 0
   349.630 ( 0.001 ms): perf/23351 ioctl(fd: 11<anon_inode:[perf_event]>, cmd: PERF_ID, arg: 0x7fff025999b8) = 0
<SNIP>
  7: PERF_RECORD_* events & perf_sample fields  :
   647.150 ( 0.014 ms): perf/23354 perf_event_open(attr_uptr: 0x7fff02599920, pid: -1, cpu: 2, group_fd: -1, flags: FD_CLOEXEC) = 3
   647.197 ( 0.076 ms): perf/23354 perf_event_open(attr_uptr: 0x414b478, pid: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
   647.289 ( 0.040 ms): perf/23354 perf_event_open(attr_uptr: 0x414b478, pid: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
   647.368 ( 0.011 ms): perf/23354 perf_event_open(attr_uptr: 0x414a5e8, pid: 23355 (perf), group_fd: -1, flags: FD_CLOEXEC) = 3
   647.381 ( 0.005 ms): perf/23354 perf_event_open(attr_uptr: 0x414a5e8, pid: 23355 (perf), cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 4
   647.387 ( 0.005 ms): perf/23354 perf_event_open(attr_uptr: 0x414a5e8, pid: 23355 (perf), cpu: 2, group_fd: -1, flags: FD_CLOEXEC) = 5
   647.393 ( 0.004 ms): perf/23354 perf_event_open(attr_uptr: 0x414a5e8, pid: 23355 (perf), cpu: 3, group_fd: -1, flags: FD_CLOEXEC) = 7
   648.026 ( 0.011 ms): perf/23354 ioctl(fd: 3<anon_inode:[perf_event]>, cmd: PERF_ENABLE) = 0
   648.038 ( 0.002 ms): perf/23354 ioctl(fd: 4<anon_inode:[perf_event]>, cmd: PERF_ENABLE) = 0
   648.042 ( 0.002 ms): perf/23354 ioctl(fd: 5<anon_inode:[perf_event]>, cmd: PERF_ENABLE) = 0
   648.045 ( 0.002 ms): perf/23354 ioctl(fd: 7<anon_inode:[perf_event]>, cmd: PERF_ENABLE) = 0
<SNIP>
  18: Breakpoint overflow signal handler         :
  2772.721 ( 0.017 ms): perf/23375 perf_event_open(attr_uptr: 0x7fff02599d20, pid: -1, cpu: 3, group_fd: -1, flags: FD_CLOEXEC) = 3
  2772.748 ( 0.009 ms): perf/23375 perf_event_open(attr_uptr: 0x7fff02599e60, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
  2772.768 ( 0.002 ms): perf/23375 ioctl(fd: 3, cmd: PERF_RESET) = 0
  2772.776 ( 0.008 ms): perf/23375 perf_event_open(attr_uptr: 0x7fff02599e60, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4
  2772.788 ( 0.002 ms): perf/23375 ioctl(fd: 4, cmd: PERF_RESET) = 0
  2772.791 ( 0.006 ms): perf/23375 perf_event_open(attr_uptr: 0x7fff02599e60, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 5
  2772.800 ( 0.001 ms): perf/23375 ioctl(fd: 5, cmd: PERF_RESET) = 0
  2772.803 ( 0.005 ms): perf/23375 ioctl(fd: 3, cmd: PERF_ENABLE) = 0
  2772.810 ( 0.004 ms): perf/23375 ioctl(fd: 4, cmd: PERF_ENABLE) = 0
  2772.815 ( 0.004 ms): perf/23375 ioctl(fd: 5, cmd: PERF_ENABLE) = 0
<SNIP>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ahotwscqt080ae0ulu3zznh2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf              | 13 +++++++++++--
 tools/perf/trace/beauty/ioctl.c       | 24 ++++++++++++++++++------
 tools/perf/trace/beauty/perf_ioctl.sh | 10 ++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)
 create mode 100755 tools/perf/trace/beauty/perf_ioctl.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 606358d67f8a..c1f7884979e2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -420,6 +420,13 @@ vhost_virtio_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/vhost_virtio_ioctl.
 $(vhost_virtio_ioctl_array): $(vhost_virtio_hdr_dir)/vhost.h $(vhost_virtio_ioctl_tbl)
 	$(Q)$(SHELL) '$(vhost_virtio_ioctl_tbl)' $(vhost_virtio_hdr_dir) > $@
 
+perf_ioctl_array := $(beauty_ioctl_outdir)/perf_ioctl_array.c
+perf_hdr_dir := $(srctree)/tools/include/uapi/linux
+perf_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/perf_ioctl.sh
+
+$(perf_ioctl_array): $(perf_hdr_dir)/perf_event.h $(perf_ioctl_tbl)
+	$(Q)$(SHELL) '$(perf_ioctl_tbl)' $(perf_hdr_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -518,7 +525,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
 	$(kvm_ioctl_array) \
-	$(vhost_virtio_ioctl_array)
+	$(vhost_virtio_ioctl_array) \
+	$(perf_ioctl_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -788,7 +796,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
 		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
 		$(OUTPUT)$(kvm_ioctl_array) \
-		$(OUTPUT)$(vhost_virtio_ioctl_array)
+		$(OUTPUT)$(vhost_virtio_ioctl_array) \
+		$(OUTPUT)$(perf_ioctl_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
 
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 95434b27873d..1be3b4cf0827 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -101,6 +101,17 @@ static size_t ioctl__scnprintf_vhost_virtio_cmd(int nr, int dir, char *bf, size_
 	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAF, nr, dir);
 }
 
+static size_t ioctl__scnprintf_perf_cmd(int nr, int dir, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/perf_ioctl_array.c"
+	static DEFINE_STRARRAY(perf_ioctl_cmds);
+
+	if (nr < strarray__perf_ioctl_cmds.nr_entries && strarray__perf_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "PERF_%s", strarray__perf_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAE, nr, dir);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 {
 	int dir	 = _IOC_DIR(cmd),
@@ -112,12 +123,13 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 		int	type;
 		size_t	(*scnprintf)(int nr, int dir, char *bf, size_t size);
 	} ioctl_types[] = { /* Must be ordered by type */
-			      { .type	= 'A', .scnprintf = ioctl__scnprintf_sndrv_pcm_cmd, },
-		['T' - 'A']=  { .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, },
-		['U' - 'A']=  { .type	= 'U', .scnprintf = ioctl__scnprintf_sndrv_ctl_cmd, },
-		['d' - 'A'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, },
-		[0xAE - 'A'] = { .type	= 0xAE, .scnprintf = ioctl__scnprintf_kvm_cmd, },
-		[0xAF - 'A'] = { .type	= 0xAF, .scnprintf = ioctl__scnprintf_vhost_virtio_cmd, },
+			      { .type	= '$', .scnprintf = ioctl__scnprintf_perf_cmd, },
+		['A' - '$'] = { .type	= 'A', .scnprintf = ioctl__scnprintf_sndrv_pcm_cmd, },
+		['T' - '$'] = { .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, },
+		['U' - '$'] = { .type	= 'U', .scnprintf = ioctl__scnprintf_sndrv_ctl_cmd, },
+		['d' - '$'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, },
+		[0xAE - '$'] = { .type	= 0xAE, .scnprintf = ioctl__scnprintf_kvm_cmd, },
+		[0xAF - '$'] = { .type	= 0xAF, .scnprintf = ioctl__scnprintf_vhost_virtio_cmd, },
 	};
 	const int nr_types = ARRAY_SIZE(ioctl_types);
 
diff --git a/tools/perf/trace/beauty/perf_ioctl.sh b/tools/perf/trace/beauty/perf_ioctl.sh
new file mode 100755
index 000000000000..faea4237c793
--- /dev/null
+++ b/tools/perf/trace/beauty/perf_ioctl.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+header_dir=$1
+
+printf "static const char *perf_ioctl_cmds[] = {\n"
+regex='^#[[:space:]]*define[[:space:]]+PERF_EVENT_IOC_(\w+)[[:space:]]+_IO[RW]*[[:space:]]*\([[:space:]]*.\$.[[:space:]]*,[[:space:]]*([[:digit:]]+).*'
+egrep $regex ${header_dir}/perf_event.h	| \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.9.4
