Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12398C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 20:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348718AbiEPUzE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348605AbiEPUyy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 16:54:54 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0457156
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 13:29:20 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id y74so16738478vsy.7
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXP8Pdn4swKo5tR3y0TOzZaHISelDqwht4aRHyxNClY=;
        b=AACI2GiJOFOIcU4Swf9BMoWDbD7G214VTGB/oShtsLdyACcNk2u5ToNhA7s3Ua347K
         q/xzEO0N9nmmS3YETwvjSBKi9EGMIEt+HEyswTNoCVSvVbdg0lWrD8bVbOepoNH86qpP
         cDVbx9+YMxggvnC8wVCgRgR1JKUI3KXx7T4iSPncl/0MI6D+20329Km3QYguglzYTGaU
         924MJC4kj3Qi/gQ78ZU2CAnBxceT+fAE6Nz+UcEF4ZZXoFylgKWRsGrW4V/H9dgqzsGi
         uEywUSk4vrJgbzrsOc0Qu+pk4toyyPAi5U/W6s5fVsoToShLpuQUKXqPZgmhyBGUMk2u
         nbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXP8Pdn4swKo5tR3y0TOzZaHISelDqwht4aRHyxNClY=;
        b=ogznR83NsZX7mKuRZc5PwTYxPALI7PQePbGJYmKJX+Z4d3alCAaIWh8oWjPM8xGWw0
         GhieQMYt7LrSplxsnNxzXDQIBr3wYhBFCkrz9RjRAU1ElXZ8plIYNd02fdizZhbq65AE
         yQNOeCNCNIFsF84Ll6A6JEiTuk9Vb6pemf4EG3f8FEliNWK3FTti2r5X1ZILjAC8TC9S
         FsAzNGvj3eKfuFUTNz8ddXOG8P5SAHnBqQ7mLxm8XLxawtk7HaCK7i6MbGonpiJ6ToT3
         DQl7tBwoAY36gMhE6IKS3cJAx/ZensEZbSpGW8aVKq1o51dWHMWkMi4e93ooYk+vcN4e
         YrNQ==
X-Gm-Message-State: AOAM530XoDCxgHoIj7sFi755OcFweYQJeoPHRpTkvNDLWFvSayxb++9r
        Nk7+PZGEg9475v0ORp11YNMRuX/4d4ofQ7ezcXEfBw==
X-Google-Smtp-Source: ABdhPJyOlJkER0OOVa22lBHY2Cyeb/wFo1paXddAfzmhSV4LVd0Q777CmlGKp7rx/sui2cn+1Nr6gW7kocWII7gMCDI=
X-Received: by 2002:a67:af01:0:b0:32d:3d57:cff with SMTP id
 v1-20020a67af01000000b0032d3d570cffmr7507996vsl.8.1652732956652; Mon, 16 May
 2022 13:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <YnqJwMfi/bcDmN4H@kernel.org> <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
 <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com> <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
 <CAP-5=fWYU1hzhGTc6q_u9r82g+rbn18+-i9o0W8sUVyk+t694w@mail.gmail.com> <f1f932f1-1b0b-120d-f082-f9df32b7b9c4@huawei.com>
In-Reply-To: <f1f932f1-1b0b-120d-f082-f9df32b7b9c4@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 May 2022 13:29:04 -0700
Message-ID: <CAP-5=fUUBezhJG3kXM04axK5jhsZpA_U6dXNEHYd07q-DOLBJQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     John Garry <john.garry@huawei.com>
Cc:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Qi Liu <liuqi115@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 16, 2022 at 4:10 AM John Garry <john.garry@huawei.com> wrote:
>
> On 15/05/2022 23:03, Ian Rogers wrote:
> > I'll raise John's "ok" and say this looks great!:-D  Some thoughts:
> >
> > The mapfile.csv cpuid values don't directly align with:
> > https://github.com/ARM-software/data/blob/master/cpus.json
> > but this definitely looks deliberate.
> >
>
> Hi Ian,
>
> > The new events lack the PMU "Unit" value.
>
> For arm support we work on the basis that no "Unit" means CPU PMU. I
> assume the same for other archs, but maybe this hybrid PMU support
> changes that.
>
> > The current perf json is
> > pretty free form and leads to problems if two PMUs are present.
>
> Can you clarify - for my benefit - exactly what you mean by "two PMUs
> are present"?

On Alderlake there is a cpu_core and cpu_atom. The event codes, etc.
vary between them - there is no notion of architecture standard
events.

> > Context is here:
> > https://lore.kernel.org/lkml/CAP-5=fWRRZsyJZ-gky-FOFz79zW_3r78d_0APpj5sf66HqTpLw@mail.gmail.com/
> >
>
> We have another problem but I am not sure if exactly the same.
>
> The issue is that if we have an event alias "cycles" for an uncore PMU,
> then if we use "stat" command then perf tool matches "cycles" to CPU
> cycles and not the uncore PMU, which we would not want.
>
> We have ways to work around it, though.

Ack.

> > My idea to rationalize this is to mirror what is already done in
> > sysfs, that is the event data is specific to a PMU. As a lot of "Unit"
> > values are missing from events on x86 a reasonable guess if the "Unit"
> > is missing is to use "cpu".
>
> This sounds like what I mentioned in the reply to 1/20:
>
> "I had a patch series which makes perf read the armv8 pmu
> sysfs event file to learn all the events which the core supports and
> create the aliases from that. So, in this, we don't require the JSONs to
> list these events explicitly. "
>
> Is this like what Andi was talking about in terms of runtime loading?

I think Andi is talking about loading the json style events at
runtime. The existing jevents.c code could be linked into the perf
tool whereas the jevents.py rewrite would be harder.

Thanks,
Ian

> > Poking a Google Pixel 4a, I see that all
> > PMU data is in "armv8_pmuv3". So for ARM I could guess this is always
> > the case, ie all events should belong to armv8_pmuv3. This may not be
> > right and could lead to confusion like an event BR_COND_MIS_PRED
> > having an alias of "armv8_pmuv3/BR_COND_MIS_PRED/" but it really
> > should have some other PMU name in there. I just raise this in case
> > there is a fix for this we could incorporate into this patch series,
> > maybe "armv8_pmuv3" is always the PMU and my life is easy.
>
> Thanks,
> John
