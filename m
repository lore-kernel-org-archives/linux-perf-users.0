From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/18] perf trace beauty ioctl: Beautify DRM ioctl cmds
Date: Tue,  1 Aug 2017 16:56:37 -0300
Message-ID: <20170801195645.16986-11-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This time we try a new approach, using uapi/drm/ copies of drm.h and
i915_drm.h we auto generate the string tables, then include it in the
ioctl cmd beautifier.

This way either the DRM developers will add the new commands to the
tools/ copy, like is happening with other areas of tools/include/ (bpf.h
comes to mind), or we'll be notified when building perf that our copy
drifted.

Either way the time from a new command being added to when 'perf trace'
gets to know it is greatly shortened, for instance:

  # strace -p 22401 -e ioctl
  ioctl(8, DRM_IOCTL_I915_GEM_BUSY, 0x7ffc934f7600) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_SET_DOMAIN, 0x7ffc934f7550) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_SW_FINISH, 0x7ffc934f76e0) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_SW_FINISH, 0x7ffc934f7780) = 0
  ioctl(8, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x69, 0x40), 0x7ffc934f7700) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_SET_DOMAIN, 0x7ffc934f7780) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_MADVISE, 0x7ffc934f76f0) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_BUSY, 0x7ffc934f76c0) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_MADVISE, 0x7ffc934f76b0) = 0
  ioctl(8, DRM_IOCTL_I915_GEM_SET_DOMAIN, 0x7ffc934f76d0) = 0
  ioctl(8, DRM_IOCTL_MODE_ADDFB, 0x7ffc934f7880) = 0
  ioctl(8, DRM_IOCTL_MODE_PAGE_FLIP, 0x7ffc934f77d0) = 0
  ^Cstrace: Process 22401 detached

versus:

  # perf trace -p 22401 -e ioctl
  1010.856 (0.006 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7ffc934f7600) = 0
  1010.865 (0.003 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_SET_DOMAIN, arg: 0x7ffc934f7550) = 0
  1010.872 (0.002 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_SW_FINISH, arg: 0x7ffc934f76e0) = 0
  1010.939 (0.015 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_SW_FINISH, arg: 0x7ffc934f7780) = 0
  1010.959 (0.085 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_EXECBUFFER2, arg: 0x7ffc934f7700) = 0
  1011.048 (0.003 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_SET_DOMAIN, arg: 0x7ffc934f7780) = 0
  1011.056 (0.002 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_MADVISE, arg: 0x7ffc934f76f0) = 0
  1011.060 (0.002 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7ffc934f76c0) = 0
  1011.064 (0.003 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_MADVISE, arg: 0x7ffc934f76b0) = 0
  1011.068 (0.002 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_SET_DOMAIN, arg: 0x7ffc934f76d0) = 0
  1011.074 (0.009 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_MODE_ADDFB, arg: 0x7ffc934f7880 ) = 0
  1011.096 (0.072 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_MODE_PAGE_FLIP, arg: 0x7ffc934f77d0) = 0
^C[root@jouet linux]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-mly2d7v9kf28rso81dijbixq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf             | 16 ++++++++++++++--
 tools/perf/trace/beauty/drm_ioctl.sh | 13 +++++++++++++
 tools/perf/trace/beauty/ioctl.c      | 14 +++++++++++++-
 3 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100755 tools/perf/trace/beauty/drm_ioctl.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d66f90e6be5c..78654995b99f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -381,6 +381,17 @@ export INSTALL SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
+drm_ioctl_outdir := $(OUTPUT)trace/beauty/generated/ioctl
+drm_ioctl_array := $(drm_ioctl_outdir)/drm_ioctl_array.c
+drm_hdr_dir := $(srctree)/tools/include/uapi/drm
+drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(drm_ioctl_outdir)' ] || mkdir -p '$(drm_ioctl_outdir)')
+
+$(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
+	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -475,7 +486,7 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
-prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders
+prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -740,7 +751,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)pmu-events/pmu-events.c
+		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)$(drm_ioctl_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
 
diff --git a/tools/perf/trace/beauty/drm_ioctl.sh b/tools/perf/trace/beauty/drm_ioctl.sh
new file mode 100755
index 000000000000..2149d3a98e42
--- /dev/null
+++ b/tools/perf/trace/beauty/drm_ioctl.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+drm_header_dir=$1
+printf "#ifndef DRM_COMMAND_BASE\n"
+grep "#define DRM_COMMAND_BASE" $drm_header_dir/drm.h
+printf "#endif\n"
+
+printf "static const char *drm_ioctl_cmds[] = {\n"
+grep "^#define DRM_IOCTL.*DRM_IO" $drm_header_dir/drm.h | \
+	sed -r 's/^#define +DRM_IOCTL_([A-Z0-9_]+)[	 ]+DRM_IO[A-Z]* *\( *(0x[[:xdigit:]]+),*.*/	[\2] = "\1",/g'
+grep "^#define DRM_I915_[A-Z_0-9]\+[	 ]\+0x" $drm_header_dir/i915_drm.h | \
+	sed -r 's/^#define +DRM_I915_([A-Z0-9_]+)[	 ]+(0x[[:xdigit:]]+)/\t[DRM_COMMAND_BASE + \2] = "I915_\1",/g'
+printf "};\n"
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 5f0dba8aaa88..732489d141c4 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -44,6 +44,17 @@ static size_t ioctl__scnprintf_tty_cmd(int nr, char *bf, size_t size)
 	return scnprintf(bf, size, "(%#x, %#x)", 'T', nr);
 }
 
+static size_t ioctl__scnprintf_drm_cmd(int nr, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/drm_ioctl_array.c"
+	static DEFINE_STRARRAY(drm_ioctl_cmds);
+
+	if (nr < strarray__drm_ioctl_cmds.nr_entries && strarray__drm_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "DRM_%s", strarray__drm_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%#x, %#x)", 'd', nr);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 {
 	int dir	 = _IOC_DIR(cmd),
@@ -55,7 +66,8 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 		int	type;
 		size_t	(*scnprintf)(int nr, char *bf, size_t size);
 	} ioctl_types[] = { /* Must be ordered by type */
-		{ .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, }
+			      { .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, },
+		['d' - 'T'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, }
 	};
 	const int nr_types = ARRAY_SIZE(ioctl_types);
 
-- 
2.9.4
