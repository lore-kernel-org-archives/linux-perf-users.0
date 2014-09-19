From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 11:47:47 -0300
Message-ID: <20140919144747.GC32694@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
 <541B3DED.1010306@gmail.com>
 <20140918203625.GM2770@kernel.org>
 <5770573.p6hpIeRPQV@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53630 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756425AbaISOr5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 10:47:57 -0400
Content-Disposition: inline
In-Reply-To: <5770573.p6hpIeRPQV@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

Em Fri, Sep 19, 2014 at 10:11:21AM +0200, Milian Wolff escreveu:
> On Thursday 18 September 2014 17:36:25 Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 18, 2014 at 02:17:49PM -0600, David Ahern escreveu:
> > > On 9/18/14, 1:17 PM, Arnaldo Carvalho de Melo wrote:
> > > >>This was also why I asked my initial question, which I want to repeat
> > > >>once
> > > >>
> > > >>>more: Is there a technical reason to not offer a "timer" software event
> > > >>>to
> > > >>>perf? I'm a complete layman when it comes to Kernel internals, but from
> > > >>>a user point of view this would be awesome:
> > > >>>
> > > >>>perf record --call-graph dwarf -e sw-timer -F 100 someapplication
> > > >>>
> > > >>>This command would then create a timer in the kernel with a 100Hz
> > > >>>frequency. Whenever it fires, the callgraphs of all threads in
> > > >>>$someapplication are sampled and written to perf.data. Is this
> > > >>>technically not feasible? Or is it simply not implemented?
> > > >>>I'm experimenting with a libunwind based profiler, and with some ugly
> > > >>>signal hackery I can now grab backtraces by sending my application
> > > >>>SIGUSR1. Based on> >
> > > >Humm, can't you do the same thing with perf? I.e. you send SIGUSR1 to
> > > >your app with the frequency you want, and then hook a 'perf probe' into
> > > >your signal... /me tries some stuff, will get back with results...
> 
> That is actually a very good idea. With the more powerful scripting abilities 
> in perf now, that could/should do the job indeed. I'll also try this out.

Now that the need for getting a backtrace from existing threads, a-la
using ptrace via gdb to attach to it and then traverse its stack to
provide that backtrace, I think we need to do something on the perf
infrastructure in the kernel to do that, i.e. somehow signal the perf
kernel part that we want a backtrace for some specific thread.

Not at event time, but at some arbitrary time, be it creating an event
that, as you suggested, will create a timer and then when that timer
fires will use (parts of the) mechanism used by ptrace.

But in the end we need a mechanism to ask for backtraces for existing,
sleeping, threads.

For waits in the future, we just need to ask for the tracepoints where
waits take place and with the current infrastructure we can get most/all
of what we need, no?
 
> > > Current profiling options with perf require the process to be running.
> > > What

> > Ok, so you want to see what is the wait channel and unwind the stack
> > from there? Is that the case? I.e. again, a sysrq-t equivalent?
 
> Hey again :)
 
> If I'm not mistaken, I could not yet bring my point across. The final goal is 

Right, but the discussion so far was to see if the existing kernel
infrastructure would allow us to write such a tool.

> to profile both, wait time _and_ CPU time, combined! By sampling a userspace 
> program with a constant frequency and some statistics one can get extremely 
> useful information out of the data. I want to use perf to automate the process 
> that Mike Dunlavey explains here: http://stackoverflow.com/a/378024/35250

Will read.
 
> So yes, I want to see the wait channel and unwind from there, if the process 
> is waiting. Otherwise just do the normal unwinding you'd do when any other 
> perf event occurs.

Ok, we need two mechanisms to get that, one for existing, sleeping
threads at the time we start monitoring (we don't have that now other
than freezing the process, looking for threads that were waiting, then
using ptrace and asking for that backtrace), and another for threads
that will sleep/wait _after_ we start monitoring.
 
> > > Milian want is to grab samples every timer expiration even if process is
> > > not running.
> > 
> > What for? And by "grab samples" you want to know where it is waiting for
> > something, together with its callchain?
> 
> See above. If I can sample the callchain every N ms, preferrably in a per-

Do you need to take periodic samples of the callchain? Or only when you
wait for something?

For things that happen at such a high freq, yeah, just sampling would be
better, but you're thinking about slow things, so multiple samples for
something waiting and waiting is not needed, just when it starts
waiting, right?

