Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C4C77B75
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjEFLGt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjEFLGs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:06:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B31038699
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:06:42 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8CxOurBNFZkjL0FAA--.9376S3;
        Sat, 06 May 2023 19:06:41 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD7+_NFZkZWxNAA--.10396S3;
        Sat, 06 May 2023 19:06:40 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 14/18] tools arch x86: Sync the cpufeatures with the kernel sources
Date:   Sat,  6 May 2023 19:06:11 +0800
Message-Id: <d0fdcea7eb8b37328fcbffdc11f8c9eeb1a8d456.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxD7+_NFZkZWxNAA--.10396S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ww18Gry3GF17Jw1kur4fuFg_yoW3Xry7pr
        yxKa93t3yrJa12kw4kJrWavrW5WF9Fkw1UGr1UWr13Z3W5Cw1ktr1I9F45CayDXw4xZ342
        gas8X3yqvrZ8urUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bkkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq6s0DMcIj6I8E
        87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjc
        xG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWx
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bVL0
        5UUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit 3d8f61bf8bcd69bc ("x86: KVM: Add common feature flag for AMD's
   PSFD")
  commit 3763bf58029f3459 ("x86/cpufeatures: Redefine synthetic virtual
   NMI bit as AMD's "real" vNMI")
  commit d1b5e84f943c7b5b ("x86/cpufeatures: Add CPU feature flags for
   shadow stacks")
  commit 6449dcb0cac73821 ("x86: CPUID and CR3/CR4 flags for Linear
   Address Masking")
  commit be8de49bea505e77 ("x86/speculation: Identify processors
   vulnerable to SMT RSB predictions")
  commit e7862eda309ecfcc ("x86/cpu: Support AMD Automatic IBRS")
  commit faabfcb194a8d068 ("x86/cpu, kvm: Add the SMM_CTL MSR not present
   feature")
  commit 5b909d4ae59aedc7 ("x86/cpu, kvm: Add the Null Selector Clears
   Base feature")
  commit 84168ae786f8a15a ("x86/cpu, kvm: Move X86_FEATURE_LFENCE_RDTSC
   to its native leaf")
  commit a9dc9ec5a1fafc3d ("x86/cpu, kvm: Add the NO_NESTED_DATA_BP
   feature")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h'
   differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm
   /cpufeatures.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/arch/x86/include/asm/cpufeatures.h | 28 +++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index b89005819cd5..d7215c8b7923 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -97,7 +97,7 @@
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-#define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
+/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
 #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
@@ -226,10 +226,9 @@
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
-#define X86_FEATURE_VNMI		( 8*32+ 1) /* Intel Virtual NMI */
-#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 2) /* Intel FlexPriority */
-#define X86_FEATURE_EPT			( 8*32+ 3) /* Intel Extended Page Table */
-#define X86_FEATURE_VPID		( 8*32+ 4) /* Intel Virtual Processor ID */
+#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* Intel FlexPriority */
+#define X86_FEATURE_EPT			( 8*32+ 2) /* Intel Extended Page Table */
+#define X86_FEATURE_VPID		( 8*32+ 3) /* Intel Virtual Processor ID */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
@@ -307,14 +306,22 @@
 #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
+#define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
+#define X86_FEATURE_USER_SHSTK		(11*32+23) /* Shadow stack support for user mode applications */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
+#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
+#define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
+#define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
+#define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
+#define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
@@ -331,6 +338,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
+#define X86_FEATURE_AMD_PSFD            (13*32+28) /* "" Predictive Store Forwarding Disable */
 #define X86_FEATURE_BTC_NO		(13*32+29) /* "" Not vulnerable to Branch Type Confusion */
 #define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
 
@@ -363,6 +371,7 @@
 #define X86_FEATURE_VGIF		(15*32+16) /* Virtual GIF */
 #define X86_FEATURE_X2AVIC		(15*32+18) /* Virtual x2apic */
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
+#define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
@@ -372,6 +381,7 @@
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
 #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
+#define X86_FEATURE_SHSTK		(16*32+ 7) /* "" Shadow stack */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
@@ -427,6 +437,13 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+/* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
+#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
+#define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* "" Null Selector Clears Base */
+#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
+#define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* "" SMM_CTL MSR is not present */
+
 /*
  * BUG word(s)
  */
@@ -467,5 +484,6 @@
 #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_SMT_RSB			X86_BUG(29) /* CPU is vulnerable to Cross-Thread Return Address Predictions */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.31.4

