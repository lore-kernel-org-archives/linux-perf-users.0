Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479822;
	b=EXKkAWn4SadelNW1XpiG2o91M/5Si+FIsO9OCwF7rdBxt/Xo9Giq/GY8VlFuHQDSP3+s
	 nEpzszecgLBEBStqo3Hv/niU5ho/H+4nwudPtS0nSAFmtOFAOTBz9+yk/RCmQGDTvni0w
	 +0n0RvBp9vZQMNIQju/BZ9YngT1KH+ZtdY62MZKzrtT3K6laFDeaOE7k41Qr1RRyrwxOP
	 vt/lJGTtFloK7zkqsyJ6GcPbXx1+FnhcjUhTZQu4PjILvATTFKOllU3i14RJFCwGB2E/B
	 0p6kmmYcT8c/uOJ1guKXTta/Ql7zDx83m86EB/fFyYXhQLj1mT7jLvwLpLUeCB9G6lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vA83aK0bo+4iPUtHM3M9jZpAf9DRYazZdjOdW51gUGI=;
	b=5LvVtiJNBfFoKdE0u9oxEJ9VuXMgzrKOaRTcpKFM9kXzgnuzEAfanqznUAwFtTgYO+RW
	 vl8nnIQErt3PlfhjANXW17sdlW0YQTPkYrOJ/tbaMMRfGqgqOnLhg4r65Lr7pkmX1QH6y
	 v/ZA53gyby2B4j1XuIJ4uBoSzpsTeF96lDUPxUA4QtECOS3pnSXiG/XPNLykpfxdzw6Iz
	 BLSc1UqZgSM9uGm7F+e8BdHeFNMBmeR2IMmBuRkNyNEoXIlOoT2R6lAjUPLkHK70gYMPp
	 nxC26WQsJTOVnmj812KJH1JCYLAVGc0w14fDC+TaEduazpUplq5V3uKDKntd9/ec2MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKDdPSap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809160A2625;
	Tue, 24 Nov 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKDdPSap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485561F01572;
	Tue, 24 Nov 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479822;
	bh=vA83aK0bo+4iPUtHM3M9jZpAf9DRYazZdjOdW51gUGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fKDdPSapkPMKNlZi6pPUo1Zbk1AyUdSKn+12j/GTl2yRhKxkjk32NJe+Z5+l4VsX9
	 xgh64yDMqKjMzs3rncd3C5gYJDUBTMWYxXKFZK3SV3TieSI6EP6Hx1nfIYyAzv05PY
	 8uXOySSikTGNFK9uVjR1aX2WY1cLN7ox39+PzgWsNLGOh92AjfWH5lrZTOryT5oka+
	 Cmds5NXsRjFvBkV6rKIATq+KTzu7wXCsIdhiBICbcOBHHMSFdBPhbmBmGAolviP2l8
	 lhdtpeat6qYbXc9/1RoWCgxb2aPB1uPLf7hLdoKHo5yDnDx4xD8eybeiQ32a0P3NMq
	 /dLQWWk11EBpg==
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
Subject: [RFC PATCH 23/26] KVM: x86/pmu: Add stats for mediated PMU context switches
Date: Tue, 24 Nov 2026 00:23:00 +0000
Message-ID: <20261124002303.1785363-24-yosry@kernel.org>
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

Add per-vCPU stats counting how many times the guest's mediated PMU
context is put, and why, mainly to help debug performance problems
caused by frequent guest context switches, e.g. due to host perf events
conflicting with the mediated PMU.  The stats are also useful for
testing. Add:

- pmu_ctx_switches: all puts of the guest context.

- pmu_ctx_switches_vmexit: puts on VM-Exits, because perf has events
  conflicting with the mediated PMU.  Note, the guest context is only
  put on slowpath VM-Exits, not on every VM-Exit.

- pmu_ctx_switches_reclaim: puts because perf reclaimed the mediated
  PMU.

