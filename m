Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A51487CD
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488434; cv=none; b=DKs0mb4ajpc0EeJw8x8Maiuc9mjsq/1hVZd9Avn8pYdnp+phmjGtGMkcgzaZ5rmQKWU0QCGCRPET/wI/E8uwF3M9WMLsjpDD7d0Ek8EJMy4kC96XqO1vmQuxZWyVemktNAkkXpXFiJuZOCi77i1EQgwbcaJqEg4TDdnxZc9fJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488434; c=relaxed/simple;
	bh=h2BIhzPWqK1WX6sUig0pWm4EWfyb/ZKPY5ztzMGHoIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gS9MPqGbjLaJmflo9X2aK8zMeufZZVCm0uUtQEy67JjP6Lc6f3ePlsnkgWSVGyTXw9dzDTF/W5zOaEBX0DYaNLbd0ARTqpPaA0X3Zg6DLKjWlXqXfI4bNnbOI0G7E46fKe8O+HJaINgcdpp8+63cbPHc7YR1dG1Ra3LFGpUmusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJexU4ZM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJexU4ZM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb5594a9f3so6408959a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488431; x=1723093231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OoGP7Z9uDxmG6CzYVyLj44ANC+cEU7w76pDMHfnQCbo=;
        b=BJexU4ZMaVaNo47MAlItEsi4c4vh+EHaRfRYRvdy9SlXk5cyYM0FIi2elFyRBW8/0u
         mXA3tnqvc+7ExlIgMT04vlXVj+x9jrKgfJVQx2JaP+gXw0iHDK+BaDI6oDPm0gzj16fv
         Jn+aa6cPghv63xh5vT+PsUs6ViFoJBtHuFLJN3unTYag3syNWlj/ZW7yB+UydXFzwFta
         WkEHA3MxEHnbgOLvPrq5Cb8Nb2J7Q3Ml3ot0yx/oo9O0199aCAOXpEF1sMF5N0PaKbHh
         n74K/J/8W+4bbcZTHYOx0LPczExx6bupi8hjpj9kbXcfvpfRE7kfSk4W7lBFEYq0KGUw
         yudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488431; x=1723093231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoGP7Z9uDxmG6CzYVyLj44ANC+cEU7w76pDMHfnQCbo=;
        b=vmDUZ69Y1KGR6Syj7vDeyFpmx5sht+6i12eKQ/iI5vnPopHT5AmBpBgac8Nm4VhB0E
         p0xdj3/4CtGec4nz7omTLhQdnZ8MitlNaZDAJ7aWH0OH19oXBdlj88rNxhe6PU8EKS38
         9hNA+FQCIxeVMy7ER7oLUnNnPk6qSAyHLBJ9C6OULEdYbKPYzq3BXeIbp+UTVfuy7biv
         U3bqlg7uVYCsnbt3JmsMlVmYRwQVy9oBFdckKBquPXiArXycn6ZzWYuUJ+zBSmYLMwpw
         fasECpZ8eGAAJwZ8hzG93HZPKBpfzuKIBIaQsUi5rIU2wPOXqKWVrNU07tl9Zx2/HcIb
         zdXw==
X-Forwarded-Encrypted: i=1; AJvYcCW0L2oO2N+T7/C7qEOjQo0gOyO2ctxdQYnrTfHQi4itpyHytsNwRa8+mSBON8xTOD5LKhZlZLQOGCdGITQhG9hHIJMYIXDdwFr1nU4W6lYYgQ==
X-Gm-Message-State: AOJu0YyhGXN8YAN3rnoKWjrvvrFP9eVSxd80oZBE/Lg7EQ4TOWY2JXXh
	1/PQQmtNLh/zvVHbuTulDIcnWnCJQSz3fdoOuY7hodnsoZLYGK+ij3LpMFnocpMAv/XoWjnBZ/Y
	c3/sfmw==
X-Google-Smtp-Source: AGHT+IE0SUiysq8onpo5FTRQNhm7CnSNYELnvE81ag75kjeNorppDjOFmoYHczpasFS8m6aV5EhpFQVwJMND
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90b:4f90:b0:2c9:9a89:a2ae with SMTP id
 98e67ed59e1d1-2cfe73470b4mr16443a91.0.1722488431039; Wed, 31 Jul 2024
 22:00:31 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:52 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-44-mizhang@google.com>
Subject: [RFC PATCH v3 43/58] KVM: x86/pmu: Introduce PMU operator for setting
 counter overflow
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce PMU operator for setting counter overflow. When emulating counter
increment, multiple counters could overflow at the same time, i.e., during
the execution of the same instruction. In passthrough PMU, having an PMU
operator provides convenience to update the PMU global status in one shot
with details hidden behind the vendor specific implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h | 1 +
 arch/x86/kvm/pmu.h                     | 1 +
 arch/x86/kvm/vmx/pmu_intel.c           | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 72ca78df8d2b..bd5b118a5ce5 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -28,6 +28,7 @@ KVM_X86_PMU_OP_OPTIONAL(passthrough_pmu_msrs)
 KVM_X86_PMU_OP_OPTIONAL(save_pmu_context)
 KVM_X86_PMU_OP_OPTIONAL(restore_pmu_context)
 KVM_X86_PMU_OP_OPTIONAL(incr_counter)
+KVM_X86_PMU_OP_OPTIONAL(set_overflow)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 325f17673a00..78a7f0c5f3ba 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -45,6 +45,7 @@ struct kvm_pmu_ops {
 	void (*save_pmu_context)(struct kvm_vcpu *vcpu);
 	void (*restore_pmu_context)(struct kvm_vcpu *vcpu);
 	bool (*incr_counter)(struct kvm_pmc *pmc);
+	void (*set_overflow)(struct kvm_vcpu *vcpu);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 42af2404bdb9..2d46c911f0b7 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -881,6 +881,10 @@ static void intel_restore_guest_pmu_context(struct kvm_vcpu *vcpu)
 	wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
 }
 
+static void intel_set_overflow(struct kvm_vcpu *vcpu)
+{
+}
+
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
@@ -897,6 +901,7 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.save_pmu_context = intel_save_guest_pmu_context,
 	.restore_pmu_context = intel_restore_guest_pmu_context,
 	.incr_counter = intel_incr_counter,
+	.set_overflow = intel_set_overflow,
 	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_INTEL_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = 1,
-- 
2.46.0.rc1.232.g9752f9e123-goog

