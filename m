Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AD27FD6A;
	Thu, 24 Apr 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511101; cv=none; b=DdxGIAXhy/jdbvRxNc8p2F8pNkzj3ukBovUs3N2T4x0Vip+cqZSVNQRwkm3ofuT2cyqdVIyq92lw6OYVvTpuANkPsxd5bGN+fVzMXrDl20rx8YthExPXbMybknVnefs+q7suCvBU0KLCi0jJkdkM8CKyyzK6gjYMEI+s5TpOcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511101; c=relaxed/simple;
	bh=WIN1ACm5TPwenVhT3KIYFpuUDxEvnWaUqxH62Jen2As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI6pztvJnepF6f1BgdYeM5vMywWmpdHjnPcaCbTxbAi/x63ZIu5keHtzZW+drqOFPLz8VswChvYFOz/p9pQyPsS+L1NyGpkKXPG1yuNxcLgJhOw0Foll8MGvDUBiCYIujkloH9Eq3h3SwKFhulzwMpmG1sBMqWMYhsihQNYT4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze0s5rn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze0s5rn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7E2C4CEE3;
	Thu, 24 Apr 2025 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511101;
	bh=WIN1ACm5TPwenVhT3KIYFpuUDxEvnWaUqxH62Jen2As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ze0s5rn90jKoJ9wE20KrfbujQxYEsvHL3fWFFfS+rHNCaPdj1HLj+MFZHWTAqPZue
	 weRmhuOCEmmENsD4TMKbmu7Y/hWMuMrcSPwG01+5Oh9Ias6B0BpfThZb+/6RUBGFhA
	 pdXUKTWa61JxJwwNXbAl+P7MnDUbQqGKud7+pPLjEpDcN5nwWVl4TzmfJJ+9ZJT7uh
	 fA7ArP3popdHYZl6VScFn8KNh1ImHve80btvmGQKmap7UznRIVsIFl2ftRVRzpQnic
	 5jCt+2TW3/RCV7lCTK9s/oOLHOXmgBEn2hbbr/JW/tV+2L4UF1MfuDiCNiL+CtDCtY
	 UAjFbFlMk94bA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf: Fix irq work dereferencing garbage
Date: Thu, 24 Apr 2025 18:11:26 +0200
Message-ID: <20250424161128.29176-3-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424161128.29176-1-frederic@kernel.org>
References: <20250424161128.29176-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following commit:

	da916e96e2de ("perf: Make perf_pmu_unregister() useable")

has introduced two significant event's parent lifecycle changes:

1) An event that has exited now has EVENT_TOMBSTONE as a parent.
   This can result in a situation where the delayed wakeup irq_work can
   accidentally dereference EVENT_TOMBSTONE on:

CPU 0                                          CPU 1
-----                                          -----

__schedule()
    local_irq_disable()
    rq_lock()
    <NMI>
    perf_event_overflow()
        irq_work_queue(&child->pending_irq)
    </NMI>
    perf_event_task_sched_out()
        raw_spin_lock(&ctx->lock)
        ctx_sched_out()
        ctx->is_active = 0
        event_sched_out(child)
        raw_spin_unlock(&ctx->lock)
                                              perf_event_release_kernel(parent)
                                                  perf_remove_from_context(child)
                                                  raw_spin_lock_irq(&ctx->lock)
                                                  // Sees !ctx->is_active
                                                  // Removes from context inline
                                                  __perf_remove_from_context(child)
                                                      perf_child_detach(child)
                                                          event->parent = EVENT_TOMBSTONE
    raw_spin_rq_unlock_irq(rq);
    <IRQ>
    perf_pending_irq()
        perf_event_wakeup(child)
            ring_buffer_wakeup(child)
                rcu_dereference(child->parent->rb) <--- CRASH

This also concerns the call to kill_fasync() on parent->fasync.

2) The final parent reference count decrement can now happen before the
   the final child reference count decrement. ie: the parent can now
   be freed before its child. On PREEMPT_RT, this can result in a
   situation where the delayed wakeup irq_work can accidentally
   dereference a freed parent:

CPU 0                                          CPU 1                              CPU 2
-----                                          -----                              ------

perf_pmu_unregister()
    pmu_detach_events()
       pmu_get_event()
           atomic_long_inc_not_zero(&child->refcount)

                                               <NMI>
                                               perf_event_overflow()
                                                   irq_work_queue(&child->pending_irq);
                                               </NMI>
                                               <IRQ>
                                               irq_work_run()
                                                   wake_irq_workd()
                                               </IRQ>
                                               preempt_schedule_irq()
                                               =========> SWITCH to workd
                                               irq_work_run_list()
                                                   perf_pending_irq()
                                                       perf_event_wakeup(child)
                                                           ring_buffer_wakeup(child)
                                                               event = child->parent

                                                                                  perf_event_release_kernel(parent)
                                                                                      // Not last ref, PMU holds it
                                                                                      put_event(child)
                                                                                      // Last ref
                                                                                      put_event(parent)
                                                                                          free_event()
                                                                                              call_rcu(...)
                                                                                  rcu_core()
                                                                                      free_event_rcu()

                                                               rcu_dereference(event->rb) <--- CRASH

