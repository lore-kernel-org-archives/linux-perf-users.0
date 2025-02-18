Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AE238D42;
	Tue, 18 Feb 2025 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866486; cv=none; b=mG47bbypDFdvyv0v7mFawH1gvZ8XUsBJHxVaeFD2/4mQbLkQhrIsqittgOl04KctxIv/V3YA3Rd1T88YEMx49TljuCrJrj9PatQDxYfO1w56h51M3+wQHT6u8wE0hoJ60o82X9/Xk/e5quInJxq8p7/Jw/COSPfjlPtoM1dOrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866486; c=relaxed/simple;
	bh=Z5N92wD81uTmvTYhJEIIyIeTLg2I592yKs1xpqSjv68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjkQK402wfVR1GreZ9WuhfCE6K8aVj1KSdXFcGa5ippFGlSXTfFTI91zQTdS11CpjdkHK/iPRPZmN1OmgkSd9ncNhWQX+rDpjM8LERMz+e3OM311t5ppQ9jzx7eaI/0LlkwTaXNN2o7qO5KH7I3bc3F7FGGs81nXsMXhiXnEFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dr91vVRp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dr91vVRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866485; x=1771402485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5N92wD81uTmvTYhJEIIyIeTLg2I592yKs1xpqSjv68=;
  b=dr91vVRpxV1MzeaE5y3R6y+i6pr5LSvJhybDJjQe2mp8ojN7O/jqYSWI
   sxAs1j15/+IBU9J24gOJCit1DsNCTkvn+1kfudGbwOEJkWXGg4D5NXzxj
   H2Y+f7sT1TZmqNSfw2L5YqqUhrOD0oxhquslY2FZ3zOHY0h8Yt7qCmCrs
   HlBAb55QBG0Cqng926fzVoFft/Na/+2bE1nRCLoQsUHqd5O2yZhKrPSbA
   uzoy0l6Qp/eu5yPhAL63RSaLm7AHv/a1zQjifQbgyy6GoIdS3dFgMe5ZZ
   UMQYIbEHenNEnv0B986KCZG/IsEFMFKGTj/8HxtysH14IVf8Jah6QNn98
   A==;
X-CSE-ConnectionGUID: u77oPzPyQ1WwIl3dwdIIQg==
X-CSE-MsgGUID: bOnLWAFaR3OnChsQuBihIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200833"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:45 -0800
X-CSE-ConnectionGUID: dRVUB8VPTjmzwPy3n7/yNA==
X-CSE-MsgGUID: nKD0BuiLQD2OQJofHHnN8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166286"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:40 -0800
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
Subject: [Patch v2 16/24] perf/x86/intel: Add counter group support for arch-PEBS
Date: Tue, 18 Feb 2025 15:28:10 +0000
Message-Id: <20250218152818.158614-17-dapeng1.mi@linux.intel.com>
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

Base on previous adaptive PEBS counter snapshot support, add counter
group support for architectural PEBS. Since arch-PEBS shares same
counter group layout with adaptive PEBS, directly reuse
__setup_pebs_counter_group() helper to process arch-PEBS counter group.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 38 ++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c        | 31 +++++++++++++++++++++----
 arch/x86/events/perf_event.h      |  2 ++
 arch/x86/include/asm/msr-index.h  |  6 +++++
 arch/x86/include/asm/perf_event.h | 13 ++++++++---
 5 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b80a66751136..f21d9f283445 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2965,6 +2965,17 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 
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
@@ -2990,6 +3001,9 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 		}
 	}
 
+	if (is_pebs_counter_event_group(event))
+		ext |= ARCH_PEBS_CNTR_ALLOW;
+
 	if (cpuc->cfg_c_val[hwc->idx] != ext)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
@@ -4120,6 +4134,20 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
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
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4242,8 +4270,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
-	    (x86_pmu.intel_cap.pebs_format >= 6) &&
-	    x86_pmu.intel_cap.pebs_baseline &&
+	    intel_pmu_has_pebs_counter_group(event->pmu) &&
 	    is_sampling_event(event) &&
 	    event->attr.precise_ip)
 		event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
@@ -5097,6 +5124,8 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 	x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 	if (caps & ARCH_PEBS_LBR)
 		x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
+	if (caps & ARCH_PEBS_CNTR_MASK)
+		x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
 
 	if (!(caps & ARCH_PEBS_AUX))
 		x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;
@@ -6759,8 +6788,11 @@ __init int intel_pmu_init(void)
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
index cad653706431..4b01beee15f4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1383,7 +1383,7 @@ static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
 }
 
 
-static void intel_pmu_late_setup(void)
+void intel_pmu_late_setup(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event;
@@ -1494,13 +1494,20 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 
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
 
@@ -2411,6 +2418,24 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
@@ -3040,10 +3065,8 @@ static void __init intel_ds_pebs_init(void)
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
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 69c4341f5753..cba7b928fdb2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1697,6 +1697,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_pebs_init(void);
 
+void intel_pmu_late_setup(void);
+
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1e67cb467946..0ca84deb2396 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -319,12 +319,18 @@
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
index d5285bb4b333..461f0e357c9e 100644
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
@@ -602,6 +602,13 @@ struct arch_pebs_lbr_header {
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
2.40.1

