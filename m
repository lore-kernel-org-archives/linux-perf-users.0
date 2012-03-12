From: Ashay Rane <ashay.r@gmail.com>
Subject: Getting event counts from perf record/report
Date: Mon, 12 Mar 2012 15:27:27 -0500
Message-ID: <CANn2t1mwdp20hqjYHejtH_A=jRiRmhn2CRubo=t_uqKvaXoNUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49056 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab2CLU11 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 Mar 2012 16:27:27 -0400
Received: by ghrr11 with SMTP id r11so3011701ghr.19
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Mar 2012 13:27:27 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I was wondering if it is possible to get the number of events (e.g.
cycles) when using `perf report' just like in `perf stat'. For
example, for `hackbench 10 process 1000', I see 19 x 10^9 cycles
reported by `perf stat'. However, `perf report -n' prints "Events: 2K
cycles" and `perf report -n --dso hackbench' prints "Events: 47
cycles". Where does the difference come from? Or am I comparing apples
and oranges?

In the end, what I am looking for is the event count (instead of
percentages) by function. A complete transcript of the commands and
their outputs follows. Any help is appreciated!

Thanks,
Ashay

---
$ perf stat -e cycles ./hackbench 10 process 1000
Running with 10*40 (== 400) tasks.
Time: 4.039

 Performance counter stats for './hackbench 10 process 1000':

    19,060,433,134 cycles                    #    0.000 GHz

       4.078210213 seconds time elapsed

$ perf record -e cycles ./hackbench 10 process 1000
Running with 10*40 (== 400) tasks.
Time: 4.053
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.165 MB perf.data (~7205 samples) ]

$ perf report -n --stdio --dso hackbench
# dso: hackbench
# ========
# captured on: Mon Mar 12 15:14:57 2012
# hostname : iHitch
# os release : 3.2.8-1-ARCH
# perf version : 3.2-3
# arch : x86_64
# nrcpus online : 2
# nrcpus avail : 2
# cpudesc : Intel(R) Core(TM)2 Duo CPU P8600 @ 2.40GHz
# cpuid : GenuineIntel,6,23,10
# total memory : 2979384 kB
# cmdline : /usr/bin/perf record -e cycles ./hackbench 10 process 1000
# event : name = cycles, type = 0, config = 0x0, config1 = 0x0,
config2 = 0x0, excl_usr = 0, excl_kern = 0, id = { 1611, 1612 }
# HEADER_CPU_TOPOLOGY info available, use -I to display
# HEADER_NUMA_TOPOLOGY info available, use -I to display
# ========
#
# Events: 47  cycles
#
# Overhead  Samples      Command     Symbol
# ........ ..........  .........  .........
#
    56.16%         24  hackbench  receiver
    40.21%         21  hackbench  sender
     3.63%          2  hackbench  write@plt


#
# (For a higher level overview, try: perf report --sort comm,dso)
#

$
