From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/18] tools headers: Sync cpu features kernel ABI headers with tooling headers
Date: Tue, 29 Aug 2017 16:42:51 -0300
Message-ID: <20170829194254.1338-16-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, David Ahern <dsahern@gmail.com>, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These changes made the tools/arch/x86/include/ headers to drift from its
kernel origins:

  910448bbed06 ("perf/x86/amd/uncore: Rename cpufeatures macro for cache counters")
  5442c2699552 ("x86/cpufeature, kvm/svm: Rename (shorten) the new "virtualized VMSAVE/VMLOAD" CPUID flag")
  cba4671af755 ("x86/mm: Disable PCID on 32-bit kernels")

Which was detected while building perf:

  make: Entering directory '/home/acme/git/linux/tools/perf'
    BUILD:   Doing 'make -j4' parallel build
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'

This sync causes just these perf object files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And the changes in the above changesets don't entail any need for change
in the above 'perf bench' files.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Ahern <dsahern@gmail.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-456aafouj911a4x4zwt8stkm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h       | 5 ++---
 tools/arch/x86/include/asm/disabled-features.h | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 14f0f2913364..8ea315a11fe0 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -177,7 +177,7 @@
 #define X86_FEATURE_PERFCTR_NB  ( 6*32+24) /* NB performance counter extensions */
 #define X86_FEATURE_BPEXT	(6*32+26) /* data breakpoint extension */
 #define X86_FEATURE_PTSC	( 6*32+27) /* performance time-stamp counter */
-#define X86_FEATURE_PERFCTR_L2	( 6*32+28) /* L2 performance counter extensions */
+#define X86_FEATURE_PERFCTR_LLC	( 6*32+28) /* Last Level Cache performance counter extensions */
 #define X86_FEATURE_MWAITX	( 6*32+29) /* MWAIT extension (MONITORX/MWAITX) */
 
 /*
@@ -196,7 +196,6 @@
 
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
-#define X86_FEATURE_SME		( 7*32+10) /* AMD Secure Memory Encryption */
 
 #define X86_FEATURE_INTEL_PPIN	( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
@@ -287,7 +286,7 @@
 #define X86_FEATURE_PAUSEFILTER (15*32+10) /* filtered pause intercept */
 #define X86_FEATURE_PFTHRESHOLD (15*32+12) /* pause filter threshold */
 #define X86_FEATURE_AVIC	(15*32+13) /* Virtual Interrupt Controller */
-#define X86_FEATURE_VIRTUAL_VMLOAD_VMSAVE (15*32+15) /* Virtual VMLOAD VMSAVE */
+#define X86_FEATURE_V_VMSAVE_VMLOAD (15*32+15) /* Virtual VMSAVE VMLOAD */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx), word 16 */
 #define X86_FEATURE_AVX512VBMI  (16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index c10c9128f54e..5dff775af7cd 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -21,13 +21,11 @@
 # define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
 # define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
 # define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
-# define DISABLE_PCID		0
 #else
 # define DISABLE_VME		0
 # define DISABLE_K6_MTRR	0
 # define DISABLE_CYRIX_ARR	0
 # define DISABLE_CENTAUR_MCR	0
-# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
@@ -51,7 +49,7 @@
 #define DISABLED_MASK1	0
 #define DISABLED_MASK2	0
 #define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	(DISABLE_PCID)
+#define DISABLED_MASK4	0
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	0
-- 
2.13.5
