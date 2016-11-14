From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Tracing sched_switch events for client application when process
 is switched back in
Date: Mon, 14 Nov 2016 12:36:11 -0300
Message-ID: <20161114153611.GA26543@kernel.org>
References: <10618911.8qrkJBTkNF@milian-kdab2>
 <4514930.f3mZKdtDhX@milian-kdab2>
 <20161011003655.GP4809@kernel.org>
 <9863268.pt3viFMpJL@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbcKNPgW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2016 10:36:22 -0500
Content-Disposition: inline
In-Reply-To: <9863268.pt3viFMpJL@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, Nov 14, 2016 at 03:10:26PM +0100, Milian Wolff escreveu:
> On Monday, October 10, 2016 9:36:55 PM CET Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 06, 2016 at 06:38:28PM +0200, Milian Wolff escreveu:
> > > only find 7, whereas tracing sched_switch finds all 100 that actually take
> > > place?
 
> Hey there,
 
> long delay but I looked at this again today.
 
> > This is looking only for the sched switches for the monitored workload,
> > which in this case is 'sleep 1', this wasn't a system wide session.

> > add -a and you'll get those other switches, if I got what you described.
 
> I've used the sources of the simple C application I showed in the first email 
> of this thread (still quoted above). Then I try:
 
> perf record --switch-events -a ./a.out
 
> And indeed, I get all switch events. But I now also profile all applications 
> on the machine, which is not what I want. I want to combine the following 

So you remove that '-a' from that command line and gets just the context
switches for that ./a.out app, no?

Lets see:

[root@jouet ~]# perf record --switch-events sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data (7 samples) ]
[root@jouet ~]#

