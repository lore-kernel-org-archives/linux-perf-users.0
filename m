Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8AD49481E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018071; cv=none; b=WuKZjIlPC9937LAUY1rv86Pc3LifNo32MeSTViMwPJVNQIIrm4nmDziaGqwlxuwiq47rwk46aZp0aTKOn6uFF2UlTDRX5XZoZ22cVjqHo8YNf5LuWkcmeveyG8aE7r0RNIG7ydGHbDocrfH/dUvc2aDjjKp8JP74aXk+/mx+9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018071; c=relaxed/simple;
	bh=+hRP+q//ngzHrXBLTWDX2unvK295jCea1dzGyWxTASo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIGQSMvRhg3yiDBtUAF0Fy9X2HCkOMpVjnYEeUeAY0waPCPtzAhQUfiOuIMikCirhE3WB4qTUChZYkdJLkfQ6p3GpdoCynwAarycqmEWW1HF0VLxNjo1i5R/E1zgR7PB/o+U756U+WukIci0dFLfxAE6/fU8PfRq7cJBtBQ4gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZ9uxArJ; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ9uxArJ"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so683297a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018068; x=1790622868; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=We/XQ6s6KSgxA61rBAufhIwuk9J/sx0XOSn2ewH01aA=;
        b=SZ9uxArJTesY+RQDcpIVr+oXTop+MK/K0YSReGJ42W3WKevKnI6n+ZQdHBQ0h+fIjN
         myfMHuDpCYuvN/xnJNrXcZf7V6aiZM2IRx3ZMTh+nnVfm3wkO0mPmMMrYvfg58zudSb9
         DmpUAF3kC0mwaaSmGYWzE/fVQ0MKiAhp/nUgHh5YrxFukUhp8BegNSkJrLMWi3ANGL2l
         PuoczdAA3bWVuByvWCQDZfOIj19FOzTZCDfwfLZcG1RymEcbDRxR0gsDm7Pa4Y9K2KSA
         lay98l0t1cg6U1cbgKtzM9rieILGIE6nBmAJg2pCm0C0MkoR9uRwIpKsNjrEYhHNbFZL
         ottg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018068; x=1790622868;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=We/XQ6s6KSgxA61rBAufhIwuk9J/sx0XOSn2ewH01aA=;
        b=yCNmS3lJo/Q74CkOjzFhzsQ/2v8ajvvsopRCm5+TrlWXTibVCvkJLcVHLBJcUwa1iB
         7pCnitxuPM72BrdH1xsEUrj3fmdDxNZpcRa2Gz9AoO1L7DPss05UqaPekwxpSPK1C2MJ
         27eWtnVm9q9/4VSneuc+JsrjQ3BhQjjjjXw0Py1OYTAiRkhbvG+0BDlDBoVz5+iad1aH
         JcD+qSk62W5Bhgc+PPFDPBjmvWYKczMRZDaWnEpqM4cJzGKlwIJ4KCt62UjY64W8OwgF
         FK9q/PLSU9Lvo8tzLYxwsBBeBj1RXkd6amquZKWFBvCFRVRoK+u/gl7pq+GTIzUk48S2
         REew==
X-Forwarded-Encrypted: i=1; AKwUvBxYUAv+ppkJn2ZXOJ6jfABoSNlSWAP7UtJtsreeJNZWFi7/mx12aJeIaJMH8g8gJzsoyBcEEanwU1mw0XWzE02T@vger.kernel.org
X-Gm-Message-State: AFuF++n4YzhkLrwOTwXPfQBRypvqT6dvvHhzPIWbg0GKG9E+erVZiW5K
	w7mZ8IFE0d52qLSQs08EJjmPKjzVpPJpIfMcyVnfbpH1wcO+wrdPCbparNHNBMYWI3JnUf3cNyg
	V+OHVcQ==
