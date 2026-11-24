Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479811;
	b=eyDFfgitM5SWmoIzjJe5zi8e9Av5St/QVr0vUtVNAe3q/UcQ5iaN18WpeQQ42La4aupB
	 UlFKTkGdF50EvAc4U6Ve+774gCx/G4fqf6O7aevT24EqRO5WRPyLkAOsaOQyG4m3pcCxf
	 GI3f9iLLD8OGlNIKoZ1Z4zK010N0gG86lYAa49MHJkhQodit723ChOUMnAEPi5MkUxdG3
	 WCavWI3rSnK/vQzO7kRmCNMaFphGMLDTnnYmbOMZrWdyiM9BR07kcUKU6oG1PHn24uR0E
	 glACKmZSZiNpC02iA3aOZFhQGHuR5fST9p66J+GjRj263bSsgZkmiHvEYDOGED4jdYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F+4s8J9yOZzJoecMyFoMiRmMZAjm9Tj+d8QGgFbVS5E=;
	b=s4I4A4Bp44h3uak0XkLHzdO1U141QPcacslAXDlz6Hl8ifo+XdGTt/SWlqQ8yzgfC2JT
	 iVBQzBJ7JNt6TUNag7Tx+4edEyxwvOLgeyV5fXwElTmN9SDg5Uh61OxFb3l70OtiGDwbz
	 QRpzkAe+F/x9VhmGaap6yHFIXMkDeqdY5IfUPYw0hysjju+LtzoaQjZ3EGVr3yud6YJ3X
	 u6BqzPPmO7D2kJtvHK/ENBeopDR+btUA8F5zjoqyngmDomIFd09zD3ky4dHMNrAAcHl2E
	 BD05egiZlxavzx1JDxC22ABeu0cAxvbXrlz35a8CC9HsydrrbO/HrcMLlXLzmjpQ3Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxLsuMyR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401A60A6F4F;
	Tue, 24 Nov 2026 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxLsuMyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27511F000F2;
	Tue, 24 Nov 2026 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479811;
	bh=F+4s8J9yOZzJoecMyFoMiRmMZAjm9Tj+d8QGgFbVS5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxLsuMyRb8xnCnMV2TUUCw1XMCfD4S1B//qtVjS5nZQ7/Qk+dV9W1JqBkSIKPktM8
	 1XRoAk9NeOFQRlDZzjR8UFxaF/b3ArD+jZnbFxUH8C/1uSRaQJGv26O8CrQYGRmtpi
	 criD6f3AvVk5NwoWxgrdyTxaKYkpYyofZxlFsrjnheiwyS4UX8RD8HtjRHgXjO9Y+2
	 YjiRexLdZpx8LQ0FTAdZGY7Cj7TeFPQKXLqaQjJlvEh46aNmJvcpV0BGxVIMBlE1tB
	 SQdqY2K3/Pes4FjGbZi+1J3fTYQVxpKB+cQBmrvQvUTA8Zd0qTedzpwwkT3jDLIJXJ
	 +pJogPGwP5BFw==
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
Subject: [RFC PATCH 16/26] KVM: x86/pmu: Write GLOBAL_CTRL to hardware if the guest context is loaded
Date: Tue, 24 Nov 2026 00:22:53 +0000
Message-ID: <20261124002303.1785363-17-yosry@kernel.org>
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
during slowpath VM-Exit handling, write the guest's GLOBAL_CTRL to
hardware on AMD if the guest context is loaded.  On Intel, the guest's
GLOBAL_CTRL lives in the VMCS and is loaded by hardware on VM-Enter, so
intel_pmu_write_global_ctrl() already writes it to the right place.

Add kvm_pmu_set_global_ctrl() to update the software copy and forward
the value to vendor code, and implement write_global_ctrl() for AMD
using kvm_pmu_guest_context_wrmsr().  Disable IRQs across the update, so
that checking whether the guest context is loaded and writing the MSR
are atomic with respect to perf reclaiming the mediated PMU (via IPI)
and putting the guest context.

