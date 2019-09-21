From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/10] tools headers uapi: Sync prctl.h with the kernel sources
Date: Sat, 21 Sep 2019 09:42:32 -0300
Message-ID: <20190921124240.15741-3-acme@kernel.org>
References: <20190921124240.15741-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Will Deacon <will@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")

that introduces prctl options that then automagically gets catched by
the prctl cmd table generator, and thus supported in the 'perf trace'
prctl beautifier for the 'option' argument:

  $ tools/perf/trace/beauty/prctl_option.sh  > after
  $ diff -u before after
  --- before	2019-09-20 14:38:41.386720870 -0300
  +++ after	2019-09-20 14:40:02.583990802 -0300
  @@ -49,6 +49,8 @@
   	[52] = "GET_SPECULATION_CTRL",
   	[53] = "SET_SPECULATION_CTRL",
   	[54] = "PAC_RESET_KEYS",
  +	[55] = "SET_TAGGED_ADDR_CTRL",
  +	[56] = "GET_TAGGED_ADDR_CTRL",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

For now just the translation of 55 and 56 to the respecting strings are
done, more work needed to allow for filters to be used using strings.

This, for instance, already works:

  # perf record -e syscalls:sys_enter_close --filter="fd==4"
  # perf script | head -5
               gpm  1018 [006] 21327.171436: syscalls:sys_enter_close: fd: 0x00000004
               gpm  1018 [006] 21329.171583: syscalls:sys_enter_close: fd: 0x00000004
              bash  4882 [002] 21330.785496: syscalls:sys_enter_close: fd: 0x00000004
              bash 20672 [001] 21330.785719: syscalls:sys_enter_close: fd: 0x00000004
              find 20672 [001] 21330.789082: syscalls:sys_enter_close: fd: 0x00000004
  # perf record -e syscalls:sys_enter_close --filter="fd>=4"
  ^C[ perf record: Woken up 1 times to write data ]
  # perf script | head -5
               gpm  1018 [005] 21401.178501: syscalls:sys_enter_close: fd: 0x00000004
   gsd-housekeepin  2287 [006] 21402.225365: syscalls:sys_enter_close: fd: 0x0000000b
   gsd-housekeepin  2287 [006] 21402.226234: syscalls:sys_enter_close: fd: 0x0000000b
   gsd-housekeepin  2287 [006] 21402.227255: syscalls:sys_enter_close: fd: 0x0000000b
   gsd-housekeepin  2287 [006] 21402.228088: syscalls:sys_enter_close: fd: 0x0000000b
  #

Being able to pass something like:

  # perf record -e syscalls:sys_enter_prctl --filter="option=*TAGGED_ADDR*"

Should be easy enough, first using tracepoint filters, then via the
augmented_raw_syscalls.c BPF method.

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
  diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-y8u8kvflooyo9x0if1g3jska@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 094bb03b9cc2..7da1b37b27aa 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -181,7 +181,7 @@ struct prctl_mm_map {
 #define PR_GET_THP_DISABLE	42
 
 /*
- * Tell the kernel to start/stop helping userspace manage bounds tables.
+ * No longer implemented, but left here to ensure the numbers stay reserved:
  */
 #define PR_MPX_ENABLE_MANAGEMENT  43
 #define PR_MPX_DISABLE_MANAGEMENT 44
@@ -229,4 +229,9 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* Tagged user address controls for arm64 */
+#define PR_SET_TAGGED_ADDR_CTRL		55
+#define PR_GET_TAGGED_ADDR_CTRL		56
+# define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.21.0
