From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/18] tools headers: Sync kernel ABI headers with tooling headers
Date: Tue,  1 Aug 2017 16:56:30 -0300
Message-ID: <20170801195645.16986-4-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbdHAT5X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2017 15:57:23 -0400
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>, Jiri Olsa <jolsa@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>

From: Ingo Molnar <mingo@kernel.org>

Sync up (copy) the following v4.13 kernel headers to the tooling headers:

  arch/arm/include/uapi/asm/kvm.h:
  arch/arm64/include/uapi/asm/kvm.h:
  arch/powerpc/include/uapi/asm/kvm.h:
  arch/s390/include/uapi/asm/kvm.h:

   - KVM ABI extensions, which do not affect perf tooling

  arch/x86/include/asm/cpufeatures.h:
  arch/x86/include/asm/disabled-features.h:

   - New PCID CPU feature on Intel CPUs - does not affect tooling.

I.e. no real changes were needed to resolve the build warnings, just a plain copy
of the latest kernel header version.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Geneviève Bastien <gbastien@versatic.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Julien Desfossez <jdesfossez@efficios.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170730095232.4j4xigsoqwufl5hu@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm/include/uapi/asm/kvm.h          |  8 ++++++++
 tools/arch/arm64/include/uapi/asm/kvm.h        |  3 +++
 tools/arch/powerpc/include/uapi/asm/kvm.h      |  6 ++++++
 tools/arch/s390/include/uapi/asm/kvm.h         | 12 ++++++++++++
 tools/arch/x86/include/asm/cpufeatures.h       |  2 ++
 tools/arch/x86/include/asm/disabled-features.h |  4 +++-
 6 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 5e3c673fa3f4..5db2d4c6a55f 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -203,6 +203,14 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
+/* Device Control API on vcpu fd */
+#define KVM_ARM_VCPU_PMU_V3_CTRL	0
+#define   KVM_ARM_VCPU_PMU_V3_IRQ	0
+#define   KVM_ARM_VCPU_PMU_V3_INIT	1
+#define KVM_ARM_VCPU_TIMER_CTRL		1
+#define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
+#define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
+
 #define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
 #define   KVM_DEV_ARM_ITS_SAVE_TABLES		1
 #define   KVM_DEV_ARM_ITS_RESTORE_TABLES	2
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 70eea2ecc663..9f3ca24bbcc6 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -232,6 +232,9 @@ struct kvm_arch_memory_slot {
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
 #define   KVM_ARM_VCPU_PMU_V3_IRQ	0
 #define   KVM_ARM_VCPU_PMU_V3_INIT	1
+#define KVM_ARM_VCPU_TIMER_CTRL		1
+#define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
+#define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 07fbeb927834..8cf8f0c96906 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -60,6 +60,12 @@ struct kvm_regs {
 
 #define KVM_SREGS_E_FSL_PIDn	(1 << 0) /* PID1/PID2 */
 
+/* flags for kvm_run.flags */
+#define KVM_RUN_PPC_NMI_DISP_MASK		(3 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_FULLY_RECOV	(1 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_LIMITED_RECOV	(2 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_NOT_RECOV	(3 << 0)
+
 /*
  * Feature bits indicate which sections of the sregs struct are valid,
  * both in KVM_GET_SREGS and KVM_SET_SREGS.  On KVM_SET_SREGS, registers
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 3dd2a1d308dd..69d09c39bbcd 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -28,6 +28,7 @@
 #define KVM_DEV_FLIC_CLEAR_IO_IRQ	8
 #define KVM_DEV_FLIC_AISM		9
 #define KVM_DEV_FLIC_AIRQ_INJECT	10
+#define KVM_DEV_FLIC_AISM_ALL		11
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
@@ -53,6 +54,11 @@ struct kvm_s390_ais_req {
 	__u16 mode;
 };
 
+struct kvm_s390_ais_all {
+	__u8 simm;
+	__u8 nimm;
+};
+
 #define KVM_S390_IO_ADAPTER_MASK 1
 #define KVM_S390_IO_ADAPTER_MAP 2
 #define KVM_S390_IO_ADAPTER_UNMAP 3
@@ -70,6 +76,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_TOD			1
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
+#define KVM_S390_VM_MIGRATION		4
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -151,6 +158,11 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
 
+/* kvm attributes for migration mode */
+#define KVM_S390_VM_MIGRATION_STOP	0
+#define KVM_S390_VM_MIGRATION_START	1
+#define KVM_S390_VM_MIGRATION_STATUS	2
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 2701e5f8145b..14f0f2913364 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -196,6 +196,7 @@
 
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
+#define X86_FEATURE_SME		( 7*32+10) /* AMD Secure Memory Encryption */
 
 #define X86_FEATURE_INTEL_PPIN	( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
@@ -286,6 +287,7 @@
 #define X86_FEATURE_PAUSEFILTER (15*32+10) /* filtered pause intercept */
 #define X86_FEATURE_PFTHRESHOLD (15*32+12) /* pause filter threshold */
 #define X86_FEATURE_AVIC	(15*32+13) /* Virtual Interrupt Controller */
+#define X86_FEATURE_VIRTUAL_VMLOAD_VMSAVE (15*32+15) /* Virtual VMLOAD VMSAVE */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx), word 16 */
 #define X86_FEATURE_AVX512VBMI  (16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 5dff775af7cd..c10c9128f54e 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -21,11 +21,13 @@
 # define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
 # define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
 # define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
+# define DISABLE_PCID		0
 #else
 # define DISABLE_VME		0
 # define DISABLE_K6_MTRR	0
 # define DISABLE_CYRIX_ARR	0
 # define DISABLE_CENTAUR_MCR	0
+# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
@@ -49,7 +51,7 @@
 #define DISABLED_MASK1	0
 #define DISABLED_MASK2	0
 #define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	0
+#define DISABLED_MASK4	(DISABLE_PCID)
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	0
-- 
2.9.4
