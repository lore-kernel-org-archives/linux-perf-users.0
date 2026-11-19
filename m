Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114351;
	b=VLJkGO/oDmQkRJDK20FDY6bq8QUHQmDZXfEmxqDtGHErjzzzD96JQOwGprpC1Ea/1Otc
	 cTUilv+fFNsEGgPMEjzG1o/T/90TpYkHcHMirkEG1tTlWzEK3/U4VJd/JvwN9eSq2y9db
	 lH67XC8VhsYqTrgp82zS5H4F1ASvsnqJpj2PEVYzAESjhMsKBx6Wy4MnUYxqfa6d5WVNH
	 BZd4cO5IlUEndKC+JJHXQrdFXntGDJmSnVK1uzlUTUq9drXSdQFYbcx6i9m6No0i60JHe
	 IYCGPT+xek8p7AyEcPK+0ljZUFoOmwlbdabWawQMlwqafjJcNsueMH23Ly9XoaG1biA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/cHlFyJ7er1p9zZEGuuY8f/jGV8qIbeyFzalWcXy1r4=;
	b=grEUITd/HUfcLQUMpokbYcRJT6EAMkSQagpBg/GPvbyTIQSKcZaItu7JG4HOqumAR0Pz
	 F5GQjH2ose4Y53JmhMMjnQSASKT6AmwT238vKkco7MIOTOZBaxhynFNRn9C9CZpeJZz2O
	 80bzR6PpwFpWWh0WSUD0fy1/fvay3qO8+H5UfmiBGo8nQbfojfcq3Cq32A9QrYDqlSf50
	 k2surYcXeJLu38KXa9Hm8szWuZ6kTGwsQw0cK8gcJHUTIvbmXOwLhTnKWBdaprIixiM5C
	 x3qteblJ1nPL7hpDrOUvferHLH1f7aPEQaq9pJ3L6pZPxLJaNeThfnK9OOq38aTUweg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmbQbxHx;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA631606C116
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA631606C116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmbQbxHx
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-5384e381fbbso131477b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114350; x=1795719150; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cHlFyJ7er1p9zZEGuuY8f/jGV8qIbeyFzalWcXy1r4=;
        b=dmbQbxHxRYaRd9wZjhOTimibKBAWd/fBYWsPJkvEO3PKAPFGqIOdS70fV+Png4u5ee
         h4vnpdU1SGd6RV0KIEM2ZbCutWdL7D4zqSBbIBb0LOvZfdGJlxdEFt/othyiOsS6Xiul
         5WyJnoGt8OuJnUdr/xmvCQOHXOdPot1+GwusZV10/O+7KlGMcupr+o9ICVqvuIXnY/+H
         ilpsYHV8MJtLwUpn/znE+Ia9ntOs6JWQoBh9UGMuj22TEQjmwSEvyS3kKpqSF30jcWUM
         O6dRiPCvek7M7lvEfO7s8EsLTDhvH9v7oR85vL+jAPXw3wodjvdKX1nkGAyE0ANKQpDT
         XwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114350; x=1795719150;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/cHlFyJ7er1p9zZEGuuY8f/jGV8qIbeyFzalWcXy1r4=;
        b=v2+lJT++ri3UoPC8aJSp+swuYtE5MJ0adAC83i2nrgkAlHnKovntLr0uE9Sg7MjtaA
         VOb4++f6hwuhfaQbGi/SaanNyYbMcv+Wa5ZzI/+xyJAT35zVZk0Gv03fAMuF1c1v+W87
         9Vc5RYi5WDRgmw9yOZbnhYEWWbWsBbsrXFOlg43P2xgTb0sRYfWjtZ7WDX5gDwgT6xco
         oZdvxnsJPudUoEad2IbjuJMA01V9W07HnkMDk50IfQtBCFvPqTxl/5Y+4036egOIOzag
         9R/oB63iLt50aOhRnxa5BaFmrLiSellpSqLta9xpGbOZXHqhIdp/Y9hAarGkhmlaFaK7
         sLJQ==
