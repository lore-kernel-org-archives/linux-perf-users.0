From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace: file names, strace groups
Date: Wed, 15 Jul 2015 16:43:15 -0300
Message-ID: <20150715194315.GC8114@kernel.org>
References: <2853551.Qtj9hFrTSc@milian-kdab2>
 <20150715145309.GD3868@kernel.org>
 <239503894.ASNylTKZCF@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54691 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307AbbGOTng (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jul 2015 15:43:36 -0400
Content-Disposition: inline
In-Reply-To: <239503894.ASNylTKZCF@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: Perf Users <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>

Em Wed, Jul 15, 2015 at 05:41:53PM +0200, Milian Wolff escreveu:
> On Wednesday 15 July 2015 11:53:09 Arnaldo Carvalho de Melo wrote:
> > Executive summary:
> > 
> > . Check the latest sources, i.e. 4.2-rc
> 
> I could also try to compile perf from git, if you tell me what branch and 
> remote I should use.

The branch I use for new features, for the next merge window (the kernel
one, that we tag along) is here:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git  perf/core

> > . Some of the stuff you report was implemented or fixed already

> > . Details about some of the limitations and advantages of 'perf trace' below

> > . Including an auto-tracing that will fix one of the problems you reported
> 
> Nice, thanks for that!
> 
> <snip>
> 
> > [acme@zoo ~]$ trace -e file cat file
> > Error:	Invalid syscall file
> > Hint:	try 'perf list syscalls:sys_enter_*'
> > Hint:	and: 'man syscalls'
 
> Just to be clear: Supporting the strace groups as a collection of syscalls 
> will be implemented? Or is that not possible, as it goes straight down to the 
> perf event subsystem which does not know this group?

Right, I'll implement a strlist__new_with_expansions(), to break a CSV
list and look for some specific keys, that when found will expand into
other keys, like what is done for strace -e file, i.e. file becomes
open,write,close, making sure there are no duplicates.

Then it will be just a matter of providing the expansors for those
strace groups.

> <snip>
> 
> > Ok, that was good, using trace to trace trace and fix it, after lunch I'll
> > give it a try.
> 
> Cool, so you'll add that internally such that the hoops are not necessary on 
> the user side to get the filename? Excellent! I also notice that 

Yes, one other plan is to get bits and pieces of 'perf probe' to be more usable
by other tools, so that we can add these probes, but this is fragile, being
useful just for some areas that are not that much in flux, this vfs_getname
one, for isntance has changed multiple times, i.e. the place where we have to
insert the probe and also the variable name we need to get (the one where the
copy from userspace was already done, etc).

> close/read/write and others /sometimes/ write out the filename:
> 
>     10.404 ( 0.001 ms): kmimetypefinde/8217 read(fd: 6</etc/localtime>, buf: 
> 0x7ffe2b6d1319, count: 15671         ) = 0
> 
>     10.529 ( 0.004 ms): kmimetypefinde/8494 read(fd: 6, buf: 0x7ffc61c45b40, 
> count: 8192                          ) = 4
> 
> This is also pretty odd.

Well, when it intercepts the vfs_getname it stores the filename in a per
thread storage, then, when it gets an open syscall return, the fd, it
associates, in an array, per thread, the filename to the fd, and then,
when that fd appears again in another syscall, it expands it, showing
the name.

When vfs_getname is not used, it still works, to some degree, but by generating
some noise in the system by reading the /proc/PID/fd/ symlinks, which is racy,
etc.

Which reminds me what needs to be done for open: to defer printing the
syscall args till we get the vfs_getname tracepoint, when we realize
what is the filename, matching the pointer to the contents... But that
has some complications, as when open itself is interrupted by some other
event... I.e. we need to somehow indicate that, for instance:

 0.605 (0.002 ms): cat/13780 open(filename: 0x78a220, mode: 7905616                                ) ...
 0.605 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo")
 0.608 (0.004 ms): cat/13780  ... [continued]: open()) = -1 ENOENT No such file or directory

I.e. normally we print the first line with what is in the
raw_syscall:sys_enter, and that is just the filename pointer, as you
see above, but then, we will do the association of that pointer to
its contents ("/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo") when
we get that probe:vfs_getname...

 0.605 (0.002 ms): cat/13780 open(filename: 0x78a220, mode: 7905616                                ) ...
 0.605 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo")
 0.608 (0.004 ms): cat/13780  ... [continued]: open()) = -1 ENOENT No such file or directory

We could transform that into:

 0.605 (0.002 ms): cat/13780 open( ... interrupted
 0.605 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo")
 0.608 (0.004 ms): cat/13780  ... [continued]: open(filename = "/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", mode: 7905616)) = -1 ENOENT No such file or directory

That, when no interruption happens, i.e. no event from syscall enter to syscall
exit happens, i.e. when "probe:vfs_getname" isn't one of the events select, for
instance,  would result into:

 0.605 (0.002 ms): cat/13780 open(filename = "/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", mode: 7905616)) = -1 ENOENT No such file or directory

Now we need just to write the code for that ;-)

> <snip>
> 
> > > O_RDONLY flag is not properly handled (compare to the strace output
> > > above).
> > 
> > It is zero, right? yeap:
> > 
> > #define O_RDONLY        00000000
> > 
> > syscall arguments with a zero payload are removed trying to make the output
> > more compact, and also for cases where some of the args are optional, to
> > reduce the logic needed to know when things are optional, just don't print
> > zeroes.
> > 
> > This shortcut has issues, as in this case, where an exception seems to be
> > needed, i.e. we should print O_RDONLY, d'accord?
> 
> Yes, that would be good to have here, I guess. In general, the closer the 
> output gets to `strace`, the better.

Ok.
 
- Arnaldo
