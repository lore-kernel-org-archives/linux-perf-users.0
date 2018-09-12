From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/7] tools headers uapi: Update tools's copies of kvm headers
Date: Wed, 12 Sep 2018 15:55:06 -0300
Message-ID: <20180912185509.32187-5-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Ahern <dsahern@gmail.com>, David Hildenbrand <david@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, James Morse <james.morse@arm.com>, Janosch Frank <frankja@linux.ibm.com>, Jim Mattson <jmattson@google.com>, Jiri Olsa <jolsa@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

	a449938297e5 ("KVM: s390: Add huge page enablement control")
	8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
	be26b3a73413 ("arm64: KVM: export the capability to set guest SError syndrome")
	b7b27facc7b5 ("arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS")
	b0960b9569db ("KVM: arm: Add 32bit get/set events support")
	a3da7b4a3be5 ("KVM: s390: add etoken support for guests")

This makes 'perf trace' automagically get aware of these new ioctls:

  $ cp include/uapi/linux/kvm.h tools/include/uapi/linux/kvm.h
  $ tools/perf/trace/beauty/kvm_ioctl.sh  > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2018-09-11 11:18:29.173207586 -0300
  +++ /tmp/after	2018-09-11 11:18:38.488200446 -0300
  @@ -84,6 +84,8 @@
        [0xbb] = "MEMORY_ENCRYPT_REG_REGION",
        [0xbc] = "MEMORY_ENCRYPT_UNREG_REGION",
        [0xbd] = "HYPERV_EVENTFD",
  +     [0xbe] = "GET_NESTED_STATE",
  +     [0xbf] = "SET_NESTED_STATE",
        [0xe0] = "CREATE_DEVICE",
        [0xe1] = "SET_DEVICE_ATTR",
        [0xe2] = "G

And cures the following warning during perf's build:

	Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
	diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2vvwh2o19orn56di0ksrtgzr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm/include/uapi/asm/kvm.h   | 13 ++++++++++++
 tools/arch/arm64/include/uapi/asm/kvm.h | 13 ++++++++++++
 tools/arch/s390/include/uapi/asm/kvm.h  |  5 ++++-
 tools/arch/x86/include/uapi/asm/kvm.h   | 37 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/kvm.h          |  6 ++++++
 5 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 16e006f708ca..4602464ebdfb 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -27,6 +27,7 @@
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
+#define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
@@ -125,6 +126,18 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/* for KVM_GET/SET_VCPU_EVENTS */
+struct kvm_vcpu_events {
+	struct {
+		__u8 serror_pending;
+		__u8 serror_has_esr;
+		/* Align it to 8 bytes */
+		__u8 pad[6];
+		__u64 serror_esr;
+	} exception;
+	__u32 reserved[12];
+};
+
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
 #define KVM_REG_ARM_COPROC_SHIFT	16
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 4e76630dd655..97c3478ee6e7 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -39,6 +39,7 @@
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
+#define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
@@ -154,6 +155,18 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/* for KVM_GET/SET_VCPU_EVENTS */
+struct kvm_vcpu_events {
+	struct {
+		__u8 serror_pending;
+		__u8 serror_has_esr;
+		/* Align it to 8 bytes */
+		__u8 pad[6];
+		__u64 serror_esr;
+	} exception;
+	__u32 reserved[12];
+};
+
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
 #define KVM_REG_ARM_COPROC_SHIFT	16
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 4cdaa55fabfe..9a50f02b9894 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -4,7 +4,7 @@
 /*
  * KVM s390 specific structures and definitions
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -225,6 +225,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
+#define KVM_SYNC_ETOKEN (1UL << 11)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -258,6 +259,8 @@ struct kvm_sync_regs {
 		struct {
 			__u64 reserved1[2];
 			__u64 gscb[4];
+			__u64 etoken;
+			__u64 etoken_extension;
 		};
 	};
 };
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index c535c2fdea13..86299efa804a 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -378,4 +378,41 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define KVM_STATE_NESTED_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+
+#define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_SMM_VMXON	0x00000002
+
+struct kvm_vmx_nested_state {
+	__u64 vmxon_pa;
+	__u64 vmcs_pa;
+
+	struct {
+		__u16 flags;
+	} smm;
+};
+
+/* for KVM_CAP_NESTED_STATE */
+struct kvm_nested_state {
+	/* KVM_STATE_* flags */
+	__u16 flags;
+
+	/* 0 for VMX, 1 for SVM.  */
+	__u16 format;
+
+	/* 128 for SVM, 128 + VMCS size for VMX.  */
+	__u32 size;
+
+	union {
+		/* VMXON, VMCS */
+		struct kvm_vmx_nested_state vmx;
+
+		/* Pad the header to 128 bytes.  */
+		__u8 pad[120];
+	};
+
+	__u8 data[0];
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index b6270a3b38e9..07548de5c988 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -949,6 +949,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_S390_HPAGE_1M 156
+#define KVM_CAP_NESTED_STATE 157
+#define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1391,6 +1394,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
 
+/* Available with KVM_CAP_NESTED_STATE */
+#define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
+#define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.14.4
