Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114362;
	b=AhObg1darAey2mJcxx7laF3RF+0+JP5f5gMEEHsW1PuN/P4hWuI59IhsZ1ma24yAHjma
	 poryFlDvTqIn0tB03GEdklXF+knECy52nZS4j3LDtV7g731+uAqNrU2lBtuKj/K0zDCXN
	 Hktbwv3VFRyHUo/DNsJm8ALnyd8rGZTh9O8vmpuo6OvO2HY5eJX2wS8HnTz6NO0uihwdC
	 EhXr56fkHzzxghw/n15Kf4GiVHd4Ix5Pzg1OX09MszYLc7hGuQ8qXCMVR9SU7+eWui/lr
	 vNegwg4jQLNxmsQ77PTVbQ9a4gQbzWAz+20qRO+oeqiUsDX83Cxa8D+bV9ppCDWFKSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FFPgXiiazla35XDoHe2VRdMYq0SrMDfs5EMKUnqJLEg=;
	b=GUrovr9XBgO6kcz6NN43TF7scpoQAuKxxbw8unV7R+piNBOW/F6GIvXOnhZ6yh4qf1c+
	 ctNVGlJfQymeZ6z/OXVBoaSi2nCD2jVW+bAlqS9cnpN271mm5dnWwctf6H+svBZEvFZnh
	 lxYaSlCEArxrru4IFhYe1St4QopsXzxO3ArSBYvoYiqLT8FZOd1E55nUb+W+5rfU7SoG5
	 RzK4sWHSGyQtarnOojMrp3kQOaxsl6ybD3uw2F3i84QknfRi5zQqsKkKkQ2eABeyj+MOX
	 ecjMB+gRaaP8pI2M85q41bawuapiK6MJj+ZA5Cs+cFjk8scOtAvW5D9CyXQBZ+MqrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y3brFtKQ;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559B60A2622
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A559B60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y3brFtKQ
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-47cfa971c9eso1702266fac.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114360; x=1795719160; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFPgXiiazla35XDoHe2VRdMYq0SrMDfs5EMKUnqJLEg=;
        b=Y3brFtKQw24Ka4geK4WnOZVgj4SL0MGKFoTEMZWUtoHr5Rs8sGlAV7lMMwsVU92GTG
         gC1euMsbBfuFyix47OB82wxd4dfs/R4HHty1WJfSDfHhciqN7Ojiv0DBnlkJ+vQN+5NW
         1x6tMjTu7vM/NA3zt2Xo8iPJ/QhHJ+A7Wv+l/Vxes3xtdRAZHej0BZiuTnXsqzPDRHhr
         hJK4a02xQ02XPMyJ3fCTwwkqH9b5Ux+etTKlUugkuATsfXjwQ/fZNVyWxVqiszkBazzJ
         3uiNc1cX7pzxgVbvAIfn7n6n7at5RDdHFEkQDHLPVWGd+z79xZi3yMzjNnGTnEzRtk2d
         mMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114360; x=1795719160;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFPgXiiazla35XDoHe2VRdMYq0SrMDfs5EMKUnqJLEg=;
        b=F3bH3ma5X3CR/PQnRaEQK8jSvHVTP7EjuEZYK9vYZby0wKysjq2C2lT4v0wtish52r
         8Gg4UZFzxQo6+M7YsHni2myEDQPoH1x2oMUZLDv2HdcWde3Va9epDUE9Fi9wUWFYrUlg
         cP0A1/noiW5RuZkaJdTkdvnAkoRLf6qQeTc1s4DXcaXtnlqoH9LVm6iNA33Hav3pwmm0
         9CWP6pjxDlqCc/hnRiajVjo+XRjq02dI//A1bsCoTWs3zIUyGSJQW2aoQauPfqH/4NZx
         xsHzrwPxedynqu4bczTjLN1s/8jGjYWOzTd6Ft0hxD2qmvvSV2uDCZMtRgCLtifXoFhI
         GAOQ==
X-Forwarded-Encrypted: i=1; AL+hErEOGS5rBgoOqwroX6Wv0pPckinsuT+fsxQSRt2eEOfNH2bGVTEBKRv8eD92VC/I/m8b4fsI5LJ18r76EF9jTFPz@vger.kernel.org
X-Gm-Message-State: APuU4Z++4BbEJXGAygzIIa+ktYiD24kde/QEz1TNA9Gj/J/kjuVaD19J
	MQjCQE8DudE3/apNXL1tWXgfnLr2BKxn+dNfnoiGAukOD7u0r8sIx+ATtwrmXiHnUhI3jyiqWBc
	lNpDLeTe6VZwN7NB1YWgdXSplzQ==
X-Received: from ilbeb1.prod.google.com ([2002:a05:6e02:4601:b0:54f:8d15:4dbc])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2383:b0:572:f8ec:5340 with SMTP id 5614622812f47-5797dd97e12mr1488800b6e.40.1795114360210;
 Thu, 19 Nov 2026 10:52:40 -0800 (PST)
