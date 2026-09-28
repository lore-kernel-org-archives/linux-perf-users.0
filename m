Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BD440A3C;
	Mon, 28 Sep 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581860; cv=none; b=NA/Xr71ZAKylY+jfrDyud/9PtYKwmWVk8im1HB6qFiCPwe8Q+cEN189zbVjjyze0AdirzG6TQMxyLBAZxDoRWLr2H2IEwfn09sqBXNEAANz9vqe91uu6jO3/S6wULCeBXupW31HrA5VPQfdAC//NLydvaBWldYkEpika2iU2r1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581860; c=relaxed/simple;
	bh=JoN9LigKxFkLMziLDj35KYOP6aM1N01vJWg84KnpEHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgMQTxC133KQz9lqMV+r2ihiWWDqcvlYn9vt+yJawqWhkBoGQiY6PH3U9Fx5Iuuft2NT5W/xpjjnyoqQZ0G0w9d2LKmkcYWgaDJdbgsgMwM/nnlpFA3BPOpNpqH3d0vMJbKZ9g6a6OrXRK7U9iuEQ6NXDuIh+6vFvzNDpFLU+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkfHNVJl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkfHNVJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581859; x=1822117859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JoN9LigKxFkLMziLDj35KYOP6aM1N01vJWg84KnpEHA=;
  b=GkfHNVJlJUZF1wqiiGmQvqc0vAQRnY3SULuFnvn+OhpkIHcx7bLzjZGU
   2CMkXck/lfexF6b+0U1JyBgCF6uO3JWe6Y4CcZwWjg3Ai1xr4tuGlHPv3
   udp1uUf1SKrC9XhrQK3ZjfEJZLQVw5lDckFQ8eQ5/3XkdKclRzdV0NdEP
   NwnrAq4ykVBbLaEStHg/aB6Qtcz4IKT6Rf4vxKb48hUEM9ysohXejGkEI
   YZ0VnlER0vLgxaFvrJvjvvENzS8j6x9OVkAobu/EeHt5aU4MOHL0QCXUV
   qXlG4tKT2RKJodpkL/BqWcyHTdHqDRgO38I9Qtq8fdi+f06OoJISPjmR2
   A==;
X-CSE-ConnectionGUID: 4rHwmw+3TYKPf7K1RWvzXA==
X-CSE-MsgGUID: wTAjF58YSPSzlsnIUUDmKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141422"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:59 -0700
X-CSE-ConnectionGUID: 7smo6o3MRra8XSOYcU8KdA==
X-CSE-MsgGUID: ySow/yu3T4WP6lfjo8LTBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024929"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:55 -0700
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
Subject: [PATCH 07/15] perf/x86/intel: Reject SAMPLE_READ for no-counter-snapshot ACR events
Date: Mon, 28 Sep 2026 15:43:01 +0800
Message-Id: <20260928074309.898043-8-dapeng1.mi@linux.intel.com>
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

ACR events cannot always provide a reliable value through SAMPLE_READ.
For non-PEBS ACR events, another ACR overflow can auto-reload the counter
before software reads it, so software cannot sample the exact count before
the hardware reload.

PEBS-backed ACR events are safe only when counter snapshot support is
available, because the value is captured in the PEBS record before the
counter is reloaded.

Reject SAMPLE_READ for ACR event groups unless the event has PEBS
counter snapshot support, so perf does not report invalid counts.

Reported-by: Andi Kleen <ak@linux.intel.com>
Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 377ff3912420..3fc3795534bf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4974,6 +4974,53 @@ static inline int intel_set_branch_counter_constr(struct perf_event *event,
 	return 0;
 }
 
+static inline bool is_acr_sample_read_allowed(struct perf_event *event,
+					      bool group_has_sample_read)
+{
+	/*
+	 * ACR events cannot report an accurate count for non-PEBS events
+	 * or for PEBS events without counter snapshots: another ACR event
+	 * may overflow andauto-reload the counter before software can read
+	 * the precise value.
+	 *
+	 * We keep the check simple and do not validate the acr_mask precisely
+	 * to determine whether the SAMPLE_READ event is actually auto-reloaded
+	 * by another ACR event. If a SAMPLE_READ event is in the group, the
+	 * ACR event must be a PEBS event with counter snapshots; otherwise it
+	 * is rejected.
+	 */
+	if (group_has_sample_read && is_sampling_event(event) &&
+	    (!event->attr.precise_ip || !is_pebs_counter_event_group(event)))
+		return false;
+
+	return true;
+}
+
+static bool intel_pmu_allow_acr_sample_read(struct perf_event *event,
+					    bool group_has_sample_read)
+{
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+
+	if (!is_acr_sample_read_allowed(leader, group_has_sample_read))
+		return false;
+
+	if (leader->nr_siblings) {
+		for_each_sibling_event(sibling, leader) {
+			if (!is_acr_sample_read_allowed(sibling,
+						group_has_sample_read))
+				return false;
+		}
+	}
+
+	/* event isn't installed as a sibling yet. */
+	if ((event != leader) &&
+	    !is_acr_sample_read_allowed(event, group_has_sample_read))
+		return false;
+
+	return true;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -5117,6 +5164,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		struct perf_event *sibling, *leader = event->group_leader;
 		struct pmu *pmu = event->pmu;
 		bool has_sw_event = false;
+		bool has_sample_read = false;
 		int num = 0, idx = 0;
 		u64 cause_mask = 0;
 
@@ -5162,8 +5210,14 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (leader->attr.config2)
 			intel_pmu_set_acr_cntr_constr(leader, &cause_mask, &num);
 
+		if ((leader->attr.sample_type & PERF_SAMPLE_READ) ||
+		    (event->attr.sample_type & PERF_SAMPLE_READ))
+			has_sample_read = true;
+
 		if (leader->nr_siblings) {
 			for_each_sibling_event(sibling, leader) {
+				if (sibling->attr.sample_type & PERF_SAMPLE_READ)
+					has_sample_read = true;
 				if (!is_x86_event(sibling)) {
 					has_sw_event = true;
 					continue;
@@ -5175,6 +5229,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 				intel_pmu_set_acr_cntr_constr(sibling, &cause_mask, &num);
 			}
 		}
+
 		if (leader != event && event->attr.config2) {
 			if (has_sw_event)
 				return -EINVAL;
@@ -5184,6 +5239,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (hweight64(cause_mask) > hweight64(hybrid(pmu, acr_cause_mask64)) ||
 		    num > hweight64(hybrid(event->pmu, acr_cntr_mask64)))
 			return -EINVAL;
+
+		if (!intel_pmu_allow_acr_sample_read(event, has_sample_read))
+			return -EINVAL;
+
 		/*
 		 * In the second round, apply the counter-constraints for
 		 * the events which can cause other events reload.
-- 
2.34.1

