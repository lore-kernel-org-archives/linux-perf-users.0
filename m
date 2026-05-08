Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2253BA251
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282045; cv=none; b=DixNtjyaC+9Ccaoai3xQDq+M0IkCIEzSGszIWJund8aWpY7uJlgcg9ZLtdo8mwa8iq4v+ImLZuusqT0PA0T74uxVCyq8LXlSz3xEs4I3clvg1HRwDOlWkq1unWiu10LIG//xbbpg+MIEbbbl8PngGLS5Im3ZRcP1Ho0g055c6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282045; c=relaxed/simple;
	bh=awV2Von+T5AhuhIFGgH37MajHZCuQxUpjUlB3MTEo/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hdRBx9EA73JgjNuB7KpLoVjGc2DMo2zR2J3qbdX7/5/PYSWTQd40+WJrl8erqTzYLhUWQuFYVosIkUduJw7EYJdQEu+swrsoYXb7dw4EFSvuHat0m24+B7aSyRB5JhcOtEkfTf0CfZ6W8+9x83HBczsyV13wtFamH/M7NivDo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD8MOjk3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD8MOjk3"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so1437286a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282042; x=1778886842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WiBynQaBCrCTrVvB2B5pzVamCqZLon4JBoEx1jyUfTY=;
        b=fD8MOjk3FqfBwbMLz14p9JrE+KJQQrNPf2rXTQh/jQ5VYvBeKIuYU9ixOXgElSAn5t
         FJVs5vs90KQLSZUEVk5+mp57W9RnNkVfTSTll3B6AHKcinprszLYz3tWgBZtn2kCbYI0
         exr1iC8mar+WbRKQzMKxD4lGjJWuAk6mZneUupes6UMQNVGa+hzXsl48yX3ZRuLcA1uk
         uWGGAY324S3O3dyfD9cvuCgt0t/xU43XLuXXT8Pq/IHliqmvedetJ2YFBxqk1Szw5HmA
         enuS/6Swye75GNGEerAKOnCcK3/5KPhtL53xvFG0f24SYU1OErrnzHxbXmHFeqUaTQyX
         OJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282042; x=1778886842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiBynQaBCrCTrVvB2B5pzVamCqZLon4JBoEx1jyUfTY=;
        b=h6XDG0vkZpSZRh3h0z/cMbOvmatgl4mz1kAybtKy5/BWkEy+zYFtrY6416aV/lG9UZ
         Cs4PzUC2YTCREpuI4V2LfgTbQ5nutL96ajOCDDlHMd9HcMxFaE0xrnVJSRWBgARIXoVf
         GFErQKfLZCYTjdprBm09XNWgz+CX70yClAKhFZM9dIB08ORyi9nrCw8fHxjJsz2I+GSc
         LAEOlzIfACEZRGMIUD8q71j6JDJjYdIstDYYmXPem20JrLTjCklnyTaxsWnBRaFD8Q3n
         UPFHzPDoaQCGbx98n+c+W2i80/C1z0t6BjnBp8Jsbx4KfA2EKY6phOfO4N+rx7FbWJcJ
         Pzbw==
X-Forwarded-Encrypted: i=1; AFNElJ8xKLJi9QvsJ6JUzwFjSNlY+sW2kCJxfn72WdkUkKm3BKBj9inJQa6+TEfHlvxhGWmqco4hOvG7Cqd/+7sRSaSi@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxGHWYUcNJs21Oj5vjXBs+t6psKtJGX3oldz3IZPcfHdv4L3o
	sXKpcZwjvN/8lPrmaW4on1VVP0ZmU6GIMOD56OG85zMNcpXHWxq1I8BYuHl41eEa51ySzU+gs1v
	3GmtGeQ==
X-Received: from pgbcr5.prod.google.com ([2002:a05:6a02:4105:b0:c79:67c5:c6b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9186:b0:3a2:cbd1:11e
 with SMTP id adf61e73a8af0-3aa8c098d8emr8683210637.14.1778282042086; Fri, 08
 May 2026 16:14:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:50 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-7-seanjc@google.com>
Subject: [PATCH v3 6/9] perf/x86: KVM: Have perf define a dedicated struct for
 getting guest PEBS data
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
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
index 7f7c7927b70b..e9acfc3f3a82 100644
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
 	u64 guest_pebs_mask;
@@ -5050,7 +5049,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 * the guest wants to use for PEBS, (c) are not excluded from counting
 	 * in the guest, and (d) _are_ excluded from counting in the host.
 	 */
-	guest_pebs_mask = pebs_mask & intel_ctrl & kvm_pmu->pebs_enable &
+	guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
 			  ~cpuc->intel_ctrl_exclude_guest_mask &
 			  cpuc->intel_ctrl_exclude_host_mask;
 
@@ -5060,7 +5059,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
 	 * wrong counter(s).
 	 */
-	guest_pebs_mask &= ~kvm_pmu->host_cross_mapped_mask;
+	guest_pebs_mask &= ~guest_pebs->cross_mapped_mask;
 
 	/*
 	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
@@ -5079,14 +5078,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
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
@@ -5102,7 +5101,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	return arr;
 }
 
-static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr, void *data)
+static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr,
+							 struct x86_guest_pebs *guest_pebs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cc0aeeb34eb5..9183b3607962 100644
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
index 752cb319d5ea..bc7e48f6f4a8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -786,11 +786,19 @@ extern void perf_load_guest_lvtpc(u32 guest_lvtpc);
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
index 27eb76e6b6a0..e65adb3dc066 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -736,11 +736,21 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
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
@@ -752,8 +762,9 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
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
index a29896a9ef14..9f0a028cf10b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7313,12 +7313,17 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
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
2.54.0.563.g4f69b47b94-goog

