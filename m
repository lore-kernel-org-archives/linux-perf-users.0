From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problems with -b, and confusing error messages
Date: Wed, 5 Oct 2016 08:11:31 -0300
Message-ID: <20161005111131.GO7143@kernel.org>
References: <CAMRJFfLVEHrJ3zqExY=SMzuw8TS7V5A4sy5N2vW9moL=uYvYvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbcJELLl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2016 07:11:41 -0400
Content-Disposition: inline
In-Reply-To: <CAMRJFfLVEHrJ3zqExY=SMzuw8TS7V5A4sy5N2vW9moL=uYvYvg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jonas Wagner <jonas.wagner@epfl.ch>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Oct 04, 2016 at 05:02:58PM +0200, Jonas Wagner escreveu:
> I would like to ask for help, because perf stopped working when I
> enable taken branch stack sampling (with the -b option). Here are a
> few examples:
> 
> $ perf record -b /bin/true
> Error:
> 'precise' request may not be supported. Try removing 'p' modifier.
> 
> $ perf record -b -e cycles /bin/true
> Error:
> No hardware sampling interrupt available.
> No APIC? If so then you can boot the kernel with the "lapic" boot
> parameter to force-enable it.
> 
> $ perf record -e cycles /bin/true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.014 MB perf.data (8 samples) ]
> 
> $ perf record -e cycles:p /bin/true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.014 MB perf.data (9 samples) ]
> 
> $ cat /proc/cmdline
> BOOT_IMAGE=/boot/vmlinuz-4.4.0-38-generic
> root=UUID=a5440a73-d559-4b61-808c-2430cd67ba25 ro quiet lapic
> 
> I have a couple questions about this:
> 
> 1. What's wrong? Branch stack sampling used to work on this machine...
> how can I make it work again?
> 2. Apparently, the problem is not related to the precise modifier, or
> the lapic boot parameter. Could we make these error messages more
> meaningful?
> 
> Note regarding (1): I recently upgraded the kernel on this machine
> from 4.4.0-36-generic to 4.4.0-38-generic, on Ubuntu Xenial. Using the
> previous kernel, perf worked fine. It's tricky for me to undo the
> update though :(
> 
> Help would be appreciated. Happy to provide more logs if needed. Thanks!

So the message needs to be improved, no question about it, but can you
try running as root or tweaking perf_event_paranoid, as here I have:

[root@jouet ~]# perf record -b /bin/true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (9 samples) ]
[root@jouet ~]# uname -a
Linux jouet 4.7.3-200.fc24.x86_64 #1 SMP Wed Sep 7 17:31:21 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
[root@jouet ~]# perf record -b /bin/true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (8 samples) ]
[root@jouet ~]# perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, branch_sample_type: ANY
[root@jouet ~]# 


And, as user:

[acme@jouet linux]$ perf record -b /bin/true
Error:
You may not have permission to collect stats.

Consider tweaking /proc/sys/kernel/perf_event_paranoid,
which controls use of the performance events system by
unprivileged users (without CAP_SYS_ADMIN).

The current value is 2:

  -1: Allow use of (almost) all events by all users
>= 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
>= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
>= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN
[acme@jouet linux]$

If I tweak /proc/sys/kernel/perf_event_paranoid, changing it from 2 to 1, say:

[acme@jouet linux]$ perf record -b /bin/true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (9 samples) ]
[acme@jouet linux]$ perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, branch_sample_type: ANY
[acme@jouet linux]$

It seems to work.

IIRC there was a change in the default of /proc/sys/kernel/perf_event_paranoid
in Ubuntu recently, I bet this is the case.

Probably they did that but forgot to update the tool, that would get better
error messages, but still not that good wrt branch stack support :-\

- Arnaldo
