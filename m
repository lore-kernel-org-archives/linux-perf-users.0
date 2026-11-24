Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479815;
	b=DH9OGgPm969sh3tCUT7p+LXFOMPHtD5gui1MJPkm/mQqatz5sXu6M5/hjNb1an3EjAdo
	 PYptd+pa9qCDaCziOhx5ClR8Ubbit2/VqL367RDk/KsrwGovK7W5hP0sI4ygE6xnDs7IW
	 7JtKprcIRrmB+NtlGuN+B51wpoQJmN2SNLSoWsLT1c+hqaluejPV/DxENW3JSf5SUiseg
	 wLnQkMFkmJFVEZaSo3IJUxa0e0nE0BH6bM2Ms9fLb49pRMnwG0EmbiEiB4YmhU7KxNRbT
	 zYg3w8YyrHDpzvCoYTnIl4gvNQ7eO2cMPBUUpKp3bV9o40RzX1QUY1vnXssqltemLxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479815;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UH4Tg5v3mspcVUOVCe0FFtKeJ6vP+q48vDuVbY5Tet8=;
	b=UC3PTpbXZ3s6rBOmoiHunspPuX2k5zlIse85p8Rlhqm5SAZJP8x2flfOBwpX20NPlHNx
	 Q6mQXhYo7HGj/mU3pGnLHkvEdqvlnKMt4CzR+0Yfxgn9KfoEHKfjnEaXoG3QkXp6fPPqk
	 uU5JBrUHCjU5qSO8HZnaXxYYSTI3QqcjS0V3OKyHzGdx8ZhrPP/XbC/ZgmYdssiW7u4xj
	 v0l3ppSiFqNTZUS86cPKxoa+nZTxTxXtJJb76xTRgjRLS3Y/jOgJjAT+61sbDEVSTr76n
	 9OvQS5KOYVYf5FOqsAN3kp0HnivAvQ8LQSlZ0Hv5GXoDhaqe0xbDG59x6TDom5kcmkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QuCFAMgC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D1606A6A4;
	Tue, 24 Nov 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QuCFAMgC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CD21F000EB;
	Tue, 24 Nov 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479814;
	bh=UH4Tg5v3mspcVUOVCe0FFtKeJ6vP+q48vDuVbY5Tet8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QuCFAMgCfko+wm93fhr0BQAsDBfGs5DcezE6RbCkMfjOaJXRNcVY4MyI54o7DYXtI
	 /1rNI4H0/wVrea+2LubrwWfygyYbodNhX/jELDDlFG7I7L9Kk9JOvhruxX0suwrmwX
	 Fjv6GUl6McgbKXWlKqt/8yc0LhaWWEsWPx+aiSCetsdM/Yp5d+1jWzyFhYGxvNQeCq
	 ndUYfCXbsWYyI99hp6Kch052XXDmvTt3oeWglazhl6rgMmpVIqwjCAurBkJJDv2FYF
	 tmgQXCcgjM9YRdhjHJakvv41+5m3IzE+HV3kTmVsqq+EjBOn3rgv3U96uvtLhmgRqi
	 wxep3GBbuW76w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 18/26] KVM: x86/pmu: Access GLOBAL_STATUS in hardware if the guest context is loaded
Date: Tue, 24 Nov 2026 00:22:55 +0000
Message-ID: <20261124002303.1785363-19-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for leaving the guest's mediated PMU context loaded
during slowpath VM-Exit handling, read and write the guest's
GLOBAL_STATUS in hardware if the guest context is loaded.  Hardware sets
overflow bits in GLOBAL_STATUS while the guest runs, and KVM's software
copy is only synced from hardware when the guest context is put.

Add helpers to read GLOBAL_STATUS, refreshing the software copy, and to
clear and set bits via GLOBAL_STATUS_CLR and GLOBAL_STATUS_SET
(GLOBAL_OVF_CTRL and GLOBAL_STATUS_SET on Intel), updating both the
software copy and hardware. Use the helpers when signaling overflow of
counters incremented for emulated instructions too, and disable IRQs
across the whole increment to avoid toggling IRQs in each helper. Add
the MSR indices to kvm_pmu_ops for use in common code.

As with counters, disable IRQs so that checking whether the guest
context is loaded and accessing hardware are atomic with respect to perf
reclaiming the mediated PMU (via IPI) and putting the guest context.

Document GLOBAL_STATUS as state that's read from hardware while the
guest context is loaded.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c           | 43 ++++++++++++++++++++++++++++++------
 arch/x86/kvm/pmu.h           |  7 ++++--
 arch/x86/kvm/svm/pmu.c       |  3 +++
 arch/x86/kvm/vmx/pmu_intel.c |  3 +++
 4 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 81278a64be43f..11d12093d3a6a 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -187,6 +187,32 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 		perf_get_hw_event_config(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 }
 
