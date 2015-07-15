From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace: file names, strace groups
Date: Wed, 15 Jul 2015 11:53:09 -0300
Message-ID: <20150715145309.GD3868@kernel.org>
References: <2853551.Qtj9hFrTSc@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38552 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbbGOOxW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jul 2015 10:53:22 -0400
Content-Disposition: inline
In-Reply-To: <2853551.Qtj9hFrTSc@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: Perf Users <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>

Executive summary:

. Check the latest sources, i.e. 4.2-rc

. Some of the stuff you report was implemented or fixed already

. Details about some of the limitations and advantages of 'perf trace' below

. Including an auto-tracing that will fix one of the problems you reported

Em Wed, Jul 15, 2015 at 03:02:21PM +0200, Milian Wolff escreveu:
> Hey all,
> 
> are there any plans to improve the `perf trace` utility to make it a drop-in 
> replacement for `strace`? `man strace` says "A traced process runs slowly.", 

Yes, 'perf trace' should go in that direction.

> and if I remember correctly, Brendan Gregg said this is due to strace using 
> the PTrace subsystem and not the faster alternative that `perf trace` is based 
> upon.

Right

> But, currently, `perf trace` is far from capable of replacing `strace` 
> for my common usecases:
> 
> $ touch test
> 
> $ strace -e file cat test
> execve("/usr/bin/cat", ["cat", "file"], [/* 90 vars */]) = 0
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
> directory)
> open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> open("/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
> open("file", O_RDONLY)                  = 3
> +++ exited with 0 +++
> 
> $ perf trace -e file cat file
> perf: Segmentation fault
> Obtained 10 stack frames.
> perf(dump_stack+0x32) [0x4d8652]
> perf(sighandler_dump_stack+0x29) [0x4d86e9]
> /usr/lib/libc.so.6(+0x335b0) [0x7f15bba065b0]
> perf(perf_evlist__mmap_read+0x35) [0x487445]
> perf(cmd_trace+0xe4b) [0x4582cb]
> perf() [0x47b593]
> perf(main+0x622) [0x427fe2]
> /usr/lib/libc.so.6(__libc_start_main+0xf0) [0x7f15bb9f3790]
> perf(_start+0x29) [0x428109]
> [(nil)]

[acme@zoo ~]$ touch test
[acme@zoo ~]$ trace -e file cat file
Error:	Invalid syscall file
Hint:	try 'perf list syscalls:sys_enter_*'
Hint:	and: 'man syscalls'
[acme@zoo ~]$

When I use 'trace', it is the same as 'perf trace', it is just a
hardlink and it checks argv[0] to use what is in
tools/perf/builtin-trace.c, etc.
 
> Two things to notice: perf version 4.1.0, and every trace call ends with the 
> above crash. But the file event group is not known to perf list, and thus 
> nothing gets traced. I'd expect an error message instead, i.e.:
> 
> $ strace -e asdf cat file
> strace: invalid system call 'asdf'

[acme@zoo ~]$ trace -e asdf cat file
Error:	Invalid syscall asdf
Hint:	try 'perf list syscalls:sys_enter_*'
Hint:	and: 'man syscalls'
[acme@zoo ~]$
 
> Now, if I instead do this:
> 
> $ perf trace -e open cat file
>      0.070 ( 0.003 ms): cat/8663 open(filename: 0x7f04b76a4a05, flags: CLOEXEC                         
> ) = 3
>      0.092 ( 0.003 ms): cat/8663 open(filename: 0x7f04b78acef0, flags: CLOEXEC                         
> ) = 3
>      0.245 ( 0.005 ms): cat/8663 open(filename: 0x7f04b7453310, flags: CLOEXEC                         
> ) = 3
>      0.277 ( 0.002 ms): cat/8663 open(filename: 0x7ffdba0902f8, mode: 131072                           
> ) = 3

[acme@zoo ~]$ trace -e open cat file
Error:	No permissions to read
/sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'

[acme@zoo ~]$ sudo mount -o remount,mode=755 /sys/kernel/debug
[sudo] password for acme: 
[acme@zoo ~]$ trace -e open cat file
Error:	No permissions to read
/sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing'

[acme@zoo ~]$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
[acme@zoo ~]$ trace -e open cat file
cat: file: No such file or directory
  0.325 ( 0.032 ms): cat/7295 open(filename: 0x7f5e1f049b92, flags: CLOEXEC) = 3
  0.361 ( 0.011 ms): cat/7295 open(filename: 0x7f5e1f24adc8, flags: CLOEXEC) = 3
  0.948 ( 0.019 ms): cat/7295 open(filename: 0x7f5e1edf86b0, flags: CLOEXEC) = 3
  1.099 ( 0.021 ms): cat/7295 open(filename: 0x7fff1460d22f, mode: 65536) = -1 ENOENT No such file or directory
  1.209 ( 0.024 ms): cat/7295 open(filename: 0x7fff1460a550, flags: CLOEXEC) = 3
  1.339 ( 0.017 ms): cat/7295 open(filename: 0xb86100, mode: 1) = -1 ENOENT No such file or directory
  1.345 ( 0.004 ms): cat/7295 open(filename: 0xb87190, mode: 12083520) = -1 ENOENT No such file or directory
  1.352 ( 0.005 ms): cat/7295 open(filename: 0xb86190, mode: 12087760) = -1 ENOENT No such file or directory
  1.359 ( 0.004 ms): cat/7295 open(filename: 0xb87110, mode: 12088032) = -1 ENOENT No such file or directory
  1.365 ( 0.004 ms): cat/7295 open(filename: 0xb87220, mode: 12087632) = -1 ENOENT No such file or directory
  1.385 ( 0.019 ms): cat/7295 open(filename: 0xb86210, mode: 12087904) = -1 ENOENT No such file or directory
[acme@zoo ~]$

 
> This is nice, esp. the time measurements. But why are the file names not 
> printed as strings? The pointer address does not help one at all. Also, the 

Because we don't use ptrace to stop the process and copy the string from
userspace, etc.

We have access, right now, to only what the tracepoints capture, and
they do not follow pointers.

So, there is already provision to either use a vfs_getname 'wannabe
tracepoint', i.e. a 'perf probe' put in the routine that copies stuff
from userspace to kernel space, and that works if you do something like:

  [root@zoo ~]# perf probe 'vfs_getname=getname_flags:72 pathname=filename:string'
  Added new event:
    probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)

  You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

  [root@zoo ~]#

