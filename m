Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114354;
	b=1Zr2nBbus/U3CAIbu9RIPMtLIDtxawQntUl0kK1dmf4mNT7di/+g4tVB05GnMz96oLOq
	 ELwRjNwkpZLGAb4We9Nu2vX/dI42W3uVJMq93by06quB3+VXdjXKVqpz7vr758nuk4bbr
	 NJXQ7a/TSDTHfsbfuterrTe7ju4FbcW5fTYY1+5vDXWmZMiIGZvECznGX04DLhLA1rCn8
	 +hbMwlQDtuBh8U4KCMmEnrtdwqUi49SzmeCq989IDh+TxGMuhRCQnZlmXnisXsDW0DBrv
	 9UwzDLnnXNksuAhLdNvH6/680aii4KXstLosUj5pYJPrXVVYblhFvzlvUOBdD+04hKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nA9X1kI7IFOq6JqFCv4FpBLK6+hTHxRCT2T0B+GpwhQ=;
	b=oxOqzvROeJp7JyHRfhALe+gcmhsXGgGIhQCcKjSCLtKtxUlfbz3JWwEJWAFBnFEXAT+H
	 809SFdCGYOtElpFH4M1QAe76XFLLBUMa2s8fsZG5aKjoc09Tw+Laxw5L/kEgWUiM7Ydew
	 /dPqe4jrY+5hjOVf8g6qpYzx+tKKiwpcDkH4q/f4kiyQ4T6E0C2beutfWZ8Pd9IIzBxFO
	 lLhzcLf0uVKg3i7/1r52VO5WGPm6+CrMgUq7ZyIxuYudvWVGy1Fv5G1+pOyYGGSlNVT1e
	 vZvxL2GLkkURwqyaYx0UXREI9mQbjrxRkig6D3MrNOVHUk+uZdo4wbNVBpVGWuenSMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HNYJE58M;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA40606CEA8
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA40606CEA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HNYJE58M
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5735cd94235so171554b6e.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114353; x=1795719153; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nA9X1kI7IFOq6JqFCv4FpBLK6+hTHxRCT2T0B+GpwhQ=;
        b=HNYJE58M1BysDw3MVjn4wh3cZTDykPJnThZbgizQcntuX8YcXcociuhpXYbtNu+0zk
         kYGtRGEQxupXlGfRStumMqzy4oiaLDXh4We6gcdZqOMmaRfbn17GqUKbErh/Zek1gatZ
         q5Aw1DiuylZmr9W//DVWNBtPktF0XgdfkvrqjIwUFfp0iZo4AkPMkwC3YeIMEvFcyyEd
         +cY4ZfP7gCFSg54I7wt0onlsvxMiUQUmy9Ztz0N1N7qbmeCzV6C+3QvCOltK6p9tM10X
         kAxJpmQCEZhx9RNju4xJlD1gYe5X9Nt/Z3Iu0u3dIiReJOKfrnsr/6XuYOdTKeM7GVMS
         6p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114353; x=1795719153;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nA9X1kI7IFOq6JqFCv4FpBLK6+hTHxRCT2T0B+GpwhQ=;
        b=iAcPcs8fwEEZrT+LLdt28D7JEvUKXggjqV3ALTnCsPjH5WCwHQKoJ++M/pWqPp7J6n
         pYFwWPBRRBjFs1xNITzibZNRkjegKox1FPQ4CfXCZa9W+I3nTiLI8v9I8a1m3OLeCbAQ
         oBEw0+j1nx7gyVa8NYYL9WdEEGXY2wU+9C8i9FnWw0yxnM697oIIwKVFuIXBfCwDcGgy
         Z95nX0kcBHw5lVLjA0SlelkxkcHk5kbayn90LjBQZzCP0nZpdVDGM18D0sXxOXTCPvzr
         zV44DUr97oBXkQo+JDDNo0x9mXL6Vl3ceABkd1r2ZqgLrBS+boN+l65U8fwFUXXQuCzO
         N8CQ==
X-Forwarded-Encrypted: i=1; AL+hErFqnN9uGR0JZT+zgRMM1lmoIpjF7htd2oPzlYDngzevlkW1WHqyAM3XwI0lddiDWvI10gvoqh45z98S/7JpqNUU@vger.kernel.org
X-Gm-Message-State: APuU4Z80BppvZOqP+l2Z3jQ0v8Y9qZ2y2xrdz92xtE5GY+iB1cjCSx0B
	mh2826LaoZ28l03p53yEDrQ3Uab33iUrx18UtlbG6uUuDDb8ylaPxc55OBg9Y4RZVX1N9GFpXby
	oY+t37jTzsLyACebbXFneLr1e1Q==
X-Received: from jagi25-n2.prod.google.com ([2002:a05:6639:59:20b0:61b:4431:8bc0])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c2c4:b0:52b:7641:33a6 with SMTP id 5614622812f47-57a0a4053a1mr1064244b6e.14.1795114352602;
 Thu, 19 Nov 2026 10:52:32 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:59 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-18-coltonlewis@google.com>
