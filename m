Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904F1B1505;
	Thu, 29 Aug 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944831; cv=none; b=kmNEPR3E1D9nPNmHA+39uRxTseQ3wN4GgIVC6AcAeJCnKq2gGrcW1CpiEQvFO3/hMIbPnDCvFaSLscbYmHsZKkxGKNWYNEtiNg98ZWsTqArpSrQz3o63z40/u0rnLGKvZlGdVZs9sFYBTMBL+HoAFwZQ7H+RcwbPvNz7FtC1zTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944831; c=relaxed/simple;
	bh=3CPL4RJHA03wwpA8F+T8Ce8Bi53YSfV0qkFQPtDEBQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNY2Hq9wr2jevxoWlD52PR/2dhWZYZ4ZNQqnvc67EUSjACCOR8lHYf9Jj0IxpScWXVL/tVpfhmNZAE9Dc3GklbyImNBcH1EgX25jDDP50QLijjlQ+fYt+DWktNKq7g8h0JG2vKFm4ljCegiLL2pIl2XAgfBTPPotrf4jQyXNEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Egj4RduW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Egj4RduW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724944830; x=1756480830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3CPL4RJHA03wwpA8F+T8Ce8Bi53YSfV0qkFQPtDEBQw=;
  b=Egj4RduWy3paJR/1JFQa+e3UaXrheWCCXGGbhp321IGJzH88tODynbSn
   XuqXPwiqR+hLeFqa3twAvrw+sjaLrohiM5EeNIfd7mCIbUg1mM+KQtLJS
   G2iKnA/TiHi7MLt8WZLzPQRwXtLQEvxQGHItr/U3lTxLeejZz/xfoByYS
   us3gnQZXcDRFhXKU7XHsizhwOiUlbNxQYZT2D0NYrRJIRpFyQgRrkM3IK
   Jw4xey3g50plDSX7+YhRYJn6ag3BVHFvnWT2URSsPlAWxMWM5LPYsWhxJ
   8sqphS/htJUO1oGm/RljaqRkxBFHAz8oYGd+GgCDKF7U5RsyGnKYR1K4L
   A==;
X-CSE-ConnectionGUID: yxEj70VGT0OcBqRHs9ZvHQ==
X-CSE-MsgGUID: XRetHN39SYWAMmQqsA62cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34118330"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34118330"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:20:29 -0700
X-CSE-ConnectionGUID: qe5oVHKNR3mWnHVwlUh9rQ==
X-CSE-MsgGUID: JRELzpHWRkOeydwRuPXYAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68428043"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 29 Aug 2024 08:20:28 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ravi.bangoria@amd.com,
	sandipan.das@amd.com,
	atrajeev@linux.vnet.ibm.com,
	luogengkun@huaweicloud.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH] perf: New start period for the freq mode
Date: Thu, 29 Aug 2024 08:20:36 -0700
Message-Id: <20240829152036.3923842-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The freq mode is the current default mode of Linux perf. 1 period is
used as a start period. The period is auto-adjusted in each tick or an
overflow to meet the frequency target.

The start period 1 is too low and may trigger some issues.
- Many HWs do not support period 1 well.
  https://lore.kernel.org/lkml/875xs2oh69.ffs@tglx/
- For an event that occurs frequently, period 1 is too far away from the
  real period. Lots of the samples are generated at the beginning.
  The distribution of samples may not be even.

It's hard to find a universal start period for all events. The idea is
only to give an estimate for the popular HW and HW cache events. For the
rest of the events, start from the lowest possible recommended value.

Only the Intel event list JSON file provides the recommended SAV
(sample after value) for each event. The estimation is based on the
Intel's SAV.

This patch implements a generic perf_freq_start_period() which impacts
all ARCHs.
If the other ARCHs don't like the start period, a per-pmu
(*freq_start_period) may be introduced instead. Or make it a __weak
function.
The other option would be exposing a start_period knob in the sysfs or a
per-event config. So the end users can set their preferred start period.
Please let me know your thoughts.

SW events may need to be specially handled, which is not implemented in
the patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 65 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4b855b018a79..7a028474caef 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12017,6 +12017,69 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
 
+static u64 perf_freq_start_period(struct perf_event *event)
+{
+	int type = event->attr.type;
+	u64 config, factor;
+
+	/*
+	 * The 127 is the lowest possible recommended SAV (sample after value)
+	 * for a 4000 freq (default freq), according to Intel event list JSON
+	 * file, which is the only JSON file that provides a recommended value.
+	 */
+	factor = 127 * 4000;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		goto end;
+
+	/*
+	 * The estimation of the start period in the freq mode is
+	 * based on the below assumption.
+	 *
+	 * For a cycles or an instructions event, 1GHZ of the
+	 * underlying platform, 1 IPC. The workload is idle 50% time.
+	 * The start period = 1,000,000,000 * 1 / freq / 2.
+	 *		    = 500,000,000 / freq
+	 *
+	 * Usually, the branch-related events occur less than the
+	 * instructions event. According to the Intel event list JSON
+	 * file, the SAV (sample after value) of a branch-related event
+	 * is usually 1/4 of an instruction event.
+	 * The start period of branch-related events = 125,000,000 / freq.
+	 *
+	 * The cache-related events occurs even less. The SAV is usually
+	 * 1/20 of an instruction event.
+	 * The start period of cache-related events = 25,000,000 / freq.
+	 */
+	config = event->attr.config & PERF_HW_EVENT_MASK;
+	if (type == PERF_TYPE_HARDWARE) {
+		switch (config) {
+		case PERF_COUNT_HW_CPU_CYCLES:
+		case PERF_COUNT_HW_INSTRUCTIONS:
+		case PERF_COUNT_HW_BUS_CYCLES:
+		case PERF_COUNT_HW_STALLED_CYCLES_FRONTEND:
+		case PERF_COUNT_HW_STALLED_CYCLES_BACKEND:
+		case PERF_COUNT_HW_REF_CPU_CYCLES:
+			factor = 500000000;
+			break;
+		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
+		case PERF_COUNT_HW_BRANCH_MISSES:
+			factor = 125000000;
+			break;
+		case PERF_COUNT_HW_CACHE_REFERENCES:
+		case PERF_COUNT_HW_CACHE_MISSES:
+			factor = 25000000;
+			break;
+		default:
+			goto end;
+		}
+	}
+
+	if (type == PERF_TYPE_HW_CACHE)
+		factor = 25000000;
+end:
+	return DIV_ROUND_UP_ULL(factor, event->attr.sample_freq);
+}
+
 /*
  * Allocate and initialize an event structure
  */
@@ -12140,7 +12203,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	hwc = &event->hw;
 	hwc->sample_period = attr->sample_period;
 	if (attr->freq && attr->sample_freq)
-		hwc->sample_period = 1;
+		hwc->sample_period = perf_freq_start_period(event);
 	hwc->last_period = hwc->sample_period;
 
 	local64_set(&hwc->period_left, hwc->sample_period);
-- 
2.38.1

