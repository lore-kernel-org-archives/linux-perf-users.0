Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF5EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 17:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFWR71 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjFWR7S (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 13:59:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FE12705
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 10:59:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so26021cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687543154; x=1690135154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dauub4fy8fAjPddBQvVt/gg/k3CBfzroXvh7UP+1NXc=;
        b=kbsXH2gQYLsTS65733T9waTclMjH7JuAs0n1PferyWuHNz3WpIcFg8Yjdf2rWS0yFR
         iFCyFMpZDfm86ucvSp6kkKNo9rOqaWWMzeyiB2Rz2QvsIyaYBKtwYWL466aDownUv5TF
         WaHaBUW5myamL7TVGHy+NLhHxd6pme8pPrrMB2hAzkXVg+7ofjVpyjPxCAPvvxztdEdc
         q30Xfj4B2AOK5zwhnbaNBhLwQ3kahguN0KBQpr9RpwAvLtVwz55B8s4tYEjN2hP39lYf
         ppDzHAQZbSKPixBwIzo9W2e0ZoD9mQY22b2dSovuMUCFAENqkSgyW2Mj5QcAYiqSbSZF
         asKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543154; x=1690135154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dauub4fy8fAjPddBQvVt/gg/k3CBfzroXvh7UP+1NXc=;
        b=LcqDFLPZeglNZ6xIEQTR/q0oFa1aA0YuQb6X5ysxg2iCHEiV54dZZ4LhUevQtVWvmA
         pVUMk34L9UYX1lJ/t+0o2S/nxs8RSEewnRMgMGf+Vj4aNN4eNmFk8e6UZ6WcUpAdu1hA
         Et4YLqf1QM4di26nL+XU9HiUpYbXytV8FCgHk+lO0Ny59PDflM9/PqO3WT/5J70B7tdx
         m8Yb+nWlqa00p0mRWMb7bJOXb2xXmQimB0tLW+W9OiaVMb5+imyA5xjEWHADm/+EZCWW
         WDiQ8OqTzHHA23jTJpQG2bF4Wg2zDHXsLlR2xAE2Z+R/hJ8DLS8b6ClJsy8i30ZncB7t
         H1hg==
X-Gm-Message-State: AC+VfDy2neisZauXaZWPz/P5S4kjooZOwW4xjnjM+GsuAABUCCKHw2Jk
        66q3hjiAtyYy8NkCwiCUZV+/ZCV8Asn0MtjxsXycsQ==
X-Google-Smtp-Source: ACHHUZ4oimnNX7RuwISJD2na3sn2NCAjEF3IuHcPRE3saPhZqfQ9Hac6v+ebGZGwcbLTagJmxxr5jrW6fjol5Yd/4Ao=
X-Received: by 2002:a05:622a:15c2:b0:3f8:5b2:aef5 with SMTP id
 d2-20020a05622a15c200b003f805b2aef5mr200221qty.29.1687543153634; Fri, 23 Jun
 2023 10:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com> <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
In-Reply-To: <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 10:59:02 -0700
Message-ID: <CAP-5=fVjtvxOqNnbLJ_tbv=Ld0sX07DYa7TFyTRyBoPNm1t-zQ@mail.gmail.com>
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

On Fri, Jun 23, 2023 at 7:30=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jun 23, 2023 at 1:42=E2=80=AFAM James Clark <james.clark@arm.com>=
 wrote:
> >
> >
> >
> > On 22/06/2023 21:15, Ian Rogers wrote:
> > > On Thu, Jun 22, 2023 at 11:57=E2=80=AFAM Namhyung Kim <namhyung@gmail=
.com> wrote:
> > >>
> > >> Hello,
> > >>
> > >> In this development cycle, we've got a big change in how to handle
> > >> heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
> > >> but caused some troubles on others.  So I'd like to confirm it works
> > >> on major platforms without problems.  Especially on ARM64 as it has
> > >> the big.LITTLE CPUs.
> > >
> > >
> > > Thanks Namhyung. I believe there is a change on ARM64 that makes a
> > > problem of one type into a slightly different problem. The perf parse
> > > events logic handles events certain known hardware events using known
> > > numeric encodings, for example, the cycles event has a type of 0
> > > (PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n286
> > >
> > > The perf_event_open syscall can specify a CPU number of -1 for any. M=
y
> > > understanding is that -1 on ARM translates into choose the PMU of the
> > > current running thread, this means that if a thread migrates from
> > > between core/PMU types it won't be recorded on the alternate PMU type=
.
> > >
> > > The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
> > > this, but appears not to be set on ARM's PMU:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/driv=
ers/perf/arm-cmn.c#n2291
> > > Could an ARM64 related person fix this?
> > >
> >
> > Yes I was planning to look into this since this thread [1].
> > It seems like there are still some test failures on Juno which I'm
> > working through now, even after the fix in that thread. And I was
> > thinking that it should be possible to support
> > PERF_PMU_CAP_EXTENDED_HW_TYPE on Arm too.
>
> Thanks James, my memory of Juno boards was early bring up work and I
> don't recall them having heterogeneous PMUs. Presumably this is
> another issue, I'm happy to help if you can share more details.
>
> It is great that you'll look to add PERF_PMU_CAP_EXTENDED_HW_TYPE,
> there is also the legacy kernel issue. Do you have a plan there or
> should supporting PERF_PMU_CAP_EXTENDED_HW_TYPE be the plan? As the
> Linux 6.5 merge window will open soon I'm concerned that these fixes
> may only make it into 6.6. Should we do anything short-term for 6.5?
> For example, if extended types aren't supported then disable the
> wildcard matching of PMUs in the "numeric", really PERF_TYPE_HARDWARE
> and PERF_TYPE_HW_CACHE, cases?
>
> Thanks,
> Ian

Not a heterogeneous ARM problem, but a problem potentially added in
perf-tools-next is that we alter groups of events based on a "group
PMU name". This is necessary so we can correctly group events for
metrics where the events require groups. There's some special logic so
that software and aux events behave the correct way:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2051

But ARM PMUs don't appear to set the auxtrace flag:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.h?h=3Dperf-tools-next#n78
which is done for Intel here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/pmu.c?h=3Dperf-tools-next#n32

Thanks,
Ian

> > [1]: https://lore.kernel.org/all/ZIxza13x+AwApbQb@kernel.org/
> >
> > > The perf tool is expecting it to be supported and so it tries to open
> > > the event for each core PMU, so the cycles event will open for each o=
f
> > > a BIG.little PMU, however, as the extended type isn't supported the
> > > same event will be opened twice and the migration problem still
> > > exists. This problem exists for all PERF_TYPE_HARDWARE events (10) an=
d
> > > all PERF_TYPE_HW_CACHE events (42).
> > >
> > > Assuming the capability issue is fixed, there is still an open issue
> > > about how to properly support these 52 events on older kernels. It
> > > would be possible to use the architecture standard events, so cycles
> > > can map to cpu_cycles, instructions to sw_incr, cache-references to
> > > l1d_cache (probably), etc. I'm not sure this will work for all 52
> > > events and the plumbing in the perf tool isn't straightforward.
> > > There's also the question of whether such a change of events should
> > > happen when we know the perf_event_open will be given a CPU, should
> > > that case not wildcard PMUs?>
> > > I'm happy to provide more context/details.
> > >
> > > Thanks,
> > > Ian
> > >
> > >> Also we are transitioning from Arnaldo's tree to new repositories in
> > >> git.kernel.org:
> > >>
> > >>  * kernel/git/perf/perf-tools (for the fixes on the current dev cycl=
e)
> > >>  * kernel/git/perf/perf-tools-next (for new features for the next cy=
cle)
> > >>
> > >> There is a branch with the same name.  Please check out
> > >> perf-tools-next and play with it.
> > >>
> > >> Thanks,
> > >> Namhyung
