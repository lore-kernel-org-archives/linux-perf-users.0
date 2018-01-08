From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Question regarding perf test case trace+probe_libc_inet_pton.sh
Date: Mon, 8 Jan 2018 16:21:31 +0100
Message-ID: <ec0fd488-1ba1-6981-ef23-f27973f707bf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933081AbeAHPVg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Jan 2018 10:21:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id w08FJkRt045819
        for <linux-perf-users@vger.kernel.org>; Mon, 8 Jan 2018 10:21:35 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fcat9hg42-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jan 2018 10:21:35 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 8 Jan 2018 15:21:33 -0000
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>


On my VM on Intel I have installed Fedora 27 and the latest linux kernel.
On Intel I get this output below and the test case succeeds:

[root@f27 perf]# ./perf probe -q /usr/lib64/libc-2.26.so inet_pton
[root@f27 perf]# ./perf probe -l
Failed to find debug information for address dbfd60f1
  probe_libc:inet_pton (on 0xdbfd60f1 in /usr/lib64/libc-2.26.so)
[root@f27 perf]# ./perf trace --no-syscalls
        -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.038 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.038/0.038/0.038/0.000 ms
     0.000 probe_libc:inet_pton:(7ff80e9368a0))
                          __GI___inet_pton (/usr/lib64/libc-2.26.so)
                          getaddrinfo (/usr/lib64/libc-2.26.so)
                          main (/usr/bin/ping)
[root@f27 perf]#

The tests/shell/trace+probe_libc_inet_pton.sh test case succeeds
because the test checks for each line of output
against a predefined list of patterns.

However on my s390x plattform using the same kernel version I
get this output:

root@s35lp76 perf]# ./perf trace --no-syscalls
                -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.015 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.015/0.015/0.015/0.000 ms
     0.000 probe_libc:inet_pton:(3ff828c2060))
                      __GI___inet_pton (/usr/lib64/libc-2.26.so)
                      gaih_inet (inlined)            <----- New
                      __GI_getaddrinfo (inlined)     <----- Different
                      main (/usr/bin/ping)
                     __libc_start_main (/usr/lib64/libc-2.26.so)
                      _start (/usr/bin/ping)

In both cases I use the libdw library for unwinding the stacks and
identical perf tool configuration settings.
(Ok I understand there is another bug on s390x because the
stack call back chain does not stop after displaying 3 entries.
More to look at, but does not matter for this discussion).

The difference is the output of the stack unwinding using libdw.
On s390x there is one additional line:
        gaih_inet (inlined)
and the following line has a different function name and
inlined instead of the library name:
        __GI_getaddrinfo (inlined)

How to solve this difference?
Hendrik Brueckner and I discussed this and would like to suggest the
following:
Instead of checking the complete stack trace just test for the
first function named
                      __GI___inet_pton (/usr/lib64/libc-2.26.so)
and for the
                      main (/usr/bin/ping)
function and ignore any call chain in between. Since the test
invokes the ping command and ends up calling correct function
__GI___inet_pton(), it does not matter what intermediate
functions are being called and if they are inlined or not.

Suggestions and comments are welcome.

Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
