Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1F1CDA3F;
	Thu, 23 Jan 2025 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613231; cv=none; b=u/+CVjLNyPQycmbf55hDCTzqXQ9nJXwPia7jMMbEKYJ0aIY+krov0755vF0bWrXd1FESrJtWe3KCSgYtj8D1IClyXeSXJBkpHfUD0gbjKe4EH7jijbSTFYUOY667kx73VFbluigGCHQYd2iSi162kGY3q9wn+b1xU3x46jdfRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613231; c=relaxed/simple;
	bh=TpIfjt1v0HwRi0fNRAa7iYXvgNjuHheeVH0IQMvHrNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYNnUJNUdsqFmnby6fN+rTKtF9FAU1fum1Qk1f/Odpqit3dq2BPsfOSej0i8/5s6h/Ofa4upCFDl05+hwcbAi3jFNXAxThASjtl9oAFjknxv2b/ZBdqCzd/jthAgt0V3fbQMnGdzYz1VCLvqBG25oSixng2Ocq6UDp4pajlBJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQ+hsBP5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQ+hsBP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613231; x=1769149231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpIfjt1v0HwRi0fNRAa7iYXvgNjuHheeVH0IQMvHrNg=;
  b=YQ+hsBP5fOs5vhzWH34d6c64ERrXvXxCknMyMPLcDMwgIsUmFU8z7DVH
   W6pIqr+peCm6UoDL6yxzLustoCzvfP9VYrJrjYyJ0CPQr7jB3opoPpJzn
   rsJ7/r8S0xOpLIcdunaHLUsKfhbiyRZGl/iFnCTTemnBIm3AvSMMsO3yb
   zb3HSQB/ZLdTdHX/EjldJeLOTo2glPljSM6tY4Y3aZrsxjgYMFE58lMFs
   Da5tPyp4Cz0n0ftehK1znFdQ9reM+jWdno71rIAy9li1nmC+JP/9VCxRj
   l9r7xFCb8YeJKVf01/6b60/4ZautPxISrHJX2rZG6QscOg3GtgJI4ziiz
   w==;
X-CSE-ConnectionGUID: lz0GKv5fQQKpsC41jyUutQ==
X-CSE-MsgGUID: i/oNXOX1RpOHHo4rQ/W59w==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513081"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513081"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:30 -0800
X-CSE-ConnectionGUID: EQidAE4KTReb2OtlCyRgeA==
X-CSE-MsgGUID: ZlZXuJx/QTWtYx6WRqgHHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334512"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:26 -0800
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
Subject: [PATCH 06/20] perf/x86/intel: Initialize architectural PEBS
Date: Thu, 23 Jan 2025 14:07:07 +0000
Message-Id: <20250123140721.2496639-7-dapeng1.mi@linux.intel.com>
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

arch-PEBS leverages CPUID.23H.4/5 sub-leaves enumerate arch-PEBS
supported capabilities and counters bitmap. This patch parses these 2
sub-leaves and initializes arch-PEBS capabilities and corresponding
structures.

Since IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs are no longer existed
for arch-PEBS, avoid code to access these MSRs as well if arch-PEBS is
supported.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 21 +++++++++++++-----
 arch/x86/events/intel/core.c      | 20 ++++++++++++++++-
 arch/x86/events/intel/ds.c        | 36 ++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h      | 25 ++++++++++++++++++---
 arch/x86/include/asm/perf_event.h |  7 ++++++
 5 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b6430e5a77b..c36cc606bd19 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -549,14 +549,22 @@ static inline int precise_br_compat(struct perf_event *event)
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
@@ -564,13 +572,14 @@ int x86_pmu_max_precise(void)
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
@@ -2615,7 +2624,9 @@ static ssize_t max_precise_show(struct device *cdev,
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
index 0063afa0ddac..dc49dcf9b705 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4973,6 +4973,21 @@ static void update_pmu_cap(struct pmu *pmu)
 		hybrid(pmu, fixed_cntr_mask64) = ebx;
 	}
 
