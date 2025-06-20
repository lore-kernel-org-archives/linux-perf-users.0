Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29723182F;
	Fri, 20 Jun 2025 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404585; cv=none; b=pkF7etAOyrT+03sdqsertvnQ1vAJ450Pu+CRNZqC4sLO+lb+95gGThMilpP1YcHriy8YpTFRtjKZZNs1GK12XaZUCAh9DDpxcg+cdWyLSkRRbiUkbuEF0erBN417DKxVlU+yGwup7cBWG7VP/w6LqBpgQZfVeQ27Gk1yqtOltnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404585; c=relaxed/simple;
	bh=U6x+FY/Q/JuPWtCjRw8pMzhGhJFnV5UPuzlO+eirDgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR6FFiN+KkLr8a97279BljdELtogMeP/DQFrNb/RTUmQiYcHLK95FbYksGmtGXwusQFzlSyh83gx/ZBwsdU1n073rhRzhYGbvNuVERc2m0GX9HTjX88xpDfKJOgaNVZ4q1IIx+9H4Mh330yJSOzcBfdvSXLqBhEMkbstZJhdmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQrxm4SH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQrxm4SH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404583; x=1781940583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U6x+FY/Q/JuPWtCjRw8pMzhGhJFnV5UPuzlO+eirDgQ=;
  b=iQrxm4SHmCRn1KWes24aF8uk20LWrSPA8bPXGd/uoKBaNvvuqrMAsyaw
   btgdXLui5ogzMlbVD//T3XMNqGL8Y/rt8B5AXbbTWrPbwEIy/pHep0ScL
   dkmn5/0ZIZVGs5FBHMB/8uwnsFrub7cVnFR3Le8XtjKcYcR/frsatOh+9
   ipdbyqXA7m7+WBpu7Y5+53Bv3/LlNGn//Wu43/u1oeIz5C8Lec8ZnKYxD
   xJ7VKqg6wmViCaqLX1wfmNdyhKu9ZVZZ0C1JgMwC7GL9emSmUnZa1OYgv
   CrM+fYbOUOFSIiO518uK922dEgk1XIGry4/c3K+qGN1smv/4rYFl4/30b
   g==;
X-CSE-ConnectionGUID: 3rFsDcALQZ22hh/QVJ/Htw==
X-CSE-MsgGUID: BETwPhmISQaoLA2oE8qZAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887808"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887808"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:43 -0700
X-CSE-ConnectionGUID: +oFe4xKqR3Sh64TmLVU6eA==
X-CSE-MsgGUID: ViW2SdLVQXKFfqZTs3cwbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156651066"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:40 -0700
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 10/13] perf/x86/intel: Add counter group support for arch-PEBS
Date: Fri, 20 Jun 2025 10:39:06 +0000
Message-ID: <20250620103909.1586595-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Base on previous adaptive PEBS counter snapshot support, add counter
group support for architectural PEBS. Since arch-PEBS shares same
counter group layout with adaptive PEBS, directly reuse
__setup_pebs_counter_group() helper to process arch-PEBS counter group.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 38 ++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c        | 29 ++++++++++++++++++++---
 arch/x86/include/asm/msr-index.h  |  6 +++++
 arch/x86/include/asm/perf_event.h | 13 ++++++++---
 4 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index faea1d42ce0c..b37e09ce3f0c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3012,6 +3012,17 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 
 			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
 				ext |= ARCH_PEBS_LBR & cap.caps;
+
+			if (pebs_data_cfg &
+			    (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHIFT))
+				ext |= ARCH_PEBS_CNTR_GP & cap.caps;
+
+			if (pebs_data_cfg &
+			    (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT))
+				ext |= ARCH_PEBS_CNTR_FIXED & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_METRICS)
+				ext |= ARCH_PEBS_CNTR_METRICS & cap.caps;
 		}
 
 		if (cpuc->n_pebs == cpuc->n_large_pebs)
@@ -3037,6 +3048,9 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 		}
 	}
 
+	if (is_pebs_counter_event_group(event))
+		ext |= ARCH_PEBS_CNTR_ALLOW;
+
 	if (cpuc->cfg_c_val[hwc->idx] != ext)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
@@ -4321,6 +4335,20 @@ static bool intel_pmu_is_acr_group(struct perf_event *event)
 	return false;
 }
 
+static inline bool intel_pmu_has_pebs_counter_group(struct pmu *pmu)
+{
+	u64 caps;
+
+	if (x86_pmu.intel_cap.pebs_format >= 6 && x86_pmu.intel_cap.pebs_baseline)
+		return true;
+
+	caps = hybrid(pmu, arch_pebs_cap).caps;
+	if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_CNTR_MASK))
+		return true;
+
+	return false;
+}
+
 static inline void intel_pmu_set_acr_cntr_constr(struct perf_event *event,
 						 u64 *cause_mask, int *num)
 {
@@ -4469,8 +4497,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
-	    (x86_pmu.intel_cap.pebs_format >= 6) &&
-	    x86_pmu.intel_cap.pebs_baseline &&
+	    intel_pmu_has_pebs_counter_group(event->pmu) &&
 	    is_sampling_event(event) &&
 	    event->attr.precise_ip)
 		event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
