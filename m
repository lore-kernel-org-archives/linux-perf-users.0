From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf test LLVM failure
Date: Mon, 19 Jun 2017 09:45:47 +0200
Message-ID: <3fddab50-c06d-452a-3447-970e3c368bcd@linux.vnet.ibm.com>
References: <95f0579d-ae99-1c6d-a19a-c79a77fea6e6@linux.vnet.ibm.com>
 <20170616160957.GE3645@kernel.org>
 <9df6cb52-345d-1e16-96af-fe7dd6bcbc2c@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A3F8A45CF3911E3FAF30A8D3"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41381 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753591AbdFSHpz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jun 2017 03:45:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5J7i62Z107075
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jun 2017 03:45:54 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b68h5vksd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jun 2017 03:45:54 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 19 Jun 2017 08:45:52 +0100
In-Reply-To: <9df6cb52-345d-1e16-96af-fe7dd6bcbc2c@huawei.com>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>

This is a multi-part message in MIME format.
--------------A3F8A45CF3911E3FAF30A8D3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 06/19/2017 02:34 AM, Wangnan (F) wrote:
> Hi,
> 
> I made a quick test on my ubuntu system, unable to reproduce.
> 
> My clang environment:
> 
> $ clang --version
> clang version 3.8.1-12ubuntu1 (tags/RELEASE_381/final)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> 
> My source code:
> $ git show
> commit a351e9b9fc24e982ec2f0e76379a49826036da12
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Apr 30 19:47:48 2017 -0700
> 
>     Linux 4.11
> 
> 
> Test result:
> 
> $ ./perf test LLVM
> 35: LLVM search and compile                    :
> 35.1: Basic BPF llvm compile                    : Ok
> 35.2: kbuild searching                          : Ok
> 35.3: Compile source for BPF prologue generation: Ok
> 35.4: Compile source for BPF relocation         : Ok
> 
> 
> 
> In your environment, clang produces a buggy BPF object file during
> 'perf test LLVM', but produces a correct BPF object when you compile
> it manually. I think the cmdline you provided to clang is different
> from the cmdline 'perf test' generated.
> 
> Could you please provide the result of 'perf test -vv LLVM'
> and the cmdline you use for manual testing?
> 
> Also, it would be thankful if you provide the '.o' file produced
> by perf test and by your manually testing. Following are steps
> to get it.
> 
> If you build perf from source, please apply the following patch:
> 
> ################### BEGIN ###################
> 
> diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
> index 482b536..e0694e0 100644
> --- a/tools/perf/tests/llvm.c
> +++ b/tools/perf/tests/llvm.c
> @@ -138,6 +138,8 @@ int test__llvm(int subtest)
>      void *obj_buf = NULL;
>      size_t obj_buf_sz = 0;
>      bool should_load_fail = false;
> +    FILE *fp;
> +    char fn[64];
> 
>      if ((subtest < 0) || (subtest >= __LLVM_TESTCASE_MAX))
>          return TEST_FAIL;
> @@ -152,6 +154,14 @@ int test__llvm(int subtest)
>                   bpf_source_table[subtest].desc);
>          }
>      }
> +
> +    snprintf(fn, sizeof(fn), "/tmp/perf-test-llvm-%d.o", subtest);
> +    fp = fopen(fn, "wb");
> +    if (fp) {
> +        fwrite(obj_buf, obj_buf_sz, 1, fp);
> +        fclose(fp);
> +    }
> +
>      free(obj_buf);
> 
>      return ret;
> ################### END ###################
> 
> then do 'perf test LLVM', and give me /tmp/perf-test-llvm-2.o
> 
> If you can't change perf's source code, you can use strace to capture
> the content of it:
> $ strace -f -o /tmp/out  -s 8192 ./perf test -vv LLVM
> 
> In resulting /tmp/out, search 'write.*ELF.*null_lseek', you will find
> a line looks like:
> 
> 12101 write(3, "\177ELF\2\1\1\0\0\0 ... ", 928) = 928
> 
> Send that line to me.
> 
> Thank you.
> 

Thank you very much for your help. I attach a tgz file which contains:
llvm/
llvm/llvmsubtest3.c   <-- Source code of failing subtest 35.3
llvm/llvmsubtest3     <-- Object code
llvm/bpftest1.c       <-- Souce code of BPF test (unneeded)
llvm/Makefile         <-- Makefile to build llvmsubtest2 and 3
llvm/llvmsubtest2.c   <-- Souce code of succeeding subtest 35.2
llvm/llvmsubtest2     <-- Object code
llvm/output/          <-- Output directory for command ./perf test -vv LLVM
llvm/output/llvm.out  <-- Verbose output of ./perf test -vv LLVM
llvm/output/perf-test-llvm-1.o <-- Object code for subtest 2
llvm/output/perf-test-llvm-2.o <-- Object code for subtest 3
llvm/output/perf-test-llvm-0.o <-- Object code for subtest 0

This provides all the information you requested.
The object files perf-test-llvm-[012].o have been captured with the
patch you provided.
The object code for llvmsubtest3.c compiled using my makefile
and the perf test LLVM code is identifcal:

[root@s8360047 llvm]# cmp llvmsubtest3 /tmp/perf-test-llvm-2.o
[root@s8360047 llvm]#

Thanks
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

--------------A3F8A45CF3911E3FAF30A8D3
Content-Type: application/x-compressed-tar;
 name="llvmtest-failure.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="llvmtest-failure.tgz"

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
9F2i/wN3VSJLAHgAAA==
--------------A3F8A45CF3911E3FAF30A8D3--
