From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf test BPF subtest bpf-prologue test fails on s390x
Date: Fri, 11 Aug 2017 17:57:17 +0800
Message-ID: <4cd18c9a-7481-5bca-2d61-49e617ba2f96@huawei.com>
References: <20170810181319.GD3900@kernel.org>
 <53348602-8cff-e218-cdeb-b5504fd211e2@huawei.com>
 <968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zefan Li <lizefan@huawei.com>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org



On 2017/8/11 17:17, Thomas-Mich Richter wrote:
> On 08/11/2017 07:19 AM, Wangnan (F) wrote:
>>
>> On 2017/8/11 2:13, Arnaldo Carvalho de Melo wrote:
>>> Thomas, please try to find who wrote that test and CC him, I'm doing it
>>> this time, Wang, can you please take a look at this?
>>>
>>> I also added lkml to the CC list, here we have more users of perf, lkml
>>> is the more developer centric perf list, as perf touches way too many
>>> places in the kernel.
>>>
>>> Best regards,
>>>
>>> - Arnaldo
>>>
>>> Em Wed, Aug 09, 2017 at 11:24:19AM +0200, Thomas Richter escreveu:
>>>> I investigate perf test BPF for s390x and have a question regarding
>>>> the 38.3 subtest (bpf-prologue test) which fails on s390x.
>>>>
>>>> When I turn on trace_printk in tests/bpf-script-test-prologue.c
>>>> I see this output in /sys/kernel/debug/tracing/trace:
>>>>
>>>> [root@s8360047 perf]# cat /sys/kernel/debug/tracing/trace
>>>> perf-30229 [000] d..2 170161.535791: : f_mode 2001d00000000 offset:0 orig:0
>>>> perf-30229 [000] d..2 170161.535809: : f_mode 6001f00000000 offset:0 orig:0
>>>> perf-30229 [000] d..2 170161.535815: : f_mode 6001f00000000 offset:1 orig:0
>>>> perf-30229 [000] d..2 170161.535819: : f_mode 2001d00000000 offset:1 orig:0
>>>> perf-30229 [000] d..2 170161.535822: : f_mode 2001d00000000 offset:2 orig:1
>>>> perf-30229 [000] d..2 170161.535825: : f_mode 6001f00000000 offset:2 orig:1
>>>> perf-30229 [000] d..2 170161.535828: : f_mode 6001f00000000 offset:3 orig:1
>>>> perf-30229 [000] d..2 170161.535832: : f_mode 2001d00000000 offset:3 orig:1
>>>> perf-30229 [000] d..2 170161.535835: : f_mode 2001d00000000 offset:4 orig:0
>>>> perf-30229 [000] d..2 170161.535841: : f_mode 6001f00000000 offset:4 orig:0
>>>>
>>>> [...]
>>>>
>>>> There are 3 parameters the eBPF program tests/bpf-script-test-prologue.c
>>>> accesses: f_mode (member of struct file at offset 140) offset and orig.
>>>> They are parameters of the lseek() system call triggered in this
>>>> test case in function llseek_loop().
>>>>
>>>> What is really strange is the value of f_mode. It is an 8 byte
>>>> value, whereas in the probe event it is defined as a 4 byte value.
>>>> The lower 4 bytes are all zero and do not belong to member f_mode.
>>>> The correct value should be 2001d for read-only and 6001f for
>>>> read-write open mode.
>>>>
>>>> Here is the output of the 'perf test -vv bpf' trace:
>>>>      Try to find probe point from debuginfo.
>>>>      Matched function: null_lseek [2d9310d]
>>>>      Probe point found: null_lseek+0
>>>>      Searching 'file' variable in context.
>>>>      Converting variable file into trace event.
>>>>      converting f_mode in file
>>>>      f_mode type is unsigned int.
>>>>      Opening /sys/kernel/debug/tracing//README write=0
>>>>      Searching 'offset' variable in context.
>>>>      Converting variable offset into trace event.
>>>>      offset type is long long int.
>>>>      Searching 'orig' variable in context.
>>>>      Converting variable orig into trace event.
>>>>      orig type is int.
>>>>      Found 1 probe_trace_events.
>>>>      Opening /sys/kernel/debug/tracing//kprobe_events write=1
>>>>      Writing event: p:perf_bpf_probe/func _text+8794224 f_mode=+140(%r2):x32
>>>>      offset=%r3:s64 orig=%r4:s32
>> Thank you for your information. This is an endianess problem.
>>
>> Here f_mode is x32, so perf probe and debuginfo in vmlinux is correct.
>> However, BPF prologue generator doesn't obey type, but unconditionally
>> fetch 8 bytes (on 64-bit machine) and pass it to parameter of
>> bpf_func__null_lseek. This is reasonable, because all args should be
>> unsigned long. However, to recover its original value, we need a casting.
>>
>> Please help me verify if the following fix works on your platform:
>>
>> diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
>> index b4ebc75..43f1e16 100644
>> --- a/tools/perf/tests/bpf-script-test-prologue.c
>> +++ b/tools/perf/tests/bpf-script-test-prologue.c
>> @@ -26,9 +26,11 @@ static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
>>          (void *) 6;
>>
>>   SEC("func=null_lseek file->f_mode offset orig")
>> -int bpf_func__null_lseek(void *ctx, int err, unsigned long f_mode,
>> +int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
>>                           unsigned long offset, unsigned long orig)
>>   {
>> +       fmode_t f_mode = (fmode_t)_f_mode;
>> +
>>          if (err)
>>                  return 0;
>>          if (f_mode & FMODE_WRITE)
>>
>> Thank you.
>>
> Thanks for this patch, unfortunately it does not work. The result is the same
> as before. Here is the trace output from /sys/kernel/debug/tracing/trace:
>     perf-18119 [001] d..2 66832.765154: : f_mode 0 offset:0 orig:0
>     perf-18119 [001] d..2 66832.765189: : f_mode 0 offset:0 orig:0
>     perf-18119 [001] d..2 66832.765203: : f_mode 0 offset:1 orig:0
>     perf-18119 [001] d..2 66832.765216: : f_mode 0 offset:1 orig:0
>     perf-18119 [001] d..2 66832.765229: : f_mode 0 offset:2 orig:1
>     perf-18119 [001] d..2 66832.765242: : f_mode 0 offset:2 orig:1
>              

So casting in big-endian platform doesn't work as I thought.

> However when I alter your patch and right shift _f_mode by 32 bits
> like this:
>
>> -int bpf_func__null_lseek(void *ctx, int err, unsigned long f_mode,
>> +int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
>>                           unsigned long offset, unsigned long orig)
>>   {
>> +       fmode_t f_mode = (fmode_t)(_f_mode >> 32);
>> +
>>          if (err)
>>                  return 0;
>>          if (f_mode & FMODE_WRITE)
>>
> the test case succeeds (here is part of the ./perf test -v bpf output):
>
> 38.3: BPF prologue generation                  :
> --- start ---
> test child forked, pid 20477
> Kernel build dir is set to /lib/modules/4.12.0perf1+/build
> set env: KBUILD_DIR=/lib/modules/4.12.0perf1+/build
> unset env: KBUILD_OPTS
>
> [...]
>
> static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
> (void *) 6;
>
> SEC("func=null_lseek file->f_mode offset orig")
> int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
> unsigned long offset, unsigned long orig)
> {
> fmode_t f_mode = (fmode_t)(_f_mode >> 32);
> char m_fmt[] = "f_mode %x offset:%lx orig:%lx\n";
> bpf_trace_printk(m_fmt, sizeof(m_fmt), f_mode, offset, orig);
>
> [...]
>
> Found 1 probe_trace_events.
> Opening /sys/kernel/debug/tracing//kprobe_events write=1
> Writing event: p:perf_bpf_probe/func _text+8769704 f_mode=+132(%r2):x32 offset=%r3:s64 orig=%r4:s32
> [...]
> Parsing probe_events: p:perf_bpf_probe/func _text+8769704 f_mode=+132(%r2):x32 offset=%r3:s64 orig=%r4:s32
> Group:perf_bpf_probe Event:func probe:p
> Writing event: -:perf_bpf_probe/func
> test child finished with 0
> ---- end ----
> BPF filter subtest 2: Ok
>
> The trace output looks correct too:
>
>              perf-20477 [001] d..2 67093.798264: : f_mode 2001d offset:6e orig:1
>              perf-20477 [001] d..2 67093.798288: : f_mode 6001f offset:6e orig:1
>
>
> I did some more digging and added a printk statement into function bpf_probe_read()
> to get some output into the kernel log.
>       Aug 11 09:57:07 s8360047 kernel: ____bpf_probe_read dst:0000000063df7940
>           0x6001f00000000 size:8 unsafe_ptr:0000000067829684 ret:0
>
> I think the error is in file  utils/bpf-prologue.c function gen_read_mem().
> Register 1 is the destination address (pointing to the stack of the bpf program?)
> where the value of struct-file.f_mode member will be stored.
> Register 2 is unconditionally set to 8.
> Register 3 is the pointer to struct-file.f_mode member (source address).
>
> Function BPF_FUNC_probe_read is then invoked to get the value of struct-file.f_mode
> from r3 to store it in r1. This ends up in function bpf_probe_read() and
> probe_kernel_read() which copies 8 byte byte wise from source to destination.
>
> I think there a 2 issues here:
> 1. We copy 8 bytes instead of 4 (sizeof(struct-file.f_mode member is 4 bytes).
> 2. Since this is a byte copy the eBPF program treats the r1 value wrong.
>     
> For little endian platforms this is ok since the eBPF program sees register r1 as
> 0x6001f00000000 (which is treated as 00 00 00 00 00 06 00 1f for arithmetic operation)
> and the bit test for FMODE_WRITE (0x2) succeeds.
>
> For big endian platforms this is wrong and the eBPF program sees register r1 also
> as 0x6001f00000000, but does not swap the byte for arithmetic operations.
> So the bit test for FMODE_WRITE (0x2) always fails.

Your analysis is correct.

>
> Maybe the solution is to add an endianness convertion into the gen_read_mem()
> function.

That means alert the prologue. We can utilize the size field in BPF_LDX_MEM.

Could you please try this patch:

diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 6cdbee1..aadbda4 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -258,7 +258,7 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,

         /* Final pass: read to registers */
         for (i = 0; i < nargs; i++)
-               ins(BPF_LDX_MEM(BPF_DW, BPF_PROLOGUE_START_ARG_REG + i,
+               ins(BPF_LDX_MEM(BPF_W, BPF_PROLOGUE_START_ARG_REG + i,
                                 BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);

         ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);


On your platform and check if the value of f_mode is correct?

NOTE: 64 bit load becomes incorrect after applying this patch. I want to 
make sure
the behavior of 32 bit BPF load instruction works correct on big endian 
machine.

Thank you.
