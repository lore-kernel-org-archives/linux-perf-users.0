Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225820F07E;
	Fri,  6 Jun 2025 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749237985; cv=none; b=JlOuUJMCik88E84D5B4SKKTqAUx7jXAAs7T3eesgWv0/mYJtee1IaHsrSnLmxqdS8OPiyopMnRTMCtlkIcvmTIUO+FH7jLXjUXSMTC4YXr2OKYHjw341GFLXjRClFiwVnUn9ROW1E0ql+G8eVSnonFTxRn/rxSnM2HuWqdbxd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749237985; c=relaxed/simple;
	bh=eQ2dskS72qyDCGS/gcS1WruDT9RQ+RjLSHe5YZogRwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aSGBQlDXCt7gMGcJNIsF7fTu5X6u68BLirOjLS21JgflTD3EENuRKaVQqYSgnIZG/nSIdDVpc74ULFKSn19wDrM88DprULmMtKetqX7HJFB05uaO1wvIHPVFbfwXGVlP7ptjoYSUkqT5prTNQKVTgyieErGO+KaVv1LwwrlZy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5bQE7m/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5bQE7m/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749237984; x=1780773984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eQ2dskS72qyDCGS/gcS1WruDT9RQ+RjLSHe5YZogRwQ=;
  b=n5bQE7m/FRHInqDlOUjjh7aEhEny2PeqQVYjyiv8wTrukM99/2K86Q6t
   ns40H2/WtuE+3pvP0DVIxeGtcpazA/P9r5hhdISwzocbVy5xuY/0z+v0y
   2cUg7E8J3Y8OTFe3E/Otqv5NoRiYN6+n2u2f/J02/M8+i6c2oayDUjnP7
   Ny8/xHV5LpzAUUBxnb0v9srrb+bA0Z1uqOanAMY4Ud+Ylfxw9iNjoSqeA
   SfCnhI9sDX2mP+yDqnocIUcvAKPY3wGnPvvy2lJ5TrARgI89V6Xjn6ZaJ
   nAlwRzthmoKpBYDf0K+lDyeYnls3Ra6ybkGJWieWrr9GA8kGURA23UrJ4
   w==;
X-CSE-ConnectionGUID: b9JInJAEQfqB2a3RnQxuvg==
X-CSE-MsgGUID: VTodKeDsSJCcuA5BVpjtQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51541681"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="51541681"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 12:26:23 -0700
X-CSE-ConnectionGUID: 3Lm5fxB6QWOfTicoSqtyBg==
X-CSE-MsgGUID: 87uFDH2ERoCHAvK6kca6hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="169101100"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jun 2025 12:26:22 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH V4] perf: Fix the throttle error of some clock events
Date: Fri,  6 Jun 2025 12:25:46 -0700
Message-Id: <20250606192546.915765-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Both ARM and IBM CI reports RCU stall, which can be reproduced by the
below perf command.
  perf record -a -e cpu-clock -- sleep 2

The issue is introduced by the generic throttle patch set, which
unconditionally invoke the event_stop() when throttle is triggered.

The cpu-clock and task-clock are two special SW events, which rely on
the hrtimer. The throttle is invoked in the hrtimer handler. The
event_stop()->hrtimer_cancel() waits for the handler to finish, which is
a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
be used to stop the timer.

There may be two ways to fix it.
- Introduce a PMU flag to track the case. Avoid the event_stop in
  perf_event_throttle() if the flag is detected.
  It has been implemented in the
  https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
  The new flag was thought to be an overkill for the issue.
- Add a check in the event_stop. Return immediately if the throttle is
  invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
  method to stop the timer.

The latter is implemented here.

Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
the order the same as perf_event_unthrottle(). Except the patch, no one
checks the hw.interrupts in the stop(). There is no impact from the
order change.

When stops in the throttle, the event should not be updated,
stop(event, 0). But the cpu_clock_event_stop() doesn't handle the flag.
In logic, it's wrong. But it didn't bring any problems with the old
code, because the stop() was not invoked when handling the throttle.
Checking the flag before updating the event.

Reported-by: Leo Yan <leo.yan@arm.com>
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Closes: https://lore.kernel.org/lkml/4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu/
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The patch is to fix the issue introduced by

  9734e25fbf5a perf: Fix the throttle logic for a group

It is still in the tip.git, I'm not sure if the commit ID is valid. So
the Fixes tag is not added.

There are some discussions regarding to a soft lockup issue.
That is an existing issue, which are not introduced by the above change.
It should be fixed separately.
https://lore.kernel.org/lkml/CAADnVQ+Lx0HWEM8xdLC80wco3BTUPAD_2dQ-3oZFiECZMcw2aQ@mail.gmail.com/

Changes since V3:
- Check before update in event_stop()
- Add Reviewed-by from Ian

 kernel/events/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..cc77f127e11a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 
 static void perf_event_throttle(struct perf_event *event)
 {
-	event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
+	event->pmu->stop(event, 0);
 	if (event == event->group_leader)
 		perf_log_throttle(event, 0);
 }
@@ -11749,7 +11749,12 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (is_sampling_event(event)) {
+	/*
+	 * The throttle can be triggered in the hrtimer handler.
+	 * The HRTIMER_NORESTART should be used to stop the timer,
+	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 */
+	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
@@ -11804,7 +11809,8 @@ static void cpu_clock_event_start(struct perf_event *event, int flags)
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
 	perf_swevent_cancel_hrtimer(event);
-	cpu_clock_event_update(event);
+	if (flags & PERF_EF_UPDATE)
+		cpu_clock_event_update(event);
 }
 
 static int cpu_clock_event_add(struct perf_event *event, int flags)
@@ -11882,7 +11888,8 @@ static void task_clock_event_start(struct perf_event *event, int flags)
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
 	perf_swevent_cancel_hrtimer(event);
-	task_clock_event_update(event, event->ctx->time);
+	if (flags & PERF_EF_UPDATE)
+		task_clock_event_update(event, event->ctx->time);
 }
 
 static int task_clock_event_add(struct perf_event *event, int flags)
-- 
2.38.1

