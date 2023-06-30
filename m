Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30453EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 15:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjF3PcV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF3PcE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 11:32:04 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33E4EE8
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:30:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4007b5bafceso244651cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688139037; x=1690731037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZy2BaVaWuZffaOOd7cOg1CVIBLJx/tbSfbjp85GUCA=;
        b=HC40wSt7LNyHtVPlU4DVW0ebUza1IA7T6NwFYOjB0ZOWb1ZT1yiGAKQWjXZEHZqWxR
         HXLj/7pWSB0EMmuK4etlImYIKkIVeLgK9U0IUjLE+p43qXyYKXP2CbmO9HiBhV7iVb6j
         KO6UEeicBzpbBU2u/dWqEu4K3tcQ8OQhAiNzQWDT/q/J/y2cGE+sn/WipF67hzTB1xs+
         I66dl0VdQ6BhSHhTxoBfwDh095zscKY7g2BMQ55IEkG8Luo7pZJXiOuh0j7DFwxI4Rvl
         6o1l251z9VBxbKiXYuy1WdHWmX6cqfkLyyJcCQNmbIoIU3HmM7gdLvGfOPKoJfu4hr4Q
         +P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139037; x=1690731037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZy2BaVaWuZffaOOd7cOg1CVIBLJx/tbSfbjp85GUCA=;
        b=Za/BldEMgi2BtAzM73y+gbCr9zagNjJU52RrFZEBggh0AdYRa69nSN46whuyGY+OP3
         1czKt2KjJprApjRVN2jiSwy1fQlyKQQLRjPwYAhLEX3WeSPnoO1t1IQUoWHuetwSDNoB
         aszMILW4C3NGZBHJYHj/vcecQ27WJ4W8SVZXeEsG0H1SOpQ/DtqryCqyP3uqzg6nA8Gu
         /oGQm2/riCNur1dKO6UxBE6sBaMHpkCzUl43R0X3ERqQPIjbKLqqxLCwbUBmvcNxGIPE
         n6KxKYNmT06heI6B5nA/THtgVXCHi/KL1QTsvjZaDZWfzXkRv/umdN2oUCtIlHlMvP+4
         18GQ==
X-Gm-Message-State: AC+VfDy80rcL2G1UI141JfWQxPBDdgAy2UHn+ltZvAt8AU4hS6pSSKUG
        5SFCLDM8WWSuW2CG81Sr+6oWyjG00o23DwpYAlPZeg==
X-Google-Smtp-Source: ACHHUZ6NJ906lAUQuUdQqe6w79UtcgA7fStPxhtW6UVETZHjT/ZtWEPLZUAAl1of7I4SWx1Pmk8j7TAkwiJBfltmFm4=
X-Received: by 2002:a05:622a:14a:b0:3ed:210b:e698 with SMTP id
 v10-20020a05622a014a00b003ed210be698mr905261qtw.7.1688139037218; Fri, 30 Jun
 2023 08:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com> <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <f1cfdc5d-19df-5d71-15c4-59af06dd3d28@arm.com>
