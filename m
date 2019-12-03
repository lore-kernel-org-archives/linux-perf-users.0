From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/23] tools arch x86: Sync asm/cpufeatures.h with the kernel sources
Date: Tue,  3 Dec 2019 10:56:03 -0300
Message-ID: <20191203135606.24902-21-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Vineela Tummalapalli <vineela.tummalapalli@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  a25bbc2644f0 ("Merge branches 'x86-cpu-for-linus' and 'x86-fpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
  db4d30fbb71b ("x86/bugs: Add ITLB_MULTIHIT bug infrastructure")
  1b42f017415b ("x86/speculation/taa: Add mitigation for TSX Async Abort")
  9d40b85bb46a ("x86/cpufeatures: Add feature bit RDPRU on AMD")

These don't cause any changes in tooling, just silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
Link: https://lkml.kernel.org/n/tip-yufg9yt2nbkh45r9xvxnnscq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 0652d3eed9bd..e9b62498fe75 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -292,6 +292,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_RDPRU		(13*32+ 4) /* Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
@@ -399,5 +400,7 @@
 #define X86_BUG_MDS			X86_BUG(19) /* CPU is affected by Microarchitectural data sampling */
 #define X86_BUG_MSBDS_ONLY		X86_BUG(20) /* CPU is only affected by the  MSDBS variant of BUG_MDS */
 #define X86_BUG_SWAPGS			X86_BUG(21) /* CPU is affected by speculation through SWAPGS */
+#define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
+#define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.21.0
