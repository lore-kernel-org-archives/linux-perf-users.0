Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9984AF9F1
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270992; cv=none; b=m6f7TF7TjCeeMynldQzUZrPbHmcMJo2HA+q4vgDrMttpR71oNYeDPT8K+uGmPbPAkmBdvdvMAPugxkrOZlqzGCERxUphxdleGJBZZJUQhdqkekRbfoY0wjVEPNMVg5ycxOdlxlQ3ZHj6mGQyVNcSh3Il1pqNISLg5GHvRuTER4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270992; c=relaxed/simple;
	bh=n6lQyuM/9asR+jh1pp81SkfOADoIJb7UAthlgebBP9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PlqaTjzulZwmkYXUpln98zNmpQLqua/+FWtDAF1J8sY5I7EjF6KwqdhhsGw8+6O6gxjmjHk05WwzqNmRLAC/SDkqTFwITlJrhZ45EcjPlcNPm9f2xCk3unD85NaAexHb92Jm+p4p7u2dSVgQeY9+mycHBgaanIit98wyGnMgbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFK4vkW+; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFK4vkW+"
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8076c66efc6so16377a34.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270986; x=1790875786; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1rFPnvvDfgrTvcPEC5jqhdQxabYYP4ivtinNrSSaBAY=;
        b=oFK4vkW++Q+B0ESddauj+voUVgwtwTtdKgwo5orU/6Kw9NCIv2sYPBwk0B/08ob9dW
         HFqnjgNewRUSJ+V+PwCjVPz3k0poC+RF9tn4IpLTXdNXjOuX4DA4yzSZ6ksvpyv4n4pP
         MUL8t0AiXzDN5TmTcvUCp62kBa07nKTqIiv43Iyw9fOmbJYZtC5Bbg1qUIiJ0lJg+4Nv
         TX8B08umEmUmMGZb5lws4wZ7PXMmzLV1z3Znrnwcs6VV31+aabcECkhIP+bDljziNEt9
         68HxgnfYpWTVLq1VYq+v3aO0M60pV2RLmF4F/3zsb15I/Qu6vEsyVtEllWsMwEqqLdzs
         pVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270986; x=1790875786;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rFPnvvDfgrTvcPEC5jqhdQxabYYP4ivtinNrSSaBAY=;
        b=Gv6D2UDRkSV+lDJamD4syDg+m0j7J0gKb6N5wY3rsP1G9YmUs+7ZnxQSq10MTPWiYA
         aXXL6Q31457NGBdVdPD1sDLQsuRFoekJsOCiq4cfzKfjHKFz5tipyx4pq8ihdKoGTEF5
         D4wZdXQM7+LY3fe1Y6F6FnzYS95+OjPS7EY2TjVfsjaO53r4nGIfLhlf7XTWutKImgTU
         r5FGzDX/YUOso/LwNYfRF3eKi+uyjFR52N2FbvC5vfZ96cTvahdPpmiTEDfvspBwA3Q1
         Vz6BVwIcegcR/e20dO1FqgrPC5oxMp8tgBjtTSfznhEVll1zEIKTwqFRzV+gIzeq+xqV
         /kGQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1cJBdOV252rRJWIgVRpDhWrCXXRQhr9L+NDYcfHSK4GApqCY2zZJkYBpXkfaU+2rJzyV0DD1LfVsI1ClFGv6H@vger.kernel.org
X-Gm-Message-State: AFuF++lRDODJt0qJEwDxbSpCYjk0T5qqmf81Rgj1lT/zqPORB1hAsZX3
	C/PGJcsmLVL88ZzDAVQe+JU5rPKkiXhuCdljt9vfk75JTtFKO+G0ADPvwQiEt+i4Ly6VEgjjcAI
	Qwzucy6PAlYH5QdcSxaG5Js+7dg==
