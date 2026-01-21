Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496929D29D
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036117; cv=none; b=nFcrplfCFNYcKTIucdOQjOxLK/2IWtGCw5e3Ly13Df/xkk0a0+5GjrRbwKM2BDFuZJtxG4EnWTcX82/7Ct4N6kttoDGToNj28Yj4gbUOSo8tk3LPlBfAocwNsrA2KLiA4l8o2Rh4dDo+6QyTAiMRBbzEYVQAOHzZk2epCSbOA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036117; c=relaxed/simple;
	bh=gLJ9pP4KbjVkIZBDUiydWO3ATbRPdgqnRoeV2aYIC0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lD4NxYjrfct18Dq7wx9VMiRrQdESGVs7sCqvF2NF9WXffDs6P2YeQrYci0YoovVUfsEruAn0rEC5oMyIO+ao0WwMLLhRfonemMe2/skdp8IuHSgAAgVHIMqLOODbm7443BSwWunbI1wKkP7eChC59pVhMuxbbOkeKsx0Dt0zWyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1nuneVu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1nuneVu"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ec823527eso536324a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769036110; x=1769640910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYZnEa6Bb/f2/6ej1BUpAz8CiN6p1EtpnBTMXq8YhlA=;
        b=W1nuneVucFkDeLy07WKwR7WvXqdoUrSlkgTfF8EINic3KY514C2zkG8D0jEFK/6Jrm
         qiFDDxyvJOCwC6ohFYKEWtDH8Y96OjD0+anCMjR2eKo/AqWNJv1nPZhHOvJiqn2uznCB
         rRZqi8f+qum+EZjcOqknJvxwQdqs1r6GygCv2bDUw5ZkBCidhXnp+Suzsw1CkdI23YTf
         wAGDF56XT3Tf3GxSVYitWQsvAN9ExIBogDDNlgPUzHbn+ZVs+JFfxMU3WpxLZxmkZrXa
         Yp1nqJ1qfWrqoLQciXroSVCgPbhyXw0abzopwsQySkSFEdtsX84bQmKxBRBhC52xlwqe
         SNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036110; x=1769640910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYZnEa6Bb/f2/6ej1BUpAz8CiN6p1EtpnBTMXq8YhlA=;
        b=Bw2iDa0AiQa6Xu+AJ8pVKGg/n3NPI6CluLvRo4P2TMWcjNwp2lTFOm5uxI6nPXfwil
         BGc9KbuVCDvvvDgsmapvqVUpFh8rf3cHIx0wU2U9BPvGlmKNGW/OrNTGuENJkoJUOgD4
         /qLjaZnCd0zOlqm0oNE2MxSvK2iBIGRR7J3MW6OU8wZ0XqHm+txl9KLfm7Eo8HmEhMqT
         yzSaQcLKt8SNi+AIYU6Vo6hLtK+FOcOHP96+tTcGbOLTew7IYly0doCGP7Un+1Elb9LC
         E45SQqFtgoCh0OAh009+S4k0saa2sbyPXEXSmQinp1g5vEaV9aUgCzHfGzzf1yOKwCxB
         zDbg==
X-Forwarded-Encrypted: i=1; AJvYcCUHD9si637JL0I8hy6qUVUAC6ANxXJT4nCIzBcpLrynqQJso76oeUmhhhJO0vCA5fdez2rIFSDNxL+CpBntjgz7@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAqInczUyVCReZkK3GCfD0RkTO6FY6AJGZKeORzpXO2Pt8H+M
	s5kT/dRvKJ8Z+WGgrpLiUZIOJFK7XjFldPd0cxDQ4cqBQ+4LEQJzWA775HDhtDrYfz3CPMb3JAE
	LIX2LbSFcazIlWQ==
X-Received: from pjbnp3.prod.google.com ([2002:a17:90b:4c43:b0:352:c99c:60b2])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d84:b0:352:e796:bb65 with SMTP id 98e67ed59e1d1-352e796bbbamr4837712a91.31.1769036109597;
 Wed, 21 Jan 2026 14:55:09 -0800 (PST)
Date: Wed, 21 Jan 2026 14:54:02 -0800
In-Reply-To: <20260121225438.3908422-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121225438.3908422-5-jmattson@google.com>
Subject: [PATCH 4/6] KVM: x86/pmu: [De]activate HG_ONLY PMCs at SVME changes
 and nested transitions
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new function, kvm_pmu_set_pmc_eventsel_hw_enable(), to set or clear
the enable bit in eventsel_hw for PMCs identified by a bitmap.

