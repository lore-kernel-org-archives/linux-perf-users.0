From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [RFC 0/5] per-event settings fixes
Date: Tue, 16 Jan 2018 16:27:52 +0100
Message-ID: <5e418aa0-d966-59d4-f024-a5fc61500f8d@linux.vnet.ibm.com>
References: <20180116142438.19520-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116142438.19520-1-acme@kernel.org>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Noel Grandin <noelgrandin@gmail.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On 01/16/2018 03:24 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi guys,
> 
> 	Jiri asked me to post this series, so here it is, please take a
> look, I'd love to harvest your Reviewed-by/Tested-by/Acked-by,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (5):
>   perf callchain: Fix attr.sample_max_stack setting
>   perf unwind: Do not look at globals
>   perf trace: Setup DWARF callchains for non-syscall events when --max-stack is used
>   perf trace: Allow overriding global --max-stack per event
>   perf callchains: Ask for PERF_RECORD_MMAP for data mmaps for DWARF unwinding
> 
>  tools/perf/builtin-trace.c               | 19 ++++++++++++++++---
>  tools/perf/util/evsel.c                  | 24 +++++++++++++++++-------
>  tools/perf/util/unwind-libunwind-local.c |  9 ---------
>  3 files changed, 33 insertions(+), 19 deletions(-)
> 

I have tested your patches on my s390x. I applied
them on top of your perf/core branch.

Here is the output:
[root@s8360047 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.046 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.046/0.046/0.046/0.000 ms
     0.000 probe_libc:inet_pton:(3ffa4ec2060))
[root@s8360047 perf]#

Test ok !

[root@s8360047 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton/max-stack=5,call-graph=dwarf/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.054 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.054/0.054/0.054/0.000 ms
     0.000 probe_libc:inet_pton:(3ff7e742060))
           __GI___inet_pton (/usr/lib64/libc-2.26.so)
           gaih_inet (inlined)
           __GI_getaddrinfo (inlined)
           main (/usr/bin/ping)
           __libc_start_main (/usr/lib64/libc-2.26.so)
[root@s8360047 perf]#

Test ok!

[root@s8360047 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.062 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.062/0.062/0.062/0.000 ms
     0.000 probe_libc:inet_pton:(3ff86642060))
           __GI___inet_pton (/usr/lib64/libc-2.26.so)
           gaih_inet (inlined)
           __GI_getaddrinfo (inlined)
           main (/usr/bin/ping)
           __libc_start_main (/usr/lib64/libc-2.26.so)
           _start (/usr/bin/ping)
[root@s8360047 perf]#

Test ok:

[root@s8360047 perf]# ./perf trace --no-syscalls --call-graph dwarf
        --max-stack 4  -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.031 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.031/0.031/0.031/0.000 ms
     0.000 probe_libc:inet_pton:(3ffa1bc2060))
           __GI___inet_pton (/usr/lib64/libc-2.26.so)
           gaih_inet (inlined)
           __GI_getaddrinfo (inlined)
           main (/usr/bin/ping)
[root@s8360047 perf]#

Test ok, also when --max-stack 4 is omitted the complete
backchain is printed.

[root@s8360047 perf]# ./perf trace --no-syscalls --call-graph dwarf
        -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.047 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.047/0.047/0.047/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb4bc2060))
[root@s8360047 perf]#

Test fails, I would have expected some callchain output.

[root@s8360047 perf]# ./perf trace --no-syscalls --call-graph dwarf --max-stack 4
        -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.055 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.055/0.055/0.055/0.000 ms
     0.000 probe_libc:inet_pton:(3ff7e6c2060))
[root@s8360047 perf]#

Test fails, I would have expected some callchain output.

It looks like /max-stack=3/ without ,call-graph=dwarf
does not trigger the stack unwinding.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