> thread manner, I can create tools which find the slowest userspace functions. 
> This is based on "inclusive" cost, which is made up out of CPU time _and_ wait 
> time combined. With it one will find all of the following:
> 
>   - CPU hotspots
>   - IO wait time
>   - lock contention in a multi-threaded application
 
> > > Any limitations that would prevent doing this with a sw event? e.g, mimic
> > > task-clock just don't disable the timer when the task is scheduled out.

> > I'm just trying to figure out if what people want is a complete
> > backtrace of all threads in a process, no matter what they are doing, at
> > some given time, i.e. at "sysrq-t" time, is that the case?
 
> Yes, that sounds correct to me. I tried it out on my system, but the output in 
> dmesg is far too large and I could not find the call stack information of my 
> test application while it slept. Looking at the other backtraces I see there, 
> I'm not sure whether sysrq-t only outputs a kernel-backtrace? Or maybe it's 

sysrq-t is just for the kernel, that is why I said that you seemed to
want it to cross into userspace.

> because I'm missing debug symbols for these applications?
> 
> [167576.049113] mysqld          S 0000000000000000     0 17023      1 
> 0x00000000
> [167576.049115]  ffff8801222a7ad0 0000000000000082 ffff8800aa8c9460 
> 0000000000014580
> [167576.049117]  ffff8801222a7fd8 0000000000014580 ffff8800aa8c9460 
> ffff8801222a7a18
> [167576.049119]  ffffffff812a2640 ffff8800bb975c40 ffff880237cd4ef0 
> ffff8801222a7b20
> [167576.049121] Call Trace:
> [167576.049124]  [<ffffffff812a2640>] ? cpumask_next_and+0x30/0x50
> [167576.049126]  [<ffffffff810b65b4>] ? add_wait_queue+0x44/0x50
> [167576.049128]  [<ffffffff8152ceb9>] schedule+0x29/0x70
> [167576.049130]  [<ffffffff8152c4ad>] schedule_hrtimeout_range_clock+0x3d/0x60
> [167576.049132]  [<ffffffff8152c4e3>] schedule_hrtimeout_range+0x13/0x20
> [167576.049134]  [<ffffffff811d5589>] poll_schedule_timeout+0x49/0x70
> [167576.049136]  [<ffffffff811d6d5e>] do_sys_poll+0x4be/0x570
> [167576.049138]  [<ffffffff81155880>] ? __alloc_pages_nodemask+0x180/0xc20
> [167576.049140]  [<ffffffff8108e3ae>] ? alloc_pid+0x2e/0x4c0
> [167576.049142]  [<ffffffff811d5700>] ? poll_select_copy_remaining+0x150/0x150
> [167576.049145]  [<ffffffff810bd1f0>] ? cpuacct_charge+0x50/0x60
> [167576.049147]  [<ffffffff811a5de3>] ? kmem_cache_alloc+0x143/0x170
> [167576.049149]  [<ffffffff8108e3ae>] ? alloc_pid+0x2e/0x4c0
> [167576.049151]  [<ffffffff810a7d08>] ? __enqueue_entity+0x78/0x80
> [167576.049153]  [<ffffffff810addee>] ? enqueue_entity+0x24e/0xaa0
> [167576.049155]  [<ffffffff812a2640>] ? cpumask_next_and+0x30/0x50
> [167576.049158]  [<ffffffff810ae74d>] ? enqueue_task_fair+0x10d/0x5b0
> [167576.049160]  [<ffffffff81045c3d>] ? native_smp_send_reschedule+0x4d/0x70
> [167576.049162]  [<ffffffff8109e740>] ? resched_task+0xc0/0xd0
> [167576.049165]  [<ffffffff8109fff7>] ? check_preempt_curr+0x57/0x90
> [167576.049167]  [<ffffffff810a2e2b>] ? wake_up_new_task+0x11b/0x1c0
> [167576.049169]  [<ffffffff8106d5c6>] ? do_fork+0x136/0x3f0
> [167576.049171]  [<ffffffff811df235>] ? __fget_light+0x25/0x70
> [167576.049173]  [<ffffffff811d6f37>] SyS_poll+0x97/0x120
> [167576.049176]  [<ffffffff81530d69>] ? system_call_fastpath+0x16/0x1b
> [167576.049178]  [<ffffffff81530d69>] system_call_fastpath+0x16/0x1b
> 
> I'm interested in the the other side of the fence. The backtrace could/should 
> stop at system_call_fastpath.

Right, adding callchains to 'perf trace' and using it with --duration
may provide a first approximation for threads that will start waiting
after 'perf trace' starts, I guess.

- Arnaldo
