Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEE2C0F84
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980293; cv=none; b=VglKz2iN731YZ6/zp+EQhRHWCd7BHnPR4wQyZDTO+l8xSDzljJVG9bwCJHGxCkL/iebkEOT5RDp+AVvGp37YNsqe7WvcNHBaZa17Th3oIENcFhA81C5Ogo+Wn1usRMOJGU+mwipAGAF7R/un6tlSPdZq6TmSziAFljwLGWIaoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980293; c=relaxed/simple;
	bh=/6biXpQFm51gHJtR2A48VdHy52DA+SmrH2G9LhLIuBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0h0/Ob/l6ZEMzjo588y6wBcaXC4lNdLMwYOnlMyG8Y0ung3L9UXJk5QfTtKiKBsrqR+2/5UersZ7TqAT2UJZjhPAXVAKSuP005qiCpaEP/RM0+oKkdL12RdNHWU/9U6huuNfL2FL8kCSjTcmglnOlhV4ES7PPfu8APWtE5bCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlNCZZYu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlNCZZYu"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3438744f12fso6648550a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980290; x=1765585090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FT03r3WGpiwo19/4S5QoYm3Bx/6piafEWN0VhOWiV4M=;
        b=JlNCZZYu/RSAc7xX6XQv4V4gUvi8/iZzruED5uWTCS52L67tXNg7pKcobOUQPG8cBH
         xA1+qpls4xoGBdVEmFs7pn0INyMg9FXE6rOknQ581AME0YTYQZ4tgTBHz9433qSUsMk4
         D5SwA7Wau3pBst00+tyFuD+z3j0iOkMEpeKPi2J7lRRvO4pUudcqGtnKVBF+mACz81/e
         bafmEU9jyjaF6yWs53vo0ObQjbpTpz/uG5kqUn2djXgeXcdRwaRynXr5WEFQ+z0cBA0v
         ZroPuq2E/D1WynteMR2Lo1Ii3hD7mG02gDSX5a+3kZ12CfWTfzhXjfwYmBiNA1u5i+0k
         DYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980290; x=1765585090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT03r3WGpiwo19/4S5QoYm3Bx/6piafEWN0VhOWiV4M=;
        b=ZqqitM3wA0eT6SvJNbpBPnxdmH6Yv15IJ0zzlsndBERrfbtFY+gcDKF792qkMMZ1S+
         hUTOcsSQ5Xgf6vCWD4LHDZyxMJQQ1yuU8OOnwgC8W66wFP9Hhpv58IbiirLI5/SrYJxG
         6OQ7W+ZrtMihhKoB2Tx3M4Ps/x25I8vl1K3WE3q5VUL+nnMvqB1HyqYPOKq0vqfxdloY
         0hSP+rNai6iWw3kBn8ctTdDDP0b6jhg7uSsyslp0JgDP2zYz3aI0iuQkJcJUWdPHhpRN
         h40kKy4+msqSMVMGJxCctpFjlVleU/bN6HLyNkZX2HefZSLd2kna0uGaHj9zvaHZvh3M
         0fAw==
X-Forwarded-Encrypted: i=1; AJvYcCUFW7Poh9/PjXl609G+YWAqtUnhFjo79JS1dOFGcMihYeKBp2QcGPL7SeIfm9vpweN/TVN+Rus/q2xscR0yESIf@vger.kernel.org
X-Gm-Message-State: AOJu0YxChGQETH4gz7S6tBcjRdc829zuZGPKPPEWArhyYozHTPxASI2s
	LKOor1RbNzQEugC/+mWQDULESFaR+tUjqTQN/l40G3V1PB9SmSw7hEMPV27+U5bU23e5eiL+jCE
	arYVunQ==
X-Google-Smtp-Source: AGHT+IFYZeA/1Yjha10aGWWmoHIcleNuAFmNne8CK5ME9Ml1zcteifWQF4rCyiueQYdIVptKTzpY36jecuo=
X-Received: from pjer9.prod.google.com ([2002:a17:90a:ac9:b0:343:6d9b:86c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2784:b0:33f:eca0:47ae
 with SMTP id 98e67ed59e1d1-349a262dda2mr610988a91.28.1764980289948; Fri, 05
 Dec 2025 16:18:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:58 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-23-seanjc@google.com>
Subject: [PATCH v6 22/44] KVM: x86/pmu: Disable interception of select PMU
 MSRs for mediated vPMUs
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Xudong Hao <xudong.hao@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

For vCPUs with a mediated vPMU, disable interception of counter MSRs for
PMCs that are exposed to the guest, and for GLOBAL_CTRL and related MSRs
if they are fully supported according to the vCPU model, i.e. if the MSRs
and all bits supported by hardware exist from the guest's point of view.

Do NOT passthrough event selector or fixed counter control MSRs, so that
KVM can enforce userspace-defined event filters, e.g. to prevent use of
AnyThread events (which is unfortunately a setting in the fixed counter
control MSR).

Defer support for nested passthrough of mediated PMU MSRs to the future,
as the logic for nested MSR interception is unfortunately vendor specific.

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
[sean: squash patches, massage changelog, refresh VMX MSRs on filter change]
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c           | 41 +++++++++++++++++--------
 arch/x86/kvm/pmu.h           |  1 +
 arch/x86/kvm/svm/svm.c       | 36 ++++++++++++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c | 13 --------
 arch/x86/kvm/vmx/pmu_intel.h | 15 +++++++++
 arch/x86/kvm/vmx/vmx.c       | 59 +++++++++++++++++++++++++++++-------
 6 files changed, 128 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c4a32bfb26f5..57833f29a746 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -719,27 +719,41 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	return 0;
 }
 
-bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
+static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
 	if (!kvm_vcpu_has_mediated_pmu(vcpu))
 		return true;
 
-	/*
-	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
-	 * in Ring3 when CR4.PCE=0.
-	 */
-	if (enable_vmware_backdoor)
-		return true;
-
 	/*
 	 * Note!  Check *host* PMU capabilities, not KVM's PMU capabilities, as
 	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
 	 * capabilities themselves may be a subset of hardware capabilities.
 	 */
 	return pmu->nr_arch_gp_counters != kvm_host_pmu.num_counters_gp ||
-	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed ||
+	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
+}
+
+bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
+{
+	return kvm_need_any_pmc_intercept(vcpu) ||
+	       !kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
+
+bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	/*
+	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
+	 * in Ring3 when CR4.PCE=0.
+	 */
+	if (enable_vmware_backdoor)
+		return true;
+
+	return kvm_need_any_pmc_intercept(vcpu) ||
 	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
 	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
 }
