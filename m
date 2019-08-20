From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/17] tools arch x86: Sync asm/cpufeatures.h with the with the kernel
Date: Tue, 20 Aug 2019 16:27:21 -0300
Message-ID: <20190820192733.19180-6-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  f36cf386e3fe ("x86/speculation/swapgs: Exclude ATOMs from speculation through SWAPGS")
  18ec54fdd6d1 ("x86/speculation: Prepare entry code for Spectre v1 swapgs mitigations")

That don't affect anything in tools/.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/n/tip-860dq1qie2cpnfghlpcnxrzr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 998c2cc08363..e880f2408e29 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -281,6 +281,8 @@
 #define X86_FEATURE_CQM_OCCUP_LLC	(11*32+ 1) /* LLC occupancy monitoring */
 #define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
 #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
+#define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
+#define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
@@ -394,5 +396,6 @@
 #define X86_BUG_L1TF			X86_BUG(18) /* CPU is affected by L1 Terminal Fault */
 #define X86_BUG_MDS			X86_BUG(19) /* CPU is affected by Microarchitectural data sampling */
 #define X86_BUG_MSBDS_ONLY		X86_BUG(20) /* CPU is only affected by the  MSDBS variant of BUG_MDS */
+#define X86_BUG_SWAPGS			X86_BUG(21) /* CPU is affected by speculation through SWAPGS */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.21.0
