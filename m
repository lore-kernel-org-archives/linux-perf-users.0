Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82E46D55C;
	Mon, 28 Sep 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581864; cv=none; b=lVwRDOPJFn0a5V40DBrjFFvl/4Cl/xvQwUnE2NbGWRRnfX0LZur+FT0ccBzNhKzPqyd6wiIHPTh2X1vEEBbypwIFQe/3yxTGGJDrX7qLyDfrqIA88Dbi8EnMU/mnOHieoWZmnbq83kO4fFHdvWn4m9T723fLp0lH/negMcuDUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581864; c=relaxed/simple;
	bh=5WqTx9IW+leSvbbuBeMtyAAPUlIrHr5Kag4n/3cc99w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRjDMem852xYCFj2bWxJ51uhZbQO21CiGRSJNTc7RALAQAHQcKYr6VJAB7OHaCTzkJhDrKE07JVQdaMOOXH0Y2+p+gR284s0+UGwrSQ5zOFJ3aa6b1CyZAKRWbp3Hd1f4LBgz0Gq3sGt64VQD1KEcZ6E3VnEPqAvhA1TxYZecBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWjMaYGv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWjMaYGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581863; x=1822117863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WqTx9IW+leSvbbuBeMtyAAPUlIrHr5Kag4n/3cc99w=;
  b=iWjMaYGvKvd2lPDW71jPyqCYWK4JnYh6h57KAgrCxcKJBJ9VcOZKTnc6
   2ydR45e1Ybd8TEL8bQ9Koy6yt3CHqrM5LdxnXIRBnnfAI7Ok7AzTqWug0
   X7cvHX0C11tbHQcGo+am3Op7XFv3t77dXfHTHPgbr/a6TBsGMKp2c4h1c
   Vmh73FMU3q3muljW793oU6+6Kje2y/3ga0pAOoym25gcdYrCsTv3pfRpe
   0NA03/8dQkUu938kMUWyjV0ERAwzmNPBapUUJtRAcOyToeA74igF+Jmv8
   GW7GVKxYpiBdYGFajLt0FwNbHboHQNNrScW+QxjEMfKzyuns8NWbTk2Z3
   g==;
X-CSE-ConnectionGUID: Vy4zlVEgQRyOL3GroGbuGw==
X-CSE-MsgGUID: 9Crj0QQQTuCbHNloQeENlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141439"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141439"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:02 -0700
X-CSE-ConnectionGUID: GYtl3Ve7SraLMwgQpOdGEg==
X-CSE-MsgGUID: 98WSUBIDSbK5FJlpp6PQdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024941"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:59 -0700
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
Subject: [PATCH 08/15] perf/x86/intel: Fix stale PEBS count without counter-group support
Date: Mon, 28 Sep 2026 15:43:02 +0800
Message-Id: <20260928074309.898043-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms without PEBS counter-group support (for example, Sapphire
Rapids), PEBS group read samples can report mismatched counts between the
precise event and its sibling, e.g.,

$ perf record -e \
 '{cpu/instructions,period=100000/pu,cpu/instructions/u}:S' -- sleep 1

The invalid event counts are seen,

1st PEBS record:
.... group nr 2
..... id 0000000000006189, value 0000000000000000, lost 0
..... id 0000000000006269, value 00000000000186c1, lost 0

2nd PEBS record:
.... group nr 2
..... id 0000000000006189, value 00000000000186a0, lost 0
..... id 0000000000006269, value 0000000000030d6b, lost 0

In PEBS records, the first event count can lag behind the second event by
about one sample period, even though both counts should be close or equal.

The root cause is ordering in __intel_pmu_pebs_last_event(): PEBS event
counts are updated after perf_event_output()/perf_event_overflow(). As a
result, perf_output_read_group() snapshots stale PEBS counts.

Move the PEBS count update before
perf_event_output()/perf_event_overflow(), matching the non-PEBS ordering
in handle_pmi_common(), so group reads report correct PEBS event counts.

Fixes: 3c00ed344cef ("perf/x86/intel/ds: Factor out functions for PEBS records processing")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f68391d60b2d..1a32f4168a84 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2956,22 +2956,6 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		setup_sample(event, iregs, at, data, regs);
 	}
 
-	if (iregs == &dummy_iregs) {
-		/*
-		 * The PEBS records may be drained in the non-overflow context,
-		 * e.g., large PEBS + context switch. Perf should treat the
-		 * last record the same as other PEBS records, and doesn't
-		 * invoke the generic overflow handler.
-		 */
-		perf_event_output(event, data, regs);
-	} else {
-		/*
-		 * All but the last records are processed.
-		 * The last one is left to be able to call the overflow handler.
-		 */
-		perf_event_overflow(event, data, regs);
-	}
-
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
 		if (is_pebs_counter_event_group(event)) {
 			if (corrupted) {
@@ -3011,6 +2995,23 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		else
 			intel_pmu_save_and_restart(event);
 	}
+
+	if (iregs == &dummy_iregs) {
+		/*
+		 * The PEBS records may be drained in the non-overflow context,
+		 * e.g., large PEBS + context switch. Perf should treat the
+		 * last record the same as other PEBS records, and doesn't
+		 * invoke the generic overflow handler.
+		 */
+		perf_event_output(event, data, regs);
+	} else {
+		/*
+		 * All but the last records are processed.
+		 * The last one is left to be able to call the overflow handler.
+		 */
+		perf_event_overflow(event, data, regs);
+	}
+
 }
 
 static DEFINE_PER_CPU(struct x86_perf_regs, x86_pebs_regs);
-- 
2.34.1

