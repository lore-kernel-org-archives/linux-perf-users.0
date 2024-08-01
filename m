Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2F14D422
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488414; cv=none; b=rYmz/wkrR+6T2NXRMMz8hQfWpD/73YBM42qgdJZAz1UJ6tX0E5jfSDTFdhifS0NHV70RhCA2qq1tIVzsExXGoNW1rgBXr+IOKFyv/xxinvEiO5h522Mdkyydo0ZHJed5u5PhOtZtcvQN6pZv7cbStRA6V9HCZRdA0M9AhJ/DE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488414; c=relaxed/simple;
	bh=FBh94zCGJGvi1JIg6LM0uz999OeW76OKHNijRrT9eVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHUpWxf11c+p+U/KyyDpl3m6LAX3fyHqW3FtjbQHhcpBREv8PJrbfSoRaIo2V+XFoF1yrof2cEkE5WKhQpGAt+7w2lJDeUf3YzZVGQGiZUNQU5Xq7J4/SAkFQeKK1k21H0WqdySkONif5QxYcFvUXvmFACCcLvzyQHxKATj6AF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X3h/OsZI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3h/OsZI"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a2d4261a48so5196326a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488412; x=1723093212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JRgfZdTWC6ROEv8+dJ/jds7GWG7YC6PLcmHROAgx7aE=;
        b=X3h/OsZIW3U6Fr3X2MCMt5f1w1DygOp2xpMaRauk1aZItcHi94qEJWLYKYaBv7d4gp
         Rl6KZ8MobqcTCLcCSfiAGJUAePp8aysBlyXlIYhHUEuPijkpUtQpBpVr1MuB0zXRpIVq
         1LV8JAeorlHAWpuZy5AXdARTZjMIUtZTXplZ49uOGz+jk6p/bjyrf1OSgDLPENKQ7Cy9
         rJzzXxU8VZgLcTzIUjj52CDhT46svJYSbjfjIpWjAhUhcJ1n8yCPBo94JA+ZorATjK1i
         FU7lg8mxYrQxJ5yz/suzlXskvtrxp3F2a5D7GeFx6DOEXs2vlwZr2qar7uLv9+30nKMn
         ABgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488412; x=1723093212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRgfZdTWC6ROEv8+dJ/jds7GWG7YC6PLcmHROAgx7aE=;
        b=h/vLW4ZIEpO4x2YPWZR7mZz9noiCDDSLNHT+EnCLm7VsnLRmtF2wrjV719XHHFrjbG
         UVJdcV59ITEgnpkL0xhD59bIKAtie1ebxN9dLgoRiMfqkyNLwUjhmg821q9d4x3KBTnF
         byR6yQYnVaxx5GlbM7wZnCLCUs5QjAwXNFKFL9hoP1GHIVkEi36s90llSl1Nql83ROH8
         M/4GKZeHgzv63rI944edOfrXH4Vuh+qCJZwOpy0JzvozEhu4N7ho5QIEkp/l+bXalUDX
         Xx7bgwxupHy5paFUqBu0FU6C7EIazuBSgMaLvzPxreX0MV+rcv68gSWF07EaE+6p1MwH
         dZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5mCJYNYxzL61S+zangd9uQjpcBlpKIUGaQhtt6br2XAGQyip/wiz/+WW742JnBuJoI9bvBwJ1UxHive0mxXtvJ6+qfb+YcX1Gg25hZQN/Aw==
X-Gm-Message-State: AOJu0Ywcl37ukMayP8D/LjL1Mz1myv1G9YqeDXl6VWOCvG70GVVMmLe5
	Am9GSoHAbl+VMvBFb7+3Ss+td53iQiY1pGyWU13Vbrn2VgTVeZYymfcPzdRm8QJ2kLiDeWOmuQ1
	byxemkA==
X-Google-Smtp-Source: AGHT+IFVXsLsgX4z9IgU0GJZDbgbP5o4RXhYLKjV6/E4VfUKjCf3tJaeScC15MZLxWjRr53zsR7h+SzEyiFz
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:902:e748:b0:1fb:54d9:ebb3 with SMTP id
 d9443c01a7336-1ff4ce9bc66mr989875ad.6.1722488411752; Wed, 31 Jul 2024
 22:00:11 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:42 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-34-mizhang@google.com>
Subject: [RFC PATCH v3 33/58] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
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

