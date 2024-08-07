Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335E1E4EFB;
	Wed,  7 Aug 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031793; cv=none; b=IjOwfEuWMBhx1/24sd0BGksJDLu5kJreH86/uSm82X1BUNpvbjJYh6PsFBoPXSswEbgaAjuGJ8ZlQrrzHvM5rGGjJZpefWfpU/VvgOqgBaRd2tIfK3UEGnREqF+Atv8n3HaF7MqLh9R2Gj/dxRKdEftB5XtpUA95IDM5EBnmNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031793; c=relaxed/simple;
	bh=YEfkuLz05+knBqwzH+1YZVTlS8GBzWRXQD4GtvkzhTw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iC2GjDaAi1XkgG3lnxM7YdOwWXKJk/iVvveP2U6k/7g4grig+XS+YbThfgAZCrOh/n5mtK7IlbyoVbhfuHJKk0XJMLR4nAvQWbWyVJ6I0dkwBeqzEGUuHaaLL0TahcUFd9oOTFyjn1kG+hevOtBWqlvq4drN/Jy5kGeYmqrTO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y6Qse5eK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y6Qse5eK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=zSTLT+/QdH0dxTPKQB/RqMCvuA6BWZoPzuTugdHd1v0=; b=Y6Qse5eK2/Q4QV6Q90hNOu7TrN
	zyr0cSk1VpcETSC3C9bLPRsrOP585MT8GDNZ3tAgcBvtbgXCA3RVhWL983OHHnb08zvRA4Cl4Bbm4
	YKrUGhyXnkt4hpLmLCb/o0T5cWO9bY1Rvd3z/9URUjPNFlRqnbLpePHPcUGhRUDldcgjcB72vAswr
	cUXKD0JQxx3b0YeCd+GVgETV4SOX2cf2gziJlNEaLT7+R76BHl84AI4HA89iHYPFC5pNg+vS6BU8h
	cqm/67boz/7q3IOr/iLe/gjYi9RWL1AAy6jTwHUyCjiGQECf3sT9ZbIhhTj6i52rbqdRM2YhaChVI
	Z+SchCpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfHC-00000007FPc-2DU2;
	Wed, 07 Aug 2024 11:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8EA69300729; Wed,  7 Aug 2024 13:56:21 +0200 (CEST)
Message-Id: <20240807115549.920950699@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 07 Aug 2024 13:29:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf: Optimize context reschedule for single PMU cases
References: <20240807112924.448091402@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Currently re-scheduling a context will reschedule all active PMUs for
that context, even if it is known only a single event is added.

Namhyung reported that changing this to only reschedule the affected
PMU when possible provides significant performance gains under certain
conditions.

Therefore, allow partial context reschedules for a specific PMU, that
of the event modified.

While the patch looks somewhat noisy, it mostly just propagates a new
@pmu argument through the callchain and modifies the epc loop to only
pick the 'epc->pmu == @pmu' case.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |  164 +++++++++++++++++++++++++++------------------------
 1 file changed, 88 insertions(+), 76 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -685,30 +685,32 @@ do {									\
 	___p;								\
 })
 
+#define for_each_epc(_epc, _ctx, _pmu, _cgroup)				\
+	list_for_each_entry(_epc, &((_ctx)->pmu_ctx_list), pmu_ctx_entry) \
+		if (_cgroup && !_epc->nr_cgroups)			\
+			continue;					\
+		else if (_pmu && _epc->pmu != _pmu)			\
+			continue;					\
+		else
+
 static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
 		perf_pmu_disable(pmu_ctx->pmu);
-	}
 }
 
 static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
 		perf_pmu_enable(pmu_ctx->pmu);
-	}
 }
 
-static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
-static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
+static void ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
+static void ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
 
 #ifdef CONFIG_CGROUP_PERF
 
