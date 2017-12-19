From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Perf test case probe libc's inet_pton & backtrace
Date: Tue, 19 Dec 2017 13:57:23 +0100
Message-ID: <0bc902bb-6b94-1c95-d89f-743b5f5b369d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751863AbdLSM53 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Dec 2017 07:57:29 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBJCumim080225
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Dec 2017 07:57:29 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ey2asavf5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Dec 2017 07:57:28 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 19 Dec 2017 12:57:26 -0000
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

 I am debugging perf test case "probe libc's inet_pton & backtrace
 it with ping" on Linux 4.15.0rc4

This is the output on my Intel VM (where is test case succeeds):
[root@f27 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton/max-stack=3/ -- ping -c1 -6 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.023 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.023/0.023/0.023/0.000 ms
     0.000 probe_libc:inet_pton:(7fc7a82df8a0))
               __GI___inet_pton (/usr/lib64/libc-2.26.so)
               getaddrinfo (/usr/lib64/libc-2.26.so)
               main (/usr/bin/ping)
[root@f27 perf]#

On s390x this test case fails because the call stack can not be
unwinded:
[root@s35lp76 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton/max-stack=3/ -- ping -c1 -6 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.034 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.034/0.034/0.034/0.000 ms
     0.000 probe_libc:inet_pton:(3ff92042060))
[root@s35lp76 perf]#

Debugging shows the difference between both platforms.
On Intel function trace__handle_event() is called several times
and one invocation has the sample->callchain pointer set
(gdb) p *sample->callchain
$16 = {nr = 4, ips = 0x7ffff7f55628}
(gdb)

It looks like it has 4 entries, all referring to the addresses
of the probed function and its back trace.

On s390x there is also one event with sample->callchain pointer set
but it has only 1 entry, the probed function.

Now when I change the parameters for perf_event_attr in function
trace__run()
 - perf_evlist()
    - perf_evsel__open()
       - sys_perf_event_open()
to include:

  evsel->attr.sample_type |= PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER;
  evsel->attr.sample_stack_user = 8192;
  evsel->attr.sample_regs_user = 0x3FFFFFFFF;

to actually include user stack and register values in the probe,
the output of the perf trace command is:

[root@s35lp76 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton/max-stack=3/ -- ping -c1 -6 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.035 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.035/0.035/0.035/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb5442060))
               __GI___inet_pton (/usr/lib64/libc-2.26.so)
               gaih_inet (inlined)
               __GI_getaddrinfo (inlined)
               main (/usr/bin/ping)
               __libc_start_main (/usr/lib64/libc-2.26.so)
               _start (/usr/bin/ping)
[root@s35lp76 perf]#

This looks much better than before (however not identical to the
output of my Intel VM), but is is identical to the output
of command 'perf trace record ...'

 ./perf trace record -g -e probe_libc:inet_pton --call-graph=dwarf
        -- ping -c1 -6 ::1

which creates a perf.data file with this contents:

 ./perf report

Samples: 1  of event 'probe_libc:inet_pton', Event count (approx.): 1
Children      Self  Trace output
-  100.00%   100.00%  (3ffbb142060)
    _start
    __libc_start_main
    main
    __GI_getaddrinfo (inlined)
    gaih_inet (inlined)
    __GI___inet_pton

How to proceed?
Should I change the invocation of the sys_perf_open_event() function
to include the USER/STACK stuff, which makes that part of the code
platform dependent as well as the test case which parses this output.

Other Ideas?
I somehow lack the knowledge on how to handle this in a common way
for all platforms.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
