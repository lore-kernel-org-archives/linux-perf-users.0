From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/29] perf trace: Wire up ioctl's USBDEBFS_ cmd table generator
Date: Thu,  3 Jan 2019 09:45:53 -0300
Message-ID: <20190103124609.29672-14-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That ends up generating this:

  [acme@quaco perf]$ cat /tmp/build/perf/trace/beauty/generated/ioctl/usbdevfs_ioctl_array.c
  static const char *usbdevfs_ioctl_cmds[] = {
	[0] = "CONTROL",
	[10] = "SUBMITURB",
	[11] = "DISCARDURB",
	[12] = "REAPURB",
	[13] = "REAPURBNDELAY",
	[14] = "DISCSIGNAL",
	[15] = "CLAIMINTERFACE",
	[16] = "RELEASEINTERFACE",
	[17] = "CONNECTINFO",
	[18] = "IOCTL",
	[19] = "HUB_PORTINFO",
	[2] = "BULK",
	[20] = "RESET",
	[21] = "CLEAR_HALT",
	[22] = "DISCONNECT",
	[23] = "CONNECT",
	[24] = "CLAIM_PORT",
	[25] = "RELEASE_PORT",
	[26] = "GET_CAPABILITIES",
	[27] = "DISCONNECT_CLAIM",
	[28] = "ALLOC_STREAMS",
	[29] = "FREE_STREAMS",
	[3] = "RESETEP",
	[30] = "DROP_PRIVILEGES",
	[31] = "GET_SPEED",
	[4] = "SETINTERFACE",
	[5] = "SETCONFIGURATION",
	[8] = "GETDRIVER",
  };

  #if 0
  static const char *usbdevfs_ioctl_32_cmds[] = {
	[0] = "CONTROL32",
	[10] = "SUBMITURB32",
	[12] = "REAPURB32",
	[13] = "REAPURBNDELAY32",
	[14] = "DISCSIGNAL32",
	[18] = "IOCTL32",
	[2] = "BULK32",
  };
  #endif
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hkam6lt1g806l0p4b7buif3n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bd23e3f30895..ff29c3372ec3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -497,6 +497,12 @@ prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
 $(prctl_option_array): $(prctl_hdr_dir)/prctl.h $(prctl_option_tbl)
 	$(Q)$(SHELL) '$(prctl_option_tbl)' $(prctl_hdr_dir) > $@
 
+usbdevfs_ioctl_array := $(beauty_ioctl_outdir)/usbdevfs_ioctl_array.c
+usbdevfs_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+
+$(usbdevfs_ioctl_array): $(linux_uapi_dir)/usbdevice_fs.h $(usbdevfs_ioctl_tbl)
+	$(Q)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(linux_uapi_dir) > $@
+
 x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
 x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
 
@@ -624,6 +630,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
+	$(usbdevfs_ioctl_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
 	$(arch_errno_name_array)
@@ -923,6 +930,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(vhost_virtio_ioctl_array) \
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
+		$(OUTPUT)$(usbdevfs_ioctl_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array)
-- 
2.19.2
