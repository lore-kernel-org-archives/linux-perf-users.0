From: Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf_events: fix rcu and locking issues with
	cgroup support
Date: Fri, 18 Feb 2011 14:40:01 +0200
Message-ID: <4d5e76b8.815bdf0a.7ac3.774f@mx.google.com>
Reply-To: eranian@google.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <perfmon2-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=perfmon2-devel>
List-Post: <mailto:perfmon2-devel@lists.sourceforge.net>
List-Help: <mailto:perfmon2-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: perfmon2-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: perfmon2-devel@lists.sf.net, linux-perf-users@vger.kernel.org, eranian@gmail.com, peterz@infradead.org, fweisbec@gmail.com, eranian@google.com, acme@redhat.com, paulus@samba.org, mingo@elte.hu, davem@davemloft.net
List-Id: linux-perf-users.vger.kernel.org

This patches ensures that we do not end up calling
perf_cgroup_from_task() when there is no cgroup event.
This avoids potential RCU and locking issues.

The change in perf_cgroup_set_timestamp() ensures we
check against ctx->nr_cgroups. It also avoids calling
perf_clock() tiwce in a row. It also ensures we do need
to grab ctx->lock before calling the function.

We drop update_cgrp_time() from task_clock_event_read()
because it is not needed. This also avoids having to
deal with perf_cgroup_from_task().

Thanks to Peter Zijlstra for his help on this.

Signed-off-by: Stephane Eranian <eranian@gmail.com>
---

diff --git a/kernel/perf_event.c b/kernel/perf_event.c
index a0a6987..438d73a 100644
--- a/kernel/perf_event.c
+++ b/kernel/perf_event.c
@@ -201,6 +201,11 @@ __get_cpu_context(struct perf_event_context *ctx)
 
 #ifdef CONFIG_CGROUP_PERF
 
+/*
+ * must ensure cgroup is pinned (css_get) before calling
+ * this function. In other words, we cannot call this function
+ * if there is no cgroup event for the current CPU context.
+ */
 static inline struct perf_cgroup *
 perf_cgroup_from_task(struct task_struct *task)
 {
@@ -268,28 +273,41 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
 
 static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
-	struct perf_cgroup *cgrp = perf_cgroup_from_task(current);
+	struct perf_cgroup *cgrp;
+
 	/*
-	 * do not update time when cgroup is not active
+	 * ensure we access cgroup data only when needed and
+	 * when we know the cgroup is pinned (css_get)
 	 */
-	if (!event->cgrp || cgrp != event->cgrp)
+	if (!is_cgroup_event(event))
 		return;
 
-	__update_cgrp_time(event->cgrp);
+	cgrp = perf_cgroup_from_task(current);
+	/*
+	 * do not update time when cgroup is not active
+	 */
+	if (cgrp == event->cgrp)
+		__update_cgrp_time(event->cgrp);
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct task_struct *task, u64 now)
+perf_cgroup_set_timestamp(struct task_struct *task,
+			  struct perf_event_context *ctx)
 {
 	struct perf_cgroup *cgrp;
 	struct perf_cgroup_info *info;
 
-	if (!task)
+	/*
+	 * ctx->lock held by caller
+	 * ensure we do not access cgroup data
+	 * unless we have the cgroup pinned (css_get)
+	 */
+	if (!task || !ctx->nr_cgroups)
 		return;
 
 	cgrp = perf_cgroup_from_task(task);
 	info = this_cpu_ptr(cgrp->info);
-	info->timestamp = now;
+	info->timestamp = ctx->timestamp;
 }
 
 #define PERF_CGROUP_SWOUT	0x1 /* cgroup switch out every event */
@@ -494,7 +512,8 @@ static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct task_struct *task, u64 now)
+perf_cgroup_set_timestamp(struct task_struct *task,
+			  struct perf_event_context *ctx)
 {
 }
 
@@ -1613,7 +1632,7 @@ static int __perf_event_enable(void *info)
 	/*
 	 * set current task's cgroup time reference point
 	 */
-	perf_cgroup_set_timestamp(current, perf_clock());
+	perf_cgroup_set_timestamp(current, ctx);
 
 	__perf_event_mark_enabled(event, ctx);
 
@@ -2048,7 +2067,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 
 	now = perf_clock();
 	ctx->timestamp = now;
-	perf_cgroup_set_timestamp(task, now);
+	perf_cgroup_set_timestamp(task, ctx);
 	/*
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
@@ -5795,7 +5814,6 @@ static void task_clock_event_read(struct perf_event *event)
 
 	if (!in_nmi()) {
 		update_context_time(event->ctx);
-		update_cgrp_time_from_event(event);
 		time = event->ctx->time;
 	} else {
 		u64 now = perf_clock();

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