+/*
+ * GLOBAL_STATUS is updated by hardware (counter overflow) while the guest's
+ * mediated PMU context is loaded, so hardware is authoritative while loaded.
+ */
+static u64 kvm_pmu_read_global_status(struct kvm_pmu *pmu)
+{
+	guard(irqsave)();
+	if (is_guest_mediated_pmu_loaded())
+		rdmsrq(kvm_pmu_ops.PERF_GLOBAL_STATUS, pmu->global_status);
+	return pmu->global_status;
+}
+
+static void kvm_pmu_clear_global_status(struct kvm_pmu *pmu, u64 bits)
+{
+	guard(irqsave)();
+	pmu->global_status &= ~bits;
+	kvm_pmu_guest_context_wrmsr(kvm_pmu_ops.PERF_GLOBAL_STATUS_CLR, bits);
+}
+
+static void kvm_pmu_set_global_status(struct kvm_pmu *pmu, u64 bits)
+{
+	guard(irqsave)();
+	pmu->global_status |= bits;
+	kvm_pmu_guest_context_wrmsr(kvm_pmu_ops.PERF_GLOBAL_STATUS_SET, bits);
+}
+
 void kvm_handle_guest_mediated_pmi(void)
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
@@ -891,7 +917,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
-		msr_info->data = pmu->global_status;
+		msr_info->data = kvm_pmu_read_global_status(pmu);
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_CORE_PERF_GLOBAL_CTRL:
@@ -962,11 +988,11 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		fallthrough;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		if (!msr_info->host_initiated)
-			pmu->global_status &= ~(data & ~pmu->global_status_rsvd);
+			kvm_pmu_clear_global_status(pmu, data & ~pmu->global_status_rsvd);
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!msr_info->host_initiated)
-			pmu->global_status |= data & ~pmu->global_status_rsvd;
+			kvm_pmu_set_global_status(pmu, data & ~pmu->global_status_rsvd);
 		break;
 	default:
 		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
@@ -1124,14 +1150,17 @@ static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 	}
 
 	/*
-	 * For mediated PMUs, the counter may be live in hardware or in
-	 * pmc->counter; the helpers will access it as needed. Signal overflow
-	 * if the counter wraps to zero after the increment.
+	 * For mediated PMUs, the counter and GLOBAL_STATUS may be live in
+	 * hardware or in software fields; the helpers will update them as
+	 * needed. Disable IRQs throughout to avoid toggling IRQs in every
+	 * helper. Signal overflow if the counter wraps to zero after the
+	 * increment.
 	 */
+	guard(irqsave)();
 	counter = (pmc_read_counter(pmc) + 1) & pmc_bitmask(pmc);
 	pmc_write_counter(pmc, counter);
 	if (!counter) {
-		pmc_to_pmu(pmc)->global_status |= BIT_ULL(pmc->idx);
+		kvm_pmu_set_global_status(pmc_to_pmu(pmc), BIT_ULL(pmc->idx));
 		if (pmc_is_pmi_enabled(pmc))
 			kvm_make_request(KVM_REQ_PMI, vcpu);
 	}
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a83560ac51e00..6a340a66e9246 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -50,6 +50,9 @@ struct kvm_pmu_ops {
 	const int MIN_NR_GP_COUNTERS;
 
 	const u32 PERF_GLOBAL_CTRL;
+	const u32 PERF_GLOBAL_STATUS;
+	const u32 PERF_GLOBAL_STATUS_CLR;
+	const u32 PERF_GLOBAL_STATUS_SET;
 	const u32 GP_EVENTSEL_BASE;
 	const u32 GP_COUNTER_BASE;
 	const u32 FIXED_COUNTER_BASE;
@@ -172,8 +175,8 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
  * lives in hardware.  Guest PMU registers fall into two categories:
  *
  *  - State that changes while the guest runs and is only saved when the
- *    guest context is put (counters) must be read from hardware, and
- *    written to both hardware and the software copy.
+ *    guest context is put (counters and GLOBAL_STATUS) must be read from
+ *    hardware, and written to both hardware and the software copy.
  *
  *  - Controls whose software copy is always up to date (event selectors,
  *    FIXED_CTR_CTRL and GLOBAL_CTRL) can be read from the software copy,
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 9c7d248f4ee10..e81e83c3d43b9 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -327,6 +327,9 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
 
 	.PERF_GLOBAL_CTRL = MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+	.PERF_GLOBAL_STATUS = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+	.PERF_GLOBAL_STATUS_CLR = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	.PERF_GLOBAL_STATUS_SET = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 	.GP_EVENTSEL_BASE = MSR_F15H_PERF_CTL0,
 	.GP_COUNTER_BASE = MSR_F15H_PERF_CTR0,
 	.FIXED_COUNTER_BASE = 0,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 69e8cc1b6732f..4d1370e0f97e7 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -858,6 +858,9 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.MIN_NR_GP_COUNTERS = 1,
 
 	.PERF_GLOBAL_CTRL = MSR_CORE_PERF_GLOBAL_CTRL,
+	.PERF_GLOBAL_STATUS = MSR_CORE_PERF_GLOBAL_STATUS,
+	.PERF_GLOBAL_STATUS_CLR = MSR_CORE_PERF_GLOBAL_OVF_CTRL,
+	.PERF_GLOBAL_STATUS_SET = MSR_CORE_PERF_GLOBAL_STATUS_SET,
 	.GP_EVENTSEL_BASE = MSR_P6_EVNTSEL0,
 	.GP_COUNTER_BASE = MSR_IA32_PMC0,
 	.FIXED_COUNTER_BASE = MSR_CORE_PERF_FIXED_CTR0,
-- 
2.56.1.809.ga0b61035b5-goog

