Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0728314C;
	Wed, 14 May 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235686; cv=none; b=a/8UnEOszOHXniaFOLAt7Dy7e2r1QWghV82PjV7TNq63352bK/O/jMbwL+hl+1wWngtgtHWraiOnZZZQxYBnXnh+w+QYHuTEJ2a3qDGn6v5vlsedr+W5jjME7jK8aJBbLToiAiN7x0h/unPlO+EuQu7X6Yh/g3FKyV4CI4AlRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235686; c=relaxed/simple;
	bh=t6/LBgg+1aMJsZFJL58x9sXMIDVKAcDStYgCa68l14o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/Lf2mD9yvFFJ/HHZry7hNRD9QCqFcXJgGHGjxg9JNkV6B9PPqa9BQ5P6i62UwAm/ESQz52Uc98trwZUqmP+yAaNvQ6cQahuWc0ci0uAqye54grPiGm89PO2zO4uT7W0+uv15yoE3TZYn9SYdLNVTaggAtyMOzpaI3219YJgc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Du1xuYlY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Du1xuYlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235685; x=1778771685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6/LBgg+1aMJsZFJL58x9sXMIDVKAcDStYgCa68l14o=;
  b=Du1xuYlYFNohsp2Ijx7Mxy2bEoSX8UGO8yiRhEHcifEni6NPPWyVdle5
   XEBd3AcNaXZw+yHmHJCC4mLKox2Ytbx/mF9rMnz7VT7qNkE8KD2tk6x3S
   1QSrUqBAhT2gEdBOEFX/6BrPGhCBzaISrxjnA24bbk25lveqmPOjgvuFl
   4B578X/h8S10gP4z0FINVn8Nfu/6Bywoao0MgVsIyt1l7vdVC+zMVC6Hc
   aldNnCAyfQ41UqkeCYFWZPtK9ssdorpKcNAfvY4TSJ9Iptd2EbaFFu73E
   VQ9lnjrusIujQ9Pu8lhG/yNUFhrqBNkqGMyrhD0VweZvcTcllT8P/jNVY
   A==;
X-CSE-ConnectionGUID: +IQBdefzQJejHq0azXge3Q==
X-CSE-MsgGUID: ElBzWMqIQI+JjbQeu6Y4fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072705"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072705"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:43 -0700
X-CSE-ConnectionGUID: FEOF1dHnR6CPlhZtRQDy0g==
X-CSE-MsgGUID: dztFy6CMTf6z/e3GuJlvUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939153"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:42 -0700
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 01/15] perf: Fix the throttle logic for a group
Date: Wed, 14 May 2025 08:13:47 -0700
Message-Id: <20250514151401.2547932-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
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

Changes since V1:
- Apply the suggested throttle/unthrottle functions from Peter.
  The MAX_INTERRUPTS and throttle logs are applied to all events.
- Update the description and comments accordingly

 kernel/events/core.c | 58 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a84abc2b7f20..a270fcda766d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2734,6 +2734,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
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
+static void perf_event_unthrottle_group(struct perf_event *event, bool start)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+
+	perf_event_unthrottle(leader, leader != event || start);
+	for_each_sibling_event(sibling, leader)
+		perf_event_unthrottle(sibling, sibling != event || start);
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
@@ -4389,10 +4422,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		hwc = &event->hw;
 
 		if (hwc->interrupts == MAX_INTERRUPTS) {
-			hwc->interrupts = 0;
-			perf_log_throttle(event, 1);
-			if (!event->attr.freq || !event->attr.sample_freq)
-				event->pmu->start(event, 0);
+			perf_event_unthrottle_group(event,
+				!event->attr.freq || !event->attr.sample_freq);
 		}
 
 		if (!event->attr.freq || !event->attr.sample_freq)
@@ -6421,14 +6452,6 @@ static void __perf_event_period(struct perf_event *event,
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
 
@@ -6436,6 +6459,14 @@ static void __perf_event_period(struct perf_event *event,
 
 	if (active) {
 		event->pmu->start(event, PERF_EF_RELOAD);
+		/*
+		 * Once the period is force-reset, the event starts immediately.
+		 * But the event/group could be throttled. Unthrottle the
+		 * event/group now to avoid the next tick trying to unthrottle
+		 * while we already re-started the event/group.
+		 */
+		if (event->hw.interrupts == MAX_INTERRUPTS)
+			perf_event_unthrottle_group(event, false);
 		perf_pmu_enable(event->pmu);
 	}
 }
@@ -10326,8 +10357,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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