Use this function to update Host-Only and Guest-Only counters at the
following transitions:

  - svm_set_efer(): When SVME changes, enable Guest-Only counters if SVME
    is being cleared (HG_ONLY bits become ignored), or disable them if SVME
    is being set (L1 is active).

  - nested_svm_vmrun(): Disable Host-Only counters and enable Guest-Only
    counters.

  - nested_svm_vmexit(): Disable Guest-Only counters and enable Host-Only
    counters.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/kvm/pmu.c                     |  7 +++++++
 arch/x86/kvm/pmu.h                     |  4 ++++
 arch/x86/kvm/svm/nested.c              | 10 ++++++++++
 arch/x86/kvm/svm/pmu.c                 | 17 +++++++++++++++++
 arch/x86/kvm/svm/svm.c                 |  3 +++
 6 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index f0aa6996811f..7b32796213a0 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -26,6 +26,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
 KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
 KVM_X86_PMU_OP(mediated_load)
 KVM_X86_PMU_OP(mediated_put)
+KVM_X86_PMU_OP_OPTIONAL(set_pmc_eventsel_hw_enable)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 833ee2ecd43f..1541c201285b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1142,6 +1142,13 @@ void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_branch_retired);
 
+void kvm_pmu_set_pmc_eventsel_hw_enable(struct kvm_vcpu *vcpu,
+				       unsigned long *bitmap, bool enable)
+{
+	kvm_pmu_call(set_pmc_eventsel_hw_enable)(vcpu, bitmap, enable);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_set_pmc_eventsel_hw_enable);
+
 static bool is_masked_filter_valid(const struct kvm_x86_pmu_event_filter *filter)
 {
 	u64 mask = kvm_pmu_ops.EVENTSEL_EVENT |
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 0925246731cb..b8be8b6e40d8 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -41,6 +41,8 @@ struct kvm_pmu_ops {
 	void (*mediated_load)(struct kvm_vcpu *vcpu);
 	void (*mediated_put)(struct kvm_vcpu *vcpu);
 	void (*write_global_ctrl)(u64 global_ctrl);
+	void (*set_pmc_eventsel_hw_enable)(struct kvm_vcpu *vcpu,
+					   unsigned long *bitmap, bool enable);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
@@ -258,6 +260,8 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_instruction_retired(struct kvm_vcpu *vcpu);
 void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu);
+void kvm_pmu_set_pmc_eventsel_hw_enable(struct kvm_vcpu *vcpu,
+				       unsigned long *bitmap, bool enable);
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index de90b104a0dd..edaa76e38417 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -28,6 +28,7 @@
 #include "smm.h"
 #include "cpuid.h"
 #include "lapic.h"
+#include "pmu.h"
 #include "svm.h"
 #include "hyperv.h"
 
@@ -1054,6 +1055,11 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
 		goto out_exit_err;
 
+	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
+		vcpu_to_pmu(vcpu)->pmc_hostonly, false);
+	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
+		vcpu_to_pmu(vcpu)->pmc_guestonly, true);
+
 	if (nested_svm_merge_msrpm(vcpu))
 		goto out;
 
@@ -1137,6 +1143,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
+	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
+		vcpu_to_pmu(vcpu)->pmc_hostonly, true);
+	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
+		vcpu_to_pmu(vcpu)->pmc_guestonly, false);
 	svm->nested.vmcb12_gpa = 0;
 	WARN_ON_ONCE(svm->nested.nested_run_pending);
 
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c06013e2b4b1..85155d65fa38 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -316,6 +316,22 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
 		wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
 }
 
+static void amd_pmu_set_pmc_eventsel_hw_enable(struct kvm_vcpu *vcpu,
+					       unsigned long *bitmap,
+					       bool enable)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int i;
+
+	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
+		if (enable)
+			pmc->eventsel_hw |= ARCH_PERFMON_EVENTSEL_ENABLE;
+		else
+			pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+	}
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -329,6 +345,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.is_mediated_pmu_supported = amd_pmu_is_mediated_pmu_supported,
 	.mediated_load = amd_mediated_pmu_load,
 	.mediated_put = amd_mediated_pmu_put,
+	.set_pmc_eventsel_hw_enable = amd_pmu_set_pmc_eventsel_hw_enable,
 
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_AMD_GP_COUNTERS,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7803d2781144..953089b38921 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -244,6 +244,9 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 			if (svm_gp_erratum_intercept && !sev_guest(vcpu->kvm))
 				set_exception_intercept(svm, GP_VECTOR);
 		}
+
+		kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
+			vcpu_to_pmu(vcpu)->pmc_guestonly, !(efer & EFER_SVME));
 	}
 
 	svm->vmcb->save.efer = efer | EFER_SVME;
-- 
2.52.0.457.g6b5491de43-goog