Disabling IRQs isn't needed on Intel, as the VMCS isn't affected by perf
reclaiming the PMU, but special casing Intel isn't worth the trouble.
Alternatively, the software update and disabling IRQs could be moved
into vendor code, but the software copy also needs to be updated for
the emulated PMU (which doesn't use write_global_ctrl()), so keeping
the update in common code is simpler.

Document GLOBAL_CTRL as a control that's read from the software copy and
written through to hardware while the guest context is loaded.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c     | 17 ++++++++++++-----
 arch/x86/kvm/pmu.h     | 14 ++++++++------
 arch/x86/kvm/svm/pmu.c |  6 ++++++
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index ffee8a4741ee1..d312f1b2f586a 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -873,6 +873,16 @@ static void kvm_pmu_mark_pmc_in_use(struct kvm_vcpu *vcpu, u32 msr)
 		__set_bit(pmc->idx, pmu->pmc_in_use);
 }
 
+static void kvm_pmu_set_global_ctrl(struct kvm_vcpu *vcpu, u64 global_ctrl)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	guard(irqsave)();
+	pmu->global_ctrl = global_ctrl;
+	if (kvm_vcpu_has_mediated_pmu(vcpu))
+		kvm_pmu_call(write_global_ctrl)(global_ctrl);
+}
+
 int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -934,15 +944,13 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		if (pmu->global_ctrl != data) {
 			diff = pmu->global_ctrl ^ data;
-			pmu->global_ctrl = data;
 			kvm_pmu_request_counters_reprogram(pmu, diff);
 		}
 		/*
 		 * Unconditionally forward writes to vendor code, i.e. to the
 		 * VMC{B,S}, as pmu->global_ctrl is per-VCPU, not per-VMC{B,S}.
 		 */
-		if (kvm_vcpu_has_mediated_pmu(vcpu))
-			kvm_pmu_call(write_global_ctrl)(data);
+		kvm_pmu_set_global_ctrl(vcpu, data);
 		break;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		/*
@@ -1043,8 +1051,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	    (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated_pmu(vcpu)))
 		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
 
-	if (kvm_vcpu_has_mediated_pmu(vcpu))
-		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
+	kvm_pmu_set_global_ctrl(vcpu, pmu->global_ctrl);
 
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
 	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 89d35a39b524b..a83560ac51e00 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -175,12 +175,14 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
  *    guest context is put (counters) must be read from hardware, and
  *    written to both hardware and the software copy.
  *
- *  - Controls whose software copy is always up to date (event selectors
- *    and FIXED_CTR_CTRL) can be read from the software copy, but writes
- *    must be propagated to hardware.  Guest writes to event selectors and
- *    FIXED_CTR_CTRL are always intercepted.  Note, the value written to
- *    hardware may differ from the guest-visible value, e.g. eventsel_hw
- *    vs. eventsel.
+ *  - Controls whose software copy is always up to date (event selectors,
+ *    FIXED_CTR_CTRL and GLOBAL_CTRL) can be read from the software copy,
+ *    but writes must be propagated to hardware.  Guest writes to event
+ *    selectors and FIXED_CTR_CTRL are always intercepted, and GLOBAL_CTRL
+ *    is saved on every VM-Exit if guest writes aren't intercepted.  Note,
+ *    the value written to hardware may differ from the guest-visible
+ *    value, e.g. eventsel_hw vs. eventsel, and the guest's GLOBAL_CTRL
+ *    lives in the VMCS on Intel.
  *
  * Write a guest PMU MSR, but only if the guest context is loaded on this
  * CPU.  Callers must keep IRQs disabled across updating KVM's software copy
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 1b5ed347bf1df..9c7d248f4ee10 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -242,6 +242,11 @@ static bool amd_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pm
 	return host_pmu->version >= 2;
 }
 
+static void amd_pmu_write_global_ctrl(u64 global_ctrl)
+{
+	kvm_pmu_guest_context_wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, global_ctrl);
+}
+
 static void amd_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -313,6 +318,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.is_mediated_pmu_supported = amd_pmu_is_mediated_pmu_supported,
 	.mediated_load = amd_mediated_pmu_load,
 	.mediated_put = amd_mediated_pmu_put,
+	.write_global_ctrl = amd_pmu_write_global_ctrl,
 
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.EVENTSEL_HW_SET = AMD64_EVENTSEL_GUESTONLY,
-- 
2.56.1.809.ga0b61035b5-goog

