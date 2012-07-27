From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: [RFD] perf: events defined contexts (was Re: perf:
 prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect)
Date: Fri, 27 Jul 2012 13:56:36 +0200
Message-ID: <20120727115633.GL1173@somewhere.redhat.com>
References: <501121D3.3060700@mentor.com>
 <20120727072647.GA3965@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:37684 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab2G0L4l (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 07:56:41 -0400
Received: by wgbfm10 with SMTP id fm10so583534wgb.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jul 2012 04:56:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120727072647.GA3965@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc: Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, a.p.zijlstra@chello.nl, acme@ghostprotocols.net, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jul 27, 2012 at 09:26:47AM +0200, Ingo Molnar wrote:
> 
> * Iegorov Oleg <oleg_iegorov@mentor.com> wrote:
> 
> > as there was no proposed solution that helped me in response to the
> > same post by Andrew Steets, I would like to know if it is possible
> > to disable/enable perf event counters from the source code?
> > 
> > calling prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect, nor does
> > compiling with -fno-omit-frame-pointer option.
> > 
> > It would be extremely useful to disable perf event counters for some
> > parts of code and re-enable them for other parts of code, like:
> > 
> > prctl(PR_TASK_PERF_EVENTS_DISABLE);
> > // not important for performance analysis code
> > prctl(PR_TASK_PERF_EVENTS_ENABLE);
> > // code that needs to be analysed
> > 
> > and then, run perf:
> > 
> > $ perf record ./program
> > $ perf report
> > 
> > Can anyone tell me how can I enable such functionality?
> 
> So, the kernel bits to do this in a pretty quirky way are there, 
> see:
> 
>     https://lkml.org/lkml/2012/1/30/99
> 
> but the librarization bits are definitely non-obvious to do and 
> it's no surprise that it has not been done yet.
> 
> Regular 'perf record' in itself is not self-profiling - it's 
> another task profiling you, so we cannot blanket allow 
> PR_TASK_PERF_EVENTS_DISABLE to disable profiling.
> 
> What we might want to do instead on the kernel side to offer the 
> functionality you are asking for is to enable 'public/weak' 
> events be created by the profiler on an opt-in basis, which can 
> be turned off by child tasks as well via 
> PR_TASK_PERF_EVENTS_DISABLE.
> 
> On the profiling workflow side it would work in a very simple 
> way, like this:
> 
>     perf record --self-profiling ./my-app
> 
> In your app you stick in appropriately placed 
> PR_TASK_PERF_EVENTS_DISABLE/ENABLE calls.
> 
> On the technical side perf record creates events with that 
> struct perf_event_attr::self_profiling flag set to 1. (the flag 
> is disabled by default)
> 
> The PR_TASK_PERF_EVENTS_DISABLE code in the modified kernel then 
> iterates through all events and disables those that have this 
> flag set, not just the ones owned by this task.
> 
> Maybe someone on Cc: would be interested in implementing this 
> new perf events feature?

The problem is more general than that I think.
We need to be able to define finer grained contexts than just
"task" and/or "CPU".

And reusing events themselves would be a nice interface.

For example create 3 events:

A = irq entry tracepoint
B = irq exit tracepoint
C = cpu-cycles

And say: I want to count cpu-cycles when event A fires and stop counting
when B fires.

With that you can count cpu cycles on irqs.

You could use any event you want to define your contexts: lock, functions, etc...

And even uprobes to define areas in userspace to profile. Would that solve
the initial problem in the thread? Like hook on function library entry/exit?

I talked about that to Jiri Olsa several times. May be he would be interested
in implementing this. I posted some patchets one year ago but got sidetracked.

This can give you an idea from where we can start: https://lkml.org/lkml/2011/3/14/346

Jiri, would you be interested in working on this?
