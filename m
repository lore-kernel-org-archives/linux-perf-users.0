Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940091;
	b=3c6B91UI5ztCm7FqTTWbEdsD0EB7jd9dDRRE2qVh7RSVMdzBTAT1K/BtDDBRZCuFCmtX
	 5VO9iIKHQe5Fvy4fi65rvqJbEoHB/ZsfHVjVf6KUpaMXvQfeW79QUB3xUfJX0ubKu3Nnj
	 LROww1yI+0IQ04b1bVaBBBIgNG2eAykwkO2nISYfyOhozPy9LCyglAQkaQZzOKbXwHFsr
	 KSL9y85QmnwEgzfpr/SFsXoq/plx7YL5zI9Bu7SahCrbL+ZBhKOGHsdSM7n8TZL6C2Lf9
	 6R3XJglo4Z08aEuDvrqFLzXIE96US9iSAGjS3bnuZfKv7dKurl0eGGgGuVwUbv2SZGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940091;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6QDUvi2wmIZ2DTjW9JqPBhh4RvDdhQCReBM9+mvfseI=;
	b=kKy8WsTOt+5bNc2k+xxVyO7+D9X/JSdGMC1m+s1XckXgSSdwVQwkNot7haWGNx1ox9LD
	 /5+fpZ6CyVVcz0j/1E7Vlk4RN7P2UnPdvlkpygrbuVWkv6/fBx9uDUi4PPMmU5ItdlFnr
	 AApND+ZvaHxttS2t6NdBwR7/0AAH6nm6XuTUa45W99actwC4AT12SXFUF1QOSSub9vBpg
	 21ZLA3W2lAqBhZymS8ZtBCVzPDXs9J3rjhrAoFdtvVcusy5WeT3O+5WHbBUsDaFOyO99t
	 uKBx4gsLc4+kkch3s3bGso9J97HhzZ0LqIfB8yxoSpJurpemZRE2yJ0Fkd7fPnnMUaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VkV4asqU;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F338606A330;
	Fri,  6 Nov 2026 04:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F338606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VkV4asqU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940092; x=1825476092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KL2OOeiYhEs0mXY7cG1Fft/MuT/CneMOmd5GWPClGvQ=;
  b=VkV4asqUyVwAlGwtcFvurB0f7HNaxckSyqCi5pulo58rc0HjmUXCeY7y
   2HiRG1cl5HSnxiuYiioylvEP6EUGnOfKISn6VLTcGvIUq6ospp3sUMeUj
   pJdGyIhBkWx3k8CTv0+S1VjrnnhBf/tHrxVNpHN8JqmpB1IYZ/7hkVEQ4
   cqXwMa+pJ3Z3aVXfvOLdbyoa04h4YJgibIimkcMsu/GG4jG2dv37tddqR
   Ks2oTIzWQQ1ndpOe89ryaihK3R+OLxZvH/nwQ/V+3XX5VcCsX1GLE6Tyr
   bz5YfXRB+CFi+YpHcU+kUotsDEcDtT3NZyD/L8sjzE1DoZ9kjcKhA4BH9
   g==;
X-CSE-ConnectionGUID: jgRkcfs7SSKXaUg6mgzUbw==
X-CSE-MsgGUID: DpG1tRYySDWCVtkb5Ng1Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780859"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780859"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:31 -0800
X-CSE-ConnectionGUID: LAlMQo1+SBWCdBWMmQQ/nw==
X-CSE-MsgGUID: aNIS1p3DTLyp9WJN/K+lYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222968"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:26 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 11/20] perf/x86/intel: Allow LBR read helpers to operate on explicit stacks
Date: Fri,  6 Nov 2026 12:32:48 +0800
Message-Id: <20261106043257.842864-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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

The LBR read helpers currently assume the default stack,
cpuc->lbr_stack, and therefore cannot be reused for other LBR
stacks that may be in use. Extend the *_lbr_read() helpers to take
an explicit LBR stack argument, so they can operate on any LBR stack
instead of only the default one.

Update the related callers, including intel_pmu_store_lbr() and
intel_pmu_lbr_filter(), to pass the appropriate stack explicitly.

No function change intended.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/brs.c    |  2 +-
 arch/x86/events/amd/lbr.c    |  2 +-
 arch/x86/events/intel/core.c |  4 +-
 arch/x86/events/intel/lbr.c  | 89 ++++++++++++++++++++----------------
 arch/x86/events/perf_event.h | 16 ++++---
 5 files changed, 64 insertions(+), 49 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 1906d1257646..475e3699d3ca 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -316,7 +316,7 @@ void amd_brs_drain(void)
 
 	num = tos - start + 1;
 
