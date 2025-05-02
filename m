Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F71E7C1C;
	Fri,  2 May 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216987; cv=none; b=nyhA6WWwM6X0wzy8kKC167l1lQT9I2fuHbOtvcy06m26VQKpVcQK0qmhZaoMlO1ugVVd6qfq8OTM+jB/YOL1qSi5FbzMRp2Xza+8JzP8fhZYeAlhRQ4HfzvL0wND0A2IUwUbzpgqvdA4+4cezRv0iCMH2feQ1jbd+9jN/fMdvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216987; c=relaxed/simple;
	bh=RW5K/w2L0V2EaZgbi8rSHarTcf/k6d7xE2jTTR7hZBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5SEtrwnswIeHTNu+Kg9S1Sv0C+LSla2Jcwsx0xLBfhbooumlK5uIvIBfBLjiAKih1Pt3clLMV9kuKThHrtpwSPHgYZ91Aai50GFl8xGqUV+OFHSlF2p3rFd3gVip0DIo/iw230MzUrZY9kHMnBnMHgEXaIqrUPtLDz14VnEOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGS/1WN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGS/1WN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F06C4CEE4;
	Fri,  2 May 2025 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746216986;
	bh=RW5K/w2L0V2EaZgbi8rSHarTcf/k6d7xE2jTTR7hZBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGS/1WN+Y2oxasCC82z4yBpD57IEkkWcmdWTG6xgowI9D7yx1B8Keav7AskKucNd4
	 XjZQEgFZt0x/Iwx3WoyTZNVZnACfhxrpND7zEbes+G1lVnHZaIy/4aQXLN6bVVF8nG
	 ZZ0z+qlAF7uWDE/BCHWgEzKjrzjxlJS+jVJWpho1r++0rlj2eOLsgdq8BHW78CzaRF
	 DTy6xJILGgxm9B8Y+UJ4R9quAonsF+CublmBtZdXH5hVUO050qpHuxvBcY/ivR61sv
	 Bs2Ohc9jxSTWRjXy7B+6FkMBkXDoxH6ytW6kR75S3mfXWXR8r3ifJgKHeWTG5V8am9
	 2BUCoqH3flUeQ==
Date: Fri, 2 May 2025 13:16:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v6 5/5] perf: Support deferred user callchains for per
 CPU events
Message-ID: <aBUoF8DyzqmiW5vk@google.com>
References: <20250501013202.997535180@goodmis.org>
 <20250501013506.751321323@goodmis.org>
 <aBPWE7ItDhEnSpav@google.com>
 <20250501165730.69642099@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501165730.69642099@gandalf.local.home>

