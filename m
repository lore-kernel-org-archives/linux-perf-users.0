From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf test LLVM failure
Date: Mon, 19 Jun 2017 13:59:50 +0200
Message-ID: <3ede448f-4af5-2a40-4f40-6d159fca6798@linux.vnet.ibm.com>
References: <95f0579d-ae99-1c6d-a19a-c79a77fea6e6@linux.vnet.ibm.com>
 <20170616160957.GE3645@kernel.org>
 <9df6cb52-345d-1e16-96af-fe7dd6bcbc2c@huawei.com>
 <3fddab50-c06d-452a-3447-970e3c368bcd@linux.vnet.ibm.com>
 <4dc06e88-f779-0549-85e7-95610ec4612b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753141AbdFSL75 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jun 2017 07:59:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5JBx0As088954
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jun 2017 07:59:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b6chcdg5a-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jun 2017 07:59:56 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 19 Jun 2017 12:59:54 +0100
In-Reply-To: <4dc06e88-f779-0549-85e7-95610ec4612b@huawei.com>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>

On 06/19/2017 12:29 PM, Wangnan (F) wrote:
> Hi,
> 
> Thank you for your quick reply.
> 
> The problem is caused by following relocation information:
> 
> $ readelf -a ./llvmsubtest3
> ...
>   [ 5] _ftrace_branch    PROGBITS         0000000000000000  00000260
>        00000000000000a0  0000000000000000  WA       0     0     4
> ...
> Relocation section '.relfunc=null_lseek file->f_mode offset orig' at offset 0x490 contains 4 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name
> 000000000038  000b00000001 unrecognized: 1       0000000000000000 _ftrace_branch
> 0000000000b0  000b00000001 unrecognized: 1       0000000000000000 _ftrace_branch
> 000000000128  000b00000001 unrecognized: 1       0000000000000000 _ftrace_branch
> 0000000001c0  000b00000001 unrecognized: 1       0000000000000000 _ftrace_branch
> 
> Relocation section '.rel_ftrace_branch' at offset 0x4d0 contains 8 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name
> 000000000000  000200000001 unrecognized: 1       0000000000000000 .L__func__.bpf_func__n
> 000000000008  000100000001 unrecognized: 1       0000000000000015 .L.str
> 000000000028  000200000001 unrecognized: 1       0000000000000000 .L__func__.bpf_func__n
> 000000000030  000100000001 unrecognized: 1       0000000000000015 .L.str
> 000000000050  000200000001 unrecognized: 1       0000000000000000 .L__func__.bpf_func__n
> 000000000058  000100000001 unrecognized: 1       0000000000000015 .L.str
> 000000000078  000200000001 unrecognized: 1       0000000000000000 .L__func__.bpf_func__n
> 000000000080  000100000001 unrecognized: 1       0000000000000015 .L.str
> ...
> 
> So I think the failure is because you enabled CONFIG_PROFILE_ALL_BRANCHES.
> 
> I can reproduce your buggy result by selecting CONFIG_PROFILE_ALL_BRANCHES in my
> kbuild:
> 
> $ ./perf test LLVM
> 35: LLVM search and compile                    :
> 35.1: Basic BPF llvm compile                    : Ok
> 35.2: kbuild searching                          : Ok
> 35.3: Compile source for BPF prologue generation: FAILED!
> 35.4: Compile source for BPF relocation         : Skip
> 
> Simply undef CONFIG_PROFILE_ALL_BRANCHES in clang opts not working because it is
> introduced by "#include <uapi/linux/fs.h>", which override cmdline options. So I
> think the best way is to undefine 'if' inside BPF script.
> 
> Please have a look on the patch I sent:
> 
> http://lkml.kernel.org/r/20170620183203.2517-1-wangnan0@huawei.com
> 
> Thank you.
> 
> 

Thank you very much for your quick fix. I can confirm that the patch
also fixes my issue on s390.


[root@s8360047 perf]# ./perf test LLVM
35: LLVM search and compile                    :
35.1: Basic BPF llvm compile                    : Ok
35.2: kbuild searching                          : Ok
35.3: Compile source for BPF prologue generation: Ok
35.4: Compile source for BPF relocation         : Ok
[root@s8360047 perf]#


You have my Tested-by/Acked-by.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
