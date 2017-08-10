From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf test BPF subtest bpf-prologue test fails on s390x
Date: Thu, 10 Aug 2017 15:13:19 -0300
Message-ID: <20170810181319.GD3900@kernel.org>
References: <20170809092419.68601-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753023AbdHJSNb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2017 14:13:31 -0400
Content-Disposition: inline
In-Reply-To: <20170809092419.68601-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Wang Nan <wangnan0@huawei.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zefan Li <lizefan@huawei.com>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Thomas, please try to find who wrote that test and CC him, I'm doing it
this time, Wang, can you please take a look at this?

I also added lkml to the CC list, here we have more users of perf, lkml
is the more developer centric perf list, as perf touches way too many
places in the kernel.

Best regards,

- Arnaldo

Em Wed, Aug 09, 2017 at 11:24:19AM +0200, Thomas Richter escreveu:
> I investigate perf test BPF for s390x and have a question regarding
> the 38.3 subtest (bpf-prologue test) which fails on s390x.
> 
> When I turn on trace_printk in tests/bpf-script-test-prologue.c
> I see this output in /sys/kernel/debug/tracing/trace:
> 
> [root@s8360047 perf]# cat /sys/kernel/debug/tracing/trace
> perf-30229 [000] d..2 170161.535791: : f_mode 2001d00000000 offset:0 orig:0
> perf-30229 [000] d..2 170161.535809: : f_mode 6001f00000000 offset:0 orig:0
> perf-30229 [000] d..2 170161.535815: : f_mode 6001f00000000 offset:1 orig:0
> perf-30229 [000] d..2 170161.535819: : f_mode 2001d00000000 offset:1 orig:0
> perf-30229 [000] d..2 170161.535822: : f_mode 2001d00000000 offset:2 orig:1
> perf-30229 [000] d..2 170161.535825: : f_mode 6001f00000000 offset:2 orig:1
> perf-30229 [000] d..2 170161.535828: : f_mode 6001f00000000 offset:3 orig:1
> perf-30229 [000] d..2 170161.535832: : f_mode 2001d00000000 offset:3 orig:1
> perf-30229 [000] d..2 170161.535835: : f_mode 2001d00000000 offset:4 orig:0
> perf-30229 [000] d..2 170161.535841: : f_mode 6001f00000000 offset:4 orig:0
> 
> [...]
> 
> There are 3 parameters the eBPF program tests/bpf-script-test-prologue.c
> accesses: f_mode (member of struct file at offset 140) offset and orig.
> They are parameters of the lseek() system call triggered in this
> test case in function llseek_loop().
> 
> What is really strange is the value of f_mode. It is an 8 byte
> value, whereas in the probe event it is defined as a 4 byte value.
> The lower 4 bytes are all zero and do not belong to member f_mode.
> The correct value should be 2001d for read-only and 6001f for
> read-write open mode.
> 
> Here is the output of the 'perf test -vv bpf' trace:
>    Try to find probe point from debuginfo.
>    Matched function: null_lseek [2d9310d]
>    Probe point found: null_lseek+0
>    Searching 'file' variable in context.
>    Converting variable file into trace event.
>    converting f_mode in file
>    f_mode type is unsigned int.
>    Opening /sys/kernel/debug/tracing//README write=0
>    Searching 'offset' variable in context.
>    Converting variable offset into trace event.
>    offset type is long long int.
>    Searching 'orig' variable in context.
>    Converting variable orig into trace event.
>    orig type is int.
>    Found 1 probe_trace_events.
>    Opening /sys/kernel/debug/tracing//kprobe_events write=1
>    Writing event: p:perf_bpf_probe/func _text+8794224 f_mode=+140(%r2):x32
> 	offset=%r3:s64 orig=%r4:s32
> 
> I have the feeling that this is an endianness issue. In file
> test/bpf-script-test-prologue.c there is this condition:
> 
>    if (f_mode & FMODE_WRITE)
> 	return 0;
> 
> On little endian platforms the value is swapped and becomes
> 0x2001d. When checking for bit 2 (FMODE_WRITE) the comparison
> succeeds in half of the invocations and fails in the other half.
> 
> On big endian platforms the value is 0xxxxx00000000 and the
> test for write-opened file always fails and all invocations
> return zero.
> 
> I use Fedora 25 and 
> [root@s8360047 ~]# rpm -qa | egrep 'clang|llvm'
> llvm-3.8.1-2.fc25.s390x
> clang-3.8.1-1.fc25.s390x
> clang-libs-3.8.1-1.fc25.s390x
> llvm-libs-3.8.1-2.fc25.s390x
> 
> Any ideas on how to debug this further.
> 
> Thanks Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
