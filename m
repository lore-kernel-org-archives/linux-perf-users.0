Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294D283683;
	Wed, 28 May 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443747; cv=none; b=UB+XrAuQUulau2zoD0mfaoFBB9JUjNUzJco2pfRQcfgwzmvRMbeaBv/JUnKc68kUUvto1p5I4qZSnQXV2zLpXDqCkc3ANgdv1kp0th8qWfAhBI5+wjWm6Cicb7tbgGDbQu87zcLksnKutOHZ8kBOIVQk+7pvcFHeM34n2D8TLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443747; c=relaxed/simple;
	bh=qgnpP9ARO5vVkvXbwXBu8ojEN41fQJiPFTS4KbCc4r4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2PAPJtr9Tqd1zsrhiy5v+O/w9XdoVBgFDeoU1WbS4b6YRwjTMwBRiXtiP/rqH0I5HC03zfVw9Ya0VDfECx9Ewf0AXwvDXqpVnYVeSIeN73eHSLdBIXtLHZJccvtV8ac19awtqMxfZxPXPgcOVC+dxXhxGWhbzfnhjI+Ff4YKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8TFURGt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8TFURGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748443745; x=1779979745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qgnpP9ARO5vVkvXbwXBu8ojEN41fQJiPFTS4KbCc4r4=;
  b=O8TFURGtyYoTVcKBp4JyEJkon3ANgyOLSPohLhT9NXKRbz5S7IyPNBxj
   KksH3eNM+3H+JA/ihN4zRdSLHlPXqFW3Y3wFq/aB/pjOOTTjRe4TXLJGK
   gb5tVfbx9/QCqu54+6EuCW5mtHpOEcSxNObsOzvlXzO6Pu5CDW94O+WmT
   s9yvb5pkcbazgJmYSwv8piz/eytzMFiYcuJJpTG5/ZWhChw8E6JihEAl5
   0LEb4HCSYpH8R/clitTSgJ6+boRwt7y6ojmUOZmi0d0cdpLkIRamGp1bF
   L+pxs3QALjHIn+4DhlGhOb9W0NYWQ3QE5uowB90oMmaQFwhteL+SmlOOz
   w==;
X-CSE-ConnectionGUID: zfDymr1KQCeXcf0p2daQBA==
X-CSE-MsgGUID: 6cChL8bORVWYhVcgtrQVkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="53096993"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="53096993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:49:04 -0700
X-CSE-ConnectionGUID: UTg9ayNJTaK/EJuhyyPE+g==
X-CSE-MsgGUID: TwpyN5IbTV69TFJzmn3hPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="180491922"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa001.jf.intel.com with ESMTP; 28 May 2025 07:49:04 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: [PATCH] perf: Fix the throttle error of some clock events
Date: Wed, 28 May 2025 07:48:23 -0700
Message-Id: <20250528144823.2996185-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The Arm CI reports RCU stall, which can be reproduced by the below perf
command.
  perf record -a -e cpu-clock -- sleep 2

The cpu-clock and task_clock are two special SW events, which rely on
the hrtimer. Instead of invoking the stop(), the HRTIMER_NORESTART is
returned to stop the timer. Because the hrtimer interrupt handler cannot
cancel itself, which causes infinite loop.

There may be two ways to fix it.
- Add a check of MAX_INTERRUPTS in the event_stop. Return immediately if
the stop is invoked by the throttle.
- Introduce a PMU flag to track the case. Avoid the event_stop in
perf_event_throttle() if the flag is detected.

The latter looks more generic. It may be used if there are more other
cases that want to avoid the stop later. The latter is implemented.

Reported-by: Leo Yan <leo.yan@arm.com>
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 947ad12dfdbe..66f02f46595c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -303,6 +303,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_NO_THROTTLE_STOP		0x0400
 
 /**
  * pmu::scope
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8327ab0ee641..4df274705038 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2655,7 +2655,22 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 
 static void perf_event_throttle(struct perf_event *event)
 {
-	event->pmu->stop(event, 0);
+	/*
+	 * Some PMUs, e.g., cpu-clock and task_clock, may rely on
+	 * a special mechanism (hrtimer) to manipulate counters.
+	 * The regular stop doesn't work, since the hrtimer interrupt
+	 * handler cannot cancel itself.
+	 *
+	 * The stop should be avoided for such cases. Let the
+	 * driver-specific code handle it.
+	 *
+	 * The counters will eventually be disabled in the driver-specific
+	 * code. In unthrottle, they still need to be re-enabled.
+	 * There is no handling for PERF_PMU_CAP_NO_THROTTLE_STOP in
+	 * the perf_event_unthrottle().
+	 */
+	if (!(event->pmu->capabilities & PERF_PMU_CAP_NO_THROTTLE_STOP))
+		event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
 	perf_log_throttle(event, 0);
 }
@@ -11846,7 +11861,8 @@ static int cpu_clock_event_init(struct perf_event *event)
 static struct pmu perf_cpu_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
-	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.capabilities	= PERF_PMU_CAP_NO_NMI |
+			  PERF_PMU_CAP_NO_THROTTLE_STOP,
 	.dev		= PMU_NULL_DEV,
 
 	.event_init	= cpu_clock_event_init,
@@ -11928,7 +11944,8 @@ static int task_clock_event_init(struct perf_event *event)
 static struct pmu perf_task_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
-	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.capabilities	= PERF_PMU_CAP_NO_NMI |
+			  PERF_PMU_CAP_NO_THROTTLE_STOP,
 	.dev		= PMU_NULL_DEV,
 
 	.event_init	= task_clock_event_init,
-- 
2.38.1