@@ -865,7 +867,7 @@ static void perf_cgroup_switch(struct ta
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_ctx_disable(&cpuctx->ctx, true);
 
-	ctx_sched_out(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
+	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 	/*
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
@@ -877,7 +879,7 @@ static void perf_cgroup_switch(struct ta
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()
 	 * to not have to pass task around
 	 */
-	ctx_sched_in(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
+	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -2656,7 +2658,8 @@ static void add_event_to_ctx(struct perf
 }
 
 static void task_ctx_sched_out(struct perf_event_context *ctx,
-				enum event_type_t event_type)
+			       struct pmu *pmu,
+			       enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 
@@ -2666,18 +2669,19 @@ static void task_ctx_sched_out(struct pe
 	if (WARN_ON_ONCE(ctx != cpuctx->task_ctx))
 		return;
 
-	ctx_sched_out(ctx, event_type);
+	ctx_sched_out(ctx, pmu, event_type);
 }
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
-				struct perf_event_context *ctx)
+				struct perf_event_context *ctx,
+				struct pmu *pmu)
 {
-	ctx_sched_in(&cpuctx->ctx, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
 	if (ctx)
-		 ctx_sched_in(ctx, EVENT_PINNED);
-	ctx_sched_in(&cpuctx->ctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 	if (ctx)
-		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
 }
 
 /*
@@ -2695,16 +2699,12 @@ static void perf_event_sched_in(struct p
  * event_type is a bit mask of the types of events involved. For CPU events,
  * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
  */
-/*
- * XXX: ctx_resched() reschedule entire perf_event_context while adding new
- * event to the context or enabling existing event in the context. We can
- * probably optimize it by rescheduling only affected pmu_ctx.
- */
 static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
-			enum event_type_t event_type)
+			struct pmu *pmu, enum event_type_t event_type)
 {
 	bool cpu_event = !!(event_type & EVENT_CPU);
+	struct perf_event_pmu_context *epc;
 
 	/*
 	 * If pinned groups are involved, flexible groups also need to be
@@ -2715,10 +2715,14 @@ static void ctx_resched(struct perf_cpu_
 
 	event_type &= EVENT_ALL;
 
-	perf_ctx_disable(&cpuctx->ctx, false);
+	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+		perf_pmu_disable(epc->pmu);
+
 	if (task_ctx) {
-		perf_ctx_disable(task_ctx, false);
-		task_ctx_sched_out(task_ctx, event_type);
+		for_each_epc(epc, task_ctx, pmu, false)
+			perf_pmu_disable(epc->pmu);
+
+		task_ctx_sched_out(task_ctx, pmu, event_type);
 	}
 
 	/*
@@ -2729,15 +2733,19 @@ static void ctx_resched(struct perf_cpu_
 	 *  - otherwise, do nothing more.
 	 */
 	if (cpu_event)
-		ctx_sched_out(&cpuctx->ctx, event_type);
+		ctx_sched_out(&cpuctx->ctx, pmu, event_type);
 	else if (event_type & EVENT_PINNED)
-		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx);
+	perf_event_sched_in(cpuctx, task_ctx, pmu);
 
-	perf_ctx_enable(&cpuctx->ctx, false);
-	if (task_ctx)
-		perf_ctx_enable(task_ctx, false);
+	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+		perf_pmu_enable(epc->pmu);
+
+	if (task_ctx) {
+		for_each_epc(epc, task_ctx, pmu, false)
+			perf_pmu_enable(epc->pmu);
+	}
 }
 
 void perf_pmu_resched(struct pmu *pmu)
@@ -2746,7 +2754,7 @@ void perf_pmu_resched(struct pmu *pmu)
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 
 	perf_ctx_lock(cpuctx, task_ctx);
-	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU);
 	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
@@ -2802,9 +2810,10 @@ static int  __perf_install_in_context(vo
 #endif
 
 	if (reprogram) {
-		ctx_sched_out(ctx, EVENT_TIME);
+		ctx_sched_out(ctx, NULL, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
+			    get_event_type(event));
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2948,7 +2957,7 @@ static void __perf_event_enable(struct p
 		return;
 
 	if (ctx->is_active)
-		ctx_sched_out(ctx, EVENT_TIME);
+		ctx_sched_out(ctx, NULL, EVENT_TIME);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 	perf_cgroup_event_enable(event, ctx);
@@ -2957,7 +2966,7 @@ static void __perf_event_enable(struct p
 		return;
 
 	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, EVENT_TIME);
+		ctx_sched_in(ctx, NULL, EVENT_TIME);
 		return;
 	}
 
@@ -2966,7 +2975,7 @@ static void __perf_event_enable(struct p
 	 * then don't put it on unless the group is on.
 	 */
 	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, EVENT_TIME);
+		ctx_sched_in(ctx, NULL, EVENT_TIME);
 		return;
 	}
 
@@ -2974,7 +2983,7 @@ static void __perf_event_enable(struct p
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx != ctx);
 
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu, get_event_type(event));
 }
 
 /*
@@ -3276,8 +3285,17 @@ static void __pmu_ctx_sched_out(struct p
 	perf_pmu_enable(pmu);
 }
 
+/*
+ * Be very careful with the @pmu argument since this will change ctx state.
+ * The @pmu argument works for ctx_resched(), because that is symmetric in
+ * ctx_sched_out() / ctx_sched_in() usage and the ctx state ends up invariant.
+ *
+ * However, if you were to be asymmetrical, you could end up with messed up
+ * state, eg. ctx->is_active cleared even though most EPCs would still actually
+ * be active.
+ */
 static void
-ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
+ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_pmu_context *pmu_ctx;
@@ -3331,11 +3349,8 @@ ctx_sched_out(struct perf_event_context
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, pmu, cgroup)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
-	}
 }
 
 /*
@@ -3579,7 +3594,7 @@ perf_event_context_sched_out(struct task
 
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, false);
-		task_ctx_sched_out(ctx, EVENT_ALL);
+		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 		perf_ctx_enable(ctx, false);
 		raw_spin_unlock(&ctx->lock);
@@ -3877,29 +3892,22 @@ static void pmu_groups_sched_in(struct p
 			   merge_sched_in, &can_add_hw);
 }
 
-static void ctx_groups_sched_in(struct perf_event_context *ctx,
-				struct perf_event_groups *groups,
-				bool cgroup)
+static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
+			       enum event_type_t event_type)
 {
-	struct perf_event_pmu_context *pmu_ctx;
-
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
-		pmu_groups_sched_in(ctx, groups, pmu_ctx->pmu);
-	}
-}
+	struct perf_event_context *ctx = pmu_ctx->ctx;
 
-static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
-			       struct pmu *pmu)
-{
-	pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
+	if (event_type & EVENT_PINNED)
+		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
+	if (event_type & EVENT_FLEXIBLE)
+		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
 }
 
 static void
-ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
+ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
 	bool cgroup = event_type & EVENT_CGROUP;
 
@@ -3935,12 +3943,16 @@ ctx_sched_in(struct perf_event_context *
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
 	 */
-	if (is_active & EVENT_PINNED)
-		ctx_groups_sched_in(ctx, &ctx->pinned_groups, cgroup);
+	if (is_active & EVENT_PINNED) {
+		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
+	}
 
 	/* Then walk through the lower prio flexible groups */
-	if (is_active & EVENT_FLEXIBLE)
-		ctx_groups_sched_in(ctx, &ctx->flexible_groups, cgroup);
+	if (is_active & EVENT_FLEXIBLE) {
+		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
+	}
 }
 
 static void perf_event_context_sched_in(struct task_struct *task)
@@ -3983,10 +3995,10 @@ static void perf_event_context_sched_in(
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
 		perf_ctx_disable(&cpuctx->ctx, false);
-		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
-	perf_event_sched_in(cpuctx, ctx);
+	perf_event_sched_in(cpuctx, ctx, NULL);
 
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
@@ -4327,14 +4339,14 @@ static bool perf_rotate_context(struct p
 		update_context_time(&cpuctx->ctx);
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
-		__pmu_ctx_sched_in(&cpuctx->ctx, pmu);
+		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
 	}
 
 	if (task_event)
 		rotate_ctx(task_epc->ctx, task_event);
 
 	if (task_event || (task_epc && cpu_event))
-		__pmu_ctx_sched_in(task_epc->ctx, pmu);
+		__pmu_ctx_sched_in(task_epc, EVENT_FLEXIBLE);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -4400,7 +4412,7 @@ static void perf_event_enable_on_exec(st
 
 	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, EVENT_TIME);
+	ctx_sched_out(ctx, NULL, EVENT_TIME);
 
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		enabled |= event_enable_on_exec(event, ctx);
@@ -4412,9 +4424,9 @@ static void perf_event_enable_on_exec(st
 	 */
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
+		ctx_resched(cpuctx, ctx, NULL, event_type);
 	} else {
-		ctx_sched_in(ctx, EVENT_TIME);
+		ctx_sched_in(ctx, NULL, EVENT_TIME);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 
@@ -13202,7 +13214,7 @@ static void perf_event_exit_task_context
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, EVENT_ALL);
+	task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
@@ -13751,7 +13763,7 @@ static void __perf_event_exit_context(vo
 	struct perf_event *event;
 
 	raw_spin_lock(&ctx->lock);
-	ctx_sched_out(ctx, EVENT_TIME);
+	ctx_sched_out(ctx, NULL, EVENT_TIME);
 	list_for_each_entry(event, &ctx->event_list, event_entry)
 		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
 	raw_spin_unlock(&ctx->lock);


