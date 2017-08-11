From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf test BPF subtest bpf-prologue test fails on s390x
Date: Fri, 11 Aug 2017 13:19:16 +0800
Message-ID: <53348602-8cff-e218-cdeb-b5504fd211e2@huawei.com>
References: <20170810181319.GD3900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:3507 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdHKFTf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2017 01:19:35 -0400
In-Reply-To: <20170810181319.GD3900@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zefan Li <lizefan@huawei.com>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On 2017/8/11 2:13, Arnaldo Carvalho de Melo wrote:
> Thomas, please try to find who wrote that test and CC him, I'm doing it
> this time, Wang, can you please take a look at this?
>
> I also added lkml to the CC list, here we have more users of perf, lkml
> is the more developer centric perf list, as perf touches way too many
> places in the kernel.
>
> Best regards,
>
> - Arnaldo
>
> Em Wed, Aug 09, 2017 at 11:24:19AM +0200, Thomas Richter escreveu:
>> I investigate perf test BPF for s390x and have a question regarding
>> the 38.3 subtest (bpf-prologue test) which fails on s390x.
>>
>> When I turn on trace_printk in tests/bpf-script-test-prologue.c
>> I see this output in /sys/kernel/debug/tracing/trace:
>>
>> [root@s8360047 perf]# cat /sys/kernel/debug/tracing/trace
>> perf-30229 [000] d..2 170161.535791: : f_mode 2001d00000000 offset:0 orig:0
>> perf-30229 [000] d..2 170161.535809: : f_mode 6001f00000000 offset:0 orig:0
>> perf-30229 [000] d..2 170161.535815: : f_mode 6001f00000000 offset:1 orig:0
>> perf-30229 [000] d..2 170161.535819: : f_mode 2001d00000000 offset:1 orig:0
>> perf-30229 [000] d..2 170161.535822: : f_mode 2001d00000000 offset:2 orig:1
>> perf-30229 [000] d..2 170161.535825: : f_mode 6001f00000000 offset:2 orig:1
>> perf-30229 [000] d..2 170161.535828: : f_mode 6001f00000000 offset:3 orig:1
>> perf-30229 [000] d..2 170161.535832: : f_mode 2001d00000000 offset:3 orig:1
>> perf-30229 [000] d..2 170161.535835: : f_mode 2001d00000000 offset:4 orig:0
>> perf-30229 [000] d..2 170161.535841: : f_mode 6001f00000000 offset:4 orig:0
>>
>> [...]
>>
>> There are 3 parameters the eBPF program tests/bpf-script-test-prologue.c
>> accesses: f_mode (member of struct file at offset 140) offset and orig.
>> They are parameters of the lseek() system call triggered in this
>> test case in function llseek_loop().
>>
>> What is really strange is the value of f_mode. It is an 8 byte
>> value, whereas in the probe event it is defined as a 4 byte value.
>> The lower 4 bytes are all zero and do not belong to member f_mode.
>> The correct value should be 2001d for read-only and 6001f for
>> read-write open mode.
>>
>> Here is the output of the 'perf test -vv bpf' trace:
>>     Try to find probe point from debuginfo.
>>     Matched function: null_lseek [2d9310d]
>>     Probe point found: null_lseek+0
>>     Searching 'file' variable in context.
>>     Converting variable file into trace event.
>>     converting f_mode in file
>>     f_mode type is unsigned int.
>>     Opening /sys/kernel/debug/tracing//README write=0
>>     Searching 'offset' variable in context.
>>     Converting variable offset into trace event.
>>     offset type is long long int.
>>     Searching 'orig' variable in context.
>>     Converting variable orig into trace event.
>>     orig type is int.
>>     Found 1 probe_trace_events.
>>     Opening /sys/kernel/debug/tracing//kprobe_events write=1
>>     Writing event: p:perf_bpf_probe/func _text+8794224 f_mode=+140(%r2):x32
>> 	offset=%r3:s64 orig=%r4:s32

Thank you for your information. This is an endianess problem.

Here f_mode is x32, so perf probe and debuginfo in vmlinux is correct.
However, BPF prologue generator doesn't obey type, but unconditionally
fetch 8 bytes (on 64-bit machine) and pass it to parameter of
bpf_func__null_lseek. This is reasonable, because all args should be
unsigned long. However, to recover its original value, we need a casting.

Please help me verify if the following fix works on your platform:

diff --git a/tools/perf/tests/bpf-script-test-prologue.c 
b/tools/perf/tests/bpf-script-test-prologue.c
index b4ebc75..43f1e16 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -26,9 +26,11 @@ static void (*bpf_trace_printk)(const char *fmt, int 
fmt_size, ...) =
         (void *) 6;

  SEC("func=null_lseek file->f_mode offset orig")
-int bpf_func__null_lseek(void *ctx, int err, unsigned long f_mode,
+int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
                          unsigned long offset, unsigned long orig)
  {
+       fmode_t f_mode = (fmode_t)_f_mode;
+
         if (err)
                 return 0;
         if (f_mode & FMODE_WRITE)

Thank you.
