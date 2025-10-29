Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D13563F8;
	Wed, 29 Oct 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733480; cv=none; b=In9ohqsqk/XOehZh8C4a7yxAS0bFJImRIfdDssADpSqYrcI4sdSC2D55AhPJ/Anix/S3yuHhSjqCS8x5YzAJ1/CVisCvmLPrOg5l3xAgiCgTR7401Zv47g5LgOrGY3uX2xMTGSWyjGtEa7T4UND9dTRpf+7fhMwxKxIfXu7wg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733480; c=relaxed/simple;
	bh=AoJ14RsIRznaYhxbsXiq7kUBAjnWYFH5zXPaMAq2kmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAJ7NfRhmwAuFrzbJvQ/+qprIRotg2nJ+GPHOqOnUdFj4tWoT1Wmdu+8FW+F9vAnA7IkEqYiDjsfWQjGyy6exkrXWfxgHGlXfcGYEOuceORMsu7bpPeJDXXyedcgjZqH3jt4ow2LYsHDG88C7Ie9rFEm3/k65GN2tWxh/FTqtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gz8Hutgx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gz8Hutgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761733478; x=1793269478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AoJ14RsIRznaYhxbsXiq7kUBAjnWYFH5zXPaMAq2kmo=;
  b=gz8HutgxRqCbO9Ix09xMgUgpTGkIUkVIbGaRNxnVZa4C7uKGdVTrRQUo
   wVtN1swe8nFcYDFSdp0UBCLfKomQ6+YYZhdZsve7hKEWH1fResCWVS4R+
   bm5T0xuK2dkj78bbxjrNoMuAPfAeyt8PGA33wCl6nus0hzQvD+txByX//
   34xxVan1BV5X3oRwEQRrgiPzAnvUnGa9khbkNIAj1gjwSMn/lGrDEtB7G
   S6OW2crQLs91mqFHgFp6mVZB3FmP/a+dl4RMXTGxd8C9+aw080os7C+dm
   xohK9CGFU7ex52b3oG5U7CO3s9wiZNqwbgnOnDPXzTINlEJRDmz8gWybP
   w==;
X-CSE-ConnectionGUID: qp6TK/wOT6awAuuVOwiGLA==
X-CSE-MsgGUID: E3+SqUJbQbe+F61A34/xsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63885966"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63885966"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 03:24:38 -0700
X-CSE-ConnectionGUID: 0uEwAHu4RIuLkNL1etg/yA==
X-CSE-MsgGUID: gbmldi1/QFycxa9P+Z+9jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185963370"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 03:24:34 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 05/12] perf/x86/intel: Initialize architectural PEBS
Date: Wed, 29 Oct 2025 18:21:29 +0800
Message-Id: <20251029102136.61364-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch-PEBS leverages CPUID.23H.4/5 sub-leaves enumerate arch-PEBS
supported capabilities and counters bitmap. This patch parses these 2
sub-leaves and initializes arch-PEBS capabilities and corresponding
structures.

Since IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs are no longer existed
for arch-PEBS, arch-PEBS doesn't need to manipulate these MSRs. Thus add
a simple pair of __intel_pmu_pebs_enable/disable() callbacks for
arch-PEBS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 21 ++++++++---
 arch/x86/events/intel/core.c      | 60 ++++++++++++++++++++++---------
 arch/x86/events/intel/ds.c        | 52 ++++++++++++++++++++++-----
 arch/x86/events/perf_event.h      | 25 +++++++++++--
 arch/x86/include/asm/perf_event.h |  7 +++-
 5 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 74479f9d6eed..f2402ae3ffa0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -554,14 +554,22 @@ static inline int precise_br_compat(struct perf_event *event)
 	return m == b;
 }
 
