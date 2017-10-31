From: Bram Stolk <b.stolk@gmail.com>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Tue, 31 Oct 2017 10:10:28 -0700
Message-ID: <CABYXEktUSaLrT4Ajp17D4i93o1Sia+Jd5vpSAydEPNOw6nTFiA@mail.gmail.com>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
 <20171031142537.GT7045@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:50308 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdJaRKa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Oct 2017 13:10:30 -0400
Received: by mail-ua0-f180.google.com with SMTP id v27so12562216uav.7
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2017 10:10:29 -0700 (PDT)
In-Reply-To: <20171031142537.GT7045@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Thanks for trying to reproduce, Arnaldo.

But for me, it's not the kernel symbols that are missing: they are all
there, syscalls and stuff.
Just the app's symbols itself are missing.

What happens if you try it on a binary you built locally, that spends
cycles in userspace?

Here is my output on my clang-built binary:

$ perf script
perf 10198 144604.396458:          1 cycles:pp:
        ffffffff81064508 native_write_msr_safe ([kernel.kallsyms])
        ffffffff8100aebd __intel_pmu_enable_all ([kernel.kallsyms])
        ffffffff8100af30 intel_pmu_enable_all ([kernel.kallsyms])
        ffffffff81006e41 x86_pmu_enable ([kernel.kallsyms])
        ffffffff8117c527 perf_pmu_enable.part.89 ([kernel.kallsyms])
        ffffffff811813e1 perf_pmu_enable ([kernel.kallsyms])
        ffffffff810052e0 x86_pmu_commit_txn ([kernel.kallsyms])
        ffffffff8117e887 group_sched_in ([kernel.kallsyms])
        ffffffff8117eb50 __perf_event_enable ([kernel.kallsyms])
        ffffffff8117c0fa remote_function ([kernel.kallsyms])
        ffffffff8110445f flush_smp_call_function_queue ([kernel.kallsyms])
        ffffffff81104e53 generic_smp_call_function_single_interrupt
([kernel.kallsyms])
        ffffffff81050df7 smp_call_function_single_interrupt ([kernel.kallsyms])
        ffffffff81844c22 call_function_single_interrupt ([kernel.kallsyms])
        ffffffff81064508 native_write_msr_safe ([kernel.kallsyms])

perf 10198 144604.396465:          1 cycles:pp:
        ffffffff81064508 native_write_msr_safe ([kernel.kallsyms])
        ffffffff81064508 native_write_msr_safe ([kernel.kallsyms])

perf 10198 144604.396468:         10 cycles:pp:
        ffffffff81064508 native_write_msr_safe ([kernel.kallsyms])
        ffffffff81064508 native_write_msr_safe ([kernel.kallsyms])

perf 10198 144604.396471:        184 cycles:pp:
        ffffffff81064508 native_write_msr_safe ([kernel.kallsyms])
        ffffffff81037ddd native_sched_clock ([kernel.kallsyms])

perf 10198 144604.396474:       4362 cycles:pp:
        ffffffff81037ddd native_sched_clock ([kernel.kallsyms])
                  4125ba [unknown] ([unknown])

perf 10198 144604.396479:     104121 cycles:pp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 10198 144604.396514:    1399685 cycles:pp:
                  411ba0 [unknown] ([unknown])
                  412634 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 10198 144604.396956:    3677146 cycles:pp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 10198 144604.398111:    3738199 cycles:pp:
                  40fda0 [unknown] ([unknown])
                  412311 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 10198 144604.399285:    3473249 cycles:pp:
                  411ba0 [unknown] ([unknown])
                  412634 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 10198 144604.400375:    3224007 cycles:pp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 10198 144604.401390: 24189320560325 cycles:pp:
                  40f210 [unknown] ([unknown])
                  41250b [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 10198 144604.815874:   28367691 cycles:pp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])
                  40b303 [unknown] ([unknown])
                  401917 [unknown] ([unknown])

On Tue, Oct 31, 2017 at 7:25 AM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Mon, Oct 30, 2017 at 01:25:08PM -0700, Bram Stolk escreveu:
>> If I record with callstacks like this:
>>
>> $ perf record --freq 2000 --call-graph dwarf ./bench
>>
>> then it works just fine: I see callstacks, and symbols in the report.
>>
>> If I delay the recording by 1 second with the --delay flag, like this:
>>
>> $ perf record --delay=1000 --freq 2000 --call-graph dwarf ./bench
>>
>> Then I lose all callstack information, and even all symbol information
>> on my program in the report.
>>
>> Is this a known issue, that --delay interferes with symbol resolution?
>>
>> Thanks!
>>
>>   Bram
>>
>> PS: I am on 64b Ubuntu, and perf version 4.4.87
>
> Works for me: :-)
>
> [root@jouet ~]# perf record --delay=1000 --freq 2000 --call-graph dwarf sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.050 MB perf.data (4 samples) ]
> [root@jouet ~]# perf script
> perf 30567 248464.097254:          1 cycles:ppp:
>                   3b233a __perf_event_task_sched_in (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   2be207 finish_task_switch (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   a44d21 __sched_text_start (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   a45368 schedule (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   a49679 do_nanosleep (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   30c816 hrtimer_nanosleep (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   30c96e sys_nanosleep (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   203a41 do_syscall_64 (/lib/modules/4.14.0-rc3+/build/vmlinux)
>                   a4ad67 return_from_SYSCALL_64 (/lib/modules/4.14.0-rc3+/build/vmlinux)
>
> perf 30567 248464.097288:          1 cycles:ppp:
>                   20d1d0 intel_bts_enable_local (/lib/modules/4.14.0-rc3+/build/vmlinux)
>
> perf 30567 248464.097302:          3 cycles:ppp:
>                   223111 native_sched_clock (/lib/modules/4.14.0-rc3+/build/vmlinux)
>
> perf 30567 248464.097317:         16 cycles:ppp:
>                   223111 native_sched_clock (/lib/modules/4.14.0-rc3+/build/vmlinux)
>
> [root@jouet ~]# perf -v
> perf version 4.14.rc6.gd688d0
> [root@jouet ~]# uname -a
> Linux jouet 4.14.0-rc3+ #1 SMP Fri Oct 13 12:21:12 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
> [root@jouet ~]#



-- 
Owner/Director of Game Studio Abraham Stolk Inc.
Vancouver BC, Canada
b.stolk@gmail.com
