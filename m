Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E17C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Mar 2022 11:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiCILE5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCILE4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Mar 2022 06:04:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92728B5624
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Mar 2022 03:03:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600611650;
        Wed,  9 Mar 2022 03:03:57 -0800 (PST)
Received: from [10.57.41.86] (unknown [10.57.41.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F19543FA4D;
        Wed,  9 Mar 2022 03:03:56 -0800 (PST)
Message-ID: <d34c1b48-e39b-e533-84be-5811f789ee73@arm.com>
Date:   Wed, 9 Mar 2022 11:03:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: What exactly does -F <freq> do?
Content-Language: en-US
To:     Douglas Graham <douglas.graham@ericsson.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <DM5PR15MB17390661547DEAA8C397A540F0069@DM5PR15MB1739.namprd15.prod.outlook.com>
 <9b4749a8-f3f3-e2e6-b1d3-8b23d946e10a@arm.com>
 <DM5PR15MB1739AC36558E0ED388735AB6F00A9@DM5PR15MB1739.namprd15.prod.outlook.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <DM5PR15MB1739AC36558E0ED388735AB6F00A9@DM5PR15MB1739.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 09/03/2022 01:05, Douglas Graham wrote:
> Thanks for the reply.
> 
>  > Yes you are right, perf only records when the process is scheduled on
>> the CPU. If you're counting cycles and that process isn't scheduled
>> then cycles isn't increasing so you will get no samples.
> 
> Maybe there is something fundamental about how perf record works that I'm not getting.
> I'm assuming that cycles is always incrementing, regardless of what is happening in
> software or what thread is running. The only thing that might change its frequency is
> CPU frequency scaling. Without freqency scaling, cycles is incremented at a constant rate.  I assume
> the way it works when I use -c <sample period> is that it writes the specified sample period to a
> PMU register. When the number of elapsed cycles hits that limit, an interrupt is generated.
> The ISR examines the state of the CPU.  If it is idle, then no sample is saved. If a thread
> is running, its program counter (and possibly a whole backtrace) is saved.  So if the CPU
> is 10% busy, only 10% of the sampling interrupts will actually wind up saving a sample.
> 
> You seem to be saying that the sampling interrupts are only generated when a thread is running
> and that they all result in a sample being saved. I think this make sense when the event being
> monitored is caused by something the thread does.  For example, you won't get any cache
> misses if nothing is running, so if your event is cache misses, you will never get a sampling interrupt
> while the CPU is idle.   But unless I'm missing something, cycles increments regardless of what
> the software is doing, so you get those interrupts no matter what is happening in software.
> 
> If I'm right about cycles incrementing at a fixed rate, then the -c <sample_period> option will result
> in a sampling interrupt at a fixed frequency.  If the clock rate is known, then converting sample_period
> to sample frequency and vice versa should be simple.  And yet, -F <freq> seems to do something quite
> different than -c <sample_period>.
> 
>> If you have a process that has a lot of idle time then maybe -c
>> is better than -F. It also sounds like you are looking for a wall
>> clock time profiler which perf isn't.
> 
> I am profiling a multithreaded application running on a quad core processor. I mainly just want to
> make sure I understand what perf is actually doing so I know how to interpret the results. I know what
> the results from a fixed sampling period mean, but I'm having a hard time wrapping my head around
> what the results from -F mean. This guy: http://sandsoftwaresound.net/perf/perf-tut-profile-hw-events
> seems to have come to the same conclusion.
> 
> I am already using -a.

In that case it does change some of my assumptions. But for this part of your message:

    > A "perf stat sleep 1" on the system I'm interested in says:

    >            1630370      cycles                    #    1.315 GHz

    > As I understand it, the cycles event is used by default, so a 100 Hz sample frequency should give the same results as a 13150000 cycles sample period.

That command is not system wide or per-CPU which is what my assumption was based one (it's per process
mode). So it's not 1.6M cycles in 1 second, it's 1.6M cycles of when the sleep process was actively
launching and running, excluding the 1s of sleep. System wide would be 'perf stat -a -- sleep 1'

If you do some busy wait for 1 second you'd see significantly more cycles counted:

    ./perf stat -- stress -c 1 --timeout 1

     Performance counter stats for 'stress -c 1 --timeout 1':

                995.68 msec task-clock:u              #    0.992 CPUs utilized                          
         3,705,040,713      cycles:u                  #    3.721 GHz     

> 
> Since most or all of this discussion seems to hinge on what happens when a core is idle, this
> https://www.brendangregg.com/perf.html#FlameGraphs might be relevant.  It contains some
> mention of filtering out cpu_idle samples:
> 
>     I frequently elide the cpu_idle threads in this way, to focus on the real threads that are consuming CPU resources
>     If I miss this step, the cpu_idle threads can often dominate the flame graph, squeezing the interesting code paths.
> 
> I don't see a lot of cpu_idle samples so maybe this is obsolete but it does imply that perf record -F did at one time
> generate lots of idle samples.
> 
> Regards,
> Doug
