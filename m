From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace & vfs_getname
Date: Tue, 24 May 2016 19:21:07 -0300
Message-ID: <20160524222107.GA8857@kernel.org>
References: <3503612.0WeV8glAT3@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34301 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbcEXWVY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 May 2016 18:21:24 -0400
Content-Disposition: inline
In-Reply-To: <3503612.0WeV8glAT3@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, May 24, 2016 at 10:42:12PM +0200, Milian Wolff escreveu:
> Hey Arnaldo,
> 
> I just wanted to try out your ongoing work to get file names printed in perf 
> trace:
> 
> ~~~~~~~~~~~~~~
> $ perf trace -e open ls builtin-trace.c
>      0.007 ( 0.007 ms): ls/26364 open(filename: 0x2a1b0d20, flags: CLOEXEC                             
> ) = -1 ENOENT No such file or directorybuiltin-trace.c
> 
>      0.022 ( 0.002 ms): ls/26364 open(filename: 0x2a1b0d20, flags: CLOEXEC                             
> ) = -1 ENOENT No such file or directory
> ...
> ~~~~~~~~~~~~~~
> 
> So apparently I still have to manually create the probe for vfs_getname. Could 
> this be simplified for the user? E.g. by adding a static tracepoint for that 

Yeah, this has to be simplified for the user.

> purpose, so one doesn't have to run `perf probe` manually? Also, note that 

That would be good, someone needs to try to convince upstream that one
more such tracepoint is warranted.

> `vfs_getname` is only mentioned in `man perf trace` for its `--tool_stats` 
> parameter, but the actual line to create the probe is nowhere to be found. 
> 
> Grepping the git log I found the following invocation, which errors out on my 
> Arch machine:
> 
> ~~~~~~~~~~~~~~~
> $ perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
> The /home/milian/.debug/.build-id/1a/03b857e3611b7a14fbf60d67cad7415706a933 
> file has no debug information.
> Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo package.
>   Error: Failed to add events.
> ~~~~~~~~~~~~~~~
> 
> On a different Arch machine it's:
> 
> ~~~~~~~~~~~~~~~
> $ perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
> The /lib/modules/4.5.4-1-ARCH/build/vmlinux file has no debug information.
> Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo package.
>   Error: Failed to add events.
> ~~~~~~~~~~~~~~~
> 
> On an Ubuntu 16.04 I'm getting this:
> 
> ~~~~~~~~~~~~~~~
> $ perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
> Failed to find the path for kernel: No such file or directory
>   Error: Failed to add events.
> ~~~~~~~~~~~~~~~
> 
> So does this really mean I'm out of luck?

For 'perf trace' to be a superset of strace it needs to pretty print
syscall args other than integers, and for that we need things like the
vfs_getname, or to go and look at several places where those syscalls
are copied to the kernel (move_addr_to_kernel, gename_flags), and back
(move_addr_to_user), etc.

I prototyped that with vfs_getname (if there is one such "wannabe
tracepoint" in place, set up with, say, perf probe, it will be used) but
never got around to actually try to push for a tracepoint for that, now
I'm briefly trying to deal with move_addr_to_kernel, to print the peer
addr in socket fds, but then I have to try to use BPF, as the
infrastructure that 'perf probe' uses in the kernel has no support for
memcpy, say, a struct (sockaddr_storage), just strings, which is enough
for "vfs_getname".

So, till we get there, the best you can do is to go from:

# perf probe -L getname_flags

to:

[root@jouet ~]# perf probe -L getname_flags:72
<getname_flags@/home/acme/git/linux/fs/namei.c:72>
     72         result->uptr = filename;
     73         result->aname = NULL;
                audit_getname(result);
     75         return result;
     76  }
         
         struct filename *
         getname(const char __user * filename)

[root@jouet ~]# 

And try adding the probe there.

Finding the right place without having debug info would be an option, we
would have to have a instruction decoder and find the right place,
tricky, brute forcish :-\

In a recent discussion (pvt) with Masami, we agreed that Ubuntu is even
worse in this regard, as we couldn't find the source code for the
running kernel easily, AFAIK it is in the linux-sources, but just as a
.bz2 file that you would have to uncompress somewhere :-\

Arch? I never tried it, would have to google for instructions on how to
use, say, systemtap (which is an older tool, so may have some tutorials
for Arch), and then set up the debuginfo/equivalent packages.

Yeah, the solution is to have tracepoints were such arguments are copied
to/from kernel/userspace, then no extra packages would be needed, etc.

- Arnaldo
