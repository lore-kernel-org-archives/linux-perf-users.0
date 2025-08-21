Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240252EA176;
	Thu, 21 Aug 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748796; cv=none; b=iiwEY5Sqmk0f7BEBUvw8LFDd587m95QexjSbiSKWpEqacAGmBvpvtSv6YAc49hznJyodTj/SpmYLm/WH/2PBqmyavuxBIoUAg0SEc8pWAFdQ5DBLgK6f4L4WTBxswFFyshtvyxNO7vTxtwf+gzwpynvZQAxIgC21I4lsgWy747c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748796; c=relaxed/simple;
	bh=9faie22239VbGmyd7/biTIdAQfN9CS5T5sjAIgFmx5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+rpE1aXiQXrJysKftz5Oimyaclb1M6BNmWA2e6N9IGw7UkKGCBsmrPqd18PkoTz/nDKmikJnMudpslQcpcrUqOvRGt3DYj/WiOWylH9ZUmCo5TcbmJl78huwRcHl755K+QoBRKYEU9JPMY5jInl39yF+GNdX1+nbaYiNXoyS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbbk+hrn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbbk+hrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755748795; x=1787284795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9faie22239VbGmyd7/biTIdAQfN9CS5T5sjAIgFmx5w=;
  b=lbbk+hrnNVyUXciSlIsXOncObKNp7S8dCHLeM6zWibwdNt2YxN0bWGGe
   WhUV7P7tkPq6uIV5FSG+Vy41/zvLgtKsGVv69Bku5Wt1CTm8WBReHupoR
   G28Atd4Ae2AY4iEYb3vfVj6fVDXYcC7DZxfN/lPejAqB/RB3t8wRMt77G
   dpnUqqUiCALT9hb8Bldbt/xALPp94PWFGUA6PBqmKSteUN+NC4takKJEw
   KseP7OyGWv/1mOrjWCdwF62GukEkpTHQoisydqH/jWPQ3/EgyNoRf7GUN
   6KUBKpnjCjVt/q4ICtZgnxoCSfoKXIT5DNattklGywEMoCaH2T9s3X1TY
   Q==;
X-CSE-ConnectionGUID: vi03YlEbTKeCJImGlMVUzA==
X-CSE-MsgGUID: XBTL9NQBSV++VZp2zFOO6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68732016"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68732016"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 20:59:55 -0700
X-CSE-ConnectionGUID: K4AtrDpJQKW1DHKG+1B7OQ==
X-CSE-MsgGUID: TpD5+4D2SrCB+xXNgRl0hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168713157"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2025 20:59:51 -0700
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
Subject: [Patch v6 10/10] perf/x86/intel: Add counter group support for arch-PEBS
Date: Thu, 21 Aug 2025 11:58:05 +0800
Message-Id: <20250821035805.159494-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
References: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
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
index c8cd490aa539..52bf3b4bc938 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3014,6 +3014,17 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 
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
@@ -3038,6 +3049,9 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 		}
 	}
 
+	if (is_pebs_counter_event_group(event))
+		ext |= ARCH_PEBS_CNTR_ALLOW;
+
 	if (cpuc->cfg_c_val[hwc->idx] != ext)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
@@ -4323,6 +4337,20 @@ static bool intel_pmu_is_acr_group(struct perf_event *event)
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
@@ -4471,8 +4499,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
-	    (x86_pmu.intel_cap.pebs_format >= 6) &&
-	    x86_pmu.intel_cap.pebs_baseline &&
+	    intel_pmu_has_pebs_counter_group(event->pmu) &&
 	    is_sampling_event(event) &&
 	    event->attr.precise_ip)
 		event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
@@ -5420,6 +5447,8 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 	x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 	if (caps & ARCH_PEBS_LBR)
 		x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
+	if (caps & ARCH_PEBS_CNTR_MASK)
+		x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
 
 	if (!(caps & ARCH_PEBS_AUX))
 		x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;
@@ -7133,8 +7162,11 @@ __init int intel_pmu_init(void)
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
index 8e1523969341..60871c484717 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1530,13 +1530,20 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 
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
 
@@ -2441,6 +2448,24 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
@@ -3097,10 +3122,8 @@ static void __init intel_ds_pebs_init(void)
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
index 737d51629c03..41852e8690d7 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -331,12 +331,18 @@
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
index 3b3848f0d339..7276ba70c88a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -141,16 +141,16 @@
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
@@ -603,6 +603,13 @@ struct arch_pebs_lbr_header {
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
2.34.1

