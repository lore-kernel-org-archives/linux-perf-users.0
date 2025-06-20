Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF857242D70
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457941; cv=none; b=N9SUhVGj4lmjRy9HjIu7ipTImWDpHg1n5ieEQiAbynqdSL21QZMYb6HeH2yefzzFQ6aPJ9iJiALaWwKUqPF/02MxrD7LCJlaQOp/qMIEmKTEMeG0TIlc/aWUrG04Bwqdu+648cJdiUYUfBWQII6vGIQ2kpyFg4eZNsmUhl2fVPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457941; c=relaxed/simple;
	bh=XOdKUxQ/QaGZqU+z2DC4uMCuspeHUckAli7oazP7b6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jD4zq111kGsg8mSFe78Z10YTAoxNJjl/wjMdV1xEQZTbuTVIrSdui/gAVQ0xKA1UZdhnMw5vxkA/Rw1N7rcYRJoTZTs1imsR++a7wl6UioI1baAIfESv5UvtqlHp1cZB1CEgQWsV0qVIkLqwTuNIaZkcZ7V+qaglFFN+qxHkpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LsrcqHL3; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsrcqHL3"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddd03db24dso22023375ab.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457936; x=1751062736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TLkE+mPccNF7FZJHZATw8blfiE6UPhgsaqmd9jjOMk=;
        b=LsrcqHL3r8Es2ZiydwnybToSwjW1N2Mjx/UxIO0m0BUMLD84EdbTIjNVNX2rHY3rSX
         LXA9w109dhqZ31sOWBfgPu7EPMZg776TgPw9f3bu9KYEOf4Kbap+0L1oMZum0kGTil4q
         I+RI6f5AmgcX/U4nPVznW+LiRfUNVy+0qFdTAxS//FRlhbu8pFiLv6rlqbVfhvtvsZhG
         ZWxDDjefRqJ75oocRMdlV3UoXiomnc6Os8P1AfC5hc8BBp7TVR5MPrJLLmAVvXIiWJtA
         1n/AYIw4Aob01GDVOkuuXEP6gQ2L2O6g8Z6mrHSR8hYbqj4YJV2kYALWG7fuwIX36DdF
         dS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457936; x=1751062736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TLkE+mPccNF7FZJHZATw8blfiE6UPhgsaqmd9jjOMk=;
        b=HepYZ/kxsiqxZPbBcYvJhEvl+m9DH3lqziEHbSyJ+XwZ+sqPz1K8hOevE9Lm/yxQmz
         uGHMlo2vgSs1AC9c5u/OUlBiOdI9NSNNrpTp5kQWOn+MvQXx8PWVVGgcaPC58oGr7sZq
         5AdhyLFmmoiS+WX2V3Rgh3L7wZbaof16xwH7Sugu+hN9R9u7KHbbZ3w2UYTK89UAuaeU
         EoeCU1jmaW7xY6snkXcOU8738KqzqRts87ARmf/7lZLLP7tzsAgqAgmy6aJDsAnOlfeo
         ZrJDNd7fdbsB8Y8A+yEjXIuSr+5O8HJ1Cg0lo33BpbzgfLNQ/ppun1D+bBCBQPDrC/aR
         PmAA==
X-Forwarded-Encrypted: i=1; AJvYcCWQPQYTmRqKnEaOq0a5W2+2dOXuJ4mxLgR4ctvldlI2rEr/3wwr4LOF1el65iJkxFw1ISOu7vm3d8WKoG1unhzj@vger.kernel.org
X-Gm-Message-State: AOJu0YylnBLSdAP+icv/YnV/hLDYD6Y0CHMMxUntwg/hd+Z9dFU4+Zzt
	R0aiSXv7+dXy/QeOp0wvyqG3maoY2vUxaU8UvVp/cI/kWKHM68D9l7/Vnx6PkOqCnE9teohBPse
	PGrqSmcqfgcw5/qhLzjInlyWvYw==
