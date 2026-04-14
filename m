Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8431B100
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194079; cv=none; b=nSci+d1jnm5w+qirdP/+do8vXOHCpRhvbwTrXw1fVrZknX6uPkdXvLWJchOyHKZW2xAhp6nshZpTNRfM3nLHrf0VgcHNCekaeCTArkurW/+qQz7ZyUYsYKwzKKpuOjR4EeN9H4wmpvP+fH6sw9/iWxhHj+XReFQVQGfjNAzHz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194079; c=relaxed/simple;
	bh=MsbAe7EnaPZ5nTEko681Nsp2L/NCmCj7xIq9wgHtl2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RnWWCVaJSpvxdautuV+WYy5ui/yGDn647gn/ciZyngMdB6851GUioIomdxOCItFYMvaXvSt8ATbs0oqPmTNgyhS9tKnOFyyWMgSaeRHo3iWB3Sh8qh2ZmttOJ6mPYNPziez98rUz7sPhtHaIK9ST8TOwSHF1AK/ii07rvWOtBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tq+sNEIN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tq+sNEIN"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d40278103so3783215b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776194077; x=1776798877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kdmfahh/EOWDmhZ848Vt8AX6Mt80XdZTFosxlYs7Rec=;
        b=Tq+sNEIN00kicn9c/HSdpIfL8yJumh32DCH6SV5YoUb09fL636Olubg/0Tj3bw5aHZ
         ykHQ4Zxwu4SRtmQ/1gPOasvjOPfGVMW9QOkZwQRVDSt0PqtJfsD+CPor6gO85mHAyhRK
         zh18IsXEa0KyLhDRfTuWrJA//Tr6tAlstUMilI+NMQ4B5iyW0PsAmay02wgi/GVTpSyc
         4kKElHlSAgPwH7R/LztUVJhN893BtWlNgT/eAtTc4DdHIUrLXDSoogLb0mnTd7YlZ8WN
         2ZcTZ92uExM5ahSjkC9SnwijYzvj4MBgkJawqJAV5SArgd+ACr3sUAahMnSY1jNzne0C
         SiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194077; x=1776798877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdmfahh/EOWDmhZ848Vt8AX6Mt80XdZTFosxlYs7Rec=;
        b=qp+C9LdOC0m1j882+rvqx4zBclNgP+9QFVHrIQtpOwVpR63IeZf45BjiOPXpuPaSYf
         9Z1Jb/OkLD1Zxop9LuO6rYgkMjpejWQ5QWxGa5DAGZo6LT0YPm8mznFRYYGtQiYhRUMb
         dMqazbCooTw88j/oFiGKplsC/xMaE8WH4ogm9kxxB0a8bg+b9I7uHD2tllyg7z5ZTSRp
         f/kdlWrvvg9VoYgzMTBGGOw6ybLEW/us4bUowrp9xdKXWmBDVFV9eSEjkS5HlWH74KpI
         XoY5TDa0wVP/sgaNQVz7ndJCRpTzUWkcwIUPi8MUJ1zEB3zmN5Ptd1xz5bDfM6MfMnCW
         Y00g==
X-Gm-Message-State: AOJu0YzU35DwvXbueEnEsSupuUefbFOsxAGvbY4zeCXimYt2/NunCQbZ
	xN/DCZdxiQJLVdMLgyaDGTEcq0cQnrhEJAgVZboomUMfGWzthIUf6NdhBbVB50i2G+e4cKjn6Yh
	IYfIi7g==
X-Received: from pfbg28.prod.google.com ([2002:a05:6a00:ae1c:b0:829:a18b:94dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d0f:b0:82c:d9d0:f482
 with SMTP id d2e1a72fcca58-82f0c3b7ad9mr21219736b3a.46.1776194077106; Tue, 14
 Apr 2026 12:14:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Apr 2026 12:14:25 -0700
In-Reply-To: <20260414191425.2697918-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414191425.2697918-5-seanjc@google.com>
Subject: [PATCH 4/4] perf/x86: KVM: Have perf define a dedicated struct for
 getting guest PEBS data
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Have perf define a struct for getting guest PEBS data from KVM instead of
poking into the kvm_pmu structure.  Passing in an entire "struct kvm_pmu"
_as an opaque pointer_ to get at four fields is silly, especially since
one of the fields exists purely to convey information to perf, i.e. isn't
used by KVM.

Perf should also own its APIs, i.e. define what fields/data it needs, not
rely on KVM to throw fields into data structures that effectively hold
KVM-internal state.

Opportunistically rephrase the comment about cross-mapped counters to
explain *why* PEBS needs to be disabled.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c            |  5 +++--
 arch/x86/events/intel/core.c      | 14 +++++++-------
 arch/x86/events/perf_event.h      |  3 ++-
 arch/x86/include/asm/kvm_host.h   |  9 ---------
 arch/x86/include/asm/perf_event.h | 12 ++++++++++--
 arch/x86/kvm/vmx/pmu_intel.c      | 20 +++++++++++++++++---
 arch/x86/kvm/vmx/vmx.c            | 11 +++++++----
 arch/x86/kvm/vmx/vmx.h            |  2 +-
 8 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21ffd99..e6f788e72e72 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -723,9 +723,10 @@ void x86_pmu_disable_all(void)
 	}
 }
 
-struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data)
+struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
+						  struct x86_guest_pebs *guest_pebs)
 {
-	return static_call(x86_pmu_guest_get_msrs)(nr, data);
+	return static_call(x86_pmu_guest_get_msrs)(nr, guest_pebs);
 }
 EXPORT_SYMBOL_FOR_KVM(perf_guest_get_msrs);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9a78731deea2..eded12764775 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/nmi.h>
