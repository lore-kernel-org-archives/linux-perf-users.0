Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43335BDBA;
	Tue,  3 Mar 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548205; cv=none; b=qg77hhxVdjOcbbZ4pMFWyFP+2Z1tm/CUPxNgfTaJK+icDNip8BzXp46Ipxv5Z0fqmg8ZF3MffxcI/tFvDZ6k4I6/FdgzSGXMeEAcFbafK0yi96ohlSN3CcSpuyNBP7MOHKLBuBRABGJU6eZNSZR4NzlfxXBtnCVmdxoDsLnltKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548205; c=relaxed/simple;
	bh=gCutPHsHvUkxriX2aNEY2zePNtw387iRYruiSJMfjpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dySJNP302RIFXJKBG9uUYMwc40itC6vgUGpSf1dggSCJj3Doy/rJSGDO/t1dh4HHuvOld73C6+n8rtoLvqAJharcQoI53X7BbNoZIAEgVBKndsvD2EG5Dmf7MUgIEqNl3hYQXIw4n04LefG5/T72RpZuHUDnKVo1eRZr9eLzo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FicXxmCq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FicXxmCq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BgY3fdJc1qTAZG1Kas+8+5sIweermnTqJFE2LQZWNXA=; b=FicXxmCqpSiJMIMqxvtTWC/Y0Q
	RYF1zAIME9TrXj+YWbgqs3SJXtIWo3p6xAMukJylR167VkFVoFq2Gy65Ozublm6YDDVcIqEDU9DCd
	LDUp9VVs9AeYe0SDoXISfWr+BkYHA1UPZ9v7KkSkGLNe/qHmBP3OeQssd2T41pRQfc/Z0q9FgkyuC
	caJk42VudK4wDXoXhdAghQC9GK68jp/1ssb90rrppfnEBDnxTKzo7U1qxcIQPa/pyKgvdRvAYkZzZ
	/KEMLs9DIlrQVivYW7ZAmGimrytZqcRyf06lvCF7X3q9RFJv+A1PBN1RYC4yl5s7k8X2SNLpJuFaE
	054Q6hsg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxQkw-00000002dgk-0Z2Z;
	Tue, 03 Mar 2026 14:29:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 14199300666; Tue, 03 Mar 2026 15:29:49 +0100 (CET)
Date: Tue, 3 Mar 2026 15:29:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@linaro.org>
Cc: Thaumy Cheng <thaumy.love@gmail.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task
 exit
Message-ID: <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
References: <20251024170543.11201-1-thaumy.love@gmail.com>
 <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
 <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
 <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org>


Sorry, things got lost again :-(

On Mon, Feb 09, 2026 at 04:12:39PM +0000, James Clark wrote:

> > >    @@ -41,10 +41,11 @@ static void perf_output_get_handle(struct
> > >    perf_output_handle *handle)
> > >    {
> > >   	struct perf_buffer *rb = handle->rb;
> > > 
> > >   	preempt_disable();
> > > 
> > >    +	WARN_ON(handle->event->cpu != smp_processor_id());
> > > 

> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 5b5cb620499e..f566ad55b4fb 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -14086,7 +14086,7 @@ static void sync_child_event(struct perf_event *child_event,
> >   	u64 child_val;
> >   	if (child_event->attr.inherit_stat) {
> > -		if (task && task != TASK_TOMBSTONE)
> > +		if (task && task != TASK_TOMBSTONE && event_filter_match(child_event))
> >   			perf_event_read_event(child_event, task);
> >   	}
> 
> Turns out I tested this before with "child_event->cpu ==
> raw_smp_processor_id()" rather than using event_filter_match() so I missed
> that the loop over all the events needs to be wrapped with
> preempt_disable(). But that can't be done because perf_event_exit_event()
> takes a mutex.
> 
> I don't think the preempt_disable() can be on any smaller region than
> outside the entire loop otherwise you can get rescheduled between
> event_filter_match() checks and end up failing them all and not writing any
> event out at all.

Ooh, cute. That's annoying. This is specific to using per-task-per-cpu
buffers afaict, nevertheless those ought to work.

Also, I suspect your WARN would trigger before c418d8b4d7a4 as well, if
it wouldn't have been for that TOMBSTONE thing.

How to fix this mess... perhaps something like this, except now I worry
about the revoke and remove_on_exec cases; do they want something?


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 03ced7aad309..d0aae76cabf4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4727,7 +4727,6 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
-				  struct task_struct *task,
 				  bool revoke);
 
 /*
@@ -4755,7 +4754,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx, ctx->task, false);
+		perf_event_exit_event(event, ctx, false);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -12863,7 +12862,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, ctx->task, true);
+	perf_event_exit_event(event, ctx, true);
 
 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -14424,17 +14423,11 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
 
-static void sync_child_event(struct perf_event *child_event,
-			     struct task_struct *task)
+static void sync_child_event(struct perf_event *child_event)
 {
 	struct perf_event *parent_event = child_event->parent;
 	u64 child_val;
 
-	if (child_event->attr.inherit_stat) {
-		if (task && task != TASK_TOMBSTONE)
-			perf_event_read_event(child_event, task);
-	}
-
 	child_val = perf_event_count(child_event, false);
 
 	/*
@@ -14450,7 +14443,6 @@ static void sync_child_event(struct perf_event *child_event,
 static void
 perf_event_exit_event(struct perf_event *event,
 		      struct perf_event_context *ctx,
-		      struct task_struct *task,
 		      bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
@@ -14476,7 +14468,7 @@ perf_event_exit_event(struct perf_event *event,
 		attach_state = READ_ONCE(event->attach_state);
 
 		if (attach_state & PERF_ATTACH_CHILD)
-			sync_child_event(event, task);
+			sync_child_event(event);
 	}
 
 	if (revoke)
@@ -14517,7 +14509,7 @@ perf_event_exit_event(struct perf_event *event,
 static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
-	struct perf_event *child_event, *next;
+	struct perf_event *event, *next;
 
 	ctx = perf_pin_task_context(task);
 	if (!ctx)
@@ -14564,11 +14556,21 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	 * won't get any samples after PERF_RECORD_EXIT. We can however still
 	 * get a few PERF_RECORD_READ events.
 	 */
-	if (exit)
+	if (exit) {
 		perf_event_task(task, ctx, 0);
 
-	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
+		guard(raw_spinlock_irq)(&ctx->lock);
+		list_for_each_entry(event, &ctx->event_list, event_entry) {
+			if (event->attr.inherit_stat) {
+				if (task && task != TASK_TOMBSTONE &&
+				    event_filter_match(event))
+					perf_event_read_event(event, task);
+			}
+		}
+	}
+
+	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry)
+		perf_event_exit_event(event, ctx, false);
 
 	mutex_unlock(&ctx->mutex);
 

> While debugging I also noticed another issue with these per-thread count
> records. perf_event_exit_event() only does anything if the event has a
> parent. But the context switch optimization means that sometimes threads
> re-use the original event which has no parent. So randomly you get threads
> that are missing from the output.
> 
> There is a comment that mentions this under the parent check:
> 
>   if (parent_event) {
>     /*
>      * Do not destroy the 'original' grouping; because of the
>      * context switch optimization the original events could've
>      * ended up in a random child task.
> 
> But I'm not sure if that was supposed to be worked around some other way and
> it's now broken, or it was a known limitation of the implementation from the
> beginning? But right now it randomly misses one of the threads and includes
> the main thread counts, or includes all the threads and doesn't include the
> main thread counts if no context switch optimisation was done.
> 
> The perf record docs don't say anything that you wouldn't expect all threads
> to be there:
> 
>     -s, --stat            per thread counts

Ha! So commit bfbd3381e63a ("perf_counter: Implement more accurate per
task statistics") actually mentions that issue and tries to mitigate,
but I think I indeed missed a case.

I suppose the easiest fix is this, but urgh...

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 03ced7aad309..c38acf1e2f43 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3664,6 +3664,9 @@ static int context_equiv(struct perf_event_context *ctx1,
 	if (ctx1->pin_count || ctx2->pin_count)
 		return 0;
 
+	if (ctx1->nr_stat || ctx2->nr_stat)
+		return 0;
+
 	/* If ctx1 is the parent of ctx2 */
 	if (ctx1 == ctx2->parent_ctx && ctx1->generation == ctx2->parent_gen)
 		return 1;
@@ -3677,76 +3680,13 @@ static int context_equiv(struct perf_event_context *ctx1,
 	 * hierarchy, see perf_event_init_context().
 	 */
 	if (ctx1->parent_ctx && ctx1->parent_ctx == ctx2->parent_ctx &&
-			ctx1->parent_gen == ctx2->parent_gen)
+	    ctx1->parent_gen == ctx2->parent_gen)
 		return 1;
 
 	/* Unmatched */
 	return 0;
 }
 
-static void __perf_event_sync_stat(struct perf_event *event,
-				     struct perf_event *next_event)
-{
-	u64 value;
-
-	if (!event->attr.inherit_stat)
-		return;
-
-	/*
-	 * Update the event value, we cannot use perf_event_read()
-	 * because we're in the middle of a context switch and have IRQs
-	 * disabled, which upsets smp_call_function_single(), however
-	 * we know the event must be on the current CPU, therefore we
-	 * don't need to use it.
-	 */
-	perf_pmu_read(event);
-
-	perf_event_update_time(event);
-
-	/*
-	 * In order to keep per-task stats reliable we need to flip the event
-	 * values when we flip the contexts.
-	 */
-	value = local64_read(&next_event->count);
-	value = local64_xchg(&event->count, value);
-	local64_set(&next_event->count, value);
-
-	swap(event->total_time_enabled, next_event->total_time_enabled);
-	swap(event->total_time_running, next_event->total_time_running);
-
-	/*
-	 * Since we swizzled the values, update the user visible data too.
-	 */
-	perf_event_update_userpage(event);
-	perf_event_update_userpage(next_event);
-}
-
-static void perf_event_sync_stat(struct perf_event_context *ctx,
-				   struct perf_event_context *next_ctx)
-{
-	struct perf_event *event, *next_event;
-
-	if (!ctx->nr_stat)
-		return;
-
-	update_context_time(ctx);
-
-	event = list_first_entry(&ctx->event_list,
-				   struct perf_event, event_entry);
-
-	next_event = list_first_entry(&next_ctx->event_list,
-					struct perf_event, event_entry);
-
-	while (&event->event_entry != &ctx->event_list &&
-	       &next_event->event_entry != &next_ctx->event_list) {
-
-		__perf_event_sync_stat(event, next_event);
-
-		event = list_next_entry(event, event_entry);
-		next_event = list_next_entry(next_event, event_entry);
-	}
-}
-
 static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
 				   struct task_struct *task, bool sched_in)
 {
@@ -3835,8 +3775,6 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
 
 			do_switch = 0;
-
-			perf_event_sync_stat(ctx, next_ctx);
 		}
 		raw_spin_unlock(&next_ctx->lock);
 		raw_spin_unlock(&ctx->lock);