+	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
+	if ((sub_bitmaps & ARCH_PERFMON_PEBS_LEAVES) == ARCH_PERFMON_PEBS_LEAVES) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_LEAF_BIT,
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, arch_pebs_cap).caps = (u64)ebx << 32;
+
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF_BIT,
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, arch_pebs_cap).counters = ((u64)ecx << 32) | eax;
+		hybrid(pmu, arch_pebs_cap).pdists = ((u64)edx << 32) | ebx;
+	} else {
+		WARN_ON(x86_pmu.arch_pebs == 1);
+		x86_pmu.arch_pebs = 0;
+	}
+
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
@@ -5945,7 +5960,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.ds_pebs ? attr->mode : 0;
+	return intel_pmu_has_pebs() ? attr->mode : 0;
 }
 
 static umode_t
@@ -7387,6 +7402,9 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		update_pmu_cap(NULL);
 
+	if (x86_pmu.arch_pebs)
+		pr_cont("Architectural PEBS, ");
+
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,
 				      &x86_pmu.intel_ctrl);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e8a06c8486af..1b33a6a60584 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1537,6 +1537,9 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 
 	cpuc->pebs_enabled |= 1ULL << hwc->idx;
 
+	if (x86_pmu.arch_pebs)
+		return;
+
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
 		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
 	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
@@ -1606,6 +1609,11 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
 
+	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
+
+	if (x86_pmu.arch_pebs)
+		return;
+
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
 	    (x86_pmu.version < 5))
 		cpuc->pebs_enabled &= ~(1ULL << (hwc->idx + 32));
@@ -1616,15 +1624,13 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	if (cpuc->enabled)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
-
-	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 }
 
 void intel_pmu_pebs_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->pebs_enabled)
+	if (!x86_pmu.arch_pebs && cpuc->pebs_enabled)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 }
 
@@ -1632,7 +1638,7 @@ void intel_pmu_pebs_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->pebs_enabled)
+	if (!x86_pmu.arch_pebs && cpuc->pebs_enabled)
 		__intel_pmu_pebs_disable_all();
 }
 
@@ -2649,11 +2655,23 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -2755,6 +2773,14 @@ void __init intel_pebs_init(void)
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
index d5b7f5605e1e..85cb36ad5520 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -707,6 +707,12 @@ enum atom_native_id {
 	skt_native_id           = 0x3,  /* Skymont */
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
@@ -742,6 +748,8 @@ struct x86_hybrid_pmu {
 					mid_ack		:1,
 					enabled_ack	:1;
 
+	struct arch_pebs_cap		arch_pebs_cap;
+
 	u64				pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
 };
 
@@ -884,7 +892,7 @@ struct x86_pmu {
 	union perf_capabilities intel_cap;
 
 	/*
-	 * Intel DebugStore bits
+	 * Intel DebugStore and PEBS bits
 	 */
 	unsigned int	bts			:1,
 			bts_active		:1,
@@ -895,7 +903,8 @@ struct x86_pmu {
 			pebs_no_tlb		:1,
 			pebs_no_isolation	:1,
 			pebs_block		:1,
-			pebs_ept		:1;
+			pebs_ept		:1,
+			arch_pebs		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	u64		pebs_events_mask;
@@ -907,6 +916,11 @@ struct x86_pmu {
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
@@ -1196,7 +1210,7 @@ int x86_reserve_hardware(void);
 
 void x86_release_hardware(void);
 
-int x86_pmu_max_precise(void);
+int x86_pmu_max_precise(struct pmu *pmu);
 
 void hw_perf_lbr_event_destroy(struct perf_event *event);
 
@@ -1766,6 +1780,11 @@ static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
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
index 71e2ae021374..00ffb9933aba 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -198,6 +198,13 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)
+#define ARCH_PERFMON_PEBS_CAP_LEAF_BIT		0x4
+#define ARCH_PERFMON_PEBS_CAP_LEAF		BIT(ARCH_PERFMON_PEBS_CAP_LEAF_BIT)
+#define ARCH_PERFMON_PEBS_COUNTER_LEAF_BIT	0x5
+#define ARCH_PERFMON_PEBS_COUNTER_LEAF		BIT(ARCH_PERFMON_PEBS_COUNTER_LEAF_BIT)
+
+#define ARCH_PERFMON_PEBS_LEAVES		(ARCH_PERFMON_PEBS_CAP_LEAF |	\
+						 ARCH_PERFMON_PEBS_COUNTER_LEAF)
 
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
-- 
2.40.1

