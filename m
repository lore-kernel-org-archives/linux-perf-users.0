Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71560C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED7061179
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbhIIUXk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233423AbhIIUXi (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 16:23:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C9E56115A;
        Thu,  9 Sep 2021 20:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631218948;
        bh=Or0vIP8ALSj1Mvi1ASB4Tok+D+dYVvjV/glrtPzu3Qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4cgwD5UeJyAN/u5Ec4uHnHbpvGBL8JR4yzDxVAQeljVmRSWsvuHgIdxPOXEUJmeY
         C1C2vSeOf926TooCP9UM/8/aIvgWdzHnRp+/tPlzC4vZ2YnSg5TG//FSkQ+V/Imzvs
         KJcovQ6nCC1ot2/KBdGL1/Ji47KVM8FZ46Iuq4Ek6K7px/7GoY7YUNNdewyMEaNr39
         WN/YcV703MrONBg5gDN7tWFS3lPGzzl1Bd6z3jw1q6DBxkmcyx9AnINpBWLVOKCY/I
         j5Ekwyl6cWZg5ZuVOf3TI9yjfYthgueW6bN1pVo+BUI/3x1Nwip0VlvnHMmWE3haW+
         oIyb4hS2EISAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE3794038F; Thu,  9 Sep 2021 17:22:25 -0300 (-03)
Date:   Thu, 9 Sep 2021 17:22:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: Reducing impact of IO/CPU overload during `perf record` - bad
 handling of excessive yield?
Message-ID: <YTptAbQgae5HEgAU@kernel.org>
References: <9270373.m2mTvpyXtE@milian-workstation>
 <CAP-5=fVM8oxmMzx4VhoCPp=t=vR3W-MT72MRL7pVsjJR9YtxXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVM8oxmMzx4VhoCPp=t=vR3W-MT72MRL7pVsjJR9YtxXA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 09, 2021 at 12:28:10PM -0700, Ian Rogers escreveu:
> On Thu, Sep 9, 2021 at 7:14 AM Milian Wolff <milian.wolff@kdab.com> wrote:
> >
> > Hey there!
> >
> > I'm trying to profile an application that suffers from overcommit and
> > excessive calls to `yield` (via OMP). Generally, it is putting a lot of strain
> > on the system. Sadly, I cannot make `perf record` work without dropping (a lot
> > of) chunks / events.
> >
> > Usually I'm using this command line:
> >
> > ```
> > perf record --call-graph dwarf -z -m 16M ...
> > ```
> >
> > But this is not enough in this case. What other alternatives are there? Is
> > there a `perf record` mode which never drops events, at the cost of maybe
> > stalling the profiled application?

There was discussion about this mode, for using on a 'perf trace' that
works like 'strace', i.e. doesn't lose records but stalls the
profiled/traced application, but I don't think that progressed

> > Generally though, looking at the (partial) data I get from perf, it seems like
> > it does not cope well in the face of excessive calls to `yield`. Take this
> > example code here:
> >
> > ```
> > #include <thread>
> > #include <vector>
> > #include <algorithm>
> >
> > void yieldALot()
> > {
> >     for (int i = 0; i < 1000000; ++i) {
> >         std::this_thread::yield();
> >     }
> > }
> >
> > int main()
> > {
> >     std::vector<std::thread> threads(std::thread::hardware_concurrency() * 2);
> >     std::generate(threads.begin(), threads.end(), []() {
> >         return std::thread(&yieldALot);
> >     });
> >
> >     for (auto &thread : threads)
> >         thread.join();
> >
> >     return 0;
> > }
> > ```
> >
> > When I compile this with `g++ test.cpp -pthread -O2 -g` and run it on my
> > system with a AMD Ryzen 9 3900X with 12 cores and 24 SMT cores, then I observe
> > the following behavior:
> >
> > ```
> > perf stat -r 5 ./a.out
> >
> >  Performance counter stats for './a.out' (5 runs):
> >
> >          18,570.71 msec task-clock                #   19.598 CPUs utilized
> > ( +-  1.27% )
> >          2,717,136      context-switches          #  145.447 K/sec
> > ( +-  3.26% )
> >                 55      cpu-migrations            #    2.944 /sec
> > ( +-  3.79% )
> >                222      page-faults               #   11.884 /sec
> > ( +-  0.49% )
> >     61,223,010,902      cycles                    #    3.277 GHz
> > ( +-  0.54% )  (83.33%)
> >      1,259,821,397      stalled-cycles-frontend   #    2.07% frontend cycles
> > idle     ( +-  1.54% )  (83.16%)
> >      9,001,394,333      stalled-cycles-backend    #   14.81% backend cycles
> > idle      ( +-  0.79% )  (83.25%)
> >     65,746,848,695      instructions              #    1.08  insn per cycle
> >                                                   #    0.14  stalled cycles
> > per insn  ( +-  0.26% )  (83.40%)
> >     14,474,862,454      branches                  #  774.830 M/sec
> > ( +-  0.36% )  (83.49%)
> >        114,518,545      branch-misses             #    0.79% of all branches
> > ( +-  0.71% )  (83.67%)
> >
> >            0.94761 +- 0.00935 seconds time elapsed  ( +-  0.99% )
> > ```
> >
> > Now compare this to what happens when I enable perf recording:
> >
> > ```
> >  Performance counter stats for 'perf record --call-graph dwarf -z ./a.out' (5
> > runs):
> >
> >          19,928.28 msec task-clock                #    9.405 CPUs utilized
> > ( +-  2.74% )
> >          3,026,081      context-switches          #  142.538 K/sec
> > ( +-  7.48% )
> >                120      cpu-migrations            #    5.652 /sec
> > ( +-  3.18% )
> >              5,509      page-faults               #  259.491 /sec
> > ( +-  0.01% )
> >     65,393,592,529      cycles                    #    3.080 GHz
> > ( +-  1.81% )  (71.81%)
> >      1,445,203,862      stalled-cycles-frontend   #    2.13% frontend cycles
> > idle     ( +-  2.01% )  (71.60%)
> >      9,701,321,165      stalled-cycles-backend    #   14.29% backend cycles
> > idle      ( +-  1.28% )  (71.62%)
> >     69,967,062,730      instructions              #    1.03  insn per cycle
> >                                                   #    0.14  stalled cycles
> > per insn  ( +-  0.74% )  (71.83%)
> >     15,376,981,968      branches                  #  724.304 M/sec
> > ( +-  0.83% )  (72.00%)
> >        127,934,194      branch-misses             #    0.81% of all branches
> > ( +-  1.29% )  (72.07%)
> >
> >           2.118881 +- 0.000496 seconds time elapsed  ( +-  0.02% )
> > ```
> >
> > Note how the CPU utilization drops dramatically by roughly a factor of 2x,
> > which correlates with the increase in overall runtime.
> >
> > From the data obtained here I see:
> > ```
> >     98.49%     0.00%  a.out    libc-2.33.so        [.] __GI___sched_yield
> > (inlined)
> >             |
> >             ---__GI___sched_yield (inlined)
> >                |
> >                |--89.93%--entry_SYSCALL_64_after_hwframe
> >                |          |
> >                |           --89.32%--do_syscall_64
> >                |                     |
> >                |                     |--71.70%--__ia32_sys_sched_yield
> >                |                     |          |
> >                |                     |          |--64.36%--schedule
> >                |                     |          |          |
> >                |                     |          |           --63.42%--
> > __schedule
> >                |                     |          |                     |
> >                |                     |          |
> > |--32.56%--__perf_event_task_sched_out
> >                |                     |          |                     |
> > |
> >                |                     |          |                     |
> > --32.07%--amd_pmu_disable_all
> >                |                     |          |                     |
> > |
> >                |                     |          |                     |
> > |--23.54%--x86_pmu_disable_all
> >                |                     |          |                     |
> > |          |
> >                |                     |          |                     |
> > |          |--12.81%--native_write_msr
> >                |                     |          |                     |
> > |          |
> >                |                     |          |                     |
> > |          |--8.24%--native_read_msr
> >                |                     |          |                     |
> > |          |
> >                |                     |          |                     |
> > |           --1.25%--amd_pmu_addr_offset
> >                |                     |          |                     |
> > |
> >                |                     |          |                     |
> > --8.19%--amd_pmu_wait_on_overflow
> >                |                     |          |                     |
> > |
> >                |                     |          |                     |
> > |--5.00%--native_read_msr
> >                |                     |          |                     |
> > |
> >                |                     |          |                     |
> > |--2.20%--delay_halt
> >                |                     |          |                     |
> > |          |
> >                |                     |          |                     |
> > |           --1.99%--delay_halt_mwaitx
> >                |                     |          |                     |
> > |
> >                |                     |          |                     |
> > --0.55%--amd_pmu_addr_offset
> >
> > ```
> >
> > Is this a dificiency with the AMD perf subsystem? Or is this a generic issue
> > with perf? I understand that it has to enable/disable the PMU when it's
> > switching tasks, but potentially there are some ways to optimize this
> > behavior?
> 
> Hi Milian,
> 
> By using dwarf call graphs your samples are writing a dump of the
> stack into the perf event ring buffer that will be processed in the
> userspace perf command. The default stack dump size is 8kb and you can
> lower it - for example with "--call-graph dwarf,4096". I suspect that
> most of the overhead you are seeing is from these stack dumps. There
> is a more complete description in the man page:
> https://man7.org/linux/man-pages/man1/perf-record.1.htm
> 
> Which are always worth improving:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Documentation/perf-record.txt?h=perf/core
> 
> Thanks,
> Ian
> > Thanks
> >
> > --
> > Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> > KDAB (Deutschland) GmbH, a KDAB Group company
> > Tel: +49-30-521325470
> > KDAB - The Qt, C++ and OpenGL Experts

-- 

- Arnaldo
