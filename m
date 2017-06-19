From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf test LLVM failure
Date: Mon, 19 Jun 2017 18:29:18 +0800
Message-ID: <4dc06e88-f779-0549-85e7-95610ec4612b@huawei.com>
References: <95f0579d-ae99-1c6d-a19a-c79a77fea6e6@linux.vnet.ibm.com>
 <20170616160957.GE3645@kernel.org>
 <9df6cb52-345d-1e16-96af-fe7dd6bcbc2c@huawei.com>
 <3fddab50-c06d-452a-3447-970e3c368bcd@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:7907 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbdFSK3s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jun 2017 06:29:48 -0400
In-Reply-To: <3fddab50-c06d-452a-3447-970e3c368bcd@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>

Hi,

Thank you for your quick reply.

The problem is caused by following relocation information:

$ readelf -a ./llvmsubtest3
...
   [ 5] _ftrace_branch    PROGBITS         0000000000000000  00000260
        00000000000000a0  0000000000000000  WA       0     0     4
...
Relocation section '.relfunc=null_lseek file->f_mode offset orig' at 
offset 0x490 contains 4 entries:
   Offset          Info           Type           Sym. Value    Sym. Name
000000000038  000b00000001 unrecognized: 1       0000000000000000 
_ftrace_branch
0000000000b0  000b00000001 unrecognized: 1       0000000000000000 
_ftrace_branch
000000000128  000b00000001 unrecognized: 1       0000000000000000 
_ftrace_branch
0000000001c0  000b00000001 unrecognized: 1       0000000000000000 
_ftrace_branch

Relocation section '.rel_ftrace_branch' at offset 0x4d0 contains 8 entries:
   Offset          Info           Type           Sym. Value    Sym. Name
000000000000  000200000001 unrecognized: 1       0000000000000000 
.L__func__.bpf_func__n
000000000008  000100000001 unrecognized: 1       0000000000000015 .L.str
000000000028  000200000001 unrecognized: 1       0000000000000000 
.L__func__.bpf_func__n
000000000030  000100000001 unrecognized: 1       0000000000000015 .L.str
000000000050  000200000001 unrecognized: 1       0000000000000000 
.L__func__.bpf_func__n
000000000058  000100000001 unrecognized: 1       0000000000000015 .L.str
000000000078  000200000001 unrecognized: 1       0000000000000000 
.L__func__.bpf_func__n
000000000080  000100000001 unrecognized: 1       0000000000000015 .L.str
...

So I think the failure is because you enabled CONFIG_PROFILE_ALL_BRANCHES.

I can reproduce your buggy result by selecting 
CONFIG_PROFILE_ALL_BRANCHES in my
kbuild:

$ ./perf test LLVM
35: LLVM search and compile                    :
35.1: Basic BPF llvm compile                    : Ok
35.2: kbuild searching                          : Ok
35.3: Compile source for BPF prologue generation: FAILED!
35.4: Compile source for BPF relocation         : Skip

Simply undef CONFIG_PROFILE_ALL_BRANCHES in clang opts not working 
because it is
introduced by "#include <uapi/linux/fs.h>", which override cmdline 
options. So I
think the best way is to undefine 'if' inside BPF script.

Please have a look on the patch I sent:

http://lkml.kernel.org/r/20170620183203.2517-1-wangnan0@huawei.com

Thank you.


