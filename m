Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479795;
	b=aCiKjOpSe3bgbLHhf/PUC+IJmRscZHFOh/ZIMWSvTqSW39pXLrbhO5+pgm33ZjLL33Jj
	 KETCQIicNStespcJv27Zyu8VU60Yb3+CgPDFz/zJFdE6c5kuiS0DInIqoOxNxLXVvKhhz
	 nfG2NyA9/Ur2VYka5UTuyZwDaDLWue85Kni8bmKqLxnfvvCMdb5nHd+/gfY0SXEYvd3yc
	 lyrmi9BkIZ1A/m0pRB8rlUFmLL5MwCwIKomNPt6D9uk/pJrp4c0IEG9KMNb6h9lt10KMy
	 iMuHwur4bHEjABPJrgUc5tISul1CtFAT05yD7eKKZ3wa2FPW47tSY7Mwkk48L/jHQtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tAohcxZBpFO1NQLl/3wbffBW8Xi/K3DQzfSMEum+Yoo=;
	b=Ls0fyl9WvkAlMrBgzMcybF5nIvtXYaQFPrh/NTfumlal+8sJ6PkO2++sFOR8FHlloS2+
	 HP0lt/95+1sf13dFYXJrJCOS7JiQqhtA30fmPS6FG7WpAoV1eKJ32k25xKOHnfYkwTudK
	 DVSGKzVXiJQMVgSW16d54MrWS2xm3l/AGc/IM6iq42NjeWJlwSErF8mYorlQr8SLVtHYF
	 Ni+jWv0VOBPgz+GBp8jnpo9yjQ0fhpl9gbtXnAYnBEcdekMf8lZRDnlMp6OqwHydNaRQW
	 fXmxF5Qmm1iul+3R0VwNVkxGuXn6JNMJDI67WX3KNPDZ7ZlvLM0URWD3U1KGjZqhCLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1pnJ14d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5236606A6B1;
	Tue, 24 Nov 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1pnJ14d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEA81F000D1;
	Tue, 24 Nov 2026 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479795;
	bh=tAohcxZBpFO1NQLl/3wbffBW8Xi/K3DQzfSMEum+Yoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1pnJ14dPKQXCFgbD8gezqAa/uPZHqFrMihUFX1Fo1SAFRIqFytphxAuvJBIs4tcD
	 ZHNuT9Z/jfBjB3d92OE4ZVyMgUUUHPVkLSKaoh/YcdMEEjCscB6aoym9PRaGMlUyGV
	 tOuJgAQwwRsT2l/30od+6hr5Trg9YQK5ZTGVBRIlI/7JFj3JPR9xSz22GI9sgNoqjs
	 ChjIwRuffMW/mPXt98GchZtCfeMrMR3aC+/gZFAUEiBjo3l8bwUPMEWDygNufTUHch
	 tjVjtdhru5+nHjBU/LelDcUdEvDHszVpvVRpYcPyxc84LzilbPbNME2yyexRtl2lei
	 0rbsTlEzfj0Zg==
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
	Yosry Ahmed <yosry@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [RFC PATCH 04/26] perf/x86: Use irqsave guard in branch stack snapshotting callbacks
Date: Tue, 24 Nov 2026 00:22:41 +0000
Message-ID: <20261124002303.1785363-5-yosry@kernel.org>
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

In preparation for adding an early return to these functions, use
guard(irqsave)() instead of local_irq_{save,restore}(), which also drops
the local flags variable. IRQs are no longer restored in
__intel_pmu_snapshot_branch_stack(), but in its callers.

The guard saves IRQs at the same point local_irq_save() did and restores
them at scope exit, after the PMU and LBR are re-enabled, so the
branch-free window before the LBR is frozen is unchanged.

No functional change intended.

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/events/amd/core.c   |  4 +---
 arch/x86/events/intel/core.c | 15 +++++----------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce5664..79a1c5f91b3af 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -931,13 +931,12 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
 {
 	struct cpu_hw_events *cpuc;
-	unsigned long flags;
 
 	/*
 	 * The sequence of steps to freeze LBR should be completely inlined
 	 * and contain no branches to minimize contamination of LBR snapshot
 	 */
-	local_irq_save(flags);
+	guard(irqsave)();
 	amd_pmu_core_disable_all();
 	__amd_pmu_lbr_disable();
 
@@ -948,7 +947,6 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 
 	amd_pmu_v2_enable_all(0);
-	local_irq_restore(flags);
 
 	return cnt;
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df590..4992cf76c7e83 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2817,7 +2817,7 @@ static void intel_pmu_enable_all(int added)
 
 static noinline int
 __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
-				  unsigned int cnt, unsigned long flags)
+				  unsigned int cnt)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -2826,34 +2826,29 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 	intel_pmu_enable_all(0);
-	local_irq_restore(flags);
 	return cnt;
 }
 
 static int
 intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
 {
-	unsigned long flags;
-
 	/* must not have branches... */
-	local_irq_save(flags);
+	guard(irqsave)();
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_lbr_disable();
 	/*            ... until here */
-	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+	return __intel_pmu_snapshot_branch_stack(entries, cnt);
 }
 
 static int
 intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
 {
-	unsigned long flags;
-
 	/* must not have branches... */
-	local_irq_save(flags);
+	guard(irqsave)();
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_arch_lbr_disable();
 	/*            ... until here */
-	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
+	return __intel_pmu_snapshot_branch_stack(entries, cnt);
 }
 
 /*
-- 
2.56.1.809.ga0b61035b5-goog

