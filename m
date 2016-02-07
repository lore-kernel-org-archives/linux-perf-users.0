From: Andreas Hollmann <hollmann@in.tum.de>
Subject: How to detect memory bound workloads with perf / toplev?
Date: Sun, 7 Feb 2016 18:39:41 +0100
Message-ID: <CAGz0_-3mKi2rict8yh-+28xLxjwSAjEDh62fwqCT4g6hm4x=Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:56736 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754635AbcBGRjo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 7 Feb 2016 12:39:44 -0500
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id 0F54C1C1134
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Feb 2016 18:39:42 +0100 (CET)
Received: by mail-qg0-f44.google.com with SMTP id b67so16356384qgb.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Feb 2016 09:39:42 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi,

im trying to find a good metric to detect memory bound situations on a
system. Pure memory bandwidth depends on the memory access pattern and
does not help to detect if the DRAM is really busy.

I found some metrics in toplev and in some documents by Ahmad Yasin
and David Levinthal.

OFFCORE_REQUESTS_OUTSTANDING.DEMAND.READ_DATA COUNTER_MASK=6 / cycles

As I understand it should give you the ratio of cycles with 6 or more
elements in the super queue and the overall cycles.

Description in toplev:

This metric estimates cycles fraction where the performance
was likely hurt due to approaching bandwidth limits of
external main (DRAM).  This metric does not aggregate
requests from other threads/cores/sockets (see Uncore
counters for that).. NUMA in multi-socket system may be
considered in such case.

ORO_Demand_DRD_C6(self, EV, 4) / CLKS(self, EV, 4 )

On my Ivybrdige CPU on my notebook it return even for pure memory
bound applications (triad a = b + 1.0 * c; a, b, c, arrays of 1 GB
size) a ratio of 0.3.

On my Westmere-EX server the same counter returns 0.001 for the same
application, which makes even less sense, since it has 10 cores per
socket and the memory bandwidth should be even a bigger issue.

Is this counter broken on the Westmere-EX architecture? Toplev
supports only Sandybridge and later.

Here is how I did the experiment:

wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
gcc -fopenmp -O2 -DNTIMES=100 -DSTREAM_ARRAY_SIZE=100000000 stream.c
-o stream.100M
perf stat -e cycles,"cpu/config=0x6530160,name=ORO_Demand_DRD_C6/" -D
5000 ./stream.100M

Ivybridge 8 Threads

Performance counter stats for './stream.100M':

 1,324,163,717,562      cycles
   364,524,300,688      ORO_Demand_DRD_C6

Westmere-EX (4-Socket * 20 Threads)

 Performance counter stats for './stream.100M':

     1923967401946      cycles
         228881898      ORO_Demand_DRD_C6

      18.754835181 seconds time elapsed
