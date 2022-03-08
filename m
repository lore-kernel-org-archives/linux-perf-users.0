Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D9C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Mar 2022 12:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiCHMYr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Mar 2022 07:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiCHMYr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Mar 2022 07:24:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9265746151
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Mar 2022 04:23:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59C4E139F;
        Tue,  8 Mar 2022 04:23:50 -0800 (PST)
Received: from [10.57.40.166] (unknown [10.57.40.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECCFD3FA5D;
        Tue,  8 Mar 2022 04:23:49 -0800 (PST)
Message-ID: <9b4749a8-f3f3-e2e6-b1d3-8b23d946e10a@arm.com>
Date:   Tue, 8 Mar 2022 12:23:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: What exactly does -F <freq> do?
Content-Language: en-US
To:     Douglas Graham <douglas.graham@ericsson.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <DM5PR15MB17390661547DEAA8C397A540F0069@DM5PR15MB1739.namprd15.prod.outlook.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <DM5PR15MB17390661547DEAA8C397A540F0069@DM5PR15MB1739.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 05/03/2022 00:51, Douglas Graham wrote:
> Hi,
> 
> The perf-record man page says this about the -F option:
> 
>   -F, --freq=
>            Profile at this frequency.
> 
> And this about the -c option:
> 
>        -c, --count=
>            Event period to sample.
> 
> A "perf stat sleep 1" on the system I'm interested in says:
> 
>            1630370      cycles                    #    1.315 GHz
> 
> As I understand it, the cycles event is used by default, so a 100 Hz sample frequency should give the same results as a 13150000 cycles sample period.
> 
> And yet the results with "-F 100" are significantly different than those with "-c 13150000".  Perf script output shows the same number of cycles on all samples collected with -c, eg:
> 
>     tmoSchedulerTx  2281 [003] 32746.853052:   13150000   cycles:        55834b1e5c [unknown] (/opt/foo)
>    richw_commond  1950 [003] 32746.926042:   13150000   cycles:  ffffffc010013504 do_el0_svc+0x44 ([kernel.kallsyms])
>          swapper                  0 [000] 32746.946399:   13150000   cycles:  ffffffc0107d1828 arch_cpu_idle+0x14 ([kernel.kallsyms])
>    richw_commond  1889 [003] 32747.002987:   13150000   cycles:  ffffffc0107dba24 _raw_spin_unlock_irqrestore+0x14 ([kernel.kallsyms])
> 
> whereas the number of cycles bounces around in the perf -F output, eg:
> 
>   tmoSchedulerTx   2281 [001] 32696.168404:    5904091    cycles:        55834b1988 [unknown] (/opt/foo)
>          startUp            2180 [001] 32696.209523:    6148607    cycles:        7fb235de68 operator delete@plt+0x8 (/usr/lib/foo.so.0.0.0)
>          swapper                 0 [001] 32696.348061:    6416807    cycles:  ffffffc0107dbaa8 _raw_spin_unlock_irq+0x18 ([kernel.kallsyms])
>    richw_commond  1889 [002] 32696.501004:   21730400   cycles:  ffffffc0107dbaa8 _raw_spin_unlock_irq+0x18 ([kernel.kallsyms])
> 
> I can understand why perf would have to keep adjusting the number of events between samples if it is targeting an constant average sample frequency but using an event that occurs at a variable rate (eg: cache misses), but cycles *does* occur at a fixed rate. So why does the number of cycles between samples keep changing (often radically) like this?  What exactly is perf aiming for?
> 
> Other statistical profilers (eg: gprof) sample at a fixed frequency, where you can assume that if the sampling frequency is 100Hz, then each sample represents roughly 10ms.  A function that was sampled 100 times during a test run ran for roughly 1 second during that run.  I think the same can be said if perf record is used with the -c option to ensure a constant sampling period.  But I have no idea how to interpret the results of a "perf record -F 100".  It almost looks like it's trying to capture 100 non-idle samples every second, but if that's what it's doing, I think the result can be wildly inaccurate.  If it's constantly adjust the sample rate to try to ensure a fixed number of non-idle samples per second, then it will sample more often when the system is lightly loaded, and that will make whatever happened during that time look more CPU intensive than it really was, when analyzed together with the samples gathered when the system was busy.

Yes you are right, perf only records when the process is scheduled on the CPU. If you're counting cycles
and that process isn't scheduled then cycles isn't increasing so you will get no samples.

If you have a process that has a lot of idle time then maybe -c is better than -F. It also sounds like you
are looking for a wall clock time profiler which perf isn't. You might also be able to play around with
-C or -a which change from tracking a single process to everything on that core/all cores. You still wouldn't get
sleeping samples, but you would get the samples padded out by whatever else was running on the core instead
of your sleeping process so -F might be more accurate.

I suppose perf is just trying to give an accurate representation of what the system is actually doing rather
than padding out with samples of processes that weren't even scheduled like a wall clock time profiler would do.

> 
> Thanks,
> Doug
> 
