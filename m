From: yuzhoujian <ufo19890607@gmail.com>
Subject: lost some call trace for sleep function
Date: Thu, 26 Oct 2017 18:24:56 +0800
Message-ID: <1509013496-12486-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:52229 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdJZKZd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Oct 2017 06:25:33 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

Hi, all.
I find a strange problem. Perf cannot record call stack which contains sleep functions.
The last function of the call trace is always "__GI___libc_nanosleep" for each sample.
one of the sample for perf script is below:

test_sleep 12275 185233.961287:          1 cycles:ppp: 
        ffffffff8100add0 intel_bts_enable_local ([kernel.kallsyms])
        ffffffff81008f20 intel_pmu_enable_all ([kernel.kallsyms])
        ffffffff810057ec x86_pmu_enable ([kernel.kallsyms])
        ffffffff81173e57 perf_pmu_enable ([kernel.kallsyms])
        ffffffff81175404 __perf_event_task_sched_in ([kernel.kallsyms])
        ffffffff810c1aa8 finish_task_switch ([kernel.kallsyms])
        ffffffff81690e00 __schedule ([kernel.kallsyms])
        ffffffff81691409 schedule ([kernel.kallsyms])
        ffffffff816902d6 do_nanosleep ([kernel.kallsyms])
        ffffffff810b747b hrtimer_nanosleep ([kernel.kallsyms])
        ffffffff810b75be sys_nanosleep ([kernel.kallsyms])
        ffffffff8169c749 system_call_fastpath ([kernel.kallsyms])
		   bf190 __GI___libc_nanosleep (/usr/lib64/libc-2.17.so)

Below is the source code of test_sleep:

void f2()
{
        sleep(1);
}
void f1()
{
        f2();
}
int main()
{
  	while(1)
     		f1();
   	return 0;
}

I think the right call stack should contain the __sleep function in glibc, just as follow

test_sleep 12275 185233.961287:          1 cycles:ppp: 
        ffffffff8100add0 intel_bts_enable_local ([kernel.kallsyms])
        ffffffff81008f20 intel_pmu_enable_all ([kernel.kallsyms])
        ffffffff810057ec x86_pmu_enable ([kernel.kallsyms])
        ffffffff81173e57 perf_pmu_enable ([kernel.kallsyms])
        ffffffff81175404 __perf_event_task_sched_in ([kernel.kallsyms])
        ffffffff810c1aa8 finish_task_switch ([kernel.kallsyms])
        ffffffff81690e00 __schedule ([kernel.kallsyms])
        ffffffff81691409 schedule ([kernel.kallsyms])
        ffffffff816902d6 do_nanosleep ([kernel.kallsyms])
        ffffffff810b747b hrtimer_nanosleep ([kernel.kallsyms])
        ffffffff810b75be sys_nanosleep ([kernel.kallsyms])
        ffffffff8169c749 system_call_fastpath ([kernel.kallsyms])
		   bf190 __GI___libc_nanosleep (/usr/lib64/libc-2.17.so)
		   bef70 __sleep (/usr/lib64/libc-2.17.so)
        	   5a1 f2 (/home/test_sleep)
        	   5c1 f1 (/home/test_sleep)
        	   5d1 main (/home/test_sleep)
        	   21c05 __libc_start_main (/usr/lib64/libc-2.17.so)

Is it a bug for perf record ??
