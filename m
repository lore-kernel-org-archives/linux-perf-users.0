Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114353;
	b=lTaNvH5r5SVv9RpryhkEjFbVF2rBMhBV2M4XC2uEM8/hG9pkv7AYREDKO9M7fDu+70Ti
	 N+RqdR6SjjgVVP/0yBzw3swZqCknqn6T9VYHiEuYdDh+C8ntLeAPbK7OBkb7pg6/GAC43
	 dw21yqmSPWyrue/8MLVHecPgzk10KLwncoMnkXE13oRHDCceA5pMRHZjzlWgCKlvoUYLJ
	 2BdwfMvP85VcgMR62VmURr5hMOds03H3KSyGxIsN7H8gRa3J16pscmoXbAL/3Wlu9vTdJ
	 r63+3/wjE1mphotbqPiQCJYu25WYNtdpISL4GfZiUmUl0jhorQ4LbPItcdWTlRRTWEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=s7gXTki65dpFFX+5OBgJjT7u8o6SXEVygRdxz2zSjw8=;
	b=cWKV+aZ7U37etJzjTKY8+DtLKorTAmNnIkXkPI6TVuRH+pi4ubjFs4ozTELajYPlOX3b
	 DGX2rFS95LtR0y4g/0W1umRLtcxZ4q0BV+gcEb8OgdjZYLDk5WF/lzq6c177ofKS+LFw3
	 ioZOiU9Mv1jT3BolDiHnd/fnBb17UWTcOmw4/+71I1idzCE2iBldnVukiIuqAflCS/uBV
	 ovOg9euw4b9FSLMii6KcXBiQUpL7pO1OE+5sXp1ZHDnQeVdeetjQn0ErGAHztQh7yN6p9
	 BxW6eBLEOxT4VtkFR0732mpo4cLV2Waim4seyJOpWp/Z1la2mYT04jSNL3oMwArd6VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cuv2e2mp;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEC606CE8C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AEC606CE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cuv2e2mp
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4eb0b989f0eso40043b6e.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114352; x=1795719152; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s7gXTki65dpFFX+5OBgJjT7u8o6SXEVygRdxz2zSjw8=;
        b=Cuv2e2mpBjuRQ/1D5LSklEhzdZOMfoG5ITkWdjoJmziD1zrFqfLs8KGZvdXOXhhQ/t
         Gcn/+Gx/oNOo0rOTKm4OEyPBuG89RYk+fl9tV922Q0VI9EX5NVnItWe6QFr2El+M5uw5
         vhWoTz0N3SwkB1i4EQ2tgWsGJcBLEa1JFH9t7NgYcUW6GStWxNmRWrkK1rLq2SBFzQyM
         qRXBkWpkFj55LT0RzN3HjzQTLkd1703nWfB/KnNu0UTPPzMQ6B8eOwPvZcx4/UOEPKWH
         Pm8ewG5dewczEzkVAjIQ+zuwWYy0u3l26/WTNlWeuJ8ebJ2OWQKzWaURd3GNiz/SK8PR
         L9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114352; x=1795719152;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7gXTki65dpFFX+5OBgJjT7u8o6SXEVygRdxz2zSjw8=;
        b=hu662qbGjI/KxxRnl3cgDJFrU2wYthvF3H8M1M0Q0M9p2bF/9seO4L6zOgdiYNPXt5
         Xzl/Ch+fL3HUpH2cE7z9lH7Y2jHu6J1c3b4K40pO1wVNNOIbFwSK0fiZhExgvyF0+GlI
         ogaNwMiyyWBoCA9jD76Eo6gwid1sVI+jOiW5/Ffnb1OYZLpYV4opzY1AWzfoiDGjzz0m
         0HnQwnOO/nSlhoEqhnYepmlKp4iDe1iLm7yveCpUXLzMRY2R4lEEZhGQi6PFfJ2tW3me
         DFrsgrO9WJbpzeGD/PrFiCpUinWv1rndEmpRbioNG3E/5ay7jB86MUqLWtHk9z+W6CDF
         8aUw==