-	cpu_init_lbr_stack(cpuc, num);
+	cpu_init_lbr_stack(cpu_lbr_stack(cpuc), num);
 
 	/*
 	 * BRS is only one pass (saturation) from MSROFF to depth-1
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 3e4e5e984649..95898a1d9901 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -179,7 +179,7 @@ void amd_pmu_lbr_read(void)
 		return;
 	}
 
-	cpu_init_lbr_stack(cpuc, x86_pmu.lbr_nr);
+	cpu_init_lbr_stack(cpu_lbr_stack(cpuc), x86_pmu.lbr_nr);
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		entry.from.full	= amd_pmu_lbr_get_from(i);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 42d4d525a729..b7045c05b736 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,7 +2826,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	intel_pmu_lbr_read();
+	intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 	cnt = min_t(unsigned int, cnt, cpu_lbr_stack(cpuc)->nr);
 
 	memcpy(entries, cpu_lbr_stack(cpuc)->entries,
@@ -4062,7 +4062,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	intel_pmu_lbr_read();
+	intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 
 	/*
 	 * Do not clear the LBR frozen status here; keep LBR frozen
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 62f2f4b9cfde..979b094ae228 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -105,7 +105,9 @@
 
 #define ARCH_LBR_CTL_MASK			0x7f000e
 
-static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
+static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
+				 struct perf_branch_stack *lbr_stack,
+				 u64 *lbr_counters);
 
 static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
 {
@@ -741,13 +743,14 @@ void intel_pmu_lbr_disable_all(void)
 	}
 }
 
-void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 
-	cpu_init_lbr_stack(cpuc, x86_pmu.lbr_nr);
+	cpu_init_lbr_stack(lbr_stack, x86_pmu.lbr_nr);
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
 		union {
@@ -760,13 +763,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
+		lbr_stack->entries[i] = (struct perf_branch_entry){
 			.from	= msr_lastbranch.from,
 			.to	= msr_lastbranch.to,
 		};
 	}
-	cpu_lbr_stack(cpuc)->nr = i;
-	cpu_lbr_stack(cpuc)->hw_idx = tos;
+	lbr_stack->nr = i;
+	lbr_stack->hw_idx = tos;
 }
 
 /*
@@ -774,7 +777,8 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  * is the same as the linear address, allowing us to merge the LIP and EIP
  * LBR formats.
  */
-void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
@@ -789,7 +793,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 			call_stack = true;
 	}
 
-	cpu_init_lbr_stack(cpuc, num);
+	cpu_init_lbr_stack(lbr_stack, num);
 	for (i = 0; i < num; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
 		u64 from, to, mis = 0, pred = 0, in_tx = 0, abort = 0;
@@ -850,7 +854,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		cpu_lbr_stack(cpuc)->entries[out] = (struct perf_branch_entry){
+		lbr_stack->entries[out] = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mis,
@@ -861,8 +865,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		};
 		out++;
 	}
-	cpu_lbr_stack(cpuc)->nr = out;
-	cpu_lbr_stack(cpuc)->hw_idx = tos;
+	lbr_stack->nr = out;
+	lbr_stack->hw_idx = tos;
 }
 
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
@@ -903,17 +907,19 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 
 static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS);
 
-static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
-				struct lbr_entry *entries)
+static void intel_pmu_store_lbr(struct lbr_entry *entries,
+				struct perf_branch_stack *lbr_stack)
 {
+	struct perf_branch_entry *e;
 	struct lbr_entry *lbr;
 	u64 from, to, info;
 	bool mispred;
 	int i;
 
-	cpu_init_lbr_stack(cpuc, x86_pmu.lbr_nr);
+	cpu_init_lbr_stack(lbr_stack, x86_pmu.lbr_nr);
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		lbr = entries ? &entries[i] : NULL;
+		e = &lbr_stack->entries[i];
 
 		from = rdlbr_from(i, lbr);
 		/*
@@ -927,7 +933,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 		mispred = get_lbr_mispred(info);
 
-		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
+		*e = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mispred,
@@ -948,7 +954,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		};
 	}
 
-	cpu_lbr_stack(cpuc)->nr = i;
+	lbr_stack->nr = i;
 }
 
 /*
@@ -999,37 +1005,41 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
 }
 
-static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
+static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc,
+				    struct perf_branch_stack *lbr_stack)
 {
-	intel_pmu_store_lbr(cpuc, NULL);
+	intel_pmu_store_lbr(NULL, lbr_stack);
 }
 
-static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
+static void
+intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc,
+			      struct perf_branch_stack *lbr_stack)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
 
 	if (!xsave) {
-		intel_pmu_store_lbr(cpuc, NULL);
+		intel_pmu_store_lbr(NULL, lbr_stack);
 		return;
 	}
 	xsave->header.xfeatures = 0;
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	if (xsave->header.xfeatures & XFEATURE_MASK_LBR) {
-		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+		intel_pmu_store_lbr(xsave->lbr.entries, lbr_stack);
 	} else {
 		/* Clear the LBR stack to avoid leaking stale entries. */
-		cpu_lbr_stack(cpuc)->nr = 0;
+		lbr_stack->nr = 0;
 	}
 }
 
