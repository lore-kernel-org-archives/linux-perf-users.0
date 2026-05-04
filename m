Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81457421F1B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929536; cv=none; b=AxmgIm+5XjulpxJnGhcOqQkTvMi9odOMRy4oFcScfggx3NUkLDNwS8bMfBWNdcMXY5K9DZONATPS3UreNEPPgbqLYgrZO7wPWg33ZqPVN781adgAseCr6EybvInI2CnSonIaVHN6aq76o2eo06EfDtjseYoGtiSI8rcdWwCZ1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929536; c=relaxed/simple;
	bh=JDqmu+DnhXRfNiWmxN2ANXkk71WPrasilO+JqIo57UQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h+8o6pzY/m6IpVXwTkEpUcRBehXKNgfJJg2mjFs+x5MwAe2Y3XVMxJPnpSAQIRcwRf7ee3qTa/Y3fcoif1W0iGEWMLRYRQyIKIK2bNMCfLmv/lz265mofcEtOxW/prkKROLn+u0XM0Sd0CvbLvIZtKj5won0MXJN2RkRejuYyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EC+VZqzK; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EC+VZqzK"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-42fb0f12b10so5334253fac.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929527; x=1778534327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBRwxe29L12LD2xEcP8UBXi5vcKDWFkDhBR645b//Pw=;
        b=EC+VZqzKavRnal/97stnhkoGLnB6Fj6svott/IEuUnNCzIedMaolUqgifvTkGcLwm8
         UDvx0dtJ7NlWk33R3df6WDk4pD3dRLmjdCIJdRc4rLSqoaruABoXhj9zGnO9a/X7ScH7
         3KHdPrbyGcSy0TYiOHPRL/goZuXAug3xaFWpMi9SrcaoAQIpTA2GywO3bS+gzmsiCpIv
         gl86CDpUazN9BmXTSKVG5vEASIuk85nCgTuj5DQGdZhKGrraKiMi6Edwzef9Ube/6mQb
         9+7rMvLU7u0mxV4KraY5WN+W6FZB0w05pZkYALHlM6hU575hQqqeSMgtAM6tiVm6G9jS
         Vl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929527; x=1778534327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBRwxe29L12LD2xEcP8UBXi5vcKDWFkDhBR645b//Pw=;
        b=Ln8uJLKNPxDQF/5oIbhSyIVbGzRT5d2ElZ4fU9kbAKEZJWap2TsX2V3hav8BXJw0UK
         jTZUk0IbCalIbqmYxQvdP7jvE9U7PZEwm4VFijNC+742oCprvaUlryzkY/9LVIh8neRh
         DW24KD3QYF1BJVMlIkG41GMjbOVSYC/IJG3UMT3+Mac90BSOh6T0d3rbI4/1/+h+9CiU
         JGiOg9FBJu2PcYqgaTxR1ugsgSKtIyVziR8cTz3MBJOWjjOS0vCdPZRYpPWy42HKiGYB
         68QwAztZunemBgVlkB8bKFy3MVFuVLwVb6SZc7ddeDWWa1Ea13ChwKo2XV/QacFnI/NT
         cGfA==
X-Forwarded-Encrypted: i=1; AFNElJ+L2KqodChxO/piOWjGa6lAQCM6u1mgtTbWxzRFiuXeN9bc/oDZQJtit44XK9e3KdjbuVf9ZMBuItXJ6x/9vf+s@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkI3a5lQ+lX2pVWp2dTQXH1E9CiIJ97Nha/VGWuqeqpApVqyS
	W7xupsSvKUmiU3rLR7ePsfnK8OnXSdhe+Y1WlaVJo++qOStqujR/GJ2w4hTQRY1QltXIXrPiO5I
	Iakwlfiaud94PPxXuSw8JgRZ5EQ==
X-Received: from iljy18.prod.google.com ([2002:a05:6e02:f52:b0:4fe:8f6f:9544])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:178f:b0:696:77e2:a78 with SMTP id 006d021491bc7-6998a5aaa71mr161406eaf.23.1777929526446;
 Mon, 04 May 2026 14:18:46 -0700 (PDT)
Date: Mon,  4 May 2026 21:18:07 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-15-coltonlewis@google.com>
Subject: [PATCH v7 14/20] KVM: arm64: Implement lazy PMU context swaps
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Since many guests will never touch the PMU, they need not pay the cost
of context swapping those registers.

Use an enum to implement a simple state machine for PMU register
access. The PMU is either free or guest owned. We only need to context
swap if the PMU registers are guest owned. The PMU initially starts as
free and only transitions to guest owned if a guest has touched the
PMU registers.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h  |  1 +
 arch/arm64/include/asm/kvm_types.h |  6 +++++-
 arch/arm64/kvm/debug.c             |  2 +-
 arch/arm64/kvm/pmu-direct.c        | 25 +++++++++++++++++++++++--
 arch/arm64/kvm/sys_regs.c          | 11 +++++++++++
 include/kvm/arm_pmu.h              |  5 +++++
 6 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1f789ba589d56..891433fe304ac 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1404,6 +1404,7 @@ static inline bool kvm_system_needs_idmapped_vectors(void)
 	return cpus_have_final_cap(ARM64_SPECTRE_V3A);
 }
 
