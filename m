From: Milian Wolff <mail@milianw.de>
Subject: perf sched trick to profile wait times: period miscalculated on multicore machines
Date: Tue, 04 Aug 2015 17:36:54 +0200
Message-ID: <2080352.v3MQbmJ2PT@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:48565 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbHDPg4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 11:36:56 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 0407162803F8
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2015 17:36:55 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello all,

following the perf tutorial, I recorded and merged samples and backtraces to 
find out where my code is sleeping. The result is something like this:

$ perf report -g graph --no-children --show-total-period --stdio
...

   100.00%            24    8886224240  ex_sleep  
fcca6947df440540ec364a93452b05b3a13ef7  [k] __schedule
            |
            ---__schedule
               schedule
               do_nanosleep
               hrtimer_nanosleep
               sys_nanosleep
               system_call
               __nanosleep
               0x7f36c861f2ad
               |          
               |--90.07%-- QThread::sleep
               |          main
               |          
               |--9.02%-- QThread::msleep
               |          main
               |          
                --0.91%-- QThread::usleep
                          main

Cool! But the period should be in ns, no? That number reported is wrong by an 
order of magnitude, roughly:

The example code sleeps for 1s, 100ms and 10ms. perf stat agrees:

1.112868066 seconds time elapsed ( +-  0.01%, avg over 10 runs )

But perf record shows a period of 8886224240ns = 8.89s - a difference of 
factor 8 (which corresponds to the number of cores on this machine, see also 
below).

I recorded the data by doing

$ sudo mount -o remount,mode=755 /sys/kernel/debug
$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
$ echo \"-1\" | sudo tee /proc/sys/kernel/perf_event_paranoid

perf record -e sched:sched_stat_sleep -e sched:sched_switch -e 
sched:sched_process_exit --call-graph dwarf -o perf.data.raw ./ex_sleep
perf inject -v -s -i perf.data.raw -o perf.data
perf report --no-children --show-total-period --stdio

One interesting find of mine is the following:

 perf script -i perf.data.raw | grep delay
           :7038  7038 [004] 80885.657156: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
           :7038  7038 [004] 80885.657158: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
           :7038  7038 [004] 80885.657158: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
           :7038  7038 [004] 80885.657158: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
           :7038  7038 [004] 80885.657158: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
           :7038  7038 [004] 80885.657158: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
           :7038  7038 [004] 80885.657159: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
           :7038  7038 [004] 80885.657159: sched:sched_stat_sleep: comm=perf 
pid=7039 delay=1015990 [ns]
         swapper     0 [002] 80886.659750: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.659752: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.659753: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.659754: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.659754: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.659755: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.659756: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.659757: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=1000521253 [ns]
         swapper     0 [002] 80886.759925: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.759927: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.759927: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.759928: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.759929: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.759930: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.759930: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.759931: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=100144138 [ns]
         swapper     0 [002] 80886.770070: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]
         swapper     0 [002] 80886.770072: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]
         swapper     0 [002] 80886.770073: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]
         swapper     0 [002] 80886.770074: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]
         swapper     0 [002] 80886.770075: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]
         swapper     0 [002] 80886.770076: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]
         swapper     0 [002] 80886.770077: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]
         swapper     0 [002] 80886.770078: sched:sched_stat_sleep: 
comm=ex_sleep pid=7039 delay=10114111 [ns]

My machine here is an 8 core, and it seems as if the sleep times are recorded 
once for every core, thus explaining the factor 8 of difference. The 
individual delays in the output above are correct, i.e. 1s, 100ms, 10ms and 
some stuff at the beginning that is perf overhead.

Would be awesome if someone could fix this, or explain me how to use perf 
correctly to not trigger this issue. As a workaround I'll devide the period 
count by nproc for now.

Furthermore, it would be awesome if perf record would repeat the individual 
period in the results, i.e. my ideal output would look somewhat like this:

  100.00%            24    1.11s  ex_sleep  
fcca6947df440540ec364a93452b05b3a13ef7  [k] __schedule
            |
            ---__schedule
               schedule
               do_nanosleep
               hrtimer_nanosleep
               sys_nanosleep
               system_call
               __nanosleep
               0x7f36c861f2ad
               |          
               |--90.07% (1.00s) -- QThread::sleep
               |          main
               |          
               |-- 9.02% (100ms) -- QThread::msleep
               |          main
               |          
                -- 0.91% (10.0ms) -- QThread::usleep
                          main

Thanks
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
