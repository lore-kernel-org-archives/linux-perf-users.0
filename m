From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/27] tools headers: Synchronize kernel <-> tooling headers
Date: Wed, 10 Jan 2018 18:28:44 -0300
Message-ID: <20180110212844.12441-28-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753997AbeAJVaP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Jan 2018 16:30:15 -0500
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Two kernel headers got modified recently due to meltdown/spectre, in:

  a89f040fa34e ("x86/cpufeatures: Add X86_BUG_CPU_INSECURE")

which are used by tooling as well:

  arch/x86/include/asm/cpufeatures.h
  arch/x86/include/asm/disabled-features.h

None of those changes have an effect on tooling, so do a plain copy.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qqzcs8ri3vks8cypg0puk0ae@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h       | 4 +++-
 tools/arch/x86/include/asm/disabled-features.h | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 800104c8a3ed..21ac898df2d8 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -197,11 +197,12 @@
 #define X86_FEATURE_CAT_L3		( 7*32+ 4) /* Cache Allocation Technology L3 */
 #define X86_FEATURE_CAT_L2		( 7*32+ 5) /* Cache Allocation Technology L2 */
 #define X86_FEATURE_CDP_L3		( 7*32+ 6) /* Code and Data Prioritization L3 */
+#define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_SME			( 7*32+10) /* AMD Secure Memory Encryption */
-
+#define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_INTEL_PT		( 7*32+15) /* Intel Processor Trace */
 #define X86_FEATURE_AVX512_4VNNIW	( 7*32+16) /* AVX-512 Neural Network Instructions */
@@ -340,5 +341,6 @@
 #define X86_BUG_SWAPGS_FENCE		X86_BUG(11) /* SWAPGS without input dep on GS */
 #define X86_BUG_MONITOR			X86_BUG(12) /* IPI required to wake up remote CPU */
 #define X86_BUG_AMD_E400		X86_BUG(13) /* CPU is among the affected by Erratum 400 */
+#define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown attack and needs kernel page table isolation */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 14d6d5007314..b027633e7300 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -50,6 +50,12 @@
 # define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+# define DISABLE_PTI		0
+#else
+# define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -60,7 +66,7 @@
 #define DISABLED_MASK4	(DISABLE_PCID)
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
-#define DISABLED_MASK7	0
+#define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
 #define DISABLED_MASK9	(DISABLE_MPX)
 #define DISABLED_MASK10	0
-- 
2.14.3
