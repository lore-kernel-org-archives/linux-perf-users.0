Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7E205AB9;
	Fri,  2 May 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181825; cv=none; b=MnnfxOBdN+UNldrwyssrAw5tvEevjmf+VY5F+y1nKX0oLEF1CCIb73T8DBQdTbOPnoPZ/GQv/JmyaPC9bHnlmJprSyiCxMsIcjVNRnAdHbER+GCKuBHWwT2KNkiFT2UaI0WlElYDKnRI+WYR8q+5FckZooP+qAuxn5jhcjPtc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181825; c=relaxed/simple;
	bh=bKgIZqE60Yc5Ng7cINg5bqiXiAx88WDNx0NxbbmuxJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPhB8C01LH/w3bXAIOKwNo3RvD7rNVa6LtnujXWvzAVeQd773srtWQUhCm6oK5PVaG3GSo/LroT3ExIbbRztn6VwUPsA3icByuuYXc0kKiP3AXsPFRh7gV7FjOr6gm4ElBpVqgCKpqgle0VoSDLxm2is6EPihsaJOdKJed+as58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TaBqGMnl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TaBqGMnl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SN1hpXTp8D/aFRS6lABiopQRF6lYY9KR9gHRTnY5UwY=; b=TaBqGMnlMHaMberg1eWR0Bpk7C
	cAqtlSQ8oAF/kfWClzM5St1RGCJTeFCogu2EdzZBXPdPKuku9XC4V5dJoCRbUiqVVNoCfJfxP3xK7
	Q/ORspdHtNoj5CBDjizcPpsKAB+zkicOzPonG1E3x7H8xjsjcjAtWKRlzCyiNaRAhmTjPJtQvXGsi
	E6uaTPtuk7qIFEM4AJPYocuhkmHWa4+YFdUeXAnyQ6vrhpNqGoDtt2z3bJLrTi2LYdCO2ASsUySeg
	4qbnDUi63PA1Toi2nqOK5QTKhBxtcA0xwJfEr9u2Upd4mw6MOyd7V0964mK0WV1yJ9z0jzyI/l5pe
	L/oKUGgA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAne6-0000000Ds04-2eqf;
	Fri, 02 May 2025 10:29:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5DC73001D4; Fri,  2 May 2025 12:29:18 +0200 (CEST)
Date: Fri, 2 May 2025 12:29:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf: Fix irq work dereferencing garbage
Message-ID: <20250502102918.GW4198@noisy.programming.kicks-ass.net>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-3-frederic@kernel.org>
 <20250424163024.GC18306@noisy.programming.kicks-ass.net>
 <aA9ic6m6WAcmVBAw@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aA9ic6m6WAcmVBAw@pavilion.home>

On Mon, Apr 28, 2025 at 01:11:47PM +0200, Frederic Weisbecker wrote:
> Le Thu, Apr 24, 2025 at 06:30:24PM +0200, Peter Zijlstra a écrit :
> > On Thu, Apr 24, 2025 at 06:11:26PM +0200, Frederic Weisbecker wrote:
> > > @@ -13940,29 +13941,36 @@ perf_event_exit_event(struct perf_event *event,
> > >  		 * Do destroy all inherited groups, we don't care about those
> > >  		 * and being thorough is better.
> > >  		 */
> > > -		detach_flags |= DETACH_GROUP | DETACH_CHILD;
> > > +		prd.detach_flags |= DETACH_GROUP | DETACH_CHILD;
> > >  		mutex_lock(&parent_event->child_mutex);
> > >  	}
> > >  
> > >  	if (revoke)
> > > -		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
> > > +		prd.detach_flags |= DETACH_GROUP | DETACH_REVOKE;
> > >  
> > > -	perf_remove_from_context(event, detach_flags);
> > > +	perf_remove_from_context(event, &prd);
> > 
> > Isn't all this waay to complicated?
> > 
> > That is, to modify state we need both ctx->mutex and ctx->lock, and this
> > is what __perf_remove_from_context() has, but because of this, holding
> > either one of those locks is sufficient to read the state -- it cannot
> > change.
> > 
> > And here we already hold ctx->mutex.
> > 
> > So can't we simply do:
> > 
> > 	old_state = event->attach_state;
> > 	perf_remove_from_context(event, detach_flags);
> > 
> > 	// do whatever with old_state
> 
> Right, the locking scenario is just a bit more complicated.
> Most flags are set on init or with both ctx mutex and lock.
> But:
> 
> _ PERF_ATTACH_CHILD is set instead with parent child_mutex and ctx lock.

Looks trivial to add ctx->mutex to the mix here. Its not like that's a
fast path. But let me go read your patch before deciding if that's
actually needed :-)