-void intel_pmu_lbr_read(void)
+void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
+			u64 *lbr_counters)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!cpuc->lbr_users || vlbr_exclude_host()) {
-		/* Reset lbr_stack.nr to prevent stale data leakage. */
-		cpu_lbr_stack(cpuc)->nr = 0;
+		/* Reset lbr_stack->nr to prevent stale data leakage. */
+		lbr_stack->nr = 0;
 		return;
 	}
 
@@ -1042,9 +1052,9 @@ void intel_pmu_lbr_read(void)
 	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
-	x86_pmu.lbr_read(cpuc);
+	x86_pmu.lbr_read(cpuc, lbr_stack);
 
-	intel_pmu_lbr_filter(cpuc);
+	intel_pmu_lbr_filter(cpuc, lbr_stack, lbr_counters);
 }
 
 /*
@@ -1227,7 +1237,9 @@ static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
  * in PERF_SAMPLE_BRANCH_STACK sample may vary.
  */
 static void
-intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
+intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
+		     struct perf_branch_stack *lbr_stack,
+		     u64 *lbr_counters)
 {
 	int br_sel = cpuc->br_sel;
 	int i, j, type, from_plm, to_plm;
@@ -1240,8 +1252,8 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
-	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
-		struct perf_branch_entry *be = &cpu_lbr_stack(cpuc)->entries[i];
+	for (i = 0; i < lbr_stack->nr; i++) {
+		struct perf_branch_entry *be = &lbr_stack->entries[i];
 
 		from = be->from;
 		to = be->to;
@@ -1285,22 +1297,21 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		return;
 
 	/* remove all entries with from=0 */
-	lbr_nr = cpu_lbr_stack(cpuc)->nr;
+	lbr_nr = lbr_stack->nr;
 	for (i = 0; i < lbr_nr; ) {
-		if (!cpu_lbr_stack(cpuc)->entries[i].from) {
+		if (!lbr_stack->entries[i].from) {
 			j = i;
 			while (++j < lbr_nr) {
-				cpu_lbr_stack(cpuc)->entries[j-1] =
-					cpu_lbr_stack(cpuc)->entries[j];
-				cpuc->lbr_counters[j-1] = cpuc->lbr_counters[j];
+				lbr_stack->entries[j-1] = lbr_stack->entries[j];
+				lbr_counters[j-1] = lbr_counters[j];
 			}
 			lbr_nr--;
-			if (!cpu_lbr_stack(cpuc)->entries[i].from)
+			if (!lbr_stack->entries[i].from)
 				continue;
 		}
 		i++;
 	}
-	cpu_lbr_stack(cpuc)->nr = lbr_nr;
+	lbr_stack->nr = lbr_nr;
 }
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
@@ -1314,8 +1325,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpu_lbr_stack(cpuc)->hw_idx = intel_pmu_lbr_tos();
 
-	intel_pmu_store_lbr(cpuc, lbr);
-	intel_pmu_lbr_filter(cpuc);
+	intel_pmu_store_lbr(lbr, cpu_lbr_stack(cpuc));
+	intel_pmu_lbr_filter(cpuc, cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3d625a6d7eb..fa0af528cd1e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -594,13 +594,13 @@ static __always_inline struct perf_branch_stack *cpu_lbr_stack(struct cpu_hw_eve
 	return (struct perf_branch_stack *)cpuc->__lbr_stack;
 }
 
-static __always_inline void cpu_init_lbr_stack(struct cpu_hw_events *cpuc, int nr)
+static __always_inline void cpu_init_lbr_stack(struct perf_branch_stack *lbr_stack, int nr)
 {
 	/*
 	 * Initialize the branch-stack count before populating entries[]
 	 * to avoid UBSAN complaints from the __counted_by(nr) flexible array.
 	 */
-	cpu_lbr_stack(cpuc)->nr = nr;
+	lbr_stack->nr = nr;
 }
 
 #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
@@ -1207,7 +1207,8 @@ struct x86_pmu {
 	unsigned int	lbr_counters:4;
 
 	void		(*lbr_reset)(void);
-	void		(*lbr_read)(struct cpu_hw_events *cpuc);
+	void		(*lbr_read)(struct cpu_hw_events *cpuc,
+				    struct perf_branch_stack *lbr_stack);
 	void		(*lbr_save)(void *ctx);
 	void		(*lbr_restore)(void *ctx);
 
@@ -2007,11 +2008,14 @@ void intel_pmu_lbr_enable_all(bool pmi);
 
 void intel_pmu_lbr_disable_all(void);
 
-void intel_pmu_lbr_read(void);
+void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
+			u64 *lbr_counters);
 
-void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack);
 
-void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack);
 
 void intel_pmu_lbr_save(void *ctx);
 
-- 
2.34.1

