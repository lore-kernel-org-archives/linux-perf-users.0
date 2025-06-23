Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD33597E;
	Thu, 26 Jun 2025 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909383; cv=none; b=dBrzqS+3OYJVcS+tHysGdRW6r5tOMo/MMumYJJMdv5PUE32hARfAqFuUrosptkdiJKtXyHVzz6HoEEYxUBDLmNh6abM+yQtefPFjuL5tZtdHJi2ONiV4AURAXbZ7nT0PNQ1t8apGVhhEqU5M+NK7fth4DGloGmTvC/wmdxkVb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909383; c=relaxed/simple;
	bh=u3426/gS8TOBdXecemGZuZU2eJGV3GBrWr7uHRzixLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYFWNR/GCZwgNyYWq5/PinxCdXD1mXpyUxcfQm5CVXDy7yRUsKiRRx5xAZbFVoH3OMFnwtZIcAgBe+B26ElWZdcZWYjeJY9jTDmMp74dvF85r5XynjSwkfeXKj6La3BdFLxBAznRw29L5UCJxG8yU1/UouxQCCfJGNM9VJKTKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkECHj6Y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkECHj6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909381; x=1782445381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3426/gS8TOBdXecemGZuZU2eJGV3GBrWr7uHRzixLc=;
  b=JkECHj6YArc2sWOLY3aE3OYapPoRUWZFg9XpRFuhL02li6wVROF+wWzT
   qEjH9bJGidcpqqoyy1TZnXV80WO/vFuIsH9ZkLaJ4aIwrTRKUg1nB2txZ
   70MlG/I62bXw4kGAuhM764PkTiUVMSyFmjbsN++EwVRt+d6Ft196PHYvC
   3eWpUWpSo6o7YUw/knYRWIAJkhWQ3WRO0BHTjQa37z/1iX0lMz9ifO+Iq
   Q91FhtuY9GBi7l/NaNOsPlrVJV7zj6irpOHZYX0vMHvyQoMp85jtXqMsJ
   DbGCS6yWp89GcTO2BouIDdcz9WIOynl0FHW0BGp0vAYbZ5QuLgwyxkqSE
   Q==;
X-CSE-ConnectionGUID: zLdI+y6hTBSOJ7dntF2FEA==
X-CSE-MsgGUID: odZLHtUJSMyO1XGcQHLtOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55820657"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55820657"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:43:01 -0700
X-CSE-ConnectionGUID: A+mZpdAhS2O2IKdavfCVew==
X-CSE-MsgGUID: ofUloqZrR3+tHjQvM06wjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157894970"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 20:42:58 -0700
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
Subject: [Patch v5 04/10] perf/x86/intel/ds: Factor out PEBS record processing code to functions
Date: Mon, 23 Jun 2025 22:35:39 +0000
Message-ID: <20250623223546.112465-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
References: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Beside some PEBS record layout difference, arch-PEBS can share most of
PEBS record processing code with adaptive PEBS. Thus, factor out these
common processing code to independent inline functions, so they can be
reused by subsequent arch-PEBS handler.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 80 ++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 26e485eca0a0..1d95e7313cac 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2614,6 +2614,54 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	}
 }
 
+static inline void __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
+						  struct pt_regs *regs,
+						  struct perf_sample_data *data,
+						  void *at, u64 pebs_status,
+						  short *counts, void **last,
+						  setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
+		event = cpuc->events[bit];
+
+		if (WARN_ON_ONCE(!event) ||
+		    WARN_ON_ONCE(!event->attr.precise_ip))
+			continue;
+
+		if (counts[bit]++)
+			__intel_pmu_pebs_event(event, iregs, regs, data,
+					       last[bit], setup_sample);
+
+		last[bit] = at;
+	}
+}
+
+static inline void
+__intel_pmu_handle_last_pebs_record(struct pt_regs *iregs, struct pt_regs *regs,
+				    struct perf_sample_data *data, u64 mask,
+				    short *counts, void **last,
+				    setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
+		if (!counts[bit])
+			continue;
+
+		event = cpuc->events[bit];
+
+		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
+					    counts[bit], setup_sample);
+	}
+
+}
+
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
@@ -2623,9 +2671,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	struct pebs_basic *basic;
-	struct perf_event *event;
 	void *base, *at, *top;
-	int bit;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
@@ -2638,6 +2684,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	mask = hybrid(cpuc->pmu, pebs_events_mask) |
 	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
+	mask &= cpuc->pebs_enabled;
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
@@ -2655,31 +2702,14 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		if (basic->format_size != cpuc->pebs_record_size)
 			continue;
 
-		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
-		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
-			event = cpuc->events[bit];
-
-			if (WARN_ON_ONCE(!event) ||
-			    WARN_ON_ONCE(!event->attr.precise_ip))
-				continue;
-
-			if (counts[bit]++) {
-				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
-						       setup_pebs_adaptive_sample_data);
-			}
-			last[bit] = at;
-		}
+		pebs_status = mask & basic->applicable_counters;
+		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
+					       pebs_status, counts, last,
+					       setup_pebs_adaptive_sample_data);
 	}
 
-	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
-		if (!counts[bit])
-			continue;
-
-		event = cpuc->events[bit];
-
-		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_pebs_adaptive_sample_data);
-	}
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
+					    setup_pebs_adaptive_sample_data);
 }
 
 static void __init intel_arch_pebs_init(void)
-- 
2.43.0

