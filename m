From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 61/63] perf trace: Wire up the fadvise 'advice' table generator
Date: Tue, 18 Dec 2018 19:07:31 -0300
Message-ID: <20181218220733.15839-62-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That ends up generating this:

  $ cat /tmp/build/perf/trace/beauty/generated/fadvise_advice_array.c
  static const char *fadvise_advices[] = {
	[0] = "NORMAL",
	[1] = "RANDOM",
	[2] = "SEQUENTIAL",
	[3] = "WILLNEED",
	[4] = "DONTNEED",
	[5] = "NOREUSE",
  };
$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zwbslubagram8a8zdc003u8h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3af432bccd3e..bd23e3f30895 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -410,6 +410,12 @@ _dummy := $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_ou
 $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
 	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
 
+fadvise_advice_array := $(beauty_outdir)/fadvise_advice_array.c
+fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
+
+$(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
+	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(linux_uapi_dir) > $@
+
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
 asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
 pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -605,6 +611,7 @@ __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
+	$(fadvise_advice_array) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
@@ -902,6 +909,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
 		$(OUTPUT)$(mount_flags_array) \
-- 
2.19.2
