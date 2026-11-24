Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479796;
	b=XM4Oegpvcjnqj1Niv/1TEe5iJ7XK2wkYvsbDHQLd7lbIESzAhqRxO5BU5Xr5HsUhSapZ
	 3CunUP69BtKoqtWTvk9sIyPGJ7wQREQGj6sJRejmTSNM2jGglDt0IAbFMNpi3uWLWHvvy
	 Wt45WD95Rei+2c2ld5iHO8rTHbHZ6X/wKRqMmCJOw2IUMaKOgycC/dn1jmWi+WHK96ng+
	 y/PTgIEaMLTYQkN0LTkTrhc1GKro0I/zmWKTxx2nycEZiuxLkBuHwFxhAMq6C2accbYsd
	 4YBV9/wuNW21wo3DARPzHTpNjA/8K596DeR3RPUDV+nWsi95HmhQKxzR9MefrPaYmUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2bFvwakOZ1pdzP7eEmL6qPN1rRb6aMNizV/MDuBu4IM=;
	b=Mbsk4U5PXmKdVrEWnu767XvAUHi7ukerr23OYwvo7bJzV6vWRlhu/sRj6wiXNkS1kFuT
	 kf20RrlCCVZnsor/uFDHo8UnrqJoLSof0Qsj+r09nospFRQD//8VJNmjFEjtsv8H6JZT7
	 NRFjFe8nSawi1ys8kG3qQD1XAYDNjz4vSkXPNBNk1P1SzTqj/+Mzch3wEUIQhX3v++gOc
	 slUn6D3l/b1GBgcsovmpO1mTvOCr77k2A48fM41ZZJDd6YHVlKmIbCRtR+a49aNtxU38D
	 IMTvzWbexG/aYYDhpfxg29KKBhlU0r4mNy9bm9KpNe/Jw4HduKDsT7PB11z/XAI1GsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY35z3nX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB860A2612;
	Tue, 24 Nov 2026 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WY35z3nX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833651F000EE;
	Tue, 24 Nov 2026 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479796;
	bh=2bFvwakOZ1pdzP7eEmL6qPN1rRb6aMNizV/MDuBu4IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WY35z3nXjp6eENpvy54I5W7EhhFtJQoidqjckOmdUKO3pVrH3uAnoLJpD3bskyO2L
	 gzH7aUF0/QbnNiBZlqUnw294fKN6Medx8RQgvUdZDlAZ3pduQxp2YY/x+FM8Xwz7Ct
	 /P6TORPxRKiYNNuxu7pmCSCnIDP9HpciVnz4bKl4sW7daW3c0FZim0B4MMsadQbMaS
	 AFq2L/7ZaknI1eYHA+31gHVydZvtZcXnwKQePmn18mEeunYr0NiTbSl9KiADHGTQ9k
	 wMie0xvRne1CnOZ8bijyV/lyvBAnrB4rYucCJW0x6qxB6tPQ1WQxpuw3zEQyEn5f6y
	 E3BmWE5tEsQXA==
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
Subject: [RFC PATCH 05/26] perf/x86: Don't snapshot the branch stack while a guest PMU is loaded
Date: Tue, 24 Nov 2026 00:22:42 +0000
Message-ID: <20261124002303.1785363-6-yosry@kernel.org>
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

The branch stack snapshot callbacks behind perf_snapshot_branch_stack()
(used by bpf_get_branch_snapshot()) freeze the LBRs by disabling the
PMU, copy the entries, and re-enable the PMU.  If a guest's mediated
vPMU context is loaded, e.g. if the snapshot is taken from NMI context
or within KVM's inner run loop, re-enabling the PMU writes the host's
GLOBAL_CTRL over the guest's PMU state.

On Intel, guest counters then count host code (and can raise PMIs
delivered to the guest) until the next VM-Enter.  On AMD, the guest's
GLOBAL_CTRL itself is overwritten.  KVM putting the guest context lazily
would make this worse, as the guest context would also stay loaded while
handling slowpath VM-Exits, e.g. across KVM tracepoints.

The snapshot isn't useful either: the host LBR users (core PMU events)
are scheduled out while a guest context is loaded, so the LBRs aren't
read, and callers get stale entries from the last time the LBRs were
read for the host.

Return an empty snapshot if a guest context is loaded, before touching
the PMU. Callers already handle empty snapshots, e.g.
bpf_get_branch_snapshot() returns -ENOENT for 0 entries, which the
default static call returns without LBR support.

Use unlikely() to hint to the compiler to lay out the not-taken path as
the fall-through, so that the common path doesn't add a taken branch to
the snapshot. Both GCC 15.2 and Clang 18.1.8 do this with the unlikely()
hint, and emit a taken branch on the common path without it (GCC's
-freorder-blocks, enabled at -O2 and -Os, uses __builtin_expect()
probabilities to reduce taken branches [1]). If the hint isn't honored,
the worst case is one extra branch entry in the snapshot.

[1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-freorder-blocks

Fixes: 42457a7fb6cac ("perf: Add APIs to load/put guest mediated PMU context")
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/events/amd/core.c   |  8 ++++++++
 arch/x86/events/intel/core.c | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 79a1c5f91b3af..874beab47541a 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -937,6 +937,14 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 	 * and contain no branches to minimize contamination of LBR snapshot
 	 */
 	guard(irqsave)();
+
+	/*
+	 * Bail if the guest owns the PMU.  unlikely() hints the compiler to not
+	 * take a branch on the common path, which would pollute the snapshot.
+	 */
+	if (unlikely(is_guest_mediated_pmu_loaded()))
+		return 0;
+
 	amd_pmu_core_disable_all();
 	__amd_pmu_lbr_disable();
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4992cf76c7e83..8972fe5c850c2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2834,6 +2834,14 @@ intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int
 {
 	/* must not have branches... */
 	guard(irqsave)();
+
+	/*
+	 * Bail if the guest owns the PMU.  unlikely() hints the compiler to not
+	 * take a branch on the common path, which would pollute the snapshot.
+	 */
+	if (unlikely(is_guest_mediated_pmu_loaded()))
+		return 0;
+
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_lbr_disable();
 	/*            ... until here */
@@ -2845,6 +2853,14 @@ intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned
 {
 	/* must not have branches... */
 	guard(irqsave)();
+
+	/*
+	 * Bail if the guest owns the PMU.  unlikely() hints the compiler to not
+	 * take a branch on the common path, which would pollute the snapshot.
+	 */
+	if (unlikely(is_guest_mediated_pmu_loaded()))
+		return 0;
+
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
 	__intel_pmu_arch_lbr_disable();
 	/*            ... until here */
-- 
2.56.1.809.ga0b61035b5-goog