In-Reply-To: <f1cfdc5d-19df-5d71-15c4-59af06dd3d28@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 08:30:25 -0700
Message-ID: <CAP-5=fXwdc4VK=6dEoD4V0Jp+unYghWYTfbN4ER2aYd9R52W1g@mail.gmail.com>
Subject: Re: perf-tools-next: Request for testing hybrid changes
To:     James Clark <james.clark@arm.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 29, 2023 at 4:14=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 23/06/2023 15:30, Ian Rogers wrote:
> > On Fri, Jun 23, 2023 at 1:42=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> >>
> >>
> >>
> >> On 22/06/2023 21:15, Ian Rogers wrote:
> >>> On Thu, Jun 22, 2023 at 11:57=E2=80=AFAM Namhyung Kim <namhyung@gmail=
.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> In this development cycle, we've got a big change in how to handle
> >>>> heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
> >>>> but caused some troubles on others.  So I'd like to confirm it works
> >>>> on major platforms without problems.  Especially on ARM64 as it has
> >>>> the big.LITTLE CPUs.
> >>>
> >>>
> >>> Thanks Namhyung. I believe there is a change on ARM64 that makes a
> >>> problem of one type into a slightly different problem. The perf parse
> >>> events logic handles events certain known hardware events using known
> >>> numeric encodings, for example, the cycles event has a type of 0
> >>> (PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n286
> >>>
> >>> The perf_event_open syscall can specify a CPU number of -1 for any. M=
y
> >>> understanding is that -1 on ARM translates into choose the PMU of the
> >>> current running thread, this means that if a thread migrates from
> >>> between core/PMU types it won't be recorded on the alternate PMU type=
.
> >>>
> >>> The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
> >>> this, but appears not to be set on ARM's PMU:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/driv=
ers/perf/arm-cmn.c#n2291
> >>> Could an ARM64 related person fix this?
> >>>
> >>
> >> Yes I was planning to look into this since this thread [1].
> >> It seems like there are still some test failures on Juno which I'm
> >> working through now, even after the fix in that thread. And I was
> >> thinking that it should be possible to support
> >> PERF_PMU_CAP_EXTENDED_HW_TYPE on Arm too.
> >
> > Thanks James, my memory of Juno boards was early bring up work and I
> > don't recall them having heterogeneous PMUs. Presumably this is
>
> Juno does seem to report two PMU types:
>
>    ls /sys/bus/event_source/devices/
>    ...
>    armv8_cortex_a53  armv8_cortex_a57
>    ...
>
> > another issue, I'm happy to help if you can share more details.
>
> So it looks like the failure starts at commit 8bc75f699c14 ("perf
> parse-events: Support wildcards on raw events"). test__checkevent_raw()
> is looking for PERF_TYPE_RAW at this point, but the commit has changed
> the opened event to be whatever PMU it found (type 8 on n1sdp for
> example) instead of PERF_TYPE_RAW (4) which causes the test to fail.
>
> Then looking at the latest perf-tools-next (ad5f604e186a), now the event
> opened goes back to PERF_TYPE_RAW again, but test__checkevent_raw() is
> testing for a real PMU type. None of the PMUs have raw type so the test
> still fails.
>
> This is all on N1SDP which only has one PMU type so
> perf_pmus__supports_extended_type() returns false.
>
> On Juno it's similar, but perf_pmus__supports_extended_type() isn't
> called for the raw test for some reason. It doesn't get hit until the
> "instructions" and test__checkevent_symbolic_name() test later. I saw
> this because I was looking into Arnaldo's suggestion to hard code a
> return false for arm there. But it doesn't fix the test failures for
> either platform.
>
> The failures do look slightly different depending on whether there are
> heterogeneous PMUs or not, so maybe there are two problems to fix. Here
> are the full outputs of the test from both platforms. But I can't really
> think what the fix should be (assuming we should first fix it without
> looking at PERF_PMU_CAP_EXTENDED_HW_TYPE yet).
>
> N1SDP (only the raw test fails):
>
>  $ ls /sys/bus/event_source/devices/
>  ...
>  armv8_pmuv3_0
>  ...
>
>  $ ./perf test "Test event parsing" -vvv
>      6: Parse event definition strings                                  :
>     6.1: Test event parsing                                            :
>   --- start ---
>   test child forked, pid 21636
>   running test 0 'syscalls:sys_enter_openat'
>   Using CPUID 0x00000000410fd0c0
>   running test 1 'syscalls:*'
>   running test 2 'r1a'
>   FAILED tests/parse-events.c:123 No PMU found for type
>   Event test failure: test 2 'r1a'running test 3 '1:1'
>   running test 4 'instructions'
>   running test 5 'cycles/period=3D100000,config2/'
>   running test 6 'faults'
>   running test 7 'L1-dcache-load-miss'
>   running test 8 'mem:0'
>   running test 9 'mem:0:x'
>   running test 10 'mem:0:r'
>   running test 11 'mem:0:w'
>   running test 12 'syscalls:sys_enter_openat:k'
>   running test 13 'syscalls:*:u'
>   running test 14 'r1a:kp'
>   FAILED tests/parse-events.c:123 No PMU found for type
>   Event test failure: test 14 'r1a:kp'running test 15 '1:1:hp'
>   running test 16 'instructions:h'
>   running test 17 'faults:u'
>   running test 18 'L1-dcache-load-miss:kp'
>   running test 19 'mem:0:u'
>   running test 20 'mem:0:x:k'
>   running test 21 'mem:0:r:hp'
>   running test 22 'mem:0:w:up'
>   running test 23 'r1,syscalls:sys_enter_openat:k,1:1:hp'
>   running test 24 'instructions:G'
>   running test 25 'instructions:H'
>   running test 26 'mem:0:rw'
>   running test 27 'mem:0:rw:kp'
>   running test 28 '{instructions:k,cycles:upp}'
>   running test 29 '{faults:k,cache-references}:u,cycles:k'
>   running test 30
> 'group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,ins=
tructions:u'
>   running test 31 '{cycles:u,instructions:kp}:p'
>   running test 32 '{cycles,instructions}:G,{cycles:G,instructions:G},cycl=
es'
>   running test 33 '*:*'
>   running test 34 '{cycles,cache-misses:G}:H'
>   running test 35 '{cycles,cache-misses:H}:G'
>   running test 36 '{cycles:G,cache-misses:H}:u'
>   running test 37 '{cycles:G,cache-misses:H}:uG'
>   running test 38 '{cycles,cache-misses,branch-misses}:S'
>   running test 39 '{instructions,branch-misses}:Su'
>   running test 40 'instructions:uDp'
>   running test 41 '{cycles,cache-misses,branch-misses}:D'
>   running test 42 'mem:0/1'
>   running test 43 'mem:0/2:w'
>   running test 44 'mem:0/4:rw:u'
>   running test 45 'instructions:I'
>   running test 46 'instructions:kIG'
>   running test 47 'task-clock:P,cycles'
>   running test 48 'instructions/name=3Dinsn/'
>   running test 49 'r1234/name=3Drawpmu/'
>   running test 50 '4:0x6530160/name=3Dnumpmu/'
>   running test 51 'L1-dcache-misses/name=3Dcachepmu/'
>   running test 52 'intel_pt//u'
>   ... SKIP
>   running test 53
> 'cycles/name=3D'COMPLEX_CYCLES_NAME:orig=3Dcycles,desc=3Dchip-clock-ticks=
'/Duk'
>   running test 54 'cycles//u'
>   running test 55 'cycles:k'
>   running test 56 'instructions:uep'
>   running test 57 '{cycles,cache-misses,branch-misses}:e'
>   running test 58 'cycles/name=3Dname/'
>   running test 59 'cycles/name=3Dl1d/'
>   running test 60 'mem:0/name=3Dbreakpoint/'
>   running test 61 'mem:0:x/name=3Dbreakpoint/'
>   running test 62 'mem:0:r/name=3Dbreakpoint/'
>   running test 63 'mem:0:w/name=3Dbreakpoint/'
>   running test 64 'mem:0/name=3Dbreakpoint/u'
>   running test 65 'mem:0:x/name=3Dbreakpoint/k'
>   running test 66 'mem:0:r/name=3Dbreakpoint/hp'
>   running test 67 'mem:0:w/name=3Dbreakpoint/up'
>   running test 68 'mem:0:rw/name=3Dbreakpoint/'
>   running test 69 'mem:0:rw/name=3Dbreakpoint/kp'
>   running test 70 'mem:0/1/name=3Dbreakpoint/'
>   running test 71 'mem:0/2:w/name=3Dbreakpoint/'
>   running test 72 'mem:0/4:rw/name=3Dbreakpoint/u'
>   running test 73 'mem:0/1/name=3Dbreakpoint1/,mem:0/4:rw/name=3Dbreakpoi=
nt2/'

I saw the raw encoding issue on my Raspberry Pi. I also saw a lot of
libtraceevent errors. This is concerning me and we need to get a fix
for 6.5.

> Juno:
>
>   (/sys/bus/event_source/devices/ output above)
>
>       3: Parse event definition strings                                  =
:
>     3.1: Test event parsing                                            :
>   --- start ---
>   running test 0 'r1a'
>   Using CPUID 0x00000000410fd070
>   FAILED tests/parse-events.c:123 No PMU found for type
>   Event test failure: test 0 'r1a'running test 1 '1:1'
>   running test 2 'instructions'
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0x800000000
>     disabled                         1
>   ------------------------------------------------------------

Here the config has the extended type in it but because ARM PMU's
heterogeneous PMUs aren't  supporting that we get divergence. I think
this is a legitimate failure until ARM's PMU driver is fixed to enable
the extended type information. We can make the test robust to this,
but it is probably a good idea to red flag the ARM PMU being wrong.

>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -2
>   running test 3 'cycles/period=3D100000,config2/'
>   running test 4 'faults'
>   running test 5 'L1-dcache-load-miss'
>   running test 6 'mem:0'
>   running test 7 'mem:0:x'
>   running test 8 'mem:0:r'
>   running test 9 'mem:0:w'
>   running test 10 'r1a:kp'
>   FAILED tests/parse-events.c:123 No PMU found for type
>   Event test failure: test 10 'r1a:kp'running test 11 '1:1:hp'
>   running test 12 'instructions:h'
>   FAILED tests/parse-events.c:329 wrong number of entries
>   Event test failure: test 12 'instructions:h'running test 13 'faults:u'
>   running test 14 'L1-dcache-load-miss:kp'
>   running test 15 'mem:0:u'
>   running test 16 'mem:0:x:k'
>   running test 17 'mem:0:r:hp'
>   running test 18 'mem:0:w:up'
>   running test 19 'instructions:G'
>   running test 20 'instructions:H'
>   running test 21 'mem:0:rw'
>   running test 22 'mem:0:rw:kp'
>   running test 23 '{instructions:k,cycles:upp}'
>   FAILED tests/parse-events.c:832 wrong number of entries
>   Event test failure: test 23 '{instructions:k,cycles:upp}'running test

These failures will relate to not opening enough events, there should
be one instructions and cycles event/evsel (both legacy types) per
PMU. Similarly below. All these failures will relate to the extended
type divergence, could this be a priority for someone, ARM, Linaro..
to look at? I'm happy to send emails, be on a call, etc.

Thanks,
Ian

> 24 '{faults:k,cache-references}:u,cycles:k'
>   FAILED tests/parse-events.c:875 wrong number of entries
>   Event test failure: test 24
> '{faults:k,cache-references}:u,cycles:k'running test 25
> '{cycles:u,instructions:kp}:p'
>   FAILED tests/parse-events.c:1041 wrong number of entries
>   Event test failure: test 25 '{cycles:u,instructions:kp}:p'running test
> 26 '{cycles,instructions}:G,{cycles:G,instructions:G},cycles'
>   FAILED tests/parse-events.c:1086 wrong number of entries
>   Event test failure: test 26
> '{cycles,instructions}:G,{cycles:G,instructions:G},cycles'running test
> 27 '{cycles,cache-misses:G}:H'
>   FAILED tests/parse-events.c:1172 wrong number of entries
>   Event test failure: test 27 '{cycles,cache-misses:G}:H'running test 28
> '{cycles,cache-misses:H}:G'
>   FAILED tests/parse-events.c:1213 wrong number of entries
>   Event test failure: test 28 '{cycles,cache-misses:H}:G'running test 29
> '{cycles:G,cache-misses:H}:u'
>   FAILED tests/parse-events.c:1254 wrong number of entries
>   Event test failure: test 29 '{cycles:G,cache-misses:H}:u'running test
> 30 '{cycles:G,cache-misses:H}:uG'
>   FAILED tests/parse-events.c:1295 wrong number of entries
>   Event test failure: test 30 '{cycles:G,cache-misses:H}:uG'running test
> 31 '{cycles,cache-misses,branch-misses}:S'
>   FAILED tests/parse-events.c:1336 wrong number of entries
>   Event test failure: test 31
> '{cycles,cache-misses,branch-misses}:S'running test 32
> '{instructions,branch-misses}:Su'
>   FAILED tests/parse-events.c:1388 wrong number of entries
>   Event test failure: test 32 '{instructions,branch-misses}:Su'running
> test 33 'instructions:uDp'
>   FAILED tests/parse-events.c:1427 wrong number of entries
>   Event test failure: test 33 'instructions:uDp'running test 34
> '{cycles,cache-misses,branch-misses}:D'
>   FAILED tests/parse-events.c:1445 wrong number of entries
>   Event test failure: test 34
> '{cycles,cache-misses,branch-misses}:D'running test 35 'mem:0/1'
>   running test 36 'mem:0/2:w'
>   running test 37 'mem:0/4:rw:u'
>   running test 38 'instructions:I'
>   running test 39 'instructions:kIG'
>   running test 40 'task-clock:P,cycles'
>   FAILED tests/parse-events.c:1564 wrong number of entries
>   Event test failure: test 40 'task-clock:P,cycles'running test 41
> 'instructions/name=3Dinsn/'
>   running test 42 'r1234/name=3Drawpmu/'
>   running test 43 '4:0x6530160/name=3Dnumpmu/'
>   running test 44 'L1-dcache-misses/name=3Dcachepmu/'
>   running test 45 'intel_pt//u'
>   ... SKIP
>   running test 46
> 'cycles/name=3D'COMPLEX_CYCLES_NAME:orig=3Dcycles,desc=3Dchip-clock-ticks=
'/Duk'
>   running test 47 'cycles//u'
>   running test 48 'cycles:k'
>   running test 49 'instructions:uep'
>   running test 50 '{cycles,cache-misses,branch-misses}:e'
>   FAILED tests/parse-events.c:1490 wrong number of entries
>   Event test failure: test 50
> '{cycles,cache-misses,branch-misses}:e'running test 51 'cycles/name=3Dnam=
e/'
>   running test 52 'cycles/name=3Dl1d/'
>   running test 53 'mem:0/name=3Dbreakpoint/'
>   running test 54 'mem:0:x/name=3Dbreakpoint/'
>   running test 55 'mem:0:r/name=3Dbreakpoint/'
>   running test 56 'mem:0:w/name=3Dbreakpoint/'
>   running test 57 'mem:0/name=3Dbreakpoint/u'
>   running test 58 'mem:0:x/name=3Dbreakpoint/k'
>   running test 59 'mem:0:r/name=3Dbreakpoint/hp'
>   running test 60 'mem:0:w/name=3Dbreakpoint/up'
>   running test 61 'mem:0:rw/name=3Dbreakpoint/'
>   running test 62 'mem:0:rw/name=3Dbreakpoint/kp'
>   running test 63 'mem:0/1/name=3Dbreakpoint/'
>   running test 64 'mem:0/2:w/name=3Dbreakpoint/'
>   running test 65 'mem:0/4:rw/name=3Dbreakpoint/u'
>   running test 66 'mem:0/1/name=3Dbreakpoint1/,mem:0/4:rw/name=3Dbreakpoi=
nt2/'
>
>
> >
> > It is great that you'll look to add PERF_PMU_CAP_EXTENDED_HW_TYPE,
> > there is also the legacy kernel issue. Do you have a plan there or
> > should supporting PERF_PMU_CAP_EXTENDED_HW_TYPE be the plan? As the
> > Linux 6.5 merge window will open soon I'm concerned that these fixes
> > may only make it into 6.6. Should we do anything short-term for 6.5?
> > For example, if extended types aren't supported then disable the
> > wildcard matching of PMUs in the "numeric", really PERF_TYPE_HARDWARE
> > and PERF_TYPE_HW_CACHE, cases?
> >
> > Thanks,
> > Ian
> >
> >> [1]: https://lore.kernel.org/all/ZIxza13x+AwApbQb@kernel.org/
> >>
> >>> The perf tool is expecting it to be supported and so it tries to open
> >>> the event for each core PMU, so the cycles event will open for each o=
f
> >>> a BIG.little PMU, however, as the extended type isn't supported the
> >>> same event will be opened twice and the migration problem still
> >>> exists. This problem exists for all PERF_TYPE_HARDWARE events (10) an=
d
> >>> all PERF_TYPE_HW_CACHE events (42).
> >>>
> >>> Assuming the capability issue is fixed, there is still an open issue
> >>> about how to properly support these 52 events on older kernels. It
> >>> would be possible to use the architecture standard events, so cycles
> >>> can map to cpu_cycles, instructions to sw_incr, cache-references to
> >>> l1d_cache (probably), etc. I'm not sure this will work for all 52
> >>> events and the plumbing in the perf tool isn't straightforward.
> >>> There's also the question of whether such a change of events should
> >>> happen when we know the perf_event_open will be given a CPU, should
> >>> that case not wildcard PMUs?>
> >>> I'm happy to provide more context/details.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> Also we are transitioning from Arnaldo's tree to new repositories in
> >>>> git.kernel.org:
> >>>>
> >>>>  * kernel/git/perf/perf-tools (for the fixes on the current dev cycl=
e)
> >>>>  * kernel/git/perf/perf-tools-next (for new features for the next cy=
cle)
> >>>>
> >>>> There is a branch with the same name.  Please check out
> >>>> perf-tools-next and play with it.
> >>>>
> >>>> Thanks,
> >>>> Namhyung