This also concerns the call to kill_fasync() on parent->fasync.

The "easy" solution to 1) is to check that event->parent is not
EVENT_TOMBSTONE on perf_event_wakeup() (including both ring buffer
and fasync uses).

The "easy" solution to 2) is to turn perf_event_wakeup() to wholefully
run under rcu_read_lock().

However because of 2), sanity would prescribe to make event::parent
an __rcu pointer and annotate each and every users to prove they are
reliable.

Propose an alternate solution and restore the stable pointer to the
parent until all its children have called _free_event() themselves to
avoid any further accident. Also revert the EVENT_TOMBSTONE design
that is mostly here to determine which caller of perf_event_exit_event()
must perform the refcount decrement on a child event matching the
increment in inherit_event().

Arrange instead for checking the attach state of an event prior to its
removal and decrement the refcount of the child accordingly.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/events/core.c | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7bcb02ffb93a..968a1d14bc8b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -208,7 +208,6 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)
-#define EVENT_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
 {
@@ -2338,12 +2337,6 @@ static void perf_child_detach(struct perf_event *event)
 
 	sync_child_event(event);
 	list_del_init(&event->child_list);
-	/*
-	 * Cannot set to NULL, as that would confuse the situation vs
-	 * not being a child event. See for example unaccount_event().
-	 */
-	event->parent = EVENT_TOMBSTONE;
-	put_event(parent_event);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -2469,6 +2462,11 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 #define DETACH_REVOKE	0x08UL
 #define DETACH_DEAD	0x10UL
 
+struct perf_remove_data {
+	unsigned int detach_flags;
+	unsigned int old_state;
+};
+
 /*
  * Cross CPU call to remove a performance event
  *
@@ -2483,28 +2481,30 @@ __perf_remove_from_context(struct perf_event *event,
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 	enum perf_event_state state = PERF_EVENT_STATE_OFF;
-	unsigned long flags = (unsigned long)info;
+	struct perf_remove_data *prd = info;
 
 	ctx_time_update(cpuctx, ctx);
 
+	prd->old_state = event->attach_state;
+
 	/*
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_EXIT)
+	if (prd->detach_flags & DETACH_EXIT)
 		state = PERF_EVENT_STATE_EXIT;
-	if (flags & DETACH_REVOKE)
+	if (prd->detach_flags & DETACH_REVOKE)
 		state = PERF_EVENT_STATE_REVOKED;
-	if (flags & DETACH_DEAD) {
+	if (prd->detach_flags & DETACH_DEAD) {
 		event->pending_disable = 1;
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
 	perf_event_set_state(event, min(event->state, state));
 
-	if (flags & DETACH_GROUP)
+	if (prd->detach_flags & DETACH_GROUP)
 		perf_group_detach(event);
-	if (flags & DETACH_CHILD)
+	if (prd->detach_flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
@@ -2541,7 +2541,7 @@ __perf_remove_from_context(struct perf_event *event,
  * When called from perf_event_exit_task, it's OK because the
  * context has been detached from its task.
  */
-static void perf_remove_from_context(struct perf_event *event, unsigned long flags)
+static void perf_remove_from_context(struct perf_event *event, struct perf_remove_data *prd)
 {
 	struct perf_event_context *ctx = event->ctx;
 
@@ -2555,13 +2555,13 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	raw_spin_lock_irq(&ctx->lock);
 	if (!ctx->is_active) {
 		__perf_remove_from_context(event, this_cpu_ptr(&perf_cpu_context),
-					   ctx, (void *)flags);
+					   ctx, (void *)prd);
 		raw_spin_unlock_irq(&ctx->lock);
 		return;
 	}
 	raw_spin_unlock_irq(&ctx->lock);
 
-	event_function_call(event, __perf_remove_from_context, (void *)flags);
+	event_function_call(event, __perf_remove_from_context, (void *)prd);
 }
 
 /*
@@ -5705,7 +5705,7 @@ static void put_event(struct perf_event *event)
 	_free_event(event);
 
 	/* Matches the refcount bump in inherit_event() */
-	if (parent && parent != EVENT_TOMBSTONE)
+	if (parent)
 		put_event(parent);
 }
 