Date: Thu, 19 Nov 2026 18:52:07 +0000
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
Message-ID: <20261119185215.632334-26-coltonlewis@google.com>
Subject: [PATCH v10 25/33] KVM: arm64: Detect overflows for the Partitioned PMU
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

Evaluate whether any enabled and unmasked guest counter has overflowed
in kvm_pmu_part_overflow_status() so KVM updates the virtual PMU
interrupt level in the vGIC (or userspace IRQ state) across VM entries
and host PMU overflow interrupts:
- Harvest any live guest overflow bits from physical pmovsset_el0 into
  shadow PMOVSSET_EL0 and clear them in hardware when the partitioned
  PMU is loaded on the local CPU.
- Check (PMOVSSET_EL0 & PMINTENSET_EL1) against PMCR_EL0.E for guest
  counters 0..HPMN-1 and PMCCNTR_EL0, and against MDCR_EL2.HPME for
  nested hypervisor counters HPMN..N-1.
- In kvm_pmu_handle_guest_irq(), raise KVM_REQ_IRQ_PENDING and kick the
  vCPU (or queue overflow_work when running in NMI context) when an
  unmasked guest overflow occurs.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c | 65 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/pmu-emul.c   |  4 +--
 arch/arm64/kvm/pmu.c        |  8 +++++
 include/kvm/arm_pmu.h       |  2 ++
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 21357decce214..b0491d32b5d7b 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -823,6 +823,71 @@ void kvm_pmu_handle_guest_irq(u64 pmovsr)
 		return;
 
 	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, govf);
+
+	if (kvm_pmu_part_overflow_status(vcpu)) {
+		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
+
+		if (!in_nmi())
+			kvm_vcpu_kick(vcpu);
+		else
+			irq_work_queue(&vcpu->arch.pmu.overflow_work);
+	}
+}
+
+/**
+ * kvm_pmu_part_overflow_status() - Determine if any guest counters have overflowed
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Determine if any guest counters have overflowed and therefore an
+ * IRQ needs to be injected into the guest. If an overflow is detected
+ * while access is VCPU_PMU_ACCESS_FREE (for example, after state
+ * restoration via KVM_SET_ONE_REG), transition the vCPU to
+ * VCPU_PMU_ACCESS_GUEST_OWNED.
+ *
+ * Return: True if there was an overflow, false otherwise
+ */
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
+{
+	u64 mask = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+	u64 hyp_mask = kvm_pmu_hyp_counter_mask(vcpu);
+	u64 pmovs, pmint, pmcr, reg;
+	unsigned long flags;
+	bool overflow;
+
+	local_irq_save(flags);
+	if (vcpu->arch.pmu.loaded_on_cpu &&
+	    vcpu == kvm_get_running_vcpu()) {
+		u64 hw_ovf = read_sysreg(pmovsset_el0) & mask;
+
+		if (hw_ovf) {
+			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, hw_ovf);
+			write_sysreg(hw_ovf, pmovsclr_el0);
+		}
+		pmint = read_pmintenset();
+		pmcr = read_pmcr();
+	} else {
+		pmint = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
+		pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
+	}
+
+	pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
+	local_irq_restore(flags);
+
+	reg = pmovs & pmint & mask;
+	if (!(pmcr & ARMV8_PMU_PMCR_E))
+		reg &= hyp_mask;
+	if (hyp_mask && !(__vcpu_sys_reg(vcpu, MDCR_EL2) & MDCR_EL2_HPME))
+		reg &= ~hyp_mask;
+
+	overflow = !!reg;
+
+	if (overflow && !in_interrupt() &&
+	    kvm_pmu_get_access(vcpu) == VCPU_PMU_ACCESS_FREE) {
+		scoped_guard(preempt)
+			kvm_pmu_set_guest_owned(vcpu);
+	}
+
+	return overflow;
 }
 
 /**
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index da66162c68042..a72bdc5a0b3ea 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -268,7 +268,7 @@ void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val)
  * counter where the values of the global enable control, PMOVSSET_EL0[n], and
  * PMINTENSET_EL1[n] are all 1.
  */
-bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu)
 {
 	u64 reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
 
@@ -400,7 +400,7 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 		kvm_pmu_counter_increment(vcpu, BIT(idx + 1),
 					  ARMV8_PMUV3_PERFCTR_CHAIN);
 
-	if (kvm_pmu_overflow_status(vcpu)) {
+	if (kvm_pmu_emul_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 
 		if (!in_nmi())
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 7389d61957fa9..9d4ad4b7bd8d5 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -409,6 +409,14 @@ u64 kvm_pmu_evtyper_mask(struct kvm *kvm)
 	return mask;
 }
 
+bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
+{
+	if (kvm_pmu_is_partitioned(vcpu->kvm))
+		return kvm_pmu_part_overflow_status(vcpu);
+
+	return kvm_pmu_emul_overflow_status(vcpu);
+}
+
 static void kvm_pmu_update_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 9800514019630..fcd8e6331943e 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -91,6 +91,8 @@ bool kvm_set_pmuserenr(u64 val);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu);
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu);
 
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
-- 
2.56.1.708.g77570a6a1d-goog

