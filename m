Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C61993B9;
	Wed, 26 Mar 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977211; cv=none; b=DjGTcsXutNzoOqdp1HMWP2A+JP2Xy3GEU0cmB0otc076xLu9jndghSIMkLuZFRAQv+84pqal/t7glEIBGPr39IzrFmc3Z5dWIF50xjs1OhNYj/GLYmqI61ehIZMEBU/zlvPYmpssDyy217EHbCInMWtMKW4MNPk3xcuS79CoAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977211; c=relaxed/simple;
	bh=qfShk4bhL7iYGDRb7/pk26sSvncKfUcnktfK3iLgfGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qz1xbii5BwiXuOO5baNOp8hmFF0zjXqoBW4PuH5RYCtFmA/vAH4O36X1wiRqMZp6JrM1/+OlXR0V7zZaT7KaYtykXGYNsh5WFTQ4p5zV9k/Yas0bLryFJL1lG5OxF2OpdCJnJmFAcpp47qUdJ+b8znZdDNsQMmeCRASMsvwjLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A95991596;
	Wed, 26 Mar 2025 01:20:14 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 604933F63F;
	Wed, 26 Mar 2025 01:20:06 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	elver@google.com,
	leo.yan@arm.com,
	james.clark@linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@arm.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v5 1/1] events/core: fix failure case for accounting child_total_enable_time at task exit
Date: Wed, 26 Mar 2025 08:20:03 +0000
Message-Id: <20250326082003.1630986-1-yeoreum.yun@arm.com>
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

Here is a failure case for accounting total_enable_time for
CPU PMU events:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
...

armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
                           `          `          `
                           `          `          > total_time_running with child
                           `          > total_time_enabled with child
                           > count with child

Performance counter stats for 'stress-ng --pthread=2 -t 2s':

     1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
     1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)

The two events above are opened on two different CPU PMUs, for example,
each event is opened for a cluster in an Arm big.LITTLE system, they
will never run on the same CPU.  In theory, the total enabled time should
be same for both events, as two events are opened and closed together.

As the result show, the two events' total enabled time including
child event are different (2289429840 vs 1950025700).
This is because child events are not accounted properly
if a event is INACTIVE state when the task exits:

perf_event_exit_event()
 `> perf_remove_from_context()
   `> __perf_remove_from_context()
     `> perf_child_detach()   -> Accumulate child_total_time_enabled
       `> list_del_event()    -> Update child event's time

The problem is the time accumulation happens prior to child event's time
updating. Thus, it misses to account the last period's time when event
exits.

The perf core layer follows the rule that timekeeping is tied to state
change. To address the issue, make __perf_remove_from_context() to
handle task exit case by passing the 'DETACH_EXIT' to it and
invokes perf_event_state() for state alongside with accouting the time.
Then, perf_child_detach() populates the time into parent's time metrics.

After this patch, this problem is gone like:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
...
armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940

 Performance counter stats for 'stress-ng --pthread=2 -t 10s':

    15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
    22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: ef54c1a476aef ("perf: Rework perf_event_exit_event()")
---
 kernel/events/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 823aa0824916..f191e92c2f48 100644
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
@@ -13448,12 +13453,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
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

