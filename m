From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Fri, 12 Jan 2018 13:47:06 -0300
Message-ID: <20180112164706.GE9655@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
 <20180112150142.GC9655@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934027AbeALQrJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Jan 2018 11:47:09 -0500
Content-Disposition: inline
In-Reply-To: <20180112150142.GC9655@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Em Fri, Jan 12, 2018 at 12:01:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 12, 2018 at 11:20:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jan 12, 2018 at 11:03:55AM +0100, Thomas Richter escreveu:
> > > On Intel platform when I execute test case
> > >    probe libc's inet_pton & backtrace it with ping
> > > I get this output which is correct:
> 
> > > [root@f27 perf]# ./perf trace --no-syscalls
> > > 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> > > PING ::1(::1) 56 data bytes
> > > 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.064 ms
> 
> > >  --- ::1 ping statistics ---
> > > 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> > > rtt min/avg/max/mdev = 0.064/0.064/0.064/0.000 ms
> > >      0.000 probe_libc:inet_pton:(7f26a88498a0))
> > > 	   __GI___inet_pton (/usr/lib64/libc-2.26.so)
> > > 	   getaddrinfo (/usr/lib64/libc-2.26.so)
> > > 	   main (/usr/bin/ping)
> > > [root@f27 perf]#
> > > 
> > > However when I add the global --call-graph dwarf to the command
> > > line I get the exactly same result which is wrong:
> > > 
> > > [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> > > 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> > > 
> > > My understanding is that the '--call-graph dwarf' option should be global
> > > and applies to all events. However it is ignored.
> > 
> > It is global, but then, per-event settings can override it.
> > 
> > So if you say that the following call (without that /max-stack=3/, which
> > implies DWARF, which is the safest bet for userspace callchains):
> > [root@jouet ~]# perf trace --no-syscalls --call-graph dwarf -e probe_libc:inet_pton ping -6 -c 1 ::1
> > PING ::1(::1) 56 data bytes
> > 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.086 ms
> > 
> > --- ::1 ping statistics ---
> > 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> > rtt min/avg/max/mdev = 0.086/0.086/0.086/0.000 ms
> >      0.000 probe_libc:inet_pton:(7fafee7ce350))
> > [root@jouet ~]#
> > 
> > And it doesn't work, right, that is a bug. I'll check if your patch
> > fixes that and then will correct the cset log, i.e. this part:
> > 
> > [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> > 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> > 
> > Should read:
> > 
> > [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> > 		-e probe_libc:inet_pton ping -6 -c 1 ::1
> > 
> > And _should_ produce a call-graph, without a stack limit, ok?
> > 
> > I'll reply to this message after testing your patch.
> 
> You patch works as advertised, but we only get the callgraph if we
> specify max-stack in the event definition, which is odd, i.e. it serves
> to ask for callgraphs, but then its value is ignored, to make it clear,
> with your patch applied I get:
> 
> [root@jouet ~]# perf trace --no-syscalls --call-graph dwarf -e probe_libc:inet_pton ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.079 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.079/0.079/0.079/0.000 ms
>      0.000 probe_libc:inet_pton:(7f4585f7d350))
> [root@jouet ~]# 
> 
> Which is a bug, the global setting should have been applied to the only
> event set.

Please pull my perf/core branch, there are two csets there that should
fix this:

[acme@jouet perf]$ git log --oneline -2
cc28fec89f2a (HEAD -> perf/core, acme.korg/perf/core) perf trace: Fix setting of --call-graph/--max-stack for non-syscall events
236d812c55c2 perf trace: No need to set PERF_SAMPLE_IDENTIFIER explicitely
[acme@jouet perf]$

https://git.kernel.org/acme/c/cc28fec89f2a
https://git.kernel.org/acme/c/236d812c55c2

236d812c55c2 is just a simplification to make cc28fec89f2a smaller and
with just one purpose.

There is still room for improvement, I noticed overriding is not working
for the probe event, investigating it now.

- Arnaldo