@@ -5412,6 +5439,8 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 	x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 	if (caps & ARCH_PEBS_LBR)
 		x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
+	if (caps & ARCH_PEBS_CNTR_MASK)
+		x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
 
 	if (!(caps & ARCH_PEBS_AUX))
 		x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;
@@ -7123,8 +7152,11 @@ __init int intel_pmu_init(void)
 	 * Many features on and after V6 require dynamic constraint,
 	 * e.g., Arch PEBS, ACR.
 	 */
-	if (version >= 6)
+	if (version >= 6) {
 		x86_pmu.flags |= PMU_FL_DYN_CONSTRAINT;
+		x86_pmu.late_setup = intel_pmu_late_setup;
+	}
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2989893b982a..e378f33206ed 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1519,13 +1519,20 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 
 u64 intel_get_arch_pebs_data_config(struct perf_event *event)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 pebs_data_cfg = 0;
+	u64 cntr_mask;
 
 	if (WARN_ON(event->hw.idx < 0 || event->hw.idx >= X86_PMC_IDX_MAX))
 		return 0;
 
 	pebs_data_cfg |= pebs_update_adaptive_cfg(event);
 
+	cntr_mask = (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHIFT) |
+		    (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT) |
+		    PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS;
+	pebs_data_cfg |= cpuc->pebs_data_cfg & cntr_mask;
+
 	return pebs_data_cfg;
 }
 
@@ -2430,6 +2437,24 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		}
 	}
 
+	if (header->cntr) {
+		struct arch_pebs_cntr_header *cntr = next_record;
+		unsigned int nr;
+
+		next_record += sizeof(struct arch_pebs_cntr_header);
+
+		if (is_pebs_counter_event_group(event)) {
+			__setup_pebs_counter_group(cpuc, event,
+				(struct pebs_cntr_header *)cntr, next_record);
+			data->sample_flags |= PERF_SAMPLE_READ;
+		}
+
+		nr = hweight32(cntr->cntr) + hweight32(cntr->fixed);
+		if (cntr->metrics == INTEL_CNTR_METRICS)
+			nr += 2;
+		next_record += nr * sizeof(u64);
+	}
+
 	/* Parse followed fragments if there are. */
 	if (arch_pebs_record_continued(header)) {
 		at = at + header->size;
@@ -3076,10 +3101,8 @@ static void __init intel_ds_pebs_init(void)
 			break;
 
 		case 6:
-			if (x86_pmu.intel_cap.pebs_baseline) {
+			if (x86_pmu.intel_cap.pebs_baseline)
 				x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
-				x86_pmu.late_setup = intel_pmu_late_setup;
-			}
 			fallthrough;
 		case 5:
 			x86_pmu.pebs_ept = 1;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 07a0e03feb5e..4de9c0d22fa1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -329,12 +329,18 @@
 #define ARCH_PEBS_INDEX_WR_SHIFT	4
 
 #define ARCH_PEBS_RELOAD		0xffffffff
+#define ARCH_PEBS_CNTR_ALLOW		BIT_ULL(35)
+#define ARCH_PEBS_CNTR_GP		BIT_ULL(36)
+#define ARCH_PEBS_CNTR_FIXED		BIT_ULL(37)
+#define ARCH_PEBS_CNTR_METRICS		BIT_ULL(38)
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
+#define ARCH_PEBS_CNTR_MASK		(ARCH_PEBS_CNTR_GP | ARCH_PEBS_CNTR_FIXED | \
+					 ARCH_PEBS_CNTR_METRICS)
 
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0f70d13780fe..380f89fd5dac 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -137,16 +137,16 @@
 #define ARCH_PERFMON_EVENTS_COUNT			7
 
 #define PEBS_DATACFG_MEMINFO	BIT_ULL(0)
-#define PEBS_DATACFG_GP	BIT_ULL(1)
+#define PEBS_DATACFG_GP		BIT_ULL(1)
 #define PEBS_DATACFG_XMMS	BIT_ULL(2)
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
-#define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR	BIT_ULL(4)
+#define PEBS_DATACFG_METRICS	BIT_ULL(5)
+#define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR_SHIFT	32
 #define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
 #define PEBS_DATACFG_FIX_SHIFT	48
 #define PEBS_DATACFG_FIX_MASK	GENMASK_ULL(7, 0)
-#define PEBS_DATACFG_METRICS	BIT_ULL(5)
 
 /* Steal the highest bit of pebs_data_cfg for SW usage */
 #define PEBS_UPDATE_DS_SW	BIT_ULL(63)
@@ -599,6 +599,13 @@ struct arch_pebs_lbr_header {
 	u64 ler_info;
 };
 
+struct arch_pebs_cntr_header {
+	u32 cntr;
+	u32 fixed;
+	u32 metrics;
+	u32 reserved;
+};
+
 /*
  * AMD Extended Performance Monitoring and Debug cpuid feature detection
  */
-- 
2.43.0