-#include <linux/kvm_host.h>
 
 #include <asm/cpufeature.h>
 #include <asm/debugreg.h>
@@ -4992,11 +4991,11 @@ static int intel_pmu_hw_config(struct perf_event *event)
  * when it uses {RD,WR}MSR, which should be handled by the KVM context,
  * specifically in the intel_pmu_{get,set}_msr().
  */
-static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
+static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
+							  struct x86_guest_pebs *guest_pebs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
-	struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
 	u64 guest_pebs_mask = pebs_mask & ~cpuc->intel_ctrl_host_mask;
@@ -5052,7 +5051,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
 	 * is using PEBS, to avoid bleeding host state into PEBS records.
 	 */
-	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
+	guest_pebs_mask &= guest_pebs->enable & ~guest_pebs->cross_mapped_mask;
 	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
 		guest_pebs_mask = 0;
 
@@ -5067,14 +5066,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	arr[(*nr)++] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_DS_AREA,
 		.host = (unsigned long)cpuc->ds,
-		.guest = kvm_pmu->ds_area,
+		.guest = guest_pebs->ds_area,
 	};
 
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		arr[(*nr)++] = (struct perf_guest_switch_msr){
 			.msr = MSR_PEBS_DATA_CFG,
 			.host = cpuc->active_pebs_data_cfg,
-			.guest = kvm_pmu->pebs_data_cfg,
+			.guest = guest_pebs->data_cfg,
 		};
 	}
 
@@ -5089,7 +5088,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	return arr;
 }
 
-static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr, void *data)
+static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr,
+							 struct x86_guest_pebs *guest_pebs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..19d811ca6b05 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1023,7 +1023,8 @@ struct x86_pmu {
 	/*
 	 * Intel host/guest support (KVM)
 	 */
-	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr, void *data);
+	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr,
+							struct x86_guest_pebs *guest_pebs);
 
 	/*
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..91b070168947 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -600,15 +600,6 @@ struct kvm_pmu {
 	u64 pebs_data_cfg;
 	u64 pebs_data_cfg_rsvd;
 
-	/*
-	 * If a guest counter is cross-mapped to host counter with different
-	 * index, its PEBS capability will be temporarily disabled.
-	 *
-	 * The user should make sure that this mask is updated
-	 * after disabling interrupts and before perf_guest_get_msrs();
-	 */
-	u64 host_cross_mapped_mask;
-
 	/*
 	 * The gate to release perf_events not marked in
 	 * pmc_in_use only once in a vcpu time slice.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ff5acb8b199b..5340d8bb1d92 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -769,11 +769,19 @@ extern void perf_load_guest_lvtpc(u32 guest_lvtpc);
 extern void perf_put_guest_lvtpc(void);
 #endif
 
+struct x86_guest_pebs {
+	u64	enable;
+	u64	ds_area;
+	u64	data_cfg;
+	u64	cross_mapped_mask;
+};
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
-extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
+extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
+							 struct x86_guest_pebs *guest_pebs);
 extern void x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
 #else
-struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
+struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
+						  struct x86_guest_pebs *guest_pebs);
 static inline void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
 	memset(lbr, 0, sizeof(*lbr));
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a0..0197007593f3 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -736,11 +736,24 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
 		intel_pmu_release_guest_lbr_event(vcpu);
 }
 
-void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
+u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu)
 {
-	struct kvm_pmc *pmc = NULL;
+	u64 host_cross_mapped_mask;
+	struct kvm_pmc *pmc;
 	int bit, hw_idx;
 
+	if (!(pmu->pebs_enable & pmu->global_ctrl))
+		return 0;
+
+	/*
+	 * Provide a mask of counters that are cross-mapped between the guest
+	 * and the host, i.e. where a guest PMC is mapped to a host PMC with a
+	 * different index.  PEBS records hold a PERF_GLOBAL_STATUS snapshot,
+	 * and so PEBS-enabled counters need to hold the correct index so as
+	 * not to confuse the guest.
+	 */
+	host_cross_mapped_mask = 0;
+
 	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
 		if (!pmc_is_locally_enabled(pmc) ||
 		    !pmc_is_globally_enabled(pmc) || !pmc->perf_event)
@@ -752,8 +765,9 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 		 */
 		hw_idx = pmc->perf_event->hw.idx;
 		if (hw_idx != pmc->idx && hw_idx > -1)
-			pmu->host_cross_mapped_mask |= BIT_ULL(hw_idx);
+			host_cross_mapped_mask |= BIT_ULL(hw_idx);
 	}
+	return host_cross_mapped_mask;
 }
 
 static bool intel_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pmu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..e6c1c64a8c94 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7313,12 +7313,15 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 	if (kvm_vcpu_has_mediated_pmu(&vmx->vcpu))
 		return;
 
-	pmu->host_cross_mapped_mask = 0;
-	if (pmu->pebs_enable & pmu->global_ctrl)
-		intel_pmu_cross_mapped_check(pmu);
+	struct x86_guest_pebs guest_pebs = {
+		.enable = pmu->pebs_enable,
+		.ds_area = pmu->ds_area,
+		.data_cfg = pmu->pebs_data_cfg,
+		.cross_mapped_mask = intel_pmu_get_cross_mapped_mask(pmu),
+	};
 
 	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
-	msrs = perf_guest_get_msrs(&nr_msrs, (void *)pmu);
+	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);
 	if (!msrs)
 		return;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index db84e8001da5..0c4563472940 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -659,7 +659,7 @@ static __always_inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
 	return container_of(vcpu, struct vcpu_vmx, vcpu);
 }
 
-void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu);
+u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu);
 int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
 void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);
 
-- 
2.54.0.rc0.605.g598a273b03-goog

