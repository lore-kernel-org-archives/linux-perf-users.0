From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: Sampling on sched:sched_switch
Date: Tue, 14 Apr 2015 11:22:26 -0300
Message-ID: <20150414142226.GL16027@kernel.org>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
 <20150413151148.GI3200@kernel.org>
 <CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
 <20150414121559.GD16027@kernel.org>
 <CAGAANTUAJJmBBSRijursj2VxCg=1kbEP90BRMW2-J0S83tzRug@mail.gmail.com>
 <20150414125921.GJ16027@kernel.org>
 <CAGAANTV1gQFd0_WZbGTG_+ASZZdDmfAecr_ddchnWGB+dMyVDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59964 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbDNOWa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Apr 2015 10:22:30 -0400
Received: from [187.65.119.65] (helo=zoo.ghostprotocols.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1Yi1jR-0003xX-IB
	for linux-perf-users@vger.kernel.org; Tue, 14 Apr 2015 14:22:29 +0000
Content-Disposition: inline
In-Reply-To: <CAGAANTV1gQFd0_WZbGTG_+ASZZdDmfAecr_ddchnWGB+dMyVDA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Apr 14, 2015 at 07:00:43PM +0530, sahil aggarwal escreveu:
> > This is incomplete: "multiple events for all CPUS" ok, but for a specific
> > thread? Or for all of them?
 
> If i have 2 CPU's, i made it run 2 threads each per CPU. Both threads
> have different streams for same tracepoints polling on them. Well, had
> to go with this approach since enabling tracepoints on all CPU when
> inherit was not working for me :(

My question stands: "Are you monitoring a specific thread? Or all
threads in the system"?
 
> > See this, look for the inherit flag, then look for the CPU arg to
> > sys_perf_event_open, many tracepoints, a process that creates a process that
> > creates a process that makes a networking call that hits net:*skb* tracepoints,
> > is something like that that you want?
 
> This is exactly what i want. But things seem to be working in unexpected way.

Read below
 
> > [root@zoo ~]# perf stat -vv -e sched:* -e skb:* time time ping -c 1 127.0.0.1
> > <SNIP>
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             2
> >   size                             112
> >   config                           10b
> >   { sample_period, sample_freq }   1
> >   sample_type                      TIME|CPU|PERIOD|RAW
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 9944  cpu -1  group_fd -1  flags 0x8
> > ------------------------------------------------------------
> 
> I think i should figure out why mmap is failing when inherit=1, seeing
> this it doesn't make sense. Will get back to you if i find something.

'perf stat' doesn't use mmap, its just counting events, lemme try
mmaping that same workload:

[root@zoo ~]# trace -o /tmp/trace.output -vv --ev sched:* --ev skb:* time time ping -c 1 127.0.0.1
<SNIP>
------------------------------------------------------------
perf_event_attr:
  type                             2
  size                             112
  config                           10b
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
------------------------------------------------------------
sys_perf_event_open: pid 19784  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 1  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 2  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 3  group_fd -1  flags 0x8
------------------------------------------------------------
perf_event_attr:
  type                             2
  size                             112
  config                           10a
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|TIME|ID|CPU|PERIOD|RAW
  read_format                      ID
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid 19784  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 1  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 2  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 3  group_fd -1  flags 0x8
------------------------------------------------------------
perf_event_attr:
  type                             2
  size                             112
  config                           109
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|TIME|ID|CPU|PERIOD|RAW
  read_format                      ID
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  sample_id_all                    1
  exclude_guest                    1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid 19784  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 1  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 2  group_fd -1  flags 0x8
sys_perf_event_open: pid 19784  cpu 3  group_fd -1  flags 0x8
------------------------------------------------------------
<SNIP>
mmap size 528384B
perf event ring buffer mmapped per cpu
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.050 ms

--- 127.0.0.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.050/0.050/0.050/0.000 ms
0.00user 0.00system 0:00.00elapsed 50%CPU (0avgtext+0avgdata 2112maxresident)k
0inputs+0outputs (0major+100minor)pagefaults 0swaps
0.00user 0.00system 0:00.00elapsed 60%CPU (0avgtext+0avgdata 2112maxresident)k
0inputs+0outputs (0major+180minor)pagefaults 0swaps
[root@zoo ~]# 

Ok, it works, but notice that it will create one file descriptor per event per
CPU (this machine has 4 CPUs), and then it will use an ioctl to ask the kernel
to send all events for an event on a CPU to the same ring buffer, so we end up
with just 4 ring buffers (perf mmaps), one per CPU:

From tools/perf/util/evlist.c, function perf_evlist__mmap_per_evsel():

  if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)

That is why I asked you about what you are monitoring, that is not clear so
far, for me.

Above, we are not asking the kernel for cpu == -1 and thread == -1, that will
result in that -EINVAL, that is there for scalability reasons.

System wide is done by using CPU = N and thread = -1, with one mmap per CPU.

- Arnaldo
