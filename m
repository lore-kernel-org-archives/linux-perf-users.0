Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479806;
	b=dlYdPimhqEQ4/w7u3gyEyrvuhPMX5Ys97hbAJfIoAQ1RtlTrsdnTR9QBNyjnYzTgLKvB
	 bQpx25hlsJrPDwKllM3OGWWL6otFeE73ntV8KOPze5AUaBAgsBSknZFS5qW3xMuV8Inwb
	 g1lDIpXBHY7e1mPdrqke/VJHlOFwD7zQVspErN/INHzLfEwCjFDWtQrVW7E8WSfKjsOuz
	 FbBOK8z0hYJm6whJG+4xGWcNPpZRrMooAWZjQDac4U7Hidspz2iCmskOp9poYpTTnM3JV
	 WR65u22nobOfWSa8CSCKFAHm3KuJFZQ1QbSLFyuXVIldIhi+2OqfS1n6y1B2f+Em+Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LrQSSv4UaljibsoNuEGR6quCOuk0TOdoW5f/RFygqrs=;
	b=h/s40bg3kBevSAJF5YoSiP3clmXMlIgTK2qy18ig6avGEGf8h6ioWTivUZsuao9vkRMR
	 NSlwERFNeP53nIiQoMc7OQ6ODZ/K4tvS8/ynfmkgIQop6B8+m07bdfoOza/96FeN4qb0l
	 XY6A9jbgztkJiuShsvawZCYpxgw4N8kcNCyLY0Stw+3SK2Q5B2C9QxeO9AIsnvWEurFuB
	 W1VjQvWDgqXHxJFjJLvgQfK4mt/w7LXCWNUZq5bE47IWequBZ94kPRC7ekXfvkiL/5tWt
	 AkWk4X6IoSaEOGjntx3vXFOxEV5XpR47sCidiMsbX10zdetzKy4nME36D/MWGATtrWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a1//mvyQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4028A606A688;
	Tue, 24 Nov 2026 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1//mvyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011A41F01577;
	Tue, 24 Nov 2026 00:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479805;
	bh=LrQSSv4UaljibsoNuEGR6quCOuk0TOdoW5f/RFygqrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a1//mvyQhA2n0YIHCQQhup52+H5eekJiOsMc0VWOSNb/pCbaECUPV6+DGQuB1VavG
	 wkh+UmjgdDFo7qwb07EDVMWlOovlnssqpDItI7h0tELnoGwvDBiJefRY3gP0BKfb6Y
	 5/RClCUoXXwEgWCDmnCNQjfKnpU5hPagE/nuWEO3GvEsd0W9PkSorjtYFwp7OMpKOT
	 hMozJXPCyMzw03nReVoGD5N7wsXh66qiK1hFI4Utiz68yovJ/O43aaPk5h5VIciRdz
	 y0wBQk7VYqQKvvkBn2YQ9HdUY+4o/HrnyF49ZggbvOlj/uAu3OwSeYnhpAy4yRoYzS
	 7TEsleTIbBMNA==
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
Subject: [RFC PATCH 12/26] KVM: x86/pmu: Access PMCs in hardware if the mediated PMU context is loaded
Date: Tue, 24 Nov 2026 00:22:49 +0000
Message-ID: <20261124002303.1785363-13-yosry@kernel.org>
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
during slowpath VM-Exit handling, read and write the guest's counters in
hardware if the guest context is loaded.  While the guest context is
loaded, the guest's counter values live in hardware, and KVM's software
copies in pmc->counter may be stale, as they are only synced from
hardware when the context is put.

Read counters with RDPMC, refreshing the software copy, and write them
through to hardware in addition to updating the software copy.  Use the
accessors when incrementing counters for emulated instructions too,
instead of updating pmc->counter directly.  Updating the software copy
while the guest context is loaded isn't strictly necessary, as it's
synced from hardware when the context is put.  This could be optimized
by tracking whether the software copy is up-to-date.

Add kvm_pmu_guest_context_wrmsr() to write a guest PMU MSR only if the
guest context is loaded, as it will be reused for other guest PMU
registers, and document there which guest PMU state lives in hardware
while the guest context is loaded.

