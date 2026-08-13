Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD142F702;
	Thu, 13 Aug 2026 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603815; cv=none; b=jIml5e7VC12JqqOKtbWASBmYbuoCeljDgPYD2H0h5W1BBJY8/CJW/4KiIfdNcUSI6vRlzCpVCj2aUN9x5jblCK/IxZMBBFAdt9UQEj+V7X+3Au2p2f1HE8MpYHjjzlkUjs6n2c6+JtvgRF9jb+aG0ZOBCdeDhshyysVIisdJlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603815; c=relaxed/simple;
	bh=B906/hiD7SoBeriay/isiF/O0i82NhlGf5i/iOusbMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fcu1B4FSWVi3VkTuW9FxeXWMRHVDrZt/wzCf2F7R565yRtZ5p6ZAw5LJ0+74RJe5i39WiX84MM6XvpftVom2bGZngD7+4kaqGL4hXHxjsxUCXF+QXmd1HcdhygEfhaWp0fV5Mn4a8fVD0Opx2Oj/Pmth+l1nUzQoxtMH4wnL/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiUn1TKV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiUn1TKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786603813; x=1818139813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B906/hiD7SoBeriay/isiF/O0i82NhlGf5i/iOusbMI=;
  b=BiUn1TKVz4UUb6wPpvdInhZeJzh67xSok13kcR88x153FtIlmLz8n6aq
   EMw7ipAZVmdy6ly9SJhAWAjST1fwTzXRGpEUEu/G3nviaSFkdnMLUIZhh
   7Zz7ONBwdK0nMQOlXrFQuNXy/jIn5jM4JAe7RaSxFZlKYxgHfRwaCk+hp
   Y8fNeFu8vLxub2HytNLLqYWExHJVq6qFwXQnNg6yRNJBh+dCORfutZH45
   cp4VG1UN9p8BOU9zynWU52Uusp4JAuUqkMGHThyOMQWC6RCRGImHJ9VOZ
   t0zH4lJIads6oizFKV95Kqhnez2nUCF2oolxhA9G43bBiProwHt6+1KYR
   Q==;
X-CSE-ConnectionGUID: ir1PQ5mhTCemg/CVtpTFnw==
X-CSE-MsgGUID: x91LOClRQIqbBMGftO7nCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="74707729"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="74707729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:50:12 -0700
X-CSE-ConnectionGUID: PYfi0BU6TUSDYQcbcAEGMA==
X-CSE-MsgGUID: wuWe5S7HRYm0NeYBU24tqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="288656031"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 12 Aug 2026 23:50:08 -0700
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
Subject: [Patch v2] perf/x86/intel: Prevent drain_pebs() reentry
Date: Thu, 13 Aug 2026 14:43:46 +0800
Message-Id: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
not be reentered. If so, one instance may observe stale buffer state and
potentially access out-of-bound memory.

Most invocations happen in NMI context, which naturally prevents reentry.
However, drain_pebs() is also reachable from process context via
intel_pmu_drain_pebs_buffer().

In those paths, the PMU is often already disabled, but not guaranteed.
For example, __intel_pmu_pebs_disable() only disables the target counter,
so other active counters can still raise a PMI and interrupt an in-flight
drain_pebs(). Here is an example,

__perf_addr_filters_adjust()
  perf_event_stop()
    __perf_event_stop()
      x86_pmu_stop() (event->pmu->stop)
        intel_pmu_disable_event()
          intel_pmu_pebs_disable()
            __intel_pmu_pebs_disable()
              intel_pmu_drain_large_pebs()
                intel_pmu_drain_pebs_buffer()

Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
use them in intel_pmu_drain_large_pebs() to disable the full PMU
around the intel_pmu_drain_pebs_buffer() call, preventing reentry.

Also add a warning in intel_pmu_drain_pebs_buffer() when the full PMU is
not disabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

v2: Move __intel_pmu_quiesce()/__intel_pmu_resume() pair into
intel_pmu_drain_large_pebs() instead of guarding all drain_pebs()
callbacks. (Peter)

v1: https://lore.kernel.org/all/20260717080342.1879573-9-dapeng1.mi@linux.intel.com/

 arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++---------
 arch/x86/events/intel/ds.c   |  8 +++++++-
 arch/x86/events/perf_event.h |  3 +++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f6ee1819864e..1cdb52c0aad5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3125,6 +3125,27 @@ static void intel_pmu_del_event(struct perf_event *event)
 		this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
 }
 
+int __intel_pmu_quiesce(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int pmu_enabled = cpuc->enabled;
+
+	cpuc->enabled = 0;
+	if (pmu_enabled)
+		intel_pmu_disable_all();
+
+	return pmu_enabled;
+}
+
+void __intel_pmu_resume(int pmu_enabled)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->enabled = pmu_enabled;
+	if (pmu_enabled)
+		intel_pmu_enable_all(0);
+}
+
 static int icl_set_topdown_event_period(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -3316,16 +3337,13 @@ static void intel_pmu_read_event(struct perf_event *event)
 	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN) ||
 	    is_pebs_counter_event_group(event)) {
 		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-		bool pmu_enabled = cpuc->enabled;
+		int pmu_enabled;
 
 		/* Only need to call update_topdown_event() once for group read. */
 		if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
 			return;
 
-		cpuc->enabled = 0;
-		if (pmu_enabled)
-			intel_pmu_disable_all();
-
+		pmu_enabled = __intel_pmu_quiesce();
 		/*
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
@@ -3334,10 +3352,7 @@ static void intel_pmu_read_event(struct perf_event *event)
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
index e86e4ba91e1b..54890dda0589 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1242,8 +1242,11 @@ int intel_pmu_drain_bts_buffer(void)
 
 void intel_pmu_drain_pebs_buffer(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_sample_data data;
 
+	WARN_ON_ONCE(cpuc->enabled);
+
 	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
 
@@ -1864,8 +1867,11 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
 {
 	if (cpuc->n_pebs == cpuc->n_large_pebs &&
-	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
+	    cpuc->n_pebs != cpuc->n_pebs_via_pt) {
+		int enabled = __intel_pmu_quiesce();
 		intel_pmu_drain_pebs_buffer();
+		__intel_pmu_resume(enabled);
+	}
 }
 
 static void __intel_pmu_pebs_enable(struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fa381110f7a7..84495279079a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1638,6 +1638,9 @@ static __always_inline void __intel_pmu_lbr_disable(void)
 	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
+extern int __intel_pmu_quiesce(void);
+extern void __intel_pmu_resume(int pmu_enabled);
+
 int intel_pmu_save_and_restart(struct perf_event *event);
 
 struct event_constraint *

base-commit: 917d558b151cad5b05991e5eaee22efab33525ca
-- 
2.34.1