X-Received: from jabfq3.prod.google.com ([2002:a05:6638:6503:b0:5f3:4cc3:520e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c2bf:b0:4d6:93c3:1af4 with SMTP id 5614622812f47-4d72bd43ad2mr3030897b6e.63.1790270985212;
 Thu, 24 Sep 2026 10:29:45 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:16 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-11-coltonlewis@google.com>
Subject: [PATCH v9 10/22] KVM: arm64: Add Partitioned PMU register trap handlers
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zide Chen <zide.chen@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

We may want a partitioned PMU but not have FEAT_FGT to untrap the
specific registers that would normally be untrapped. Add handling for
those trapped register accesses that does the right thing if the PMU
is partitioned.

For PMOVSCLR_EL0, clear guest overflow bits in both virtual and physical
registers. For PMEVTYPER and PMCCFILTR, write to the virtual register;
subsequent patches enforce the event filter at vcpu_load() and on
trapped register writes.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c |  51 +++++++
 arch/arm64/kvm/sys_regs.c   | 277 +++++++++++++++++++++++++++++-------
 include/kvm/arm_pmu.h       |   7 +
 3 files changed, 287 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index f224b97823ce5..5045051e91cd3 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -64,6 +64,57 @@ bool kvm_pmu_is_partitioned(struct kvm *kvm)
 	return kvm && test_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &kvm->arch.flags);
 }
 
