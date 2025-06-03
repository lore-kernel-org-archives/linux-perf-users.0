Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A192F2D;
	Tue,  3 Jun 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961866; cv=none; b=RWakfmEU17uwOofu/tzP1huJOTviBA1WIvzU1TZ7iHeZEpkK/mPx5NShtBCqRaY8rE7lRUIuiKjgH8xU21KpsGWIoqp3Kv600gyZQpmCUZ40SiSZTmUM8XK6AUEVEejSXqJjOlPHhW2ROEiBkwpDktDDo+56xup4uykNVGVZ1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961866; c=relaxed/simple;
	bh=DVkykSv4skyinugXsU8moehq4N/ZpB8pFG19BZJfeiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf8I6wK+cs5+jYE5NX3RcHch/OZPrYypi2VCI/PSYDVkgqeDXfr2OLdC1uEp3y9RxjTplQg95mwsjHR1pQWsY1FAvgzglp9AR4VSu8H4EqoZHSSLlrd8awWR7f6zhIunewTGM1gG9kEnig74Y10/uczdtGzvYomieJqhRzUVnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ydr6t2cx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ydr6t2cx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dD2wGqHYiNqMbAUWNHi98ec5kU7ZYQbnB/g0nn0pcFE=; b=Ydr6t2cxgKaemssobB0Mb5vgUq
	v13Agq791Gca3sDdX57/Yqp7mBPQ0x7iBYwzcQ+0cUGZ7ZZpIVrjl/JBulxi6ZetAhs3NOwbVwiQc
	uvSONU7StoYupRP4z0f+FhE5VXrlxgk3ZarJNkThAua3VxOvseA7O8Bh/jo76CYfXPlpjsQM/11RH
	rCZJg0eegLZKqyGv506OWThOCbZ9zLJJmz6XLwFeovYmq3sXVPvH8HYf8vA0vmXcbMoLFaf45dtBT
	kNTj35+oUJVJhsHW/7o97iADrHbt9MOxC1NuAV1ZdY75vY3xt+cJw1YWXTSSkpC5pGOTpjw9ZytLJ
	pHvbVNVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSsA-000000027sk-3wkX;
	Tue, 03 Jun 2025 14:44:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72726300780; Tue,  3 Jun 2025 16:44:14 +0200 (CEST)
Date: Tue, 3 Jun 2025 16:44:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250603144414.GC38114@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603140040.GB8020@e132581.arm.com>

On Tue, Jun 03, 2025 at 03:00:40PM +0100, Leo Yan wrote:

> > +	if (event->state > PERF_EVENT_STATE_OFF)
> > +		perf_cgroup_event_disable(event, ctx);
> > +
> 
> As we discussed, seems to me, the issue is caused by an ambigous state
> machine transition:
> 
> When a PMU event state is PERF_EVENT_STATE_EXIT, the current code does
> not transite the state to PERF_EVENT_STATE_OFF. As a result, the
> list_del_event() function skips to clean up cgroup pointer for non OFF
> states. This is different from the code prior to the commit a3c3c6667,
> which transits states EXIT -> INACTIVE -> OFF.

Right.

> My suggestion is not reliable. Roughly read code, except for the
> PERF_EVENT_STATE_EXIT case, I think other error cases should also clean
> up the cgroup pointer.  The reason is I don't see other places to
> clean up the cgroup pointer for these error cases:
> 
>   PERF_EVENT_STATE_REVOKED
>   PERF_EVENT_STATE_DEAD

Those should be done here; on the first transition into these states.

> Only in the PERF_EVENT_STATE_ERROR state, we don't need to cleanup
> cgroup as this has already been handled in merge_sched_in().
> 
> So a correct condition would be:
> 
>     if (event->state > PERF_EVENT_STATE_OFF ||
>         event->state <= PERF_EVENT_STATE_EXIT)
>         perf_cgroup_event_disable(event, ctx);

I'm too tired to get my head straight. I'll look tomorrow.

> And we need to remove the perf_cgroup_event_disable() from
> list_del_event() to avoid duplicate code.
> 
> Perhaps a better approach for code consolidation would be to modify
> the conditions in list_del_event() to ensure the cgroup pointer is
> cleaned up in error cases. However, I'm not confident that this is the
> correct direction, so I would wait for suggestions from the maintainers.

Probably easier to keep here in __perf_remove_from_context() where we
have prev and next state available.

Anyway, I currently have the below, but I'll update once I've had sleep.

---
Subject: perf: Fix dangling cgroup pointer in cpuctx
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 2 Jun 2025 19:40:49 +0100

From: Yeoreum Yun <yeoreum.yun@arm.com>

Commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting
bug at task exit") moves the event->state update to before
list_del_event(). This makes the event->state test in list_del_event()
always false; never calling perf_cgroup_event_disable().

As a result, cpuctx->cgrp won't be cleared properly; causing havoc.

Fixes: a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: David Wang <00107082@163.com>
Link: https://lore.kernel.org/all/aD2TspKH%2F7yvfYoO@e129823.arm.com/ [0]
---
 kernel/events/core.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2120,18 +2120,6 @@ list_del_event(struct perf_event *event,
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 	event->pmu_ctx->nr_events--;
 }
@@ -2493,11 +2481,14 @@ __perf_remove_from_context(struct perf_e
 		state = PERF_EVENT_STATE_EXIT;
 	if (flags & DETACH_REVOKE)
 		state = PERF_EVENT_STATE_REVOKED;
-	if (flags & DETACH_DEAD) {
-		event->pending_disable = 1;
+	if (flags & DETACH_DEAD)
 		state = PERF_EVENT_STATE_DEAD;
-	}
+
 	event_sched_out(event, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+
 	perf_event_set_state(event, min(event->state, state));
 
 	if (flags & DETACH_GROUP)
