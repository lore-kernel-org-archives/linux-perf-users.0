From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: perf test BPF subtest bpf-prologue test fails on s390x
Date: Wed,  9 Aug 2017 11:24:19 +0200
Message-ID: <20170809092419.68601-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752548AbdHIJYY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 05:24:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v799NqwZ057421
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 05:24:24 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c7vmq3yrt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 05:24:24 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 10:24:22 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v799OJal18284796
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 09:24:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 628FFAE045
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Aug 2017 10:20:20 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4494EAE04D
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Aug 2017 10:20:20 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Aug 2017 10:20:20 +0100 (BST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I investigate perf test BPF for s390x and have a question regarding
the 38.3 subtest (bpf-prologue test) which fails on s390x.

When I turn on trace_printk in tests/bpf-script-test-prologue.c
I see this output in /sys/kernel/debug/tracing/trace:

[root@s8360047 perf]# cat /sys/kernel/debug/tracing/trace
perf-30229 [000] d..2 170161.535791: : f_mode 2001d00000000 offset:0 orig:0
perf-30229 [000] d..2 170161.535809: : f_mode 6001f00000000 offset:0 orig:0
perf-30229 [000] d..2 170161.535815: : f_mode 6001f00000000 offset:1 orig:0
perf-30229 [000] d..2 170161.535819: : f_mode 2001d00000000 offset:1 orig:0
perf-30229 [000] d..2 170161.535822: : f_mode 2001d00000000 offset:2 orig:1
perf-30229 [000] d..2 170161.535825: : f_mode 6001f00000000 offset:2 orig:1
perf-30229 [000] d..2 170161.535828: : f_mode 6001f00000000 offset:3 orig:1
perf-30229 [000] d..2 170161.535832: : f_mode 2001d00000000 offset:3 orig:1
perf-30229 [000] d..2 170161.535835: : f_mode 2001d00000000 offset:4 orig:0
perf-30229 [000] d..2 170161.535841: : f_mode 6001f00000000 offset:4 orig:0

[...]

There are 3 parameters the eBPF program tests/bpf-script-test-prologue.c
accesses: f_mode (member of struct file at offset 140) offset and orig.
They are parameters of the lseek() system call triggered in this
test case in function llseek_loop().

What is really strange is the value of f_mode. It is an 8 byte
value, whereas in the probe event it is defined as a 4 byte value.
The lower 4 bytes are all zero and do not belong to member f_mode.
The correct value should be 2001d for read-only and 6001f for
read-write open mode.

Here is the output of the 'perf test -vv bpf' trace:
   Try to find probe point from debuginfo.
   Matched function: null_lseek [2d9310d]
   Probe point found: null_lseek+0
   Searching 'file' variable in context.
   Converting variable file into trace event.
   converting f_mode in file
   f_mode type is unsigned int.
   Opening /sys/kernel/debug/tracing//README write=0
   Searching 'offset' variable in context.
   Converting variable offset into trace event.
   offset type is long long int.
   Searching 'orig' variable in context.
   Converting variable orig into trace event.
   orig type is int.
   Found 1 probe_trace_events.
   Opening /sys/kernel/debug/tracing//kprobe_events write=1
   Writing event: p:perf_bpf_probe/func _text+8794224 f_mode=+140(%r2):x32
	offset=%r3:s64 orig=%r4:s32

I have the feeling that this is an endianness issue. In file
test/bpf-script-test-prologue.c there is this condition:

   if (f_mode & FMODE_WRITE)
	return 0;

On little endian platforms the value is swapped and becomes
0x2001d. When checking for bit 2 (FMODE_WRITE) the comparison
succeeds in half of the invocations and fails in the other half.

On big endian platforms the value is 0xxxxx00000000 and the
test for write-opened file always fails and all invocations
return zero.

I use Fedora 25 and 
[root@s8360047 ~]# rpm -qa | egrep 'clang|llvm'
llvm-3.8.1-2.fc25.s390x
clang-3.8.1-1.fc25.s390x
clang-libs-3.8.1-1.fc25.s390x
llvm-libs-3.8.1-2.fc25.s390x

Any ideas on how to debug this further.

Thanks Thomas
