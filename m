From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/10] tools arch x86: Sync asm/cpufeatures.h with the kernel sources
Date: Sat, 21 Sep 2019 09:42:35 -0300
Message-ID: <20190921124240.15741-6-acme@kernel.org>
References: <20190921124240.15741-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@suse.de>, Gayatri Kammela <gayatri.kammela@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  b4dd4f6e3648 ("x86/vmware: Add a header file for hypercall definitions")
  f36cf386e3fe ("x86/speculation/swapgs: Exclude ATOMs from speculation through SWAPGS")
  be261ffce6f1 ("x86: Remove X86_FEATURE_MFENCE_RDTSC")
  018ebca8bd70 ("x86/cpufeatures: Enable a new AVX512 CPU feature")

These don't cause any changes in tooling, just silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

To clarify, updating those files cause these bits of tools/perf to rebuild:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
  INSTALL  GTK UI
  LD       /tmp/build/perf/bench/perf-in.o

Those use just:

  $ grep FEATURE tools/arch/x86/lib/mem*.S
  tools/arch/x86/lib/memcpy_64.S:	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
  tools/arch/x86/lib/memcpy_64.S:		      "jmp memcpy_erms", X86_FEATURE_ERMS
  tools/arch/x86/lib/memset_64.S:	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
  tools/arch/x86/lib/memset_64.S:		      "jmp memset_erms", X86_FEATURE_ERMS
  $

I.e. none of the feature defines added/removed by the patches above.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Gayatri Kammela <gayatri.kammela@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Link: https://lkml.kernel.org/n/tip-pq63abgknsaeov23p80d8gjv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 5171b9c7ca3e..0652d3eed9bd 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -231,6 +231,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
+#define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
+#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
@@ -354,6 +356,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
-- 
2.21.0
