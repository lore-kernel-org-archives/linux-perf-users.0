Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB922A4E6;
	Thu,  1 May 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133048; cv=none; b=CZbQJ+aHGETglG79ctj3HREx9mVQxBXeDKEV0yBrAwB39cPBq6pO04cMo4sa1e6PsY48y4OkqRX5kzb8yf0XLuAVhrLbFq+euq7VDoj4//J6bMBXae3leaaTlxDY8JFGangFdgN7is4vYgt02H3Ct5mZTYBR2V9XT6YDmX2HFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133048; c=relaxed/simple;
	bh=V7YTtQTW9uZnRxfPiPselvUTdC8j+/VUn3zueN1fe3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JubFCRAm0o+dBI1ScoqPzMB3bvzfroOXj8fQsfsV6DPIZxy5eAYxiBL8jR254Rf9ha2eUqAEEH7Upx5D2I7c6Q6in4RFVgluzaNPOL/GXDzlr9CWn43HPVgi+Y41tKc1Q7tRme6duWR+qpIg6GltZw/zDrmBiGvFBYmGpRn+RBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF31C4CEE4;
	Thu,  1 May 2025 20:57:24 +0000 (UTC)
Date: Thu, 1 May 2025 16:57:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v6 5/5] perf: Support deferred user callchains for per
 CPU events
Message-ID: <20250501165730.69642099@gandalf.local.home>
In-Reply-To: <aBPWE7ItDhEnSpav@google.com>
References: <20250501013202.997535180@goodmis.org>
	<20250501013506.751321323@goodmis.org>
	<aBPWE7ItDhEnSpav@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 May 2025 13:14:11 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, Apr 30, 2025 at 09:32:07PM -0400, Steven Rostedt wrote:

> > To solve this, when a per CPU event is created that has defer_callchain
> > attribute set, it will do a lookup from a global list
> > (unwind_deferred_list), for a perf_unwind_deferred descriptor that has the
> > id that matches the PID of the current task's group_leader.  
> 
> Nice, it'd work well with the perf tools at least.

Cool!



