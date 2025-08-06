Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50B2D8380
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510299; cv=none; b=O7MLW/JSCdkXgUV8RWa2lvEoOeFcNQFwzJJ/9E+zY4wUQJSTX3neNT9OGzJ2N4cqkhFSAiSElEWJN3kplOJN6jaBHrbcAP9+OR9a242oslUH1s6+g2rTsPDsdd9JP9V7FiwffEFigyeMx60KJnOIriY558BVgpXSYkYDv+NPLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510299; c=relaxed/simple;
	bh=byG6xS28Uf7b/R4Aqls1ih01tm3g3UFbLNRST2TR/5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t8LSivJ4OiLPiHw9UjBTocxyhFLrmsz5wU3Z+zC5JCgBYRX9DlUSDY7pSOBTPlYGsa6rCIH3cD+xso6PJhUgoxcMLUUInKmQde4jYM1Zf6bYiV66QaV1OjdriPxyzAwoJ1/vPBgev9XCV+2wqERfif3WbYSkZm8pb0TKlbSz1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWXz4ill; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWXz4ill"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2424aaa9840so2089355ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510293; x=1755115093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgsu0fWGzXM1P0ieUy8M+NNgbe9X2+RcO7orAU+l0hA=;
        b=XWXz4illZG+jNmDDjzIFMe1K6RKAAsAOg4ZY+lniQAtDlFJDh5wZqhT+AGop63xHxy
         cl98U1Sr1vFAKdz98qWjmpsCLCdw6HPRoyjJaUZT02l0cqYWUFyjYnChifbLgBDIYL9C
         uBNM0e7n00Mcc+FE+TbAqd9XTdcWE8NkyYgZknJ+dmTJGHF0Xz/fN13nmLl0DqlQNL41
         J7MmjjK6tWNWNGnX6u83pnyiPact62OIJfmHNu3JBn1hRy2v+xaNxizA7WLkngRkUfo5
         VuKd93w6gNen7N+ClJO0CBk9TapSZJttQjgf+CGxFjbzGbkd4YCopETY72hIqWbATOI/
         IIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510293; x=1755115093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xgsu0fWGzXM1P0ieUy8M+NNgbe9X2+RcO7orAU+l0hA=;
        b=VwbpdcV0w+2j260k8CrDwpaXWRh3NLSZ0gwqI7GCrMLkq3CXO/lne2iAPkI/0Q2jqu
         hUkDEyWuN9brskaNPMi7k0tdOnD16gdXNsP2Kue9d/bt51Jwwvj7RL0E9DbPwxbSKgBj
         33I04KOL0SSx9+JHyF0E4tpRVZNHy+39mSF4LEmJxDxp0e2zjg+8zWTrOX2GsTu5TQmP
         +VDScvCV/iSIGIkqUc5OLb5izz/7rUR9JmN82n842bshNhvyxFjM3FafxvHIflGrIIyY
         MRAvgVrzOOIH2QoEhN0PxmC1kV8jM9K3DDcYVbyqowQD2HetXyMjQl3LN37A4hy/s5wa
         lsow==
X-Forwarded-Encrypted: i=1; AJvYcCWJr+gtmOm/05z8oNjRGtkRkVMBsbrn6CVwMjfRGnA1Wa+kF7TUi9K0AWyJgK5YpSodMe8fIAJq3YOXSPE3eoEY@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzeTKsaSfOTqdXBduSSe68MXS0ZQbAOq0iOaZ7UN9OeAuC03Q
	8zohm144HcgAfCk7+Ld8jYGcwGU5y90R4e+9/xD9kPqxxEnUwtJ1ZO0iUCYF4hGnryMiPActHY/
	ntpY7IQ==
