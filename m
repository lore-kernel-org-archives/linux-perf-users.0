From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Mon, 15 Jan 2018 13:31:00 +0100
Message-ID: <8d20a732-25af-968c-f3a9-1a1336854851@linux.vnet.ibm.com>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org> <20180112150142.GC9655@kernel.org>
 <20180112164706.GE9655@kernel.org> <20180112200229.GI9655@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112200229.GI9655@kernel.org>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 01/12/2018 09:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 12, 2018 at 01:47:06PM -0300, Arnaldo Carvalho de Melo escreveu:
>> There is still room for improvement, I noticed overriding is not working
>> for the probe event, investigating it now.
> 
> So, I had to fix this another way to get the possibility of overwriting
> the global options (--max-stack, --call-graph) in an specific tracepoint
> event:
> 
> http://git.kernel.org/acme/c/08e26396c6f2
> 
> replaced that HEAD.
> 
> This cset may take some more minutes to show up, just pushed.
> 

I have installed your perf/core tree on my Fedora 27 Virtual Machine
running on my Intel notebook.

Here are some commands and the output on an Intel platform:

[root@f27 perf]# uname -a
Linux f27 4.15.0-rc6acme+ #1 SMP Mon Jan 15 12:35:23 CET 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@f27 perf]#

[root@f27 perf]# ./perf trace --no-syscalls --call-graph fp --max-stack 3
        -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.022 ms
     0.000 probe_libc:inet_pton:
 --- ::1 ping statistics ---
(7f8fc407d8a0))
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.022/0.022/0.022/0.000 ms
[root@f27 perf]#

--> No call graph at all, the kernel as been compiled with ORC unwinder.

[root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf --max-stack 3
        -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.024 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.024/0.024/0.024/0.000 ms
0.000 probe_libc:inet_pton:(7f7ff38488a0))
[root@f27 perf]#

--> No call graph at all, the kernel as been compiled with OCR unwinder.

[root@f27 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton/call-graph=dwarf,max-stack=4/
        ping -6 -c 1 ::1PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.019 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.019/0.019/0.019/0.000 ms
     0.000 probe_libc:inet_pton:(7fc985d658a0))
           __inet_pton (inlined)
           gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
           __GI_getaddrinfo (inlined)
           main (/usr/bin/ping)
           __libc_start_main (/usr/lib64/libc-2.26.so)
           _start (/usr/bin/ping)
[root@f27 perf]#

--> Dwarf call graph, but max-stack=4 not honoured when specified as
        event specific restriction.

[root@f27 perf]# ./perf trace --no-syscalls --max-stack 4
        -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.020 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.020/0.020/0.020/0.000 ms
     0.000 probe_libc:inet_pton:(7ffbc5f768a0))
            __inet_pton (inlined)
            gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
            __GI_getaddrinfo (inlined)
            main (/usr/bin/ping)
[root@f27 perf]#


--> Dwarf call graph and --max-stack 4 is also honoured.

I have the feeling that your fix does not work very well when
used with the --no-syscalls option.
Omitting --no-syscalls shows your explained behavior.

So there must be a difference between --no-syscalls and --syscalls
invocation.     

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