X-Received: from pgbfl13.prod.google.com ([2002:a05:6a02:50cd:b0:cc4:ebc4:db3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d95:b0:3d0:7a2e:f827
 with SMTP id adf61e73a8af0-3dd8c44d03amr19044590637.16.1790018067340; Mon, 21
 Sep 2026 12:14:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:14 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-7-seanjc@google.com>
Subject: [PATCH v4 06/10] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
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
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c            |  5 +++--
 arch/x86/events/intel/core.c      | 16 ++++++++--------
 arch/x86/events/perf_event.h      |  3 ++-
 arch/x86/include/asm/kvm_host.h   |  9 ---------
 arch/x86/include/asm/perf_event.h | 12 ++++++++++--
 arch/x86/kvm/vmx/pmu_intel.c      | 17 ++++++++++++++---
 arch/x86/kvm/vmx/vmx.c            | 11 ++++++++---
 arch/x86/kvm/vmx/vmx.h            |  2 +-
 8 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ef9b8df2e1f7..9b1a9032e36d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -862,9 +862,10 @@ void x86_pmu_disable_all(void)
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
index 859aba923a6a..66cacfeb47d3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/nmi.h>
-#include <linux/kvm_host.h>
 
 #include <asm/cpufeature.h>
 #include <asm/cpuid/api.h>
@@ -5318,11 +5317,11 @@ static int intel_pmu_hw_config(struct perf_event *event)
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
 	u64 guest_pebs_mask;
@@ -5376,7 +5375,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 * the guest wants to use for PEBS, (c) are not excluded from counting
 	 * in the guest, and (d) _are_ excluded from counting in the host.
 	 */
-	guest_pebs_mask = pebs_mask & intel_ctrl & kvm_pmu->pebs_enable &
+	guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
 			  ~cpuc->intel_ctrl_exclude_guest_mask &
 			  cpuc->intel_ctrl_exclude_host_mask;
 
@@ -5386,7 +5385,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
 	 * wrong counter(s).
 	 */
-	guest_pebs_mask &= ~kvm_pmu->host_cross_mapped_mask;
+	guest_pebs_mask &= ~guest_pebs->cross_mapped_mask;
 
 	/*
 	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
@@ -5405,14 +5404,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	arr[(*nr)++] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_DS_AREA,
 		.host = (unsigned long)cpuc->ds,
-		.guest = guest_pebs_mask ? kvm_pmu->ds_area : (unsigned long)cpuc->ds,
+		.guest = guest_pebs_mask ? guest_pebs->ds_area : (unsigned long)cpuc->ds,
 	};
 
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		arr[(*nr)++] = (struct perf_guest_switch_msr){
 			.msr = MSR_PEBS_DATA_CFG,
 			.host = cpuc->active_pebs_data_cfg,
-			.guest = guest_pebs_mask ? kvm_pmu->pebs_data_cfg :
+			.guest = guest_pebs_mask ? guest_pebs->data_cfg :
 						   cpuc->active_pebs_data_cfg,
 		};
 	}
@@ -5428,7 +5427,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	return arr;
 }
 
-static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr, void *data)
+static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr,
+							 struct x86_guest_pebs *guest_pebs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 87733dd52846..68ece64ff8cd 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1230,7 +1230,8 @@ struct x86_pmu {
 	/*
 	 * Intel host/guest support (KVM)
 	 */
-	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr, void *data);
+	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr,
+							struct x86_guest_pebs *guest_pebs);
 
 	/*
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 57d37491c7c0..20b9db3f5203 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -608,15 +608,6 @@ struct kvm_pmu {
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
index 12f7db8c57b4..27f9c5bee7b0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -819,11 +819,19 @@ extern void perf_load_guest_lvtpc(u32 guest_lvtpc);
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
index bfa8612fb450..a21e146ad4f2 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -747,11 +747,21 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
 		intel_pmu_release_guest_lbr_event(vcpu);
 }
 
-void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
+u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu)
 {
-	struct kvm_pmc *pmc = NULL;
+	u64 host_cross_mapped_mask;
+	struct kvm_pmc *pmc;
 	int bit, hw_idx;
 
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
@@ -763,8 +773,9 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
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
index 612ab07d4100..b097db296792 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7363,12 +7363,17 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 	if (kvm_vcpu_has_mediated_pmu(&vmx->vcpu))
 		return;
 
-	pmu->host_cross_mapped_mask = 0;
+	struct x86_guest_pebs guest_pebs = {
+		.enable = pmu->pebs_enable,
+		.ds_area = pmu->ds_area,
+		.data_cfg = pmu->pebs_data_cfg,
+	};
+
 	if (pmu->pebs_enable & pmu->global_ctrl)
-		intel_pmu_cross_mapped_check(pmu);
+		guest_pebs.cross_mapped_mask = intel_pmu_get_cross_mapped_mask(pmu);
 
 	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
-	msrs = perf_guest_get_msrs(&nr_msrs, (void *)pmu);
+	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);
 	if (!msrs)
 		return;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..5c4e2cf6256c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -664,7 +664,7 @@ static __always_inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
 	return container_of(vcpu, struct vcpu_vmx, vcpu);
 }
 
-void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu);
+u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu);
 int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
 void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

