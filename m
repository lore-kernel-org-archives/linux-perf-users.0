From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Mon, 15 Jan 2018 10:20:53 -0300
Message-ID: <20180115132053.GB3542@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
 <20180112150142.GC9655@kernel.org>
 <20180112164706.GE9655@kernel.org>
 <20180112200229.GI9655@kernel.org>
 <866e5b29-9d48-b946-c705-fc7c790e4fb5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966995AbeAONU4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Jan 2018 08:20:56 -0500
Content-Disposition: inline
In-Reply-To: <866e5b29-9d48-b946-c705-fc7c790e4fb5@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Em Mon, Jan 15, 2018 at 10:11:02AM +0100, Thomas-Mich Richter escreveu:
> On 01/12/2018 09:02 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jan 12, 2018 at 01:47:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> There is still room for improvement, I noticed overriding is not working
> >> for the probe event, investigating it now.
> > 
> > So, I had to fix this another way to get the possibility of overwriting
> > the global options (--max-stack, --call-graph) in an specific tracepoint
> > event:
> > 
> > http://git.kernel.org/acme/c/08e26396c6f2
> > 
> > replaced that HEAD.
> > 
> > This cset may take some more minutes to show up, just pushed.
> > 
> 
> Sorry this does *not* work on my s390x.
 
> I have cloned your perf/core tree and above commit is included.
> Here is the command I tried:
> 
> [root@s8360047 perf]# ./perf trace -vv --no-syscalls  --max-stack 4 --call-graph dwarf 
>            -e probe_libc:inet_pton -- ping -6 -c 1 ::1

yeah, I'm looking at this now, reproduced here on x86_64 :-\

- Arnaldo

> callchain: type DWARF
> callchain: stack dump size 8192
> ------------------------------------------------------------
> perf_event_attr:
>   type                             2
>   size                             112
>   config                           0x45f
>   { sample_period, sample_freq }   1
>   sample_type                      IP|TID|TIME|ADDR|CPU|PERIOD|RAW|DATA_SRC
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   enable_on_exec                   1
>   task                             1
>   mmap_data                        1
>   sample_id_all                    1
>   exclude_guest                    1
>   mmap2                            1
>   comm_exec                        1
>   { wakeup_events, wakeup_watermark } 1
> ------------------------------------------------------------
> sys_perf_event_open: pid 6735  cpu 0  group_fd -1  flags 0x8 = 3
> sys_perf_event_open: pid 6735  cpu 1  group_fd -1  flags 0x8 = 4
> mmap size 2101248B
> perf event ring buffer mmapped per cpu
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.070 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.070/0.070/0.070/0.000 ms
>      0.000 probe_libc:inet_pton:(3ffada42060))
> [root@s8360047 perf]# 
> 
> I do miss in sample_type bits for CALLCHAIN, STACK_USER and REG_USER
> in the debug output of the perf_event_open() attribute printout.

 
> When I invoke the command with
> [root@s8360047 perf]# ./perf trace -vv --no-syscalls 
> 	-e probe_libc:inet_pton/call-graph=dwarf,max-stack=3/ -- ping -6 -c 1 ::1
> callchain: type DWARF
> callchain: stack dump size 8192
> ------------------------------------------------------------
> perf_event_attr:
>   type                             2
>   size                             112
>   config                           0x45f
>   { sample_period, sample_freq }   1
>   sample_type                      IP|TID|TIME|CALLCHAIN|CPU|PERIOD|RAW|REGS_USER|STACK_USER
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   enable_on_exec                   1
>   task                             1
>   sample_id_all                    1
>   exclude_guest                    1
>   exclude_callchain_user           1
>   mmap2                            1
>   comm_exec                        1
>   { wakeup_events, wakeup_watermark } 1
>   sample_regs_user                 0x3ffffffff
>   sample_stack_user                8192
>   sample_max_stack                 3
> ------------------------------------------------------------
> sys_perf_event_open: pid 6768  cpu 0  group_fd -1  flags 0x8 = 3
> sys_perf_event_open: pid 6768  cpu 1  group_fd -1  flags 0x8 = 4
> mmap size 528384B
> perf event ring buffer mmapped per cpu
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.074 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.074/0.074/0.074/0.000 ms
> [... snip ....]
> 
> unwind: _start:ip = 0x2aa1e38457b (0x457b)
>      0.000 probe_libc:inet_pton:(3ff9b142060))
>                                        __GI___inet_pton (/usr/lib64/libc-2.26.so)
>                                        gaih_inet (inlined)
>                                        __GI_getaddrinfo (inlined)
>                                        main (/usr/bin/ping)
>                                        __libc_start_main (/usr/lib64/libc-2.26.so)
>                                        _start (/usr/bin/ping)
> [root@s8360047 perf]# 
> 
> I see the proper result as expected.
> 
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
