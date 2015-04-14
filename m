From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: Sampling on sched:sched_switch
Date: Tue, 14 Apr 2015 09:59:21 -0300
Message-ID: <20150414125921.GJ16027@kernel.org>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
 <20150413151148.GI3200@kernel.org>
 <CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
 <20150414121559.GD16027@kernel.org>
 <CAGAANTUAJJmBBSRijursj2VxCg=1kbEP90BRMW2-J0S83tzRug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53426 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbDNM7Y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Apr 2015 08:59:24 -0400
Received: from [187.65.119.65] (helo=zoo.ghostprotocols.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1Yi0R1-0004jC-VZ
	for linux-perf-users@vger.kernel.org; Tue, 14 Apr 2015 12:59:24 +0000
Content-Disposition: inline
In-Reply-To: <CAGAANTUAJJmBBSRijursj2VxCg=1kbEP90BRMW2-J0S83tzRug@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Apr 14, 2015 at 06:00:17PM +0530, sahil aggarwal escreveu:
> > So, there are some critical pieces of information missing here:
> > - perf --version
 
> bash-4.1# perf --version
> perf version 3.2.17

This is really, really super old, but should probably not be a problem
:-)
 
> > - cat /proc/cpuinfo
 
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 45
> model name : Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz

<SNIP>
 
> > - uname -a
> bash-4.1# uname -a
> Linux ops-es2 3.2.66-amd64 #1 SMP Wed Mar 4 16:29:30 IST 2015 x86_64 GNU/Linux

Humm, when you think that something is wrong about a piece of software you're
dealing with, please try using the latest release for that software to see if
the results are the same, because you may be hitting a bug long fixed.

Anyway, read on :-)

> > [root@zoo ~]# cat /sys/kernel/debug/events/sched/sched_switch/format
> > name: sched_switch
> > ID: 263
 
> bash-4.1# cat /sys/kernel/debug/tracing/events/sched/sched_switch/id
> 87
 
> > So you have two counters, one in each CPU, for the same thread? What is
> > the intent?

> I have multiple tracepoints(say ~20-25), i tried it to enable them for
> all CPU's but when i do attr->inherit = 1, it doesnt mmap the FD(

This is incomplete: "multiple events for all CPUS" ok, but for a specific
thread? Or for all of them?

See this, look for the inherit flag, then look for the CPU arg to
sys_perf_event_open, many tracepoints, a process that creates a process that
creates a process that makes a networking call that hits net:*skb* tracepoints,
is something like that that you want?

[root@zoo ~]# perf stat -vv -e sched:* -e skb:* time time ping -c 1 127.0.0.1
<SNIP>
------------------------------------------------------------
perf_event_attr:
  type                             2
  size                             112
  config                           10b
  { sample_period, sample_freq }   1
  sample_type                      TIME|CPU|PERIOD|RAW
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 9944  cpu -1  group_fd -1  flags 0x8
------------------------------------------------------------
perf_event_attr:
  type                             2
  size                             112
  config                           10a
  { sample_period, sample_freq }   1
  sample_type                      TIME|CPU|PERIOD|RAW
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1      
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 9944  cpu -1  group_fd -1  flags 0x8
------------------------------------------------------------
perf_event_attr:
  type                             2
  size                             112
  config                           109
  { sample_period, sample_freq }   1
  sample_type                      TIME|CPU|PERIOD|RAW
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 9944  cpu -1  group_fd -1  flags 0x8
------------------------------------------------------------
perf_event_attr:
  type                             2
  size                             112
  config                           108
  { sample_period, sample_freq }   1
  sample_type                      TIME|CPU|PERIOD|RAW
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 9944  cpu -1  group_fd -1  flags 0x8
------------------------------------------------------------

<suppress many other tracepoint perf_event_attr dumps>

------------------------------------------------------------
sys_perf_event_open: pid 9944  cpu -1  group_fd -1  flags 0x8
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.061 ms

--- 127.0.0.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.061/0.061/0.061/0.000 ms
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 2244maxresident)k
0inputs+0outputs (0major+102minor)pagefaults 0swaps
0.00user 0.00system 0:00.00elapsed 50%CPU (0avgtext+0avgdata 2244maxresident)k
0inputs+0outputs (0major+182minor)pagefaults 0swaps
sched:sched_kthread_stop: 0 2488023 2488023
sched:sched_kthread_stop_ret: 0 2488023 2488023
sched:sched_wakeup: 130 2488023 2488023
sched:sched_wakeup_new: 4 2488023 2488023
sched:sched_switch: 122 2488023 2488023
sched:sched_migrate_task: 6 2488023 2488023
sched:sched_process_free: 0 2488023 2488023
sched:sched_process_exit: 3 2488023 2488023
sched:sched_wait_task: 0 2488023 2488023
sched:sched_process_wait: 2 2488023 2488023
sched:sched_process_fork: 2 2488023 2488023
sched:sched_process_exec: 3 2488023 2488023
sched:sched_stat_wait: 0 2488023 2488023
sched:sched_stat_sleep: 0 2488023 2488023
sched:sched_stat_iowait: 0 2488023 2488023
sched:sched_stat_blocked: 0 2488023 2488023
sched:sched_stat_runtime: 2354533 2488023 2488023
sched:sched_pi_setprio: 0 2488023 2488023
sched:sched_move_numa: 0 2488023 2488023
sched:sched_stick_numa: 0 2488023 2488023
sched:sched_swap_numa: 0 2488023 2488023
sched:sched_wake_idle_without_ipi: 7 2488023 2488023
skb:kfree_skb: 1 2488023 2488023
skb:consume_skb: 2 2488023 2488023
skb:skb_copy_datagram_iovec: 1 2488023 2488023

 Performance counter stats for 'time time ping -c 1 127.0.0.1':

                 0      sched:sched_kthread_stop                                    
                 0      sched:sched_kthread_stop_ret                                   
               130      sched:sched_wakeup                                          
                 4      sched:sched_wakeup_new                                      
               122      sched:sched_switch                                          
                 6      sched:sched_migrate_task                                    
                 0      sched:sched_process_free                                    
                 3      sched:sched_process_exit                                    
                 0      sched:sched_wait_task                                       
                 2      sched:sched_process_wait                                    
                 2      sched:sched_process_fork                                    
                 3      sched:sched_process_exec                                    
                 0      sched:sched_stat_wait                                       
                 0      sched:sched_stat_sleep                                      
                 0      sched:sched_stat_iowait                                     
                 0      sched:sched_stat_blocked                                    
         2,354,533      sched:sched_stat_runtime                                    
                 0      sched:sched_pi_setprio                                      
                 0      sched:sched_move_numa                                       
                 0      sched:sched_stick_numa                                      
                 0      sched:sched_swap_numa                                       
                 7      sched:sched_wake_idle_without_ipi                                   
                 1      skb:kfree_skb                                               
                 2      skb:consume_skb                                             
                 1      skb:skb_copy_datagram_iovec                                   

       0.003088642 seconds time elapsed

[root@zoo ~]# 


> Gives EINVAL). When i digged the perf code a bit, i found :
> 
> if (evlist->cpus->map[0] < 0)
>                 no_inherit = true;
> 
> So, i thought may be it doesn't allow trace on all CPU's when i
> inherit. Does that make sense.?
