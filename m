From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Reordering the thread output in perf trace --summary
Date: Wed, 4 May 2016 18:41:23 -0300
Message-ID: <20160504214123.GF11069@kernel.org>
References: <91397949.qTd2kn5sDj@milian-kdab2>
 <52227896.H02DnUL2Ue@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53680 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbcEDVl2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2016 17:41:28 -0400
Content-Disposition: inline
In-Reply-To: <52227896.H02DnUL2Ue@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Wed, May 04, 2016 at 11:51:04AM +0200, Milian Wolff escreveu:
> On Wednesday, May 4, 2016 11:02:12 AM CEST Milian Wolff wrote:
> > I would like to propose to reorder the output to sort the output in
> > ascending total event order, such that the most interesting output is shown
> > at the bottom of the output on the CLI. I.e. in the output above it should
> > be something like

> > perf trace --summary lab_mandelbrot_concurrent |& grep events
> > ... continued for a total of 163 lines
> >  lab_mandelbrot_ (19502), 88 events, 0.2%, 0.000 msec
> >  Thread (pooled) (19501), 114 events, 0.3%, 0.000 msec
> >  Thread (pooled) (19503), 106 events, 0.3%, 0.000 msec
> >  Thread (pooled) (19504), 101 events, 0.3%, 0.000 msec
> >  Thread (pooled) (19505), 102 events, 0.3%, 0.000 msec
> >  QDBusConnection (19499), 132 events, 0.4%, 0.000 msec
> >  QXcbEventReader (19498), 1094 events, 3.0%, 0.000 msec
> >  Thread (pooled) (19500), 1982 events, 5.5%, 0.000 msec
> >  lab_mandelbrot_ (19497), 9246 events, 25.7%, 0.000 msec

> > If this is acceptable to you, can someone please tell me how to do such a
> > seemingly simple task in C? In C++ I'd except to add a simple std::sort
> > somewhere, but in perf's C...? My current idea would be to run
> > machine__for_each_thread and store the even count + thread pointer in
> > another temporary buffer, which I then qsort and finally iterate over. Does
> > that sound OK, or how would you approach this task?
 
> While at it, can we similarly reorder the output of the per-thread syscall 
> list? At the moment it is e.g.:

Take a look at my perf/core branch, I have it working there.

I'm in the process of experimenting with creating some kinde of template
for resorting rb_trees, that will reduce the boilerplace while keeping
it following the principles described in Documentation/rbtree.txt.

Using it:

# trace -a -s sleep 1
<SNIP>
 gnome-shell (2231), 148 events, 10.3%, 0.000 msec

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   poll                  14     8.138     0.000     0.581     8.012     98.33%
   ioctl                 17     0.096     0.001     0.006     0.054     54.34%
   recvmsg               30     0.070     0.001     0.002     0.005      7.87%
   writev                 6     0.032     0.004     0.005     0.006      5.43%
   read                   4     0.010     0.002     0.003     0.003      9.83%
   write                  3     0.006     0.002     0.002     0.002     13.11%


 Xorg (1965), 150 events, 10.4%, 0.000 msec

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   select                11   377.791     0.000    34.345   267.619     72.83%
   writev                12     0.064     0.002     0.005     0.010     12.94%
   ioctl                  3     0.059     0.005     0.020     0.041     55.30%
   recvmsg               18     0.050     0.001     0.003     0.005     10.72%
   setitimer             18     0.032     0.001     0.002     0.004     10.40%
   rt_sigprocmask        10     0.014     0.001     0.001     0.004     20.81%
   poll                   2     0.004     0.001     0.002     0.003     47.14%
   read                   1     0.003     0.003     0.003     0.003      0.00%


 qemu-system-x86 (10021), 272 events, 18.8%, 0.000 msec

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   poll                 102   989.336     0.000     9.699    30.118     14.38%
   read                  34     0.200     0.003     0.006     0.014      7.01%


 qemu-system-x86 (9931), 464 events, 32.2%, 0.000 msec

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   ppoll                 96   982.288     0.000    10.232    30.035     12.59%
   write                 34     0.368     0.003     0.011     0.026      5.80%
   ioctl                102     0.290     0.001     0.003     0.010      4.74%


[root@jouet ~]# 

Gotta check why the total time per thread is zeroed tho...

- Arnaldo
