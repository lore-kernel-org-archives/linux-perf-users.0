Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479826;
	b=l9NWBws5Ig9Jax2bjJU+le4ulYi04T908KlBP/d18s/etMFZLTiKa3BTDqX1l4DGdrV8
	 C2F51CVL15/k3siYJt5piXZ0eU+wuIACbuvEzFZIzei7MC5kEeXDleTIAKQ01UIxoEJ0W
	 713V571Qvqy+8X2wNkA5VZmm4pcV/Sc+FILKe9Vl7Z26X1qWWc3MRLTOZbHJfluKZeJKd
	 pxDQNvrIhc4dv8AM9yqotwMBTsWj4ttoBwfUb+eoBF6ITza7ssm4PK8sxS6K7S5Q063h0
	 tbB+TegVRI6TAdktEKoeCdrgkNuL5rN25phnNinb17xPfHd7ME+X5Op7SQUz99ypL4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rMzI9ARjYbF3YZ8FF7+zs/SIxNGg4vON9w4oyH3HYGg=;
	b=j0PE21ODca8Rf2Kxp96UApVxDvkr2x7Qdc0PCcxT/bNpPBcIC63QBGp/2KEbie3tfGqF
	 2S83z3AeEHp239RxZOvl+W925H5FKkAETjNPweh1n93syRoGK0QdYe29jR9tnHZJzdjdQ
	 8LRZQ2o6cueww7ND+bUi3HOIqFEtXUbpJ2yCqsRrH0MVyUhcAFyyBHSM2AEoK5cx8ASW/
	 FqTfH2BM4SUwQxWUc66fUVk91+WikZDrtxFLG2q1k7jGwforTzs8lT5CxPwHSUNzBrQR3
	 +Mxnyn89XJbPKCPFt65ECaPJ6RLR6jX1vGnKKxz+YC94FsX22tiHAI1sd18JDUEfVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWHBjoCI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA45606A68B;
	Tue, 24 Nov 2026 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWHBjoCI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D615B1F0093C;
	Tue, 24 Nov 2026 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479826;
	bh=rMzI9ARjYbF3YZ8FF7+zs/SIxNGg4vON9w4oyH3HYGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWHBjoCI66SGYw8l7YKVycvQluFNnLGwa0p1BM2c7DUz74M7TUsaRJu0wJEiAQFts
	 Xy9yXTqxeSeu34ish56PihOIujGnnt116ffd4L2sZ7VoLFR2KjVpma/NodoyUKLjfc
	 VLVyoHGbZ+4DA8r7AkVlXrAiQu0IXSGXzrLX9wgCN0qJsMmwrzIGxcj+CV1uLQGRlO
	 nftxTtrX6U35269+HokGFGdkPvMdRQ3DbArMJVeQFbo8QikKyFPkhuhLh2FszTCmLE
	 ZRyDoFvT2PY0aJ0lz0UdRUw20bB3Su1atEU1R8EpQ6PkIacVl3m5KGutrtpmfPkbcq
	 XSH+puZHO6Xvw==
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
Subject: [RFC PATCH 26/26] KVM: x86/pmu: Allow emulation in the fastpath with a mediated PMU
Date: Tue, 24 Nov 2026 00:23:03 +0000
Message-ID: <20261124002303.1785363-27-yosry@kernel.org>
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

Effectively revert commit f7a65e58d643 ("KVM: x86/pmu: Disallow
emulation in the fastpath if mediated PMCs are active"), as KVM no
longer relies on its software copies of PMU state being consistent with
hardware while the guest context is loaded.

KVM now accesses PMU registers in hardware if needed with the guest
context loaded, and can therefore emulate instructions correctly in the
fastpath with a mediated PMU. Specifically, KVM writes to hardware when
incrementing counters or setting bits in GLOBAL_STATUS if the guest
context is loaded.

When emulating an instruction in the fastpath, KVM increments PMCs that
count instructions with the guest context loaded.  KVM now updates
counters and GLOBAL_STATUS in hardware in that case.
kvm_pmu_trigger_event() reads GLOBAL_CTRL from software to determine
which counters to increment, but the software copy is up to date even
when the guest context is loaded: either guest writes are intercepted,
or it's synced from hardware after every VM-Exit

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c |  3 ---
 arch/x86/kvm/pmu.h  | 10 ----------
 arch/x86/kvm/x86.c  |  6 ------
 3 files changed, 19 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c58889cf36f55..9f2172060d331 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -924,9 +924,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_write);
 
 static fastpath_t __handle_fastpath_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
-	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	switch (msr) {
 	case APIC_BASE_MSR + (APIC_ICR >> 4):
 		if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(vcpu->arch.apic) ||
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 565e09b23c498..5953f3e8a5d45 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -308,16 +308,6 @@ static inline bool pmc_is_globally_enabled(struct kvm_pmc *pmc)
 	return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
 }
 
-static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
-{
-	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-
-	return !kvm_vcpu_has_mediated_pmu(vcpu) ||
-	       !bitmap_intersects(pmu->pmc_counting_instructions,
-				  (unsigned long *)&pmu->global_ctrl,
-				  X86_PMC_IDX_MAX);
-}
-
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca2a58079b019..c1469a64c880d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -831,9 +831,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_invd);
 
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	if (!kvm_emulate_invd(vcpu))
 		return EXIT_FASTPATH_EXIT_USERSPACE;
 
@@ -8780,9 +8777,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_halt);
 
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	if (!kvm_emulate_halt(vcpu))
 		return EXIT_FASTPATH_EXIT_USERSPACE;
 
-- 
2.56.1.809.ga0b61035b5-goog