X-Google-Smtp-Source: AGHT+IGjOVjMJgLz2fS/cn5FiFF0L2j0BQ8Kgspjt+cfMRIO/JKDaNYzPFPk3n1FGowkS6X5Jtr/S5JnoBk=
X-Received: from pjbgf4.prod.google.com ([2002:a17:90a:c7c4:b0:312:ea08:fa64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3504:b0:240:3e72:efb3
 with SMTP id d9443c01a7336-2429f42fa4cmr56513685ad.43.1754510293150; Wed, 06
 Aug 2025 12:58:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:46 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-25-seanjc@google.com>
Subject: [PATCH v5 24/44] KVM: x86: Rework KVM_REQ_MSR_FILTER_CHANGED into a
 generic RECALC_INTERCEPTS
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

Rework the MSR_FILTER_CHANGED request into a more generic RECALC_INTERCEPTS
request, and expand the responsibilities of vendor code to recalculate all
intercepts that vary based on userspace input, e.g. instruction intercepts
that are tied to guest CPUID.

Providing a generic recalc request will allow the upcoming mediated PMU
support to trigger a recalc when PMU features, e.g. PERF_CAPABILITIES, are
set by userspace, without having to make multiple calls to/from PMU code.
As a bonus, using a request will effectively coalesce recalcs, e.g. will
reduce the number of recalcs for normal usage from 3+ to 1 (vCPU create,
set CPUID, set PERF_CAPABILITIES (Intel only), set filter).

The downside is that MSR filter changes that are done in isolation will do
a small amount of unnecessary work, but that's already a relatively slow
path, and the cost of recalculating instruction intercepts is negligible.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  4 ++--
 arch/x86/kvm/svm/svm.c             |  8 ++++----
 arch/x86/kvm/vmx/main.c            | 14 +++++++-------
 arch/x86/kvm/vmx/vmx.c             |  9 +++++++--
 arch/x86/kvm/vmx/x86_ops.h         |  2 +-
 arch/x86/kvm/x86.c                 | 15 +++++++--------
 7 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 18a5c3119e1a..7c240e23bd52 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -138,7 +138,7 @@ KVM_X86_OP(check_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
 KVM_X86_OP_OPTIONAL(enable_l2_tlb_flush)
 KVM_X86_OP_OPTIONAL(migrate_timers)
-KVM_X86_OP(recalc_msr_intercepts)
+KVM_X86_OP(recalc_intercepts)
 KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ff0d753e2b07..b891bd92fc83 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -120,7 +120,7 @@
 #define KVM_REQ_TLB_FLUSH_GUEST \
 	KVM_ARCH_REQ_FLAGS(27, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_APF_READY		KVM_ARCH_REQ(28)
-#define KVM_REQ_MSR_FILTER_CHANGED	KVM_ARCH_REQ(29)
+#define KVM_REQ_RECALC_INTERCEPTS	KVM_ARCH_REQ(29)
 #define KVM_REQ_UPDATE_CPU_DIRTY_LOGGING \
 	KVM_ARCH_REQ_FLAGS(30, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_MMU_FREE_OBSOLETE_ROOTS \
@@ -1912,7 +1912,7 @@ struct kvm_x86_ops {
 	int (*enable_l2_tlb_flush)(struct kvm_vcpu *vcpu);
 
 	void (*migrate_timers)(struct kvm_vcpu *vcpu);
-	void (*recalc_msr_intercepts)(struct kvm_vcpu *vcpu);
+	void (*recalc_intercepts)(struct kvm_vcpu *vcpu);
 	int (*complete_emulated_msr)(struct kvm_vcpu *vcpu, int err);
 
 	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f7e1e665a826..3d9dcc66a407 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1077,7 +1077,7 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void svm_recalc_intercepts_after_set_cpuid(struct kvm_vcpu *vcpu)
+static void svm_recalc_intercepts(struct kvm_vcpu *vcpu)
 {
 	svm_recalc_instruction_intercepts(vcpu);
 	svm_recalc_msr_intercepts(vcpu);
@@ -1225,7 +1225,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 
 	svm_hv_init_vmcb(vmcb);
 
-	svm_recalc_intercepts_after_set_cpuid(vcpu);
+	svm_recalc_intercepts(vcpu);
 
 	vmcb_mark_all_dirty(vmcb);
 
@@ -4479,7 +4479,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (sev_guest(vcpu->kvm))
 		sev_vcpu_after_set_cpuid(svm);
 
-	svm_recalc_intercepts_after_set_cpuid(vcpu);
+	svm_recalc_intercepts(vcpu);
 }
 
 static bool svm_has_wbinvd_exit(void)
@@ -5181,7 +5181,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.apic_init_signal_blocked = svm_apic_init_signal_blocked,
 
-	.recalc_msr_intercepts = svm_recalc_msr_intercepts,
+	.recalc_intercepts = svm_recalc_intercepts,
 	.complete_emulated_msr = svm_complete_emulated_msr,
 
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index dbab1c15b0cd..68dcafd177a8 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -188,18 +188,18 @@ static int vt_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return vmx_get_msr(vcpu, msr_info);
 }
 
-static void vt_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
+static void vt_recalc_intercepts(struct kvm_vcpu *vcpu)
 {
 	/*
-	 * TDX doesn't allow VMM to configure interception of MSR accesses.
-	 * TDX guest requests MSR accesses by calling TDVMCALL.  The MSR
-	 * filters will be applied when handling the TDVMCALL for RDMSR/WRMSR
-	 * if the userspace has set any.
+	 * TDX doesn't allow VMM to configure interception of instructions or
+	 * MSR accesses.  TDX guest requests MSR accesses by calling TDVMCALL.
+	 * The MSR filters will be applied when handling the TDVMCALL for
+	 * RDMSR/WRMSR if the userspace has set any.
 	 */
 	if (is_td_vcpu(vcpu))
 		return;
 
-	vmx_recalc_msr_intercepts(vcpu);
+	vmx_recalc_intercepts(vcpu);
 }
 
 static int vt_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
@@ -995,7 +995,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.apic_init_signal_blocked = vt_op(apic_init_signal_blocked),
 	.migrate_timers = vmx_migrate_timers,
 
-	.recalc_msr_intercepts = vt_op(recalc_msr_intercepts),
+	.recalc_intercepts = vt_op(recalc_intercepts),
 	.complete_emulated_msr = vt_op(complete_emulated_msr),
 
 	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 93b87f9e6dfd..2244ca074e9d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4068,7 +4068,7 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
+static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	if (!cpu_has_vmx_msr_bitmap())
 		return;
@@ -4121,6 +4121,11 @@ void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	 */
 }
 
+void vmx_recalc_intercepts(struct kvm_vcpu *vcpu)
+{
+	vmx_recalc_msr_intercepts(vcpu);
+}
+
 static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 						int vector)
 {
@@ -7778,7 +7783,7 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 			~FEAT_CTL_SGX_LC_ENABLED;
 
 	/* Recalc MSR interception to account for feature changes. */
-	vmx_recalc_msr_intercepts(vcpu);
+	vmx_recalc_intercepts(vcpu);
 
 	/* Refresh #PF interception to account for MAXPHYADDR changes. */
 	vmx_update_exception_bitmap(vcpu);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 2b3424f638db..2c590ff44ced 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -52,7 +52,7 @@ void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector);
 void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
 bool vmx_has_emulated_msr(struct kvm *kvm, u32 index);
-void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu);
+void vmx_recalc_intercepts(struct kvm_vcpu *vcpu);
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
 int vmx_get_feature_msr(u32 msr, u64 *data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c34dd3f0222..69f5d9deb75f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6742,7 +6742,11 @@ static int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm,
 
 	kvm_free_msr_filter(old_filter);
 
-	kvm_make_all_cpus_request(kvm, KVM_REQ_MSR_FILTER_CHANGED);
+	/*
+	 * Recalc MSR intercepts as userspace may want to intercept accesses to
+	 * MSRs that KVM would otherwise pass through to the guest.
+	 */
+	kvm_make_all_cpus_request(kvm, KVM_REQ_RECALC_INTERCEPTS);
 
 	return 0;
 }
@@ -10765,13 +10769,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_APF_READY, vcpu))
 			kvm_check_async_pf_completion(vcpu);
 
-		/*
-		 * Recalc MSR intercepts as userspace may want to intercept
-		 * accesses to MSRs that KVM would otherwise pass through to
-		 * the guest.
-		 */
-		if (kvm_check_request(KVM_REQ_MSR_FILTER_CHANGED, vcpu))
-			kvm_x86_call(recalc_msr_intercepts)(vcpu);
+		if (kvm_check_request(KVM_REQ_RECALC_INTERCEPTS, vcpu))
+			kvm_x86_call(recalc_intercepts)(vcpu);
 
 		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
 			kvm_x86_call(update_cpu_dirty_logging)(vcpu);
-- 
2.50.1.565.gc32cd1483b-goog

