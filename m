Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A07D530;
	Tue, 25 Mar 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892208; cv=none; b=mzwFMYrNoE9vh+se4Kwr3U6UN9pL45aQougrnosL6DZdhqzOrpv1WpBDZo1SlHe9vVUpBuMf+DdX//NrxENqdg0iL+19cL1DaGvTBqnyhXgEcpShXsUFHQOGnjZzuXaYYew7Ai+AboiUD3KSix3FZLa+Qp42w1qGk0DuMzgGdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892208; c=relaxed/simple;
	bh=pcjmIUDV1y803v4VNtj2L6DD6Te2Hsbn9Vt/OMzK3Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2EmJuvRXChIN1DVy/Xc7kZ9FFZWSRPyu5IfLXXph9Ir9F7NLr+og5eRMN5tE7JHjP1izbc/s3irZJ7LXeJg/0w0X1fDMgnJ9CbRSY0p61UvPFNPan+HDGrqtatwyQYSPfq/JLw6EsdJySGuTLANkZnR43Htu7cO3/5asUldbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52FB14BF;
	Tue, 25 Mar 2025 01:43:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CBD73F58B;
	Tue, 25 Mar 2025 01:43:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:43:20 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@kernel.org, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, Mark.Rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Message-ID: <20250325084320.GC604566@e132581.arm.com>
References: <20250306123350.1650114-1-yeoreum.yun@arm.com>
 <20250324194758.GB604566@e132581.arm.com>
 <Z+Jdl99Y2EpDHciK@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Jdl99Y2EpDHciK@e129823.arm.com>

On Tue, Mar 25, 2025 at 07:39:03AM +0000, Yeoreum Yun wrote:

[...]

> > > After this patch, this problem is gone like:
> > >
> > > sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
> > > ...
> > > armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
> > > armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940
> > >
> > >  Performance counter stats for 'stress-ng --pthread=2 -t 10s':
> > >
> > >     15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
> > >     22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)
> > >
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > Suggsted-by: Peter Zijlstra <peterz@infradead.org>
> >
> > /Suggsted-by/Suggested-by/
> 
> Thanks ;) I'll respin.

Given this patch is a fix, it is good to add a fix tag.

> > > ---
> > >  kernel/events/core.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 6364319e2f88..058533a50493 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -2407,6 +2407,7 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
> > >  #define DETACH_GROUP	0x01UL
> > >  #define DETACH_CHILD	0x02UL
> > >  #define DETACH_DEAD	0x04UL
> > > +#define DETACH_EXIT	0x08UL
> > >
> > >  /*
> > >   * Cross CPU call to remove a performance event
> > > @@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
> > >  			   void *info)
> > >  {
> > >  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> > > +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
> > >  	unsigned long flags = (unsigned long)info;
> > >
> > >  	ctx_time_update(cpuctx, ctx);
> > > @@ -2429,16 +2431,19 @@ __perf_remove_from_context(struct perf_event *event,
> > >  	 * Ensure event_sched_out() switches to OFF, at the very least
> > >  	 * this avoids raising perf_pending_task() at this time.
> > >  	 */
> > > -	if (flags & DETACH_DEAD)
> > > +	if (flags & DETACH_EXIT)
> > > +		state = PERF_EVENT_STATE_EXIT;
> > > +	if (flags & DETACH_DEAD) {
> > >  		event->pending_disable = 1;
> > > +		state = PERF_EVENT_STATE_DEAD;
> > > +	}
> > >  	event_sched_out(event, ctx);
> > > +	perf_event_set_state(event, min(event->state, state));
> >
> > Nitpick: can we move perf_event_set_state() before event_sched_out()?
> >
> > So the function handles the state machine ahead, then proceed for
> > other operations.
> 
> No It couldn't. IIUC, event_sched_out() disable pmu with ACTIVE state
> event only.
> If state is changed first from active state, it wouldn't be sched out by
> event_sched_out.

Indeed !  Please ignore my comment.

> > >  	if (flags & DETACH_GROUP)
> > >  		perf_group_detach(event);
> > >  	if (flags & DETACH_CHILD)
> > >  		perf_child_detach(event);
> > >  	list_del_event(event, ctx);
> > > -	if (flags & DETACH_DEAD)
> > > -		event->state = PERF_EVENT_STATE_DEAD;
> > >
> > >  	if (!pmu_ctx->nr_events) {
> > >  		pmu_ctx->rotate_necessary = 0;
> > > @@ -13424,12 +13429,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
> > >  		mutex_lock(&parent_event->child_mutex);
> > >  	}
> > >
> > > -	perf_remove_from_context(event, detach_flags);
> > > -
> > > -	raw_spin_lock_irq(&ctx->lock);
> > > -	if (event->state > PERF_EVENT_STATE_EXIT)
> > > -		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
> > > -	raw_spin_unlock_irq(&ctx->lock);
> > > +	perf_remove_from_context(event, detach_flags | DETACH_EXIT);

It is good to add a description in commit log for why remove the
code chunk for updating state in the function perf_event_exit_event().

As we discussed, it uses a central place __perf_remove_from_context()
to maintain the state when event exits,  this can avoid race
condition.  To support this, the 'DETACH_EXIT' flag is passed to
__perf_remove_from_context() instead.

Thanks,
Leo

> > >
> > >  	/*
> > >  	 * Child events can be freed.
> > > --
> > > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > >
