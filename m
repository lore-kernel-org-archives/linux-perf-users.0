Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249249;
	b=JrFfqYJ21eXi9colHvlzFGOSKw58W1nWpve5NfihAVQzqv/9jPV3mjTGdc66txmKW0P1
	 01zG5D++NjMpZAYU0cbsHuDKpCakTunj0fo8qzQ3fvj2bfGcPTPf8G0WcG/xmUumus5uz
	 +S+oWGqG4MpAfFMmg1vz8LuTUzKHmlW/eIOnu9dW3z2380VT/GRBL9Bk66kSqGA4PQGNF
	 2jKxqKbhmPmUIPbVKcwP1nrwGXCKVs3ujy+I8FqioUWQdmWLo8l+l1vseyNqEQAe2NdF2
	 uerCu2PC2mVuotoLXRTo6mz8DP1zBy+NRYNtMLpNCeLf7N1Gt+/AIQN77IdxApHGF9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249249;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IKlli8/q9+SUQM5jRLqapt90Xe7P/TVOyAnXbUrWVP0=;
	b=UT58apzMjPOUXtOaxapgFt4JPxXZnSbOJU9EjL9yoz2gqc2d9PpV/peohjSVYElxWiP5
	 L4HUmIFcN+2IbSMa52tkfU4Z9pM1itwHpw2TRD77rgTFDy2VaJtFL4mYu+eWF+dqjuz+4
	 4LIjfJ8APE6m441Hr7sMfV7YVA7LAJSykklComTNkshF3bEeTpwQOBf8VVHuECucPbq8q
	 YEmeMCskg/yGoOJ/6NTwseUWF3MT+tfbAKhNxKRwaEOzsAwhUiiERtN4fQrrjmzZFxcAz
	 VAHQHoKQ0CUZsxMHnPKaUG5on98Zy1vdan5g7v83AtfA5MSBbPfBWR4kzyAXVlEDKZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="GdA8jZv/";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48230606A31E;
	Thu, 29 Oct 2026 04:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48230606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GdA8jZv/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249250; x=1824785250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8LwEBZTOqsfUo6iAAGTv5Lp9NkP58BtHvSg4Auolnew=;
  b=GdA8jZv/6s4iz2BSG9lu8QCS2R34V4VC2Bl/MaVhvV/h1wtu+XZuzg6x
   UOUtGdgOTkSKUd3//zTEbvyy6muWKxVWyh04g+caSXp3IoN8g9zKp77OY
   idBkmpsSin2V5i+hUEOT5Q3QmyPygtzBmkjrPocPHpOE+RF3Bv/5/80Bk
   Gy0u3AEWCWCycXvCUChSHVSc7nJgHZ3qCkPJ9rcQasaQ399x60QvBzVqr
   buH2fqhzQgscIu6Egtk+dFIY4HejVKe3Mjf79ROKvICJq7x62jB141XBj
   R0t2zogdQQlXoCy0VdTDf9ksDqWwguXxuKUabRLsBtVUFdHsi3tERtBsx
   A==;
X-CSE-ConnectionGUID: SZMzwUMzTZKfzd1ESziRaA==
X-CSE-MsgGUID: PyFuTz4GQCunVcNU6dhRfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986301"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986301"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:29 -0700
X-CSE-ConnectionGUID: mseqp4qHSN+BPjNvr3TQKQ==
X-CSE-MsgGUID: 4mGhFe1KQTqhdDKInxBQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420488"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:24 -0700
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
Subject: [Patch v5 10/18] perf/x86/intel: Allow LBR read helpers to operate on explicit stacks
Date: Thu, 29 Oct 2026 12:39:06 +0800
Message-Id: <20261029043914.1395147-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c |   9 ++-
 arch/x86/events/intel/lbr.c  | 113 ++++++++++++++++++++---------------
 arch/x86/events/perf_event.h |  16 +++--
 3 files changed, 84 insertions(+), 54 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a67297148bb6..5eda551cc9f2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,10 +2826,12 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	intel_pmu_lbr_read();
+	intel_pmu_lbr_read(&cpuc->lbr_stack,
+			   cpuc->lbr_entries, cpuc->lbr_counters);
 	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