> > +static void perf_event_deferred_cpu(struct unwind_work *work,
> > +				    struct unwind_stacktrace *trace, u64 cookie)
> > +{
> > +	struct perf_unwind_deferred *defer =
> > +		container_of(work, struct perf_unwind_deferred, unwind_work);
> > +	struct perf_unwind_cpu *cpu_unwind;
> > +	struct perf_event *event;
> > +	int cpu;
> > +
> > +	guard(rcu)();
> > +	guard(preempt)();
> > +
> > +	cpu = smp_processor_id();
> > +	cpu_unwind = &defer->cpu_events[cpu];
> > +
> > +	WRITE_ONCE(cpu_unwind->processing, 1);
> > +	/*
> > +	 * Make sure the above is seen for the rcuwait in
> > +	 * perf_remove_unwind_deferred() before iterating the loop.
> > +	 */
> > +	smp_mb();
> > +
> > +	list_for_each_entry_rcu(event, &cpu_unwind->list, unwind_list) {
> > +		perf_event_callchain_deferred(event, trace);
> > +		/* Only the first CPU event gets the trace */
> > +		break;  
> 
> I guess this is to emit a callchain record when more than one events
> requested the deferred callchains for the same task like:
> 
>   $ perf record -a -e cycles,instructions
> 
> right?

Yeah. If perf assigns more than one per CPU event, we only need one of
those events to record the deferred trace, not both of them.

But I keep a link list so that if the program closes the first one and
keeps the second active, this will still work, as the first one would be
removed from the list, and the second one would pick up the tracing after
that.

> 
> 
> > +	}
> > +
> > +	WRITE_ONCE(cpu_unwind->processing, 0);
> > +	rcuwait_wake_up(&cpu_unwind->pending_unwind_wait);
> > +}
> > +
> >  static void perf_free_addr_filters(struct perf_event *event);
> >  
> >  /* vs perf_event_alloc() error */
> > @@ -8198,6 +8355,15 @@ static int deferred_request_nmi(struct perf_event *event)
> >  	return 0;
> >  }
> >  
> > +static int deferred_unwind_request(struct perf_unwind_deferred *defer)
> > +{
> > +	u64 cookie;
> > +	int ret;
> > +
> > +	ret = unwind_deferred_request(&defer->unwind_work, &cookie);
> > +	return ret < 0 ? ret : 0;
> > +}
> > +
> >  /*
> >   * Returns:
> >  *     > 0 : if already queued.
> > @@ -8210,11 +8376,14 @@ static int deferred_request(struct perf_event *event)
> >  	int pending;
> >  	int ret;
> >  
> > -	/* Only defer for task events */
> > -	if (!event->ctx->task)
> > +	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
> >  		return -EINVAL;
> >  
> > -	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
> > +	if (event->unwind_deferred)
> > +		return deferred_unwind_request(event->unwind_deferred);
> > +
> > +	/* Per CPU events should have had unwind_deferred set! */
> > +	if (WARN_ON_ONCE(!event->ctx->task))
> >  		return -EINVAL;
> >  
> >  	if (in_nmi())
> > @@ -13100,13 +13269,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
> >  		}
> >  	}
> >  
> > +	/* Setup unwind deferring for per CPU events */
> > +	if (event->attr.defer_callchain && !task) {  
> 
> As I said it should handle per-task and per-CPU events.  How about this?

Hmm, I just added some printk()s in this code, and it seems that perf
record always did per CPU.

But if an event is per CPU and per task, will it still only trace that
task? It will never trace another task right?

Because the way this is currently implemented is that the event that
requested the callback is the one that records it, even if it runs on
another CPU:

In defer_request_nmi():

	struct callback_head *work = &event->pending_unwind_work;
	int ret;

	if (event->pending_unwind_callback)
		return 1;

	ret = task_work_add(current, work, TWA_NMI_CURRENT);
	if (ret)
		return ret;

	event->pending_unwind_callback = 1;

The task_work_add() adds the work from the event's pending_unwind_work.

Now the callback will be:

static void perf_event_deferred_task(struct callback_head *work)
{
	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);

// the above is the event that requested this. This may run on another CPU.

	struct unwind_stacktrace trace;

	if (!event->pending_unwind_callback)
		return;

	if (unwind_deferred_trace(&trace) >= 0) {

		/*
		 * All accesses to the event must belong to the same implicit RCU
		 * read-side critical section as the ->pending_unwind_callback reset.
		 * See comment in perf_pending_unwind_sync().
		 */
		guard(rcu)();
		perf_event_callchain_deferred(event, &trace);

// The above records the stack trace to that event.
// Again, this may happen on another CPU.

	}

	event->pending_unwind_callback = 0;
	local_dec(&event->ctx->nr_no_switch_fast);
	rcuwait_wake_up(&event->pending_unwind_wait);
}

Is the recording to an event from one CPU to another CPU an issue, if that
event also is only tracing a task?

> 
> 	if (event->attr.defer_callchain) {
> 		if (event->cpu >= 0) {
> 			err = perf_add_unwind_deferred(event);
> 			if (err)
> 				return ERR_PTR(err);
> 		} else {
> 			init_task_work(&event->pending_unwind_work,
> 					perf_event_callchain_deferred,
> 					perf_event_deferred_task);
> 		}
> 	}
> 
> > +		err = perf_add_unwind_deferred(event);
> > +		if (err)
> > +			return ERR_PTR(err);
> > +	}
> > +
> >  	err = security_perf_event_alloc(event);
> >  	if (err)
> >  		return ERR_PTR(err);
> >  
> >  	if (event->attr.defer_callchain)
> >  		init_task_work(&event->pending_unwind_work,
> > -			       perf_event_callchain_deferred);
> > +			       perf_event_deferred_task);  
> 
> And you can remove here.

There's nothing wrong with always initializing it. It will just never be
called.

What situation do we have where cpu is negative? What's the perf command?
Is there one?

> 
> Thanks,
> Namhyung
> 

Thanks for the review.

-- Steve
