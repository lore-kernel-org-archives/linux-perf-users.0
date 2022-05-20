Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A01C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 May 2022 04:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbiETEcO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 May 2022 00:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiETEcM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 May 2022 00:32:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66C57998
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 21:32:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j25so9805161wrc.9
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+yLwX4v2kJDuTdhPmFkHWTh5EbBsLz6n6h1cv0PsHE=;
        b=l4UUOYRepzob/HFyAF2Rl6gwo8FbLs4V2ylF9L4Aele+X1dKOZDCu93dLjeMtJOO28
         QXum7nQMlIz1Mza0YhEnjd38y5eFmyu1Tdi1MnRFBdptOjrMkjdifzIijNlNg+uP3pp4
         cyi1M2xWQGOujm7/0dB18yhCS34gPdxosiotphU+Z8lT4jtoSSWy8ccuKPEq8lxTog3B
         fQcZGa1Z+8hHeXXPrMkYjdh7HeZhmGzDG3rV7RqO7+im6R9JoJ4IJA4lzqVk9XvBrH0J
         xL2sFwmmt1uOjla9JJzKMWXiHh5FTdmAdLZjh3jhAGgVmPk+jsTLKHsOyshYaJvewkre
         xMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+yLwX4v2kJDuTdhPmFkHWTh5EbBsLz6n6h1cv0PsHE=;
        b=77IJfq8857MH4vGdgXAw/Mo8A+oWjjKr3pn7xxp5qJHEmGVRqPMOI8RsOahR3aAIoL
         UhXYIRYYGIpAbHnluoCQQr0LB6C4/m3liWqOnGpAyPbxf9g3RiAL4fFTis+l9PjO9WWZ
         4XgBNrthRo//8igRighjr8TRwDaJ6pH2ZCq3vOuY+s96InTeT2M61Ywo548U1pST6fWX
         YiUeLJZx2P5DLtZZDcGbb8jeqaG/8htEmDhbveVl0c4AAZ3FPW9/LuQ5V3XvOVaQtJRd
         symo6GPT9Db0lMu53WieDQgnvbcb3dd4jAxOlhcZ7/aMSUi1xrUtuS+dzYX0kR0yJX85
         CoUA==
X-Gm-Message-State: AOAM533+IUUcM9If0bdSnL3hmE0cmDhxgItin9daVFs7RlReNCpKggiA
        7Iaaqz0hcz4oajkehgBjVumBmj+1feLTDxIZ8jCzDg==
X-Google-Smtp-Source: ABdhPJwQN/0YILiNXWjmTMiG3mOUXqk0m3Fwxd7G7ym80oOOIkivHTG/LVUHBmB2V75Nev6A+wsACLruMGgRETw9Qlo=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr6647011wrq.654.1653021124626; Thu, 19
 May 2022 21:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-3-ravi.bangoria@amd.com>
 <CAP-5=fXiZj+EBqmg89faK0pZD-Af3V1fHWMOkds1oKoaz+ucFA@mail.gmail.com> <e578d274-946f-2c73-026d-9b172ce32f19@amd.com>
In-Reply-To: <e578d274-946f-2c73-026d-9b172ce32f19@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 21:31:52 -0700
Message-ID: <CAP-5=fXJQcVEUEz3taSXsm0Kd0Fs3Vc4+++vz1fVEHLjB3nMPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] perf header: Parse non-cpu pmu capabilities
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 19, 2022 at 8:49 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Ian,
>
> On 20-May-22 3:57 AM, Ian Rogers wrote:
> > On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> Pmus advertise their capabilities via sysfs attribute files but
> >> perf tool currently parses only core(cpu) pmu capabilities. Add
> >> support for parsing non-cpu pmu capabilities.
> >>
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >> ---
> >>  .../Documentation/perf.data-file-format.txt   |  18 ++
> >>  tools/perf/util/env.c                         |  48 +++++
> >>  tools/perf/util/env.h                         |  11 +
> >>  tools/perf/util/header.c                      | 198 ++++++++++++++++++
> >>  tools/perf/util/header.h                      |   1 +
> >>  tools/perf/util/pmu.c                         |  15 +-
> >>  tools/perf/util/pmu.h                         |   2 +
> >>  7 files changed, 289 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> >> index f56d0e0fbff6..7f8341db9134 100644
> >> --- a/tools/perf/Documentation/perf.data-file-format.txt
> >> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> >> @@ -435,6 +435,24 @@ struct {
> >>         } [nr_pmu];
> >>  };
> >>
> >> +       HEADER_PMU_CAPS = 32,
> >> +
> >> +       List of pmu capabilities (except cpu pmu which is already
> >> +       covered by HEADER_CPU_PMU_CAPS)
> >
> > Sorry for the ignorance, is this currently broken for hybrid then?
> > Will hybrid have a HEADER_CPU_PMU_CAPS? Presumably this varies between
> > ARM's big.little and Alderlake.
>
> It's covered by HEADER_HYBRID_CPU_PMU_CAPS, but that too covers only
> cpu pmu. I think I should update the above comment to:
>
>         List of pmu capabilities (except cpu pmu which is already
>         covered by HEADER_CPU_PMU_CAPS / HEADER_HYBRID_CPU_PMU_CAPS)
>
> >> +
> >> +struct {
> >> +       u32 nr_pmus;
> >> +       struct {
> >> +               u32 core_type;  /* For hybrid topology */
> >
> > Could this be pmu_type as presumably we can have capabilities on any
> > kind of PMU?
>
> Not sure I follow that question but let me just put my thoughts here.
>
> {core_type, pmu_name} is the unique key here. Considering a hypothetical
> scenario: A system has two types of cores P-core and E-core. Certain pmu
> inside P-core has some capabilities which are missing in the identical
> pmu belonging to E-core. The header will look something like:
>
> struct {
>         .nr_pmus = 2,
>         [0] = struct {
>                 .core_type = 0, /* P-core */
>                 .pmu_name = xyz_pmu,
>                 .nr_caps = 2,
>                 [0] = { .name = cap1, .value = value1 },
>                 [1] = { .name = cap2, .value = value2 },
>         },
>         [1] = struct {
>                 .core_type = 1; /* E-core */
>                 .pmu_name = xyz_pmu;
>                 .nr_caps = 1;
>                 [0] = { .name = cap1, .value = value1 };
>         },
> };
>
> Does that answer your question?
>
> Thanks for the review,
> Ravi

I may be being a little ahead of the current code as I'm wondering
about heterogeneous systems with many non-CPU PMUs. It seems such a
scenario just wouldn't touch the core_type field here. Could the p or
e core-ness of a PMU be implied by the name? Is there something
similar to core_type in sysfs or would we use the name in that case?

Thanks,
Ian