X-Forwarded-Encrypted: i=1; AL+hErGhWlmTMHiiq+rEWFIHcL2Rz0Jeg3tX/uTr4jmLcWUzP9nJIwnxrz7OtepACw73KTx/F4yJjhK0Us3S8yAz5b9Q@vger.kernel.org
X-Gm-Message-State: APuU4Z+wEi2/dY/jQ/hocVK6qhsXL8Q7aS+4Itoe/1XUahlSPZblW5no
	/bE1BGFdIDKX8CM0HlFvytMvve5v9xjVbJ/T8hj9Kv6Gh27HtwSVYRnXR3YjDRX/qPBmzDFfaTx
	h2mPZMMguswE22PUcVR1i4nLwNg==
X-Received: from ilre4.prod.google.com ([2002:a92:de44:0:b0:523:5388:be99])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c2bd:b0:576:1161:dece with SMTP id 5614622812f47-57a0b44d7f1mr1001393b6e.42.1795114349506;
 Thu, 19 Nov 2026 10:52:29 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:56 +0000
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
Message-ID: <20261119185215.632334-15-coltonlewis@google.com>
Subject: [PATCH v10 14/33] KVM: arm64: Add Partitioned PMU register trap handlers
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

Even when a VM uses a Partitioned PMU, PMU register accesses still trap
to EL2 when the host lacks FEAT_FGT, when accessing registers that
remain trapped via FGT (PMOVS, PMEVTYPER<n>_EL0, PMCCFILTR_EL0), or when
MDCR_EL2.TPM / MDCR_EL2.TPMCR is active for a nested context.

Add kvm_pmu_direct_reg_read() and kvm_pmu_direct_reg_write() in
arch/arm64/kvm/pmu-direct.c under a single guard(preempt)() per call and
dispatch partitioned accesses from pmu_reg_read() and pmu_reg_write() in
arch/arm64/kvm/sys_regs.c:
- Read and write live hardware registers when the partitioned PMU is
  loaded on the local CPU (masking counter bitmaps to the guest
  partition), and fall back to the shadow sys_regs[] array otherwise.
- Clear guest overflow bits in both physical pmovsclr_el0 and shadow
  PMOVSSET_EL0 on PMOVSCLR_EL0 writes, and harvest live hardware guest
  overflow bits into shadow PMOVSSET_EL0 on PMOVS reads.
- Record filtered guest PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 values in
  sys_regs[]; a subsequent patch enforces the KVM PMU event filter in
  hardware.
- Add kvm_pmu_get_pmselr() in arch/arm64/kvm/emulate-nested.c so
  check_mdcr_hpmn() evaluates the live PMSELR_EL0 counter selector on
  trapped PMXEVTYPER_EL0 and PMXEVCNTR_EL0 accesses.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/emulate-nested.c |  12 +-
 arch/arm64/kvm/pmu-direct.c     | 252 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c       | 157 ++++++++++++++------
 include/kvm/arm_pmu.h           |  13 ++
 4 files changed, 383 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 2bec816683614..1cd2f42452fe7 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -562,12 +562,19 @@ static enum trap_behaviour check_cptr_tta(struct kvm_vcpu *vcpu)
 	return BEHAVE_HANDLE_LOCALLY;
 }
 
+static u64 kvm_pmu_get_pmselr(struct kvm_vcpu *vcpu)
+{
+	if (kvm_pmu_is_partitioned(vcpu->kvm))
+		return kvm_pmu_direct_reg_read(vcpu, PMSELR_EL0);
+
+	return __vcpu_sys_reg(vcpu, PMSELR_EL0);
+}
+
 static enum trap_behaviour check_mdcr_hpmn(struct kvm_vcpu *vcpu)
 {
 	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
 	unsigned int idx;
 
-
 	switch (sysreg) {
 	case SYS_PMEVTYPERn_EL0(0) ... SYS_PMEVTYPERn_EL0(30):
 	case SYS_PMEVCNTRn_EL0(0) ... SYS_PMEVCNTRn_EL0(30):
@@ -575,8 +582,7 @@ static enum trap_behaviour check_mdcr_hpmn(struct kvm_vcpu *vcpu)
 		break;
 	case SYS_PMXEVTYPER_EL0:
 	case SYS_PMXEVCNTR_EL0:
-		idx = SYS_FIELD_GET(PMSELR_EL0, SEL,
-				    __vcpu_sys_reg(vcpu, PMSELR_EL0));
+		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, kvm_pmu_get_pmselr(vcpu));
 		break;
 	default:
 		/* Someone used this trap helper for something else... */
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index b1c180ae79d9d..13f5bcc2a9084 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -4,7 +4,9 @@
  * Author: Colton Lewis <coltonlewis@google.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/kvm_host.h>
+#include <linux/lockdep.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
 
@@ -64,6 +66,17 @@ bool kvm_pmu_is_partitioned(struct kvm *kvm)
 	return kvm && test_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &kvm->arch.flags);
 }
 