@@ -5718,6 +5718,7 @@ int perf_event_release_kernel(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_event *child, *tmp;
+	struct perf_remove_data prd = { .old_state = 0 };
 
 	/*
 	 * If we got here through err_alloc: free_event(event); we will not
@@ -5747,7 +5748,8 @@ int perf_event_release_kernel(struct perf_event *event)
 	 * child events.
 	 */
 	if (event->state > PERF_EVENT_STATE_REVOKED) {
-		perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
+		prd.detach_flags = DETACH_GROUP | DETACH_DEAD;
+		perf_remove_from_context(event, &prd);
 	} else {
 		event->state = PERF_EVENT_STATE_DEAD;
 	}
@@ -5789,7 +5791,8 @@ int perf_event_release_kernel(struct perf_event *event)
 		tmp = list_first_entry_or_null(&event->child_list,
 					       struct perf_event, child_list);
 		if (tmp == child) {
-			perf_remove_from_context(child, DETACH_GROUP | DETACH_CHILD);
+			prd.detach_flags = DETACH_GROUP | DETACH_CHILD;
+			perf_remove_from_context(child, &prd);
 		} else {
 			child = NULL;
 		}
@@ -13583,11 +13586,12 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 
 	if (move_group) {
-		perf_remove_from_context(group_leader, 0);
+		struct perf_remove_data prd = { 0 };
+		perf_remove_from_context(group_leader, &prd);
 		put_pmu_ctx(group_leader->pmu_ctx);
 
 		for_each_sibling_event(sibling, group_leader) {
-			perf_remove_from_context(sibling, 0);
+			perf_remove_from_context(sibling, &prd);
 			put_pmu_ctx(sibling->pmu_ctx);
 		}
 
@@ -13789,14 +13793,15 @@ static void __perf_pmu_remove(struct perf_event_context *ctx,
 			      struct list_head *events)
 {
 	struct perf_event *event, *sibling;
+	struct perf_remove_data prd = { 0 };
 
 	perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu) {
-		perf_remove_from_context(event, 0);
+		perf_remove_from_context(event, &prd);
 		put_pmu_ctx(event->pmu_ctx);
 		list_add(&event->migrate_entry, events);
 
 		for_each_sibling_event(sibling, event) {
-			perf_remove_from_context(sibling, 0);
+			perf_remove_from_context(sibling, &prd);
 			put_pmu_ctx(sibling->pmu_ctx);
 			list_add(&sibling->migrate_entry, events);
 		}
@@ -13921,11 +13926,7 @@ perf_event_exit_event(struct perf_event *event,
 		      struct perf_event_context *ctx, bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = DETACH_EXIT;
-	bool is_child = !!parent_event;
-
-	if (parent_event == EVENT_TOMBSTONE)
-		parent_event = NULL;
+	struct perf_remove_data prd = {	.detach_flags = DETACH_EXIT };
 
 	if (parent_event) {
 		/*
@@ -13940,29 +13941,36 @@ perf_event_exit_event(struct perf_event *event,
 		 * Do destroy all inherited groups, we don't care about those
 		 * and being thorough is better.
 		 */
-		detach_flags |= DETACH_GROUP | DETACH_CHILD;
+		prd.detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
 	}
 
 	if (revoke)
-		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
+		prd.detach_flags |= DETACH_GROUP | DETACH_REVOKE;
 
-	perf_remove_from_context(event, detach_flags);
+	perf_remove_from_context(event, &prd);
 	/*
 	 * Child events can be freed.
 	 */
-	if (is_child) {
-		if (parent_event) {
-			mutex_unlock(&parent_event->child_mutex);
-			/*
-			 * Kick perf_poll() for is_event_hup();
-			 */
-			perf_event_wakeup(parent_event);
+	if (parent_event) {
+		mutex_unlock(&parent_event->child_mutex);
+		/*
+		 * Kick perf_poll() for is_event_hup();
+		 */
+		perf_event_wakeup(parent_event);
+
+		/*
+		 * Match the refcount initialization. Make sure it doesn't happen
+		 * twice if pmu_detach_event() calls it on an already exited task.
+		 */
+		if (prd.old_state & PERF_ATTACH_CHILD) {
 			/*
 			 * pmu_detach_event() will have an extra refcount.
+			 * perf_pending_task() might have one too.
 			 */
 			put_event(event);
 		}
+
 		return;
 	}
 
@@ -14532,13 +14540,14 @@ static void perf_swevent_init_cpu(unsigned int cpu)
 static void __perf_event_exit_context(void *__info)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_remove_data prd = { .detach_flags = DETACH_GROUP };
 	struct perf_event_context *ctx = __info;
 	struct perf_event *event;
 
 	raw_spin_lock(&ctx->lock);
 	ctx_sched_out(ctx, NULL, EVENT_TIME);
 	list_for_each_entry(event, &ctx->event_list, event_entry)
-		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
+		__perf_remove_from_context(event, cpuctx, ctx, (void *)&prd);
 	raw_spin_unlock(&ctx->lock);
 }
 
-- 
2.48.1

