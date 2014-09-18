From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 12:57:45 -0300
Message-ID: <20140918155745.GH2770@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
 <5166825.efsYl6z7uN@milian-kdab2>
 <20140918145124.GF2770@kernel.org>
 <2297882.Vc1x1zOfA6@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38110 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756327AbaIRP5x (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 11:57:53 -0400
Content-Disposition: inline
In-Reply-To: <2297882.Vc1x1zOfA6@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>

Em Thu, Sep 18, 2014 at 05:26:33PM +0200, Milian Wolff escreveu:
> On Thursday 18 September 2014 11:51:24 Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 18, 2014 at 03:41:20PM +0200, Milian Wolff escreveu:
> > > On Thursday 18 September 2014 10:23:50 Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Sep 18, 2014 at 02:32:10PM +0200, Milian Wolff escreveu:
> > > > > is it somehow possible to use perf based on some kernel timer? I'd
> > > > > like to get

> > > > Try with tracepoints or with probe points combined with callchains
> > > > instead of using a hardware counter.
> > > 
> > > where would you add such tracepoints? Or what tracepoint would you use?
> > > And
> > > what is the difference between tracepoints and probe points (I'm only
> > > aware of `perf probe`).
> > 
> > tracepoints are places in the kernel (and in userspace as well, came
> > later tho) where developers put in place for later tracing.
> > 
> > They are super optimized, so have a lower cost than 'probe points' that
> > you can put in place using 'perf probe'.
> > 
> > To see the tracepoints, or any other available event in your system, use
> > 'perf list'.
> > 
> > The debugfs filesystem will need to be mounted, but that will be
> > transparently done if the user has enough privileges.
> 
> Thanks for the quick rundown Arnaldo! Sadly, that much I "knew" already, yet 
> am not able to understand how to use for my purpose.
> 
> > For instance, here are some tracepoints that you may want to use:
> > 
> > [root@zoo ~]# perf list sched:*
 
> <snip>
 
> I tried this:
 
> # a.out is the result of compiling `int main { sleep(1); return 0; }`:
> perf record -e sched:* --call-graph dwarf ./a.out
> perf report -g graph --stdio
> # the result can be found here: http://paste.kde.org/pflkskwrf
 
> How do I have to interpret this?
 
> a) This is not Wall-clock profiling, no? It just grabs a callgraph whenever 
> one of the sched* events occurs, none of these events will occur, say, every X 
> ms.
> b) The callgraphs are really strange, imo. Different traces are printed with 
> the same cost, which sounds wrong, no? See e.g. the multiple 44.44% traces in 
> sched:sched_wakeup.

Try using --no-children in the 'report' command line.

> c) Most of the traces point into the kernel, how can I hide these traces and 
> only concentrate on the user-space? Do I have to grep manually for [.] ? I 

Oh well, for userspace you need to be aware of how callchains are
collected, i.e. if your binaries and libraries use
-fno-omit-frame-pointer, because if they do you will not get callchains
going into userspace, so you will need to specifically ask for 'DWARF'
callchains, from 'perf record' documentation:

    --call-graph
        Setup and enable call-graph (stack chain/backtrace) recording, implies -g.

            Allows specifying "fp" (frame pointer) or "dwarf"
            (DWARF's CFI - Call Frame Information) as the method to collect
            the information used to show the call graphs.

            In some systems, where binaries are build with gcc
            --fomit-frame-pointer, using the "fp" method will produce bogus
            call graphs, using "dwarf", if available (perf tools linked to
            the libunwind library) should be used instead.


This has to be made automated, i.e. the tooling needs to figure out that
the binaries used do use %bp for optimization and automagically collect
DWARF, but till then, one needs to know about such issues and deal with
it.

User space support is something that as you see, is still rough, we need
people like you trying it, but while it is rough, people tend to avoid
it... :-\


> tried something like `perf report --parent "main"` but that makes no 
> difference.
> 
> > I would recommend that you take a look at Brendan Greggs _excellent_
> > tutorials at:
> > 
> > http://www.brendangregg.com/perf.html
> > 
> > He will explain all this in way more detail than I briefly skimmed
> > above. :-)
> 
> I did that already, but Brendan and the other available Perf documentation 
> mostly concentrates on performance issues in the Kernel. I'm interested purely 
> in the user space. Perf record with one of the hardware PMU events works 
> nicely in that case, but one cannot use it to find locks&waits similar to what 
> VTune offers.

Humm, yeah, you need to figure out how to solve your issue, what I tried
was to show what kinds of building blocks you could use to build what
you need, but no, there is no ready to use tool for this, that I am
aware of.

For instance, you need to collect scheduler events, then do some
scripting, perhaps using perl or python, perhaps using the scripting
support that is built into perf already, but yeah, not documented.

You could try starting with:

[root@ssdandy ~]# perf script -l
List of available trace scripts:
  net_dropmonitor                      display a table of dropped frames
  failed-syscalls-by-pid [comm]        system-wide failed syscalls, by pid
  syscall-counts [comm]                system-wide syscall counts
  netdev-times [tx] [rx] [dev=] [debug] display a process of packet and processing time
  sctop [comm] [interval]              syscall top
  syscall-counts-by-pid [comm]         system-wide syscall counts, by pid
  sched-migration                      sched migration overview
  event_analyzing_sample               analyze all perf samples
  futex-contention                     futext contention measurement
  failed-syscalls [comm]               system-wide failed syscalls
  workqueue-stats                      workqueue stats (ins/exe/create/destroy)
  wakeup-latency                       system-wide min/max/avg wakeup latency
  rw-by-file <comm>                    r/w activity for a program, by file
  rw-by-pid                            system-wide r/w activity
  rwtop [interval]                     system-wide r/w top
[root@ssdandy ~]#

They will all have a 'perf record'  phase that will collect some
tracepoints into a perf.data file, then some perl/python scripts to
handle the events and get to some conclusion or generate some tables,
etc.

Haven't tested these in a while, wouldn't be surprised if some of them
bitrotted.

- Arnaldo