+static bool kvm_pmu_part_on_cpu(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+
+	lockdep_assert_preemption_disabled();
+
+	return kvm_pmu_is_partitioned(vcpu->kvm) &&
+	       vcpu == kvm_get_running_vcpu() && pmu &&
+	       cpumask_test_cpu(smp_processor_id(), &pmu->supported_cpus);
+}
+
 static u64 kvm_vcpu_pmu_guest_counter_mask(struct kvm_vcpu *vcpu)
 {
 	if (vcpu && kvm_pmu_is_partitioned(vcpu->kvm)) {
@@ -79,6 +92,245 @@ static u64 kvm_vcpu_pmu_guest_counter_mask(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void kvm_pmu_direct_pmcr_write(struct kvm_vcpu *vcpu, u64 val)
+{
+	bool reset_p = val & ARMV8_PMU_PMCR_P;
+	bool reset_c = val & ARMV8_PMU_PMCR_C;
+	unsigned long mask;
+	u64 pmcr_mask;
+	int i;
+
+	lockdep_assert_preemption_disabled();
+
+	if (!kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, V3P5))
+		val &= ~ARMV8_PMU_PMCR_LP;
+
+	pmcr_mask = ARMV8_PMU_PMCR_MASK &
+		    ~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C);
+	__vcpu_rmw_sys_reg(vcpu, PMCR_EL0, &=, ~ARMV8_PMU_PMCR_MASK);
+	__vcpu_rmw_sys_reg(vcpu, PMCR_EL0, |=, val & pmcr_mask);
+
+	if (reset_c)
+		__vcpu_assign_sys_reg(vcpu, PMCCNTR_EL0, 0);
+
+	mask = kvm_pmu_accessible_counter_mask(vcpu) &
+	       ~BIT(ARMV8_PMU_CYCLE_IDX);
+	if (reset_p) {
+		for_each_set_bit(i, &mask, ARMV8_PMU_MAX_GENERAL_COUNTERS)
+			__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, 0);
+	}
+
+	if (!kvm_pmu_part_on_cpu(vcpu))
+		return;
+
+	if (reset_c)
+		write_pmccntr(0);
+
+	if (reset_p) {
+		for_each_set_bit(i, &mask, ARMV8_PMU_MAX_GENERAL_COUNTERS)
+			write_pmevcntrn(i, 0);
+	}
+
+	write_sysreg(val & ~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C), pmcr_el0);
+}
+
+static u64 kvm_pmu_direct_pmcr_read(struct kvm_vcpu *vcpu)
+{
+	u64 n = vcpu->kvm->arch.nr_pmu_counters;
+	u64 pmcr;
+
+	lockdep_assert_preemption_disabled();
+
+	if (!kvm_pmu_part_on_cpu(vcpu))
+		return kvm_vcpu_read_pmcr(vcpu);
+
+	pmcr = read_sysreg(pmcr_el0);
+	if (!kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, V3P5))
+		pmcr &= ~ARMV8_PMU_PMCR_LP;
+
+	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
+		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
+
+	return u64_replace_bits(pmcr, n, ARMV8_PMU_PMCR_N);
+}
+
+static u64 kvm_pmu_direct_cntr_read(struct kvm_vcpu *vcpu, u8 idx)
+{
+	lockdep_assert_preemption_disabled();
+
+	if (!kvm_pmu_part_on_cpu(vcpu))
+		return __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + idx);
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		return read_pmccntr();
+
+	return read_pmevcntrn(idx);
+}
+
+static void kvm_pmu_direct_cntr_write(struct kvm_vcpu *vcpu, u8 idx, u64 val)
+{
+	lockdep_assert_preemption_disabled();
+
+	__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + idx, val);
+	if (!kvm_pmu_part_on_cpu(vcpu))
+		return;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		write_pmccntr(val);
+	else
+		write_pmevcntrn(idx, val);
+}
+
+/**
+ * kvm_pmu_direct_reg_read() - Read a guest PMU register for Partitioned PMU
+ * @vcpu: Pointer to vcpu struct
+ * @reg: vCPU system register index
+ *
+ * Return: Register value read from hardware or shadow state
+ */
+u64 kvm_pmu_direct_reg_read(struct kvm_vcpu *vcpu, unsigned int reg)
+{
+	unsigned long flags;
+	u64 val = 0;
+
+	guard(preempt)();
+
+	switch (reg) {
+	case PMCR_EL0:
+		return kvm_pmu_direct_pmcr_read(vcpu);
+	case PMSELR_EL0:
+		if (kvm_pmu_part_on_cpu(vcpu) &&
+		    !(vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+			return read_sysreg(pmselr_el0);
+		return __vcpu_sys_reg(vcpu, reg);
+	case PMEVCNTR0_EL0 ... PMCCNTR_EL0:
+		return kvm_pmu_direct_cntr_read(vcpu, reg - PMEVCNTR0_EL0);
+	case PMEVTYPER0_EL0 ... PMCCFILTR_EL0:
+		return __vcpu_sys_reg(vcpu, reg);
+	case PMCNTENSET_EL0:
+		if (kvm_pmu_part_on_cpu(vcpu))
+			return read_sysreg(pmcntenset_el0) &
+			       kvm_vcpu_pmu_guest_counter_mask(vcpu);
+		return __vcpu_sys_reg(vcpu, reg);
+	case PMINTENSET_EL1:
+		if (kvm_pmu_part_on_cpu(vcpu))
+			return read_sysreg(pmintenset_el1) &
+			       kvm_vcpu_pmu_guest_counter_mask(vcpu);
+		return __vcpu_sys_reg(vcpu, reg);
+	case PMOVSSET_EL0:
+		local_irq_save(flags);
+		if (kvm_pmu_part_on_cpu(vcpu)) {
+			u64 hw_ovf = read_sysreg(pmovsset_el0) &
+				     kvm_vcpu_pmu_guest_counter_mask(vcpu);
+
+			if (hw_ovf) {
+				__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, hw_ovf);
+				write_sysreg(hw_ovf, pmovsclr_el0);
+			}
+		}
+		val = __vcpu_sys_reg(vcpu, reg);
+		local_irq_restore(flags);
+		return val;
+	case PMUSERENR_EL0:
+		if (kvm_pmu_part_on_cpu(vcpu) &&
+		    !(vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+			return read_sysreg(pmuserenr_el0);
+		return __vcpu_sys_reg(vcpu, reg);
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
+/**
+ * kvm_pmu_direct_reg_write() - Write a guest PMU register for Partitioned PMU
+ * @vcpu: Pointer to vcpu struct
+ * @reg: vCPU system register index
+ * @val: Value to write
+ * @set: True when setting bits, false when clearing bits in mask registers
+ */
+void kvm_pmu_direct_reg_write(struct kvm_vcpu *vcpu, unsigned int reg,
+			      u64 val, bool set)
+{
+	unsigned long flags;
+	u64 mask;
+	int idx;
+
+	guard(preempt)();
+
+	switch (reg) {
+	case PMCR_EL0:
+		kvm_pmu_direct_pmcr_write(vcpu, val);
+		break;
+	case PMSELR_EL0:
+		if (kvm_pmu_part_on_cpu(vcpu) &&
+		    !(vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+			write_sysreg(val, pmselr_el0);
+		__vcpu_assign_sys_reg(vcpu, reg, val);
+		break;
+	case PMEVCNTR0_EL0 ... PMCCNTR_EL0:
+		idx = reg - PMEVCNTR0_EL0;
+		if (vcpu_mode_is_32bit(vcpu) && idx != ARMV8_PMU_CYCLE_IDX)
+			val = (kvm_pmu_direct_cntr_read(vcpu, idx) &
+			       GENMASK_ULL(63, 32)) |
+			      lower_32_bits(val);
+		kvm_pmu_direct_cntr_write(vcpu, idx, val);
+		break;
+	case PMEVTYPER0_EL0 ... PMCCFILTR_EL0:
+		mask = kvm_pmu_evtyper_mask(vcpu->kvm);
+		if (reg == PMCCFILTR_EL0)
+			mask &= ~kvm_pmu_event_mask(vcpu->kvm);
+		__vcpu_assign_sys_reg(vcpu, reg, val & mask);
+		break;
+	case PMCNTENSET_EL0:
+		val &= kvm_vcpu_pmu_guest_counter_mask(vcpu);
+		if (set) {
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, |=, val);
+			if (kvm_pmu_part_on_cpu(vcpu))
+				write_sysreg(val, pmcntenset_el0);
+		} else {
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, &=, ~val);
+			if (kvm_pmu_part_on_cpu(vcpu))
+				write_sysreg(val, pmcntenclr_el0);
+		}
+		break;
+	case PMINTENSET_EL1:
+		val &= kvm_vcpu_pmu_guest_counter_mask(vcpu);
+		if (set) {
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, |=, val);
+			if (kvm_pmu_part_on_cpu(vcpu))
+				write_sysreg(val, pmintenset_el1);
+		} else {
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, ~val);
+			if (kvm_pmu_part_on_cpu(vcpu))
+				write_sysreg(val, pmintenclr_el1);
+		}
+		break;
+	case PMOVSSET_EL0:
+		local_irq_save(flags);
+		if (set) {
+			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, val);
+		} else {
+			mask = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+			if (kvm_pmu_part_on_cpu(vcpu))
+				write_sysreg(val & mask, pmovsclr_el0);
+			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~val);
+		}
+		local_irq_restore(flags);
+		break;
+	case PMUSERENR_EL0:
+		val &= ARMV8_PMU_USERENR_MASK;
+		if (kvm_pmu_part_on_cpu(vcpu) &&
+		    !(vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+			write_sysreg(val, pmuserenr_el0);
+		__vcpu_assign_sys_reg(vcpu, reg, val);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
 /**
  * kvm_pmu_guest_counter_mask() - Compute bitmask of guest-reserved counters
  *
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2d9ae781acff0..db6f3adcaae7c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1089,9 +1089,85 @@ static u64 reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return __vcpu_sys_reg(vcpu, r->reg);
 }
 
+static u64 pmu_reg_read(struct kvm_vcpu *vcpu, enum vcpu_sysreg reg)
+{
+	if (kvm_pmu_is_partitioned(vcpu->kvm))
+		return kvm_pmu_direct_reg_read(vcpu, reg);
+
+	switch (reg) {
+	case PMCR_EL0:
+		return kvm_vcpu_read_pmcr(vcpu);
+	case PMEVCNTR0_EL0 ... PMCCNTR_EL0:
+		return kvm_pmu_get_counter_value(vcpu, reg - PMEVCNTR0_EL0);
+	case PMSELR_EL0:
+	case PMEVTYPER0_EL0 ... PMCCFILTR_EL0:
+	case PMCNTENSET_EL0:
+	case PMINTENSET_EL1:
+	case PMOVSSET_EL0:
+	case PMUSERENR_EL0:
+		return __vcpu_sys_reg(vcpu, reg);
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
+static void pmu_reg_write(struct kvm_vcpu *vcpu, enum vcpu_sysreg reg, u64 val,
+			  bool set)
+{
+	int idx;
+
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		kvm_pmu_direct_reg_write(vcpu, reg, val, set);
+		return;
+	}
+
+	switch (reg) {
+	case PMCR_EL0:
+		kvm_pmu_handle_pmcr(vcpu, val);
+		break;
+	case PMSELR_EL0:
+		__vcpu_assign_sys_reg(vcpu, reg, val);
+		break;
+	case PMEVCNTR0_EL0 ... PMCCNTR_EL0:
+		kvm_pmu_set_counter_value(vcpu, reg - PMEVCNTR0_EL0, val);
+		break;
+	case PMEVTYPER0_EL0 ... PMCCFILTR_EL0:
+		idx = reg - PMEVTYPER0_EL0;
+		kvm_pmu_set_counter_event_type(vcpu, val, idx);
+		kvm_vcpu_pmu_restore_guest(vcpu);
+		break;
+	case PMCNTENSET_EL0:
+		if (set)
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, |=, val);
+		else
+			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, &=, ~val);
+		kvm_pmu_reprogram_counter_mask(vcpu, val);
+		break;
+	case PMINTENSET_EL1:
+		if (set)
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, |=, val);
+		else
+			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, ~val);
+		break;
+	case PMOVSSET_EL0:
+		if (set)
+			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, val);
+		else
+			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~val);
+		break;
+	case PMUSERENR_EL0:
+		__vcpu_assign_sys_reg(vcpu, reg, val & ARMV8_PMU_USERENR_MASK);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
 static bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
 {
-	u64 reg = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	u64 reg = pmu_reg_read(vcpu, PMUSERENR_EL0);
 	bool enabled = (reg & flags) || vcpu_mode_priv(vcpu);
 
 	if (!enabled)
@@ -1130,18 +1206,17 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
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
@@ -1156,10 +1231,10 @@ static bool access_pmselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
@@ -1236,6 +1311,7 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 			      struct sys_reg_params *p,
 			      const struct sys_reg_desc *r)
 {
+	enum vcpu_sysreg reg;
 	u64 idx = ~0UL;
 
 	if (r->CRn == 9 && r->CRm == 13) {
@@ -1245,7 +1321,7 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 				return false;
 
 			idx = SYS_FIELD_GET(PMSELR_EL0, SEL,
-					    __vcpu_sys_reg(vcpu, PMSELR_EL0));
+					    pmu_reg_read(vcpu, PMSELR_EL0));
 		} else if (r->Op2 == 0) {
 			/* PMCCNTR_EL0 */
 			if (pmu_access_cycle_counter_el0_disabled(vcpu))
@@ -1273,13 +1349,15 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
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
@@ -1295,7 +1373,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
 		/* PMXEVTYPER_EL0 */
-		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0));
+		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, pmu_reg_read(vcpu, PMSELR_EL0));
 		reg = PMEVTYPER0_EL0 + idx;
 	} else if (r->CRn == 14 && (r->CRm & 12) == 12) {
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
@@ -1311,12 +1389,10 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
@@ -1350,16 +1426,9 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
-		p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
+		p->regval = pmu_reg_read(vcpu, PMCNTENSET_EL0) & mask;
 	}
 
 	return true;
@@ -1368,22 +1437,17 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
-		p->regval = __vcpu_sys_reg(vcpu, PMINTENSET_EL1) & mask;
+		p->regval = pmu_reg_read(vcpu, PMINTENSET_EL1) & mask;
 	}
 
 	return true;
