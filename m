Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723327E1AB;
	Tue, 20 May 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765037; cv=none; b=jh0U1NOpeBHy5JPnwALBqwSiiKuE/klhNy+pKWHbRZOYHz9b53795I1YkpKM9JXEugx/H/UEY+ZMeeKvbWmZwCcm8J7kYEhlvmLpDQ24k5TPVzRu0gLrEzeYTrqPeLgaPgkrEAV8G76FjAvGYly8H9CJTUI/gLlWQdNGAoX8rIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765037; c=relaxed/simple;
	bh=RhWTWrmTfiwk6pJE65tbJb5g6Dca08aHeW4obh7IKQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLPLHJbMftOWivrIkxrqWcSqOCfzVhVLNjZ29LNe7zKjW3AZxL1iRE4f1nd/fpth05cNc2MzrwJRvck75jpKuXU2lsiFVWfBahpM2cUyOMdKiNTpkDQoisu96X1cz9+/XW6J/ZQ2ceUx41rzHM0KHmf1Xv5YQNvZmDbyJdmUCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXchJYJZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXchJYJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765035; x=1779301035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RhWTWrmTfiwk6pJE65tbJb5g6Dca08aHeW4obh7IKQs=;
  b=fXchJYJZA1FRDGDTNSKYy8Tg9is1VEy9iKfmzlBjBmj1Kwz3YM6a1ZeK
   Y3uC1HGWMcRKvh3udVXH6qdTgRvFtlK6USQxTI0n9IbdYjlSpciIdWSg8
   SH0OVFd7FdjgHydiNbp2FQrwGNvyNd1xID24OGL0CNfPPhwx8KNZ2S2EO
   frX6d6R9iHDZ9jX8cwiiWg5C5y4WmN5eKN9yQ6b+ciyEGXnvT1m00I9fo
   p6jJkFOMhMwDGlEDhO8DIogXPV6+yCJar6GARnnsOlKCAws1GPjtWZiSC
   alQ4lQQCCAIQof0Cnav6hyJiKgikTEuTSFmSb1b1sNcUoKiJo0Z7Hj92N
   A==;
X-CSE-ConnectionGUID: 0jJqY7erR8Kql1JUgPPD5g==
X-CSE-MsgGUID: s5yhNLx3RIK69C8OL98yrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847943"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847943"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:12 -0700
X-CSE-ConnectionGUID: M3vc2tqnQTarATGdY60rSg==
X-CSE-MsgGUID: zfPrytPLRJSWcnBeYCLA0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514704"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:12 -0700
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 01/16] perf: Fix the throttle logic for a group
Date: Tue, 20 May 2025 11:16:29 -0700
Message-Id: <20250520181644.2673067-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current throttle logic doesn't work well with a group, e.g., the
following sampling-read case.

$ perf record -e "{cycles,cycles}:S" ...

$ perf report -D | grep THROTTLE | tail -2
            THROTTLE events:        426  ( 9.0%)
          UNTHROTTLE events:        425  ( 9.0%)

$ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
... sample_read:
.... group nr 2
..... id 0000000000000327, value 000000000cbb993a, lost 0
..... id 0000000000000328, value 00000002211c26df, lost 0

The second cycles event has a much larger value than the first cycles
event in the same group.

The current throttle logic in the generic code only logs the THROTTLE
event. It relies on the specific driver implementation to disable
events. For all ARCHs, the implementation is similar. Only the event is
disabled, rather than the group.

The logic to disable the group should be generic for all ARCHs. Add the
logic in the generic code. The following patch will remove the buggy
driver-specific implementation.

The throttle only happens when an event is overflowed. Stop the entire
group when any event in the group triggers the throttle.
The MAX_INTERRUPTS is set to all throttle events.

The unthrottled could happen in 3 places.
- event/group sched. All events in the group are scheduled one by one.
  All of them will be unthrottled eventually. Nothing needs to be
  changed.
- The perf_adjust_freq_unthr_events for each tick. Needs to restart the
  group altogether.
