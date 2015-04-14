From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: Sampling on sched:sched_switch
Date: Tue, 14 Apr 2015 09:15:59 -0300
Message-ID: <20150414121559.GD16027@kernel.org>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
 <20150413151148.GI3200@kernel.org>
 <CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35189 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359AbbDNMQD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Apr 2015 08:16:03 -0400
Received: from [187.65.119.65] (helo=zoo.ghostprotocols.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1Yhzl4-00021p-LW
	for linux-perf-users@vger.kernel.org; Tue, 14 Apr 2015 12:16:02 +0000
Content-Disposition: inline
In-Reply-To: <CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Apr 14, 2015 at 11:12:11AM +0530, sahil aggarwal escreveu:
> In my case:
 
> bash-4.1# sudo perf stat -e sched:sched_switch sleep 1
 
>  Performance counter stats for 'sleep 1':
 
>                  0 sched:sched_switch
 
>        1.004714901 seconds time elapsed

So, there are some critical pieces of information missing here:

- perf --version
- cat /proc/cpuinfo
- uname -a
- What distribution is this?

So that we can try to figure this out.
 
> And  if i do:
 
> bash-4.1# perf stat -e cs sleep 1

>  Performance counter stats for 'sleep 1':
 
>                  1 cs
 
>        1.003306642 seconds time elapsed
 
> To enable sampling on sched:sched_switch my perf_event_attr look like:
 
>         e_open->attr.disabled           = 1;
>         e_open->attr.type                  = PERF_TYPE_TRACEPOINT;
>         e_open->attr.config               = 87;

in my machine:

[root@zoo ~]# cat /sys/kernel/debug/events/sched/sched_switch/format 
name: sched_switch
ID: 263


>         e_open->attr.size                  = sizeof(e_open->attr);
>         e_open->attr.sample_period = 1;
>         e_open->attr.inherit               = 1;
>         e_open->attr.sample_type     = PERF_SAMPLE_TIME      |
> PERF_SAMPLE_RAW       |
> PERF_SAMPLE_CPU       |
> PERF_SAMPLE_TID       ;
>         e_open->attr.__reserved_1       = 0;
>         e_open->attr.read_format        = 0;
 
> Running in separate thread for each CPU:

Running in separate thread for each CPU? Can you ellaborate on this?

> perf_event_open(&e_open->attr,2552,0,-1,0)
> perf_event_open(&e_open->attr,2552,1,-1,0)

So you have two counters, one in each CPU, for the same thread? What is
the intent?

If I go to do it with 'perf stat' it uses:

[root@zoo ~]# perf stat -vv -p 7762 -e sched:*switch 2>&1 | grep sys_perf_event_open
sys_perf_event_open: pid 7762  cpu -1  group_fd -1  flags 0x8
^C[root@zoo ~]#

Just one sys_perf_event_open syscall, stating that its the thread 7762
that should be monitored, in whatever CPU it ends up running.

Of course I can have multiple sys_perf_event_open() calls, from
different users even, if they have the appropriate permissions, and as
well many from the same user, but why, on the same monitoring session,
create one thread per CPU if the thread will only run in one CPU at a
time? You will end up having to order events from multiple ring buffers,
etc.

> 
> But if do :
> 
>        e_open->attr.disabled           = 1;
>         e_open->attr.type                  = PERF_TYPE_SOFTWARE;
>         e_open->attr.config               = PERF_COUNT_SW_CONTEXT_SWITCHES;
>         e_open->attr.size                  = sizeof(e_open->attr);
>         e_open->attr.sample_period = 1;
>         e_open->attr.inherit               = 1;
>         e_open->attr.sample_type     = PERF_SAMPLE_TIME      |
> 
> PERF_SAMPLE_RAW       |
> 
> PERF_SAMPLE_CPU       |
> 
> PERF_SAMPLE_TID       ;
>         e_open->attr.__reserved_1       = 0;
>         e_open->attr.read_format          = 0;
> 
> It writes events to ring buffer but of course without any
> args(prev_comm,prev_pid,next_comm,next_pid)
> 
> So i am not able to understand this difference. Why sched:sched_switch
> doesnt give me any counter.

The difference is that you're using two different kinds of events, as you
can see on the attr.type and attr.config above, for some reason in your
case the PERF_TYPE_TRACEPOINT one is not happening, being lost or not
being asked for in some subtle way.

- Arnaldo
