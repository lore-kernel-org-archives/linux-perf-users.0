From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/30] tools headers: Synchronize KVM arch ABI headers
Date: Tue, 28 Nov 2017 12:02:17 -0300
Message-ID: <20171128150220.5064-28-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <cdall@linaro.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up changes from these csets:

  da9a1446d248 ("KVM: s390: provide a capability for AIS state migration")
  5c5196da4e96 ("KVM: arm/arm64: Support EL1 phys timer register access in set/get reg")

None of which affects buildint tools/perf/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoffer Dall <cdall@linaro.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-dd72s6izo4qdzt1isowlz8ji@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm/include/uapi/asm/kvm.h   | 7 +++++++
 tools/arch/arm64/include/uapi/asm/kvm.h | 7 +++++++
 tools/include/uapi/linux/kvm.h          | 1 +
 3 files changed, 15 insertions(+)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 1f57bbe82b6f..6edd177bb1c7 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -152,6 +152,12 @@ struct kvm_arch_memory_slot {
 	(__ARM_CP15_REG(op1, 0, crm, 0) | KVM_REG_SIZE_U64)
 #define ARM_CP15_REG64(...) __ARM_CP15_REG64(__VA_ARGS__)
 
+/* PL1 Physical Timer Registers */
+#define KVM_REG_ARM_PTIMER_CTL		ARM_CP15_REG32(0, 14, 2, 1)
+#define KVM_REG_ARM_PTIMER_CNT		ARM_CP15_REG64(0, 14)
+#define KVM_REG_ARM_PTIMER_CVAL		ARM_CP15_REG64(2, 14)
+
+/* Virtual Timer Registers */
 #define KVM_REG_ARM_TIMER_CTL		ARM_CP15_REG32(0, 14, 3, 1)
 #define KVM_REG_ARM_TIMER_CNT		ARM_CP15_REG64(1, 14)
 #define KVM_REG_ARM_TIMER_CVAL		ARM_CP15_REG64(3, 14)
@@ -216,6 +222,7 @@ struct kvm_arch_memory_slot {
 #define   KVM_DEV_ARM_ITS_SAVE_TABLES		1
 #define   KVM_DEV_ARM_ITS_RESTORE_TABLES	2
 #define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
+#define   KVM_DEV_ARM_ITS_CTRL_RESET		4
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 51149ec75fe4..9abbf3044654 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -196,6 +196,12 @@ struct kvm_arch_memory_slot {
 
 #define ARM64_SYS_REG(...) (__ARM64_SYS_REG(__VA_ARGS__) | KVM_REG_SIZE_U64)
 
+/* Physical Timer EL0 Registers */
+#define KVM_REG_ARM_PTIMER_CTL		ARM64_SYS_REG(3, 3, 14, 2, 1)
+#define KVM_REG_ARM_PTIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 2, 2)
+#define KVM_REG_ARM_PTIMER_CNT		ARM64_SYS_REG(3, 3, 14, 0, 1)
+
+/* EL0 Virtual Timer Registers */
 #define KVM_REG_ARM_TIMER_CTL		ARM64_SYS_REG(3, 3, 14, 3, 1)
 #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
@@ -228,6 +234,7 @@ struct kvm_arch_memory_slot {
 #define   KVM_DEV_ARM_ITS_SAVE_TABLES           1
 #define   KVM_DEV_ARM_ITS_RESTORE_TABLES        2
 #define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
+#define   KVM_DEV_ARM_ITS_CTRL_RESET		4
 
 /* Device Control API on vcpu fd */
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 7e99999d6236..282d7613fce8 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -931,6 +931,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_S390_AIS_MIGRATION 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.13.6