+/**
+ * kvm_pmu_direct_pmcr_write() - Handle guest writes to PMCR_EL0
+ * @vcpu: Pointer to vcpu struct
+ * @val: Value written to PMCR_EL0
+ *
+ * Write control bits to physical pmcr_el0 and reset guest-owned general
+ * event counters when PMCR_EL0.P is set.
+ */
+void kvm_pmu_direct_pmcr_write(struct kvm_vcpu *vcpu, u64 val)
+{
+	bool reset_p = val & ARMV8_PMU_PMCR_P;
+	unsigned long mask;
+	int i;
+
+	val &= ~ARMV8_PMU_PMCR_P;
+
+	write_sysreg(val, pmcr_el0);
+
+	if (reset_p) {
+		mask = kvm_pmu_implemented_counter_mask(vcpu) & ~BIT(ARMV8_PMU_CYCLE_IDX);
+
+		if (!vcpu_is_el2(vcpu))
+			mask &= ~kvm_pmu_hyp_counter_mask(vcpu);
+
+		for_each_set_bit(i, &mask, ARMV8_PMU_MAX_GENERAL_COUNTERS)
+			write_pmevcntrn(i, 0);
+	}
+}
+
+/**
+ * kvm_pmu_direct_pmcr_read() - Handle guest reads from PMCR_EL0
+ * @vcpu: Pointer to vcpu struct
+ *
+ * Read physical pmcr_el0 and replace PMCR_EL0.N with the number of
+ * event counters partitioned to the guest.
+ *
+ * Return: Filtered PMCR_EL0 value
+ */
+u64 kvm_pmu_direct_pmcr_read(struct kvm_vcpu *vcpu)
+{
+	u64 n = vcpu->kvm->arch.nr_pmu_counters;
+
+	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
+		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
+
+	return u64_replace_bits(
+		read_sysreg(pmcr_el0),
+		n,
+		ARMV8_PMU_PMCR_N);
+}
+
 /**
  * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
  *
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f7f750b7a91c4..c8210a8b10389 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1092,9 +1092,204 @@ static u64 reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return __vcpu_sys_reg(vcpu, r->reg);
 }
 
+/**
+ * pmu_reg_write() - Register writes for Partitioned PMU
+ * @vcpu: Pointer to vcpu
+ * @reg: vcpu register
+ * @val: value to write
+ * @set: setting or clearing a mask
+ *
+ * Helper for sys_reg.c register accessor functions.
+ */
+static void pmu_reg_write(struct kvm_vcpu *vcpu, enum vcpu_sysreg reg, u64 val, bool set)
+{
+	unsigned long flags;
+	u64 mask;
+	int idx;
+
+	switch (reg) {
+	case PMCR_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm))
+			kvm_pmu_direct_pmcr_write(vcpu, val);
+		else
+			kvm_pmu_handle_pmcr(vcpu, val);
+		break;
+	case PMSELR_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm))
+			write_sysreg(val, pmselr_el0);
+		__vcpu_assign_sys_reg(vcpu, reg, val);
+		break;
+	case PMEVCNTR0_EL0 ... PMCCNTR_EL0:
+		idx = reg - PMEVCNTR0_EL0;
+
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			if (idx == ARMV8_PMU_CYCLE_IDX)
+				write_sysreg(val, pmccntr_el0);
+			else
+				write_pmevcntrn(idx, val);
+		} else {
+			kvm_pmu_set_counter_value(vcpu, idx, val);
+		}
+		break;
+	case PMEVTYPER0_EL0 ... PMCCFILTR_EL0:
+		idx = reg - PMEVTYPER0_EL0;
+
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			mask = kvm_pmu_evtyper_mask(vcpu->kvm);
+			__vcpu_assign_sys_reg(vcpu, reg, val & mask);
+		} else {
+			kvm_pmu_set_counter_event_type(vcpu, val, idx);
+			kvm_vcpu_pmu_restore_guest(vcpu);
+		}
+		break;
+	case PMCNTENSET_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			if (set)
+				write_sysreg(val, pmcntenset_el0);
+			else
+				write_sysreg(val, pmcntenclr_el0);
+		} else {
+			if (set)
+				/* accessing PMCNTENSET_EL0 */
+				__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, |=, val);
+			else
+				/* accessing PMINTENCLR_EL1 */
+				__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, &=, ~val);
+
+			kvm_pmu_reprogram_counter_mask(vcpu, val);
+		}
+		break;
+	case PMINTENSET_EL1:
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			if (set)
+				write_sysreg(val, pmintenset_el1);
+			else
+				write_sysreg(val, pmintenclr_el1);
+		} else {
+			if (set)
+				/* accessing PMINTENSET_EL1 */
+				__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, |=, val);
+			else
+				/* accessing PMINTENCLR_EL1 */
+				__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, ~val);
+		}
+		break;
+	case PMOVSSET_EL0:
+		local_irq_save(flags);
+		if (set) {
+			/* accessing PMOVSSET_EL0 */
+			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, val);
+		} else {
+			/* accessing PMOVSCLR_EL0 */
+			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~val);
+			if (kvm_pmu_is_partitioned(vcpu->kvm))
+				write_sysreg(val & kvm_pmu_guest_counter_mask(),
+					     pmovsclr_el0);
+		}
+		local_irq_restore(flags);
+		break;
+	case PMUSERENR_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm))
+			write_sysreg(val, pmuserenr_el0);
+		__vcpu_assign_sys_reg(vcpu, reg, val);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+}
+
+/**
+ * pmu_reg_read() - Register reads for Partitioned PMU
+ * @vcpu: Pointer to vcpu
+ * @reg: vcpu register
+ *
+ * Helper for sys_reg.c register accessor functions.
+ *
+ * Return: value read
+ */
+static u64 pmu_reg_read(struct kvm_vcpu *vcpu, enum vcpu_sysreg reg)
+{
+	unsigned long flags;
+	u64 val = 0;
+	int idx;
+
+	switch (reg) {
+	case PMCR_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm))
+			val = kvm_pmu_direct_pmcr_read(vcpu);
+		else
+			val = kvm_vcpu_read_pmcr(vcpu);
+		break;
+	case PMSELR_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm))
+			val = read_sysreg(pmselr_el0);
+		else
+			val = __vcpu_sys_reg(vcpu, reg);
+		break;
+	case PMEVCNTR0_EL0 ... PMCCNTR_EL0:
+		idx = reg - PMEVCNTR0_EL0;
+
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			if (idx == ARMV8_PMU_CYCLE_IDX)
+				val = read_sysreg(pmccntr_el0);
+			else
+				val = read_pmevcntrn(idx);
+		} else {
+			val = kvm_pmu_get_counter_value(vcpu, idx);
+		}
+		break;
+	case PMEVTYPER0_EL0 ... PMCCFILTR_EL0:
+		val = __vcpu_sys_reg(vcpu, reg);
+		break;
+	case PMCNTENSET_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			val = read_sysreg(pmcntenset_el0);
+			val &= kvm_pmu_guest_counter_mask();
+		} else {
+			val = __vcpu_sys_reg(vcpu, reg);
+		}
+		break;
+	case PMINTENSET_EL1:
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			val = read_sysreg(pmintenset_el1);
+			val &= kvm_pmu_guest_counter_mask();
+		} else {
+			val = __vcpu_sys_reg(vcpu, reg);
+		}
+		break;
+	case PMOVSSET_EL0:
+		local_irq_save(flags);
+		if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+			u64 hw_ovf = read_sysreg(pmovsset_el0) &
+				     kvm_pmu_guest_counter_mask();
+
+			if (hw_ovf) {
+				__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, hw_ovf);
+				write_sysreg(hw_ovf, pmovsclr_el0);
+			}
+		}
+		val = __vcpu_sys_reg(vcpu, reg);
+		local_irq_restore(flags);
+		break;
+	case PMUSERENR_EL0:
+		if (kvm_pmu_is_partitioned(vcpu->kvm))
+			val = read_sysreg(pmuserenr_el0);
+		else
+			val = __vcpu_sys_reg(vcpu, reg);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	return val;
+}
+
 static bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
 {
-	u64 reg = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	u64 reg = pmu_reg_read(vcpu, PMUSERENR_EL0);
 	bool enabled = (reg & flags) || vcpu_mode_priv(vcpu);
 
 	if (!enabled)
@@ -1133,18 +1328,17 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 	if (p->is_write) {
 		/*
-		 * Only update writeable bits of PMCR (continuing into
-		 * kvm_pmu_handle_pmcr() as well)
+		 * Only update writeable bits of PMCR
 		 */
-		val = kvm_vcpu_read_pmcr(vcpu);
+		val = pmu_reg_read(vcpu, PMCR_EL0);
 		val &= ~ARMV8_PMU_PMCR_MASK;
 		val |= p->regval & ARMV8_PMU_PMCR_MASK;
 		if (!kvm_supports_32bit_el0())
 			val |= ARMV8_PMU_PMCR_LC;
-		kvm_pmu_handle_pmcr(vcpu, val);
+		pmu_reg_write(vcpu, PMCR_EL0, val, 0);
 	} else {
 		/* PMCR.P & PMCR.C are RAZ */
-		val = kvm_vcpu_read_pmcr(vcpu)
+		val = pmu_reg_read(vcpu, PMCR_EL0)
 		      & ~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C);
 		p->regval = val;
 	}
