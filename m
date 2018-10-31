From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/28] tools headers: Sync the various kvm.h header copies
Date: Wed, 31 Oct 2018 13:45:02 -0300
Message-ID: <20181031164508.4784-23-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For powerpc, s390, x86 and the main uapi linux/kvm.h header, none of
them entail changes in tooling.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-avn7iy8f4tcm2y40sbsdk31m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/kvm.h |  1 +
 tools/arch/s390/include/uapi/asm/kvm.h    |  2 ++
 tools/arch/x86/include/uapi/asm/kvm.h     |  6 ++----
 tools/include/uapi/linux/kvm.h            | 21 +++++++++++++++++++--
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 1b32b56a03d3..8c876c166ef2 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -634,6 +634,7 @@ struct kvm_ppc_cpu_char {
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
 #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
+#define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 9a50f02b9894..16511d97e8dc 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -160,6 +160,8 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
+#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
 
 /* kvm attributes for migration mode */
 #define KVM_S390_VM_MIGRATION_STOP	0
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 8a6eff9c27f3..dabfcf7c3941 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -300,10 +300,7 @@ struct kvm_vcpu_events {
 		__u8 injected;
 		__u8 nr;
 		__u8 has_error_code;
-		union {
-			__u8 pad;
-			__u8 pending;
-		};
+		__u8 pending;
 		__u32 error_code;
 	} exception;
 	struct {
@@ -387,6 +384,7 @@ struct kvm_sync_regs {
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+#define KVM_STATE_NESTED_EVMCS		0x00000004
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 2875ce85b322..2b7a652c9fa4 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -420,13 +420,19 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 pio;
+	};
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 pio;
+	};
 	__u8  data[8];
 };
 
@@ -751,6 +757,15 @@ struct kvm_ppc_resize_hpt {
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
+/*
+ * On arm64, machine type can be used to request the physical
+ * address size for the VM. Bits[7-0] are reserved for the guest
+ * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * value 0 implies the default IPA size, 40bits.
+ */
+#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
+#define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
+	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 /*
  * ioctls for /dev/kvm fds:
  */
@@ -958,6 +973,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_SEND_IPI 161
 #define KVM_CAP_COALESCED_PIO 162
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
+#define KVM_CAP_EXCEPTION_PAYLOAD 164
+#define KVM_CAP_ARM_VM_IPA_SIZE 165
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.14.4
