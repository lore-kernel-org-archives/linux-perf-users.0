Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479810;
	b=EXnIkE9spCPONrJ3AQ/F23LPoa8FpbbjhwYs5vrACdRvAfK9bO96DievzxElBTDiAVkF
	 JR6bDMabu67z+ygqCAogaUieurZ/LwmIe3hmULrrquf8Z47inUyeQ4Mwf1fYzxhXunCHm
	 PrZnFPd+PnctQyJw/46BjdvzrGSD4TsLtvCrE+TuCi0z00gzr7QoEHJ6wBlCoRZpJuuli
	 56MiQzTeGbWVHYHpkbZ+bMdrO6VCVqGQctovKgeMYghyRn8fbtrGWsPApScmLZY1VIFCU
	 x2PHyUjRN588Po1Dzgnnpn2UUfb0StsimGjIgAuRosOxvl78HrtDoTNqDvqtatyWuyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=goU0kxCL9fqVkYoq/6qrg/icuvM4CQTsUUtFCDZSucY=;
	b=ailxRkbawsbxOhwRfbMSpY1U3NmuE2WsOXKlkcGONnx0jHXA1goTejscwoAe0khHZ7PQ
	 dYV/CGMoWvFxYVx30XHbqE3xaGCRRm3iJYE/72HMwdg5fPh5JoVQZ/SE5AhVo9pWOZkxO
	 FIwt9ClbqQpRULCtDefCzmjrlnzR6v2P9e30TPvmcEL2YHZpcb5XshmCjZ0UfT3di/MIf
	 FJg+I0Zav/FzJd1hA99w0ejxcRo+CcDQ0kTSe/g4LYVutnfL+lKP0mXdcVGcBQcTvxe1S
	 REcZkI4PihnKvVemCLiq4dzkiZoQW1MB18F+f0CniCqB509LOiU7qNWf29Rm/xS2SaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dY+nDIu3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835360A3806;
	Tue, 24 Nov 2026 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dY+nDIu3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2A81F02ED2;
	Tue, 24 Nov 2026 00:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479809;
	bh=goU0kxCL9fqVkYoq/6qrg/icuvM4CQTsUUtFCDZSucY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dY+nDIu3ijZltqoTMkEHTrIswhVYgcmK80Cn5NcNDZLhw+tZWLU68MzY+zA+D0MA/
	 S7Bgu6mb95XjmmsALuLcp+7MVaRyBrTybePPG1HAQlcD/sriMndRCeSYohB+70H97P
	 GclAK84z74DolwKfrKPWnxk6XlMBGbuIDuYd/OdBVkTY0HsOR1OG5U/bpHls+nAoy0
	 vljLWBAG9Fr2KUTTJDO5jymZmcSquqRmkoipnK9qb3B7Gu5Gkx1JOJ83q64h8+NeDV
	 YeRyvzfpO/nFtb8Rc2c1ZHDIquW9Xs9wLy8YdSsOlyEYV/TMX5IY4+AeOA8R033D6E
	 Ia+WFdjKsA4CA==
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
Subject: [RFC PATCH 15/26] KVM: x86/pmu: Write PMU controls to hardware on reprogram if loaded
Date: Tue, 24 Nov 2026 00:22:52 +0000
Message-ID: <20261124002303.1785363-16-yosry@kernel.org>
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
during slowpath VM-Exit handling, write eventsel_hw and
fixed_ctr_ctrl_hw to hardware when reprogramming counters if the guest
context is loaded.

Only update eventsel_hw and fixed_ctr_ctrl_hw when reprogramming
counters, instead of also updating them when the guest writes the MSRs,
to keep them in sync with hardware and keep the hardware writes in one
place. Otherwise, if e.g. eventsel_hw is zeroed on an MSR write and the
guest context is put before reprogramming, putting the context would
skip clearing the event selector in hardware.

