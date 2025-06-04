Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0332D70810;
	Wed,  4 Jun 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046613; cv=none; b=mcs3vFSqanAxXuQt0CI8POG0agfhg9txlU2I/OZnsBM3va14Jh44w+TVaxfPNOvILEaegC1RLBtdvpTntq1O6652U7SdK5ceMbfv2A5fOgSrHOIHMDb+mV1sJXMuL+wsrchPXI6t8PlxSOrtc5aY1UzX1PDke+ZKwU6F2XHgaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046613; c=relaxed/simple;
	bh=/YWykEisRQ2WmTIDjG72mSa5eF+TJ63K3gwljHiPuBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf73hQtT+BCvcwky9gYL1w+Msnc/ELY/CWLYm/dBVbWu5idwEl3gWKRxNRkjYZh/6vDMit7w1SpNqnuOkiPPlZCHCB7EG5DtWW7rSz0mxGCZt12h654rYlobJ4cnr27fNT5EuqO6gM/boWYD/LNwVjGmfd96/ZmEY4KxD4bZYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YiqDS7o5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiqDS7o5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QNl5vGajRvJwYB9vPMZwKE2YZ8Aq0k/Jqe04/75BEQQ=; b=YiqDS7o5oRM1rJDLzzov6oLFeh
	XiW5LbKWoWlihyb1MEdtj2n6iZyd9dkUbopJnh0GUbx3Y5AMT57huRJctGlaf5KA7Xt+7tgLposOn
	UsXCRNTbhgHXiRBJabcBVBDzSvvqbcSHV6HGQSTw1sLnl/kshU+h5mhvket7tvG02PQllQXvLFR59
	QiKC7oYTu0t9ynzaCLDn2ZGBIfEDUZ7Vj2ZtyeARJQADCMR6DagT9CjkTzI3bwmDlsUGyZXL/C3M5
	KWqD5mMBlTe4qJWkc+KIt1yJ/8ck2zVYh5ZsyTONE4Zj+VveA8+EHGGkIlNMWPJOLZvXLQr8Cvsb1
	AtZ7SQcA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMov3-00000000uH8-2nkQ;
	Wed, 04 Jun 2025 14:16:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8337F300787; Wed,  4 Jun 2025 16:16:40 +0200 (CEST)
Date: Wed, 4 Jun 2025 16:16:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604141640.GL38114@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604101821.GC8020@e132581.arm.com>

On Wed, Jun 04, 2025 at 11:18:21AM +0100, Leo Yan wrote:
> On Wed, Jun 04, 2025 at 10:03:39AM +0200, Peter Zijlstra wrote:

> > And now we have the sitation that __perf_remove_from_context() can do:
> > 
> >   {ACTIVE,INACTIVE,OFF,ERROR} -> {OFF,EXIT,REVOKED,DEAD}
> 
> A detailed transition is:
> 
>   Case 1: {ACTIVE} -> {INACTIVE} -> {OFF,EXIT,REVOKED,DEAD}

It can also start with INACTIVE, but yeah..
 
>   Case 2: {ERROR} -> {ERROR,EXIT,REVOKED,DEAD}
>   Case 3: {OFF} -> {OFF,EXIT,REVOKED,DEAD}

> 
> > Where the {OFF,ERROR} -> * transition already have
> > perf_cgroup_event_disable(), but the {ACTIVE,INACTIVE} -> * part has
> > not.
> 
> Just a minor concern.
> 
> I noticed perf_put_aux_event() sets the ERROR state for sibling events
> of an AUX event. 

There is also perf_remove_sibling_event(), which can cause ERROR.

> IIUC, the AUX event is the group leader, so we only
> need to clean up the cgroup pointer for the AUX event, and simply set
> the ERROR state for its sibling events, correct?

Not sure; I forever forget how the AUX events are supposed to work :-/

It might be prudent to do something like so:


diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..e6583747838a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2149,8 +2149,9 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
 }
 
 static void put_event(struct perf_event *event);
-static void event_sched_out(struct perf_event *event,
-			    struct perf_event_context *ctx);
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
@@ -2183,8 +2184,7 @@ static void perf_put_aux_event(struct perf_event *event)
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		__event_disable(event, ctx, PERF_EVENT_STATE_ERROR);
 	}
 }
 
@@ -2242,18 +2242,6 @@ static inline struct list_head *get_event_list(struct perf_event *event)
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
@@ -2289,8 +2277,15 @@ static void perf_group_detach(struct perf_event *event)
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
@@ -2562,6 +2557,19 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state)
+{
+	if (event == event->group_leader)
+		group_sched_out(event, ctx);
+	else
+		event_sched_out(event, ctx);
+
+	perf_event_set_state(event, state);
+	perf_cgroup_event_disable(event, ctx);
+}
+
 /*
  * Cross CPU call to disable a performance event
  */
@@ -2575,15 +2583,7 @@ static void __perf_event_disable(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu_ctx->pmu);
 	ctx_time_update_event(ctx, event);
-
-	if (event == event->group_leader)
-		group_sched_out(event, ctx);
-	else
-		event_sched_out(event, ctx);
-
-	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	perf_cgroup_event_disable(event, ctx);
-
+	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 	perf_pmu_enable(event->pmu_ctx->pmu);
 }
 
