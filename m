From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Bug Report
Date: Mon, 11 May 2015 18:42:46 -0300
Message-ID: <20150511214246.GA29215@kernel.org>
References: <CAPMERti9KnqyR7U3upPz0wh14CEO=W1T=0_cDQ61cBASdKH-yQ@mail.gmail.com>
 <5550E37B.8070209@gmail.com>
 <CAPMERtji+=bZffRL-kFpvkte-P_U3DR3fs+FXe=zS9L91JphhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47520 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbbEKVmw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 May 2015 17:42:52 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C35C420CCB
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2015 21:42:50 +0000 (UTC)
Received: from zoo.ghostprotocols.net (unknown [177.35.16.174])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 872C120CCA
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2015 21:42:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPMERtji+=bZffRL-kFpvkte-P_U3DR3fs+FXe=zS9L91JphhQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alex Newman <posix4e@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

Em Mon, May 11, 2015 at 10:56:39AM -0700, Alex Newman escreveu:
> Ah sorry for the typo. David, that's correct. But you should be able
> to replicate that the error message is not revealing.

It should be changed to emit better messages like was done for 'perf
trace':

[acme@zoo linux]$ trace usleep 1
Error:	No permissions to read /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug'

[acme@zoo linux]$ sudo mount -o remount,mode=755 /sys/kernel/debug
[sudo] password for acme: 
[acme@zoo linux]$ trace usleep 1
     0.095 ( 0.002 ms): usleep/974 brk(                                                                  ) = 0x7f2dc04fd000
     0.112 ( 0.003 ms): usleep/974 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f2dbf39e000
     0.123 ( 0.006 ms): usleep/974 access(filename: 0x7f2dbf19c270, mode: R                              ) = -1 ENOENT No such file or directory
     0.137 ( 0.006 ms): usleep/974 open(filename: 0x7f2dbf19ab92, flags: CLOEXEC                         ) = 3
     0.141 ( 0.002 ms): usleep/974 fstat(fd: 3, statbuf: 0x7ffffabf0d60                                  ) = 0
     0.146 ( 0.004 ms): usleep/974 mmap(len: 98505, prot: READ, flags: PRIVATE, fd: 3                    ) = 0x7f2dbf385000
     0.148 ( 0.001 ms): usleep/974 close(fd: 3                                                           ) = 0
     0.164 ( 0.007 ms): usleep/974 open(filename: 0x7f2dbf39427a, flags: CLOEXEC                         ) = 3
     0.168 ( 0.002 ms): usleep/974 read(fd: 3, buf: 0x7ffffabf0ef0, count: 832                           ) = 832
     0.171 ( 0.001 ms): usleep/974 fstat(fd: 3, statbuf: 0x7ffffabf0d90                                  ) = 0
     0.179 ( 0.005 ms): usleep/974 mmap(len: 2147728, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f2dbef71000
     0.188 ( 0.007 ms): usleep/974 mprotect(start: 0x7f2dbef7c000, len: 2097152                          ) = 0
     0.194 ( 0.005 ms): usleep/974 mmap(addr: 0x7f2dbf17c000, len: 8192, prot: READ|WRITE, flags: PRIVATE|DENYWRITE|FIXED, fd: 3, off: 45056) = 0x7f2dbf17c000
     0.205 ( 0.001 ms): usleep/974 close(fd: 3                                                           ) = 0
     0.220 ( 0.007 ms): usleep/974 open(filename: 0x7f2dbf39b33b, flags: CLOEXEC                         ) = 3
     0.223 ( 0.002 ms): usleep/974 read(fd: 3, buf: 0x7ffffabf0ec0, count: 832                           ) = 832
     0.230 ( 0.002 ms): usleep/974 fstat(fd: 3, statbuf: 0x7ffffabf0d60                                  ) = 0
     0.237 ( 0.006 ms): usleep/974 mmap(len: 3919744, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f2dbebb4000
     0.247 ( 0.009 ms): usleep/974 mprotect(start: 0x7f2dbed67000, len: 2097152                          ) = 0
     0.255 ( 0.006 ms): usleep/974 mmap(addr: 0x7f2dbef67000, len: 24576, prot: READ|WRITE, flags: PRIVATE|DENYWRITE|FIXED, fd: 3, off: 1781760) = 0x7f2dbef67000
     0.273 ( 0.011 ms): usleep/974 mmap(addr: 0x7f2dbef6d000, len: 16256, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS|FIXED, fd: -1) = 0x7f2dbef6d000
     0.281 ( 0.001 ms): usleep/974 close(fd: 3                                                           ) = 0
     0.291 ( 0.003 ms): usleep/974 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f2dbf384000
     0.306 ( 0.003 ms): usleep/974 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f2dbf383000
     0.311 ( 0.002 ms): usleep/974 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f2dbf382000
     0.316 ( 0.001 ms): usleep/974 arch_prctl(option: 4098, arg2: 139834458388224, arg3: 139834458382352, arg4: 34, arg5: 4294967295) = 0
     0.386 ( 0.006 ms): usleep/974 mprotect(start: 0x7f2dbef67000, len: 16384, prot: READ                ) = 0
     0.396 ( 0.003 ms): usleep/974 mprotect(start: 0x7f2dbf17c000, len: 4096, prot: READ                 ) = 0
     0.407 ( 0.004 ms): usleep/974 mprotect(start: 0x7f2dbf5a3000, len: 4096, prot: READ                 ) = 0
     0.416 ( 0.005 ms): usleep/974 mprotect(start: 0x7f2dbf39f000, len: 4096, prot: READ                 ) = 0
     0.429 ( 0.012 ms): usleep/974 munmap(addr: 0x7f2dbf385000, len: 98505                               ) = 0
     0.487 ( 0.002 ms): usleep/974 brk(                                                                  ) = 0x7f2dc04fd000
     0.492 ( 0.004 ms): usleep/974 brk(brk: 0x7f2dc051e000                                               ) = 0x7f2dc051e000
     0.495 ( 0.001 ms): usleep/974 brk(                                                                  ) = 0x7f2dc051e000
     0.573 ( 0.059 ms): usleep/974 nanosleep(rqtp: 0x7ffffabf14e0                                        ) = 0
     0.581 ( 0.000 ms): usleep/974 exit_group(                                                           
[acme@zoo linux]$ 

[acme@zoo linux]$ trace --all-cpus
Error:	Operation not permitted.
Hint:	Check /proc/sys/kernel/perf_event_paranoid setting.
Hint:	For system wide tracing it needs to be set to -1.
Hint:	Try: 'sudo sh -c "echo -1 > /proc/sys/kernel/perf_event_paranoid"'
Hint:	The current value is 1.
[acme@zoo linux]$ 

Will try to do it soon,

- Arnaldo
 
> On Mon, May 11, 2015 at 10:14 AM, David Ahern <dsahern@gmail.com> wrote:
> > On 5/11/15 10:57 AM, Alex Newman wrote:
> >>
> >> Hello mailing list friends,
> >>
> >> I am sorry if this is not the best place for this (where should I
> >> report improvements for perf).
> >>
> >> This command works when I have the correct permissions but if I don't
> >> rather than getting "bad permissions" I get
> >>
> >> posix4e@posix4e-P27GV2:~$ perf stat -e 'ext4:' -a
> >
> >
> > that's an invalid event list; it should never work. Did you mean -e
> > 'ext4:*'?
> >
> > David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
