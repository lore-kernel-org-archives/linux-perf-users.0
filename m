Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3BA2BEC37
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510321; cv=none; b=FAsZOSpkLLARHb/HPPAD1oaUMJcMLtA5gWSnXT85KMWu7tUQ0owoVXYXxaLbn0o0EVaPy9c/3BXNyB3kCSyAKex6n7gMxO5P4JG9bcVS3rZblKVnYMJ/614rM5O7QuFm8hasFvHPrBlEcsIXA6BDn+sPvInBqgjYjPNT3oVJTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510321; c=relaxed/simple;
	bh=Wpc8Jd9c5FTviX8Nxdqz9AYHAb0HsNCDdNNI+vxMlVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lTnH5MfAUqFXbxDDt6WlnPctzFyN8vJOi3uwSGLPBDelR+Am8CPZWmQ46Rg/s29UuXGMhXQebWSHyVoMt7Z1eh6UAjLoPaaVPeHgEDtCbT4dbQ6SKIyKhXRR8hK/jmJlXReWliXSpVX5pOu3mZAS0j/kbF1IlX5+Ujap4Sz+whQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4R2l5U3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4R2l5U3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ea430d543so311225a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510318; x=1755115118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mbLaYrBpG9GN/ccdjbZmNVq0IkY2pKSaCp1hoLzaUb8=;
        b=F4R2l5U3Zs/Tt1JRAvtsqAzEd9cVdolHZvuVEYwjvFHDj7e9UdVCbAuSpfKH7fOeI2
         Hnkd8wM4df8l+1paSBz7Jv/A5LdbxsF6fkl7ih7TaROhtUTeOFneZ09iMLuMc1+kDCIP
         GV8qQtFBIgk2JaLdE6nqRu50lWIO/bGxwknzIMFDsw8/xluZYWkop2VVjYSkCX+KwrYv
         YvRQ26PqRgUTxXHETnTovhgmAgZZPBaFs8ckBBcIpvsck9VZfkPNTGlPndKHOk2fhGuh
         LZOzBM+tNBiUlGXGB++gMaAIlRYKE6JPjFJDiDgDxnbhb6by7KOVj2eFzkUcFpr/1CGH
         lX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510318; x=1755115118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbLaYrBpG9GN/ccdjbZmNVq0IkY2pKSaCp1hoLzaUb8=;
        b=AGx0YAKG0UieoBruRDQvPxCxEfdzybWoQ5cvSs49BxRH2B7AhdSghxn+5gdPETlyDb
         SbFKVrsVnPZrMRLuET5y8ofhEvVlhW2azBTCOlYSYHeztS5/ogSgvdRkJjyqmB/w5/yY
         f/K8Zi1gPRuu7dM+Vk3/f3DDc0CiI1n9u7agZi4qKU9O3n8iFRMRYdUK4KiSeQsn5h/T
         CUJL8TcgIRTUIltDjro13TDsDced7MlSE0HBgILgasUHAB7PldC800VE4p8EDAWCep9c
         ZlCXSd69q9oRyfsiRiQtcEhdnt6X3TjnHGwFiZQQqobqfe/KqIfIVr+1DZoV+/oQl/8Z
         hb1g==
X-Forwarded-Encrypted: i=1; AJvYcCVr62TZZJY1robYy+o3yHaAaIwiRwtVbIXTmTUBcRP4P8jBMSz6EB0NwiP3cJzCw+FHVC8qx7LN6QgN7yxFSEg3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0whH0wkkC+W8+Sirn7MSHyUGENCkb4wgIdS8UDVw25nRT80E
	q5MC8eUGWdLCXW27Tpm/7CPheXQZYU82Td1VUsYrt8PC39Uu46ZmXRNsADLSHSJ+pwOrn1aFicx
	qgQr8Tw==
X-Google-Smtp-Source: AGHT+IG1RDTXadNPV+CIxuchWnyR7MvCJdJx9iRkBiPVNpyV8SP3VNbt+vP90Pa+IEkbzbifDn/Htni5q5g=
X-Received: from pjzd15.prod.google.com ([2002:a17:90a:e28f:b0:312:151d:c818])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a04:b0:31e:6f0a:6a1a
 with SMTP id 98e67ed59e1d1-32166dfac71mr5462707a91.3.1754510317778; Wed, 06
 Aug 2025 12:58:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:00 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-39-seanjc@google.com>
Subject: [PATCH v5 38/44] KVM: x86/pmu: Disallow emulation in the fastpath if
 mediated PMCs are active
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Don't handle exits in the fastpath if emulation is required, i.e. if an
instruction needs to be skipped, the mediated PMU is enabled, and one or
more PMCs is counting instructions.  With the mediated PMU, KVM's cache of
PMU state is inconsistent with respect to hardware until KVM exits the
inner run loop (when the mediated PMU is "put").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.h | 10 ++++++++++
 arch/x86/kvm/x86.c |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index e2e2d8476a3f..a0cd42cbea9d 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -234,6 +234,16 @@ static inline bool pmc_is_globally_enabled(struct kvm_pmc *pmc)
 	return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
 }
 
+static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	return !kvm_vcpu_has_mediated_pmu(vcpu) ||
+	       !bitmap_intersects(pmu->pmc_counting_instructions,
+				  (unsigned long *)&pmu->global_ctrl,
+				  X86_PMC_IDX_MAX);
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7fb94ef64e18..6bdf7ef0b535 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2092,6 +2092,9 @@ EXPORT_SYMBOL_GPL(kvm_emulate_invd);
 
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu)
 {
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	if (!kvm_emulate_invd(vcpu))
 		return EXIT_FASTPATH_EXIT_USERSPACE;
 
@@ -2151,6 +2154,9 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 	u64 data = kvm_read_edx_eax(vcpu);
 	u32 msr = kvm_rcx_read(vcpu);
 
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	switch (msr) {
 	case APIC_BASE_MSR + (APIC_ICR >> 4):
 		if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(vcpu->arch.apic) ||
@@ -11267,6 +11273,9 @@ EXPORT_SYMBOL_GPL(kvm_emulate_halt);
 
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu)
 {
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	if (!kvm_emulate_halt(vcpu))
 		return EXIT_FASTPATH_EXIT_USERSPACE;
 
-- 
2.50.1.565.gc32cd1483b-goog

