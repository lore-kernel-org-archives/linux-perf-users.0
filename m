From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Fri, 12 Jan 2018 12:01:42 -0300
Message-ID: <20180112150142.GC9655@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933984AbeALPBs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Jan 2018 10:01:48 -0500
Content-Disposition: inline
In-Reply-To: <20180112142032.GB9655@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Em Fri, Jan 12, 2018 at 11:20:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 12, 2018 at 11:03:55AM +0100, Thomas Richter escreveu:
> > On Intel platform when I execute test case
> >    probe libc's inet_pton & backtrace it with ping
> > I get this output which is correct:

> > [root@f27 perf]# ./perf trace --no-syscalls
> > 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> > PING ::1(::1) 56 data bytes
> > 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.064 ms

> >  --- ::1 ping statistics ---
> > 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> > rtt min/avg/max/mdev = 0.064/0.064/0.064/0.000 ms
> >      0.000 probe_libc:inet_pton:(7f26a88498a0))
> > 	   __GI___inet_pton (/usr/lib64/libc-2.26.so)
> > 	   getaddrinfo (/usr/lib64/libc-2.26.so)
> > 	   main (/usr/bin/ping)
> > [root@f27 perf]#
> > 
> > However when I add the global --call-graph dwarf to the command
> > line I get the exactly same result which is wrong:
> > 
> > [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> > 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> > 
> > My understanding is that the '--call-graph dwarf' option should be global
> > and applies to all events. However it is ignored.
> 
> It is global, but then, per-event settings can override it.
> 
> So if you say that the following call (without that /max-stack=3/, which
> implies DWARF, which is the safest bet for userspace callchains):
> [root@jouet ~]# perf trace --no-syscalls --call-graph dwarf -e probe_libc:inet_pton ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.086 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.086/0.086/0.086/0.000 ms
>      0.000 probe_libc:inet_pton:(7fafee7ce350))
> [root@jouet ~]#
> 
> And it doesn't work, right, that is a bug. I'll check if your patch
> fixes that and then will correct the cset log, i.e. this part:
> 
> [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> 
> Should read:
> 
> [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> 		-e probe_libc:inet_pton ping -6 -c 1 ::1
> 
> And _should_ produce a call-graph, without a stack limit, ok?
> 
> I'll reply to this message after testing your patch.

You patch works as advertised, but we only get the callgraph if we
specify max-stack in the event definition, which is odd, i.e. it serves
to ask for callgraphs, but then its value is ignored, to make it clear,
with your patch applied I get:

[root@jouet ~]# perf trace --no-syscalls --call-graph dwarf -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.079 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.079/0.079/0.079/0.000 ms
     0.000 probe_libc:inet_pton:(7f4585f7d350))
[root@jouet ~]# 

Which is a bug, the global setting should have been applied to the only
event set.

Also:

[root@jouet ~]# perf trace --no-syscalls --call-graph dwarf --max-stack=3 -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.065 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.065/0.065/0.065/0.000 ms
     0.000 probe_libc:inet_pton:(7ffac40fa350))
[root@jouet ~]# 

Also doesn't work, which also is a bug, DWARF callgraphs should have
been set _and_ limited to 3 levels.

[root@jouet ~]# perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.063 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.063/0.063/0.063/0.000 ms
     0.000 probe_libc:inet_pton:(7f79a0312350))
                                       __GI___inet_pton (/usr/lib64/libc-2.26.so)
                                       getaddrinfo (/usr/lib64/libc-2.26.so)
                                       [0xffffa9fef2875f40] (/usr/bin/ping)
[root@jouet ~]#

Works as advertised, i.e. it sets DWARF callgraphs for that event only
and limits it to 3.

Then if we try with your patch:

[root@jouet ~]# perf trace --no-syscalls --call-graph dwarf -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.082 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.082/0.082/0.082/0.000 ms
     0.000 probe_libc:inet_pton:(7f4c3d953350))
                                       __inet_pton (inlined)
                                       gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                       __GI_getaddrinfo (inlined)
                                       [0xffffaa1b49e1ef3f] (/usr/bin/ping)
                                       __libc_start_main (/usr/lib64/libc-2.26.so)
                                       [0xffffaa1b49e1f379] (/usr/bin/ping)
[root@jouet ~]#

It works but ignores the max-stack setting, which is wrong, as per-event
setting should override global ones.

So what I think is happening is that --call-graph is only affecting
syscall events, i.e.:

[root@jouet ~]# perf trace -e nanosleep sleep 1
     1.047 (1000.182 ms): sleep/11767 nanosleep(rqtp: 0x7ffc7fbdf060) = 0
[root@jouet ~]# perf trace --call-graph dwarf -e nanosleep sleep 1
no symbols found in /usr/bin/sleep, maybe install a debug package?
     0.380 (1000.161 ms): sleep/11772 nanosleep(rqtp: 0x7ffffe08a460) = 0
                                       __GI___nanosleep (inlined)
                                       [0xffffa9e3d99a0856] (/usr/bin/sleep)
                                       [0xffffa9e3d99a062f] (/usr/bin/sleep)
                                       [0xffffa9e3d999d903] (/usr/bin/sleep)
                                       __libc_start_main (/usr/lib64/libc-2.26.so)
                                       [0xffffa9e3d999d9f9] (/usr/bin/sleep)
[root@jouet ~]# perf trace --call-graph dwarf --max-stack 3 -e nanosleep sleep 1
no symbols found in /usr/bin/sleep, maybe install a debug package?
     0.954 (1000.160 ms): sleep/11786 nanosleep(rqtp: 0x7ffdd19d42c0) = 0
                                       __GI___nanosleep (inlined)
                                       [0xffffa9ed007bd856] (/usr/bin/sleep)
                                       [0xffffa9ed007bd62f] (/usr/bin/sleep)
[root@jouet ~]# perf trace --max-stack 3 -e nanosleep sleep 1
no symbols found in /usr/bin/sleep, maybe install a debug package?
     0.745 (1000.170 ms): sleep/11791 nanosleep(rqtp: 0x7ffd0f665590) = 0
                                       __GI___nanosleep (inlined)
                                       [0xffffaa6de4631856] (/usr/bin/sleep)
                                       [0xffffaa6de463162f] (/usr/bin/sleep)
[root@jouet ~]#

So what we should fix is the setting of --call-graph and --max-stack in
the non syscall events, that became supported by 'perf trace' later, so
I'm not applying your patch and will try later to fix this, unless you
beat me to it.

Thanks!

- Arnaldo
