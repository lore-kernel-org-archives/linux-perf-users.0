Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5D324701
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676865; cv=none; b=a2DkQ21UcyzeX/Ou65+4MqEooVTbbES8o2/VvG+A28VVp8uCD2V8vt7xc5gBZ2YTKgiF8d/j4YDk9k62W99bzzDirFpxQ1J1MOWlLYC6kgWtYgb/6yKpTnH3wozriuCz8JtDvjPPDQNzdXZC7AyrDAJLNmsZvU4MXLBMhWXd1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676865; c=relaxed/simple;
	bh=RowRt03ThgQKuNhhFZ3YMhl1qn0omKfjfEtkXkjMK7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1n+PrzZ+RN6Flqtcni06ea/PIJx/qyfaZ3c2PVaxCfRLjfLZHvdkVlPbxrWzIHL27jubpfoYbh6Q3E7JJB7SLlBXl/ueyzW/2Fcckb4Hm5GGemahLJAx5X3TJ51dV05+vVmnsNLOSEpvnt7KRNhYwpBPFwsiFcNiB7UUDJCvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RlXkr1NW; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlXkr1NW"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-409037c3f0bso13375523fac.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 14:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770676860; x=1771281660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtvZ/CVAyvlBIyi+KC1xnXowl3JGTClEkFZx5dHECQw=;
        b=RlXkr1NW/O273SG/7upIZZrnT18xA+ix6n4aWWYhmSbfC+UULhlRrVrhPHTNKHMlcr
         Gn05MalaYcdtOSHCzcunf5t6rPuKAJoVewBRmj4fz98cfpqMafwFFz/cV2JixANpRxXy
         zKh3xyad41cwzbyedkkII3q9M8nC/OetiCDj0lYvroQiqrtGw7SxDQdQLjAYqU6UjN6D
         BDZDIjFcNg4FtCDsSxp4qGEIX1ZAcJinuAy5TSUzmykMV1LNc+Ae/AtulilSTSLxenqL
         xeVL3ZMcHxzZ9/lH+aLgK6sU+RvPQ7MyM16pcDW+X2ma7ppXitXORxvJ8ni9odsU2BLn
         peMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676860; x=1771281660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtvZ/CVAyvlBIyi+KC1xnXowl3JGTClEkFZx5dHECQw=;
        b=nS+IgEngJTfcoszPkhsP2Us8qV1zjPPBEV+UhDLe+0Jj05Z/y3Ziigud9eqO2vo+0H
         saD6QjEdHiBfQ91ec5eVN8f2icoQnkNqLiS+bYC8Pke2c2+ljk0v4xp23DKeFU5ozI3y
         Fz8zUy2K0XyX7PEq18sT3djQzYjnSze8BL+ynM8z5YD/QP3KY/g/sLrm4V/F6EZXrlkv
         NR8k6mpNERA5jjPbUoDlpjS7qwacd3t2uK9nqxT+S4J7+dPknDX4HaTIydDUPaQBA6BQ
         uEvhTtqTgOy78Ti+F/XxrzaRsc6FYRCosCV7A0UvFchWFmpdXKtlW10OD2vC96g6PeXo
         tOYA==
X-Forwarded-Encrypted: i=1; AJvYcCWmpFZ2awRgmLTecGheq+Pe3iCaED+XGpErAE3gZrKRLNoamdk5chQUL+tgoyis/5PrelMQX0yatUehAuCTiGtN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61LRzPdlmsE1Lxx+KoBPfOOQkjsEjPXgvS+IKx9H1w0tOmCyr
	jxlXTdI2uJQTFyTsmMLJ1MD06jfohuERuidWFY6Gf1wkTvsE9TdIpRtL/McBi2VMhD9gU2p1TNH
	fUfDlZC7hFoOBUZDZ6fBJopb7HQ==
X-Received: from ilbbg8.prod.google.com ([2002:a05:6e02:3108:b0:482:7936:419f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:4913:b0:662:fa75:d6df with SMTP id 006d021491bc7-672fdc0a914mr57705eaf.12.1770676860543;
 Mon, 09 Feb 2026 14:41:00 -0800 (PST)
Date: Mon,  9 Feb 2026 22:14:10 +0000
In-Reply-To: <20260209221414.2169465-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209221414.2169465-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209221414.2169465-16-coltonlewis@google.com>
Subject: [PATCH v6 15/19] KVM: arm64: Detect overflows for the Partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When we re-enter the VM after handling a PMU interrupt, calculate
whether it was any of the guest counters that overflowed and inject an
interrupt into the guest if so.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/pmu-emul.c   |  4 ++--
 arch/arm64/kvm/pmu.c        |  6 +++++-
 include/kvm/arm_pmu.h       |  2 ++
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 79d13a0aa2fd6..6ebb59d2aa0e7 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -378,3 +378,33 @@ void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr)
 
 	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, govf);
 }
+
+/**
+ * kvm_pmu_part_overflow_status() - Determine if any guest counters have overflowed
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Determine if any guest counters have overflowed and therefore an
+ * IRQ needs to be injected into the guest. If access is still free,
+ * then the guest hasn't accessed the PMU yet so we know the guest
+ * context is not loaded onto the pCPU and an overflow is impossible.
+ *
+ * Return: True if there was an overflow, false otherwise
+ */
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu;
+	u64 mask, pmovs, pmint, pmcr;
+	bool overflow;
+
+	if (vcpu->arch.pmu.access == VCPU_PMU_ACCESS_FREE)
+		return false;
+
+	pmu = vcpu->kvm->arch.arm_pmu;
+	mask = kvm_pmu_guest_counter_mask(pmu);
+	pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
+	pmint = read_pmintenset();
+	pmcr = read_pmcr();
+	overflow = (pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint);
+
+	return overflow;
+}
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a40db0d5120ff..c5438de3e5a74 100644
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
 
@@ -405,7 +405,7 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 		kvm_pmu_counter_increment(vcpu, BIT(idx + 1),
 					  ARMV8_PMUV3_PERFCTR_CHAIN);
 
-	if (kvm_pmu_overflow_status(vcpu)) {
+	if (kvm_pmu_emul_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 
 		if (!in_nmi())
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index b198356d772ca..72d5b7cb3d93e 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -408,7 +408,11 @@ static void kvm_pmu_update_state(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 	bool overflow;
 
-	overflow = kvm_pmu_overflow_status(vcpu);
+	if (kvm_vcpu_pmu_is_partitioned(vcpu))
+		overflow = kvm_pmu_part_overflow_status(vcpu);
+	else
+		overflow = kvm_pmu_emul_overflow_status(vcpu);
+
 	if (pmu->irq_level == overflow)
 		return;
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 3d922bd145d4e..93586691a2790 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -90,6 +90,8 @@ bool kvm_set_pmuserenr(u64 val);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu);
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu);
 
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
-- 
2.53.0.rc2.204.g2597b5adb4-goog

