Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972226;
	b=Qap85buw356yft/GUBxnzgUM6yGeQPxzGHW3gsGYAxYShN44h60Qjxe+QA8Gt0XBKbW9
	 3skt+zQdx82EAVy1CE4bQZxei2i0P5IQvwg5ClQ/4qR8kzqm7XVG1TF4qSgr/Mhn8q1Jv
	 CpTONGBGGArdTi9jHYooUEYuC75pGhTcZq6oCBGM3Jcl6AECyqRj4W6Ty26IqDF7Al3mz
	 Z3uEcPCiIn/hEkrlkjw+7A6g0bFi5F+BwqPWgFILX4pWuI17plkC6VVSJ623hN2vttVoB
	 ltLiLbJxDHvd8xSsig49Ody/RbaXM6KXRxSELSYvf8ib78mYflMQ9zirvqy3mQX/P7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972226;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y2UQF/Rr0loIBHyT4U2Gln87hooKe028lrGEMMbHpkU=;
	b=ona32AzhOkV9KUiMUD+7xbI9g2HHsMjXnfPr/52eKRbq7toy8YoAFhOG1ueyZHtUl4wC
	 uUCSwLVDvtlR3rl6+CoPjNSruclt2pDRyOqVpgt9Bh2aCjSsKalOTdcg1urFF4hHvBBlt
	 1X31vO4D8G8TIdNqwtmiiBoWzCiyqzWM1uuVSooZ5qedGN7mlQMkHyFLtqFU5HrFS6wMz
	 zy8/KxWMy9yU7Or0p8Pru9wzLgu3WMRSHbGI0UvWdQTPLaBFaYnDiFG28eNZQWNbo4ev3
	 U9fQnKfhpJtEqvgnjWNzgYTqxDv4gA+GX9uXAIEH7TX0EdvXf/GjqJzKQnc9KC6MjQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fA9RASi8;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF460A3803;
	Wed, 18 Nov 2026 03:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFF460A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fA9RASi8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972226; x=1826508226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egMZjOZENxd8kcBv2ni/WQe9H/9824ZK6sIG92gw9cw=;
  b=fA9RASi8yxtfjvty16wN3qnDRH2IpF3RGMBsgr90WqdRptwkGcMCFs8b
   4yBej0cnruaT0t9xmP2jsmNVCukWU/y8vwjUVksQbuFw/6t3ufcbQGy4x
   fTJtKH2HMieyaZZrDyIvsHjhxa/ytTZStyvbW7fDNkokQNFI2vSWxPo4F
   WSs1Vk+OPzYRamFqL6R6IWenc2teZXIGmYtOgy193IHgWk7K0MNcHPOvc
   rZIlxiqndulGNZYIcK2Z3WL/Kj6XdBpJ65+Qlyl2ibAoNEk/r++yQE73S
   WgTlpc0+6T9lRlz4h96SoZY/wYc8dmQ77m+EM+k2gUbpjfpqTzaAVYsCb
   w==;
X-CSE-ConnectionGUID: Do05FnSETrCoR6gB4E7xPQ==
X-CSE-MsgGUID: 5fLZVbuZSOqHbQyS1V+PwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629924"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629924"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:42 -0800
X-CSE-ConnectionGUID: FxiVx9h4Qmqcw52qOqYdPg==
X-CSE-MsgGUID: rboYNfiETum35RR/ASYBFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894258"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:38 -0800
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
Subject: [Patch v7 11/24] perf/x86/intel: Allow LBR read helpers to operate on explicit stacks
Date: Wed, 18 Nov 2026 11:14:40 +0800
Message-Id: <20261118031453.1353625-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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
cpuc->__lbr_stack, and therefore cannot be reused for other LBR
stacks that may be in use. Extend the *_lbr_read() helpers to take
an explicit LBR stack argument, so they can operate on any LBR stack
instead of only the default one.

Do the same for intel_pmu_store_lbr() and intel_pmu_lbr_filter(), and
pass the LBR counters array explicitly as well, since it is filtered
together with the stack.

No functional change intended.

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
index 6547555192cf..357c8eb7ee08 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,7 +2826,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	intel_pmu_lbr_read();
+	intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 	cnt = min_t(unsigned int, cnt, cpu_lbr_stack(cpuc)->nr);
 
 	memcpy(entries, cpu_lbr_stack(cpuc)->entries,
@@ -4063,7 +4063,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	intel_pmu_lbr_read();
+	intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 
 	/*
 	 * Keep the LBR state frozen throughout PMI handling so that the PMI
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 15d779f92553..b60719adcc1c 100644
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
@@ -740,13 +742,14 @@ void intel_pmu_lbr_disable_all(void)
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
@@ -759,13 +762,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
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
@@ -773,7 +776,8 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  * is the same as the linear address, allowing us to merge the LIP and EIP
  * LBR formats.
  */
-void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
+			   struct perf_branch_stack *lbr_stack)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
@@ -788,7 +792,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 			call_stack = true;
 	}
 
-	cpu_init_lbr_stack(cpuc, num);
+	cpu_init_lbr_stack(lbr_stack, num);
 	for (i = 0; i < num; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
 		u64 from, to, mis = 0, pred = 0, in_tx = 0, abort = 0;
@@ -849,7 +853,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		cpu_lbr_stack(cpuc)->entries[out] = (struct perf_branch_entry){
+		lbr_stack->entries[out] = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mis,
@@ -860,8 +864,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		};
 		out++;
 	}
-	cpu_lbr_stack(cpuc)->nr = out;
-	cpu_lbr_stack(cpuc)->hw_idx = tos;
+	lbr_stack->nr = out;
+	lbr_stack->hw_idx = tos;
 }
 
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
@@ -902,17 +906,19 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 
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
@@ -926,7 +932,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 		mispred = get_lbr_mispred(info);
 
-		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
+		*e = (struct perf_branch_entry){
 			.from		= from,
 			.to		= to,
 			.mispred	= mispred,
@@ -947,7 +953,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		};
 	}
 
-	cpu_lbr_stack(cpuc)->nr = i;
+	lbr_stack->nr = i;
 }
 
 /*
@@ -998,37 +1004,41 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
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
 
@@ -1041,9 +1051,9 @@ void intel_pmu_lbr_read(void)
 	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
-	x86_pmu.lbr_read(cpuc);
+	x86_pmu.lbr_read(cpuc, lbr_stack);
 
-	intel_pmu_lbr_filter(cpuc);
+	intel_pmu_lbr_filter(cpuc, lbr_stack, lbr_counters);
 }
 
 /*
@@ -1226,7 +1236,9 @@ static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
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
@@ -1239,8 +1251,8 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
-	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
-		struct perf_branch_entry *be = &cpu_lbr_stack(cpuc)->entries[i];
+	for (i = 0; i < lbr_stack->nr; i++) {
+		struct perf_branch_entry *be = &lbr_stack->entries[i];
 
 		from = be->from;
 		to = be->to;
@@ -1284,22 +1296,21 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
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
@@ -1313,8 +1324,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
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