+void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu);
 void kvm_init_host_debug_data(void);
 void kvm_debug_init_vhe(void);
 void kvm_vcpu_load_debug(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/include/asm/kvm_types.h b/arch/arm64/include/asm/kvm_types.h
index 9a126b9e2d7c9..4e39cbc80aa0b 100644
--- a/arch/arm64/include/asm/kvm_types.h
+++ b/arch/arm64/include/asm/kvm_types.h
@@ -4,5 +4,9 @@
 
 #define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
 
-#endif /* _ASM_ARM64_KVM_TYPES_H */
+enum vcpu_pmu_register_access {
+	VCPU_PMU_ACCESS_FREE,
+	VCPU_PMU_ACCESS_GUEST_OWNED,
+};
 
+#endif /* _ASM_ARM64_KVM_TYPES_H */
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 0ab89c91e19cb..c2cf6b308ec60 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -34,7 +34,7 @@ static int cpu_has_spe(u64 dfr0)
  *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
  *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
  */
-static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
+void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 {
 	int hpmn = kvm_pmu_hpmn(vcpu);
 
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 14cc419dbafad..881cea5117515 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -72,10 +72,29 @@ bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
 	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;
 
 	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
+		vcpu->arch.pmu.access == VCPU_PMU_ACCESS_GUEST_OWNED &&
 		cpus_have_final_cap(ARM64_HAS_FGT) &&
 		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
 }
 
+/**
+ * kvm_pmu_set_guest_owned()
+ * @vcpu: Pointer to vcpu struct
+ *
+ * Reconfigure the guest for physical access of PMU hardware if
+ * allowed. This means reconfiguring mdcr_el2 and loading the vCPU
+ * state onto hardware.
+ *
+ */
+void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_pmu_is_partitioned(vcpu) &&
+	    vcpu->arch.pmu.access == VCPU_PMU_ACCESS_FREE) {
+		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_GUEST_OWNED;
+		kvm_arm_setup_mdcr_el2(vcpu);
+	}
+}
+
 /**
  * kvm_pmu_hpmn() - Calculate HPMN field value
  * @vcpu: Pointer to struct kvm_vcpu
@@ -278,7 +297,8 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	 * If we aren't guest-owned then we know the guest isn't using
 	 * the PMU anyway, so no need to bother with the swap.
 	 */
-	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
+	if (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
+	    vcpu->arch.pmu.access != VCPU_PMU_ACCESS_GUEST_OWNED)
 		return;
 
 	preempt_disable();
@@ -353,7 +373,8 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	 * accessing the PMU anyway, so no need to bother with the
 	 * swap.
 	 */
-	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
+	if (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
+	    vcpu->arch.pmu.access != VCPU_PMU_ACCESS_GUEST_OWNED)
 		return;
 
 	preempt_disable();
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index cc3d1804ab200..e4840d93a769f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1035,6 +1035,7 @@ static bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
 static void pmu_write_pmcr(struct kvm_vcpu *vcpu, u64 val)
 {
 	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
+		kvm_pmu_set_guest_owned(vcpu);
 		write_sysreg(val, pmcr_el0);
 		return;
 	}
@@ -1086,6 +1087,7 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static void pmu_write_pmselr(struct kvm_vcpu *vcpu, u64 val)
 {
 	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
+		kvm_pmu_set_guest_owned(vcpu);
 		write_sysreg(val, pmselr_el0);
 		return;
 	}
@@ -1193,6 +1195,8 @@ static void pmu_write_evcntr(struct kvm_vcpu *vcpu, u64 val, u64 idx)
 		return;
 	}
 
+	kvm_pmu_set_guest_owned(vcpu);
+
 	if (idx == ARMV8_PMU_CYCLE_IDX) {
 		write_sysreg(val, pmccntr_el0);
 		return;
@@ -1281,6 +1285,7 @@ static void pmu_write_evtyper(struct kvm_vcpu *vcpu, u64 val, u64 idx)
 	u64 mask;
 
 	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
+		kvm_pmu_set_guest_owned(vcpu);
 		mask = kvm_pmu_evtyper_mask(vcpu->kvm);
 		__vcpu_assign_sys_reg(vcpu, PMEVTYPER0_EL0 + idx, val & mask);
 		return;
@@ -1350,6 +1355,8 @@ static int get_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 *v
 static void pmu_write_pmcnten(struct kvm_vcpu *vcpu, u64 val, bool set)
 {
 	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
+		kvm_pmu_set_guest_owned(vcpu);
+
 		if (set)
 			write_sysreg(val, pmcntenset_el0);
 		else
@@ -1398,6 +1405,8 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static void pmu_write_pminten(struct kvm_vcpu *vcpu, u64 val, bool set)
 {
 	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
+		kvm_pmu_set_guest_owned(vcpu);
+
 		if (set)
 			write_sysreg(val, pmintenset_el1);
 		else
@@ -1453,6 +1462,8 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		return false;
 
 	if (p->is_write) {
+		kvm_pmu_set_guest_owned(vcpu);
+
 		if (r->CRm & 0x2)
 			/* accessing PMOVSSET_EL0 */
 			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index fa881dc5f5832..0de63cc48fef9 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -7,6 +7,7 @@
 #ifndef __ASM_ARM_KVM_PMU_H
 #define __ASM_ARM_KVM_PMU_H
 
+#include <linux/kvm_types.h>
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmuv3.h>
 #include <linux/perf/arm_pmu.h>
@@ -40,6 +41,7 @@ struct kvm_pmu {
 	int irq_num;
 	bool created;
 	bool irq_level;
+	enum vcpu_pmu_register_access access;
 };
 
 struct arm_pmu_entry {
@@ -101,6 +103,8 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_pmu_put(struct kvm_vcpu *vcpu);
 
+void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu);
+
 #if !defined(__KVM_NVHE_HYPERVISOR__)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
@@ -173,6 +177,7 @@ static inline u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 }
 static inline void kvm_pmu_load(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_put(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_set_guest_owned(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
-- 
2.54.0.545.g6539524ca2-goog

