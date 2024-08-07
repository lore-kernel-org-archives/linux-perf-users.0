Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533051E4EF9;
	Wed,  7 Aug 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031791; cv=none; b=QObVyyzieXPyMkB/GN+IKbj3Ibveu1xekhbnGeuKxsBjNaG5ZWkr0nUBa0JnbloMcbgadTXyQVifQ4pG2QEa/Ir0Mza8vxz0lbzWhOiHlPYds3vHr+I5XjEN0PAKaSJh17pn6LAeeFQAz1uHUP4pHZr4eNbOOfpHuQv9rZ3wR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031791; c=relaxed/simple;
	bh=6gQiTjGykhW8SFyeSx9DwNl2psRAC9Xu2UHTYOvcTRA=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gZ9A5Ag6gWPEpODDq2H48Runtyz+qUum+rfo0m5b4f0yggnw59eN1gQN5oqkGDFWSE2szP8mIXR4nUCZqdEHuHBu4+Ncq/1RRjLW2ywLbu7jO2JhbBHBRMOeoyWWfGdd/D7A5HKjyAldCBySYvigixQu8nZGZa8lxBOKlr+v1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bZwH3wfe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bZwH3wfe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=pRqURCFC6WRD3RajDGiuhRpL9LQ05saHVBXcyGEeN24=; b=bZwH3wfexhWefWICLlJRo37iaH
	jGeqBMYaoBe5sGNXD9DPVzkigDT8nS4Bl/jp5Xoi+BMwKblylE3DfFkumul0lit+Bs5yFkKLEHcTM
	Yu2gZPJHkYryBGYrfF5BV9pCmv74QY4mci8P0Vsd4gX5YBkXmIwZ4+IN/kwfsvTva2mr70aVxCz3Y
	aNXGMdvvAmxJswwzCf+xr9VSWxJv4m3KLmLt/ftlE1ZaPJ6t+w/i3vo7n2Xfj9Q0pFjzH3ELkuRwz
	BMM7OkOy0d/Ko5eb2L7P2Sfoala9GRfaRY96P2/YgIwriQA6+9cFZ8aOWScQl7bmh+0gZLb7uFrt3
	5Rv0kiWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfHC-00000007FPd-2A4V;
	Wed, 07 Aug 2024 11:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9AE0E300ABE; Wed,  7 Aug 2024 13:56:21 +0200 (CEST)
Message-Id: <20240807115550.250637571@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 07 Aug 2024 13:29:28 +0200
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
Subject: [PATCH 4/5] perf: Add context time freeze
References: <20240807112924.448091402@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Many of the the context reschedule users are of the form:

  ctx_sched_out(.type = EVENT_TIME);
  ... modify context
  ctx_resched();

With the idea that the whole reschedule happens with a single
time-stamp, rather than with each ctx_sched_out() advancing time and
ctx_sched_in() re-starting time, creating a non-atomic experience.

However, Kan noticed that since this completely stops time, it
actually looses a bit of time between the stop and start. Worse, now
that we can do partial (per PMU) reschedules, the PMUs that are not
scheduled out still observe the time glitch.

Replace this with:

  ctx_time_freeze();
  ... modify context
  ctx_resched();

With the assumption that this happens in a perf_ctx_lock() /
perf_ctx_unlock() pair.

The new ctx_time_freeze() will update time and sets EVENT_FROZEN, and
ensures EVENT_TIME and EVENT_FROZEN remain set, this avoids
perf_event_time_now() from observing a time wobble from not seeing
EVENT_TIME for a little while.

Additionally, this avoids loosing time between
ctx_sched_out(EVENT_TIME) and ctx_sched_in(), which would re-set the
timestamp.

Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |  128 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 42 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -155,20 +155,55 @@ static int cpu_function_call(int cpu, re
 	return data.ret;
 }
 
+enum event_type_t {
+	EVENT_FLEXIBLE	= 0x01,
+	EVENT_PINNED	= 0x02,
+	EVENT_TIME	= 0x04,
+	EVENT_FROZEN	= 0x08,
+	/* see ctx_resched() for details */
+	EVENT_CPU	= 0x10,
+	EVENT_CGROUP	= 0x20,
+
+	/* compound helpers */
+	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
+	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
+};
+
+static inline void __perf_ctx_lock(struct perf_event_context *ctx)
+{
+	raw_spin_lock(&ctx->lock);
+	WARN_ON_ONCE(ctx->is_active & EVENT_FROZEN);
+}
+
 static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
 			  struct perf_event_context *ctx)
 {
-	raw_spin_lock(&cpuctx->ctx.lock);
+	__perf_ctx_lock(&cpuctx->ctx);
 	if (ctx)
-		raw_spin_lock(&ctx->lock);
+		__perf_ctx_lock(ctx);
+}
+
+static inline void __perf_ctx_unlock(struct perf_event_context *ctx)
+{
+	/*
+	 * If ctx_sched_in() didn't again set any ALL flags, clean up
+	 * after ctx_sched_out() by clearing is_active.
+	 */
+	if (ctx->is_active & EVENT_FROZEN) {
+		if (!(ctx->is_active & EVENT_ALL))
+			ctx->is_active = 0;
+		else
+			ctx->is_active &= ~EVENT_FROZEN;
+	}
+	raw_spin_unlock(&ctx->lock);
 }
 
 static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 			    struct perf_event_context *ctx)
 {
 	if (ctx)
-		raw_spin_unlock(&ctx->lock);
-	raw_spin_unlock(&cpuctx->ctx.lock);
+		__perf_ctx_unlock(ctx);
+	__perf_ctx_unlock(&cpuctx->ctx);
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)
@@ -370,16 +405,6 @@ static void event_function_local(struct
 	(PERF_SAMPLE_BRANCH_KERNEL |\
 	 PERF_SAMPLE_BRANCH_HV)
 
-enum event_type_t {
-	EVENT_FLEXIBLE = 0x1,
-	EVENT_PINNED = 0x2,
-	EVENT_TIME = 0x4,
-	/* see ctx_resched() for details */
-	EVENT_CPU = 0x8,
-	EVENT_CGROUP = 0x10,
-	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
-};
-
 /*
  * perf_sched_events : >0 events exist
  */
@@ -2332,18 +2357,39 @@ group_sched_out(struct perf_event *group
 }
 
 static inline void
-ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx, bool final)
 {
 	if (ctx->is_active & EVENT_TIME) {
+		if (ctx->is_active & EVENT_FROZEN)
+			return;
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, false);
+		update_cgrp_time_from_cpuctx(cpuctx, final);
 	}
 }
 
 static inline void
+ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+{
+	__ctx_time_update(cpuctx, ctx, false);
+}
+
+/*
+ * To be used inside perf_ctx_lock() / perf_ctx_unlock(). Lasts until perf_ctx_unlock().
+ */
+static inline void
+ctx_time_freeze(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+{
+	ctx_time_update(cpuctx, ctx);
+	if (ctx->is_active & EVENT_TIME)
+		ctx->is_active |= EVENT_FROZEN;
+}
+
+static inline void
 ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 {
 	if (ctx->is_active & EVENT_TIME) {
+		if (ctx->is_active & EVENT_FROZEN)
+			return;
 		update_context_time(ctx);
 		update_cgrp_time_from_event(event);
 	}
@@ -2822,7 +2868,7 @@ static int  __perf_install_in_context(vo
 #endif
 
 	if (reprogram) {
-		ctx_sched_out(ctx, NULL, EVENT_TIME);
+		ctx_time_freeze(cpuctx, ctx);
 		add_event_to_ctx(event, ctx);
 		ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
 			    get_event_type(event));
@@ -2968,8 +3014,7 @@ static void __perf_event_enable(struct p
 	    event->state <= PERF_EVENT_STATE_ERROR)
 		return;
 
-	if (ctx->is_active)
-		ctx_sched_out(ctx, NULL, EVENT_TIME);
+	ctx_time_freeze(cpuctx, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 	perf_cgroup_event_enable(event, ctx);
@@ -2977,19 +3022,15 @@ static void __perf_event_enable(struct p
 	if (!ctx->is_active)
 		return;
 
-	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, NULL, EVENT_TIME);
+	if (!event_filter_match(event))
 		return;
-	}
 
 	/*
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, NULL, EVENT_TIME);
+	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE)
 		return;
-	}
 
 	task_ctx = cpuctx->task_ctx;
 	if (ctx->task)
@@ -3263,7 +3304,7 @@ static void __pmu_ctx_sched_out(struct p
 	struct perf_event *event, *tmp;
 	struct pmu *pmu = pmu_ctx->pmu;
 
-	if (ctx->task && !ctx->is_active) {
+	if (ctx->task && !(ctx->is_active & EVENT_ALL)) {
 		struct perf_cpu_pmu_context *cpc;
 
 		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
@@ -3338,24 +3379,29 @@ ctx_sched_out(struct perf_event_context
 	 *
 	 * would only update time for the pinned events.
 	 */
-	if (is_active & EVENT_TIME) {
-		/* update (and stop) ctx time */
-		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, ctx == &cpuctx->ctx);
+	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx);
+
+	/*
+	 * CPU-release for the below ->is_active store,
+	 * see __load_acquire() in perf_event_time_now()
+	 */
+	barrier();
+	ctx->is_active &= ~event_type;
+
+	if (!(ctx->is_active & EVENT_ALL)) {
 		/*
-		 * CPU-release for the below ->is_active store,
-		 * see __load_acquire() in perf_event_time_now()
+		 * For FROZEN, preserve TIME|FROZEN such that perf_event_time_now()
+		 * does not observe a hole. perf_ctx_unlock() will clean up.
 		 */
-		barrier();
+		if (ctx->is_active & EVENT_FROZEN)
+			ctx->is_active &= EVENT_TIME_FROZEN;
+		else
+			ctx->is_active = 0;
 	}
 
-	ctx->is_active &= ~event_type;
-	if (!(ctx->is_active & EVENT_ALL))
-		ctx->is_active = 0;
-
 	if (ctx->task) {
 		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
-		if (!ctx->is_active)
+		if (!(ctx->is_active & EVENT_ALL))
 			cpuctx->task_ctx = NULL;
 	}
 
@@ -3943,7 +3989,7 @@ ctx_sched_in(struct perf_event_context *
 
 	ctx->is_active |= (event_type | EVENT_TIME);
 	if (ctx->task) {
-		if (!is_active)
+		if (!(is_active & EVENT_ALL))
 			cpuctx->task_ctx = ctx;
 		else
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
@@ -4424,7 +4470,7 @@ static void perf_event_enable_on_exec(st
 
 	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, NULL, EVENT_TIME);
+	ctx_time_freeze(cpuctx, ctx);
 
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		enabled |= event_enable_on_exec(event, ctx);
@@ -4437,8 +4483,6 @@ static void perf_event_enable_on_exec(st
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
 		ctx_resched(cpuctx, ctx, NULL, event_type);
-	} else {
-		ctx_sched_in(ctx, NULL, EVENT_TIME);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 


