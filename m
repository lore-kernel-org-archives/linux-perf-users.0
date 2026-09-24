Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859964C14E9
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271008; cv=none; b=aJcUBrQuNYMgFTjlgTLm/Z7dPzFsR/q674/NrSdYQEOoIqXAZHjqgGwAGfqoqwhJ/bCozWa7+zezClarkavYqNlQOyJMlquInWyeRu0E32DNNF6TqR0cvDeCWAqJiXURfOKgj9vTiv1oRdNrdtvzYU6jMGDOkEjUmKBXRkVp1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271008; c=relaxed/simple;
	bh=+LJ57dwDKb/GvJ9BnpXeZyHIJZfWTg4yKipkpz7XVL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pip0vn0CcCfvfSS84+EXtJkwx0zkKFbx0IfLPElBRpSeFZ2q4wYk1lLEXLkfVaQfhWND6jbjHYrXpBQhZXXULAktrLNCiB/dudJNB7MMWB3LAhkYa2X9kEG+/Hu1++oiLaaA3qaS6LBAfIXCfFLfjti0vX1BksP83Wx5NDsRNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXwQWg5p; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXwQWg5p"
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a7de733fa9so217831b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270999; x=1790875799; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwsk9te7VPUHzegWpxO9JFCtI5Vc22J8AiaBQE2VWD8=;
        b=eXwQWg5pwKw29VKyff0YrVXdnE780LE3SeHonQcrebMB+asR9sdoBEjWqHGtksEpT1
         N//uHbvZKSEX4nh0dbO4GLYVoZTSPS63hyyYexcpSpKLM9M081QiOFUPjIJAfjZTVuwG
         1BhJxSH3mrB28fnoE6VqwAhwYwL9cSigdAyHymwqw0Y2lieMikx19OWTcegzoHtCNgmn
         mNA/95/oBtyADzKEPOMhP1NeJF0rVVy2Eozw/8El5bALENjBm7QbnHQS35BLTV7scco1
         8WybiuAd7dswzoNtmi4ard9RMm+eFyaq1TvFYdrAQXyUys0yaL83/XD9kfAMrJfdI44m
         yeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270999; x=1790875799;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwsk9te7VPUHzegWpxO9JFCtI5Vc22J8AiaBQE2VWD8=;
        b=bxZO1PgLT+GMVUdFOZmH+MroD167QQjB1WFPg3lA9+Q+1i8Y4CORR6wVgH6HCAQjdu
         hvGv/IeJ564VMO4W13fF+U76346y2cnNXR1C6AGHPRAIv36goDuLrpXspWv6JcpZSjOC
         6eL3HtVZBCKBDTMR0QeMyL/RUcDmgjoozREUAM+du89bNqHH3+5Dfp+4lMsF71/SWYuO
         SiyGR6/24lvTtFtPTxKYoLpEm1D7UYKXyG7gutIzqF/5zsXR935RF/+mqb8Myi6PtJBf
         qEbdIwif/g3ehUwkYFtaEYEUkNblPz6FPOoqabD5LGTOfrcDF4djEcs58g9RJFPa0+Ao
         Fu3w==
X-Forwarded-Encrypted: i=1; AKwUvByq1wQIgXibpasGmtJt2p+NQkuEYNDR9uZyGZQkwt/yEhCK33zd7lh9GKTjGomvMvGoTrysEY5SJcb9F2KP672d@vger.kernel.org
X-Gm-Message-State: AFuF++no7dObgDHubdrM9eZLMTzBQb99uyHL+QnwTGpsq7ME144vJ1dh
	y7x7J+lTMPfSB1jjdsH/x27N3oEHs967nyOmPGUxHe9WSbaDXAClmM9fFeDzx1tbEX+gykrl2Rg
	rgIUe3KsWLAnyD2FjedZBrNEaTw==
X-Received: from jabel8.prod.google.com ([2002:a05:6638:4d88:b0:5f3:c301:1e33])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3a1b:b0:4d6:9252:4645 with SMTP id 5614622812f47-4d72ea62a98mr3099601b6e.57.1790270998742;
 Thu, 24 Sep 2026 10:29:58 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:25 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-20-coltonlewis@google.com>
Subject: [PATCH v9 19/22] KVM: arm64: Detect overflows for the Partitioned PMU
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

When re-entering the VM or synchronizing PMU state after a guest counter
overflow interrupt, evaluate whether any enabled and unmasked guest
counter has overflowed ((PMOVSSET_EL0 & PMINTENSET_EL1 & PMCNTENSET_EL0)
with PMCR_EL0.E set) and update the virtual PMU interrupt level in the
vGIC accordingly.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c | 55 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/pmu-emul.c   | 12 ++++++--
 arch/arm64/kvm/pmu.c        |  8 +++++-
 include/kvm/arm_pmu.h       |  2 ++
 4 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 95b5a64052762..ec821aa54688f 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -534,6 +534,61 @@ void kvm_pmu_handle_guest_irq(u64 pmovsr)
 
 	for_each_set_bit(i, (unsigned long *)&govf, 64)
 		set_bit(i, (unsigned long *)__ctxt_sys_reg(&vcpu->arch.ctxt, PMOVSSET_EL0));
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
+	u64 pmovs, pmint, pmcr;
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
+	overflow = (pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint);
+
+	if (overflow && kvm_pmu_get_access(vcpu) == VCPU_PMU_ACCESS_FREE)
+		kvm_pmu_set_guest_owned(vcpu);
+
+	return overflow;
 }
 
 /**
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index e8195984b0373..21e2c96abfdb1 100644
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
 
@@ -296,8 +296,14 @@ bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sync_regs *sregs = &vcpu->run->s.regs;
 	bool run_level = sregs->device_irq_level & KVM_ARM_DEV_PMU;
+	bool overflow;
 
-	return kvm_pmu_overflow_status(vcpu) != run_level;
+	if (kvm_pmu_is_partitioned(vcpu->kvm))
+		overflow = kvm_pmu_part_overflow_status(vcpu);
+	else
+		overflow = kvm_pmu_emul_overflow_status(vcpu);
+
+	return overflow != run_level;
 }
 
 /*
@@ -400,7 +406,7 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 		kvm_pmu_counter_increment(vcpu, BIT(idx + 1),
 					  ARMV8_PMUV3_PERFCTR_CHAIN);
 
-	if (kvm_pmu_overflow_status(vcpu)) {
+	if (kvm_pmu_emul_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 
 		if (!in_nmi())
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index a8214ab52fcb5..4a3c6600b2678 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -409,12 +409,18 @@ u64 kvm_pmu_evtyper_mask(struct kvm *kvm)
 static void kvm_pmu_update_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	bool overflow;
 
 	if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 		return;
 
+	if (kvm_pmu_is_partitioned(vcpu->kvm))
+		overflow = kvm_pmu_part_overflow_status(vcpu);
+	else
+		overflow = kvm_pmu_emul_overflow_status(vcpu);
+
 	WARN_ON(kvm_vgic_inject_irq(vcpu->kvm, vcpu, pmu->irq_num,
-				    kvm_pmu_overflow_status(vcpu), pmu));
+				    overflow, pmu));
 }
 
 /**
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 955f142a41b94..428a609eaf1a7 100644
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
2.56.0.rc1.310.g51773c2048-goog

