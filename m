From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: lost some call trace for sleep function
Date: Thu, 26 Oct 2017 14:32:54 -0300
Message-ID: <20171026173254.GM7045@kernel.org>
References: <1509013496-12486-1-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbdJZRc5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Oct 2017 13:32:57 -0400
Content-Disposition: inline
In-Reply-To: <1509013496-12486-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

Em Thu, Oct 26, 2017 at 06:24:56PM +0800, yuzhoujian escreveu:
> Hi, all.
> I find a strange problem. Perf cannot record call stack which contains sleep functions.
> The last function of the call trace is always "__GI___libc_nanosleep" for each sample.
> one of the sample for perf script is below:

How are you recording it? Please state the exact command line you use for 'record'.

Here are some attempts at doing that on a fedora 26 x86_64 system:

[acme@jouet linux]$ uname -a
Linux jouet 4.14.0-rc3+ #1 SMP Fri Oct 13 12:21:12 -03 2017 x86_64 x86_64 x86_64 GNU/Linux

# perf trace -e nanosleep --max-stack=10 sleep 1
     0.649 (1000.121 ms): sleep/9566 nanosleep(rqtp: 0x7ffe56769570                                        ) = 0
                                       __nanosleep_nocancel (/usr/lib64/libc-2.25.so)
                                       rpl_nanosleep (/usr/bin/sleep)
                                       xnanosleep (/usr/bin/sleep)
                                       main (/usr/bin/sleep)
                                       __libc_start_main (/usr/lib64/libc-2.25.so)
                                       _start (/usr/bin/sleep)
#

Which is equivalent to:

# perf record -e syscalls:sys_enter_nanosleep/call-graph=dwarf,max-stack=10/ sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.027 MB perf.data (1 samples) ]
# perf script
sleep  9629 [001] 210689.400780: syscalls:sys_enter_nanosleep: rqtp: 0x7ffd6a99b180, rmtp: 0x00000000
                   d4420 __nanosleep_nocancel (/usr/lib64/libc-2.25.so)
                    46c6 rpl_nanosleep (/usr/bin/sleep)
                    449f xnanosleep (/usr/bin/sleep)
                    1773 main (/usr/bin/sleep)
                   20509 __libc_start_main (/usr/lib64/libc-2.25.so)
                    1869 _start (/usr/bin/sleep)

# 

But why are you trying to sample CPU cycles used on a function that sleeps?

- Arnaldo
 
> test_sleep 12275 185233.961287:          1 cycles:ppp: 
>         ffffffff8100add0 intel_bts_enable_local ([kernel.kallsyms])
>         ffffffff81008f20 intel_pmu_enable_all ([kernel.kallsyms])
>         ffffffff810057ec x86_pmu_enable ([kernel.kallsyms])
>         ffffffff81173e57 perf_pmu_enable ([kernel.kallsyms])
>         ffffffff81175404 __perf_event_task_sched_in ([kernel.kallsyms])
>         ffffffff810c1aa8 finish_task_switch ([kernel.kallsyms])
>         ffffffff81690e00 __schedule ([kernel.kallsyms])
>         ffffffff81691409 schedule ([kernel.kallsyms])
>         ffffffff816902d6 do_nanosleep ([kernel.kallsyms])
>         ffffffff810b747b hrtimer_nanosleep ([kernel.kallsyms])
>         ffffffff810b75be sys_nanosleep ([kernel.kallsyms])
>         ffffffff8169c749 system_call_fastpath ([kernel.kallsyms])
> 		   bf190 __GI___libc_nanosleep (/usr/lib64/libc-2.17.so)
> 
> Below is the source code of test_sleep:
> 
> void f2()
> {
>         sleep(1);
> }
> void f1()
> {
>         f2();
> }
> int main()
> {
>   	while(1)
>      		f1();
>    	return 0;
> }
> 
> I think the right call stack should contain the __sleep function in glibc, just as follow
> 
> test_sleep 12275 185233.961287:          1 cycles:ppp: 
>         ffffffff8100add0 intel_bts_enable_local ([kernel.kallsyms])
>         ffffffff81008f20 intel_pmu_enable_all ([kernel.kallsyms])
>         ffffffff810057ec x86_pmu_enable ([kernel.kallsyms])
>         ffffffff81173e57 perf_pmu_enable ([kernel.kallsyms])
>         ffffffff81175404 __perf_event_task_sched_in ([kernel.kallsyms])
>         ffffffff810c1aa8 finish_task_switch ([kernel.kallsyms])
>         ffffffff81690e00 __schedule ([kernel.kallsyms])
>         ffffffff81691409 schedule ([kernel.kallsyms])
>         ffffffff816902d6 do_nanosleep ([kernel.kallsyms])
>         ffffffff810b747b hrtimer_nanosleep ([kernel.kallsyms])
>         ffffffff810b75be sys_nanosleep ([kernel.kallsyms])
>         ffffffff8169c749 system_call_fastpath ([kernel.kallsyms])
> 		   bf190 __GI___libc_nanosleep (/usr/lib64/libc-2.17.so)
> 		   bef70 __sleep (/usr/lib64/libc-2.17.so)
>         	   5a1 f2 (/home/test_sleep)
>         	   5c1 f1 (/home/test_sleep)
>         	   5d1 main (/home/test_sleep)
>         	   21c05 __libc_start_main (/usr/lib64/libc-2.17.so)
> 
> Is it a bug for perf record ??
