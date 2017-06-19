From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf test LLVM failure
Date: Mon, 19 Jun 2017 08:34:12 +0800
Message-ID: <9df6cb52-345d-1e16-96af-fe7dd6bcbc2c@huawei.com>
References: <95f0579d-ae99-1c6d-a19a-c79a77fea6e6@linux.vnet.ibm.com>
 <20170616160957.GE3645@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:7884 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbdFSAek (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 18 Jun 2017 20:34:40 -0400
In-Reply-To: <20170616160957.GE3645@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>

Hi,

I made a quick test on my ubuntu system, unable to reproduce.

My clang environment:

$ clang --version
clang version 3.8.1-12ubuntu1 (tags/RELEASE_381/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

My source code:
$ git show
commit a351e9b9fc24e982ec2f0e76379a49826036da12
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Apr 30 19:47:48 2017 -0700

     Linux 4.11


Test result:

$ ./perf test LLVM
35: LLVM search and compile                    :
35.1: Basic BPF llvm compile                    : Ok
35.2: kbuild searching                          : Ok
35.3: Compile source for BPF prologue generation: Ok
35.4: Compile source for BPF relocation         : Ok



In your environment, clang produces a buggy BPF object file during
'perf test LLVM', but produces a correct BPF object when you compile
it manually. I think the cmdline you provided to clang is different
from the cmdline 'perf test' generated.

Could you please provide the result of 'perf test -vv LLVM'
and the cmdline you use for manual testing?

Also, it would be thankful if you provide the '.o' file produced
by perf test and by your manually testing. Following are steps
to get it.

If you build perf from source, please apply the following patch:

################### BEGIN ###################

diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 482b536..e0694e0 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -138,6 +138,8 @@ int test__llvm(int subtest)
      void *obj_buf = NULL;
      size_t obj_buf_sz = 0;
      bool should_load_fail = false;
+    FILE *fp;
+    char fn[64];

      if ((subtest < 0) || (subtest >= __LLVM_TESTCASE_MAX))
          return TEST_FAIL;
@@ -152,6 +154,14 @@ int test__llvm(int subtest)
                   bpf_source_table[subtest].desc);
          }
      }
+
+    snprintf(fn, sizeof(fn), "/tmp/perf-test-llvm-%d.o", subtest);
+    fp = fopen(fn, "wb");
+    if (fp) {
+        fwrite(obj_buf, obj_buf_sz, 1, fp);
+        fclose(fp);
+    }
+
      free(obj_buf);

      return ret;
################### END ###################

then do 'perf test LLVM', and give me /tmp/perf-test-llvm-2.o

If you can't change perf's source code, you can use strace to capture
the content of it:
$ strace -f -o /tmp/out  -s 8192 ./perf test -vv LLVM

In resulting /tmp/out, search 'write.*ELF.*null_lseek', you will find
a line looks like:

12101 write(3, "\177ELF\2\1\1\0\0\0 ... ", 928) = 928

Send that line to me.

Thank you.

On 2017/6/17 0:09, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 13, 2017 at 10:40:37AM +0200, Thomas-Mich Richter escreveu:
>> I have Fedora 25 with an 4.11 kernel and get this error
>>
>> [root@s8360047 perf]# ./perf test   LLVM
>> 35: LLVM search and compile                    :
>> 35.1: Basic BPF llvm compile                    : Ok
>> 35.2: kbuild searching                          : Ok
>> 35.3: Compile source for BPF prologue generation: FAILED!
>> 35.4: Compile source for BPF relocation         : Skip
>> [root@s8360047 perf]#
>>
>> The error message is
>> libbpf: Program 'func=null_lseek file->f_mode offset orig'
>> contains non-map related relo data pointing to section 5
> Wang, can you please take a look at this?
>
> - Arnaldo
>   
>> I have installed
>> clang-3.8.1-1.fc25.s390x
>> clang-libs-3.8.1-1.fc25.s390x
>> libpfm-4.8.0-2.ibm.fc25.s390x
>> compiler-rt-3.9.1-1.fc25.s390x
>> llvm-libs-3.8.1-2.fc25.s390x
>>
>> and when I compile the test/bpf-script-test-prologue.c manually
>> the compile does not show any error message.
>>
>> The error comes from file ../lib/bpf/libbpf.c
>> function bpf_program__collect_reloc()
>>
>> Any ideas what cauese this and how to fix it?
>>
>> By the way Fedora 24 with the same kernel version as above runs fine.
>>
>> -- 
>> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
>> --
>> Vorsitzende des Aufsichtsrats: Martina Koederitz
>> Geschäftsführung: Dirk Wittkopp
>> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