@@ -1159,10 +1353,10 @@ static bool access_pmselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		return false;
 
 	if (p->is_write)
-		__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, p->regval);
+		pmu_reg_write(vcpu, PMSELR_EL0, p->regval, 0);
 	else
 		/* return PMSELR.SEL field */
-		p->regval = __vcpu_sys_reg(vcpu, PMSELR_EL0)
+		p->regval = pmu_reg_read(vcpu, PMSELR_EL0)
 			    & PMSELR_EL0_SEL_MASK;
 
 	return true;
@@ -1239,6 +1433,7 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 			      struct sys_reg_params *p,
 			      const struct sys_reg_desc *r)
 {
+	enum vcpu_sysreg reg;
 	u64 idx = ~0UL;
 
 	if (r->CRn == 9 && r->CRm == 13) {
@@ -1248,7 +1443,7 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 				return false;
 
 			idx = SYS_FIELD_GET(PMSELR_EL0, SEL,
-					    __vcpu_sys_reg(vcpu, PMSELR_EL0));
+					    pmu_reg_read(vcpu, PMSELR_EL0));
 		} else if (r->Op2 == 0) {
 			/* PMCCNTR_EL0 */
 			if (pmu_access_cycle_counter_el0_disabled(vcpu))
@@ -1276,18 +1471,21 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 	if (!pmu_counter_idx_valid(vcpu, idx))
 		return false;
 
+	reg = PMEVCNTR0_EL0 + idx;
+
 	if (p->is_write) {
 		if (pmu_access_el0_disabled(vcpu))
 			return false;
 
-		kvm_pmu_set_counter_value(vcpu, idx, p->regval);
+		pmu_reg_write(vcpu, reg, p->regval, 0);
 	} else {
-		p->regval = kvm_pmu_get_counter_value(vcpu, idx);
+		p->regval = pmu_reg_read(vcpu, reg);
 	}
 
 	return true;
 }
 
+
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
@@ -1298,7 +1496,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
 		/* PMXEVTYPER_EL0 */
-		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0));
+		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, pmu_reg_read(vcpu, PMSELR_EL0));
 		reg = PMEVTYPER0_EL0 + idx;
 	} else if (r->CRn == 14 && (r->CRm & 12) == 12) {
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
@@ -1314,12 +1512,10 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (!pmu_counter_idx_valid(vcpu, idx))
 		return false;
 
-	if (p->is_write) {
-		kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
-		kvm_vcpu_pmu_restore_guest(vcpu);
-	} else {
-		p->regval = __vcpu_sys_reg(vcpu, reg);
-	}
+	if (p->is_write)
+		pmu_reg_write(vcpu, reg, p->regval, 0);
+	else
+		p->regval = pmu_reg_read(vcpu, reg);
 
 	return true;
 }
