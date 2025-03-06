Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A9F1FC0E5;
	Thu,  6 Mar 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264439; cv=none; b=WRdFQmF+/wpdJAVnBwth7ZEiRn8LwYnA1OKbUZXHrz/85ssSg6KmYOnf9lVy+tsCljeX69hsuhT6TqJFKWIGQ7g9K77u/rw6jm082o8Wunpfw1Sly0IbyofwKkTW54F+Cnoi76xOH/B0MeH88eW2EDPVTUUMRoiD7AUKvuvLtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264439; c=relaxed/simple;
	bh=aGjzBpT0G0t8eJj0mKb/W8C/c3s44EYZ+Jb75+aXYak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CEoi/ke9l+wXu5Q6N11p75oFGIBgfSYpsnrCZyojNqeeWtL+mU6XgOkeuOMmP7OwCyTb35mDrjXIfp/i7kmAowrMorZqB3f6oyLwsVBJrfA61g2HlMXGOiZ4yapc9CmcNmwyZOKvA5zutA8SmN5jjKR775fiAdU85akLLINHg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9601C1007;
	Thu,  6 Mar 2025 04:34:09 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FB523F673;
	Thu,  6 Mar 2025 04:33:54 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: mingo@kernel.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	Mark.Rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	leo.yan@arm.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4] events/core: fix acoount failure for event's child_total_enable_time at task exit
Date: Thu,  6 Mar 2025 12:33:50 +0000
Message-Id: <20250306123350.1650114-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf core code fails to account for total_enable_time of event
when its state is inactive.

Here is the error case for failure to account for total_enable_time for
core event:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
...

/*
 * three number represetns each
 *   scaled count / total_enable_time / total_total_running_time
 */
armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
                                      ^^^^^^^^^^
armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
                                      ^^^^^^^^^^

 Performance counter stats for 'stress-ng --pthread=2 -t 2s':

     1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
     1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)

Since above two events are belong to the same task context and
mutually-exclusive per cpu (they couldn't be active at the same time on the same cpu),
the total_enable_time should be the same (marked with ^^^^^^^^^^^)
and the summation of ratio should be 100%.

This account failure of total_enable_time because of
account failure of child_total_enable_time of child event when
child task exit.

Below table explains how the child_total_enable_time is failed to account at
exiting child task which switch cpus as time passes by (CPU0 -> CPU1 -> CPU0)

 - in means sched_in.
 - out means sched_out.
 - exit means at the exit of child task.
   NOTE: the value is before calling list_del_event(). which mean
         the value at exit column will be added at parent event's
          child_total_enable_time when child task exit.
 - ctx is the child_task_ctx,
 - e0 is the child_event which set with cpu == -1 and opened with pmu0 only
   added in CPU0,
 - e1 is the child_event which set with cpu == -1 and opened with pmu1 only
   added in CPU1,
 - e0 and e1 belongs to same child_task_ctx.

          CPU0 (run t1)        CPU1 (run t2)          CPU0 (run t3)
          |  in | out |       | in  | out     |       | in      | exit        |
------------------------------------------------------------------------------
ctx->time |  0  | t1  |       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2 + t3|
------------------------------------------------------------------------------
e0->ena   |  0  | t1  |       | t1  | t1     *|       | t1 + t2 | t1 + t2 + t3|
------------------------------------------------------------------------------
e0->run   |  0  | t1  |       | t1  | t1     *|       | t1      | t1 + t3     |
------------------------------------------------------------------------------
e1->ena   |  0  | 0  *|       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2    X|
------------------------------------------------------------------------------
e1->run   |  0  | 0  *|       | 0   | t2      |       | t2      | t2         X|
------------------------------------------------------------------------------

The value marked with * means it doesn't updates since event->state was
INACTIVE.

Please see the last CPU0's column with exit (marked with X).
Since e1's state is INACTIVE its total_enable_time doesn't update
and it remains with former value without accounting t3 time.

In this situation, at __perf_remove_from_context() while exit child_task,
sync_child_event() where adds child_event's total_enable_time to
parent event's child_total_enable_time in perf_child_detach() is called
before list_del_event() in which event time is updated by setting
the event state as OFF.
That means child_total_enable_time is added with missing
amount of last enable time -- t3.

In case of parent event's total_enable_time is updated properly in
list_del_event() when the task exit.
However, the child_total_enable_time is missed when child_task exited,
the perf prints error amount of enable_time (which is summation of
total_enable_time + child_total_enable_time).

To address this, update event state via perf_event_state() in
__perf_remove_from_context() and call it before perf_child_detach()
where parent's total_enable_time is updated.

After this patch, this problem is gone like:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
...
armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940

 Performance counter stats for 'stress-ng --pthread=2 -t 10s':

    15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
    22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Suggsted-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6364319e2f88..058533a50493 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2407,6 +2407,7 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x08UL

 /*
  * Cross CPU call to remove a performance event
@@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   void *info)
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;

 	ctx_time_update(cpuctx, ctx);
@@ -2429,16 +2431,19 @@ __perf_remove_from_context(struct perf_event *event,
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_DEAD)
+	if (flags & DETACH_EXIT)
+		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
+		state = PERF_EVENT_STATE_DEAD;
+	}
 	event_sched_out(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
-	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;

 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
@@ -13424,12 +13429,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		mutex_lock(&parent_event->child_mutex);
 	}

-	perf_remove_from_context(event, detach_flags);
-
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state > PERF_EVENT_STATE_EXIT)
-		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, detach_flags | DETACH_EXIT);

 	/*
 	 * Child events can be freed.
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

