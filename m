Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E612820C4;
	Thu, 24 Apr 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512236; cv=none; b=RgDrxGeLLig9kRZKIQtIoAje/mhysKqjzleyz/n6gNKujButGeDk/OGEnjCiyiuqLflSzKxe8WwABQo+2jyB+WrW7GU7eCKwmCHoyIA0CzvytA7YTUQk/KYW6WSmoWoYhZ0xc3AWMxqlM+/ew/6CTfaELtZFIMng0QoR0301HLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512236; c=relaxed/simple;
	bh=IWmU6gONw5t+4KVzr0MRet+HiNA+MvVoz2tDGMAfBrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geIuDY57oa1QFk9bLRzF2oDIUYIsMbeK+bld8sPEpGGRjOOOekd+KF4dverpcjGpwWIf4TNwpkQaFPMGJEFo8VTKdaOPgscQb42kRcw4fTnXpN7bmyszAC3vUkjuatb3TFi6KlTo/w/nVVayQk/0FTs8Jmj0UZG45au4POfgo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LJTpY3pC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LJTpY3pC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Npt9CwID0qeQ99x3SGhWNp1tL0Z6rWptYEQ/EwcsuNg=; b=LJTpY3pC+ZGWZ9G3nCPPPQs009
	Lc4d3y1QeNFfBVZKdol+dwUBIRlXFc3Bk4qk4xhqexQyG1yPijoAf2i7Rf49+jTd2MnFkgnAf9+Mr
	BKZVnj222xdttVw0tEs23UxUw85YSASdHNzJi4YTbBBXAv7C7KU/bjKQtjhBQ/kVq3SRo94x3UFLQ
	npAp4AnyGfjkMLaJ9o5U5XrR6YCM81+35xCzR1U/bK013/xMOFdkjKdcoxAUKbGbRNAnK40l+rcYe
	K/5S/HvoAQVLdXrjkJ1wg9Z0nCM1DAO+QwWQ83WuXwbwzQvEBOs0OeohwjjOl6RYhHsh3ujeJtX/g
	g+/oCI+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7zT0-0000000BrOL-2p0d;
	Thu, 24 Apr 2025 16:30:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D418300642; Thu, 24 Apr 2025 18:30:24 +0200 (CEST)
Date: Thu, 24 Apr 2025 18:30:24 +0200
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
Message-ID: <20250424163024.GC18306@noisy.programming.kicks-ass.net>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424161128.29176-3-frederic@kernel.org>

On Thu, Apr 24, 2025 at 06:11:26PM +0200, Frederic Weisbecker wrote:
> The following commit:
> 
> 	da916e96e2de ("perf: Make perf_pmu_unregister() useable")
> 
> has introduced two significant event's parent lifecycle changes:
> 
> 1) An event that has exited now has EVENT_TOMBSTONE as a parent.
>    This can result in a situation where the delayed wakeup irq_work can
>    accidentally dereference EVENT_TOMBSTONE on:
> 
> CPU 0                                          CPU 1
> -----                                          -----
> 
> __schedule()
>     local_irq_disable()
>     rq_lock()
>     <NMI>
>     perf_event_overflow()
>         irq_work_queue(&child->pending_irq)
>     </NMI>
>     perf_event_task_sched_out()
>         raw_spin_lock(&ctx->lock)
>         ctx_sched_out()
>         ctx->is_active = 0
>         event_sched_out(child)
>         raw_spin_unlock(&ctx->lock)
>                                               perf_event_release_kernel(parent)
>                                                   perf_remove_from_context(child)
>                                                   raw_spin_lock_irq(&ctx->lock)
>                                                   // Sees !ctx->is_active
>                                                   // Removes from context inline
>                                                   __perf_remove_from_context(child)
>                                                       perf_child_detach(child)
>                                                           event->parent = EVENT_TOMBSTONE
>     raw_spin_rq_unlock_irq(rq);
>     <IRQ>
>     perf_pending_irq()
>         perf_event_wakeup(child)
>             ring_buffer_wakeup(child)
>                 rcu_dereference(child->parent->rb) <--- CRASH
> 
> This also concerns the call to kill_fasync() on parent->fasync.