As fixed_ctr_ctrl_hw is no longer overwritten with the guest's value on
MSR writes, compare against the guest's previous fixed_ctr_ctrl in
reprogram_fixed_counters() again, effectively reverting commit
9c6e2463c9f3 ("KVM: x86/pmu: Use hardware value when reprogramming for
FIXED_CTR_CTRL changes").  Comparing against fixed_ctr_ctrl_hw was only
needed because the overwrite could leave counters that are disallowed by
the event filter enabled in fixed_ctr_ctrl_hw without reprogramming
them.

Disable IRQs across updating the software fields and writing hardware,
so that the two are atomic with respect to perf reclaiming the mediated
PMU (via IPI) and putting the guest context. Document which guest PMU
registers are read from software and written through to hardware while
the guest context is loaded.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c           |  7 +++++++
 arch/x86/kvm/pmu.h           | 15 ++++++++++++---
 arch/x86/kvm/svm/pmu.c       |  1 -
 arch/x86/kvm/vmx/pmu_intel.c | 12 +-----------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 44d947b854b9c..ffee8a4741ee1 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -575,6 +575,8 @@ static void kvm_mediated_pmu_reprogram_counter(struct kvm_pmc *pmc)
 	bool allowed = pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc);
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
+	guard(irqsave)();
+
 	if (pmc_is_gp(pmc)) {
 		/*
 		 * Leave eventsel_hw zero for counters that can't count, so that
@@ -584,12 +586,17 @@ static void kvm_mediated_pmu_reprogram_counter(struct kvm_pmc *pmc)
 		if (allowed)
 			pmc->eventsel_hw = (pmc->eventsel | kvm_pmu_ops.EVENTSEL_HW_SET) &
 					   ~kvm_pmu_ops.EVENTSEL_HW_CLR;
+
+		kvm_pmu_guest_context_wrmsr(gp_eventsel_msr(pmc->idx), pmc->eventsel_hw);
 	} else {
 		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
 
 		pmu->fixed_ctr_ctrl_hw &= ~mask;
 		if (allowed)
 			pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
+
+		kvm_pmu_guest_context_wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL,
+					    pmu->fixed_ctr_ctrl_hw);
 	}
 }
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 462df3a9de491..89d35a39b524b 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -169,9 +169,18 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 
 /*
  * While the guest's mediated PMU context is loaded, the guest's PMU state
- * lives in hardware.  State that changes while the guest runs and is only
- * saved when the guest context is put (counters) must be read from
- * hardware, and written to both hardware and the software copy.
+ * lives in hardware.  Guest PMU registers fall into two categories:
+ *
+ *  - State that changes while the guest runs and is only saved when the
+ *    guest context is put (counters) must be read from hardware, and
+ *    written to both hardware and the software copy.
+ *
+ *  - Controls whose software copy is always up to date (event selectors
+ *    and FIXED_CTR_CTRL) can be read from the software copy, but writes
+ *    must be propagated to hardware.  Guest writes to event selectors and
+ *    FIXED_CTR_CTRL are always intercepted.  Note, the value written to
+ *    hardware may differ from the guest-visible value, e.g. eventsel_hw
+ *    vs. eventsel.
  *
  * Write a guest PMU MSR, but only if the guest context is loaded on this
  * CPU.  Callers must keep IRQs disabled across updating KVM's software copy
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 232c4779e5a32..1b5ed347bf1df 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -166,7 +166,6 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = data;
 
 			if (data & AMD64_EVENTSEL_HOST_GUEST_MASK)
 				__set_bit(pmc->idx, pmu->pmc_has_mode_specific_enables);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index fb7ad53855f1d..69e8cc1b6732f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -57,20 +57,11 @@ static struct x86_pmu_lbr *vcpu_to_lbr_records(struct kvm_vcpu *vcpu)
 
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
-	/*
-	 * Compare against the value the mediated PMU shoves into hardware, not
-	 * the guest's desired value.  For the emulated PMU (proxied via perf),
-	 * they are one and the same (fixed_ctr_ctrl_hw isn't used other than
-	 * here).  For the mediated PMU, KVM needs to reprogram the actual MSR,
-	 * and so needs to react to potential changes in the value shoved into
-	 * hardware, e.g. to ensure the event filter is enforced.
-	 */
-	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw;
 	struct kvm_pmc *pmc;
+	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl;
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;
-	pmu->fixed_ctr_ctrl_hw = data;
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		u8 new_ctrl = fixed_ctrl_field(data, i);
 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
@@ -445,7 +436,6 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
-				pmc->eventsel_hw = data;
 				kvm_pmu_request_counter_reprogram(pmc);
 			}
 			break;
-- 
2.56.1.809.ga0b61035b5-goog