@@ -1353,16 +1549,9 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	mask = kvm_pmu_accessible_counter_mask(vcpu);
 	if (p->is_write) {
 		val = p->regval & mask;
-		if (r->Op2 & 0x1)
-			/* accessing PMCNTENSET_EL0 */
-			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, |=, val);
-		else
-			/* accessing PMCNTENCLR_EL0 */
-			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, &=, ~val);
-
-		kvm_pmu_reprogram_counter_mask(vcpu, val);
+		pmu_reg_write(vcpu, PMCNTENSET_EL0, val, r->Op2 & 0x1);
 	} else {
-		p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+		p->regval = pmu_reg_read(vcpu, PMCNTENSET_EL0);
 	}
 
 	return true;
@@ -1371,22 +1560,17 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {
-	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+	u64 val, mask;
 
 	if (check_pmu_access_disabled(vcpu, 0))
 		return false;
 
+	mask = kvm_pmu_accessible_counter_mask(vcpu);
 	if (p->is_write) {
-		u64 val = p->regval & mask;
-
-		if (r->Op2 & 0x1)
-			/* accessing PMINTENSET_EL1 */
-			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, |=, val);
-		else
-			/* accessing PMINTENCLR_EL1 */
-			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, ~val);
+		val = p->regval & mask;
+		pmu_reg_write(vcpu, PMINTENSET_EL1, val, r->Op2 & 0x1);
 	} else {
-		p->regval = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
+		p->regval = pmu_reg_read(vcpu, PMINTENSET_EL1);
 	}
 
 	return true;
@@ -1453,20 +1637,18 @@ static int set_pmmir(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
-	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+	u64 val, mask;
 
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
+	mask = kvm_pmu_accessible_counter_mask(vcpu);
+
 	if (p->is_write) {
-		if (r->CRm & 0x2)
-			/* accessing PMOVSSET_EL0 */
-			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
-		else
-			/* accessing PMOVSCLR_EL0 */
-			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~(p->regval & mask));
+		val = p->regval & mask;
+		pmu_reg_write(vcpu, PMOVSSET_EL0, val, r->CRm & 0x2);
 	} else {
-		p->regval = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
+		p->regval = pmu_reg_read(vcpu, PMOVSSET_EL0);
 	}
 
 	return true;
@@ -1495,10 +1677,9 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		if (!vcpu_mode_priv(vcpu))
 			return undef_access(vcpu, p, r);
 
-		__vcpu_assign_sys_reg(vcpu, PMUSERENR_EL0,
-				      (p->regval & ARMV8_PMU_USERENR_MASK));
+		pmu_reg_write(vcpu, PMUSERENR_EL0, p->regval & ARMV8_PMU_USERENR_MASK, 0);
 	} else {
-		p->regval = __vcpu_sys_reg(vcpu, PMUSERENR_EL0)
+		p->regval = pmu_reg_read(vcpu, PMUSERENR_EL0)
 			    & ARMV8_PMU_USERENR_MASK;
 	}
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 45ed338ee7504..a24788243ac99 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -98,6 +98,8 @@ void kvm_vcpu_pmu_resync_el0(void);
 bool has_kvm_pmu_partition_support(void);
 void kvm_pmu_partition_enable(struct kvm *kvm, bool enable);
 bool kvm_pmu_is_partitioned(struct kvm *kvm);
+void kvm_pmu_direct_pmcr_write(struct kvm_vcpu *vcpu, u64 val);
+u64 kvm_pmu_direct_pmcr_read(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_host_counter_mask(void);
 u64 kvm_pmu_guest_counter_mask(void);
 /*
@@ -143,6 +145,11 @@ static inline bool kvm_pmu_is_partitioned(struct kvm *kvm)
 {
 	return false;
 }
+static inline void kvm_pmu_direct_pmcr_write(struct kvm_vcpu *vcpu, u64 val) {}
+static inline u64 kvm_pmu_direct_pmcr_read(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
-- 
2.56.0.rc1.310.g51773c2048-goog