On 2017/6/19 15:45, Thomas-Mich Richter wrote:
> On 06/19/2017 02:34 AM, Wangnan (F) wrote:
>> Hi,
>>
>> I made a quick test on my ubuntu system, unable to reproduce.
>>
>> My clang environment:
>>
>> $ clang --version
>> clang version 3.8.1-12ubuntu1 (tags/RELEASE_381/final)
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/bin
>>
>> My source code:
>> $ git show
>> commit a351e9b9fc24e982ec2f0e76379a49826036da12
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Sun Apr 30 19:47:48 2017 -0700
>>
>>      Linux 4.11
>>
>>
>> Test result:
>>
>> $ ./perf test LLVM
>> 35: LLVM search and compile                    :
>> 35.1: Basic BPF llvm compile                    : Ok
>> 35.2: kbuild searching                          : Ok
>> 35.3: Compile source for BPF prologue generation: Ok
>> 35.4: Compile source for BPF relocation         : Ok
>>
>>
>>
>> In your environment, clang produces a buggy BPF object file during
>> 'perf test LLVM', but produces a correct BPF object when you compile
>> it manually. I think the cmdline you provided to clang is different
>> from the cmdline 'perf test' generated.
>>
>> Could you please provide the result of 'perf test -vv LLVM'
>> and the cmdline you use for manual testing?
>>
>> Also, it would be thankful if you provide the '.o' file produced
>> by perf test and by your manually testing. Following are steps
>> to get it.
>>
>> If you build perf from source, please apply the following patch:
>>
>> ################### BEGIN ###################
>>
>> diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
>> index 482b536..e0694e0 100644
>> --- a/tools/perf/tests/llvm.c
>> +++ b/tools/perf/tests/llvm.c
>> @@ -138,6 +138,8 @@ int test__llvm(int subtest)
>>       void *obj_buf = NULL;
>>       size_t obj_buf_sz = 0;
>>       bool should_load_fail = false;
>> +    FILE *fp;
>> +    char fn[64];
>>
>>       if ((subtest < 0) || (subtest >= __LLVM_TESTCASE_MAX))
>>           return TEST_FAIL;
>> @@ -152,6 +154,14 @@ int test__llvm(int subtest)
>>                    bpf_source_table[subtest].desc);
>>           }
>>       }
>> +
>> +    snprintf(fn, sizeof(fn), "/tmp/perf-test-llvm-%d.o", subtest);
>> +    fp = fopen(fn, "wb");
>> +    if (fp) {
>> +        fwrite(obj_buf, obj_buf_sz, 1, fp);
>> +        fclose(fp);
>> +    }
>> +
>>       free(obj_buf);
>>
>>       return ret;
>> ################### END ###################
>>
>> then do 'perf test LLVM', and give me /tmp/perf-test-llvm-2.o
>>
>> If you can't change perf's source code, you can use strace to capture
>> the content of it:
>> $ strace -f -o /tmp/out  -s 8192 ./perf test -vv LLVM
>>
>> In resulting /tmp/out, search 'write.*ELF.*null_lseek', you will find
>> a line looks like:
>>
>> 12101 write(3, "\177ELF\2\1\1\0\0\0 ... ", 928) = 928
>>
>> Send that line to me.
>>
>> Thank you.
>>
> Thank you very much for your help. I attach a tgz file which contains:
> llvm/
> llvm/llvmsubtest3.c   <-- Source code of failing subtest 35.3
> llvm/llvmsubtest3     <-- Object code
> llvm/bpftest1.c       <-- Souce code of BPF test (unneeded)
> llvm/Makefile         <-- Makefile to build llvmsubtest2 and 3
> llvm/llvmsubtest2.c   <-- Souce code of succeeding subtest 35.2
> llvm/llvmsubtest2     <-- Object code
> llvm/output/          <-- Output directory for command ./perf test -vv LLVM
> llvm/output/llvm.out  <-- Verbose output of ./perf test -vv LLVM
> llvm/output/perf-test-llvm-1.o <-- Object code for subtest 2
> llvm/output/perf-test-llvm-2.o <-- Object code for subtest 3
> llvm/output/perf-test-llvm-0.o <-- Object code for subtest 0
>
> This provides all the information you requested.
> The object files perf-test-llvm-[012].o have been captured with the
> patch you provided.
> The object code for llvmsubtest3.c compiled using my makefile
> and the perf test LLVM code is identifcal:
>
> [root@s8360047 llvm]# cmp llvmsubtest3 /tmp/perf-test-llvm-2.o
> [root@s8360047 llvm]#
>
> Thanks
