From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Sampling on sched:sched_switch
Date: Mon, 13 Apr 2015 12:11:48 -0300
Message-ID: <20150413151148.GI3200@kernel.org>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45219 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbbDMPLx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Apr 2015 11:11:53 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B9933202DD
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 15:11:52 +0000 (UTC)
Received: from zoo.ghostprotocols.net (unknown [187.65.119.65])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9A905202B4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 15:11:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, Apr 13, 2015 at 06:34:38PM +0530, sahil aggarwal escreveu:
> Hi
> 
> I am enabling sampling on tracepoint: sched:sched_switch, during which
> i get no data points for a particular process but when i run:

"sampling" what target? System wide? How are you setting up
perf_event_attr?
 
> perf stat -e "context_switch" <some exec>

s/context_switch/sched:sched_switch/g, right?

> then it shows that exec was context switched.
> 
> How it could be possible.?

Why would it not?

[root@zoo ~]# perf stat -e sched:sched_switch usleep 1

 Performance counter stats for 'usleep 1':

                 1      sched:sched_switch                                          

       0.001180692 seconds time elapsed

[root@zoo ~]#

[root@zoo ~]# perf trace --ev sched:sched_switch usleep 1 | tail
  0.407 ( 0.004 ms): usleep/9676 mprotect(start: 0x601000, len: 4096, prot: READ      ) = 0
  0.417 ( 0.005 ms): usleep/9676 mprotect(start: 0x7f1649452000, len: 4096, prot: READ) = 0
  0.429 ( 0.010 ms): usleep/9676 munmap(addr: 0x7f1649436000, len: 108577             ) = 0
  0.495 ( 0.002 ms): usleep/9676 brk(                                                 ) = 0xe5b000
  0.500 ( 0.004 ms): usleep/9676 brk(brk: 0xe7c000                                    ) = 0xe7c000
  0.503 ( 0.001 ms): usleep/9676 brk(                                                 ) = 0xe7c000
  0.525 ( 0.005 ms): usleep/9676 nanosleep(rqtp: 0x7fffc0c7f7e0                       ) ...
  0.525 (         ): sched:sched_switch:usleep:9676 [120] S ==> swapper/2:0 [120])
  0.582 ( 0.062 ms): usleep/9676  ... [continued]: nanosleep()) = 0
  0.588 ( 0.000 ms): usleep/9676 exit_group(                                                           
[root@zoo ~]#

When we expected it to :-)

Now, this is how perf_event_attr is being set, in both cases (the code setting
up the perf_event_attr in 'perf trace' and 'perf stat' is the same):

[root@zoo ~]# perf stat -vv -e sched:sched_switch usleep 1
<SNIP>
perf_event_attr:
  type                             2
  size                             112
  config                           107
  { sample_period, sample_freq }   1
  sample_type                      TIME|CPU|PERIOD|RAW
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 9685  cpu -1  group_fd -1  flags 0x8
sched:sched_switch: 1 688844 688844

 Performance counter stats for 'usleep 1':

                 1      sched:sched_switch                                          

       0.001368517 seconds time elapsed

[root@zoo ~]#

[root@zoo ~]# perf trace -vv --ev sched:sched_switch usleep 1 
<SNIP>
perf_event_attr:
  type                             2
  size                             112
  config                           107
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|TIME|ID|CPU|PERIOD|RAW
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  { wakeup_events, wakeup_watermark } 1
<SNIP setting up the other events, for the syscall events>
  0.491 ( 0.002 ms): usleep/9693 brk(                                            ) = 0xd41000
  0.502 ( 0.004 ms): usleep/9693 brk(brk: 0xd62000                               ) = 0xd62000
  0.505 ( 0.002 ms): usleep/9693 brk(                                            ) = 0xd62000
  0.527 ( 0.005 ms): usleep/9693 nanosleep(rqtp: 0x7ffc7df44ee0                  ) ...
  0.527 (         ): sched:sched_switch:usleep:9693 [120] S ==> swapper/1:0 [120])
  0.583 ( 0.061 ms): usleep/9693  ... [continued]: nanosleep()) = 0
  0.589 ( 0.000 ms): usleep/9693 exit_group(                                                           
[root@zoo ~]# 

In the 'perf trace' case we need more stuff into sample_type, like ID, because
we need to map back to multiple events: sched:sched_switch, raw_syscalls:sys_e{nter,xit}, etc.

- Arnaldo
