From: Milian Wolff <mail@milianw.de>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 16:53:42 +0200
Message-ID: <38149799.gZAnD74qWP@milian-kdab2>
References: <2221771.b2oSN5LR6X@milian-kdab2> <874mw4m9pg.fsf@sejong.aot.lge.com> <20140919143340.GB32694@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:46843 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805AbaISOxo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 10:53:44 -0400
In-Reply-To: <20140919143340.GB32694@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On Friday 19 September 2014 11:33:40 Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 19, 2014 at 02:59:55PM +0900, Namhyung Kim escreveu:
> > Hi Arnaldo and Millan,
> > 
> > On Thu, 18 Sep 2014 16:17:13 -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Sep 18, 2014 at 06:37:47PM +0200, Milian Wolff escreveu:
> > >> That would indeed be very welcome. There are multiple "defaults" in
> > >> perf which I find highly confusing. The --no-children above e.g.
> > >> could/should probably be the default, no? Similar, I find it extremely
> > >> irritating that `perf report -g`> > 
> > > It was, this is something we've actually been discussing recently: the
> > > change that made --children be the default mode. That is why I added
> > > Namhyung and Ingo to the CC list, so that they become aware of more
> > > reaction to this change.
> > 
> > Yeah, we should rethink about changing the default now.  Actually I'm
> > okay with the change, Ingo what do you think?
> > 
> > >> defaults to `-g fractal` and not `-g graph`.
> > >> 
> > >> 100% foo
> > >> 
> > >>   70% bar
> > >>   
> > >>     70% asdf
> > >>     30% lalala
> > >>   
> > >>   30% baz
> > >> 
> > >> is much harder to interpret than
> > >> 
> > >> 100% foo
> > >> 
> > >>   70% bar
> > >>   
> > >>     49% asdf
> > >>     21% lalala
> > >>   
> > >>   30% baz
> > 
> > I also agree with you. :)
> > 
> > > But the question then is if this is configurable, if not that would be a
> > > first step, i.e. making this possible via some ~/.perfconfig change.
> > 
> > Yes, we have record.call-graph and top.call-graph config options now so
> > adding a new report.call-graph option should not be difficult.  However
> > I think it'd be better being call-graph.XXX as it can be applied to all
> 
> No problem, with sourcing being supported in ~/.perfconfig, we can have
> as many #include call-graph.XXX as needed, multiple levels of includes
> and all.
> 
> > other subcommands transparently.
> > 
> > What about like below?
> > 
> > [call-graph]
> > 
> >   mode = dwarf
> >   dump-size = 8192
> >   print-type = fractal
> >   order = callee
> >   threshold = 0.5
> >   print-limit = 128
> >   sort-key = function
> 
> Milian, does this provide what you expect? How would we call this
> specific call-graph profile?

print-type should be graph, not fractal. Otherwise it sounds good to me. But 
how would one use it? I tried putting it into ~/.perfconfig, but apparently my 
3.16.2-1-ARCH Perf does not support this feature yet? How/when would that 
config be used? As soon as one does "perf record -g" (for mode and dump-size) 
or "perf report" (for a perf.data with call graphs)? That would be very 
useful!

> Ideas on where to put this below tools/perf/?

Nope.

> > > Later we could advocate changing the default. Or perhaps provide some
> > > "skins", i.e. config files that could be sourced into ~/.perfconfig so
> > > that perf mimics the decisions of other profilers, with which people are
> > > used to.
> > > 
> > > Kinda like making mutt behave like pine (as I did a long time ago), even
> > > if just for a while, till one gets used to the "superior" default way of
> > > doing things of the new tool :-)
> > > 
> > >> > > I did that already, but Brendan and the other available Perf
> > >> > > documentation
> > >> > > mostly concentrates on performance issues in the Kernel. I'm
> > >> > > interested
> > >> > > purely in the user space. Perf record with one of the hardware PMU
> > >> > > events
> > >> > > works nicely in that case, but one cannot use it to find
> > >> > > locks&waits
> > >> > > similar to what VTune offers.
> > >> > 
> > >> > Humm, yeah, you need to figure out how to solve your issue, what I
> > >> > tried
> > >> > was to show what kinds of building blocks you could use to build what
> > >> > you need, but no, there is no ready to use tool for this, that I am
> > >> > aware of.
> > 
> > I'm also *very* interest in collecting idle/wait info using perf.  Looks
> > like we can somehow use sched:* tracepoints but it requires root
> > privilege though (unless /proc/sys/kernel/perf_event_paranoid being -1).
> > 
> > With that restriction however, we might improve perf sched (or even
> > plain perf record/report) to provide such info..  David may have an
> > idea. :)
> 
> So this is like, thinking just on userspace here for a change, using
> syscall entry as the wait time entry, then later, when we are at syscall
> exit time (another tracepoint) we subtract the time from syscall entry,
> and that is our waiting-for-the-kernel time, put a call-chain there and
> we can sort by that syscall time, i.e. a bit like 'perf trace' +
> callchains, no?
> 
> I.e. if I want to see what syscalls are taking more than 50ms on my
> system:
> 
> [root@zoo ProgramasRFB]# trace --duration 50 | head -10
<snip>
> 
> But then want to filter this a bit more and exclude poll calls:
> 
> [root@zoo ProgramasRFB]# trace --duration 50 -e \!poll | head -10
<snip>

This sounds useful. If it now would also print backtraces... :) But note how 
this would not find a userspace function that does 5 syscalls, each taking 
10ms.

And again, just sampling syscalls is not what I'm looking for. It is 
definitely a good tool to have at hand, but very specific already. If you want 
to get an overview on where your app is spending time, having a Wall-time 
overview is much more helpful as it will also show CPU hotspots or stuff 
unrelated to syscalls.

Bye

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
