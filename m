Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802A3E00A7;
	Fri, 17 Jul 2026 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275824; cv=none; b=pkrVcWLjDOB2ZjOPcwGJ1nU+SeoXtwdZOiZ4fD42pRcf1XKyTnx3X5a8ruMominRDBuuyQpk8oPwvcS9jgryTdemvotSoL8fQWXK39La0AZ7y92IN6Sd7usXdAy7QWhyGOmggpqLmSVuAIE3VeOD8Nf+Q28pM+WVwUxpTQXuqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275824; c=relaxed/simple;
	bh=joy9KmE+zXckzB/IpdRag9bXM8lxCGCgXPq5Cj4nKus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0OP+FqsP9r5wYz8s+gUV5s38/AsdNVbb0SfRAKbOM30xTs4yjf+Be87a0OLaMDbpFVIx3X+i9ILk66tZH1Jwf4/vO3soGN0p+Ea3KTWo7zmu6x7XpM/YEXZ6bWy3PictOb5LsT8j8vaiyD/PTE++d9hsBj/9pymEF/wB/MMV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvjWEaeJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvjWEaeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275823; x=1815811823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=joy9KmE+zXckzB/IpdRag9bXM8lxCGCgXPq5Cj4nKus=;
  b=nvjWEaeJ65l3mwaCBQjbar9FlIiorntpXiCXfwcU6bXZ0C0P7dBuBw4j
   sEjPZMaTwhGy7Q30KeVy18lfELd6OZ2ZagO3ah0+RMNVo1L09dQM16pbW
   HkcZ7C6QcHu0zSeRftU7wL9LseDiM63JEwxeO5A5WjSzgayRzHBw+dRg4
   8PfaP8XL+K3jFySC80crl4se0LH+rWGUBaRbYdwalA1fMHIEGgWLIi6Yi
   HeKkBJ2+HoeV6bJOEb+CHyv8wISgWR8V4SoYenserNGTqAXp/ZEJAU802
   P+lFdNtx4xetgm6LqaLequqvKz8FxrlOSsRzNVZwyfi5II/SRkgkYvDLh
   A==;
X-CSE-ConnectionGUID: RFBNuEEITPK2/hwL4ixdEg==
X-CSE-MsgGUID: nltjhvxyQKay3niwKuZAiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065592"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:23 -0700
X-CSE-ConnectionGUID: 5FWruUzyQIqZBsdyYO1HnQ==
X-CSE-MsgGUID: ofZY702TQUqudCczxT1qHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315488"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:10:19 -0700
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
Subject: [Patch v3 8/8] perf/x86/intel: Prevent drain_pebs() reentry
Date: Fri, 17 Jul 2026 16:03:42 +0800
Message-Id: <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
not run concurrently. If it is reentered, one instance may observe stale
buffer state and potentially access out-of-bound memory.

Most invocations happen in NMI context, which naturally prevents reentry.
However, drain_pebs() is also reachable from process context via
intel_pmu_drain_pebs_buffer().

In those paths, the PMU is often already disabled, but not guaranteed.
For example, __intel_pmu_pebs_disable() only disables the target counter,
so other active counters can still raise a PMI and interrupt an in-flight
drain_pebs().

Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
use them in intel_pmu_drain_pebs_buffer() to disable the full PMU
around the drain_pebs() call, preventing reentry.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 40 ++++++++++++++++++++++++++++--------
 arch/x86/events/intel/ds.c   |  7 -------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 361f8e0ab36c..726b39b9bba9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3125,6 +3125,36 @@ static void intel_pmu_del_event(struct perf_event *event)
 		this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
 }
 
+static inline void __intel_pmu_quiesce(bool pmu_enabled)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->enabled = 0;
+	if (pmu_enabled)
+		intel_pmu_disable_all();
+}
+
+static inline void __intel_pmu_resume(bool pmu_enabled)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->enabled = pmu_enabled;
+	if (pmu_enabled)
+		intel_pmu_enable_all(0);
+}
+
+void intel_pmu_drain_pebs_buffer(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	bool pmu_enabled = cpuc->enabled;
+	struct perf_sample_data data;
+
+	/* Disable PMU so no new PMI can interrupt and re-enter drain_pebs(). */
+	__intel_pmu_quiesce(pmu_enabled);
+	static_call(x86_pmu_drain_pebs)(NULL, &data);
+	__intel_pmu_resume(pmu_enabled);
+}
+
 static int icl_set_topdown_event_period(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -3322,10 +3352,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
 			return;
 
-		cpuc->enabled = 0;
-		if (pmu_enabled)
-			intel_pmu_disable_all();
-
+		__intel_pmu_quiesce(pmu_enabled);
 		/*
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
@@ -3334,10 +3361,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();
-
-		cpuc->enabled = pmu_enabled;
-		if (pmu_enabled)
-			intel_pmu_enable_all(0);
+		__intel_pmu_resume(pmu_enabled);
 
 		return;
 	}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e86e4ba91e1b..7f8b98d1837d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1240,13 +1240,6 @@ int intel_pmu_drain_bts_buffer(void)
 	return 1;
 }
 
-void intel_pmu_drain_pebs_buffer(void)
-{
-	struct perf_sample_data data;
-
-	static_call(x86_pmu_drain_pebs)(NULL, &data);
-}
-
 /*
  * PEBS
  */
-- 
2.34.1