@@ -1450,20 +1514,18 @@ static int set_pmmir(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
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
-		p->regval = __vcpu_sys_reg(vcpu, PMOVSSET_EL0) & mask;
+		p->regval = pmu_reg_read(vcpu, PMOVSSET_EL0) & mask;
 	}
 
 	return true;
@@ -1492,10 +1554,9 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
index e06255e46a4d8..276ab74fa0208 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -98,6 +98,9 @@ void kvm_vcpu_pmu_resync_el0(void);
 bool has_kvm_pmu_partition_support(void);
 void kvm_pmu_partition_enable(struct kvm *kvm, bool enable);
 bool kvm_pmu_is_partitioned(struct kvm *kvm);
+u64 kvm_pmu_direct_reg_read(struct kvm_vcpu *vcpu, unsigned int reg);
+void kvm_pmu_direct_reg_write(struct kvm_vcpu *vcpu, unsigned int reg,
+			      u64 val, bool set);
 u64 kvm_pmu_guest_counter_mask(void);
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
@@ -137,6 +140,16 @@ static inline bool kvm_pmu_is_partitioned(struct kvm *kvm)
 {
 	return false;
 }
+
+static inline u64 kvm_pmu_direct_reg_read(struct kvm_vcpu *vcpu,
+					  unsigned int reg)
+{
+	return 0;
+}
+
+static inline void kvm_pmu_direct_reg_write(struct kvm_vcpu *vcpu,
+					    unsigned int reg, u64 val,
+					    bool set) {}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
-- 
2.56.1.708.g77570a6a1d-goog

