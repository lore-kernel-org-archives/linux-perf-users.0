From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/26] tools arch x86: Sync the msr-index.h copy with the kernel sources
Date: Mon, 13 Apr 2020 13:51:41 -0300
Message-ID: <20200413165203.1816-5-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Which causes these changes in tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2020-04-01 12:11:14.789344795 -0300
  +++ after	2020-04-01 12:11:56.907798879 -0300
  @@ -10,6 +10,7 @@
   	[0x00000029] = "KNC_EVNTSEL1",
   	[0x0000002a] = "IA32_EBL_CR_POWERON",
   	[0x0000002c] = "EBC_FREQUENCY_ID",
  +	[0x00000033] = "TEST_CTRL",
   	[0x00000034] = "SMI_COUNT",
   	[0x0000003a] = "IA32_FEAT_CTL",
   	[0x0000003b] = "IA32_TSC_ADJUST",
  @@ -27,6 +28,7 @@
   	[0x000000c2] = "IA32_PERFCTR1",
   	[0x000000cd] = "FSB_FREQ",
   	[0x000000ce] = "PLATFORM_INFO",
  +	[0x000000cf] = "IA32_CORE_CAPS",
   	[0x000000e2] = "PKG_CST_CONFIG_CONTROL",
   	[0x000000e7] = "IA32_MPERF",
   	[0x000000e8] = "IA32_APERF",
  $

  $ make -C tools/perf O=/tmp/build/perf install-bin
  <SNIP>
    CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
    LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
    LD       /tmp/build/perf/trace/beauty/perf-in.o
    LD       /tmp/build/perf/perf-in.o
    LINK     /tmp/build/perf/perf
  <SNIP>

Now one can do:

	perf trace -e msr:* --filter=msr==IA32_CORE_CAPS

or:

	perf trace -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'

And see only those MSRs being accessed via:

  # perf trace -v -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'
  New filter for msr:read_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:write_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:rdpmc: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20200401153325.GC12534@kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index d5e517d1c3dd..12c9684d59ba 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -41,6 +41,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTRL				0x00000033
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
@@ -70,6 +74,11 @@
  */
 #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
 
+/* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
+#define MSR_IA32_CORE_CAPS			  0x000000cf
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
-- 
2.21.1