-int x86_pmu_max_precise(void)
+int x86_pmu_max_precise(struct pmu *pmu)
 {
 	int precise = 0;
 
-	/* Support for constant skid */
 	if (x86_pmu.pebs_active && !x86_pmu.pebs_broken) {
-		precise++;
+		/* arch PEBS */
+		if (x86_pmu.arch_pebs) {
+			precise = 2;
+			if (hybrid(pmu, arch_pebs_cap).pdists)
+				precise++;
+
+			return precise;
+		}
 
+		/* legacy PEBS - support for constant skid */
+		precise++;
 		/* Support for IP fixup */
 		if (x86_pmu.lbr_nr || x86_pmu.intel_cap.pebs_format >= 2)
 			precise++;
@@ -569,13 +577,14 @@ int x86_pmu_max_precise(void)
 		if (x86_pmu.pebs_prec_dist)
 			precise++;
 	}
+
 	return precise;
 }
 
 int x86_pmu_hw_config(struct perf_event *event)
 {
 	if (event->attr.precise_ip) {
-		int precise = x86_pmu_max_precise();
+		int precise = x86_pmu_max_precise(event->pmu);
 
 		if (event->attr.precise_ip > precise)
 			return -EOPNOTSUPP;
@@ -2630,7 +2639,9 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	struct pmu *pmu = dev_get_drvdata(cdev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise(pmu));
 }
 
 static DEVICE_ATTR_RO(max_precise);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c88bcd5d2bc4..9ce27b326923 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5271,34 +5271,59 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
+#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
+
 static void update_pmu_cap(struct pmu *pmu)
 {
-	unsigned int cntr, fixed_cntr, ecx, edx;
-	union cpuid35_eax eax;
-	union cpuid35_ebx ebx;
+	unsigned int eax, ebx, ecx, edx;
+	union cpuid35_eax eax_0;
+	union cpuid35_ebx ebx_0;
+	u64 cntrs_mask = 0;
+	u64 pebs_mask = 0;
+	u64 pdists_mask = 0;
 
-	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx);
 
-	if (ebx.split.umask2)
+	if (ebx_0.split.umask2)
 		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
-	if (ebx.split.eq)
+	if (ebx_0.split.eq)
 		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
 
-	if (eax.split.cntr_subleaf) {
+	if (eax_0.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
-			    &cntr, &fixed_cntr, &ecx, &edx);
-		hybrid(pmu, cntr_mask64) = cntr;
-		hybrid(pmu, fixed_cntr_mask64) = fixed_cntr;
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, cntr_mask64) = eax;
+		hybrid(pmu, fixed_cntr_mask64) = ebx;
+		cntrs_mask = counter_mask(eax, ebx);
 	}
 
-	if (eax.split.acr_subleaf) {
+	if (eax_0.split.acr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
-			    &cntr, &fixed_cntr, &ecx, &edx);
+			    &eax, &ebx, &ecx, &edx);
 		/* The mask of the counters which can be reloaded */
-		hybrid(pmu, acr_cntr_mask64) = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
-
+		hybrid(pmu, acr_cntr_mask64) = counter_mask(eax, ebx);
 		/* The mask of the counters which can cause a reload of reloadable counters */
-		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cause_mask64) = counter_mask(ecx, edx);
+	}
+
+	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
+	if (eax_0.split.pebs_caps_subleaf && eax_0.split.pebs_cnts_subleaf) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, arch_pebs_cap).caps = (u64)ebx << 32;
+
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		pebs_mask   = counter_mask(eax, ecx);
+		pdists_mask = counter_mask(ebx, edx);
+		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
+		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
+
+		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
+			x86_pmu.arch_pebs = 0;
+	} else {
+		WARN_ON(x86_pmu.arch_pebs == 1);
+		x86_pmu.arch_pebs = 0;
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
@@ -6252,7 +6277,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.ds_pebs ? attr->mode : 0;
+	return intel_pmu_has_pebs() ? attr->mode : 0;
 }
 
 static umode_t
@@ -7728,6 +7753,9 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		update_pmu_cap(NULL);
 
+	if (x86_pmu.arch_pebs)
+		pr_cont("Architectural PEBS, ");
+
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,
 				      &x86_pmu.intel_ctrl);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..26e485eca0a0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1531,6 +1531,15 @@ static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
 		intel_pmu_drain_pebs_buffer();
 }
 
+static void __intel_pmu_pebs_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
+	cpuc->pebs_enabled |= 1ULL << hwc->idx;
+}
+
 void intel_pmu_pebs_enable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1539,9 +1548,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	struct debug_store *ds = cpuc->ds;
 	unsigned int idx = hwc->idx;
 
-	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
-
-	cpuc->pebs_enabled |= 1ULL << hwc->idx;
+	__intel_pmu_pebs_enable(event);
 
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
 		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
@@ -1603,14 +1610,22 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	pebs_update_state(needed_cb, cpuc, event, false);
 }
 
-void intel_pmu_pebs_disable(struct perf_event *event)
+static void __intel_pmu_pebs_disable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
 	intel_pmu_drain_large_pebs(cpuc);