Implement the save/restore of PMU state for pasthrough PMU in Intel. In
passthrough mode, KVM owns exclusively the PMU HW when control flow goes to
the scope of passthrough PMU. Thus, KVM needs to save the host PMU state
and gains the full HW PMU ownership. On the contrary, host regains the
ownership of PMU HW from KVM when control flow leaves the scope of
passthrough PMU.

Implement PMU context switches for Intel CPUs and opptunistically use
rdpmcl() instead of rdmsrl() when reading counters since the former has
lower latency in Intel CPUs.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/kvm/pmu.c           | 46 ++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c | 41 +++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 782b564bdf96..9bb733384069 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1068,14 +1068,60 @@ void kvm_pmu_passthrough_pmu_msrs(struct kvm_vcpu *vcpu)
 
 void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	u32 i;
+
 	lockdep_assert_irqs_disabled();
 
 	static_call_cond(kvm_x86_pmu_save_pmu_context)(vcpu);
+
+	/*
+	 * Clear hardware selector MSR content and its counter to avoid
+	 * leakage and also avoid this guest GP counter get accidentally
+	 * enabled during host running when host enable global ctrl.
+	 */
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		pmc = &pmu->gp_counters[i];
+		rdpmcl(i, pmc->counter);
+		rdmsrl(pmc->msr_eventsel, pmc->eventsel);
+		if (pmc->counter)
+			wrmsrl(pmc->msr_counter, 0);
+		if (pmc->eventsel)
+			wrmsrl(pmc->msr_eventsel, 0);
+	}
+
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+		pmc = &pmu->fixed_counters[i];
+		rdpmcl(INTEL_PMC_FIXED_RDPMC_BASE | i, pmc->counter);
+		if (pmc->counter)
+			wrmsrl(pmc->msr_counter, 0);
+	}
 }
 
 void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int i;
+
 	lockdep_assert_irqs_disabled();
 
 	static_call_cond(kvm_x86_pmu_restore_pmu_context)(vcpu);
+
+	/*
+	 * No need to zero out unexposed GP/fixed counters/selectors since RDPMC
+	 * in this case will be intercepted. Accessing to these counters and
+	 * selectors will cause #GP in the guest.
+	 */
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		pmc = &pmu->gp_counters[i];
+		wrmsrl(pmc->msr_counter, pmc->counter);
+		wrmsrl(pmc->msr_eventsel, pmu->gp_counters[i].eventsel);
+	}
+
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
+		pmc = &pmu->fixed_counters[i];
+		wrmsrl(pmc->msr_counter, pmc->counter);
+	}
 }
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 0de918dc14ea..89c8f73a48c8 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -572,7 +572,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
-		pmu->fixed_counters[i].msr_eventsel = MSR_CORE_PERF_FIXED_CTR_CTRL;
+		pmu->fixed_counters[i].msr_eventsel = 0;
 		pmu->fixed_counters[i].msr_counter = MSR_CORE_PERF_FIXED_CTR0 + i;
 	}
 }
@@ -799,6 +799,43 @@ static void intel_passthrough_pmu_msrs(struct kvm_vcpu *vcpu)
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, MSR_TYPE_RW, msr_intercept);
 }
 
+static void intel_save_guest_pmu_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	/* Global ctrl register is already saved at VM-exit. */
+	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
+	/* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. */
+	if (pmu->global_status)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status);
+
+	rdmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl);
+	/*
+	 * Clear hardware FIXED_CTR_CTRL MSR to avoid information leakage and
+	 * also avoid these guest fixed counters get accidentially enabled
+	 * during host running when host enable global ctrl.
+	 */
+	if (pmu->fixed_ctr_ctrl)
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
+}
+
+static void intel_restore_guest_pmu_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	u64 global_status, toggle;
+
+	/* Clear host global_ctrl MSR if non-zero. */
+	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
+	toggle = pmu->global_status ^ global_status;
+	if (global_status & toggle)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
+	if (pmu->global_status & toggle)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
+
+	wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl);
+}
+
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
@@ -812,6 +849,8 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.cleanup = intel_pmu_cleanup,
 	.is_rdpmc_passthru_allowed = intel_is_rdpmc_passthru_allowed,
 	.passthrough_pmu_msrs = intel_passthrough_pmu_msrs,
+	.save_pmu_context = intel_save_guest_pmu_context,
+	.restore_pmu_context = intel_restore_guest_pmu_context,
 	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_INTEL_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = 1,
-- 
2.46.0.rc1.232.g9752f9e123-goog

