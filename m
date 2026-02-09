Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48931A56C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676856; cv=none; b=Bb+xpUVjrVxoeDaqLhHPrnWFxnE+w3d77NC+pxOUaBAQ1YDQrDh+DkN+dqdXsZHGj5RclaWHBswo0ahDCjLrEKO8P9BEc3cj1kUo6/WtcsSdV4TdR+UC/vISWbEEWVRQs+4lCpKb+gigz0LutExSBvDuiVNwkyJ/paSqyxJsbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676856; c=relaxed/simple;
	bh=B9HZV/XvGCtJKEIzSCyXAxqSnw0EEFic83RP1XipC3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ri179eBtk91rMIgYwso4F1fnV2mI8fJioSDznrgZv8MCyaT47fCCrTT+eugDkzIj1bnWjmzunxizWW3t9HAGqIswpTOkiL/K3I8TNDKdtbd+x8IccBeQ4selLV55k478Dyu4u0oRDd8UfnfjWsR7AP1IOCoLo6hvI2ldhwoEzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NnzDkZsd; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnzDkZsd"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-663005f0997so10281593eaf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 14:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770676852; x=1771281652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nily0rEh3mmY4uvAeTjqDVW7kEcYRK1QYtsSJT+aPhk=;
        b=NnzDkZsdRLMTlHa1swP5Z/JorSQFqooN1864sOw2+uAjnPSBEswKJaMg8TA+qw52ye
         MpOnat3IAmj/gBBsPdM1dBaEvdKS32+Dm80ECCaL1tcby+2ksjylQ9XIAXYbIiDbBu5X
         7JzB+lgSgl4NPkMD+Qj3odeKBGp6FjqhzJ8hYlOhnwUbeUNoVZ/k+AbYveWeMCOlkcqF
         KprLqhMyPqQt9DAr7O8cZod1P0vLamAuVywNZyX958GK0fVU8U0igL4u9uVFjl+wcQrI
         eS1mZ159iT2LPJXOKSJhbYP9d+giiwI4/IrgteNWXIC8OF13nOLeA0VgDm1fFZ5A2Bwa
         dUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676852; x=1771281652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nily0rEh3mmY4uvAeTjqDVW7kEcYRK1QYtsSJT+aPhk=;
        b=NJ8qcUtzsgI7z32TWyyoh+uoCMi75xog+sOpNuW309ouj/ObQmuLFRzhNda8/gWEHi
         6riLVusX/kfEVezhkX3ZK8nycSBZqwJu5+4/toO1Pw/b7Q+pBP8ivBIylXYvpmt64SuA
         1Ge19jKjA29tyUwlepeOdsfKi15TAxq2/hauhZxPy73rDSr/F/NamP4JLacNZeR3VRYf
         YKO9ZaPrF0kLVrMvZFHrNQxewZL86wLzbmfqCBrT/nkYpbTD7mTExYxZt2ynOV4FXVTI
         nmS6/EMiBWj5N8oUke7PxxnucbhL8+vIEyLxS+AjkbgezahG8Mx7VxVAJv8gXospxgil
         FNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxs8wmKaR0KKaeSiIE6VRZSlPYbyppMMzmvvKNXEvIZG2CwhMsjD2SG/euclhSFQyOqYQapE1ncr94MtUhIANP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ULsJqakYw/NmTbU3/Sh7fVzBtuEOwVYah/j21DHv/0pgfSRw
	6kTt9na3fzKYlnNKVbHdEFCaYo2+ZhwG05EOdllXJR47isR++lyWQ52Ce8V0hy2bStIxf5KNRfL
	0cS445A/KKOSY3At59XJ5P6ezBA==
X-Received: from iobbx7.prod.google.com ([2002:a05:6602:4187:b0:957:50e1:3858])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a4a:e902:0:b0:66f:6d5e:76c3 with SMTP id 006d021491bc7-672fff0af95mr60439eaf.42.1770676852384;
 Mon, 09 Feb 2026 14:40:52 -0800 (PST)
Date: Mon,  9 Feb 2026 22:14:03 +0000
In-Reply-To: <20260209221414.2169465-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209221414.2169465-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209221414.2169465-9-coltonlewis@google.com>
Subject: [PATCH v6 08/19] KVM: arm64: Define access helpers for PMUSERENR and PMSELR
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

In order to ensure register permission checks will have consistent
results whether or not the PMU is partitioned, define some access
helpers for PMUSERENR and PMSELR that always return the canonical
value for those registers, whether it lives in a physical or virtual
register.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c      | 16 ++++++++++++++++
 arch/arm64/kvm/sys_regs.c |  6 +++---
 include/kvm/arm_pmu.h     | 12 ++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 74a5d35edb244..344ed9d8329a6 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -885,3 +885,19 @@ u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 
 	return u64_replace_bits(pmcr, n, ARMV8_PMU_PMCR_N);
 }
+
+u64 kvm_vcpu_read_pmselr(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_pmu_is_partitioned(vcpu))
+		return read_sysreg(pmselr_el0);
+	else
+		return __vcpu_sys_reg(vcpu, PMSELR_EL0);
+}
+
+u64 kvm_vcpu_read_pmuserenr(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_pmu_is_partitioned(vcpu))
+		return read_sysreg(pmuserenr_el0);
+	else
+		return __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a460e93b1ad0a..9e893859a41c9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -987,7 +987,7 @@ static u64 reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 
 static bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
 {
-	u64 reg = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	u64 reg = kvm_vcpu_read_pmuserenr(vcpu);
 	bool enabled = (reg & flags) || vcpu_mode_priv(vcpu);
 
 	if (!enabled)
@@ -1141,7 +1141,7 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 				return false;
 
 			idx = SYS_FIELD_GET(PMSELR_EL0, SEL,
-					    __vcpu_sys_reg(vcpu, PMSELR_EL0));
+					    kvm_vcpu_read_pmselr(vcpu));
 		} else if (r->Op2 == 0) {
 			/* PMCCNTR_EL0 */
 			if (pmu_access_cycle_counter_el0_disabled(vcpu))
@@ -1191,7 +1191,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
 		/* PMXEVTYPER_EL0 */
-		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0));
+		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, kvm_vcpu_read_pmselr(vcpu));
 		reg = PMEVTYPER0_EL0 + idx;
 	} else if (r->CRn == 14 && (r->CRm & 12) == 12) {
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 50983cdbec045..f21439000129b 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -130,6 +130,8 @@ int kvm_arm_set_default_pmu(struct kvm *kvm);
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm);
 
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu);
+u64 kvm_vcpu_read_pmselr(struct kvm_vcpu *vcpu);
+u64 kvm_vcpu_read_pmuserenr(struct kvm_vcpu *vcpu);
 bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx);
 void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu);
 #else
@@ -250,6 +252,16 @@ static inline u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static inline u64 kvm_vcpu_read_pmselr(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static u64 kvm_vcpu_read_pmuserenr(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
 static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	return false;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