X-Forwarded-Encrypted: i=1; AL+hErGEGnFIDMkJwYCjXdxHXzEFzcKt+3xTkVLVCSsCdKNFgK31FEaeW5/8VBRn41Ak6pyHsPW3+6HDue2f3i/M9PGN@vger.kernel.org
X-Gm-Message-State: APuU4Z+coMX/stVcYGo/4HxOHOVVIKesCtj3cRQwZgJvz4QRm4WwsgYF
	ekY8405tkfVXWOXT/CNfv4C8x8IZjtRr/PYUnREeSFCdTenId8JtbWbmNTqHUyNxCst4D+ggxe9
	Z9jFQ1gbxGBoC4xyrlvc2/k5Z3g==
X-Received: from ilben9-n2.prod.google.com ([2002:a05:6e02:5109:20b0:54b:6fad:75e6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3026:b0:571:d883:d551 with SMTP id 5614622812f47-579789ceb9fmr1648716b6e.2.1795114351597;
 Thu, 19 Nov 2026 10:52:31 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:58 +0000
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
Message-ID: <20261119185215.632334-17-coltonlewis@google.com>
Subject: [PATCH v10 16/33] KVM: arm64: Set up MDCR_EL2 to handle a Partitioned PMU
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

Configure MDCR_EL2 for a Partitioned PMU in kvm_arm_setup_mdcr_el2():
set HPME, HPMD, and HCCD (plus HLP on FEAT_PMUv3p5 so host counters
retain 64-bit overflow width), program HPMN to the guest's general
purpose counter count, and clear coarse-grained TPM and TPMCR traps when
FEAT_FGT is available. Protect MDCR_EL2 updates with local_daif_save()
so GICv3 pseudo-NMI PMU handlers toggling MDCR_EL2.HPME cannot race with
kvm_arm_setup_mdcr_el2().

Update kvm_nested_setup_mdcr_el2() for the two nested execution contexts:
- Nested guest context (is_nested_ctxt(vcpu), L2 at vEL1/vEL0):
  NV_MDCR_GUEST_INCLUDE already propagates L1's virtual TPM and TPMCR.
  When L1 sub-partitions its counters (vHPMN < nr_pmu_counters, so
  kvm_pmu_hyp_counter_mask(vcpu) is non-zero), physical MDCR_EL2.HPMN
  still equals nr_pmu_counters, so hardware alone cannot stop L2 from
  accessing L1's hypervisor counters (vHPMN..nr_pmu_counters-1) or
  reading nr_pmu_counters from PMCR_EL0.N. Force TPM and TPMCR so L0
  emulates 0..vHPMN-1 locally and forwards hypervisor counter traps to
  L1.
- Nested hypervisor context (else branch, L1): under VHE, both L1 vEL2
  (physical EL1) and VHE host EL0 (physical EL0) run in this context
  without exiting to L0 across ERET and SVC. When L1's PMUSERENR_EL0 is
  0, hardware traps EL0 PMU accesses directly to L1 vEL2, allowing TPM
  and TPMCR to stay clear for untrapped L1 vEL2 access. When L1 enables
  EL0 access in PMUSERENR_EL0, propagate L1's virtual TPM/TPMCR (and set
  TPM/TPMCR if L1 sub-partitions counters) so VHE host EL0 cannot bypass
  L1's traps or vHPMN boundary.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/debug.c  | 41 +++++++++++++++++++++++++++++++++++++++--
 arch/arm64/kvm/nested.c | 35 ++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 89c9fb0cfeee2..a1cb4c076bdb4 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -11,6 +11,7 @@
 #include <linux/hw_breakpoint.h>
 
 #include <asm/arm_pmuv3.h>
+#include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
@@ -37,9 +38,10 @@ static int cpu_has_spe(u64 dfr0)
  */
 static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 {
+	unsigned long daif;
 	u64 mdcr;
 
-	preempt_disable();
+	daif = local_daif_save();
 
 	/*
 	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
@@ -53,6 +55,41 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 		 MDCR_EL2_TDRA |
 		 MDCR_EL2_TDOSA);
 
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		u8 nr_host_cntr = *host_data_ptr(nr_event_counters);
+		u8 nr_guest_cntr = vcpu->kvm->arch.nr_pmu_counters;
+
+		if (cpumask_test_cpu(smp_processor_id(),
+				     vcpu->kvm->arch.supported_cpus) &&
+		    nr_guest_cntr < nr_host_cntr &&
+		    (cpus_have_final_cap(ARM64_HAS_HPMN0) || nr_guest_cntr > 0)) {
+			u64 hpmn = FIELD_GET(MDCR_EL2_HPMN, read_sysreg(mdcr_el2));
+			bool hpme;
+
+			if (hpmn < nr_host_cntr)
+				hpme = !!(read_sysreg(mdcr_el2) & MDCR_EL2_HPME);
+			else
+				hpme = !!(read_sysreg(pmcr_el0) & ARMV8_PMU_PMCR_E);
+
+			mdcr |= (MDCR_EL2_HPMD | MDCR_EL2_HCCD);
+			if (is_pmuv3p5(read_pmuver()))
+				mdcr |= MDCR_EL2_HLP;
+			if (hpme)
+				mdcr |= MDCR_EL2_HPME;
+
+			/*
+			 * Take out the coarse grain traps if we are using
+			 * fine grain traps and enforce counter access with
+			 * HPMN.
+			 */
+			mdcr &= ~MDCR_EL2_HPMN;
+			mdcr |= FIELD_PREP(MDCR_EL2_HPMN, nr_guest_cntr);
+
+			if (cpus_have_final_cap(ARM64_HAS_FGT))
+				mdcr &= ~(MDCR_EL2_TPM | MDCR_EL2_TPMCR);
+		}
+	}
+
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
 		/* Route all software debug exceptions to EL2 */
