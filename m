Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1672DE6E5;
	Mon, 11 Aug 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902901; cv=none; b=nDawK2FpZn/ILrScQ5KjMKDUNCV6lSHuSANIXbVzES7wxAEAi8ERzVR71v8qr/S9V3SUt98nY0stmN0nETUUU56bp3+16pMOCIUPk6Z+hWjZfW6pe6oIK+ZIF0Swj1BRKV5MnixqLRK1xW9vCRfSgO1BmsQr4edblR3pl93oKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902901; c=relaxed/simple;
	bh=7LC99mG6CAsODrq/k96iOPGgZQeZVG2EuMixAhEZ0hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VljdJ1++wfCtdjQCXq/fVoZgF19vQtqhWG35ESXyUez+vuYdJTIzgmiEE0Imi2CBy3YrwGKKsbUm+T7xXdvaPzAxWQ2jJq0oSeNfrFkZdnfiB6DnX44sUbexsQKDqGvawIX9Uw8NoVrfiInmkJsldjTHD2z7TBYlxr+DGvdW5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBgdJDmW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBgdJDmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754902900; x=1786438900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7LC99mG6CAsODrq/k96iOPGgZQeZVG2EuMixAhEZ0hA=;
  b=jBgdJDmWpGdJY19UHmGSrMTNyvuI64Kl7oj0RB6zSpMY50yebHEcXIzx
   qCvOSG4CHJiE2N5Do2jPqCpBaxvEwfe67XNuiUmbMdse1jlxF/StGo+yC
   gnzi0lrMMIqtkQTsLYqQxtwd+1FMimXFPX1GuVB0wbXsvnX6DbJ5ZJEhZ
   yRbmd0wyx1qXTShaA8Fmv5qCoXFszvI1/voP/fFuutdtRvpHBWEoZDd2X
   LYOs02ZnmR9wP5pvIB6bi9MAUe0U+hO/eAXPKyi0ZGV144fU5y3mVPw9i
   XS9jUjglOEtf1FHjrPDkzgZ+A85FTYB1K+k5UO1AWQloQmUyeuPfkauAP
   g==;
X-CSE-ConnectionGUID: Vo1Ihs12QJe4PDpAv2LQSQ==
X-CSE-MsgGUID: 1DJ2qvlkRiKNhKFB5sTrjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57107342"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57107342"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 02:01:39 -0700
X-CSE-ConnectionGUID: qg0uc91NQQO8KhtZ8vOKfQ==
X-CSE-MsgGUID: gzhvExp+RSWId96/H8XmMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166219856"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2025 02:01:35 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [Patch v2 3/6] perf/x86: Check if cpuc->events[*] pointer exists before accessing it
Date: Mon, 11 Aug 2025 17:00:31 +0800
Message-Id: <20250811090034.51249-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMI handler could disable some events as the interrupt throttling
and clear the corresponding items in cpuc->events[] array.

perf_event_overflow()
  -> __perf_event_overflow()
    ->__perf_event_account_interrupt()
      -> perf_event_throttle_group()
        -> perf_event_throttle()
          -> event->pmu->stop()
            -> x86_pmu_stop()

Moreover PMI is NMI on x86 platform and it could interrupt other perf
code like setup_pebs_adaptive_sample_data(). So once PMI handling
finishes and returns into setup_pebs_adaptive_sample_data() and it could
find the cpuc->events[*] becomes NULL and accessing this NULL pointer
triggers an invalid memory access and leads to kernel crashes eventually.

Thus add NULL check before accessing cpuc->events[*] pointer.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
---
 arch/x86/events/core.c       |  3 +++
 arch/x86/events/intel/core.c |  6 +++++-
 arch/x86/events/intel/ds.c   | 13 ++++++-------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..f0a3bc57157d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1711,6 +1711,9 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 			continue;
 
 		event = cpuc->events[idx];
+		if (!event)
+			continue;
+
 		last_period = event->hw.last_period;
 
 		val = static_call(x86_pmu_update)(event);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 15da60cf69f2..386717b75a09 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2718,6 +2718,8 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
+		if (!other)
+			continue;
 		other->hw.saved_slots = slots;
 		other->hw.saved_metric = metrics;
 	}
@@ -2761,6 +2763,8 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end,
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
+		if (!other)
+			continue;
 		__icl_update_topdown_event(other, slots, metrics,
 					   event ? event->hw.saved_slots : 0,
 					   event ? event->hw.saved_metric : 0);
@@ -3138,7 +3142,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 
 	for_each_set_bit(bit, (unsigned long *)&guest_pebs_idxs, X86_PMC_IDX_MAX) {
 		event = cpuc->events[bit];
-		if (!event->attr.precise_ip)
+		if (!event || !event->attr.precise_ip)
 			continue;
 
 		perf_sample_data_init(data, 0, event->hw.last_period);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..b23c49e2e06f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2480,6 +2480,8 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
 	 */
 	for_each_set_bit(bit, (unsigned long *)&pebs_enabled, X86_PMC_IDX_MAX) {
 		event = cpuc->events[bit];
+		if (!event)
+			continue;
 		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 			intel_pmu_save_and_restart_reload(event, 0);
 	}
@@ -2579,10 +2581,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 			continue;
 
 		event = cpuc->events[bit];
-		if (WARN_ON_ONCE(!event))
-			continue;
-
-		if (WARN_ON_ONCE(!event->attr.precise_ip))
+		if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
 			continue;
 
 		/* log dropped samples number */
@@ -2645,9 +2644,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
 		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
 			event = cpuc->events[bit];
-
-			if (WARN_ON_ONCE(!event) ||
-			    WARN_ON_ONCE(!event->attr.precise_ip))
+			if (!event || WARN_ON_ONCE(!event->attr.precise_ip))
 				continue;
 
 			if (counts[bit]++) {
@@ -2663,6 +2660,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 			continue;
 
 		event = cpuc->events[bit];
+		if (!event)
+			continue;
 
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
 					    counts[bit], setup_pebs_adaptive_sample_data);
-- 
2.34.1

