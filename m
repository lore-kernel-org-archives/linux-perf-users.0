Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B1AC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 03:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJDDne (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 23:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDDnd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Oct 2022 23:43:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEC920F74
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Oct 2022 20:43:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b7so11749244wrq.9
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Oct 2022 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=p0GA9pNWsnfjwF844Pq50TIrD1Zj7GeD8ecze27Xd7I=;
        b=SSRXJDCyV0lgOmYXUjtpB7i5OXZg11pg4lsMLpSmT0USPJ0CXCgL+gsx0niOndx6MK
         i7zBtFHYhp8Pa7pcrofmq2i6A4ndF2y8K29OHTGbZDy6izpQvwSoSGjMNJDp56A+ii4H
         OLdpqKWXAmYclxn8fAynHztTe9T3rVjkRKfYu8Op+vHuO/iB389OZki1BSSdjMbfMAT7
         o+JVvaEFBQIDRVnhnF91raAbtUC4dbwgMQLufs48oiuuXSZxoR3Us/bcB7QLM5Qw/hnw
         EVKNMDpdwnMF1uhJAa6mgikpCbnjPWBKxdt7MQzZByR8yJYtOu3rGlrOhuG1+ZwurAjD
         DaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=p0GA9pNWsnfjwF844Pq50TIrD1Zj7GeD8ecze27Xd7I=;
        b=sNbfcifA9jMaIN48ZpsCslSOczGpYcg3lBKpI+5DutOBOwFctJBpeGlgtcEof29gNg
         Edp+r5KSERDAcWN8o8S1tVWh+77s1Wv8L74Hh/SD8jn/aOZVw1xMAOrYaJUCM/lQv4/c
         ZV7BbciQSGeaxy7XsDVRaAR7PYgjVBAz1AXxNAwRfVIt/nEhXq89n1DU7xfcY4olz891
         WNH+75n4E2ls4tGPeyokIcNF3EYlY0Wv2nV4ALFkPWOw1wnjrPf3bkD7jiJYmoogg0XP
         Ttk5i+8Z2PvKJFeEQ+L25CCsAkm3OGRRbqiK/lywOY8fZ348N9g702rG1B4pq4wMA0jY
         3HSA==
X-Gm-Message-State: ACrzQf3FeWxYl/7Ixutmipk+BcVeG6tRDpy7r6bVCi8017A+vCy2clnk
        VWHvCxLjUxQ9nfTt3ahAMkkwBYcJNmW+bndlFMswAw==
X-Google-Smtp-Source: AMsMyM494QP+LBwSK+L/onWQsEN5D1jWJByaWb0zn3ngpZL5MPrp9WPTW0sIrXv9ptmweTVtiPkxH9ErxtoIO7x5WNA=
X-Received: by 2002:a5d:6d86:0:b0:22e:404f:1101 with SMTP id
 l6-20020a5d6d86000000b0022e404f1101mr3615761wrs.343.1664855010409; Mon, 03
 Oct 2022 20:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Oct 2022 20:43:18 -0700
Message-ID: <CAP-5=fXk6sLhZsEs72G4pOuZNzDJLc2Vkkvf+Jv=LXQDHPy8-w@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Improvements to Intel perf metrics
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 3, 2022 at 7:16 PM Ian Rogers <irogers@google.com> wrote:
>
> For consistency with:
> https://github.com/intel/perfmon-metrics
> rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
>
> Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
> are correctly expanded in the single main metric. Fix perf expr to
> allow a double if to be correctly processed.
>
> Add all 6 levels of TMA metrics. Child metrics are placed in a group
> named after their parent allowing children of a metric to be
> easily measured using the metric name with a _group suffix.
>
> Don't drop TMA metrics if they contain topdown events.
>
> The ## and ##? operators are correctly expanded.
>
> The locate-with column is added to the long description describing a
> sampling event.
>
> Metrics are written in terms of other metrics to reduce the expression
> size and increase readability.
>
> Following this the pmu-events/arch/x86 directories match those created
> by the script at:
> https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
> with updates at:
> https://github.com/captain5050/event-converter-for-linux-perf
>
>
> v3. Fix a parse metrics test failure due to making metrics referring
>     to other metrics case sensitive - make the cases in the test
>     metric match.
> v2. Fixes commit message wrt missing mapfile.csv updates as noted by
>     Zhengjun Xing <zhengjun.xing@linux.intel.com>. ScaleUnit is added
>     for TMA metrics. Metrics with topdown events have have a missing
>     slots event added if necessary. The latest metrics at:
>     https://github.com/intel/perfmon-metrics are used, however, the
>     event-converter-for-linux-perf scripts now prefer their own
>     metrics in case of mismatched units when a metric is written in
>     terms of another.  Additional testing was performed on broadwell,
>     broadwellde, cascadelakex, haswellx, sapphirerapids and tigerlake
>     CPUs.

I wrote up a little example of performing a top-down analysis for the
perf wiki here:
https://perf.wiki.kernel.org/index.php/Top-Down_Analysis

Thanks,
Ian

> Ian Rogers (23):
>   perf expr: Allow a double if expression
>   perf test: Adjust case of test metrics
>   perf expr: Remove jevents case workaround
>   perf metrics: Don't scale counts going into metrics
>   perf vendor events: Update Intel skylakex
>   perf vendor events: Update Intel alderlake
>   perf vendor events: Update Intel broadwell
>   perf vendor events: Update Intel broadwellx
>   perf vendor events: Update Intel cascadelakex
>   perf vendor events: Update elkhartlake cpuids
>   perf vendor events: Update Intel haswell
>   perf vendor events: Update Intel haswellx
>   perf vendor events: Update Intel icelake
>   perf vendor events: Update Intel icelakex
>   perf vendor events: Update Intel ivybridge
>   perf vendor events: Update Intel ivytown
>   perf vendor events: Update Intel jaketown
>   perf vendor events: Update Intel sandybridge
>   perf vendor events: Update Intel sapphirerapids
>   perf vendor events: Update silvermont cpuids
>   perf vendor events: Update Intel skylake
>   perf vendor events: Update Intel tigerlake
>   perf vendor events: Update Intel broadwellde
>
>  .../arch/test/test_soc/cpu/metrics.json       |    6 +-
>  .../arch/x86/alderlake/adl-metrics.json       | 1353 ++++++++++++++++-
>  .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
>  .../arch/x86/alderlake/frontend.json          |   12 +
>  .../pmu-events/arch/x86/alderlake/memory.json |   22 +
>  .../pmu-events/arch/x86/alderlake/other.json  |   22 +
>  .../arch/x86/alderlake/pipeline.json          |   14 +-
>  .../arch/x86/broadwell/bdw-metrics.json       |  679 +++++++--
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  711 +++++++--
>  .../arch/x86/broadwellx/bdx-metrics.json      |  965 +++++++-----
>  .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
>  .../x86/broadwellx/uncore-interconnect.json   |   18 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    | 1285 ++++++++++------
>  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
>  .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
>  .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
>  .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
>  .../arch/x86/haswell/hsw-metrics.json         |  570 ++++++-
>  .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
>  .../arch/x86/haswellx/frontend.json           |   12 +-
>  .../arch/x86/haswellx/hsx-metrics.json        |  919 +++++++----
>  .../x86/haswellx/uncore-interconnect.json     |   18 +-
>  .../arch/x86/haswellx/uncore-memory.json      |   18 +-
>  .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
>  .../arch/x86/icelake/icl-metrics.json         |  808 +++++++++-
>  .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
>  .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
>  .../arch/x86/icelakex/icx-metrics.json        | 1155 ++++++++++----
>  .../arch/x86/icelakex/pipeline.json           |    2 +-
>  .../arch/x86/icelakex/uncore-other.json       |    2 +-
>  .../arch/x86/ivybridge/ivb-metrics.json       |  594 ++++++--
>  .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
>  .../arch/x86/ivytown/floating-point.json      |    2 +-
>  .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
>  .../arch/x86/ivytown/ivt-metrics.json         |  630 ++++++--
>  .../arch/x86/ivytown/uncore-cache.json        |   58 +-
>  .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
>  .../arch/x86/ivytown/uncore-memory.json       |    2 +-
>  .../arch/x86/ivytown/uncore-other.json        |    6 +-
>  .../arch/x86/ivytown/uncore-power.json        |    8 +-
>  .../arch/x86/jaketown/jkt-metrics.json        |  327 +++-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
>  .../arch/x86/sandybridge/snb-metrics.json     |  315 +++-
>  .../arch/x86/sapphirerapids/cache.json        |    4 +-
>  .../arch/x86/sapphirerapids/frontend.json     |   11 +
>  .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 1249 ++++++++++-----
>  .../arch/x86/skylake/skl-metrics.json         |  861 ++++++++---
>  .../arch/x86/skylakex/skx-metrics.json        | 1262 +++++++++------
>  .../arch/x86/skylakex/uncore-memory.json      |   18 +-
>  .../arch/x86/skylakex/uncore-other.json       |   19 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  810 +++++++++-
>  tools/perf/pmu-events/empty-pmu-events.c      |    6 +-
>  tools/perf/tests/expr.c                       |    4 +
>  tools/perf/util/expr.c                        |   11 +-
>  tools/perf/util/expr.y                        |    2 +-
>  tools/perf/util/stat-shadow.c                 |    9 +-
>  58 files changed, 11514 insertions(+), 3630 deletions(-)
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
