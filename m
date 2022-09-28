Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04684C32771
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Sep 2022 14:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiI1OEm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiI1OEk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 10:04:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DF42A7
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 07:04:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so1311925wml.5
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pT8Pa3aul2y0J8wI5tmV3D9446EVxudJ37A+PRgWGI8=;
        b=rMmrvTV8seAmkNBYH/IQFG1Bq315cEfN2kCgCHAPtSW9HLvXyujjih7AzistOpSNvR
         lgsbHw6KuQYVTybZRtWYbsHMVkbj5UUIAfx7R6HK3p5FXrQFkCUzmX4D0VF1mbOXp73N
         kBN/n94KCVxT1iy6AbFdRWN9+3C39hPT8unSa68kWOtNWapEaym/k1EWP/7MVWHPx3nt
         /cFhsQpkjWsyWVq17BBfGWX3E75SSb06pZofHOylE9xXNaf8QbszHPJh+07iMq4PDu2s
         jozUr+LA59u7iHOWSVdc4E4rEELQPqtknwAuMIVVX1AsS9PU1CvOItfVyhRUs9gprQOs
         nz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pT8Pa3aul2y0J8wI5tmV3D9446EVxudJ37A+PRgWGI8=;
        b=r8FK5Dv/AnrsmXDidU544tmK5qTkwn2IF3X0EiO1BkPi8+T6blm0u2WQmQFlLtbqHV
         XQNop6AbfMB4e+WjJQl67iTjq0SJK3+MlPiBhzoNlr+iJPa6SoVrkcFFjq1wE+g6qwEY
         hSqypv3YQn4wa37Jl7p0PuRh02ZAjgB/ChNJ5MC4ydL7v9vYijgaskKKmz6+X9F2lAG3
         8o9VzNYM7BLSmSQQ0Vz8ZSGRmFtolrX1IrPDzPGwVbIupQNZJALc1IWVMerXjJwALwYB
         iOJpSPfetMjpnqpNQq5Q02CZRAVyG1YPu9Sk7Yacon/00BF23TmKniEzyj7/CaeJ8WYL
         F+Yw==
X-Gm-Message-State: ACrzQf2s0iLieb/FwO9iq6kqzMjePX/K31cOklAjfesLHNBnG62Gfj5e
        0ygIVz8J5hnDbrYmtFgKuoeNLSNOxJPxmumOeRGaBg==
X-Google-Smtp-Source: AMsMyM57nb70paswkeHU2k8r9GJkG5/+auAKQtn4FibtVPlxvL2DZ0yjT6BtSVkVRmLuMCpp64vH9vog6X43f2xtGLk=
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id
 u8-20020a7bc048000000b003b4fb26f0f3mr7253561wmc.115.1664373870360; Wed, 28
 Sep 2022 07:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com> <6312dee3-aa37-b244-df0e-a5cd75ddee71@linux.intel.com>
In-Reply-To: <6312dee3-aa37-b244-df0e-a5cd75ddee71@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 07:04:17 -0700
Message-ID: <CAP-5=fUUohS8LYJOQo7gxViKzp0EJ5Enz797tpWE3dhyq11ODg@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] Improvements to Intel perf metrics
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 28, 2022 at 5:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-09-28 3:21 a.m., Ian Rogers wrote:
> > For consistency with:
> > https://github.com/intel/perfmon-metrics
> > rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
> >
>
> If so, all the scripts with the old name must be broken on the existing
> platforms. Can we keep both old name and new name for the existing
> platforms?
>
> For the event naming, if we want to rename an event. We still keep the
> old name and mark it as deprecated in the existing platforms to maintain
> compatibility.
>
> Can we do the similar thing for metrics?
> For the existing platforms, just add all the metrics from the
> perfmon-metrics and don't change the existing metrics unless they have
> errors.
>
> Thanks,
> Kan

Thanks Kan,

Do we have examples of scripts that will be impacted by this? My
thoughts are that such scripts are likely using TopdownL1 as a metric
group, the metrics within that group vary and names may change over
time. For example, on hybrid there is Backend_Bound_Aux. Given the
existing state, such compatibility is only required for level 1
metrics on CNL CPX CLX KBLR/CFL/CML SKX SKL/KBL BDX BDW HSX HSW IVT
IVB JKT/SNB-EP SNB. Injecting either a metric group or an aliasing
metric is messy and when can we stop carrying the patch? There hasn't
been discussion of doing this in the context of:
https://github.com/intel/perfmon-metrics
I'd suggest that this is a good time for script writers to change how
they use particular metrics and derive the information instead from
groups like TopdownL1. This will also make them robust to changes in
the TMA metrics CSV files, another win.

Thanks,
Ian


> > Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
> > are correctly expanded in the single main metric. Fix perf expr to
> > allow a double if to be correctly processed.
> >
> > Add all 6 levels of TMA metrics. Child metrics are placed in a group
> > named after their parent allowing children of a metric to be
> > easily measured using the metric name with a _group suffix.
> >
> > Don't drop TMA metrics if they contain topdown events.
> >
> > The ## and ##? operators are correctly expanded.
> >
> > The locate-with column is added to the long description describing a
> > sampling event.
> >
> > Metrics are written in terms of other metrics to reduce the expression
> > size and increase readability.
> >
> > Following this the pmu-events/arch/x86 directories match those created
> > by the script at:
> > https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
> > with updates at:
> > https://github.com/captain5050/event-converter-for-linux-perf
> >
> > Ian Rogers (22):
> >   perf expr: Allow a double if expression
> >   perf expr: Remove jevents case workaround
> >   perf metrics: Don't scale counts going into metrics
> >   perf vendor events: Update Intel skylakex
> >   perf vendor events: Update Intel alderlake
> >   perf vendor events: Update Intel broadwell
> >   perf vendor events: Update Intel broadwellx
> >   perf vendor events: Update Intel cascadelakex
> >   perf vendor events: Update elkhartlake cpuids
> >   perf vendor events: Update Intel haswell
> >   perf vendor events: Update Intel haswellx
> >   perf vendor events: Update Intel icelake
> >   perf vendor events: Update Intel icelakex
> >   perf vendor events: Update Intel ivybridge
> >   perf vendor events: Update Intel ivytown
> >   perf vendor events: Update Intel jaketown
> >   perf vendor events: Update Intel sandybridge
> >   perf vendor events: Update Intel sapphirerapids
> >   perf vendor events: Update silvermont cpuids
> >   perf vendor events: Update Intel skylake
> >   perf vendor events: Update Intel tigerlake
> >   perf vendor events: Update Intel broadwellde
> >
> >  .../arch/x86/alderlake/adl-metrics.json       | 1215 ++++++++++++++++-
> >  .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
> >  .../arch/x86/alderlake/frontend.json          |   12 +
> >  .../pmu-events/arch/x86/alderlake/memory.json |   22 +
> >  .../pmu-events/arch/x86/alderlake/other.json  |   22 +
> >  .../arch/x86/alderlake/pipeline.json          |   14 +-
> >  .../arch/x86/broadwell/bdw-metrics.json       |  603 ++++++--
> >  .../arch/x86/broadwellde/bdwde-metrics.json   |  639 +++++++--
> >  .../arch/x86/broadwellx/bdx-metrics.json      |  644 +++++++--
> >  .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
> >  .../x86/broadwellx/uncore-interconnect.json   |   18 +-
> >  .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
> >  .../arch/x86/cascadelakex/clx-metrics.json    |  893 ++++++++----
> >  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
> >  .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
> >  .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
> >  .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
> >  .../arch/x86/haswell/hsw-metrics.json         |  502 +++++--
> >  .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
> >  .../arch/x86/haswellx/frontend.json           |   12 +-
> >  .../arch/x86/haswellx/hsx-metrics.json        |  707 +++++++---
> >  .../x86/haswellx/uncore-interconnect.json     |   18 +-
> >  .../arch/x86/haswellx/uncore-memory.json      |   18 +-
> >  .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
> >  .../arch/x86/icelake/icl-metrics.json         |  725 +++++++++-
> >  .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
> >  .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
> >  .../arch/x86/icelakex/icx-metrics.json        |  794 ++++++++++-
> >  .../arch/x86/icelakex/pipeline.json           |    2 +-
> >  .../arch/x86/icelakex/uncore-other.json       |    2 +-
> >  .../arch/x86/ivybridge/ivb-metrics.json       |  525 +++++--
> >  .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
> >  .../arch/x86/ivytown/floating-point.json      |    2 +-
> >  .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
> >  .../arch/x86/ivytown/ivt-metrics.json         |  558 ++++++--
> >  .../arch/x86/ivytown/uncore-cache.json        |   58 +-
> >  .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
> >  .../arch/x86/ivytown/uncore-memory.json       |    2 +-
> >  .../arch/x86/ivytown/uncore-other.json        |    6 +-
> >  .../arch/x86/ivytown/uncore-power.json        |    8 +-
> >  .../arch/x86/jaketown/jkt-metrics.json        |  291 ++--
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
> >  .../arch/x86/sandybridge/snb-metrics.json     |  279 +++-
> >  .../arch/x86/sapphirerapids/cache.json        |    4 +-
> >  .../arch/x86/sapphirerapids/frontend.json     |   11 +
> >  .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
> >  .../arch/x86/sapphirerapids/spr-metrics.json  |  858 +++++++++++-
> >  .../arch/x86/skylake/skl-metrics.json         |  774 ++++++++---
> >  .../arch/x86/skylakex/skx-metrics.json        |  859 +++++++++---
> >  .../arch/x86/skylakex/uncore-memory.json      |   18 +-
> >  .../arch/x86/skylakex/uncore-other.json       |   19 +-
> >  .../arch/x86/tigerlake/tgl-metrics.json       |  727 +++++++++-
> >  tools/perf/tests/expr.c                       |    4 +
> >  tools/perf/util/expr.c                        |   11 +-
> >  tools/perf/util/expr.y                        |    2 +-
> >  tools/perf/util/stat-shadow.c                 |    9 +-
> >  56 files changed, 10103 insertions(+), 2129 deletions(-)
> >
