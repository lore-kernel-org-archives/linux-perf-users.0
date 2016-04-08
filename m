From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf trace: Add support for printing call chains on
 sys_exit events.
Date: Fri, 8 Apr 2016 15:18:53 -0300
Message-ID: <20160408181853.GC25165@kernel.org>
References: <1460115255-17648-1-git-send-email-milian.wolff@kdab.com>
 <20160408175754.GB25165@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51855 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbcDHSS6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Apr 2016 14:18:58 -0400
Content-Disposition: inline
In-Reply-To: <20160408175754.GB25165@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

Em Fri, Apr 08, 2016 at 02:57:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Apr 08, 2016 at 01:34:15PM +0200, Milian Wolff escreveu:
> > Now, one can print the call chain for every encountered sys_exit
> > event, e.g.:

> > Note that it is advised to increase the number of mmap pages to
> > prevent event losses when using this new feature. Often, adding
> > `-m 10M` to the `perf trace` invocation is enough.

> > This feature is also available in strace when built with libunwind
> > via `strace -k`. Performance wise, this solution is much better:

> >     $ time find path/to/linux &> /dev/null

> >     real    0m0.051s
> >     user    0m0.013s
> >     sys     0m0.037s

> >     $ time perf trace -m 800M --call-graph dwarf find path/to/linux &>
> >     /dev/null

> >     real    0m2.624s
> >     user    0m1.203s
> >     sys     0m1.333s

> >     $ time strace -k find path/to/linux  &> /dev/null
 
> >     real    0m35.398s
> >     user    0m10.403s
> >     sys     0m23.173s

> > Note that it is currently not possible to configure the print output.
> > Adding such a feature, similar to what is available in `perf script`
> > via its `--fields` knob can be added later on.
 
> You mixed up multiple changes in one single patch, I'll break it down
> while testing, and before pushing upstream.

Expanding a bit the audience:

First test, it works, great! But do we really need that address? I guess not,
right, perhaps via some callchain parameter, to tell what we want to see? But
by default knowing the function name + DSO seems enough, no?

[root@jouet bpf]# trace -e nanosleep --call-graph dwarf usleep 1
     0.071 ( 0.071 ms): usleep/5455 nanosleep(rqtp: 0x7ffee070f080) = 0
	          2036be syscall_slow_exit_work ([kernel.kallsyms])
	          203dfb do_syscall_64 ([kernel.kallsyms])
	          9b8fe1 return_from_SYSCALL_64 ([kernel.kallsyms])
	    7f41622ec790 __nanosleep (/usr/lib64/libc-2.22.so)
	    7f416231d524 usleep (/usr/lib64/libc-2.22.so)
	    563b6c6afcab [unknown] (/usr/bin/usleep)
	    7f4162244580 __libc_start_main (/usr/lib64/libc-2.22.so)
	    563b6c6afce9 [unknown] (/usr/bin/usleep)
[root@jouet bpf]#

Yeah, you agree with that, now that I read the patch 8-):

+               /* TODO: user-configurable print_opts */
+               unsigned int print_opts = PRINT_IP_OPT_IP


Ok, removing that OPT_IP I get, oops, the alignment is beign done only on ip?

[root@jouet bpf]# trace -e nanosleep --call-graph dwarf usleep 1
     0.063 ( 0.063 ms): usleep/6132 nanosleep(rqtp: 0x7ffd1b7a8e70                                        ) = 0
 syscall_slow_exit_work ([kernel.kallsyms])
 do_syscall_64 ([kernel.kallsyms])
 return_from_SYSCALL_64 ([kernel.kallsyms])
 __nanosleep (/usr/lib64/libc-2.22.so)
 usleep (/usr/lib64/libc-2.22.so)
 [unknown] (/usr/bin/usleep)
 __libc_start_main (/usr/lib64/libc-2.22.so)
 [unknown] (/usr/bin/usleep)
[root@jouet bpf]# 

Fixing it up we get:

[root@jouet bpf]# trace -e nanosleep --call-graph dwarf usleep 1
     0.063 ( 0.063 ms): usleep/6132 nanosleep(rqtp: 0x7ffd1b7a8e70                                        ) = 0
                                    syscall_slow_exit_work ([kernel.kallsyms])
                                    do_syscall_64 ([kernel.kallsyms])
                                    return_from_SYSCALL_64 ([kernel.kallsyms])
                                    __nanosleep (/usr/lib64/libc-2.22.so)
                                    usleep (/usr/lib64/libc-2.22.so)
                                    [unknown] (/usr/bin/usleep)
                                    __libc_start_main (/usr/lib64/libc-2.22.so)
                                    [unknown] (/usr/bin/usleep)
[root@jouet bpf]# 

Better, but perhaps we should try aligning, up to a limit, the function names/DSOs?

[root@jouet bpf]# trace -e nanosleep --call-graph dwarf usleep 1
     0.063 ( 0.063 ms): usleep/6132 nanosleep(rqtp: 0x7ffd1b7a8e70                                        ) = 0
                                    syscall_slow_exit_work ([kernel.kallsyms])
                                    do_syscall_64          ([kernel.kallsyms])
                                    return_from_SYSCALL_64 ([kernel.kallsyms])
                                    __nanosleep            (/usr/lib64/libc-2.22.so)
                                    usleep                 (/usr/lib64/libc-2.22.so)
                                    [unknown]              (/usr/bin/usleep)
                                    __libc_start_main      (/usr/lib64/libc-2.22.so)
                                    [unknown]              (/usr/bin/usleep)
[root@jouet bpf]# 

wdyt?

Also, after this initial support is in, I think the next step is to
allow per syscall configs, like we have for per tracepoints, i.e. this
should be possible:

   # trace -e nanosleep(call-graph=dwarf),socket -a

And then we would get callchains just for nanosleep calls, not for
socket ones. We then need to think how to ask that efficiently to the
kernel, in this case it should be instead of using
raw_syscalls:sys_enter + tracepoint filters set via ioctl, to use
syscalls:sys_{enter,exit}_nanosleep, with callgraphs +
syscalls:sys_{enter,exit}_socket, without.

Doing it this way allows us to avoid asking callchains for a lot of
events when we want just for a few ones, to reduce overhead.

Anyway, I think I'll just break this down into multiple patches and then
we can work on these other aspects.

David, ah, his patch floated on the linux-perf-users mailing list, easy
one once the thread->priv one got out of the way (it was being used by
builtin-trace.c and the unwind code, ugh).

Thanks,

- Arnaldo
