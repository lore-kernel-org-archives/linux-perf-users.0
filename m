From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/18] perf trace beautify ioctl: Beautify sound ioctl's 'cmd' arg
Date: Tue,  1 Aug 2017 16:56:39 -0300
Message-ID: <20170801195645.16986-13-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This time we try a new approach, using a copy of uapi/sound/asound.h we
auto generate the string tables, then include it in the ioctl cmd
beautifier.

This way either the sound developers will add the new commands to the
tools/ copy, like is happening with other areas of tools/include/ (bpf.h
comes to mind), or we'll be notified when building perf that our copy
drifted.

E.g.:

  # perf trace -p 22084 -e ioctl 2>&1 | head -5
     0.000 ( 0.068 ms): alsa-sink-ALC3/22084 ioctl(fd: 49</dev/snd/pcmC1D0p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x557f8d7fa0f0) = 0
     0.344 ( 0.041 ms): alsa-sink-ALC3/22084 ioctl(fd: 46</dev/snd/controlC1>, cmd: SNDRV_CTL_ELEM_READ, arg: 0x7fe764018ee0) = 0
     0.403 ( 0.011 ms): alsa-sink-ALC3/22084 ioctl(fd: 49</dev/snd/pcmC1D0p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x557f8d7fa0f0) = 0
     0.427 ( 0.009 ms): alsa-sink-ALC3/22084 ioctl(fd: 49</dev/snd/pcmC1D0p>, cmd: SNDRV_PCM_STATUS_EXT, arg: 0x7fe76c2e0b30) = 0
     2.461 ( 0.042 ms): alsa-sink-ALC3/22084 ioctl(fd: 49</dev/snd/pcmC1D0p>, cmd: SNDRV_PCM_HWSYNC, arg: 0x557f8d7fa0f0) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-8zuyf3e3u6jjcb2xzerw0kdi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                   | 26 +++++++++++++++++++++-----
 tools/perf/trace/beauty/ioctl.c            | 28 ++++++++++++++++++++++++++--
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh |  8 ++++++++
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh |  8 ++++++++
 4 files changed, 63 insertions(+), 7 deletions(-)
 create mode 100755 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
 create mode 100755 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 78654995b99f..d49354d340fd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -381,17 +381,31 @@ export INSTALL SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
-drm_ioctl_outdir := $(OUTPUT)trace/beauty/generated/ioctl
-drm_ioctl_array := $(drm_ioctl_outdir)/drm_ioctl_array.c
+beauty_ioctl_outdir := $(OUTPUT)trace/beauty/generated/ioctl
+drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
 drm_hdr_dir := $(srctree)/tools/include/uapi/drm
 drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(drm_ioctl_outdir)' ] || mkdir -p '$(drm_ioctl_outdir)')
+_dummy := $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
 
 $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
 	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
 
+sndrv_ctl_ioctl_array := $(beauty_ioctl_outdir)/sndrv_ctl_ioctl_array.c
+sndrv_ctl_hdr_dir := $(srctree)/tools/include/uapi/sound
+sndrv_ctl_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
+
+$(sndrv_ctl_ioctl_array): $(sndrv_ctl_hdr_dir)/asound.h $(sndrv_ctl_ioctl_tbl)
+	$(Q)$(SHELL) '$(sndrv_ctl_ioctl_tbl)' $(sndrv_ctl_hdr_dir) > $@
+
+sndrv_pcm_ioctl_array := $(beauty_ioctl_outdir)/sndrv_pcm_ioctl_array.c
+sndrv_pcm_hdr_dir := $(srctree)/tools/include/uapi/sound
+sndrv_pcm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
+
+$(sndrv_pcm_ioctl_array): $(sndrv_pcm_hdr_dir)/asound.h $(sndrv_pcm_ioctl_tbl)
+	$(Q)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(sndrv_pcm_hdr_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
@@ -486,7 +500,7 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
-prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array)
+prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) $(sndrv_pcm_ioctl_array) $(sndrv_ctl_ioctl_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -752,7 +766,9 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
-		$(OUTPUT)$(drm_ioctl_array)
+		$(OUTPUT)$(drm_ioctl_array) \
+		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
+		$(OUTPUT)$(sndrv_pcm_ioctl_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
 
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 732489d141c4..ec5a5a499667 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -55,6 +55,28 @@ static size_t ioctl__scnprintf_drm_cmd(int nr, char *bf, size_t size)
 	return scnprintf(bf, size, "(%#x, %#x)", 'd', nr);
 }
 
+static size_t ioctl__scnprintf_sndrv_pcm_cmd(int nr, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/sndrv_pcm_ioctl_array.c"
+	static DEFINE_STRARRAY(sndrv_pcm_ioctl_cmds);
+
+	if (nr < strarray__sndrv_pcm_ioctl_cmds.nr_entries && strarray__sndrv_pcm_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "SNDRV_PCM_%s", strarray__sndrv_pcm_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%#x, %#x)", 'A', nr);
+}
+
+static size_t ioctl__scnprintf_sndrv_ctl_cmd(int nr, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/sndrv_ctl_ioctl_array.c"
+	static DEFINE_STRARRAY(sndrv_ctl_ioctl_cmds);
+
+	if (nr < strarray__sndrv_ctl_ioctl_cmds.nr_entries && strarray__sndrv_ctl_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "SNDRV_CTL_%s", strarray__sndrv_ctl_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%#x, %#x)", 'U', nr);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 {
 	int dir	 = _IOC_DIR(cmd),
@@ -66,8 +88,10 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 		int	type;
 		size_t	(*scnprintf)(int nr, char *bf, size_t size);
 	} ioctl_types[] = { /* Must be ordered by type */
-			      { .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, },
-		['d' - 'T'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, }
+			      { .type	= 'A', .scnprintf = ioctl__scnprintf_sndrv_pcm_cmd, },
+		['T' - 'A']=  { .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, },
+		['U' - 'A']=  { .type	= 'U', .scnprintf = ioctl__scnprintf_sndrv_ctl_cmd, },
+		['d' - 'A'] = { .type	= 'd', .scnprintf = ioctl__scnprintf_drm_cmd, }
 	};
 	const int nr_types = ARRAY_SIZE(ioctl_types);
 
diff --git a/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
new file mode 100755
index 000000000000..aad5ab130539
--- /dev/null
+++ b/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+sound_header_dir=$1
+
+printf "static const char *sndrv_ctl_ioctl_cmds[] = {\n"
+grep "^#define[\t ]\+SNDRV_CTL_IOCTL_" $sound_header_dir/asound.h | \
+	sed -r 's/^#define +SNDRV_CTL_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.U., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
+printf "};\n"
diff --git a/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
new file mode 100755
index 000000000000..b7e9ef6b2f55
--- /dev/null
+++ b/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+sound_header_dir=$1
+
+printf "static const char *sndrv_pcm_ioctl_cmds[] = {\n"
+grep "^#define[\t ]\+SNDRV_PCM_IOCTL_" $sound_header_dir/asound.h | \
+	sed -r 's/^#define +SNDRV_PCM_IOCTL_([A-Z0-9_]+)[\t ]+_IO[RW]*\( *.A., *(0x[[:xdigit:]]+),?.*/\t[\2] = \"\1\",/g'
+printf "};\n"
-- 
2.9.4