Subject: [PATCH v10 17/33] KVM: arm64: Context swap Partitioned PMU guest registers
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Save and restore the guest PMU registers that are untrapped when the PMU
is partitioned:
- PMEVCNTRn_EL0
- PMCCNTR_EL0
- PMSELR_EL0 (when MDCR_EL2.TPM is clear)
- PMUSERENR_EL0 (when MDCR_EL2.TPM is clear)
- PMCR_EL0
- PMCNTENSET_EL0 / PMCNTENCLR_EL0
- PMINTENSET_EL1 / PMINTENCLR_EL1

Mask counter bitmaps to guest-reserved counters so host-owned counters
in HPMN..N-1 are left untouched. Clear hardware guest overflow flags on
load before enabling PMINTENSET_EL1 to avoid spurious interrupts, flush
pending hardware guest overflow flags into shadow PMOVSSET_EL0 on put,
and restore physical PMCR_EL0.E from MDCR_EL2.HPME on put so active host
perf events continue counting.

PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 are loaded in the next patch after
applying the KVM PMU event filter. A subsequent patch makes these swaps
lazy until the guest enables the PMU.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/arm.c        |   4 +-
 arch/arm64/kvm/pmu-direct.c | 175 ++++++++++++++++++++++++++++++++++++
 include/kvm/arm_pmu.h       |   6 +-
 3 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 157bf4b812020..fc420d8f0e4fe 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -767,6 +767,7 @@ static void vhe_vcpu_load(struct kvm_vcpu *vcpu)
 	kvm_vcpu_load_fgt(vcpu);
 	kvm_vcpu_load_vhe(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
+	kvm_pmu_load(vcpu);
 	kvm_vcpu_pmu_restore_guest(vcpu);
 
 	vcpu_load_pvtime(vcpu);
@@ -821,12 +822,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 static void vhe_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_pmu_put(vcpu);
+	kvm_vcpu_pmu_restore_host(vcpu);
 	kvm_vcpu_put_debug(vcpu);
 	kvm_arch_vcpu_put_fp(vcpu);
 	kvm_vcpu_put_vhe(vcpu);
 	kvm_timer_vcpu_put(vcpu);
 	kvm_vgic_put(vcpu);
-	kvm_vcpu_pmu_restore_host(vcpu);
 
 	if (vcpu_has_nv(vcpu))
 		kvm_vcpu_put_hw_mmu(vcpu);
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 13f5bcc2a9084..5c8a8c42e353d 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -344,3 +344,178 @@ u64 kvm_pmu_guest_counter_mask(void)
 {
 	return kvm_vcpu_pmu_guest_counter_mask(kvm_get_running_vcpu());
 }
+
+/**
+ * kvm_pmu_load() - Load untrapped PMU registers
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Load all untrapped PMU registers from the VCPU into the PCPU. Mask
+ * to only bits belonging to guest-reserved counters and leave
+ * host-reserved counters alone in bitmask registers.
+ */
+void kvm_pmu_load(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	unsigned long guest_counters;
+	unsigned long flags;
+	u64 mask;
+	u8 i;
+	u64 val;
+
+	/*
+	 * If we aren't guest-owned then we know the guest isn't using
+	 * the PMU anyway, so no need to bother with the swap.
+	 */
+	if (!kvm_pmu_is_partitioned(vcpu->kvm) || !vcpu->wants_to_run || !pmu)
+		return;
+
+	local_irq_save(flags);
+	if (!cpumask_test_cpu(smp_processor_id(), &pmu->supported_cpus)) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+
+	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
+		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
+
+		if (i == ARMV8_PMU_CYCLE_IDX)
+			write_pmccntr(val);
+		else
+			write_pmevcntrn(i, val);
+	}
+
+	if (!(vcpu->arch.mdcr_el2 & MDCR_EL2_TPM)) {
+		val = __vcpu_sys_reg(vcpu, PMSELR_EL0);
+		write_sysreg(val, pmselr_el0);
+
+		val = __vcpu_sys_reg(vcpu, PMUSERENR_EL0) &
+		      ARMV8_PMU_USERENR_MASK;
+		write_sysreg(val, pmuserenr_el0);
+	}
+
+	/* Save only the stateful writable bits. */
+	val = __vcpu_sys_reg(vcpu, PMCR_EL0);
+	mask = ARMV8_PMU_PMCR_MASK &
+		~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C);
+	if (!kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, V3P5))
+		mask &= ~ARMV8_PMU_PMCR_LP;
+	write_sysreg(val & mask, pmcr_el0);
+
+	/*
+	 * When handling these:
+	 * 1. Apply only the bits for guest counters (indicated by mask)
+	 * 2. Use the different registers for set and clear
+	 */
+	mask = guest_counters;
+
+	/*
+	 * Clear the hardware overflow flags so there is no chance of
+	 * creating spurious interrupts. The hardware here is never
+	 * the canonical version anyway.
+	 */
+	write_sysreg(mask, pmovsclr_el0);
+	isb();
+
+	val = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+	write_sysreg(val & mask, pmcntenset_el0);
+	write_sysreg(~val & mask, pmcntenclr_el0);
+
+	val = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
+	write_sysreg(val & mask, pmintenset_el1);
+	write_sysreg(~val & mask, pmintenclr_el1);
+
+	local_irq_restore(flags);
+}
+
+/**
+ * kvm_pmu_put() - Put untrapped PMU registers
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Put all untrapped PMU registers from the PCPU into the VCPU. Mask
+ * to only bits belonging to guest-reserved counters and leave
+ * host-reserved counters alone in bitmask registers.
+ */
+void kvm_pmu_put(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	unsigned long guest_counters;
+	unsigned long flags;
+	u64 pmcr_mask;
+	u64 mask;
+	u8 i;
+	u64 val;
+
+	/*
+	 * If we aren't guest-owned then we know the guest is not
+	 * accessing the PMU anyway, so no need to bother with the
+	 * swap.
+	 */
+	if (!kvm_pmu_is_partitioned(vcpu->kvm) || !vcpu->wants_to_run || !pmu)
+		return;
+
+	local_irq_save(flags);
+	if (!cpumask_test_cpu(smp_processor_id(), &pmu->supported_cpus)) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+	mask = guest_counters;
+
+	/* Mask these to only save the guest relevant bits. */
+	val = read_sysreg(pmcntenset_el0);
+	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
+
+	val = read_sysreg(pmintenset_el1);
+	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
+
+	/* Stop guest counters and disable interrupts in hardware first. */
+	write_sysreg(mask, pmcntenclr_el0);
+	write_sysreg(mask, pmintenclr_el1);
+	isb();
+
+	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
+		if (i == ARMV8_PMU_CYCLE_IDX) {
+			val = read_pmccntr();
+			write_pmccntr(0);
+		} else {
+			val = read_pmevcntrn(i);
+			write_pmevcntrn(i, 0);
+		}
+
+		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
+	}
+
+	if (!(vcpu->arch.mdcr_el2 & MDCR_EL2_TPM)) {
+		val = read_sysreg(pmselr_el0);
+		__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);
+		write_sysreg(0, pmselr_el0);
+
+		val = read_sysreg(pmuserenr_el0) & ARMV8_PMU_USERENR_MASK;
+		__vcpu_assign_sys_reg(vcpu, PMUSERENR_EL0, val);
+		write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
+	}
+
+	val = read_sysreg(pmcr_el0);
+	pmcr_mask = ARMV8_PMU_PMCR_MASK;
+	if (!kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, V3P5))
+		pmcr_mask &= ~ARMV8_PMU_PMCR_LP;
+	__vcpu_rmw_sys_reg(vcpu, PMCR_EL0, &=, ~ARMV8_PMU_PMCR_MASK);
+	__vcpu_rmw_sys_reg(vcpu, PMCR_EL0, |=, val & pmcr_mask);
+
+	val = ARMV8_PMU_PMCR_LC;
+	if (pmu->pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5)
+		val |= ARMV8_PMU_PMCR_LP;
+	if (vcpu->arch.mdcr_el2 & MDCR_EL2_HPME)
+		val |= ARMV8_PMU_PMCR_E;
+	write_sysreg(val, pmcr_el0);
+
+	/* Save pending guest hardware overflows. */
+	val = read_sysreg(pmovsset_el0);
+	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, val & mask);
+	write_sysreg(val & mask, pmovsclr_el0);
+
+	local_irq_restore(flags);
+}
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 276ab74fa0208..4580f62234128 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -102,6 +102,9 @@ u64 kvm_pmu_direct_reg_read(struct kvm_vcpu *vcpu, unsigned int reg);
 void kvm_pmu_direct_reg_write(struct kvm_vcpu *vcpu, unsigned int reg,
 			      u64 val, bool set);
 u64 kvm_pmu_guest_counter_mask(void);
+void kvm_pmu_load(struct kvm_vcpu *vcpu);
+void kvm_pmu_put(struct kvm_vcpu *vcpu);
+
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
  * Must be called before every vcpu run after disabling interrupts, to ensure
@@ -146,10 +149,11 @@ static inline u64 kvm_pmu_direct_reg_read(struct kvm_vcpu *vcpu,
 {
 	return 0;
 }
-
 static inline void kvm_pmu_direct_reg_write(struct kvm_vcpu *vcpu,
 					    unsigned int reg, u64 val,
 					    bool set) {}
+static inline void kvm_pmu_load(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_put(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
-- 
2.56.1.708.g77570a6a1d-goog