@@ -936,11 +950,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	 * in the global controls).  Emulate that behavior when refreshing the
 	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
 	 */
-	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters) {
+	if (pmu->nr_arch_gp_counters &&
+	    (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated_pmu(vcpu)))
 		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
-		if (kvm_vcpu_has_mediated_pmu(vcpu))
-			kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
-	}
+
+	if (kvm_vcpu_has_mediated_pmu(vcpu))
+		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
 
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
 	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 2ff469334c1a..356b08e92bc9 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -239,6 +239,7 @@ void kvm_pmu_instruction_retired(struct kvm_vcpu *vcpu);
 void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
+bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu);
 bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu);
 
 extern struct kvm_pmu_ops intel_pmu_ops;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 11913574de88..fa04e58ff524 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -730,6 +730,40 @@ void svm_vcpu_free_msrpm(void *msrpm)
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
 }
 
+static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	int i;
+
+	if (!enable_mediated_pmu)
+		return;
+
+	/* Legacy counters are always available for AMD CPUs with a PMU. */
+	for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++)
+		svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
+					  MSR_TYPE_RW, intercept);
+
+	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++)
+		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
+					  MSR_TYPE_RW, intercept);
+
+	for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
+		svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
+					     MSR_TYPE_RW);
+
+	intercept = kvm_need_perf_global_ctrl_intercept(vcpu);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+				  MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+				  MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+				  MSR_TYPE_RW, intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
+				  MSR_TYPE_RW, intercept);
+}
+
 static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -798,6 +832,8 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	if (sev_es_guest(vcpu->kvm))
 		sev_es_recalc_msr_intercepts(vcpu);
 
+	svm_recalc_pmu_msr_intercepts(vcpu);
+
 	/*
 	 * x2APIC intercepts are modified on-demand and cannot be filtered by
 	 * userspace.
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index dbab7cca7a62..820da47454d7 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -128,19 +128,6 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	return &counters[array_index_nospec(idx, num_counters)];
 }
 
-static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
-{
-	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
-		return 0;
-
-	return vcpu->arch.perf_capabilities;
-}
-
-static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
-{
-	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
-}
-
 static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
 {
 	if (!fw_writes_is_enabled(pmu_to_vcpu(pmu)))
diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
index 5620d0882cdc..5d9357640aa1 100644
--- a/arch/x86/kvm/vmx/pmu_intel.h
+++ b/arch/x86/kvm/vmx/pmu_intel.h
@@ -4,6 +4,21 @@
 
 #include <linux/kvm_host.h>
 
+#include "cpuid.h"
+
+static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
+{
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
+		return 0;
+
+	return vcpu->arch.perf_capabilities;
+}
+
+static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
+{
+	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
+}
+
 bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);
 int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 72b92cea9d72..f0a20ff2a941 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4228,6 +4228,53 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	bool has_mediated_pmu = kvm_vcpu_has_mediated_pmu(vcpu);
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool intercept = !has_mediated_pmu;
+	int i;
+
+	if (!enable_mediated_pmu)
+		return;
+
+	vm_entry_controls_changebit(vmx, VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL,
+				    has_mediated_pmu);
+
+	vm_exit_controls_changebit(vmx, VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+					VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
+				   has_mediated_pmu);
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
+					  MSR_TYPE_RW, intercept);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TYPE_RW,
+					  intercept || !fw_writes_is_enabled(vcpu));
+	}
+	for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
+					  MSR_TYPE_RW, true);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i,
+					  MSR_TYPE_RW, true);
+	}
+
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
+		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
+					  MSR_TYPE_RW, intercept);
+	for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)
+		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
+					  MSR_TYPE_RW, true);
+
+	intercept = kvm_need_perf_global_ctrl_intercept(vcpu);
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS,
+				  MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
+				  MSR_TYPE_RW, intercept);
+	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
+				  MSR_TYPE_RW, intercept);
+}
+
 static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	bool intercept;
@@ -4294,17 +4341,7 @@ static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET, MSR_TYPE_RW, intercept);
 	}
 
-	if (enable_mediated_pmu) {
-		bool is_mediated_pmu = kvm_vcpu_has_mediated_pmu(vcpu);
-		struct vcpu_vmx *vmx = to_vmx(vcpu);
-
-		vm_entry_controls_changebit(vmx,
-					    VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL, is_mediated_pmu);
-
-		vm_exit_controls_changebit(vmx,
-					   VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
-					   VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, is_mediated_pmu);
-	}
+	vmx_recalc_pmu_msr_intercepts(vcpu);
 
 	/*
 	 * x2APIC and LBR MSR intercepts are modified on-demand and cannot be
-- 
2.52.0.223.gf5cc29aaa4-goog