So, after this if we try again:

[acme@zoo linux]$ trace -e open cat file
Error:	Operation not permitted.
Hint:	Check /proc/sys/kernel/perf_event_paranoid setting.
Hint:	For system wide tracing it needs to be set to -1.
Hint:	Try: 'sudo sh -c "echo -1 > /proc/sys/kernel/perf_event_paranoid"'
Hint:	The current value is 1.
[acme@zoo linux]$

Ok, now it sees the probe:vfs_getname tracepoint and tries to use it, but
normal users can't connect to kprobes... So, if we open the doors wide:

[acme@zoo linux]$ trace -e open cat file
cat: file: No such file or directory
     0.159 ( 0.012 ms): cat/7662 open(filename: 0x7f65e224cb92, flags: CLOEXEC) = 3

It still doesn't work, but at least it managed to connect to the probe, probably,
IIRC, open doesn't use getname_flags() to transfer the contents pointed by
'filename' in the open syscall from userspace to kernel space, or the logic to
connect the vfs_getname payload to the outstanding open syscall has issues, lets see:

[acme@zoo linux]$ perf record -e probe:vfs_getname cat file
cat: file: No such file or directory
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.017 MB perf.data (12 samples) ]
[acme@zoo linux]$ perf script
  cat 7682 [0] 1.093735: probe:vfs_getname: (ffffffff812230bc) pathname="/etc/ld.so.preload"
  cat 7682 [0] 1.093747: probe:vfs_getname: (ffffffff812230bc) pathname="/etc/ld.so.cache"
  cat 7682 [0] 1.093767: probe:vfs_getname: (ffffffff812230bc) pathname="/lib64/libc.so.6"
  cat 7682 [0] 1.094051: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/lib/locale/local
  cat 7682 [0] 1.094113: probe:vfs_getname: (ffffffff812230bc) pathname="file"
  cat 7682 [0] 1.094165: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/share/locale/loc
  cat 7682 [0] 1.094229: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/share/locale/en_
  cat 7682 [0] 1.094233: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/share/locale/en_
  cat 7682 [0] 1.094236: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/share/locale/en_
  cat 7682 [0] 1.094242: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/share/locale/en.
  cat 7682 [0] 1.094245: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/share/locale/en.
  cat 7682 [0] 1.094248: probe:vfs_getname: (ffffffff812230bc) pathname="/usr/share/locale/en/
(END)

So, good news, I guess some tweaking to the open logic in 'builtin-trace.c' will
do the trick for the open syscall as well, lets see again, using trace itself...

