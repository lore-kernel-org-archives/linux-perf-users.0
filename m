Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09689EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjFWOcK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjFWObv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 10:31:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661EE3589
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 07:31:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4007b5bafceso202401cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687530664; x=1690122664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5iEOnLk/7Yg3m1qETm1rPlyU0ntsHTbEfYKd49V99c=;
        b=pXhRTUEN7KaWN1R7L/IDA5SpB7cKA2hblbsWUtj2GhvwE3j6sYAiNI4mmQxBElVTbw
         MnWop2KkNf2kj2WXBpEu2FdRCNaf5exGIsvxVFLVafYgMVJM3SYYxAwwaCDfR1FCtNZw
         umOBlVYAuf29wF7NsRSxoSQOmDUKfG8gkQCsl0vQrz1zv5oxmYjvPDAQhJCbhJ5Qgk7t
         Ywvo4bpsMHVoSJ5wIDnLMOkp3dc35PZLICPQWeYjNinGH5xiDMQji+biwcWQUyWtuwWY
         vMA1ZfREy9UAeIB716J8io+rbC/OpqDV7W/t4VZvnmk3ibbXKk7J3GM6xIoy4Uqs6Enp
         fizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530664; x=1690122664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5iEOnLk/7Yg3m1qETm1rPlyU0ntsHTbEfYKd49V99c=;
        b=Py/Q2d2Q9Ncx9Zy1YsEhcYfbeLt1keQD2JZ7olwkLMHD4zUivljUS7Q+HJc1nwuH9p
         XLOBaNw1MEIjjWC9GsYnNiEdAlYP1icpRRvTy4ZH43cRfo4Ty2dh2Bjst5ag6Wkt2JcB
         9bTLyzVDfSbGvGvQtF9UlbCKtvNiziVFW5Y821GVntgWd2OXd5WQ6D+EPeE3Ss/ZXxMC
         mDuglsd1Q9L9F1rChb65bOm7UyO0WQNk34ztyzJgxzH4rHxdB2jg+OTzpFw1xP+N5EeT
         J88kA/7C1ohpd9LfmPbZ+G5IPOOXxKZYrG9YlXlBYoaU49db40KwcZlkodZMuqbia3OZ
         9c3A==
X-Gm-Message-State: AC+VfDwi7hY7bLPJggeU58fYCeAa7SsgseISr1NjmUcTi9kuxOZsRi8s
        7Dv9QJSRcH4/nw0EX8RjCubQb6v/I5jEYDpUvz4ZNg==
X-Google-Smtp-Source: ACHHUZ75VQbe9yBjX4z27ZtI15rJZmQ/Sv9JcPmM0x1u4KcjVRo2Eh0QUO9VXOjdmmSi7YeZCKsAiEjXAZOzDU5wA8g=
X-Received: by 2002:a05:622a:34c:b0:3ef:4319:c6c5 with SMTP id
 r12-20020a05622a034c00b003ef4319c6c5mr110653qtw.19.1687530664484; Fri, 23 Jun
 2023 07:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com> <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
In-Reply-To: <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 07:30:53 -0700
Message-ID: <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
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

On Fri, Jun 23, 2023 at 1:42=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 22/06/2023 21:15, Ian Rogers wrote:
> > On Thu, Jun 22, 2023 at 11:57=E2=80=AFAM Namhyung Kim <namhyung@gmail.c=
om> wrote:
> >>
> >> Hello,
> >>
> >> In this development cycle, we've got a big change in how to handle
> >> heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
> >> but caused some troubles on others.  So I'd like to confirm it works
> >> on major platforms without problems.  Especially on ARM64 as it has
> >> the big.LITTLE CPUs.
> >
> >
> > Thanks Namhyung. I believe there is a change on ARM64 that makes a
> > problem of one type into a slightly different problem. The perf parse
> > events logic handles events certain known hardware events using known
> > numeric encodings, for example, the cycles event has a type of 0
> > (PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n286
> >
> > The perf_event_open syscall can specify a CPU number of -1 for any. My
> > understanding is that -1 on ARM translates into choose the PMU of the
> > current running thread, this means that if a thread migrates from
> > between core/PMU types it won't be recorded on the alternate PMU type.
> >
> > The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
> > this, but appears not to be set on ARM's PMU:
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/driver=
s/perf/arm-cmn.c#n2291
> > Could an ARM64 related person fix this?
> >
>
> Yes I was planning to look into this since this thread [1].
> It seems like there are still some test failures on Juno which I'm
> working through now, even after the fix in that thread. And I was
> thinking that it should be possible to support
> PERF_PMU_CAP_EXTENDED_HW_TYPE on Arm too.

Thanks James, my memory of Juno boards was early bring up work and I
don't recall them having heterogeneous PMUs. Presumably this is
another issue, I'm happy to help if you can share more details.

It is great that you'll look to add PERF_PMU_CAP_EXTENDED_HW_TYPE,
there is also the legacy kernel issue. Do you have a plan there or
should supporting PERF_PMU_CAP_EXTENDED_HW_TYPE be the plan? As the
Linux 6.5 merge window will open soon I'm concerned that these fixes
may only make it into 6.6. Should we do anything short-term for 6.5?
For example, if extended types aren't supported then disable the
wildcard matching of PMUs in the "numeric", really PERF_TYPE_HARDWARE
and PERF_TYPE_HW_CACHE, cases?

Thanks,
Ian

> [1]: https://lore.kernel.org/all/ZIxza13x+AwApbQb@kernel.org/
>
> > The perf tool is expecting it to be supported and so it tries to open
> > the event for each core PMU, so the cycles event will open for each of
> > a BIG.little PMU, however, as the extended type isn't supported the
> > same event will be opened twice and the migration problem still
> > exists. This problem exists for all PERF_TYPE_HARDWARE events (10) and
> > all PERF_TYPE_HW_CACHE events (42).
> >
> > Assuming the capability issue is fixed, there is still an open issue
> > about how to properly support these 52 events on older kernels. It
> > would be possible to use the architecture standard events, so cycles
> > can map to cpu_cycles, instructions to sw_incr, cache-references to
> > l1d_cache (probably), etc. I'm not sure this will work for all 52
> > events and the plumbing in the perf tool isn't straightforward.
> > There's also the question of whether such a change of events should
> > happen when we know the perf_event_open will be given a CPU, should
> > that case not wildcard PMUs?>
> > I'm happy to provide more context/details.
> >
> > Thanks,
> > Ian
> >
> >> Also we are transitioning from Arnaldo's tree to new repositories in
> >> git.kernel.org:
> >>
> >>  * kernel/git/perf/perf-tools (for the fixes on the current dev cycle)
> >>  * kernel/git/perf/perf-tools-next (for new features for the next cycl=
e)
> >>
> >> There is a branch with the same name.  Please check out
> >> perf-tools-next and play with it.
> >>
> >> Thanks,
> >> Namhyung
