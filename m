From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: reading PMU counts with perf leader sampling and perf script
Date: Mon, 12 Sep 2016 17:04:11 -0300
Message-ID: <20160912200411.GH4897@kernel.org>
References: <etPan.57d2cbe0.548515bd.6188@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbcILUEY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Sep 2016 16:04:24 -0400
Content-Disposition: inline
In-Reply-To: <etPan.57d2cbe0.548515bd.6188@cern.ch>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Omar Awile <omar.awile@cern.ch>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>

Em Fri, Sep 09, 2016 at 02:48:53PM +0000, Omar Awile escreveu:
> Hello,
 
> I’ve been trying to get periodic readouts of PMU event counts using
> perf record (similar to what perf stat -I does but with a higher
> precision than 10ms).
 
> For this I thought I could use leader sampling with ref_cycles and the
> events I am targeting.
 
> For example something like this:
 
> $ perf record -P -c 2000000 -e '{cycles,instructions,branch-misses}:S' — ./workload
 
> This seems to read out the sample values for the other events whenever
> the cycle event is sampled.
 
> The next step would be for me to use perf script and a little python
> script to get the event counts but I can’t seem to find a way to do
> this. Can someone point me in the right direction?
 
> perf report seems to be able to read these samples but they are shown
> only as aggregates. Also, perf script would allow me to
> process/analyze the data myself. If this is currently not possible,
> how would I go about adding the missing functionality in perf script?

Can you please take a look at tools/perf/scripts/python/stat-cpi.py,
this processes hardware counters, in python, the changeset that
introduces it:

https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git/commit/?id=b8a1962d17b4e3cfdd7b7dc9ebd94affbcb4c1c5

<SNIP>
get CPI systemwide:

    $ perf stat -e cycles,instructions -a -I 1000 record sleep 3
    #           time             counts unit events
         1.000158618        594,274,711      cycles                     (100.00%)
         1.000158618        441,898,250      instructions
         2.000350973        567,649,705      cycles                     (100.00%)
         2.000350973        432,669,206      instructions
         3.000559210        561,940,430      cycles                     (100.00%)
         3.000559210        420,403,465      instructions
         3.000670798            780,105      cycles                     (100.00%)
         3.000670798            326,516      instructions

    $ perf script -s ./scripts/python/stat-cpi.py
           1.000159: cpu -1, thread -1 -> cpi 1.344823 (594274711/441898250)
           2.000351: cpu -1, thread -1 -> cpi 1.311972 (567649705/432669206)
           3.000559: cpu -1, thread -1 -> cpi 1.336669 (561940430/420403465)
           3.000671: cpu -1, thread -1 -> cpi 2.389178 (780105/326516)

    $ perf stat -e cycles,instructions -a -I 1000 record sleep 3 | perf script -s ./scripts/python/stat-cpi.py
           1.000202: cpu -1, thread -1 -> cpi 1.035091 (940778881/908885530)
           2.000392: cpu -1, thread -1 -> cpi 1.442600 (627493992/434974455)
           3.000545: cpu -1, thread -1 -> cpi 1.353612 (741463930/547766890)
           3.000622: cpu -1, thread -1 -> cpi 2.642110 (784083/296764)

<SNIP>

And that -I limitation can be lifted, no?

- Arnaldo