On Thu, May 01, 2025 at 04:57:30PM -0400, Steven Rostedt wrote:
> On Thu, 1 May 2025 13:14:11 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Wed, Apr 30, 2025 at 09:32:07PM -0400, Steven Rostedt wrote:
> 
> > > To solve this, when a per CPU event is created that has defer_callchain
> > > attribute set, it will do a lookup from a global list
> > > (unwind_deferred_list), for a perf_unwind_deferred descriptor that has the
> > > id that matches the PID of the current task's group_leader.  
> > 
> > Nice, it'd work well with the perf tools at least.
> 
> Cool!
> 
> 
> 
> > > +static void perf_event_deferred_cpu(struct unwind_work *work,
> > > +				    struct unwind_stacktrace *trace, u64 cookie)
> > > +{
> > > +	struct perf_unwind_deferred *defer =
> > > +		container_of(work, struct perf_unwind_deferred, unwind_work);
> > > +	struct perf_unwind_cpu *cpu_unwind;
> > > +	struct perf_event *event;
> > > +	int cpu;
> > > +
> > > +	guard(rcu)();
> > > +	guard(preempt)();
> > > +
> > > +	cpu = smp_processor_id();
> > > +	cpu_unwind = &defer->cpu_events[cpu];
> > > +
> > > +	WRITE_ONCE(cpu_unwind->processing, 1);
> > > +	/*
> > > +	 * Make sure the above is seen for the rcuwait in
> > > +	 * perf_remove_unwind_deferred() before iterating the loop.
> > > +	 */
> > > +	smp_mb();
> > > +
> > > +	list_for_each_entry_rcu(event, &cpu_unwind->list, unwind_list) {
> > > +		perf_event_callchain_deferred(event, trace);
> > > +		/* Only the first CPU event gets the trace */
> > > +		break;  
> > 
> > I guess this is to emit a callchain record when more than one events
> > requested the deferred callchains for the same task like:
> > 
> >   $ perf record -a -e cycles,instructions
> > 
> > right?
> 
> Yeah. If perf assigns more than one per CPU event, we only need one of
> those events to record the deferred trace, not both of them.
> 
> But I keep a link list so that if the program closes the first one and
> keeps the second active, this will still work, as the first one would be
> removed from the list, and the second one would pick up the tracing after
> that.

Makes sense.

> 
> > 
> > 
> > > +	}
> > > +
> > > +	WRITE_ONCE(cpu_unwind->processing, 0);
> > > +	rcuwait_wake_up(&cpu_unwind->pending_unwind_wait);
> > > +}
> > > +
> > >  static void perf_free_addr_filters(struct perf_event *event);
> > >  
> > >  /* vs perf_event_alloc() error */
> > > @@ -8198,6 +8355,15 @@ static int deferred_request_nmi(struct perf_event *event)
> > >  	return 0;
> > >  }
> > >  
> > > +static int deferred_unwind_request(struct perf_unwind_deferred *defer)
> > > +{
> > > +	u64 cookie;
> > > +	int ret;
> > > +
> > > +	ret = unwind_deferred_request(&defer->unwind_work, &cookie);
> > > +	return ret < 0 ? ret : 0;
> > > +}
> > > +
> > >  /*
> > >   * Returns:
> > >  *     > 0 : if already queued.
> > > @@ -8210,11 +8376,14 @@ static int deferred_request(struct perf_event *event)
> > >  	int pending;
> > >  	int ret;
> > >  
> > > -	/* Only defer for task events */
> > > -	if (!event->ctx->task)
> > > +	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
> > >  		return -EINVAL;
> > >  
> > > -	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
> > > +	if (event->unwind_deferred)
> > > +		return deferred_unwind_request(event->unwind_deferred);
> > > +
> > > +	/* Per CPU events should have had unwind_deferred set! */
> > > +	if (WARN_ON_ONCE(!event->ctx->task))
> > >  		return -EINVAL;
> > >  
> > >  	if (in_nmi())
> > > @@ -13100,13 +13269,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
> > >  		}
> > >  	}
> > >  
> > > +	/* Setup unwind deferring for per CPU events */
> > > +	if (event->attr.defer_callchain && !task) {  
> > 
> > As I said it should handle per-task and per-CPU events.  How about this?
> 
> Hmm, I just added some printk()s in this code, and it seems that perf
> record always did per CPU.

Right, that's the default behavior.

> 
> But if an event is per CPU and per task, will it still only trace that
> task? It will never trace another task right?

Yes, the event can be inherited to a child but then child will create a
new event so each task will have its own events.

> 
> Because the way this is currently implemented is that the event that
> requested the callback is the one that records it, even if it runs on
> another CPU:
> 
> In defer_request_nmi():
> 
> 	struct callback_head *work = &event->pending_unwind_work;
> 	int ret;
> 
> 	if (event->pending_unwind_callback)
> 		return 1;
> 
> 	ret = task_work_add(current, work, TWA_NMI_CURRENT);
> 	if (ret)
> 		return ret;
> 
> 	event->pending_unwind_callback = 1;
> 
> The task_work_add() adds the work from the event's pending_unwind_work.
> 
> Now the callback will be:
> 
> static void perf_event_deferred_task(struct callback_head *work)
> {
> 	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
> 
> // the above is the event that requested this. This may run on another CPU.
> 
> 	struct unwind_stacktrace trace;
> 
> 	if (!event->pending_unwind_callback)
> 		return;
> 
> 	if (unwind_deferred_trace(&trace) >= 0) {
> 
> 		/*
> 		 * All accesses to the event must belong to the same implicit RCU
> 		 * read-side critical section as the ->pending_unwind_callback reset.
> 		 * See comment in perf_pending_unwind_sync().
> 		 */
> 		guard(rcu)();
> 		perf_event_callchain_deferred(event, &trace);
> 
> // The above records the stack trace to that event.
> // Again, this may happen on another CPU.
> 
> 	}
> 
> 	event->pending_unwind_callback = 0;
> 	local_dec(&event->ctx->nr_no_switch_fast);
> 	rcuwait_wake_up(&event->pending_unwind_wait);
> }
> 
> Is the recording to an event from one CPU to another CPU an issue, if that
> event also is only tracing a task?

IIUC it should be fine as long as you use the unwind descriptor logic
like in the per-CPU case.  The data should be written to the current
CPU's ring buffer for per-task and per-CPU events.

> 
> > 
> > 	if (event->attr.defer_callchain) {
> > 		if (event->cpu >= 0) {
> > 			err = perf_add_unwind_deferred(event);
> > 			if (err)
> > 				return ERR_PTR(err);
> > 		} else {
> > 			init_task_work(&event->pending_unwind_work,
> > 					perf_event_callchain_deferred,
> > 					perf_event_deferred_task);
> > 		}
> > 	}
> > 
> > > +		err = perf_add_unwind_deferred(event);
> > > +		if (err)
> > > +			return ERR_PTR(err);
> > > +	}
> > > +
> > >  	err = security_perf_event_alloc(event);
> > >  	if (err)
> > >  		return ERR_PTR(err);
> > >  
> > >  	if (event->attr.defer_callchain)
> > >  		init_task_work(&event->pending_unwind_work,
> > > -			       perf_event_callchain_deferred);
> > > +			       perf_event_deferred_task);  
> > 
> > And you can remove here.
> 
> There's nothing wrong with always initializing it. It will just never be
> called.

Ok.

> 
> What situation do we have where cpu is negative? What's the perf command?
> Is there one?

Yep, there's --per-thread option for just per-task events.

Thanks,
Namhyung