X-Google-Smtp-Source: AGHT+IE6oh+D/93u2i5FqfrM7fWzDsA+dS03dbCH1axzjP2fK0KgI8fFqm+kYjEF6gu4aMgcIodY83nkJvGivBM9cg==
X-Received: from ilue6.prod.google.com ([2002:a05:6e02:b26:b0:3dd:b662:5c3b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:168d:b0:3dc:787f:2bb7 with SMTP id e9e14a558f8ab-3de38cba89amr46469765ab.17.1750457936356;
 Fri, 20 Jun 2025 15:18:56 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:19 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-20-coltonlewis@google.com>
Subject: [PATCH v2 18/23] KVM: arm64: Context swap Partitioned PMU guest registers
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Save and restore newly untrapped registers that will be directly
accessed by the guest when the PMU is partitioned.

* PMEVCNTRn_EL0
* PMCCNTR_EL0
* PMICNTR_EL0
* PMUSERENR_EL0
* PMSELR_EL0
* PMCR_EL0
* PMCNTEN_EL0
* PMINTEN_EL1

If the PMU is not partitioned or MDCR_EL2.TPM is set, all PMU
registers are trapped so return immediately.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h |   2 +
 arch/arm64/include/asm/kvm_pmu.h  |   2 +
 arch/arm64/kvm/arm.c              |   2 +
 arch/arm64/kvm/pmu-part.c         | 101 ++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2df76689381a..374771557d2c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -453,9 +453,11 @@ enum vcpu_sysreg {
 	PMEVCNTR0_EL0,	/* Event Counter Register (0-30) */
 	PMEVCNTR30_EL0 = PMEVCNTR0_EL0 + 30,
 	PMCCNTR_EL0,	/* Cycle Counter Register */
+	PMICNTR_EL0,	/* Instruction Counter Register */
 	PMEVTYPER0_EL0,	/* Event Type Register (0-30) */
 	PMEVTYPER30_EL0 = PMEVTYPER0_EL0 + 30,
 	PMCCFILTR_EL0,	/* Cycle Count Filter Register */
+	PMICFILTR_EL0,	/* Insturction Count Filter Register */
 	PMCNTENSET_EL0,	/* Count Enable Set Register */
 	PMINTENSET_EL1,	/* Interrupt Enable Set Register */
 	PMOVSSET_EL0,	/* Overflow Flag Status Set Register */
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 1b68f1a706d1..208893485027 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -96,6 +96,8 @@ void kvm_pmu_host_counters_disable(void);
 
 u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
 u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
+void kvm_pmu_load(struct kvm_vcpu *vcpu);
+void kvm_pmu_put(struct kvm_vcpu *vcpu);
 
 #if !defined(__KVM_NVHE_HYPERVISOR__)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e452aba1a3b2..7c007ee44ecb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -616,6 +616,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_vcpu_load_vhe(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
 	kvm_vcpu_pmu_restore_guest(vcpu);
+	kvm_pmu_load(vcpu);
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
 
@@ -658,6 +659,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_timer_vcpu_put(vcpu);
 	kvm_vgic_put(vcpu);
 	kvm_vcpu_pmu_restore_host(vcpu);
+	kvm_pmu_put(vcpu);
 	if (vcpu_has_nv(vcpu))
 		kvm_vcpu_put_hw_mmu(vcpu);
 	kvm_arm_vmid_clear_active();
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 289f396bd887..19bd6e0da222 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -8,6 +8,7 @@
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
 
+#include <asm/kvm_emulate.h>
 #include <asm/kvm_pmu.h>
 #include <asm/arm_pmuv3.h>
 
@@ -175,3 +176,103 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 
 	return hpmn;
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
+	u64 mask = kvm_pmu_guest_counter_mask(pmu);
+	u8 i;
+	u64 val;
+
+	/*
+	 * If the PMU is not partitioned or we have MDCR_EL2_TPM,
+	 * every PMU access is trapped so don't bother with the swap.
+	 */
+	if (!kvm_pmu_is_partitioned(pmu) || (vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+		return;
+
+	for (i = 0; i < pmu->hpmn_max; i++) {
+		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
+		write_pmevcntrn(i, val);
+	}
+
+	val = __vcpu_sys_reg(vcpu, PMCCNTR_EL0);
+	write_pmccntr(val);
+
+	val = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	write_pmuserenr(val);
+
+	val = __vcpu_sys_reg(vcpu, PMSELR_EL0);
+	write_pmselr(val);
+
+	val = __vcpu_sys_reg(vcpu, PMCR_EL0);
+	write_pmcr(val);
+
+	/*
+	 * Loading these registers is tricky because of
+	 * 1. Applying only the bits for guest counters (indicated by mask)
+	 * 2. Setting and clearing are different registers
+	 */
+	val = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+	write_pmcntenset(val & mask);
+	write_pmcntenclr(~val & mask);
+
+	val = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
+	write_pmintenset(val & mask);
+	write_pmintenclr(~val & mask);
+}
+
+/**
+ * kvm_pmu_put() - Put untrapped PMU registers
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Put all untrapped PMU registers from the VCPU into the PCPU. Mask
+ * to only bits belonging to guest-reserved counters and leave
+ * host-reserved counters alone in bitmask registers.
+ */
+void kvm_pmu_put(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	u64 mask = kvm_pmu_guest_counter_mask(pmu);
+	u8 i;
+	u64 val;
+
+	/*
+	 * If the PMU is not partitioned or we have MDCR_EL2_TPM,
+	 * every PMU access is trapped so don't bother with the swap.
+	 */
+	if (!kvm_pmu_is_partitioned(pmu) || (vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+		return;
+
+	for (i = 0; i < pmu->hpmn_max; i++) {
+		val = read_pmevcntrn(i);
+		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
+	}
+
+	val = read_pmccntr();
+	__vcpu_assign_sys_reg(vcpu, PMCCNTR_EL0, val);
+
+	val = read_pmuserenr();
+	__vcpu_assign_sys_reg(vcpu, PMUSERENR_EL0, val);
+
+	val = read_pmselr();
+	__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);
+
+	val = read_pmcr();
+	__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val);
+
+	/* Mask these to only save the guest relevant bits. */
+	val = read_pmcntenset();
+	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
+
+	val = read_pmintenset();
+	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
+}
-- 
2.50.0.714.g196bf9f422-goog

