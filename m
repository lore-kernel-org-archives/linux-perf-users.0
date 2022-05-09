Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44CC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 May 2022 17:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbiEIRcu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 May 2022 13:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiEIRct (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 May 2022 13:32:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260927EBB7
        for <linux-perf-users@vger.kernel.org>; Mon,  9 May 2022 10:28:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so20433379wrh.11
        for <linux-perf-users@vger.kernel.org>; Mon, 09 May 2022 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1bopt98I3waHgLq149Sd9tf4yf2YLICVLzIky9yT44=;
        b=awdyFHQXUThM7hZBNq5IZTN2yJXos41Ya6tdkWwTzxJoXZ0oRrWN63N4bIybTRPTCU
         slhLnNquBMhiKHxO85fAmOUkj0Cqr7W5TZu0U3U27hkyk4Xyopzb60ZGA5vRuDBuzfB4
         zP9izLcfs4u1vjx8MF++iTi3nuWkCmUx8zZbUAgXi9mYLApQEZwSs0YgLH3Jg3vkVPMg
         zVao8W3/ENV4LORtI8hoIL0RmVinhd/oFFRlqwolgIhSk78XhMI/E2bY4o1OSsWVFLvO
         eWjT5OA7Vs719cDFD1/MYmJE5RGaveizFjji6AhMi2OqE2C6ml+h/FhHSVQGDNPRbfo2
         eYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1bopt98I3waHgLq149Sd9tf4yf2YLICVLzIky9yT44=;
        b=jSNN/vqj2EimW/ThaJVYGOVX/kSrlQCgfji7UQFW69Za1DhNp8PK19yekDmKYFmoG2
         OpaD18IT+Nzi1q5r5OztVjNdnBCEJ9bVwYM3M18d3lfxUGA1Escdh4Gqloejus+moXgH
         Lp5pAE1EWBQtpvbFYyBmjqsuAB8o85vHHVi/QyAycwrP7EjN8b1YM8Lus7JR/04A3O4W
         vGnW+rYXRHSP9ChgPkQX2z/5oetf6A8w36Gj4kjdoU8sT0xoDUqlJUdwekGeafSJupz/
         8sc++sTe9ATHaSXGV+nEhIaPMx/ZBr+/wiH46lMzYLLWetRKWgtRoiHkEI4tyvzPQuKs
         y7AQ==
X-Gm-Message-State: AOAM5317WEV8fRmtMO2+a0zpTdPc1K1qi3teZAj7PFNInObeJb0zrU2A
        30olrM24WVVxfhOBJkJmHKd3h+2YqCpQ0fWUPzV3jA==
X-Google-Smtp-Source: ABdhPJx5Yp1mhs3PbL+YlzJ8QfnGAWyT+iIEUSGvXjh60h9PdXr4MWUOuogBwUQBI9DBINxcHoUXY1U4apmuSGmazwE=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr14940551wro.654.1652117332485; Mon, 09
 May 2022 10:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com> <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
 <CAP-5=fVHhWu1uJHnTfFYWvM02_F-bFBZaaOYo8zPRiA=ODRxGQ@mail.gmail.com>
 <12c03e85-cb48-d264-5f04-e9bf9faaf739@linux.intel.com> <CAP-5=fW9Cp3ShO=tTQddDWXz+nrSip99HrNW7Wv5_Qsy1UT7bw@mail.gmail.com>
 <83417b72-4872-072a-2328-a88d2bb90858@linux.intel.com>
In-Reply-To: <83417b72-4872-072a-2328-a88d2bb90858@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 May 2022 10:28:40 -0700
Message-ID: <CAP-5=fXnYUnbT89q9W0Ax3d-26jbL5Mcd7O5X=JcXq9FnOUm7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf evlist: Keep topdown counters in weak group
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 5, 2022 at 12:44 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 5/5/2022 2:31 PM, Ian Rogers wrote:
> >>> So I think fixing all of these should be a follow up. I am working to
> >>> get access to an Alderlake system, could we land this first?
> >>>
> >> I think we can use pmu_name to replace the "cpu" to fix the issue for
> >> the hybrid platform. For a hybrid platform, the pmu_name is either
> >> cpu_atom or cpu_core.
> >>
> >> Besides, the topdown events may have a PMU prefix, e.g.,
> >> cpu_core/topdown-be-bound/. The strcasecmp may not work well for this case.
> >>
> >> How about the below patch?
> >> If it's OK for you, could you please merge it into your V2 patch set?
> >> I can do the test on a ADL system.
> >>
> >> diff --git a/tools/perf/arch/x86/util/evsel.c
> >> b/tools/perf/arch/x86/util/evsel.c
> >> index 40b171de2086..551ae2bab70e 100644
> >> --- a/tools/perf/arch/x86/util/evsel.c
> >> +++ b/tools/perf/arch/x86/util/evsel.c
> >> @@ -33,11 +33,12 @@ void arch_evsel__fixup_new_cycles(struct
> >> perf_event_attr *attr)
> >>
> >>    bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >>    {
> >> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> >> -           !pmu_have_event("cpu", "slots"))
> >> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
> >> +
> >> +       if (!pmu_have_event(pmu_name, "slots"))
> >>                  return false;
> > Hmm. The idea with this test is to see if the architecture supports
> > topdown events before going further. There's a similar test in all the
> > arch_evlist functions. I think with cpu_core this needs to become:
> >
>
> The case is a little bit different here. For the arch_evlist functions,
> the input is the evlist, not the specific evsel. So we have to check all
> the possible PMU names which are "cpu" and "cpu_core". Then we decide
> whether going further.
>
> The input of the evsel__must_be_in_group() is the evsel. The PMU name is
> stored in the evsel->pmu_name. I don't think we need to check all the
> possible PMU names. Using evsel->pmu_name should be good enough.
>
> > if (!pmu_have_event("cpu", "slots") && !pmu_have_event("cpu_core", "slots") )
> >
> > But we should add a helper function for this. It is odd to have this
> > change supporting Alderlake but the existing evlist work not. Perhaps
> > we should just wait until Zhengjun's patches land.
>
> Yes, a helper function is good for the arch_evlist functions. But I
> don't think this patch needs the helper function. Zhengjun's patches are
> to fix the other topdown issues on ADL. There is no dependency between
> this patch and zhengjun's patches.
>
> Thanks,
> Kan

TL;DR I think we can move forward with landing these patches to fix Icelake.

For Alderlake/hybrid we have a problem. To determine what happens with
grouping we need to know does the CPU have topdown events? This is a
runtime question for doing perf_event_open and so an arch test and
weak symbol are appropriate. For Icelake we are determining the
presence of topdown events by looking at the special PMU cpu. For
Alderlake the same information can be found by looking at the PMUs
cpu_core and cpu_atom, but how to discover those PMU names? It is
already somewhat concerning that we've hard coded "cpu" and we don't
want to have an ever growing list of PMU names.

We have similarly hard coded "cpu" in the topology code here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/cputopo.c?h=tmp.perf/core#n18
Is this unreasonable given cpu is already supposed to be ABI stable:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/Documentation/ABI/stable/sysfs-devices-system-cpu?h=tmp.perf/core

It is hard to say what the right hybrid fix is here. I should get a
system I can poke shortly. I'd also like to compare what's in sysfs
for Alderlake with ARM's big.little approach. I can imagine we need a
function that returns a list of CPU like PMUs for probing. Ideally we
could work this out from sysfs and use some stable ABI.

Thanks,
Ian
