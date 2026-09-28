Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEB46D2B0;
	Mon, 28 Sep 2026 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581882; cv=none; b=U3o1xrRKIQBU/67xXhoTbIZGE+fDZoTDHiXLsUMhczuX/5oCDtkl6G8GcfwlQKxJC74U/Sr/bSbINIIQnT7aDxGGd5AIDMN4GvK8C/oCIY4yoUdP/GoZrDA4o7h2T1HfwuOu+lmXzFE3DXYk3wGZshcnZCtLqj80KsEx4S7ft64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581882; c=relaxed/simple;
	bh=mE1uvNOf+JI8TkksKAJj6bPggdcvNBANjHRwrpDxPPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BT+DkEjQui8XmM53KJwzkzRQwsa5+Gu0G8DWlYyzVwQxkAiogaUtPkK5+YDX8EF01uvEIYXTg1ZuwiGjwcr4jekfpS6MKHbWbz2WO6J1tcDdEZm/alPesjQSi4FSy83brDsf726jkQjXauc4OEkPMDBtmIyFhQaxfQYORSZChkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7XH984M; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7XH984M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581881; x=1822117881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mE1uvNOf+JI8TkksKAJj6bPggdcvNBANjHRwrpDxPPw=;
  b=e7XH984Macoj6ohWDAcdyBLuCqxdCtvud5iZGasrcGmQ0bPYXhsEH0Mk
   moP4c14+ib+TyPl2QH3DZbUHjG1+YmmDCcP4NGaO1I5dDUqOAPWylATTA
   75tVQCgDd7O2YVJoal/bmwdzTzrlQsZI/d306zsdcUdcOIFTDI8PaxvCu
   OMe9nzZWCxp5MjuFqVF+NlXPr3Go4FlXqI0TBy+oL1MvPCwIgn1VqpIX5
   q1jriwCr7UlV8M1Hv0+hMT1mVrpEJwkN2DwicpnhnV2B8iZFOocH6c1Dx
   ibXYynMb6OQ3r0yKFslUE70huw1Ji0z8L7pOdEWX2QaMbB76bq2pP5ra/
   Q==;
X-CSE-ConnectionGUID: 9jpLpStvQqO0q0bUfDEESg==
X-CSE-MsgGUID: 0Gc6kwXHSAyZiP39RiZTAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141494"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141494"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:21 -0700
X-CSE-ConnectionGUID: iafmqAB+SaeBkewgHTgzEg==
X-CSE-MsgGUID: Ii6+w8ccTF+09RajwObtlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275025052"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:51:17 -0700
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
Subject: [PATCH 13/15] perf/x86: Validate event type before topdown/mem-loads classification
Date: Mon, 28 Sep 2026 15:43:07 +0800
Message-Id: <20260928074309.898043-14-dapeng1.mi@linux.intel.com>
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

Software events can be grouped with x86 PMU events. While iterating an
x86 event group, a non-x86 event may be misclassified as a SLOTS,
topdown metric or mem-loads{,-aux} events if its config bits happen to
match the x86 masks.

Require is_x86_event() before classifying SLOTS, topdown metric or
mem-loads{,-aux} events to avoid false matches on software events.

Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Fixes: 61b985e3e775 ("perf/x86/intel: Add perf core PMU support for Sapphire Rapids")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  8 ++++++--
 arch/x86/events/perf_event.h | 14 ++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0d360fba4b79..6cc1462c9c82 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4809,12 +4809,16 @@ static bool is_available_metric_event(struct perf_event *event)
 
 static inline bool is_mem_loads_event(struct perf_event *event)
 {
-	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0xcd, .umask=0x01);
+	return is_x86_event(event) &&
+	       ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
+		X86_CONFIG(.event = 0xcd, .umask = 0x01));
 }
 
 static inline bool is_mem_loads_aux_event(struct perf_event *event)
 {
-	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0x03, .umask=0x82);
+	return is_x86_event(event) &&
+	       ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
+		X86_CONFIG(.event = 0x03, .umask = 0x82));
 }
 
 static inline bool require_mem_loads_aux_event(struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e274802ef062..55f9684152c9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -96,18 +96,22 @@ static inline bool is_topdown_count(struct perf_event *event)
 	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
 }
 
+int is_x86_event(struct perf_event *event);
+
 static inline bool is_metric_event(struct perf_event *event)
 {
 	u64 config = event->attr.config;
 
-	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
-		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
-		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
+	return is_x86_event(event) &&
+	       ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
+	       ((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING) &&
+	       ((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
 }
 
 static inline bool is_slots_event(struct perf_event *event)
 {
-	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_TD_SLOTS;
+	return is_x86_event(event) &&
+	       (event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_TD_SLOTS;
 }
 
 static inline bool is_topdown_event(struct perf_event *event)
@@ -115,8 +119,6 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
-int is_x86_event(struct perf_event *event);
-
 static inline bool check_leader_group(struct perf_event *leader, int flags)
 {
 	return is_x86_event(leader) ? !!(leader->hw.flags & flags) : false;
-- 
2.34.1

