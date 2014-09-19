From: Milian Wolff <mail@milianw.de>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 17:05:22 +0200
Message-ID: <2370687.Svp715mhCr@milian-kdab2>
References: <2221771.b2oSN5LR6X@milian-kdab2> <5770573.p6hpIeRPQV@milian-kdab2> <20140919144747.GC32694@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:47188 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbaISPFZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 11:05:25 -0400
In-Reply-To: <20140919144747.GC32694@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On Friday 19 September 2014 11:47:47 Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 19, 2014 at 10:11:21AM +0200, Milian Wolff escreveu:
> > On Thursday 18 September 2014 17:36:25 Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Sep 18, 2014 at 02:17:49PM -0600, David Ahern escreveu:
> > > > On 9/18/14, 1:17 PM, Arnaldo Carvalho de Melo wrote:
> > > > >>This was also why I asked my initial question, which I want to
> > > > >>repeat
> > > > >>once
> > > > >>
> > > > >>>more: Is there a technical reason to not offer a "timer" software
> > > > >>>event
> > > > >>>to
> > > > >>>perf? I'm a complete layman when it comes to Kernel internals, but
> > > > >>>from
> > > > >>>a user point of view this would be awesome:
> > > > >>>
> > > > >>>perf record --call-graph dwarf -e sw-timer -F 100 someapplication
> > > > >>>
> > > > >>>This command would then create a timer in the kernel with a 100Hz
> > > > >>>frequency. Whenever it fires, the callgraphs of all threads in
> > > > >>>$someapplication are sampled and written to perf.data. Is this
> > > > >>>technically not feasible? Or is it simply not implemented?
> > > > >>>I'm experimenting with a libunwind based profiler, and with some
> > > > >>>ugly
> > > > >>>signal hackery I can now grab backtraces by sending my application
> > > > >>>SIGUSR1. Based on> >
> > > > >
> > > > >Humm, can't you do the same thing with perf? I.e. you send SIGUSR1 to
> > > > >your app with the frequency you want, and then hook a 'perf probe'
> > > > >into
> > > > >your signal... /me tries some stuff, will get back with results...
> > 
> > That is actually a very good idea. With the more powerful scripting
> > abilities in perf now, that could/should do the job indeed. I'll also try
> > this out.
>
> Now that the need for getting a backtrace from existing threads, a-la
> using ptrace via gdb to attach to it and then traverse its stack to
> provide that backtrace, I think we need to do something on the perf
> infrastructure in the kernel to do that, i.e. somehow signal the perf
> kernel part that we want a backtrace for some specific thread.
> 
> Not at event time, but at some arbitrary time, be it creating an event
> that, as you suggested, will create a timer and then when that timer
> fires will use (parts of the) mechanism used by ptrace.
> 
> But in the end we need a mechanism to ask for backtraces for existing,
> sleeping, threads.

Yes, such a capability would be tremendously helpful for writing profiling 
tools for userspace applications. It should also work for threads that are not 
sleeping though, or are all threads of a process frozen when a perf event 
fires anyways?

> For waits in the future, we just need to ask for the tracepoints where
> waits take place and with the current infrastructure we can get most/all
> of what we need, no?

See David's email, this is possible even now with the sched:* events.
 
> > > > Current profiling options with perf require the process to be running.
> > > > What
> > > 
> > > Ok, so you want to see what is the wait channel and unwind the stack
> > > from there? Is that the case? I.e. again, a sysrq-t equivalent?
> > 
> > Hey again :)
> > 
> > If I'm not mistaken, I could not yet bring my point across. The final goal
> > is
> Right, but the discussion so far was to see if the existing kernel
> infrastructure would allow us to write such a tool.
> 
> > to profile both, wait time _and_ CPU time, combined! By sampling a
> > userspace program with a constant frequency and some statistics one can
> > get extremely useful information out of the data. I want to use perf to
> > automate the process that Mike Dunlavey explains here:
> > http://stackoverflow.com/a/378024/35250
> Will read.
> 
> > So yes, I want to see the wait channel and unwind from there, if the
> > process is waiting. Otherwise just do the normal unwinding you'd do when
> > any other perf event occurs.
> 
> Ok, we need two mechanisms to get that, one for existing, sleeping
> threads at the time we start monitoring (we don't have that now other
> than freezing the process, looking for threads that were waiting, then
> using ptrace and asking for that backtrace), and another for threads
> that will sleep/wait _after_ we start monitoring.
> 
> > > > Milian want is to grab samples every timer expiration even if process
> > > > is
> > > > not running.
> > > 
> > > What for? And by "grab samples" you want to know where it is waiting for
> > > something, together with its callchain?
> > 
> > See above. If I can sample the callchain every N ms, preferrably in a per-
> 
> Do you need to take periodic samples of the callchain? Or only when you
> wait for something?
> 
> For things that happen at such a high freq, yeah, just sampling would be
> better, but you're thinking about slow things, so multiple samples for
> something waiting and waiting is not needed, just when it starts
> waiting, right?

I need periodic samples. I'm not looking exclusively for wait time (that can 
be done already, see above). I'm looking for a generic overview of the 
userspace program. Where does it spent time? Without periodic samples, I 
cannot do any statistics. I think this should become clear when you read Mike 
Dunlavey's text that explains the GDB-based poor-mans-profiler (which is 
actually pretty helpful, despite the name).

> > thread manner, I can create tools which find the slowest userspace
> > functions. This is based on "inclusive" cost, which is made up out of CPU
> > time _and_ wait> 
> > time combined. With it one will find all of the following:
> >   - CPU hotspots
> >   - IO wait time
> >   - lock contention in a multi-threaded application
> >   
> > > > Any limitations that would prevent doing this with a sw event? e.g,
> > > > mimic
> > > > task-clock just don't disable the timer when the task is scheduled
> > > > out.
> > > 
> > > I'm just trying to figure out if what people want is a complete
> > > backtrace of all threads in a process, no matter what they are doing, at
> > > some given time, i.e. at "sysrq-t" time, is that the case?
> > 
> > Yes, that sounds correct to me. I tried it out on my system, but the
> > output in dmesg is far too large and I could not find the call stack
> > information of my test application while it slept. Looking at the other
> > backtraces I see there, I'm not sure whether sysrq-t only outputs a
> > kernel-backtrace? Or maybe it's
> sysrq-t is just for the kernel, that is why I said that you seemed to
> want it to cross into userspace.

Ah, ok. I misunderstood you.

<snip>

> Right, adding callchains to 'perf trace' and using it with --duration
> may provide a first approximation for threads that will start waiting
> after 'perf trace' starts, I guess.

Yes, see also the other mail on that. This would be very helpful, but only 
partially related to the goal I have in mind here :)

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