> _ PERF_ATTACH_ITRACE is set from pmu::start(). Thus from the event context
>   with just interrupt disabled. It's probably enough to synchronize against
>   initialization and remove_from_context IPIs but perf_event_exit_event() needs
>   some care.

Right, that's a little tricky indeed. As stated, we don't care about the
bit, but the write shouldn't mess things up.

> So we must hold both ctx mutex and child_mutex (although the pmus_srcu thing
> should make that PERF_ATTACH_CHILD thing visible but let's keep things obvious).
> And also have WRITE_ONCE() / READ_ONCE() to take care about PERF_ATTACH_ITRACE,
> which we don't care about anyway.
> 
> Now this looks like this:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7bcb02ffb93a..7278ca731a55 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -208,7 +208,6 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
>  }
>  
>  #define TASK_TOMBSTONE ((void *)-1L)
> -#define EVENT_TOMBSTONE ((void *)-1L)
>  
>  static bool is_kernel_event(struct perf_event *event)
>  {
> @@ -2338,12 +2337,6 @@ static void perf_child_detach(struct perf_event *event)
>  
>  	sync_child_event(event);
>  	list_del_init(&event->child_list);
> -	/*
> -	 * Cannot set to NULL, as that would confuse the situation vs
> -	 * not being a child event. See for example unaccount_event().
> -	 */
> -	event->parent = EVENT_TOMBSTONE;
> -	put_event(parent_event);
>  }
>  
>  static bool is_orphaned_event(struct perf_event *event)
> @@ -5705,7 +5698,7 @@ static void put_event(struct perf_event *event)
>  	_free_event(event);
>  
>  	/* Matches the refcount bump in inherit_event() */
> -	if (parent && parent != EVENT_TOMBSTONE)
> +	if (parent)
>  		put_event(parent);
>  }
>  
> @@ -9998,7 +9991,7 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
>  
>  void perf_event_itrace_started(struct perf_event *event)
>  {
> -	event->attach_state |= PERF_ATTACH_ITRACE;
> +	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
>  }
>  
>  static void perf_log_itrace_start(struct perf_event *event)
> @@ -13922,10 +13915,7 @@ perf_event_exit_event(struct perf_event *event,
>  {
>  	struct perf_event *parent_event = event->parent;
>  	unsigned long detach_flags = DETACH_EXIT;
> -	bool is_child = !!parent_event;
> -
> -	if (parent_event == EVENT_TOMBSTONE)
> -		parent_event = NULL;
> +	unsigned int attach_state;
>  
>  	if (parent_event) {
>  		/*
> @@ -13942,6 +13932,8 @@ perf_event_exit_event(struct perf_event *event,
>  		 */
>  		detach_flags |= DETACH_GROUP | DETACH_CHILD;
>  		mutex_lock(&parent_event->child_mutex);
> +		/* PERF_ATTACH_ITRACE might be set concurrently */
> +		attach_state = READ_ONCE(event->attach_state);
>  	}
>  
>  	if (revoke)
> @@ -13951,18 +13943,25 @@ perf_event_exit_event(struct perf_event *event,
>  	/*
>  	 * Child events can be freed.
>  	 */
> -	if (is_child) {
> -		if (parent_event) {
> -			mutex_unlock(&parent_event->child_mutex);
> -			/*
> -			 * Kick perf_poll() for is_event_hup();
> -			 */
> -			perf_event_wakeup(parent_event);
> +	if (parent_event) {
> +		mutex_unlock(&parent_event->child_mutex);
> +		/*
> +		 * Kick perf_poll() for is_event_hup();
> +		 */
> +		perf_event_wakeup(parent_event);

Should not this perf_event_wakeup() be inside the next if() as well?
doing anything on parent_event when !ATTACH_CHILD seems dodgy.

> +
> +		/*
> +		 * Match the refcount initialization. Make sure it doesn't happen
> +		 * twice if pmu_detach_event() calls it on an already exited task.
> +		 */
> +		if (attach_state & PERF_ATTACH_CHILD) {
>  			/*
>  			 * pmu_detach_event() will have an extra refcount.
> +			 * perf_pending_task() might have one too.
>  			 */
>  			put_event(event);
>  		}
> +
>  		return;
>  	}

This is a *much* saner patch, thank you!

So the thing I worried about... which is why I chose for the TOMBSTONE
thing, is that this second invocation will now dereference parent_event,
even though we've already released our reference count on it. 

This is essentially a use-after-free.

The thing that makes it work is RCU. And I think we're good, since the
fail case is two perf_event_exit_event() invocations on the same event,
separated by an RCU grace period, and I don't think this can happen.

But its a shame we can't reliably detect that.. Oh well.
