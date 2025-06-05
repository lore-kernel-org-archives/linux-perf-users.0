Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA88488;
	Thu,  5 Jun 2025 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749126835; cv=none; b=C5r4PWA/rzpqxhFsgdn9sCF92M+KWKCX8wAnx1HcE+D7uasIyrrVEaCM5aXets4dOOCp01U+DKNDCTk4OLXWCG5l9hkS62yJeL2ie14Dzo+Ip39oFSh/4deqiV4OWWJve6ZLtf//QNqppfqbgdLq/OEgxM+hzzdUuhcc7XUU5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749126835; c=relaxed/simple;
	bh=oSg0BWQhTBYi4pRNfN5FZqVnrstvVSk2pbDgIsNr8O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWW0eZVFq+TVlXnaMJV2KHU6ViV8ZHEcLSFSIDRLh66NKq7NTJNZ8DXu5BNDFXswITEldJyxHNIbjY6Y0OMevLn88kT8G9QkxjUfcasd9DM5LP6+765WF4S7HzubSqPrVZ0xu3bNACSWUfTT5Cbjz7RpJ07MtxMH+i41yYiY8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ddBo4wVd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddBo4wVd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xJHjIyrqVhzyFs1QdOrPnjGgaN4xPKZQLhRy3L1nySg=; b=ddBo4wVdR1yo2OyDoim0aGXJon
	ZtI6amPXG8QgireXbsqr5/Xk5Wv3iE2KdKJFVH4XchYMqXvqUyZKuZPl6MV0KbQ9zrrJgve1r6W36
	pUz8/tqx7g7u18UaO4UU7fdE/5gZGyRXi6oOI9RXKmiw3nygNmm/heV/GJqPLuxii7TCe7mPilR1m
	i1i+5WUFc/nO8XF+sp53jnQ3gOJX95/b5F5VzPD+AD0L8CWEp06zScJN1ZMZJ32Eg8b2aO3pbRWa7
	eJuuDrUWY829OP5TtWdSR/r73O/IRDdO0Ocb9tsD7Dcm5f/K3026tozIlscFxVFQAQEdMBsd3SP7C
	lDCfKLcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN9my-00000004EXg-1Wkf;
	Thu, 05 Jun 2025 12:33:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B46693005AF; Thu,  5 Jun 2025 14:33:43 +0200 (CEST)
Date: Thu, 5 Jun 2025 14:33:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250605123343.GD35970@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
 <20250604141640.GL38114@noisy.programming.kicks-ass.net>
 <20250604154639.GE8020@e132581.arm.com>
 <20250605112921.GR39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605112921.GR39944@noisy.programming.kicks-ass.net>

On Thu, Jun 05, 2025 at 01:29:21PM +0200, Peter Zijlstra wrote:

> But yes, slightly confusing. Let me see if I can make a less confusing
> patch, and if not, sprinkle comments.

I've settled on the below.

---
Subject: perf: Fix cgroup state vs ERROR
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jun 5 12:37:11 CEST 2025

While chasing down a missing perf_cgroup_event_disable() elsewhere,
Leo Yan found that both perf_put_aux_event() and
perf_remove_sibling_event() were also missing one.

Specifically, the rule is that events that switch to OFF,ERROR need to
call perf_cgroup_event_disable().

Unify the disable paths to ensure this.

Fixes: ab43762ef010 ("perf: Allow normal events to output AUX data")
Fixes: 9f0c4fa111dc ("perf/core: Add a new PERF_EV_CAP_SIBLING event capability")
Reported-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2149,8 +2149,9 @@ perf_aux_output_match(struct perf_event
 }
 
 static void put_event(struct perf_event *event);
-static void event_sched_out(struct perf_event *event,
-			    struct perf_event_context *ctx);
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
@@ -2183,8 +2184,7 @@ static void perf_put_aux_event(struct pe
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		__event_disable(iter, ctx, PERF_EVENT_STATE_ERROR);
 	}
 }
 
@@ -2242,18 +2242,6 @@ static inline struct list_head *get_even
 				    &event->pmu_ctx->flexible_active;
 }
 
-/*
- * Events that have PERF_EV_CAP_SIBLING require being part of a group and
- * cannot exist on their own, schedule them out and move them into the ERROR
- * state. Also see _perf_event_enable(), it will not be able to recover
- * this ERROR state.
- */
-static inline void perf_remove_sibling_event(struct perf_event *event)
-{
-	event_sched_out(event, event->ctx);
-	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-}
-
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2289,8 +2277,15 @@ static void perf_group_detach(struct per
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
+		/*
+		 * Events that have PERF_EV_CAP_SIBLING require being part of
+		 * a group and cannot exist on their own, schedule them out
+		 * and move them into the ERROR state. Also see
+		 * _perf_event_enable(), it will not be able to recover this
+		 * ERROR state.
+		 */
 		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			perf_remove_sibling_event(sibling);
+			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
 
 		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
@@ -2562,6 +2557,15 @@ static void perf_remove_from_context(str
 	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state)
+{
+	event_sched_out(event, ctx);
+	perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, state);
+}
+
 /*
  * Cross CPU call to disable a performance event
  */
@@ -2576,13 +2580,18 @@ static void __perf_event_disable(struct
 	perf_pmu_disable(event->pmu_ctx->pmu);
 	ctx_time_update_event(ctx, event);
 
+	/*
+	 * When disabling a group leader, the whole group becomes ineligible
+	 * to run, so schedule out the full group.
+	 */
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
-	else
-		event_sched_out(event, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	perf_cgroup_event_disable(event, ctx);
+	/*
+	 * But only mark the leader OFF; the siblings will remain
+	 * INACTIVE.
+	 */
+	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 
 	perf_pmu_enable(event->pmu_ctx->pmu);
 }
