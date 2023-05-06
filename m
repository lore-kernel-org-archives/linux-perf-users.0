Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C97EC7EE22
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjEFLFs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjEFLFr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:05:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 755B859D7
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:05:45 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8Cx+emINFZkZb0FAA--.9455S3;
        Sat, 06 May 2023 19:05:44 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxDbOFNFZkSmxNAA--.10164S4;
        Sat, 06 May 2023 19:05:43 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 11/18] tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel sources
Date:   Sat,  6 May 2023 19:05:15 +0800
Message-Id: <ab8b8cce08e7c94d1176ffbef603cd7c978faccf.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxDbOFNFZkSmxNAA--.10164S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuFy3KF1DAw1fCF1UJw4DCFg_yoW7WFW3p3
        Z5Aas5JF4YgrWfC34rJF1Dury3G393Wrn5K3y3Wr4a9F13t3WkJrs2kFs8AF9rtw48Ja1I
        9FySgry5W34Dt3DanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bkkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj6I8E
        87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjc
        xG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWx
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bYoG
        QUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit e65733b5c59a1ea2 ("KVM: x86: Redefine 'longmode' as a flag for
   KVM_EXIT_HYPERCALL")
  commit 30ec7997d175cd68 ("KVM: arm64: timers: Allow userspace to set
   the global counter offset")
  commit 821d935c87bc9525 ("KVM: arm64: Introduce support for userspace
   SMCCC filtering")
  commit 81dc9504a7006b48 ("KVM: arm64: nv: timers: Support hyp timer
   emulation")
  commit a8308b3fc9494953 ("KVM: arm64: Refactor hvc filtering to support
   different actions")
  commit 0e5c9a9d6548e9b1 ("KVM: arm64: Expose SMC/HVC width to
   userspace")

Silencing these perf build warnings:

 Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs
  from latest version at 'include/uapi/linux/kvm.h'
 diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
 Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h'
  differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
 diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi
  /asm/kvm.h
 Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h'
  differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
 diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi
  /asm/kvm.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/arch/arm64/include/uapi/asm/kvm.h | 36 +++++++++++++++++++++++++
 tools/arch/x86/include/uapi/asm/kvm.h   |  3 +++
 tools/include/uapi/linux/kvm.h          | 12 +++++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index f8129c624b07..f7ddd73a8c0f 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -198,6 +198,15 @@ struct kvm_arm_copy_mte_tags {
 	__u64 reserved[2];
 };
 
+/*
+ * Counter/Timer offset structure. Describe the virtual/physical offset.
+ * To be used with KVM_ARM_SET_COUNTER_OFFSET.
+ */
+struct kvm_arm_counter_offset {
+	__u64 counter_offset;
+	__u64 reserved;
+};
+
 #define KVM_ARM_TAGS_TO_GUEST		0
 #define KVM_ARM_TAGS_FROM_GUEST		1
 
@@ -372,6 +381,10 @@ enum {
 #endif
 };
 
+/* Device Control API on vm fd */
+#define KVM_ARM_VM_SMCCC_CTRL		0
+#define   KVM_ARM_VM_SMCCC_FILTER	0
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
@@ -411,6 +424,8 @@ enum {
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
+#define   KVM_ARM_VCPU_TIMER_IRQ_HVTIMER	2
+#define   KVM_ARM_VCPU_TIMER_IRQ_HPTIMER	3
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
 
@@ -469,6 +484,27 @@ enum {
 /* run->fail_entry.hardware_entry_failure_reason codes. */
 #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED	(1ULL << 0)
 
+enum kvm_smccc_filter_action {
+	KVM_SMCCC_FILTER_HANDLE = 0,
+	KVM_SMCCC_FILTER_DENY,
+	KVM_SMCCC_FILTER_FWD_TO_USER,
+
+#ifdef __KERNEL__
+	NR_SMCCC_FILTER_ACTIONS
+#endif
+};
+
+struct kvm_smccc_filter {
+	__u32 base;
+	__u32 nr_functions;
+	__u8 action;
+	__u8 pad[15];
+};
+
+/* arm64-specific KVM_EXIT_HYPERCALL flags */
+#define KVM_HYPERCALL_EXIT_SMC		(1U << 0)
+#define KVM_HYPERCALL_EXIT_16BIT	(1U << 1)
+
 #endif
 
 #endif /* __ARM_KVM_H__ */
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 7f467fe05d42..1a6a1f987949 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -559,4 +559,7 @@ struct kvm_pmu_event_filter {
 #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
 #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
 
+/* x86-specific KVM_EXIT_HYPERCALL flags. */
+#define KVM_EXIT_HYPERCALL_LONG_MODE	BIT(0)
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 4003a166328c..737318b1c1d9 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -341,8 +341,13 @@ struct kvm_run {
 			__u64 nr;
 			__u64 args[6];
 			__u64 ret;
-			__u32 longmode;
-			__u32 pad;
+
+			union {
+#ifndef __KERNEL__
+				__u32 longmode;
+#endif
+				__u64 flags;
+			};
 		} hypercall;
 		/* KVM_EXIT_TPR_ACCESS */
 		struct {
@@ -1184,6 +1189,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
 #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
 #define KVM_CAP_PMU_EVENT_MASKED_EVENTS 226
+#define KVM_CAP_COUNTER_OFFSET 227
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1543,6 +1549,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
 #define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
 #define KVM_ARM_MTE_COPY_TAGS	  _IOR(KVMIO,  0xb4, struct kvm_arm_copy_mte_tags)
+/* Available with KVM_CAP_COUNTER_OFFSET */
+#define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.31.4