[acme@zoo linux]$ trace -e open --event probe:vfs_getname cat file
cat: file: No such file or directory
 0.163 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/etc/ld.so.preload")
 0.180 (0.004 ms): cat/7754 open(filename: 0x7fe6c4b86b92, flags: CLOEXEC                         ) ...
 0.180 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/etc/ld.so.cache")
 0.186 (0.010 ms): cat/7754  ... [continued]: open()) = 3
 0.206 (0.003 ms): cat/7754 open(filename: 0x7fe6c4d87dc8, flags: CLOEXEC                         ) ...
 0.206 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/lib64/libc.so.6")
 0.212 (0.009 ms): cat/7754  ... [continued]: open()) = 3
 0.477 (0.005 ms): cat/7754 open(filename: 0x7fe6c49356b0, flags: CLOEXEC                         ) ...
 0.477 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/lib/locale/locale-archive")
 0.485 (0.013 ms): cat/7754  ... [continued]: open()) = 3
 0.540 (0.003 ms): cat/7754 open(filename: 0x7fff70d9220f, mode: 65536                            ) ...
 0.540 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="file")
 0.545 (0.008 ms): cat/7754  ... [continued]: open()) = -1 ENOENT No such file or directory
 0.604 (0.005 ms): cat/7754 open(filename: 0x7fff70d8f610, flags: CLOEXEC                         ) ...
 0.604 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/locale.alias")
 0.612 (0.013 ms): cat/7754  ... [continued]: open()) = 3
 0.701 (0.006 ms): cat/7754 open(filename: 0x1315100, mode: 1                                     ) ...
 0.701 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo")
 0.707 (0.012 ms): cat/7754  ... [continued]: open()) = -1 ENOENT No such file or directory
 0.711 (0.003 ms): cat/7754 open(filename: 0x1316190, mode: 20009280                              ) ...
 0.711 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo")
 0.716 (0.007 ms): cat/7754  ... [continued]: open()) = -1 ENOENT No such file or directory
 0.720 (0.003 ms): cat/7754 open(filename: 0x1315190, mode: 20013520                              ) ...
 0.720 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en_US/LC_MESSAGES/libc.mo")
 0.724 (0.007 ms): cat/7754  ... [continued]: open()) = -1 ENOENT No such file or directory
 0.729 (0.003 ms): cat/7754 open(filename: 0x1316110, mode: 20013792                              ) ...
 0.729 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo")
 0.732 (0.006 ms): cat/7754  ... [continued]: open()) = -1 ENOENT No such file or directory
 0.736 (0.003 ms): cat/7754 open(filename: 0x1316220, mode: 20013392                              ) ...
 0.736 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo")
 0.740 (0.006 ms): cat/7754  ... [continued]: open()) = -1 ENOENT No such file or directory
 0.744 (0.003 ms): cat/7754 open(filename: 0x1315210, mode: 20013664                              ) ...
 0.744 (        ): probe:vfs_getname:(ffffffff812230bc) pathname="/usr/share/locale/en/LC_MESSAGES/libc.mo")
 0.749 (0.007 ms): cat/7754  ... [continued]: open()) = -1 ENOENT No such file or directory
[acme@zoo linux]$

Ok, that was good, using trace to trace trace and fix it, after lunch I'll give
it a try.

One not: -e expects syscall names, --event (or --ev, as it accepts the minimum
non-ambiguous part of a long option) expects perf events, but I think I'll make
both accept either "events", to avoid confusion with other perf tools, i.e.

  -e sched:*,open,close

Should do the same as:

  -e open,close --ev sched:*

Etc.

> O_RDONLY flag is not properly handled (compare to the strace output above).

It is zero, right? yeap:

#define O_RDONLY        00000000

syscall arguments with a zero payload are removed trying to make the output
more compact, and also for cases where some of the args are optional, to reduce
the logic needed to know when things are optional, just don't print zeroes.

This shortcut has issues, as in this case, where an exception seems to be
needed, i.e. we should print O_RDONLY, d'accord?
 
> I'd love to see someone working on this gem, as it really promises to be a 
> good replacement for strace.

Well, you're doing some work, getting some discussion going, I can code some
more if someone like you tests it and tries to use it in your use cases.

Bonus points go to whoever follows these discussions and writes some
documentation or blogs about it ;-)

Ok, now to juggle this with the eBPF enablement of perf... I can see
some synergies, like: please, trace network traffic to host foo.bar,
please... :-)

- Arnaldo
