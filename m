From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 11:33:40 -0300
Message-ID: <20140919143340.GB32694@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
 <2297882.Vc1x1zOfA6@milian-kdab2>
 <20140918155745.GH2770@kernel.org>
 <45528931.El8SOGvs6Z@milian-kdab2>
 <20140918191713.GK2770@kernel.org>
 <874mw4m9pg.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53122 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306AbaISOdu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 10:33:50 -0400
Content-Disposition: inline
In-Reply-To: <874mw4m9pg.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Milian Wolff <mail@milianw.de>, linux-perf-users <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

Em Fri, Sep 19, 2014 at 02:59:55PM +0900, Namhyung Kim escreveu:
> Hi Arnaldo and Millan,
> 
> On Thu, 18 Sep 2014 16:17:13 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 18, 2014 at 06:37:47PM +0200, Milian Wolff escreveu:
> >> That would indeed be very welcome. There are multiple "defaults" in perf which 
> >> I find highly confusing. The --no-children above e.g. could/should probably be 
> >> the default, no? Similar, I find it extremely irritating that `perf report -g` 

> > It was, this is something we've actually been discussing recently: the
> > change that made --children be the default mode. That is why I added
> > Namhyung and Ingo to the CC list, so that they become aware of more
> > reaction to this change.

> Yeah, we should rethink about changing the default now.  Actually I'm
> okay with the change, Ingo what do you think?
 
> >> defaults to `-g fractal` and not `-g graph`.
> >> 
> >> 100% foo
> >>   70% bar
> >>     70% asdf
> >>     30% lalala
> >>   30% baz

> >> is much harder to interpret than

> >> 100% foo
> >>   70% bar
> >>     49% asdf
> >>     21% lalala
> >>   30% baz

> I also agree with you. :)

> > But the question then is if this is configurable, if not that would be a
> > first step, i.e. making this possible via some ~/.perfconfig change.
 
> Yes, we have record.call-graph and top.call-graph config options now so
> adding a new report.call-graph option should not be difficult.  However
> I think it'd be better being call-graph.XXX as it can be applied to all

No problem, with sourcing being supported in ~/.perfconfig, we can have
as many #include call-graph.XXX as needed, multiple levels of includes
and all.

> other subcommands transparently.
 
> What about like below?
 
> [call-graph]
>   mode = dwarf
>   dump-size = 8192
>   print-type = fractal
>   order = callee
>   threshold = 0.5
>   print-limit = 128
>   sort-key = function

Milian, does this provide what you expect? How would we call this
specific call-graph profile?

Ideas on where to put this below tools/perf/?

> > Later we could advocate changing the default. Or perhaps provide some
> > "skins", i.e. config files that could be sourced into ~/.perfconfig so
> > that perf mimics the decisions of other profilers, with which people are
> > used to.

> > Kinda like making mutt behave like pine (as I did a long time ago), even
> > if just for a while, till one gets used to the "superior" default way of
> > doing things of the new tool :-)

> >> > > I did that already, but Brendan and the other available Perf documentation
> >> > > mostly concentrates on performance issues in the Kernel. I'm interested
> >> > > purely in the user space. Perf record with one of the hardware PMU events
> >> > > works nicely in that case, but one cannot use it to find locks&waits
> >> > > similar to what VTune offers.

> >> > Humm, yeah, you need to figure out how to solve your issue, what I tried
> >> > was to show what kinds of building blocks you could use to build what
> >> > you need, but no, there is no ready to use tool for this, that I am
> >> > aware of.
 
> I'm also *very* interest in collecting idle/wait info using perf.  Looks
> like we can somehow use sched:* tracepoints but it requires root
> privilege though (unless /proc/sys/kernel/perf_event_paranoid being -1).
 
> With that restriction however, we might improve perf sched (or even
> plain perf record/report) to provide such info..  David may have an
> idea. :)

So this is like, thinking just on userspace here for a change, using
syscall entry as the wait time entry, then later, when we are at syscall
exit time (another tracepoint) we subtract the time from syscall entry,
and that is our waiting-for-the-kernel time, put a call-chain there and
we can sort by that syscall time, i.e. a bit like 'perf trace' +
callchains, no?

I.e. if I want to see what syscalls are taking more than 50ms on my
system:

[root@zoo ProgramasRFB]# trace --duration 50 | head -10
   132.962 (85.670 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
   267.184 (134.110 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
   328.303 (263.584 ms): chrome/17715 poll(ufds: 0x3ae9a95653f0, nfds: 6, timeout_msecs: 263) = 0 Timeout
   380.623 (300.665 ms): xchat/17397 poll(ufds: 0x25397d0, nfds: 6, timeout_msecs: 300      ) = 0 Timeout
   425.713 (250.214 ms): qemu-system-x8/17344 ioctl(fd: 18<anon_inode:kvm-vcpu>, cmd: 0xae80) = 0
   545.482 (482.962 ms): chrome/18798 futex(uaddr: 0x7fff19d88624, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88590, val3: 4294967295) = -1 ETIMEDOUT Connection timed out
   547.938 (500.641 ms): chrome/18173 futex(uaddr: 0x7fe1c1ed796c, op: WAIT_BITSET|PRIV|CLKRT, val: 197751, utime: 0x7fe1c15b5a60, val3: 4294967295) = -1 ETIMEDOUT Connection timed out
   547.969 (272.853 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
   633.711 (500.637 ms): chrome/18829 futex(uaddr: 0x7fe1bdbb862c, op: WAIT_BITSET|PRIV|CLKRT, val: 89537, utime: 0x7fe1ba67ea60, val3: 4294967295) = -1 ETIMEDOUT Connection timed out
   633.767 (85.697 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
[root@zoo ProgramasRFB]#

But then want to filter this a bit more and exclude poll calls:

[root@zoo ProgramasRFB]# trace --duration 50 -e \!poll | head -10
   299.079 (221.049 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
   304.830 (250.211 ms): qemu-system-x8/17344 ioctl(fd: 18<anon_inode:kvm-vcpu>, cmd: 0xae80) = 0
   486.710 (187.180 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
   555.125 (250.216 ms): qemu-system-x8/17344 ioctl(fd: 18<anon_inode:kvm-vcpu>, cmd: 0xae80) = 0
   578.685 (500.638 ms): chrome/18829 futex(uaddr: 0x7fe1bdbb862c, op: WAIT_BITSET|PRIV|CLKRT, val: 89879, utime: 0x7fe1ba67ea60, val3: 4294967295) = -1 ETIMEDOUT Connection timed out
   578.749 (91.940 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
   800.123 (500.640 ms): chrome/18827 futex(uaddr: 0x7fe1b93aa7cc, op: WAIT_BITSET|PRIV|CLKRT, val: 89803, utime: 0x7fe1bd2b3a60, val3: 4294967295) = -1 ETIMEDOUT Connection timed out
   800.152 (500.618 ms): chrome/18077 futex(uaddr: 0x7fe1c179e96c, op: WAIT_BITSET|PRIV|CLKRT, val: 198047, utime: 0x7fe1c1637a60, val3: 4294967295) = -1 ETIMEDOUT Connection timed out
   800.165 (221.309 ms): chrome/18060 futex(uaddr: 0x7fff19d88924, op: WAIT_BITSET|PRIV, val: 1, utime: 0x7fff19d88890, val3: 4294967295) = 0
   805.419 (250.219 ms): qemu-system-x8/17344 ioctl(fd: 18<anon_inode:kvm-vcpu>, cmd: 0xae80) = 0
[root@zoo ProgramasRFB]#

format:

   time-since-start (syscall duration): ...

- Arnaldo