@@ -73,7 +110,7 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	if (has_vhe())
 		write_sysreg(mdcr, mdcr_el2);
 
-	preempt_enable();
+	local_daif_restore(daif);
 }
 
 void kvm_init_host_debug_data(void)
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index b80d90ede9004..06a535c54b708 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -2241,16 +2241,29 @@ void kvm_nested_setup_mdcr_el2(struct kvm_vcpu *vcpu, u64 *mdcr)
 {
 	u64 guest_mdcr = __vcpu_sys_reg(vcpu, MDCR_EL2);
 
-	if (is_nested_ctxt(vcpu))
+	if (is_nested_ctxt(vcpu)) {
 		*mdcr |= (guest_mdcr & NV_MDCR_GUEST_INCLUDE);
-	/*
-	 * In yet another example where FEAT_NV2 is fscking broken, accesses
-	 * to MDSCR_EL1 are redirected to the VNCR despite having an effect
-	 * at EL2. Use a big hammer to apply sanity.
-	 *
-	 * Unless of course we have FEAT_FGT, in which case we can precisely
-	 * trap MDSCR_EL1.
-	 */
-	else if (!cpus_have_final_cap(ARM64_HAS_FGT))
-		*mdcr |= MDCR_EL2_TDA;
+		if (kvm_pmu_is_partitioned(vcpu->kvm) &&
+		    kvm_pmu_hyp_counter_mask(vcpu))
+			*mdcr |= MDCR_EL2_TPM | MDCR_EL2_TPMCR;
+	} else {
+		/*
+		 * In yet another example where FEAT_NV2 is fscking broken,
+		 * accesses to MDSCR_EL1 are redirected to the VNCR despite
+		 * having an effect at EL2. Use a big hammer to apply sanity.
+		 *
+		 * Unless of course we have FEAT_FGT, in which case we can
+		 * precisely trap MDSCR_EL1.
+		 */
+		if (!cpus_have_final_cap(ARM64_HAS_FGT))
+			*mdcr |= MDCR_EL2_TDA;
+
+		if (kvm_pmu_is_partitioned(vcpu->kvm) &&
+		    (__vcpu_sys_reg(vcpu, PMUSERENR_EL0) &
+		     ARMV8_PMU_USERENR_MASK)) {
+			*mdcr |= guest_mdcr & (MDCR_EL2_TPM | MDCR_EL2_TPMCR);
+			if (kvm_pmu_hyp_counter_mask(vcpu))
+				*mdcr |= MDCR_EL2_TPM | MDCR_EL2_TPMCR;
+		}
+	}
 }
-- 
2.56.1.708.g77570a6a1d-goog