Argh, I actually looked for this case and didn't find it in one of the
earlier fixes :/

> 2) The final parent reference count decrement can now happen before the
>    the final child reference count decrement. ie: the parent can now
>    be freed before its child. On PREEMPT_RT, this can result in a
>    situation where the delayed wakeup irq_work can accidentally
>    dereference a freed parent:
> 
> CPU 0                                          CPU 1                              CPU 2
> -----                                          -----                              ------
> 
> perf_pmu_unregister()
>     pmu_detach_events()
>        pmu_get_event()
>            atomic_long_inc_not_zero(&child->refcount)
> 
>                                                <NMI>
>                                                perf_event_overflow()
>                                                    irq_work_queue(&child->pending_irq);
>                                                </NMI>
>                                                <IRQ>
>                                                irq_work_run()
>                                                    wake_irq_workd()
>                                                </IRQ>
>                                                preempt_schedule_irq()
>                                                =========> SWITCH to workd
>                                                irq_work_run_list()
>                                                    perf_pending_irq()
>                                                        perf_event_wakeup(child)
>                                                            ring_buffer_wakeup(child)
>                                                                event = child->parent
> 
>                                                                                   perf_event_release_kernel(parent)
>                                                                                       // Not last ref, PMU holds it
>                                                                                       put_event(child)
>                                                                                       // Last ref
>                                                                                       put_event(parent)
>                                                                                           free_event()
>                                                                                               call_rcu(...)
>                                                                                   rcu_core()
>                                                                                       free_event_rcu()
> 
>                                                                rcu_dereference(event->rb) <--- CRASH
> 
> This also concerns the call to kill_fasync() on parent->fasync.
> 
> The "easy" solution to 1) is to check that event->parent is not
> EVENT_TOMBSTONE on perf_event_wakeup() (including both ring buffer
> and fasync uses).
> 
> The "easy" solution to 2) is to turn perf_event_wakeup() to wholefully
> run under rcu_read_lock().
> 
> However because of 2), sanity would prescribe to make event::parent
> an __rcu pointer and annotate each and every users to prove they are
> reliable.
> 
> Propose an alternate solution and restore the stable pointer to the
> parent until all its children have called _free_event() themselves to
> avoid any further accident. Also revert the EVENT_TOMBSTONE design
> that is mostly here to determine which caller of perf_event_exit_event()
> must perform the refcount decrement on a child event matching the
> increment in inherit_event().
> 
> Arrange instead for checking the attach state of an event prior to its
> removal and decrement the refcount of the child accordingly.

Urgh, brain hurts, will have to look again tomorrow.


> @@ -13940,29 +13941,36 @@ perf_event_exit_event(struct perf_event *event,
>  		 * Do destroy all inherited groups, we don't care about those
>  		 * and being thorough is better.
>  		 */
> -		detach_flags |= DETACH_GROUP | DETACH_CHILD;
> +		prd.detach_flags |= DETACH_GROUP | DETACH_CHILD;
>  		mutex_lock(&parent_event->child_mutex);
>  	}
>  
>  	if (revoke)
> -		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
> +		prd.detach_flags |= DETACH_GROUP | DETACH_REVOKE;
>  
> -	perf_remove_from_context(event, detach_flags);
> +	perf_remove_from_context(event, &prd);

Isn't all this waay to complicated?

That is, to modify state we need both ctx->mutex and ctx->lock, and this
is what __perf_remove_from_context() has, but because of this, holding
either one of those locks is sufficient to read the state -- it cannot
change.

And here we already hold ctx->mutex.

So can't we simply do:

	old_state = event->attach_state;
	perf_remove_from_context(event, detach_flags);

	// do whatever with old_state

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
> +
> +		/*
> +		 * Match the refcount initialization. Make sure it doesn't happen
> +		 * twice if pmu_detach_event() calls it on an already exited task.
> +		 */
> +		if (prd.old_state & PERF_ATTACH_CHILD) {
>  			/*
>  			 * pmu_detach_event() will have an extra refcount.
> +			 * perf_pending_task() might have one too.
>  			 */
>  			put_event(event);
>  		}
> +
>  		return;
>  	}
>  
