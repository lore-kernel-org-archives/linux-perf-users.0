Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4F231C8D;
	Tue, 18 Feb 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866461; cv=none; b=NSHT0OSh+8F87DyzNcWV1+GjIZ2Y6Q9DmYCYLUH/fb5XCtHK7MyWsnvfU5Wj2KpRDA0I0J0v+1FfwEHTaR4ROqIpTpEYmrg4XSg/Cp/KXo5wB9M3eI+tgrzv7ogo1YgprPicrHQKRKUKAdnx6Gthk1ZnG2qeSa2IBNx65gJeuPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866461; c=relaxed/simple;
	bh=HF6/nE9sM4OGUGQr/VeJgJtMUcaweMGpFQlJBKBGIUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBgHdxZXBseRH9cJUKwp2VnfB+2kUqn6mMHYdlSNqYMhL0tGQMqIiqOLDYDvKVz9nMCTf7Py7lEe7U2IEhXw8/4ajYFGBECvJwEZY3TlIf0zXn3YbyfVsgttAnhpQJ7BIroCPzKJSKwMW3A0lYZBTfPF4uvS1aSJhypYIxWRi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPHdW351; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPHdW351"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866460; x=1771402460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HF6/nE9sM4OGUGQr/VeJgJtMUcaweMGpFQlJBKBGIUo=;
  b=RPHdW351ulCDmy3W4Jai9x9Njs9pog2lDg6ZLCFVyskNk0XFsQf4+irI
   PtcOIxR6IHaW59H6Kwccv7aXrJfn1fmw0dpIzeSA8O5u8qXUU+TY5Lgix
   HtEkEbnNN15RLjHhYLn1i6jOXxfV044YWKGDofcnkQt8ymzKNELzbFYU8
   6c9KNa5BpYOYFjfdyq3uUp+TMlRilXixLqHICcCx9A+bfTSCubrL4KHSl
   944eVW4QO4wownVaL5IEPaca848qs6LbOXhT3kNdnx0WKPYnfHiBH9Ofz
   06zMnvZVA/lomUwReRaJBpv/cNFpmYOkk596bH5+GzXDfTBVHvxeYi770
   A==;
X-CSE-ConnectionGUID: xw3vPHtPTEaalKbKmcrzhA==
X-CSE-MsgGUID: ld7UXsXjQV68Xx7+bYVvPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200781"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200781"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:15 -0800
X-CSE-ConnectionGUID: 5u79tHmiTtGz4sVhSAh3FA==
X-CSE-MsgGUID: WuCxNAR9TAOV2ltwP4OO8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166196"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:11 -0800
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
Subject: [Patch v2 08/24] perf/x86/intel: Initialize architectural PEBS
Date: Tue, 18 Feb 2025 15:28:02 +0000
Message-Id: <20250218152818.158614-9-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/core.c            | 21 ++++++++++---
 arch/x86/events/intel/core.c      | 40 +++++++++++++++++-------
 arch/x86/events/intel/ds.c        | 52 ++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h      | 25 +++++++++++++--
 arch/x86/include/asm/perf_event.h |  7 ++++-
 5 files changed, 117 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1c2ff407ef17..24ae1159d6b9 100644
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
@@ -2626,7 +2635,9 @@ static ssize_t max_precise_show(struct device *cdev,
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
index 41c7243a4507..37540eb80029 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4970,22 +4970,37 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
 static void update_pmu_cap(struct pmu *pmu)
 {
-	unsigned int cntr, fixed_cntr, ecx, edx;
-	union cpuid35_eax eax;
-	union cpuid35_ebx ebx;
+	unsigned int eax, ebx, ecx, edx;
+	union cpuid35_eax eax_0;
+	union cpuid35_ebx ebx_0;
 
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
+		hybrid(pmu, arch_pebs_cap).counters = ((u64)ecx << 32) | eax;
+		hybrid(pmu, arch_pebs_cap).pdists = ((u64)edx << 32) | ebx;
+	} else {
+		WARN_ON(x86_pmu.arch_pebs == 1);
+		x86_pmu.arch_pebs = 0;
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
@@ -5942,7 +5957,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.ds_pebs ? attr->mode : 0;
+	return intel_pmu_has_pebs() ? attr->mode : 0;
 }
 
 static umode_t
@@ -7388,6 +7403,9 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		update_pmu_cap(NULL);
 
+	if (x86_pmu.arch_pebs)
+		pr_cont("Architectural PEBS, ");
+
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,
 				      &x86_pmu.intel_ctrl);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ab4a9a01336d..e66c5f307e93 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1525,6 +1525,15 @@ static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
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
@@ -1533,9 +1542,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	struct debug_store *ds = cpuc->ds;
 	unsigned int idx = hwc->idx;
 
-	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
-
-	cpuc->pebs_enabled |= 1ULL << hwc->idx;
+	__intel_pmu_pebs_enable(event);
 
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
 		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
@@ -1597,14 +1604,22 @@ void intel_pmu_pebs_del(struct perf_event *event)
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
@@ -1616,8 +1631,6 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	if (cpuc->enabled)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
-
-	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 }
 
 void intel_pmu_pebs_enable_all(void)
@@ -2649,11 +2662,26 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -2768,6 +2796,14 @@ void __init intel_pebs_init(void)
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
index 4bc6c9d66b94..265d76a321dd 100644
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
 
@@ -888,7 +896,7 @@ struct x86_pmu {
 	union perf_capabilities intel_cap;
 
 	/*
-	 * Intel DebugStore bits
+	 * Intel DebugStore and PEBS bits
 	 */
 	unsigned int	bts			:1,
 			bts_active		:1,
@@ -899,7 +907,8 @@ struct x86_pmu {
 			pebs_no_tlb		:1,
 			pebs_no_isolation	:1,
 			pebs_block		:1,
-			pebs_ept		:1;
+			pebs_ept		:1,
+			arch_pebs		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	u64		pebs_events_mask;
@@ -911,6 +920,11 @@ struct x86_pmu {
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
@@ -1205,7 +1219,7 @@ int x86_reserve_hardware(void);
 
 void x86_release_hardware(void);
 
-int x86_pmu_max_precise(void);
+int x86_pmu_max_precise(struct pmu *pmu);
 
 void hw_perf_lbr_event_destroy(struct perf_event *event);
 
@@ -1775,6 +1789,11 @@ static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
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
index eaf0d5245999..4f0c01610175 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -195,6 +195,8 @@ union cpuid10_edx {
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+#define ARCH_PERFMON_PEBS_CAP_LEAF		0x4
+#define ARCH_PERFMON_PEBS_COUNTER_LEAF		0x5
 
 union cpuid35_eax {
 	struct {
@@ -205,7 +207,10 @@ union cpuid35_eax {
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
2.40.1

