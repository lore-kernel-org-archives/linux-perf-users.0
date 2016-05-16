From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace: Problems initializing symbol libraries!
Date: Mon, 16 May 2016 17:13:59 -0300
Message-ID: <20160516201359.GB3455@kernel.org>
References: <2323271.hRPH2PSKxc@milian-kdab2>
 <20160512181044.GK20258@kernel.org>
 <1849423.FYp0BrzLMo@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34103 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbcEPUOF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 May 2016 16:14:05 -0400
Content-Disposition: inline
In-Reply-To: <1849423.FYp0BrzLMo@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, May 16, 2016 at 01:31:48PM +0200, Milian Wolff escreveu:
> On Donnerstag, 12. Mai 2016 15:10:44 CEST Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 12, 2016 at 02:05:35PM +0200, Milian Wolff escreveu:
> > > I'm getting the following error when trying to run `perf trace` built from
> > > acme's perf/core branch on an Ubuntu 16.04 machine:
> > > 
> > > $ perf trace
> > > Problems initializing symbol libraries!

Ok, so with the perf tool that comes with ubuntu 16.04 I get:

  acme@ubuntu:~$ perf record ls
  WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
  check /proc/sys/kernel/kptr_restrict.

  Samples in kernel functions may not be resolved if a suitable vmlinux
  file is not found in the buildid cache or in the vmlinux path.

  Samples in kernel modules won't be resolved at all.

  If some relocation was applied (e.g. kexec) symbols may be misresolved
  even with a suitable vmlinux or kallsyms file.

  Cannot read kernel map
  Couldn't record kernel reference relocation symbol
  Symbol resolution may be skewed if relocation was used (e.g. kexec).
  Check /proc/kallsyms permission or run as root.
  git  perf.data
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (14 samples) ]
  acme@ubuntu:~$

Which is a better message than:

  acme@ubuntu:~$ perf trace
  Error:	No permissions to read /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
  Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing'

  acme@ubuntu:~$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
  acme@ubuntu:~$ perf trace
  Error:	No permissions to read /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
  Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing'

  acme@ubuntu:~$ sudo mount -o remount,mode=755 /sys/kernel/debug
  acme@ubuntu:~$ perf trace
  Problems initializing symbol libraries!
  acme@ubuntu:~$

So, if I follow the instructions given in the 'perf record ls' case:

  acme@ubuntu:~$ sudo sh -c "echo 0 > /proc/sys/kernel/kptr_restrict"
  acme@ubuntu:~$ perf trace
  Error:	Operation not permitted.
  Hint:	Check /proc/sys/kernel/perf_event_paranoid setting.
  Hint:	For system wide tracing it needs to be set to -1.
  Hint:	Try: 'sudo sh -c "echo -1 > /proc/sys/kernel/perf_event_paranoid"'
  Hint:	The current value is 1.
  acme@ubuntu:~$ 

It gets a bit better, then, one more step...

  acme@ubuntu:~$ perf trace --ev sched:sched_switch -e nanosleep sleep 1
       0.938 (   0.025 ms): sleep/7461 nanosleep(rqtp: 0x7ffc77ca6310                                        ) ...
       0.938 (           ): sched:sched_switch:prev_comm=sleep prev_pid=7461 prev_prio=120 prev_state=S ==> next_comm=swapper/1 next_pid=0 next_prio=120)
    1001.076 (1000.163 ms): sleep/7461  ... [continued]: nanosleep()) = 0
  acme@ubuntu:~$ 

So, the problem is not with what is in my perf/core branch, its that ubuntu
16.04's kernel comes with kptr_restrict defaulting to 1, I have to get that
warning emitted by 'perf record' into 'perf trace'.

- Arnaldo
