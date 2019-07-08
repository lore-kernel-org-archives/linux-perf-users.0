From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/8] tools arch kvm: Sync kvm headers with the kernel sources
Date: Mon,  8 Jul 2019 12:42:00 -0300
Message-ID: <20190708154207.11403-2-acme@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708154207.11403-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dave Martin <Dave.Martin@arm.com>, Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  41040cf7c5f0 ("arm64/sve: Fix missing SVE/FPSIMD endianness conversions")
  6ca00dfafda7 ("KVM: x86: Modify struct kvm_nested_state to have explicit fields for data")

None entail changes in tooling.

This silences these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-1cdbq5ulr4d6cx3iv2ye5wdv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h |  7 ++++++
 tools/arch/x86/include/uapi/asm/kvm.h   | 31 +++++++++++++++++--------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 7b7ac0f6cec9..d819a3e8b552 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -260,6 +260,13 @@ struct kvm_vcpu_events {
 	 KVM_REG_SIZE_U256 |						\
 	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
 
+/*
+ * Register values for KVM_REG_ARM64_SVE_ZREG(), KVM_REG_ARM64_SVE_PREG() and
+ * KVM_REG_ARM64_SVE_FFR() are represented in memory in an endianness-
+ * invariant layout which differs from the layout used for the FPSIMD
+ * V-registers on big-endian systems: see sigcontext.h for more explanation.
+ */
+
 #define KVM_ARM64_SVE_VQ_MIN __SVE_VQ_MIN
 #define KVM_ARM64_SVE_VQ_MAX __SVE_VQ_MAX
 
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 24a8cd229df6..d6ab5b4d15e5 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -383,6 +383,9 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
 #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
 
+#define KVM_STATE_NESTED_FORMAT_VMX	0
+#define KVM_STATE_NESTED_FORMAT_SVM	1	/* unused */
+
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
@@ -390,7 +393,14 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
 
-struct kvm_vmx_nested_state {
+#define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
+
+struct kvm_vmx_nested_state_data {
+	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
+	__u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
+};
+
+struct kvm_vmx_nested_state_hdr {
 	__u64 vmxon_pa;
 	__u64 vmcs12_pa;
 
@@ -401,24 +411,25 @@ struct kvm_vmx_nested_state {
 
 /* for KVM_CAP_NESTED_STATE */
 struct kvm_nested_state {
-	/* KVM_STATE_* flags */
 	__u16 flags;
-
-	/* 0 for VMX, 1 for SVM.  */
 	__u16 format;
-
-	/* 128 for SVM, 128 + VMCS size for VMX.  */
 	__u32 size;
 
 	union {
-		/* VMXON, VMCS */
-		struct kvm_vmx_nested_state vmx;
+		struct kvm_vmx_nested_state_hdr vmx;
 
 		/* Pad the header to 128 bytes.  */
 		__u8 pad[120];
-	};
+	} hdr;
 
-	__u8 data[0];
+	/*
+	 * Define data region as 0 bytes to preserve backwards-compatability
+	 * to old definition of kvm_nested_state in order to avoid changing
+	 * KVM_{GET,PUT}_NESTED_STATE ioctl values.
+	 */
+	union {
+		struct kvm_vmx_nested_state_data vmx[0];
+	} data;
 };
 
 #endif /* _ASM_X86_KVM_H */
-- 
2.20.1
