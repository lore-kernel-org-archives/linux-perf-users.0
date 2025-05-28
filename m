Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8391B87C0;
	Wed, 28 May 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455141; cv=none; b=fWETkTAGiEMQigmVKG1nUb0eIre9U0ljtF5EyrsLCBsZRxv/hb+0a9AapyyITT7MAv1+jbzTBglOV4FDLQX4U0n0pC8JWXlqMVDuo/G3OXdyRu6BzlLMWH+HBT5uX3Ufqz5xubZ2H+VaCIS3FZQn3AENc2gqmwDbBkTuCUi50W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455141; c=relaxed/simple;
	bh=dWdT/BynBBuDSCyma1X+cQB7xQLt4r1AGcNl9ltXRbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E+mdwKqAXmIF8AHvff1n5fhoEkN0rOV63z4LcqZJ+FWzIYn32EDcf5WihvToZBzFd6bPSHL8ADM4nV6uxlpC+jdYdo8Zb3RgzJXjqd1hWSHAUJUxGZWxHq6e52p7D3SNOraZ7T2cDqn1Wy6HAS8lZwLwLyj9z5aAGckQTJslYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge5Nqd/f; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge5Nqd/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748455139; x=1779991139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dWdT/BynBBuDSCyma1X+cQB7xQLt4r1AGcNl9ltXRbQ=;
  b=ge5Nqd/fbZj2s6JHiBG448/m4yMMJRHODKngqxJCKWtseWVm17ldlJVE
   PcEls/ewhNMqTbdbcQw9jJpzI/CyL6EXYG3zIfqmUby34HVZOKLg5OXSc
   c5nRTNOTqd6Qfh8aIyD7ya/PSUmD/Q51SBzXizAiKu8/KUq7ZA55j1Ijc
   LRpcTQOcS1mTXUv5Fb6ZhOogKqNmseEwVEjSXBj1uDHeA/bi48t961vx/
   iLDdWDrZBZW4lmVo2happI7KBdgW/P7nQcSE+mBaTA2nuCMZ58iibebo2
   eyVu3GkXHxPac3nBVad0nJyTbnlCN9KzFYF5go4GtxtMrJbDeOiIw2VRn
   Q==;
X-CSE-ConnectionGUID: BfMO+r4URxe9XcMmBXSYfA==
X-CSE-MsgGUID: d3mFRUadSrebLDgEqzsqtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50648745"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50648745"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:58:58 -0700
X-CSE-ConnectionGUID: Zy20/L1sTQyvQQjMFfqx/Q==
X-CSE-MsgGUID: ikwD+7d6Tsi3LwndxkjWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="147193272"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 28 May 2025 10:58:58 -0700
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
Subject: [PATCH V2] perf: Fix the throttle error of some clock events
Date: Wed, 28 May 2025 10:58:32 -0700
Message-Id: <20250528175832.2999139-1-kan.liang@linux.intel.com>
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
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rebase on top of the latest tip.git
- Add Tested-by from Leo

 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 52dc7cfab0e0..97a747a97a50 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -305,6 +305,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
+#define PERF_PMU_CAP_NO_THROTTLE_STOP	0x0800
 
 /**
  * pmu::scope
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..abd19bb571e3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2656,7 +2656,22 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 
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
 	if (event == event->group_leader)
 		perf_log_throttle(event, 0);
@@ -11848,7 +11863,8 @@ static int cpu_clock_event_init(struct perf_event *event)
 static struct pmu perf_cpu_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
-	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.capabilities	= PERF_PMU_CAP_NO_NMI |
+			  PERF_PMU_CAP_NO_THROTTLE_STOP,
 	.dev		= PMU_NULL_DEV,
 
 	.event_init	= cpu_clock_event_init,
@@ -11930,7 +11946,8 @@ static int task_clock_event_init(struct perf_event *event)
 static struct pmu perf_task_clock = {
 	.task_ctx_nr	= perf_sw_context,
 
-	.capabilities	= PERF_PMU_CAP_NO_NMI,
+	.capabilities	= PERF_PMU_CAP_NO_NMI |
+			  PERF_PMU_CAP_NO_THROTTLE_STOP,
 	.dev		= PMU_NULL_DEV,
 
 	.event_init	= task_clock_event_init,
-- 
2.38.1

