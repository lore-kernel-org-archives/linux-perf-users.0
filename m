Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821722C32D;
	Fri, 20 Jun 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404563; cv=none; b=jS/AshncvfGElhNYaT3YR1jhCw9DJmfsqXGw1z4Wr+Ec3sYFw18zxPyLyRlcEvy02eFIO9G4C52S4hN2QWZ/C4AC5iWmG+e6n130i//KIzpKEhYuzLsIXuW5s36I+OvDm2y3SAvTKcEYzQqG83hiH8qZ2z7VoIb7FtaamN4FYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404563; c=relaxed/simple;
	bh=u3426/gS8TOBdXecemGZuZU2eJGV3GBrWr7uHRzixLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFoD7ZMI8uKyGVk4uiBLoiZtqRC5u2OL9YniswV8NeE7dd6UK6WPtnc+91KaQO/yQPwdM1CFnaIYPDX0AtveRz9k4QyEd9fO+CBBEohjn3i+avp0cJ619GWM/fKAQKu/tB3DA7JaCABc9r1O0/mp7G7WNi3821MDxthQYvAxG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HI9CHnHH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HI9CHnHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404561; x=1781940561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3426/gS8TOBdXecemGZuZU2eJGV3GBrWr7uHRzixLc=;
  b=HI9CHnHHyQDSTSFKzjB064gvN8Z54UqMGOkMZNZQKbNOGKJFPts7mgtl
   8/FBpBNQmcF8tmyDkxofYjuMwBjzwQIdI56EtE0e8t+t+X7jlw86/3Hwl
   z4EO+C+rHwzjaJ7Fpecl0G8gS2YZAsS5sVUktGvrms0YGPJDzvIg8QcW2
   8KOhbpRt9JeuNc1fhNu1lJn9kpDUkUn/EAW0zRfsCOx2yzy5m+KUIcElz
   db0iL9qt79VCs9IpA6zmjtywLQTdawto/HHVHljuDPSewqgegw1hRALFi
   RKL6s0VZ9YsdWLuiFyLHcRoZ6PM5CfEchm9n8QCj+N5QlixKjVaGJkWmp
   A==;
X-CSE-ConnectionGUID: H1KT80DQTKyNdHnieKgBnw==
X-CSE-MsgGUID: 5GNlSp4qR3O30fjNAId3Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887740"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887740"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:21 -0700
X-CSE-ConnectionGUID: KQdm0kZOQQeVDxJxIq48Lg==
X-CSE-MsgGUID: SMpc0a9FT4+EsyQQhwHTlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156650992"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:18 -0700
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
Subject: [Patch v4 04/13] perf/x86/intel/ds: Factor out PEBS record processing code to functions
Date: Fri, 20 Jun 2025 10:39:00 +0000
Message-ID: <20250620103909.1586595-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
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

