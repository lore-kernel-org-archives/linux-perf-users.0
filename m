From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Duplicate EXIT record for sudo process
Date: Tue, 14 Nov 2017 13:31:47 +0100
Message-ID: <1b7e21bb-e341-61db-728f-c52dfe0fbdd5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755048AbdKNMbx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 07:31:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAECUD7o073055
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 07:31:53 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e7ydybt1g-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 07:31:52 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 14 Nov 2017 12:31:50 -0000
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Stefan Liebler <stli@linux.vnet.ibm.com>

I have installed linux 4.14 and discovered a duplicate entry of type
PERF_RECORD_EXIT in the perf data file. A process has 1 FORK and 2 EXIT records.
It is simple to recreate.  You need two shells:

Run command as root in shell 1:
[root@s35lp76 perf]# ./perf record -a -n

Now open a new shell as non-root user and run command
shell 2:
[tmricht@s35lp76 ~]$ sudo ls -l /

As soon as the sudo command finishes, cntrl-C the perf record in
shell 1 and look at the perf.data file.

5 295009586070 0x23288 [0x38]: PERF_RECORD_FORK(22592:22592):(22562:22562)
5 295010239273 0x24b00 [0x30]: PERF_RECORD_COMM exec: sudo:22592/22592
5 295010243323 0x24b30 [0x38]: PERF_RECORD_EXIT(22592:22592):(22592:22592)
5 295010261805 0x24b68 [0x70]: PERF_RECORD_MMAP2 22592/22592:
        [0x118d00000(0x27000) @ 0 5e:01 268957 361132184]: r-xp /usr/bin/sudo
5 295010299013 0x24bd8 [0x78]: PERF_RECORD_MMAP2 22592/22592:
        [0x3ffbac00000(0x2b000) @ 0 5e:01 271462 361135670]:
        r-xp /usr/lib64/ld-2.26.so
...                               
0 295028626784 0x22118 [0x38]: PERF_RECORD_FORK(22596:22596):(22592:22592)
4 295029581934 0x24458 [0x30]: PERF_RECORD_COMM exec: ls:22596/22596
... 
4 295034690214 0x248d0 [0x38]: PERF_RECORD_EXIT(22596:22596):(22596:22596)
0 295040438756 0x22150 [0x38]: PERF_RECORD_EXIT(22592:22592):(22592:22592)
                                                              
The sudo command (pid 22592) is FORK'ed and EXEC'ed and
immediately follows an EXIT record, even before the MMAP2 records
show up. Later sudo forks command ls (pid 22596) and finally both processes
are terminated resulting in the second EXIT record for process sudo (22952).

Is this intended?

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