[root@jouet ~]# perf script --show-switch-events
   perf 29395 176148.426824:          1 cycles:ppp:  ffffffffae1ad256 perf_event_exec+0x146 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux
   perf 29395 176148.426827:          1 cycles:ppp:  ffffffffae00ca1b intel_pmu_handle_irq+0x21b (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vm
   perf 29395 176148.426829:         10 cycles:ppp:  ffffffffae02fd93 native_sched_clock+0x33 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlin
   perf 29395 176148.426830:        221 cycles:ppp:  ffffffffae02fd93 native_sched_clock+0x33 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlin
   perf 29395 176148.426831:       5213 cycles:ppp:  ffffffffae02fe79 sched_clock+0x9 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
  sleep 29395 176148.426834:     120344 cycles:ppp:  ffffffffae36b0cf selinux_inode_permission+0x11f (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_6
  sleep 29395 176148.426873:    1717973 cycles:ppp:  ffffffffae259e3b free_pipe_info+0x4b (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
  sleep 29395 176148.427182: PERF_RECORD_SWITCH OUT
  sleep 29395 176149.427366: PERF_RECORD_SWITCH IN 

And if you use something that generates more switches, say:

[root@jouet ~]# perf record --switch-events ping -c 5 localhost
PING localhost.localdomain (127.0.0.1) 56(84) bytes of data.
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=1 ttl=64 time=0.043 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=2 ttl=64 time=0.040 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=3 ttl=64 time=0.038 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=4 ttl=64 time=0.038 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=5 ttl=64 time=0.036 ms

--- localhost.localdomain ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4077ms
rtt min/avg/max/mdev = 0.036/0.039/0.043/0.002 ms
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.021 MB perf.data (9 samples) ]
[root@jouet ~]# perf script --show-switch-events
   perf 29429 176239.731333:          1 cycles:ppp:  ffffffffae1ad250 perf_event_exec+0x140 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux
   perf 29429 176239.731336:          1 cycles:ppp:  ffffffffae00ca1b intel_pmu_handle_irq+0x21b (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vm
   perf 29429 176239.731338:          9 cycles:ppp:  ffffffffae02fd93 native_sched_clock+0x33 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlin
   perf 29429 176239.731339:        198 cycles:ppp:  ffffffffae02fd93 native_sched_clock+0x33 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlin
   perf 29429 176239.731340:       4667 cycles:ppp:  ffffffffae02fe7c sched_clock+0xc (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
   ping 29429 176239.731343:     108407 cycles:ppp:  ffffffffae258d09 setup_new_exec+0x109 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
   ping 29429 176239.731378:    1645300 cycles:ppp:  ffffffffae240c29 mem_cgroup_try_charge+0x19 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vm
   ping 29429 176239.731951:    2594316 cycles:ppp:  ffffffffae0e46fc __wake_up_bit+0x1c (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
   ping 29429 176239.732833:    2411373 cycles:ppp:  ffffffffae756ec0 icmpv4_xrlim_allow.isra.17+0x60 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_
   ping 29429 176239.732872: PERF_RECORD_SWITCH OUT
   ping 29429 176240.738063: PERF_RECORD_SWITCH IN 
   ping 29429 176240.738139: PERF_RECORD_SWITCH OUT
   ping 29429 176241.762048: PERF_RECORD_SWITCH IN 
   ping 29429 176241.762119: PERF_RECORD_SWITCH OUT
   ping 29429 176242.786143: PERF_RECORD_SWITCH IN 
   ping 29429 176242.786221: PERF_RECORD_SWITCH OUT
   ping 29429 176243.810099: PERF_RECORD_SWITCH IN 
   ping 29429 176243.810182: PERF_RECORD_SWITCH OUT
   ping 29429 176243.810190: PERF_RECORD_SWITCH IN

5 out, 5 in, in a lightly loaded machine, plenty of CPUs, looks about right, no?

But...

> features:
> 
> - sample CPU events for a given application with backtraces
> 	perf record --call-graph dwarf ./foo
> - record switch-out events with backtraces (`-e sched:sched_switch/fp=dwarf/`)
> - somehow record the switch-in events, which are associated with a different 
> process and thus currently discarded

You want the backtraces with that, and since this is a meta-event... Humm, for
the switch in would the above be sufficient? What value would be in knowing the
backtrace in that case?

So something like would do? Try not looking at the "PERF_RECORD_SWITCH OUT"
lines, they are generated by the kernel _after_ the corresponding
sched:sched_switch is registered:

[root@jouet ~]# perf record --call-graph=dwarf --switch-events -e sched:sched_switch ping -c 5 localhost
PING localhost.localdomain (127.0.0.1) 56(84) bytes of data.
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=1 ttl=64 time=0.043 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=2 ttl=64 time=0.039 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=3 ttl=64 time=0.043 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=4 ttl=64 time=0.041 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=5 ttl=64 time=0.039 ms

--- localhost.localdomain ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4074ms
rtt min/avg/max/mdev = 0.039/0.041/0.043/0.002 ms
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.069 MB perf.data (5 samples) ]
[root@jouet ~]# ^C
[root@jouet ~]# perf script --show-switch-events
ping 29565 [001] 176667.912276: sched:sched_switch: ping:29565 [120] S ==> swapper/1:0 [120]
                  9fd994 __schedule+0xa4200354 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  9fdde5 schedule+0xa4200035 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  a01259 schedule_timeout+0xa4200219 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  8cb431 __skb_wait_for_more_packets+0xa4200111 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  8cb796 __skb_recv_datagram+0xa4200066 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  8cb82f skb_recv_datagram+0xa420003f (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  94d197 raw_recvmsg+0xa4200097 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  95daee inet_recvmsg+0xa420007e (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  8bb61d sock_recvmsg+0xa420003d (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  8bc667 ___sys_recvmsg+0xa42000d7 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  8bd191 __sys_recvmsg+0xa4200051 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  8bd1e2 sys_recvmsg+0xa4200012 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  a02572 entry_SYSCALL_64_fastpath+0xa420001a (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  104050 __GI___libc_recvmsg+0xffff0206e8e70010 (/usr/lib64/libc-2.23.so)
                    7b5a _init+0xffff5455e66f3ab2 (/usr/bin/ping)
                    3b34 _init+0xffff5455e66efa8c (/usr/bin/ping)
                    2d9f _init+0xffff5455e66eecf7 (/usr/bin/ping)
                   20731 __libc_start_main+0xffff0206e8e700f1 (/usr/lib64/libc-2.23.so)
                    30a9 _init+0xffff5455e66ef001 (/usr/bin/ping)

ping 29565 [001] 176667.912281: PERF_RECORD_SWITCH OUT
ping 29565 [001] 176668.915107: PERF_RECORD_SWITCH IN 
ping 29565 [001] 176668.915114: sched:sched_switch: ping:29565 [120] R ==> kworker/1:179:28142 [120]
                  9fd994 __schedule+0xa4200354 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  9fdde5 schedule+0xa4200035 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  203282 exit_to_usermode_loop+0xa4200072 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  203be1 syscall_return_slowpath+0xa42000a1 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  a025fa entry_SYSCALL_64_fastpath+0xa42000a2 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  104050 __GI___libc_recvmsg+0xffff0206e8e70010 (/usr/lib64/libc-2.23.so)
                    7b5a _init+0xffff5455e66f3ab2 (/usr/bin/ping)
                    3b34 _init+0xffff5455e66efa8c (/usr/bin/ping)
                    2d9f _init+0xffff5455e66eecf7 (/usr/bin/ping)
                   20731 __libc_start_main+0xffff0206e8e700f1 (/usr/lib64/libc-2.23.so)
                    30a9 _init+0xffff5455e66ef001 (/usr/bin/ping)

ping 29565 [001] 176668.915121: PERF_RECORD_SWITCH OUT
ping 29565 [001] 176668.915126: PERF_RECORD_SWITCH IN 
ping 29565 [001] 176668.915197: sched:sched_switch: ping:29565 [120] S ==> swapper/1:0 [120]
                  9fd994 __schedule+0xa4200354 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
                  9fdde5 schedule+0xa4200035 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
[root@jouet ~]# 

Just to check that the backtrace for ping is ok, I did a 'dnf debuginfo-install
iputils', looks sensible:
 
ping 29619 [001] 176793.486584: sched:sched_switch: ping:29619 [120] S ==> swapper/1:0 [120]
        9fd994 __schedule+0xa4200354 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        9fdde5 schedule+0xa4200035 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        a01259 schedule_timeout+0xa4200219 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        8cb431 __skb_wait_for_more_packets+0xa4200111 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        8cb796 __skb_recv_datagram+0xa4200066 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        8cb82f skb_recv_datagram+0xa420003f (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        94d197 raw_recvmsg+0xa4200097 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        95daee inet_recvmsg+0xa420007e (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        8bb61d sock_recvmsg+0xa420003d (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        8bc667 ___sys_recvmsg+0xa42000d7 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        8bd191 __sys_recvmsg+0xa4200051 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        8bd1e2 sys_recvmsg+0xa4200012 (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        a02572 entry_SYSCALL_64_fastpath+0xa420001a (/usr/lib/debug/lib/modules/4.8.6-201.fc24.x86_64/vmlinux)
        104050 __GI___libc_recvmsg+0xffff020805e62010 (/usr/lib64/libc-2.23.so)
          7b5a main_loop+0xffff550a5a4dc1fa (/usr/bin/ping)
          3b34 ping4_run+0xffff550a5a4dc534 (/usr/bin/ping)
          2d9f main+0xffff550a5a4dc98f (/usr/bin/ping)
         20731 __libc_start_main+0xffff020805e620f1 (/usr/lib64/libc-2.23.so)
          30a9 _start+0xffff550a5a4dc029 (/usr/bin/ping)

> Any advise on where to look for the filtering? Not discarding the sched_switch 
> of a different process based on matching next_tid can't be that hard, or is 
> it?
> 
> Cheers
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