Disable IRQs across checking whether the guest context is loaded and
accessing the counter, as perf may reclaim the PMU via IPI and put the
guest context.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 21 ++++++++++++++++-----
 arch/x86/kvm/pmu.h | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4d170abb2b384..6f82213058f14 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -419,10 +419,19 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
 	return kvm_pmu_ops.GP_EVENTSEL_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
 }
 
+static u32 pmc_counter_msr(struct kvm_pmc *pmc)
+{
+	return pmc_is_fixed(pmc) ?
+	       fixed_counter_msr(pmc->idx - KVM_FIXED_PMC_BASE_IDX) :
+	       gp_counter_msr(pmc->idx);
+}
+
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 {
 	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu)) {
+		guard(irqsave)();
 		pmc->counter = val & pmc_bitmask(pmc);
+		kvm_pmu_guest_context_wrmsr(pmc_counter_msr(pmc), pmc->counter);
 		return;
 	}
 
@@ -1082,6 +1091,7 @@ static bool pmc_is_pmi_enabled(struct kvm_pmc *pmc)
 static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 {
 	struct kvm_vcpu *vcpu = pmc->vcpu;
+	u64 counter;
 
 	/*
 	 * For perf-based PMUs, accumulate software-emulated events separately
@@ -1096,12 +1106,13 @@ static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 	}
 
 	/*
-	 * For mediated PMUs, pmc->counter is updated when the vCPU's PMU is
-	 * put, and will be loaded into hardware when the PMU is loaded. Simply
-	 * increment the counter and signal overflow if it wraps to zero.
+	 * For mediated PMUs, the counter may be live in hardware or in
+	 * pmc->counter; the helpers will access it as needed. Signal overflow
+	 * if the counter wraps to zero after the increment.
 	 */
-	pmc->counter = (pmc->counter + 1) & pmc_bitmask(pmc);
-	if (!pmc->counter) {
+	counter = (pmc_read_counter(pmc) + 1) & pmc_bitmask(pmc);
+	pmc_write_counter(pmc, counter);
+	if (!counter) {
 		pmc_to_pmu(pmc)->global_status |= BIT_ULL(pmc->idx);
 		if (pmc_is_pmi_enabled(pmc))
 			kvm_make_request(KVM_REQ_PMI, vcpu);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ff4b6f15b915c..fe1baa50ebceb 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -137,12 +137,24 @@ static inline bool pmc_is_fixed(struct kvm_pmc *pmc)
 	return pmc->type == KVM_PMC_FIXED;
 }
 
+static inline u64 pmc_rdpmc(struct kvm_pmc *pmc)
+{
+	if (pmc_is_fixed(pmc))
+		return rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | (pmc->idx - KVM_FIXED_PMC_BASE_IDX));
+
+	return rdpmc(pmc->idx);
+}
+
 static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 {
 	u64 counter, enabled, running;
 
-	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu))
+	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu)) {
+		guard(irqsave)();
+		if (is_guest_mediated_pmu_loaded())
+			pmc->counter = pmc_rdpmc(pmc);
 		return pmc->counter & pmc_bitmask(pmc);
+	}
 
 	counter = pmc->counter + pmc->emulated_counter;
 
@@ -153,6 +165,24 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 	return counter & pmc_bitmask(pmc);
 }
 
+/*
+ * While the guest's mediated PMU context is loaded, the guest's PMU state
+ * lives in hardware.  State that changes while the guest runs and is only
+ * saved when the guest context is put (counters) must be read from
+ * hardware, and written to both hardware and the software copy.
+ *
+ * Write a guest PMU MSR, but only if the guest context is loaded on this
+ * CPU.  Callers must keep IRQs disabled across updating KVM's software copy
+ * and calling this, so that the two are atomic with respect to perf
+ * reclaiming the mediated PMU (via IPI) and putting the guest context.
+ */
+static inline void kvm_pmu_guest_context_wrmsr(u32 msr, u64 val)
+{
+	lockdep_assert_irqs_disabled();
+	if (is_guest_mediated_pmu_loaded())
+		wrmsrq(msr, val);
+}
+
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val);
 
 static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
-- 
2.56.1.809.ga0b61035b5-goog