-	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+	memcpy(entries, cpuc->lbr_entries,
+	       sizeof(struct perf_branch_entry) * cnt);
 
 	/*
 	 * Do not blindly call intel_pmu_enable_all() to re-enable LBR.
@@ -4061,7 +4063,8 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	intel_pmu_lbr_read();
+	intel_pmu_lbr_read(&cpuc->lbr_stack,
+			   cpuc->lbr_entries, cpuc->lbr_counters);
 
 	/*
 	 * Do not clear the LBR frozen status here; keep LBR frozen
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ee724b28d90c..63f0504f9d2a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -105,7 +105,10 @@
 
 #define ARCH_LBR_CTL_MASK			0x7f000e
 
-static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
+static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
+				 struct perf_branch_stack *lbr_stack,
+				 struct perf_branch_entry *lbr_entries,
+				 u64 *lbr_counters);
 
 static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
 {
@@ -741,10 +744,12 @@ void intel_pmu_lbr_disable_all(void)
 	}
 }
 
-void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack,
+			   struct perf_branch_entry *lbr_entries)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
-	struct perf_branch_entry *br = cpuc->lbr_entries;
+	struct perf_branch_entry *br = lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 
@@ -766,8 +771,8 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		};
 		br++;
 	}
-	cpuc->lbr_stack.nr = i;
-	cpuc->lbr_stack.hw_idx = tos;
+	lbr_stack->nr = i;
+	lbr_stack->hw_idx = tos;
 }
 
 /*
@@ -775,11 +780,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  * is the same as the linear address, allowing us to merge the LIP and EIP
  * LBR formats.
  */
-void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack,
+			   struct perf_branch_entry *lbr_entries)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
-	struct perf_branch_entry *br = cpuc->lbr_entries;
+	struct perf_branch_entry *br = lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 	int out = 0;
@@ -862,8 +869,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		};
 		out++;
 	}
-	cpuc->lbr_stack.nr = out;
-	cpuc->lbr_stack.hw_idx = tos;
+	lbr_stack->nr = out;
+	lbr_stack->hw_idx = tos;
 }
 
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
@@ -904,8 +911,9 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 
 static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS);
 
-static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
-				struct lbr_entry *entries)
+static void intel_pmu_store_lbr(struct lbr_entry *entries,
+				struct perf_branch_stack *lbr_stack,
+				struct perf_branch_entry *lbr_entries)
 {
 	struct perf_branch_entry *e;
 	struct lbr_entry *lbr;
@@ -915,7 +923,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		lbr = entries ? &entries[i] : NULL;
-		e = &cpuc->lbr_entries[i];
+		e = &lbr_entries[i];
 
 		from = rdlbr_from(i, lbr);
 		/*
@@ -939,18 +947,18 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 			.cycles		= get_lbr_cycles(info),
 			.type		= get_lbr_br_type(info),
 			/*
-			 * Leverage the reserved field of
-			 * cpuc->lbr_entries[i] to temporarily store the
-			 * branch counters information. The later code will
-			 * decide what content can be disclosed to the perf
-			 * tool. Pleae see intel_pmu_lbr_counters_reorder().
+			 * Leverage the reserved field of lbr_entries[i] to
+			 * temporarily store the branch counters information.
+			 * The later code will decide what content can be
+			 * disclosed to the perf tool.
+			 * Please see intel_pmu_lbr_counters_reorder().
 			 */
 			.reserved	= (info >> LBR_INFO_BR_CNTR_OFFSET) &
 					  LBR_INFO_BR_CNTR_FULL_MASK,
 		};
 	}
 
-	cpuc->lbr_stack.nr = i;
+	lbr_stack->nr = i;
 }
 
 /*
@@ -1001,37 +1009,44 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
-static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
+static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc,
+				    struct perf_branch_stack *lbr_stack,
+				    struct perf_branch_entry *lbr_entries)
 {
-	intel_pmu_store_lbr(cpuc, NULL);
+	intel_pmu_store_lbr(NULL, lbr_stack, lbr_entries);
 }
 
-static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
+static void
+intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc,
+			      struct perf_branch_stack *lbr_stack,
+			      struct perf_branch_entry *lbr_entries)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
 
 	if (!xsave) {
-		intel_pmu_store_lbr(cpuc, NULL);
+		intel_pmu_store_lbr(NULL, lbr_stack, lbr_entries);
 		return;
 	}
 	xsave->header.xfeatures = 0;
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	if (xsave->header.xfeatures & XFEATURE_MASK_LBR) {
-		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+		intel_pmu_store_lbr(xsave->lbr.entries, lbr_stack, lbr_entries);
 	} else {
 		/* Clear the LBR stack to avoid leaking stale entries. */
-		cpuc->lbr_stack.nr = 0;
+		lbr_stack->nr = 0;
 	}
 }
 
-void intel_pmu_lbr_read(void)
+void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
+			struct perf_branch_entry *lbr_entries,
+			u64 *lbr_counters)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!cpuc->lbr_users || vlbr_exclude_host()) {
-		/* Reset lbr_stack.nr to prevent stale data leakage. */
-		cpuc->lbr_stack.nr = 0;
+		/* Reset lbr_stack->nr to prevent stale data leakage. */
+		lbr_stack->nr = 0;
 		return;
 	}
 
