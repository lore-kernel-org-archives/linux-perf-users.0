Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAEC29A1;
	Fri, 20 Dec 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688929; cv=none; b=ITZhF6ehNX23J7uvXhqevvoPVsJmcZED3Pxpa0/8PpZ1pYjURg0vxvuyacFkc8XMwemBH4yu2xRCdT/s0B0a7W5xSHkoGDtUGLzPH9O58XxFyYZk1aym+O3XHqvUkyFcjaAHlbii1b9WoGMRwmZmhbtpqThmd85gqShNoYeLpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688929; c=relaxed/simple;
	bh=QHJxK24r7yicZ2O7jHQ4CVK+H4K4RQjAIxpMF/38D84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tm1dPMyOL7Hr5YzwgO1RETuZVuZFFJwS9XQGSvyO2Ze8cD9IopenmVqHQD06A+S5EDavvcEAyPSf0Q6tMWR9cMN6FFYy5rriJpjg5xhz8v245FzIm/PKicDM90CBN8hW/sUNHvyM6RvXalHUbKDzuUuH+9GN8F6oQiyYxr0zo/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64056339;
	Fri, 20 Dec 2024 02:02:34 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 674C23F720;
	Fri, 20 Dec 2024 02:02:04 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2] events/core: fix acoount failure for event's total_enable_time
Date: Fri, 20 Dec 2024 10:02:02 +0000
Message-Id: <20241220100202.804062-1-yeoreum.yun@arm.com>
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
armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440

 Performance counter stats for 'stress-ng --pthread=2 -t 2s':

     1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
     1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)

Since above two events are belong to the same task context and
mutually-exclusive per cpu (they couldn't be active at the same time on the same cpu),
the total_enable_time should be the same (the 2nd number among 3 numbers)
and the summation of ratio should be 100%.

This account failure of total_enable_time for event could happen in below sequence.

1. two event opened with:
   - first event (e0) is opened with pmu0(p0) which could be added on CPU0.
   - second event (e1) is opened with pmu1(p1) which could be added on CPU1.
   - these two event belongs to the same task_ctx.

   at this point:
     task_ctx->time = 0
     e0->total_enable_time = 0
     e0->total_running_time = 0
     e1->total_enable_time = 0
     e1->total_running_time = 0

2. the task_ctx is sched in CPU0.
   - In ctx_sched_in(), the task_ctx->time doesn't updated.
   - In event_sched_in() e0 is activated so, its state becomes ACTIVE.
   - In event_sched_in() e1 is activated, but soon becomes !ACTIVE
     because pmu1 doesn't support CPU1 so it failed in pmu1->add().

   at this point:
     task_ctx->time = 0
     e0->total_enable_time = 0
     e0->total_running_time = 0
     e1->total_enable_time = 0
     e1->total_running_time = 0

3. the task_ctx is sched out from CPU0. and suppose scheulded time as t1.
   - In ctx_sched_out(), the task_ctx->time updated with t1.
   - e0 was ACTIVE, so In event_sched_out(),
     e0->total_enable_time and e0->total_running_time are updated with t1.
   - e1 was !ACTIVE, so it doesn't update
     e1->total_enable_time and e1->total_running_time.

   at this point:
     task_ctx->time = t1
     e0->total_enable_time = t1
     e0->total_running_time = t1
     e1->total_enable_time = 0
     e1->total_running_time = 0

4. the task_ctx is sched in to CPU1.
   - task_ctx->time doesn't changed.
   - In event_sched_in() e0 is activated, but soon becomes !ACTIVE
     because pmu1 doesn't support CPU1 so it failed in pmu1->add().
   - In event_sched_in() e1 is activated, and when it changes event
     state to ACTIVE, e1->total_enable_time is updated with
     task_ctx->time.

   at this point:
   task_ctx->time = t1
   e0->total_enable_time = t1
   e0->total_running_time = t1
   e1->total_enable_time = t1
   e1->total_running_time = 0

5. the task_ctx is sched out from CPU1. and suppose scheulded time as t2.
   - In ctx_sched_out(), the task_ctx->time updated with t1 + t2.
   - e0 was !ACTIVE, so it doesn't update
     e0->total_enable_time and e0->total_running_time.
   - e1 was ACTIVE, so In event_sched_out(),
     e1->total_enable_time and e1->total_running_time are updated with t2.

   at this point:
     task_ctx->time = t1 + t2
     e0->total_enable_time = t1
     e0->total_running_time = t1
     e1->total_enable_time = t1 + t2
     e1->total_running_time = t2

6. the task_ctx is sched in CPU0 again.
   - task_ctx->time doesn't changed.
   - In event_sched_in() e0 is activated, and when it changes event
     state to ACTIVE, e0->total_enable_time is updated with
     task_ctx->time.
   - In event_sched_in() e1 is activated, but soon becomes !ACTIVE
     because pmu1 doesn't support CPU1 so it failed in pmu1->add().

   at this point:
     task_ctx->time = t1 + t2
     e0->total_enable_time = t1 + t2
     e0->total_running_time = t1
     e1->total_enable_time = t1 + t2
     e1->total_running_time = t2

7. the task exit and task_ctx is sched out. and suppose scheulded time as t3.
   - In ctx_sched_out(), the task_ctx->time updated with t1 + t2 + t3.
   - e0 was ACTIVE, so In event_sched_out(),
     e0->total_enable_time and e1->total_running_time are updated with t3.
   - e1 was !ACTIVE, so it doesn't update
     e1->total_enable_time and e1->total_running_time.

   at this point:
     task_ctx->time = t1 + t2 + t3
     e0->total_enable_time = t1 + t2 +t3
     e0->total_running_time = t1 + t3
     e1->total_enable_time = t1 + t2
     e1->total_running_time = t2

In step 7, amount of t3 enable time is missing in e1.
So, the perf prints error ratio for total_running_time/total_enable_time
for e1.

Here is the summary of change of time as timeline:

               CPU0                  CPU1                     CPU0
          |  in | out |       | in | out     |       | in      | out (exit)   |
------------------------------------------------------------------------------
ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
------------------------------------------------------------------------------
e0->ena   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t2 + t3 |
------------------------------------------------------------------------------
e0->run   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t3      |
------------------------------------------------------------------------------
e1->ena   |  0  | 0   |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2      |
------------------------------------------------------------------------------
e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
------------------------------------------------------------------------------

To address this, update total_enable_time in event_sched_out() when event state
is PERF_EVENT_STATE_INACTIVE.

After this patch, this problem is gone like:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
...
armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940

 Performance counter stats for 'stress-ng --pthread=2 -t 10s':

    15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
    22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 kernel/events/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..308850449a84 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2311,6 +2311,11 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);

+	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		perf_event_update_time(event);
+		return;
+	}
+
 	if (event->state != PERF_EVENT_STATE_ACTIVE)
 		return;

@@ -2351,7 +2356,7 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 {
 	struct perf_event *event;

-	if (group_event->state != PERF_EVENT_STATE_ACTIVE)
+	if (group_event->state < PERF_EVENT_STATE_INACTIVE)
 		return;

 	perf_assert_pmu_disabled(group_event->pmu_ctx->pmu);
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