-
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
+	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
+}
+
+void intel_pmu_pebs_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
+	__intel_pmu_pebs_disable(event);
 
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
 	    (x86_pmu.version < 5))
@@ -1622,8 +1637,6 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	if (cpuc->enabled)
 		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
-
-	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 }
 
 void intel_pmu_pebs_enable_all(void)
@@ -2669,11 +2682,26 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	}
 }
 
+static void __init intel_arch_pebs_init(void)
+{
+	/*
+	 * Current hybrid platforms always both support arch-PEBS or not
+	 * on all kinds of cores. So directly set x86_pmu.arch_pebs flag
+	 * if boot cpu supports arch-PEBS.
+	 */
+	x86_pmu.arch_pebs = 1;
+	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
+	x86_pmu.pebs_capable = ~0ULL;
+
+	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
+	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
+}
+
 /*
  * PEBS probe and setup
  */
 
-void __init intel_pebs_init(void)
+static void __init intel_ds_pebs_init(void)
 {
 	/*
 	 * No support for 32bit formats
@@ -2788,6 +2816,14 @@ void __init intel_pebs_init(void)
 	}
 }
 
+void __init intel_pebs_init(void)
+{
+	if (x86_pmu.intel_cap.pebs_format == 0xf)
+		intel_arch_pebs_init();
+	else
+		intel_ds_pebs_init();
+}
+
 void perf_restore_debug_store(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 285779c73479..ca5289980b52 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -708,6 +708,12 @@ enum hybrid_pmu_type {
 	hybrid_big_small_tiny	= hybrid_big   | hybrid_small_tiny,
 };
 
+struct arch_pebs_cap {
+	u64 caps;
+	u64 counters;
+	u64 pdists;
+};
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -752,6 +758,8 @@ struct x86_hybrid_pmu {
 					mid_ack		:1,
 					enabled_ack	:1;
 
+	struct arch_pebs_cap		arch_pebs_cap;
+
 	u64				pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
 };
 
@@ -906,7 +914,7 @@ struct x86_pmu {
 	union perf_capabilities intel_cap;
 
 	/*
-	 * Intel DebugStore bits
+	 * Intel DebugStore and PEBS bits
 	 */
 	unsigned int	bts			:1,
 			bts_active		:1,
@@ -917,7 +925,8 @@ struct x86_pmu {
 			pebs_no_tlb		:1,
 			pebs_no_isolation	:1,
 			pebs_block		:1,
-			pebs_ept		:1;
+			pebs_ept		:1,
+			arch_pebs		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	u64		pebs_events_mask;
@@ -929,6 +938,11 @@ struct x86_pmu {
 	u64		rtm_abort_event;
 	u64		pebs_capable;
 
+	/*
+	 * Intel Architectural PEBS
+	 */
+	struct arch_pebs_cap arch_pebs_cap;
+
 	/*
 	 * Intel LBR
 	 */
@@ -1216,7 +1230,7 @@ int x86_reserve_hardware(void);
 
 void x86_release_hardware(void);
 
-int x86_pmu_max_precise(void);
+int x86_pmu_max_precise(struct pmu *pmu);
 
 void hw_perf_lbr_event_destroy(struct perf_event *event);
 
@@ -1791,6 +1805,11 @@ static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
 	return fls((u32)hybrid(pmu, pebs_events_mask));
 }
 
+static inline bool intel_pmu_has_pebs(void)
+{
+	return x86_pmu.ds_pebs || x86_pmu.arch_pebs;
+}
+
 #else /* CONFIG_CPU_SUP_INTEL */
 
 static inline void reserve_ds_buffers(void)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 49a4d442f3fc..0dfa06722bab 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -200,6 +200,8 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 #define ARCH_PERFMON_ACR_LEAF			0x2
+#define ARCH_PERFMON_PEBS_CAP_LEAF		0x4
+#define ARCH_PERFMON_PEBS_COUNTER_LEAF		0x5
 
 union cpuid35_eax {
 	struct {
@@ -210,7 +212,10 @@ union cpuid35_eax {
 		unsigned int    acr_subleaf:1;
 		/* Events Sub-Leaf */
 		unsigned int    events_subleaf:1;
-		unsigned int	reserved:28;
+		/* arch-PEBS Sub-Leaves */
+		unsigned int	pebs_caps_subleaf:1;
+		unsigned int	pebs_cnts_subleaf:1;
+		unsigned int	reserved:26;
 	} split;
 	unsigned int            full;
 };
-- 
2.34.1

