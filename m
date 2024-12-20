Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41178208AD;
	Fri, 20 Dec 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707664; cv=none; b=eHsQeSp6YnInyZ/GyKAoa70zfRmy7Nx9rD4B80oqhRjNvCz+ZQyGtBn9KbR3/8AqnCUdxop5HJDcO/z+FKiZJWlp3tJSIKo1Cl90ZpvyaCydHaFE5DPg0nCc9BB2Wb1Ansy3qOYRLa1U3uBI8x+B+pG4+h771boD7JKzoBhMVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707664; c=relaxed/simple;
	bh=mby6WrwYP6EpsQbYq1jjcb3UKsWLUP3S20uL3bcQBDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvNcX/g8iYjJSIiVxbsWKN53gekMNpWdEMjHGgFl6nvpp28UUPIwwPxcxxWNuq1xJ8J74IJThfL2Fe7P4q8/OcyGtIeN0ehbzYJgH2TQWKLofnw8Vh1pMjHqhWm+LFAPstz+JekiYdviphyinKvBBB0JMWSW5zL33s2Ko9RAwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NuPKUcz7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuPKUcz7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PaDCs73MiIN85EEReuNEPeywKOmLrwpAkoY73o3PEF8=; b=NuPKUcz7p0Nuaz2vVsAM2Zd1Wt
	29ldmQ7KBPaWHg2AtticAGIc8joU3MyTy9CQXxjDUJh5gc+XbO4Z0xqODi0XfCr4sqIqXAmXrcHCl
	8ayfvfFo+MVNSr29kJmGK+fE471T1pvM/kVFvk64TBxPlJp52i87/44pSSIb7FFFJc5eWlC/6GRel
	WM44nTdIxZ3WrT90zsPHlcr4UNssd+V+prkwHAbPJ+1A9pMmJDrZ/ra7rXUzNrOmzr9aOQkY64XJu
	xt0WzBgjq4usVVnUIpBtyLLx0oQfK/jZeOeaSobpMIqF8OmAVTKXvnMgKasRYv5Yt0/sHoZGix5t+
	UWk5XGAg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOehj-00000005gGh-3PhU;
	Fri, 20 Dec 2024 15:14:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ABCEB3003FF; Fri, 20 Dec 2024 16:14:14 +0100 (CET)
Date: Fri, 20 Dec 2024 16:14:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <20241220151414.GO11133@noisy.programming.kicks-ass.net>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2V5s2JM4W7BRckR@e129823.arm.com>

On Fri, Dec 20, 2024 at 02:05:39PM +0000, Yeoreum Yun wrote:

> > > This account failure of total_enable_time for event could happen in below sequence.
> > >
> > > 1. two event opened with:
> > >    - first event (e0) is opened with pmu0(p0) which could be added on CPU0.
> > >    - second event (e1) is opened with pmu1(p1) which could be added on CPU1.
> > >    - these two event belongs to the same task_ctx.
> > >
> > >    at this point:
> > >      task_ctx->time = 0
> > >      e0->total_enable_time = 0
> > >      e0->total_running_time = 0
> > >      e1->total_enable_time = 0
> > >      e1->total_running_time = 0
> > >
> > > 2. the task_ctx is sched in CPU0.
> > >    - In ctx_sched_in(), the task_ctx->time doesn't updated.
> > >    - In event_sched_in() e0 is activated so, its state becomes ACTIVE.
> > >    - In event_sched_in() e1 is activated, but soon becomes !ACTIVE
> > >      because pmu1 doesn't support CPU1 so it failed in pmu1->add().
> >
> > This doesn't make sense; e1 should never reach event_sched_in() and it
> > should already be INACTIVE.
> >
> > Notable events are created INACTIVE when !attr->disabled.
> 
> But in perf stat code, it via enable_counter(), so it's set with
> INACTIVE.

your text above references ctx_sched_in(), what you're now saying is
__perf_event_enable(); *that* will indeed set INACTIVE, but it will then
also fail event_filter_match() and never even reschedule.

> > Also, scheduling should not get beyond merge_sched_in()'s
> > event_filter_match(), which will find the CPU is a mismatch and stop
> > right there.
> >
> > This also means the event (e1) does not get to go on flexible_active
> > (see below).
> 
> No, when perf stat command with above, the cpu sets as == -1,
> So, It doesn't filter out in event_filter_match(). so it enter into
> merge_sched_in() and get into event_sched_in().

Hurmph, I thought the hybrid stuff used to set CPU.

Let me try and remember how the hybrid stuff works again. Ah
pmu::filter(), that's called in visit_groups_merge() and should stop
right there if the PMU doesn't work on that CPU.

Is your hybrid PMu not set up right?

> > > To address this, update total_enable_time in event_sched_out() when event state
> > > is PERF_EVENT_STATE_INACTIVE.
> >
> > This is a giant jump that I'm not following. Notably ctx_sched_out()
> > will only iterate pmu_ctx->{pinned,flexible}_active and that list should
> > only include ACTIVE events.
> > So how does handling INACTIVE in event_sched_out() even begin to help?
> 
> the answer is in the perf_event_exit_event()'s
> perf_remove_from_context(). in here
> event_sched_out() is called via __perf_remove_from_context()
> So above case, the enable time is fixed in here.

OK, how's this then?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..d12b402f9751 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2422,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 	unsigned long flags = (unsigned long)info;
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 
 	ctx_time_update(cpuctx, ctx);
 
@@ -2438,7 +2439,9 @@ __perf_remove_from_context(struct perf_event *event,
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;
+		state = PERF_EVENT_STATE_DEAD;
+
+	perf_event_set_state(event, state);
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
