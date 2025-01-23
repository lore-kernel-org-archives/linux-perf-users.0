Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1621D63D0;
	Thu, 23 Jan 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613261; cv=none; b=k1xtXmjDXatEpXXlpL/8IByZS6Bn5FUzk1UrKt68Cvy05ExoHwuq54oxUzLbBpzMWGLqruhY389ov2A2KMHxWaCH6n+/c+oGCKqcEyOigFjcsoZGa6rNWxNr6cp4i9DrjupyzF2hjhQRIernN+iYXUHzFN7B+CQAW0rZ6o4JEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613261; c=relaxed/simple;
	bh=k1nX0IQ8iIrSSRgZ/Mtbl7lrtf9QpbxEsHzeK5gUJxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAjHsgk9OYu3XcdGglHPxAE2tLoEMx5hUWpTotlgZIfeaBLiOQR0UanRdTSNQpyOHCMloiuae9grjJRkiQtl4idMmGenLbMNg1IT0/Vqn5pBrsw99/5qnw295js5LvmQ5hKFBoFbTPV5IDar/YmuK813UukdntJRAZZ6MIChHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJx7A53f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJx7A53f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613260; x=1769149260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1nX0IQ8iIrSSRgZ/Mtbl7lrtf9QpbxEsHzeK5gUJxs=;
  b=KJx7A53fq6Kx8Ekottkktbiuqo1/Dynus4D8XLrLhZsXFwzEo1v2dBzZ
   en0iptE/tsYrOoV+nyP02hYrMDDQct/cG1MDtw7bQuEccYBkj0K7TYh0K
   vAc120ScBpBoLGcucHOgTx3NgOKBojM4mblSRVwjTFtmOQ77pTYfZziA+
   wN2to67nYUKQMbMOHADSoZKSJ9tGBeh+ufiwl0If9qsXsNAT6mhAyGY5g
   Q/8EMLZrvXwOTOB+7BNKdol423fK8RacH8oRnC3UmzM8/FSO3SJUodUBl
   Qp3DV89sMpt8IA8b4sBsR5vYA4eO5Di3PB1ToTQlCjyirKxfdcV59tbDp
   g==;
X-CSE-ConnectionGUID: vxmALjdjRrKEN5UsE2RM3w==
X-CSE-MsgGUID: cIJ/FD7JQXuo5MPWTpp2YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513172"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513172"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:59 -0800
X-CSE-ConnectionGUID: XIsdZsY9ShqmZF7CeZ8KZw==
X-CSE-MsgGUID: qqGnYeOJTHCt2lfnm9UCtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334681"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:55 -0800
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
Subject: [PATCH 14/20] perf/x86/intel: Add counter group support for arch-PEBS
Date: Thu, 23 Jan 2025 14:07:15 +0000
Message-Id: <20250123140721.2496639-15-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c      | 36 +++++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c        | 27 ++++++++++++++++++++++-
 arch/x86/events/perf_event.h      |  2 ++
 arch/x86/include/asm/msr-index.h  |  6 ++++++
 arch/x86/include/asm/perf_event.h | 13 ++++++++---
 5 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cb88ae60de8e..9c5b44a73ca2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2955,6 +2955,17 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 
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
@@ -2980,6 +2991,9 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 		}
 	}
 
+	if (is_pebs_counter_event_group(event))
+		ext |= ARCH_PEBS_CNTR_ALLOW;
+
 	if (cpuc->cfg_c_val[hwc->idx] != ext)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
@@ -4131,6 +4145,20 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
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
@@ -4243,8 +4271,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
 
 	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
-	    (x86_pmu.intel_cap.pebs_format >= 6) &&
-	    x86_pmu.intel_cap.pebs_baseline &&
+	    intel_pmu_has_pebs_counter_group(event->pmu) &&
 	    is_sampling_event(event) &&
 	    event->attr.precise_ip)
 		event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
@@ -5089,6 +5116,9 @@ static inline void __intel_update_pmu_caps(struct pmu *pmu)
 
 	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+
+	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_CNTR_MASK)
+		x86_pmu.late_setup = intel_pmu_late_setup;
 }
 
 static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
@@ -5098,6 +5128,8 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 	x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 	if (caps & ARCH_PEBS_LBR)
 		x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
+	if (caps & ARCH_PEBS_CNTR_MASK)
+		x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
 
 	if (!(caps & ARCH_PEBS_AUX))
 		x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a7e101f6f2d6..32a44e3571cb 100644
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
 
@@ -2404,6 +2411,24 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3acb03a5c214..ce8757cb229c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1688,6 +1688,8 @@ void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
+void intel_pmu_late_setup(void);
+
 void intel_pebs_init(void);
 
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a3fad7e910eb..6235df132ee0 100644
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
index cca8a0d68cbc..a38d791cd0c2 100644
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
@@ -573,6 +573,13 @@ struct arch_pebs_lbr_header {
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

