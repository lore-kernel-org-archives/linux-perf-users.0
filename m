Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479807;
	b=XA5yaW5DYnIpBKGscG6xlHmi+lntTzBzX8szedLyLOWkEvIlj/x6nEAI/OZBPi2SrChH
	 Hkn00TxWkLT4xyhmFlFNvVUUQ+nm5zSWObXJzaJ/xprAkKFw9MenEoFWP3mKYCYskY9E8
	 CtzcV9VX7u4cr+D2A9JlIAE+/HOoMZrFaJa9tST+ZMA/Sn9SfNKeMrb1yYzx/B+IMax91
	 o2m46Z9p8EWadcIJyGAFug2GFtMg4UKs4/6XR6UqIZh+rP133RB7Gj+oFJ8azcedVlHNp
	 7WkVZQOjGHOVupGLivY+s46CZ+PB5fMpy6vYe6Em0n2iwor9pXfsNlgXK5GSEDMAdhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479807;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/Q08YDoQbOfOm+qoyKhtZdI+17Mqu5hb8hqerCG3tsc=;
	b=XhXnw1NrlkT+GtQLsa2n/601BHROmGZoOzsD0UU1Bw6omVbQbJHY0/96WWNFMkiYlNNu
	 26DsP3wNq3gzCvqF5bvGiqRVK0tdOVjjon/EB5PIav44qHmviup0Sqw09FtA5T485hq4U
	 s7mf6eit4jml9qnJCcwtu0AZlV4J4qZ1Si4Frg0PmqSsgP52DP5+SaLYLi0fwcAPfBU5f
	 CqTw/+/43JGvj4yXFIuHsknhjfEXOLRP6GXM98cddBGLRjPHJcHGhefMV4GYRcPJVBfzg
	 aYGu4tFKaw0Mi3dn3pPCYXt265LMJIh0gBeC2GG7mGXY1HHCBLgSXCkdHOrJCU3Oe8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEph31NC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2D60A5BE7;
	Tue, 24 Nov 2026 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEph31NC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7021F01576;
	Tue, 24 Nov 2026 00:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479807;
	bh=/Q08YDoQbOfOm+qoyKhtZdI+17Mqu5hb8hqerCG3tsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEph31NC1icNqhy33KolhrxluSuaht2nfLoDFTap6z6aMmzAMkRA8sve2a3icXFbr
	 TMxX2eWEbXILDjp0gPAZuFdZD9gIXbsRp841f2DxWjlC9w2h/B8L7K/d8OIE3UDkMg
	 O+ykItxRgAio1QlD8gxh+8aT/8V4iTjsRHPxEFaanVpsiJqqchgAdWqn5vj42n5Mjp
	 YMLKNlxEooUC3I+evl/KQs30p+laE6wo3F/1yBojd2MqI+KEdLRhiykK3RjXuBQANL
	 zELBjk5mQ0AlcpERFPy0hHUOSd3spzLrvQT3Cr9sqNg3ZXluNtyFtJk7WySsEd2CeS
	 4R8TYwoWsfWdQ==
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
Subject: [RFC PATCH 13/26] KVM: x86/pmu: Compute eventsel_hw from eventsel when reprogramming
Date: Tue, 24 Nov 2026 00:22:50 +0000
Message-ID: <20261124002303.1785363-14-yosry@kernel.org>
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

Instead of only setting the enable bit in eventsel_hw when refreshing
the event filter, compute the entire eventsel_hw from eventsel when
reprogramming a counter that's allowed to count, and rename
kvm_mediated_pmu_refresh_event_filter() to
kvm_mediated_pmu_reprogram_counter() accordingly. As counters are only
allowed to count if the enable bit is set in eventsel, copying eventsel
also sets the enable bit.

Move forcing GUESTONLY and clearing HOSTONLY on AMD from
amd_pmu_set_msr() to the reprogramming path, using vendor-provided bits
to set and clear, and have amd_pmu_set_msr() record the guest's value
as-is like Intel. Writing an event selector always requests a reprogram,
which is handled before the guest context is loaded, so the value is
fixed up before it's written to hardware.

For counters that can't count, the event selector in hardware may now
differ in the GUESTONLY and HOSTONLY bits, which is benign as the enable
bit is cleared.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c     | 8 ++++----
 arch/x86/kvm/pmu.h     | 2 ++
 arch/x86/kvm/svm/pmu.c | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 6f82213058f14..0a5299532c086 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -570,7 +570,7 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
 	return is_fixed_event_allowed(filter, pmc->idx);
 }
 
-static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
+static void kvm_mediated_pmu_reprogram_counter(struct kvm_pmc *pmc)
 {
 	bool allowed = pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc);
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
@@ -578,8 +578,8 @@ static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 	if (pmc_is_gp(pmc)) {
 		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 		if (allowed)
-			pmc->eventsel_hw |= pmc->eventsel &
-					    ARCH_PERFMON_EVENTSEL_ENABLE;
+			pmc->eventsel_hw = (pmc->eventsel | kvm_pmu_ops.EVENTSEL_HW_SET) &
+					   ~kvm_pmu_ops.EVENTSEL_HW_CLR;
 	} else {
 		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
 
@@ -598,7 +598,7 @@ static int reprogram_counter(struct kvm_pmc *pmc)
 	u8 fixed_ctr_ctrl;
 
 	if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
-		kvm_mediated_pmu_refresh_event_filter(pmc);
+		kvm_mediated_pmu_reprogram_counter(pmc);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index fe1baa50ebceb..462df3a9de491 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -44,6 +44,8 @@ struct kvm_pmu_ops {
 	void (*write_global_ctrl)(u64 global_ctrl);
 
 	const u64 EVENTSEL_EVENT;
+	const u64 EVENTSEL_HW_SET;
+	const u64 EVENTSEL_HW_CLR;
 	const int MAX_NR_GP_COUNTERS;
 	const int MIN_NR_GP_COUNTERS;
 
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c18286545a7ac..232c4779e5a32 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -166,8 +166,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
-					   AMD64_EVENTSEL_GUESTONLY;
+			pmc->eventsel_hw = data;
 
 			if (data & AMD64_EVENTSEL_HOST_GUEST_MASK)
 				__set_bit(pmc->idx, pmu->pmc_has_mode_specific_enables);
@@ -317,6 +316,8 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.mediated_put = amd_mediated_pmu_put,
 
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
+	.EVENTSEL_HW_SET = AMD64_EVENTSEL_GUESTONLY,
+	.EVENTSEL_HW_CLR = AMD64_EVENTSEL_HOSTONLY,
 	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_AMD_GP_COUNTERS,
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
 
-- 
2.56.1.809.ga0b61035b5-goog

