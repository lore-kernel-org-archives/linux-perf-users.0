Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB322B8A5;
	Tue, 18 Feb 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866428; cv=none; b=I1NNLCPNnG1J3B8Js1D6brlnp2exf+1lzx3S32E2L7WotSgVXG0T5ipM5DOhio1tHIBgBbvHzRx6d4a78LBZava4lqPxzaif1Ju85zuyI7lSNNw1SVj98YoRZ4EAqPndWFHUVPtyDLZwNwjJrQ5eQBp2hBo0hqJ2NsMTFxEfKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866428; c=relaxed/simple;
	bh=yB/FZS4m/RR+fQhgDKhzUQfmQoLtxQ+kNlzFJkx9zaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P11wstzSuIvhtbnpJif8VuEZgiuVlkIT5Z7XxniMC8qXh5fJChoh+0WUX5ASlDSZP5XsoxRMwJM87OdxrA7lNtkNWY/rpO2wI1neTavQi0YaqUVon18NV8S4z9vuzS5Z9rgFlz17n0T4sZPVtyRZbgZPL7HHLf+usfIWxh2Ftrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZCrYtXc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZCrYtXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866427; x=1771402427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yB/FZS4m/RR+fQhgDKhzUQfmQoLtxQ+kNlzFJkx9zaw=;
  b=JZCrYtXcIoHaUVVf7hw25oIcjKwae10+79c5+Vh9yeLttLCdIrW4/4gV
   s5+hiv8IC1VfG1zDUXWP4xLiBWCrwEvK3or+69UStN0V650BSrDyVVXRq
   DbanY+PzQxS/oeoCy7zc1fCOcDaSH9LodO9qCpVdK0QdupCVv/Jg+toXR
   Q2IV4PGdNDgskpFYQJCPo1c3rC+H1fK2Di/jv85z+vByGiSen8eCd7quA
   eF7dq/um/bME7kLXYFPyBUF0pHdH25Puf9rPnY7PrSDy2Tcfv43YjLkUS
   XxGeL/drTCym/PQjhvm7h95GgJQ+WYnD+5jFbWfZvvYVSKPYEhjTeA1by
   Q==;
X-CSE-ConnectionGUID: dOR2qsHhTUe8fBSjMb26Zg==
X-CSE-MsgGUID: PyRIImO8RtK3FNpSZ1ixsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200679"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200679"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:13:47 -0800
X-CSE-ConnectionGUID: RrNRhlLIQ4KDPuNbAtcHbQ==
X-CSE-MsgGUID: KVMIirJrQryr9P5uge/b2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166074"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:13:43 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: [Patch v2 01/24] perf/x86: Add dynamic constraint
Date: Tue, 18 Feb 2025 15:27:55 +0000
Message-Id: <20250218152818.158614-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

More and more features require a dynamic event constraint, e.g., branch
counter logging, auto counter reload, Arch PEBS, etc.

Add a generic flag, PMU_FL_DYN_CONSTRAINT, to indicate the case. It
avoids keeping adding the individual flag in intel_cpuc_prepare().

Add a variable dyn_constraint in the struct hw_perf_event to track the
dynamic constraint of the event. Apply it if it's updated.

Apply the generic dynamic constraint for branch counter logging.
Many features on and after V6 require dynamic constraint. So
unconditionally set the flag for V6+.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  1 +
 arch/x86/events/intel/core.c | 21 +++++++++++++++------
 arch/x86/events/intel/lbr.c  |  2 +-
 arch/x86/events/perf_event.h |  1 +
 include/linux/perf_event.h   |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b6430e5a77b..883e0ee893cb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -675,6 +675,7 @@ static int __x86_pmu_event_init(struct perf_event *event)
 	event->hw.idx = -1;
 	event->hw.last_cpu = -1;
 	event->hw.last_tag = ~0ULL;
+	event->hw.dyn_constraint = ~0ULL;
 
 	/* mark unused */
 	event->hw.extra_reg.idx = EXTRA_REG_NONE;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a9b4f1099a86..5570d97b8f4f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3736,10 +3736,9 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (cpuc->excl_cntrs)
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
 
-	/* Not all counters support the branch counter feature. */
-	if (branch_sample_counters(event)) {
+	if (event->hw.dyn_constraint != ~0ULL) {
 		c2 = dyn_constraint(cpuc, c2, idx);
-		c2->idxmsk64 &= x86_pmu.lbr_counters;
+		c2->idxmsk64 &= event->hw.dyn_constraint;
 		c2->weight = hweight64(c2->idxmsk64);
 	}
 
@@ -4056,15 +4055,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		leader = event->group_leader;
 		if (branch_sample_call_stack(leader))
 			return -EINVAL;
-		if (branch_sample_counters(leader))
+		if (branch_sample_counters(leader)) {
 			num++;
+			leader->hw.dyn_constraint &= x86_pmu.lbr_counters;
+		}
 		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 
 		for_each_sibling_event(sibling, leader) {
 			if (branch_sample_call_stack(sibling))
 				return -EINVAL;
-			if (branch_sample_counters(sibling))
+			if (branch_sample_counters(sibling)) {
 				num++;
+				sibling->hw.dyn_constraint &= x86_pmu.lbr_counters;
+			}
 		}
 
 		if (num > fls(x86_pmu.lbr_counters))
@@ -4864,7 +4867,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_BR_CNTR)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_DYN_CONSTRAINT)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
@@ -6582,6 +6585,12 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
 
+	/*
+	 * Many features on and after V6 require dynamic constraint,
+	 * e.g., Arch PEBS, ACR.
+	 */
+	if (version >= 6)
+		x86_pmu.flags |= PMU_FL_DYN_CONSTRAINT;
 	/*
 	 * Install the hw-cache-events table:
 	 */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dc641b50814e..743dcc322085 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1609,7 +1609,7 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_nr = lbr_nr;
 
 	if (!!x86_pmu.lbr_counters)
-		x86_pmu.flags |= PMU_FL_BR_CNTR;
+		x86_pmu.flags |= PMU_FL_BR_CNTR | PMU_FL_DYN_CONSTRAINT;
 
 	if (x86_pmu.lbr_mispred)
 		static_branch_enable(&x86_lbr_mispred);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a698e6484b3b..f4693409e191 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1066,6 +1066,7 @@ do {									\
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
+#define PMU_FL_DYN_CONSTRAINT	0x800 /* Needs dynamic constraint */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d07bc1193f3..c381ea7135df 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -158,6 +158,7 @@ struct hw_perf_event {
 		struct { /* hardware */
 			u64		config;
 			u64		last_tag;
+			u64		dyn_constraint;
 			unsigned long	config_base;
 			unsigned long	event_base;
 			int		event_base_rdpmc;
-- 
2.40.1