Don't add a stat for puts when the vCPU is put, e.g. when the vCPU task
is scheduled out or KVM_RUN returns to userspace, as it can be derived
from the other stats, and when exactly the vCPU is put is an
implementation detail.

Return whether the guest context was actually put from
kvm_mediated_pmu_put(), as it may already be put when perf reclaims the
mediated PMU.  The guest context is always loaded on slowpath VM-Exits
for vCPUs with a mediated PMU, so WARN if it wasn't put there, and count
the put unconditionally.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/pmu.c              | 11 ++++++++---
 arch/x86/kvm/pmu.h              |  2 +-
 arch/x86/kvm/x86.c              |  9 +++++++--
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3efef3415f8e8..366b00ffa37f4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1477,6 +1477,9 @@ struct kvm_vcpu_stat {
 	u64 preemption_other;
 	u64 guest_mode;
 	u64 notify_window_exits;
+	u64 pmu_ctx_switches;
+	u64 pmu_ctx_switches_vmexit;
+	u64 pmu_ctx_switches_reclaim;
 };
 
 struct x86_instruction_info;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4879578c7d579..80229f3d477fb 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -230,7 +230,8 @@ void kvm_handle_mediated_pmu_reclaim(void)
 	if (WARN_ON_ONCE(!vcpu || !kvm_vcpu_has_mediated_pmu(vcpu)))
 		return;
 
-	kvm_mediated_pmu_put(vcpu);
+	if (kvm_mediated_pmu_put(vcpu))
+		++vcpu->stat.pmu_ctx_switches_reclaim;
 }
 
 static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
@@ -1489,13 +1490,14 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 	}
 }
 
-void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
+/* Returns true if the guest context was loaded and is now put. */
+bool kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_irqs_disabled();
 
 	if (!is_guest_mediated_pmu_loaded() ||
 	    KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
-		return;
+		return false;
 
 	/*
 	 * Defer handling of PERF_GLOBAL_CTRL to vendor code.  On Intel, it's
@@ -1508,4 +1510,7 @@ void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 	perf_put_guest_lvtpc();
 
 	perf_put_guest_context();
+
+	++vcpu->stat.pmu_ctx_switches;
+	return true;
 }
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 89807e7a3c771..565e09b23c498 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -333,7 +333,7 @@ void kvm_pmu_instruction_retired(struct kvm_vcpu *vcpu);
 void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu);
 void kvm_pmu_sync_lvtpc(struct kvm_vcpu *vcpu, u32 lvtpc);
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu);
-void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu);
+bool kvm_mediated_pmu_put(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7fb954ed8e84b..ca2a58079b019 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -299,6 +299,9 @@ const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	STATS_DESC_COUNTER(VCPU, preemption_other),
 	STATS_DESC_IBOOLEAN(VCPU, guest_mode),
 	STATS_DESC_COUNTER(VCPU, notify_window_exits),
+	STATS_DESC_COUNTER(VCPU, pmu_ctx_switches),
+	STATS_DESC_COUNTER(VCPU, pmu_ctx_switches_vmexit),
+	STATS_DESC_COUNTER(VCPU, pmu_ctx_switches_reclaim),
 };
 
 const struct kvm_stats_header kvm_vcpu_stats_header = {
@@ -8439,8 +8442,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	kvm_load_host_pkru(vcpu);
 
-	if (kvm_vcpu_has_mediated_pmu(vcpu) && perf_has_mediated_pmu_conflicts())
-		kvm_mediated_pmu_put(vcpu);
+	if (kvm_vcpu_has_mediated_pmu(vcpu) && perf_has_mediated_pmu_conflicts()) {
+		WARN_ON_ONCE(!kvm_mediated_pmu_put(vcpu));
+		++vcpu->stat.pmu_ctx_switches_vmexit;
+	}
 
 	/*
 	 * Do this here before restoring debug registers on the host.  And
-- 
2.56.1.809.ga0b61035b5-goog

