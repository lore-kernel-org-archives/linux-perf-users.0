From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: perf test LLVM failure
Date: Tue, 13 Jun 2017 10:40:37 +0200
Message-ID: <95f0579d-ae99-1c6d-a19a-c79a77fea6e6@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752233AbdFMIks (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2017 04:40:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5D8dD21040336
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2017 04:40:42 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2b2c8kspt1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2017 04:40:41 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 13 Jun 2017 09:40:40 +0100
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org

I have Fedora 25 with an 4.11 kernel and get this error

[root@s8360047 perf]# ./perf test   LLVM
35: LLVM search and compile                    :
35.1: Basic BPF llvm compile                    : Ok
35.2: kbuild searching                          : Ok
35.3: Compile source for BPF prologue generation: FAILED!
35.4: Compile source for BPF relocation         : Skip
[root@s8360047 perf]#

The error message is
libbpf: Program 'func=null_lseek file->f_mode offset orig'
contains non-map related relo data pointing to section 5

I have installed
clang-3.8.1-1.fc25.s390x
clang-libs-3.8.1-1.fc25.s390x
libpfm-4.8.0-2.ibm.fc25.s390x
compiler-rt-3.9.1-1.fc25.s390x
llvm-libs-3.8.1-2.fc25.s390x

and when I compile the test/bpf-script-test-prologue.c manually
the compile does not show any error message.

The error comes from file ../lib/bpf/libbpf.c
function bpf_program__collect_reloc()

Any ideas what cauese this and how to fix it?

By the way Fedora 24 with the same kernel version as above runs fine.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
