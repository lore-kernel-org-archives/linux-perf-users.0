From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 11:51:24 -0300
Message-ID: <20140918145124.GF2770@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
 <20140918132350.GE2770@kernel.org>
 <5166825.efsYl6z7uN@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34076 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716AbaIROvc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 10:51:32 -0400
Content-Disposition: inline
In-Reply-To: <5166825.efsYl6z7uN@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Em Thu, Sep 18, 2014 at 03:41:20PM +0200, Milian Wolff escreveu:
> On Thursday 18 September 2014 10:23:50 Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 18, 2014 at 02:32:10PM +0200, Milian Wolff escreveu:
> > > is it somehow possible to use perf based on some kernel timer? I'd like to
> > > get
> > Try with tracepoints or with probe points combined with callchains
> > instead of using a hardware counter.
 
> where would you add such tracepoints? Or what tracepoint would you use? And 
> what is the difference between tracepoints and probe points (I'm only aware of 
> `perf probe`).

tracepoints are places in the kernel (and in userspace as well, came
later tho) where developers put in place for later tracing.

They are super optimized, so have a lower cost than 'probe points' that
you can put in place using 'perf probe'.

To see the tracepoints, or any other available event in your system, use
'perf list'.

The debugfs filesystem will need to be mounted, but that will be
transparently done if the user has enough privileges.

For instance, here are some tracepoints that you may want to use:

[root@zoo ~]# perf list sched:*
  sched:sched_kthread_stop                           [Tracepoint event]
  sched:sched_kthread_stop_ret                       [Tracepoint event]
  sched:sched_wakeup                                 [Tracepoint event]
  sched:sched_wakeup_new                             [Tracepoint event]
  sched:sched_switch                                 [Tracepoint event]
  sched:sched_migrate_task                           [Tracepoint event]
  sched:sched_process_free                           [Tracepoint event]
  sched:sched_process_exit                           [Tracepoint event]
  sched:sched_wait_task                              [Tracepoint event]
  sched:sched_process_wait                           [Tracepoint event]
  sched:sched_process_fork                           [Tracepoint event]
  sched:sched_process_exec                           [Tracepoint event]
  sched:sched_stat_wait                              [Tracepoint event]
  sched:sched_stat_sleep                             [Tracepoint event]
  sched:sched_stat_iowait                            [Tracepoint event]
  sched:sched_stat_blocked                           [Tracepoint event]
  sched:sched_stat_runtime                           [Tracepoint event]
  sched:sched_pi_setprio                             [Tracepoint event]
  sched:sched_move_numa                              [Tracepoint event]
  sched:sched_stick_numa                             [Tracepoint event]
  sched:sched_swap_numa                              [Tracepoint event]
  sched:sched_wake_idle_without_ipi                  [Tracepoint event]
[root@zoo ~]

All tracepoints, for the system scheduler.

You can ask for all of them to be collected, togethed with callchains,
using:

[root@zoo ~]# perf record -a -e sched:* -g usleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.294 MB perf.data (~56528 samples) ]
[root@zoo ~]#

This collected system wide samples for all the scheduler tracepoints for
1 microsecond.

Use perf report and it will tell you how many of those tracepoints were
hit during this short system wide session, and will allow you to
traverse its callchains.

I would recommend that you take a look at Brendan Greggs _excellent_
tutorials at:

http://www.brendangregg.com/perf.html

He will explain all this in way more detail than I briefly skimmed
above. :-)

- Arnaldo