- The __perf_event_period(). The whole group needs to be restarted
  altogether as well.

With the fix,
$ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
... sample_read:
.... group nr 2
..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 66 ++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index af78ec118e8f..915698f47682 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2739,6 +2739,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
 static void perf_log_throttle(struct perf_event *event, int enable);
 static void perf_log_itrace_start(struct perf_event *event);
 
+static void perf_event_unthrottle(struct perf_event *event, bool start)
+{
+	event->hw.interrupts = 0;
+	if (start)
+		event->pmu->start(event, 0);
+	perf_log_throttle(event, 1);
+}
+
+static void perf_event_throttle(struct perf_event *event)
+{
+	event->pmu->stop(event, 0);
+	event->hw.interrupts = MAX_INTERRUPTS;
+	perf_log_throttle(event, 0);
+}
+
+static void perf_event_unthrottle_group(struct perf_event *event, bool skip_start_event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+
+	perf_event_unthrottle(leader, skip_start_event ? leader != event : true);
+	for_each_sibling_event(sibling, leader)
+		perf_event_unthrottle(sibling, skip_start_event ? sibling != event : true);
+}
+
+static void perf_event_throttle_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+
+	perf_event_throttle(leader);
+	for_each_sibling_event(sibling, leader)
+		perf_event_throttle(sibling);
+}
+
 static int
 event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 {
@@ -2767,10 +2800,8 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 	 * ticks already, also for a heavily scheduling task there is little
 	 * guarantee it'll get a tick in a timely manner.
 	 */
-	if (unlikely(event->hw.interrupts == MAX_INTERRUPTS)) {
-		perf_log_throttle(event, 1);
-		event->hw.interrupts = 0;
-	}
+	if (unlikely(event->hw.interrupts == MAX_INTERRUPTS))
+		perf_event_unthrottle(event, false);
 
 	perf_pmu_disable(event->pmu);
 
@@ -4393,12 +4424,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 
 		hwc = &event->hw;
 
-		if (hwc->interrupts == MAX_INTERRUPTS) {
-			hwc->interrupts = 0;
-			perf_log_throttle(event, 1);
-			if (!is_event_in_freq_mode(event))
-				event->pmu->start(event, 0);
-		}
+		if (hwc->interrupts == MAX_INTERRUPTS)
+			perf_event_unthrottle_group(event, is_event_in_freq_mode(event));
 
 		if (!is_event_in_freq_mode(event))
 			continue;
@@ -6426,14 +6453,6 @@ static void __perf_event_period(struct perf_event *event,
 	active = (event->state == PERF_EVENT_STATE_ACTIVE);
 	if (active) {
 		perf_pmu_disable(event->pmu);
-		/*
-		 * We could be throttled; unthrottle now to avoid the tick
-		 * trying to unthrottle while we already re-started the event.
-		 */
-		if (event->hw.interrupts == MAX_INTERRUPTS) {
-			event->hw.interrupts = 0;
-			perf_log_throttle(event, 1);
-		}
 		event->pmu->stop(event, PERF_EF_UPDATE);
 	}
 
@@ -6441,6 +6460,14 @@ static void __perf_event_period(struct perf_event *event,
 
 	if (active) {
 		event->pmu->start(event, PERF_EF_RELOAD);
+		/*
+		 * Once the period is force-reset, the event starts immediately.
+		 * But the event/group could be throttled. Unthrottle the
+		 * event/group now to avoid the next tick trying to unthrottle
+		 * while we already re-started the event/group.
+		 */
+		if (event->hw.interrupts == MAX_INTERRUPTS)
+			perf_event_unthrottle_group(event, true);
 		perf_pmu_enable(event->pmu);
 	}
 }
@@ -10331,8 +10358,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
 		__this_cpu_inc(perf_throttled_count);
 		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
-		hwc->interrupts = MAX_INTERRUPTS;
-		perf_log_throttle(event, 0);
+		perf_event_throttle_group(event);
 		ret = 1;
 	}
 
-- 
2.38.1

