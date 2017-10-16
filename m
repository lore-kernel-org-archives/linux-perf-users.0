From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf buildild-list -H dumps core
Date: Mon, 16 Oct 2017 08:52:27 +0200
Message-ID: <0dbfaac2-46dc-8c63-05b7-004f3604b8c3@linux.vnet.ibm.com>
References: <6ec683e8-f23e-0595-5674-d5ef20ae03f5@linux.vnet.ibm.com>
 <20171013144805.GQ3503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750794AbdJPGwd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Oct 2017 02:52:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9G6nHRn001682
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 02:52:32 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dmq089w76-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 02:52:32 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 16 Oct 2017 07:52:30 +0100
In-Reply-To: <20171013144805.GQ3503@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 10/13/2017 04:48 PM, Arnaldo Carvalho de Melo wrote:

Here is the load of perf using gdb:

 

[root@s35lp76 core-dump-buildid]# gdb ~/linux/tools/perf/perf
GNU gdb (GDB) Fedora 7.12.1-48.fc25
Copyright (C) 2017 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "s390x-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /root/linux/tools/perf/perf...done.



This is the command:
(gdb) r buildid-list -H 
Starting program: /root/linux/tools/perf/perf buildid-list -H
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
Detaching after fork from child process 249033.

Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
Missing separate debuginfos, use: dnf debuginfo-install audit-libs-2.7.7-1.fc25.s390x bzip2-libs-1.0.6-21.fc25.s390x elfutils-libelf-0.169-1.fc25.s390x elfutils-libs-0.169-1.fc25.s390x libcap-ng-0.7.8-1.fc25.s390x numactl-libs-2.0.11-2.ibm.fc25.s390x openssl-libs-1.1.0e-1.1.ibm.fc25.s390x perl-libs-5.24.1-386.fc25.s390x python-libs-2.7.13-2.fc25.s390x slang-2.3.0-7.fc25.s390x xz-libs-5.2.3-2.fc25.s390x zlib-1.2.8-10.fc25.s390x
(gdb) where
#0  0x0000000000000000 in ?? ()
#1  0x00000000010fad6a in machines__deliver_event (machines=<optimized out>, machines@entry=0x2c6fd18, 
    evlist=<optimized out>, event=event@entry=0x3fffdf00470, sample=0x3ffffffe880, sample@entry=0x3ffffffe888, 
    tool=tool@entry=0x1312968 <build_id.mark_dso_hit_ops>, file_offset=1136) at util/session.c:1287
#2  0x00000000010fbf4e in perf_session__deliver_event (file_offset=1136, tool=0x1312968 <build_id.mark_dso_hit_ops>, 
    sample=0x3ffffffe888, event=0x3fffdf00470, session=0x2c6fc30) at util/session.c:1340
#3  perf_session__process_event (session=0x2c6fc30, session@entry=0x0, event=event@entry=0x3fffdf00470, 
    file_offset=file_offset@entry=1136) at util/session.c:1522
#4  0x00000000010fddde in __perf_session__process_events (file_size=11880, data_size=<optimized out>, 
    data_offset=<optimized out>, session=0x0) at util/session.c:1899
#5  perf_session__process_events (session=0x0, session@entry=0x2c6fc30) at util/session.c:1953
#6  0x000000000103b2ac in perf_session__list_build_ids (with_hits=<optimized out>, force=<optimized out>)
    at builtin-buildid-list.c:83
#7  cmd_buildid_list (argc=<optimized out>, argv=<optimized out>) at builtin-buildid-list.c:115
#8  0x00000000010a026c in run_builtin (p=0x1311f78 <commands+24>, argc=argc@entry=2, argv=argv@entry=0x3fffffff3c0)
    at perf.c:296
#9  0x000000000102bc00 in handle_internal_command (argv=<optimized out>, argc=2) at perf.c:348
#10 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:392
#11 main (argc=<optimized out>, argv=0x3fffffff3c0) at perf.c:536
(gdb) 


Hope this helps.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
