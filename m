From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/63] perf beauty: Wire up the renameat flags table generator to the Makefile
Date: Tue, 18 Dec 2018 19:06:40 -0300
Message-ID: <20181218220733.15839-11-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:

  $ cat /tmp/build/perf/trace/beauty/generated/rename_flags_array.c
  static const char *rename_flags[] = {
	[0 + 1] = "NOREPLACE",
	[1 + 1] = "EXCHANGE",
	[2 + 1] = "WHITEOUT",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4fad4xahrn04y06o0lc49clm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bfdaefd500ab..22956a85e4c6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -490,6 +490,12 @@ prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
 
+rename_flags_array := $(beauty_outdir)/rename_flags_array.c
+rename_flags_tbl := $(srctree)/tools/perf/trace/beauty/rename_flags.sh
+
+$(rename_flags_array): $(linux_uapi_dir)/fs.h $(rename_flags_tbl)
+	$(Q)$(SHELL) '$(rename_flags_tbl)' $(linux_uapi_dir) > $@
+
 arch_errno_name_array := $(beauty_outdir)/arch_errno_name_array.c
 arch_errno_hdr_dir := $(srctree)/tools
 arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
@@ -604,6 +610,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
+	$(rename_flags_array) \
 	$(arch_errno_name_array)
 
 $(OUTPUT)%.o: %.c prepare FORCE
@@ -900,6 +907,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
+		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 
-- 
2.19.2
