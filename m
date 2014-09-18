From: Milian Wolff <mail@milianw.de>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 17:26:33 +0200
Message-ID: <2297882.Vc1x1zOfA6@milian-kdab2>
References: <2221771.b2oSN5LR6X@milian-kdab2> <5166825.efsYl6z7uN@milian-kdab2> <20140918145124.GF2770@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:53643 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbaIRP0g (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 11:26:36 -0400
In-Reply-To: <20140918145124.GF2770@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Thursday 18 September 2014 11:51:24 Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 18, 2014 at 03:41:20PM +0200, Milian Wolff escreveu:
> > On Thursday 18 September 2014 10:23:50 Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Sep 18, 2014 at 02:32:10PM +0200, Milian Wolff escreveu:
> > > > is it somehow possible to use perf based on some kernel timer? I'd
> > > > like to
> > > > get
> > > 
> > > Try with tracepoints or with probe points combined with callchains
> > > instead of using a hardware counter.
> > 
> > where would you add such tracepoints? Or what tracepoint would you use?
> > And
> > what is the difference between tracepoints and probe points (I'm only
> > aware of `perf probe`).
> 
> tracepoints are places in the kernel (and in userspace as well, came
> later tho) where developers put in place for later tracing.
> 
> They are super optimized, so have a lower cost than 'probe points' that
> you can put in place using 'perf probe'.
> 
> To see the tracepoints, or any other available event in your system, use
> 'perf list'.
> 
> The debugfs filesystem will need to be mounted, but that will be
> transparently done if the user has enough privileges.

Thanks for the quick rundown Arnaldo! Sadly, that much I "knew" already, yet 
am not able to understand how to use for my purpose.

> For instance, here are some tracepoints that you may want to use:
> 
> [root@zoo ~]# perf list sched:*

<snip>

I tried this:

# a.out is the result of compiling `int main { sleep(1); return 0; }`:
perf record -e sched:* --call-graph dwarf ./a.out
perf report -g graph --stdio
# the result can be found here: http://paste.kde.org/pflkskwrf

How do I have to interpret this?

a) This is not Wall-clock profiling, no? It just grabs a callgraph whenever 
one of the sched* events occurs, none of these events will occur, say, every X 
ms.
b) The callgraphs are really strange, imo. Different traces are printed with 
the same cost, which sounds wrong, no? See e.g. the multiple 44.44% traces in 
sched:sched_wakeup.
c) Most of the traces point into the kernel, how can I hide these traces and 
only concentrate on the user-space? Do I have to grep manually for [.] ? I 
tried something like `perf report --parent "main"` but that makes no 
difference.

> I would recommend that you take a look at Brendan Greggs _excellent_
> tutorials at:
> 
> http://www.brendangregg.com/perf.html
> 
> He will explain all this in way more detail than I briefly skimmed
> above. :-)

I did that already, but Brendan and the other available Perf documentation 
mostly concentrates on performance issues in the Kernel. I'm interested purely 
in the user space. Perf record with one of the hardware PMU events works 
nicely in that case, but one cannot use it to find locks&waits similar to what 
VTune offers.

Bye

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
