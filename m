From: Milian Wolff <mail@milianw.de>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 18:37:47 +0200
Message-ID: <45528931.El8SOGvs6Z@milian-kdab2>
References: <2221771.b2oSN5LR6X@milian-kdab2> <2297882.Vc1x1zOfA6@milian-kdab2> <20140918155745.GH2770@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:55989 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbaIRQhu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 12:37:50 -0400
In-Reply-To: <20140918155745.GH2770@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>

On Thursday 18 September 2014 12:57:45 Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 18, 2014 at 05:26:33PM +0200, Milian Wolff escreveu:
> > On Thursday 18 September 2014 11:51:24 Arnaldo Carvalho de Melo wrote:

<snip>

> > b) The callgraphs are really strange, imo. Different traces are printed
> > with the same cost, which sounds wrong, no? See e.g. the multiple 44.44%
> > traces in sched:sched_wakeup.
> 
> Try using --no-children in the 'report' command line.

Nice, this is very useful. Many thanks!

> > c) Most of the traces point into the kernel, how can I hide these traces
> > and only concentrate on the user-space? Do I have to grep manually for
> > [.] ? I

> Oh well, for userspace you need to be aware of how callchains are
> collected, i.e. if your binaries and libraries use
> -fno-omit-frame-pointer, because if they do you will not get callchains
> going into userspace, so you will need to specifically ask for 'DWARF'
> callchains, from 'perf record' documentation:

I'm actually aware of that and I did add that option to my initial record 
call, sorry for not being clear here.

<snip>

> This has to be made automated, i.e. the tooling needs to figure out that
> the binaries used do use %bp for optimization and automagically collect
> DWARF, but till then, one needs to know about such issues and deal with
> it.

That would indeed be very welcome. There are multiple "defaults" in perf which 
I find highly confusing. The --no-children above e.g. could/should probably be 
the default, no? Similar, I find it extremely irritating that `perf report -g` 
defaults to `-g fractal` and not `-g graph`.

100% foo
  70% bar
    70% asdf
    30% lalala
  30% baz

is much harder to interpret than

100% foo
  70% bar
    49% asdf
    21% lalala
  30% baz

especially for more involved call chains. It took me quite some time to become 
aware of the ability to pass `-g graph` to get the desired output. KCacheGrind 
e.g. also defaults to something similar to `-g graph` and only optionally 
allows the user to get the "relative to parent" cost of `-g fractal`.

> User space support is something that as you see, is still rough, we need
> people like you trying it, but while it is rough, people tend to avoid
> it... :-\

Yes. But already perf is extremely useful and I use it a lot. I'm also 
actively educating people about using it more. I've talked about it at last 
year's Akademy and Qt Developer Days, and again this year at a profiling 
workshop at Akademy. Please keep up the good work!

> > tried something like `perf report --parent "main"` but that makes no
> > difference.
> > 
> > > I would recommend that you take a look at Brendan Greggs _excellent_
> > > tutorials at:
> > > 
> > > http://www.brendangregg.com/perf.html
> > > 
> > > He will explain all this in way more detail than I briefly skimmed
> > > above. :-)
> > 
> > I did that already, but Brendan and the other available Perf documentation
> > mostly concentrates on performance issues in the Kernel. I'm interested
> > purely in the user space. Perf record with one of the hardware PMU events
> > works nicely in that case, but one cannot use it to find locks&waits
> > similar to what VTune offers.
> 
> Humm, yeah, you need to figure out how to solve your issue, what I tried
> was to show what kinds of building blocks you could use to build what
> you need, but no, there is no ready to use tool for this, that I am
> aware of.
> 
> For instance, you need to collect scheduler events, then do some
> scripting, perhaps using perl or python, perhaps using the scripting
> support that is built into perf already, but yeah, not documented.

And also lacking the ability to get callgraphs, if I'm not mistaken. This is 
crucial for my undertaking. Or has this been added in the meantime?

<snip>

This was also why I asked my initial question, which I want to repeat once 
more: Is there a technical reason to not offer a "timer" software event to 
perf? I'm a complete layman when it comes to Kernel internals, but from a user 
point of view this would be awesome:

perf record --call-graph dwarf -e sw-timer -F 100 someapplication

This command would then create a timer in the kernel with a 100Hz frequency. 
Whenever it fires, the callgraphs of all threads in $someapplication are 
sampled and written to perf.data. Is this technically not feasible? Or is it 
simply not implemented?

I'm experimenting with a libunwind based profiler, and with some ugly signal 
hackery I can now grab backtraces by sending my application SIGUSR1. Based on 
that, I can probably create a profiling tool that fits my needs. I just wonder 
why one cannot do the same with perf.

Thanks for your time

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
