From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 16:17:13 -0300
Message-ID: <20140918191713.GK2770@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
 <2297882.Vc1x1zOfA6@milian-kdab2>
 <20140918155745.GH2770@kernel.org>
 <45528931.El8SOGvs6Z@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46243 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756197AbaIRTRU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 15:17:20 -0400
Content-Disposition: inline
In-Reply-To: <45528931.El8SOGvs6Z@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

Em Thu, Sep 18, 2014 at 06:37:47PM +0200, Milian Wolff escreveu:
> On Thursday 18 September 2014 12:57:45 Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 18, 2014 at 05:26:33PM +0200, Milian Wolff escreveu:
> > > On Thursday 18 September 2014 11:51:24 Arnaldo Carvalho de Melo wrote:
 
> <snip>
 
> > > b) The callgraphs are really strange, imo. Different traces are printed
> > > with the same cost, which sounds wrong, no? See e.g. the multiple 44.44%
> > > traces in sched:sched_wakeup.

> > Try using --no-children in the 'report' command line.

> Nice, this is very useful. Many thanks!

npo
 
> > > c) Most of the traces point into the kernel, how can I hide these traces
> > > and only concentrate on the user-space? Do I have to grep manually for
> > > [.] ? I

> > Oh well, for userspace you need to be aware of how callchains are
> > collected, i.e. if your binaries and libraries use
> > -fno-omit-frame-pointer, because if they do you will not get callchains
> > going into userspace, so you will need to specifically ask for 'DWARF'
> > callchains, from 'perf record' documentation:
 
> I'm actually aware of that and I did add that option to my initial record 
> call, sorry for not being clear here.
 
> <snip>
 
> > This has to be made automated, i.e. the tooling needs to figure out that
> > the binaries used do use %bp for optimization and automagically collect
> > DWARF, but till then, one needs to know about such issues and deal with
> > it.
> 
> That would indeed be very welcome. There are multiple "defaults" in perf which 
> I find highly confusing. The --no-children above e.g. could/should probably be 
> the default, no? Similar, I find it extremely irritating that `perf report -g` 

It was, this is something we've actually been discussing recently: the
change that made --children be the default mode. That is why I added
Namhyung and Ingo to the CC list, so that they become aware of more
reaction to this change.

> defaults to `-g fractal` and not `-g graph`.
> 
> 100% foo
>   70% bar
>     70% asdf
>     30% lalala
>   30% baz
> 
> is much harder to interpret than
> 
> 100% foo
>   70% bar
>     49% asdf
>     21% lalala
>   30% baz

But the question then is if this is configurable, if not that would be a
first step, i.e. making this possible via some ~/.perfconfig change.

Later we could advocate changing the default. Or perhaps provide some
"skins", i.e. config files that could be sourced into ~/.perfconfig so
that perf mimics the decisions of other profilers, with which people are
used to.

Kinda like making mutt behave like pine (as I did a long time ago), even
if just for a while, till one gets used to the "superior" default way of
doing things of the new tool :-)
 
> especially for more involved call chains. It took me quite some time to become 
> aware of the ability to pass `-g graph` to get the desired output. KCacheGrind 
> e.g. also defaults to something similar to `-g graph` and only optionally 
> allows the user to get the "relative to parent" cost of `-g fractal`.
> 
> > User space support is something that as you see, is still rough, we need
> > people like you trying it, but while it is rough, people tend to avoid
> > it... :-\
> 
> Yes. But already perf is extremely useful and I use it a lot. I'm also 
> actively educating people about using it more. I've talked about it at last 
> year's Akademy and Qt Developer Days, and again this year at a profiling 
> workshop at Akademy. Please keep up the good work!

Thanks a lot for doing that!

> > > tried something like `perf report --parent "main"` but that makes no
> > > difference.

> > > > I would recommend that you take a look at Brendan Greggs _excellent_
> > > > tutorials at:

> > > > http://www.brendangregg.com/perf.html

> > > > He will explain all this in way more detail than I briefly skimmed
> > > > above. :-)

> > > I did that already, but Brendan and the other available Perf documentation
> > > mostly concentrates on performance issues in the Kernel. I'm interested
> > > purely in the user space. Perf record with one of the hardware PMU events
> > > works nicely in that case, but one cannot use it to find locks&waits
> > > similar to what VTune offers.

> > Humm, yeah, you need to figure out how to solve your issue, what I tried
> > was to show what kinds of building blocks you could use to build what
> > you need, but no, there is no ready to use tool for this, that I am
> > aware of.

> > For instance, you need to collect scheduler events, then do some
> > scripting, perhaps using perl or python, perhaps using the scripting
> > support that is built into perf already, but yeah, not documented.

> And also lacking the ability to get callgraphs, if I'm not mistaken. This is 
> crucial for my undertaking. Or has this been added in the meantime?

I guess it was:

commit 57608cfd8827a74237d264a197722e2c99f72da4
Author: Joseph Schuchart <joseph.schuchart@tu-dresden.de>
Date:   Thu Jul 10 13:50:56 2014 +0200

    perf script: Provide additional sample information on generic events
    
    To python scripts, including pid, tid, and cpu for which the event
    was recorded.
    
    At the moment, the pointer to the sample struct is passed to
    scripts, which seems to be of little use.
    
    The patch puts this information in dictionaries for easy access by
    Python scripts.

commit 0f5f5bcd112292f14b75750dde7461463bb1c7bb
Author: Joseph Schuchart <joseph.schuchart@tu-dresden.de>
Date:   Thu Jul 10 13:50:51 2014 +0200

    perf script: Add callchain to generic and tracepoint events
    
    This provides valuable information for tracing performance problems.
    
    Since this change alters the interface for the python scripts, also
    adjust the script generation and the provided scripts.
 
> <snip>
> 
> This was also why I asked my initial question, which I want to repeat once 
> more: Is there a technical reason to not offer a "timer" software event to 
> perf? I'm a complete layman when it comes to Kernel internals, but from a user 
> point of view this would be awesome:
 
> perf record --call-graph dwarf -e sw-timer -F 100 someapplication
 
> This command would then create a timer in the kernel with a 100Hz frequency. 
> Whenever it fires, the callgraphs of all threads in $someapplication are 
> sampled and written to perf.data. Is this technically not feasible? Or is it 
> simply not implemented?

> I'm experimenting with a libunwind based profiler, and with some ugly signal 
> hackery I can now grab backtraces by sending my application SIGUSR1. Based on 

Humm, can't you do the same thing with perf? I.e. you send SIGUSR1 to
your app with the frequency you want, and then hook a 'perf probe' into
your signal... /me tries some stuff, will get back with results...

> that, I can probably create a profiling tool that fits my needs. I just wonder 
> why one cannot do the same with perf.

- Arnaldo
