Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C61442F2;
	Wed, 11 Dec 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932969; cv=none; b=KvhWOEFUyAclvtoUOKdfnpUddjGGShdpkv3giRdxEevFVht5N7xDku+t8414xJx3ChH+AgenUtcdGVyFWhdBSqwAT2WxwSUwM4CRL8DfT0fMizh9VW3s68jSYmMqpnwokCLZrZSEnJn7jBH/El6k8GiANRVJd+ByLg968+OL62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932969; c=relaxed/simple;
	bh=yZV4wFsvTjVmy2hy69LP2ALNu/X9FZ8UBCHjdsnzqLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZkrqgyphOitLpV8QKu6YJG16syxu7lI68obeJuNRElBdqvacNnRPr1gpyH6JQXj2YLSqqxKzO89VFBd753xSxtdx3C02ELhyyFzbl2F805GWaguTodnvd8rxm0iqcsF7FoR0Nn9f2ikqjSpXMK3e+oJt3L43BrPXCEErJfbkm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jO85U3a7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jO85U3a7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733932968; x=1765468968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yZV4wFsvTjVmy2hy69LP2ALNu/X9FZ8UBCHjdsnzqLk=;
  b=jO85U3a7IAiwgqXbKAuGfDIf/8nCLIxmvxmbpD9agDc3ph//Gt4PK600
   f3OjGlN/2USGO2byxT5kidemEByKxkdE5Ya61D9Obi8W4A/+vECC+mSK7
   /NG4Egi1qNNxVAfaiVOXQVhy+q24E/V3MIwQG8zG7K/FZC8Iz+vzXhzqN
   jWcWRwbz+O2bqZkV/Du/6oFwzkeaWoL7jW+eA6uZZJQ/hr2H/o0H4p36M
   yFetXP5/NkholsP2qzDJuX01rkBkIHg0grmSdwlmfCB5fEU1O4A65Vc03
   f4B/V8/w2i80Pl1x69qUnPwyEzVQ6G6UClkxUeVmsiTFW7eWivSptGJsr
   w==;
X-CSE-ConnectionGUID: +W5EDeLSQ8qdofe3id6tOw==
X-CSE-MsgGUID: JvwBga8GT1237wpm5UFg9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34458978"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34458978"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:02:47 -0800
X-CSE-ConnectionGUID: E23TXczYRZOJLb1jjjoncQ==
X-CSE-MsgGUID: iOwPjAlDRa2affFXYVT/1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95686231"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 11 Dec 2024 08:02:46 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	ak@linux.intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: irogers@google.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 1/2] perf/x86/intel: Support RDPMC metrics clear mode
Date: Wed, 11 Dec 2024 08:03:17 -0800
Message-Id: <20241211160318.235056-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The new RDPMC enhancement, metrics clear mode, is to clear the
PERF_METRICS-related resources as well as the fixed-function performance
monitoring counter 3 after the read is performed. It is available for
ring 3. The feature is enumerated by the
IA32_PERF_CAPABILITIES.RDPMC_CLEAR_METRICS[bit 19]. To enable the
feature, the IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[bit 14] must be set.

Two ways were considered to enable the feature.
- Expose a knob in the sysfs globally. One user may affect the
  measurement of other users when changing the knob. The solution is
  dropped.
- Introduce a new event format, metrics_clear, for the slots event to
  disable/enable the feature only for the current process. Users can
  utilize the feature as needed.
The latter solution is implemented in the patch.

The current KVM doesn't support the perf metrics yet. For
virtualization, the feature can be enabled later separately.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The V4 can be found at
https://lore.kernel.org/lkml/20240926184558.3797290-1-kan.liang@linux.intel.com/

Change since V4:
- Split the doc update into a dedicated patch


 arch/x86/events/intel/core.c      | 20 +++++++++++++++++++-
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2e1e26846050..e76e892f44cd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2816,6 +2816,9 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 			return;
 
 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+
+		if (event->attr.config1 & INTEL_TD_CFG_METRIC_CLEAR)
+			bits |= INTEL_FIXED_3_METRICS_CLEAR;
 	}
 
 	intel_set_masks(event, idx);
@@ -4071,7 +4074,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * is used in a metrics group, it too cannot support sampling.
 	 */
 	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
-		if (event->attr.config1 || event->attr.config2)
+		/* The metrics_clear can only be set for the slots event */
+		if (event->attr.config1 &&
+		    (!is_slots_event(event) || (event->attr.config1 & ~INTEL_TD_CFG_METRIC_CLEAR)))
+			return -EINVAL;
+
+		if (event->attr.config2)
 			return -EINVAL;
 
 		/*
@@ -4680,6 +4688,8 @@ PMU_FORMAT_ATTR(in_tx,  "config:32"	);
 PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
 PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
 
+PMU_FORMAT_ATTR(metrics_clear,	"config1:0"); /* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+
 static ssize_t umask2_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *page)
@@ -4699,6 +4709,7 @@ static struct device_attribute format_attr_umask2  =
 static struct attribute *format_evtsel_ext_attrs[] = {
 	&format_attr_umask2.attr,
 	&format_attr_eq.attr,
+	&format_attr_metrics_clear.attr,
 	NULL
 };
 
@@ -4723,6 +4734,13 @@ evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	if (i == 1)
 		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
 
+	/* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+	if (i == 2) {
+		union perf_capabilities intel_cap = hybrid(dev_get_drvdata(dev), intel_cap);
+
+		return intel_cap.rdpmc_metrics_clear ? attr->mode : 0;
+	}
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 82c6f45ce975..31c2771545a6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -624,6 +624,7 @@ union perf_capabilities {
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
 		u64	anythread_deprecated:1;
+		u64	rdpmc_metrics_clear:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index cb9c4679f45c..1ac79f361645 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -41,6 +41,7 @@
 #define INTEL_FIXED_0_USER				(1ULL << 1)
 #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
 #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+#define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
 
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
@@ -372,6 +373,9 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
 #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
 #define INTEL_TD_METRIC_NUM			8
 
+#define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
+#define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
+
 static inline bool is_metric_idx(int idx)
 {
 	return (unsigned)(idx - INTEL_PMC_IDX_METRIC_BASE) < INTEL_TD_METRIC_NUM;
-- 
2.38.1