@@ -1044,9 +1059,9 @@ void intel_pmu_lbr_read(void)
 	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
-	x86_pmu.lbr_read(cpuc);
+	x86_pmu.lbr_read(cpuc, lbr_stack, lbr_entries);
 
-	intel_pmu_lbr_filter(cpuc);
+	intel_pmu_lbr_filter(cpuc, lbr_stack, lbr_entries, lbr_counters);
 }
 
 /*
@@ -1229,7 +1244,10 @@ static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
  * in PERF_SAMPLE_BRANCH_STACK sample may vary.
  */
 static void
-intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
+intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
+		     struct perf_branch_stack *lbr_stack,
+		     struct perf_branch_entry *lbr_entries,
+		     u64 *lbr_counters)
 {
 	u64 from, to;
 	int br_sel = cpuc->br_sel;
@@ -1241,11 +1259,11 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+	for (i = 0; i < lbr_stack->nr; i++) {
 
-		from = cpuc->lbr_entries[i].from;
-		to = cpuc->lbr_entries[i].to;
-		type = cpuc->lbr_entries[i].type;
+		from = lbr_entries[i].from;
+		to = lbr_entries[i].to;
+		type = lbr_entries[i].type;
 
 		/*
 		 * Parse the branch type recorded in LBR_x_INFO MSR.
@@ -1257,9 +1275,9 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 			type = arch_lbr_br_type_map[type] | to_plm;
 		} else
-			type = branch_type(from, to, cpuc->lbr_entries[i].abort);
+			type = branch_type(from, to, lbr_entries[i].abort);
 		if (type != X86_BR_NONE && (br_sel & X86_BR_ANYTX)) {
-			if (cpuc->lbr_entries[i].in_tx)
+			if (lbr_entries[i].in_tx)
 				type |= X86_BR_IN_TX;
 			else
 				type |= X86_BR_NO_TX;
@@ -1273,27 +1291,27 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		 */
 		if (type == X86_BR_NONE || (br_sel & type) != type ||
 		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
-			cpuc->lbr_entries[i].from = 0;
+			lbr_entries[i].from = 0;
 			compress = true;
 		}
 
 		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
-			cpuc->lbr_entries[i].type = common_branch_type(type);
+			lbr_entries[i].type = common_branch_type(type);
 	}
 
 	if (!compress)
 		return;
 
 	/* remove all entries with from=0 */
-	for (i = 0; i < cpuc->lbr_stack.nr; ) {
-		if (!cpuc->lbr_entries[i].from) {
+	for (i = 0; i < lbr_stack->nr; ) {
+		if (!lbr_entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr) {
-				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
-				cpuc->lbr_counters[j-1] = cpuc->lbr_counters[j];
+			while (++j < lbr_stack->nr) {
+				lbr_entries[j-1] = lbr_entries[j];
+				lbr_counters[j-1] = lbr_counters[j];
 			}
-			cpuc->lbr_stack.nr--;
-			if (!cpuc->lbr_entries[i].from)
+			lbr_stack->nr--;
+			if (!lbr_entries[i].from)
 				continue;
 		}
 		i++;
@@ -1311,8 +1329,9 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
 
-	intel_pmu_store_lbr(cpuc, lbr);
-	intel_pmu_lbr_filter(cpuc);
+	intel_pmu_store_lbr(lbr, &cpuc->lbr_stack, cpuc->lbr_entries);
+	intel_pmu_lbr_filter(cpuc, &cpuc->lbr_stack,
+			     cpuc->lbr_entries, cpuc->lbr_counters);
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a4aab8130e92..2b942a445038 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1192,7 +1192,9 @@ struct x86_pmu {
 	unsigned int	lbr_counters:4;
 
 	void		(*lbr_reset)(void);
-	void		(*lbr_read)(struct cpu_hw_events *cpuc);
+	void		(*lbr_read)(struct cpu_hw_events *cpuc,
+				    struct perf_branch_stack *lbr_stack,
+				    struct perf_branch_entry *lbr_entries);
 	void		(*lbr_save)(void *ctx);
 	void		(*lbr_restore)(void *ctx);
 
@@ -1992,11 +1994,17 @@ void intel_pmu_lbr_enable_all(bool pmi);
 
 void intel_pmu_lbr_disable_all(void);
 
-void intel_pmu_lbr_read(void);
+void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
+			struct perf_branch_entry *lbr_entries,
+			u64 *lbr_counters);
 
-void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack,
+			   struct perf_branch_entry *lbr_entries);
 
-void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack,
+			   struct perf_branch_entry *lbr_entries);
 
 void intel_pmu_lbr_save(void *ctx);
 
-- 
2.34.1

