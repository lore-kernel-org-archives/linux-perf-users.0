Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED7C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 02:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJDCQV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDCQT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C7357F4
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Oct 2022 19:16:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so128155017b3.10
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Oct 2022 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date;
        bh=/oDSH3OdUMvg7xjQ26JyefXMtLcIaw7n6p5qDnQ+TRM=;
        b=TcffAz6baSBi0YdKKwF9ywYZNIvdxwPYXps21HCsdtHNfn1M8k+fN1d2WW2fTfDReO
         P28x8TCNNEZwo3HqYUfC6DOsgIyspIYQ0xNAHgbj0PICZG2KVPvCHgX3xpne5tLKsxLQ
         D85FY/U2tYgQefdh9rT+uEPFs492bGmhFoEYonL0/L1QvZx/WMJTq7SiId4XzI5WQuz6
         +F1+3TODcgiiTJQUFDDL4mmbGsyOngTSr89kMLkS38kvlJ3LEXOr54AydAAp41hov+YH
         ZItXlhBq5fzsliGxRlVmyNM/MdoIuTeN0cyuMEL9w2sXnor/pzLuXi04FPYJ8CUWuEqG
         a/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/oDSH3OdUMvg7xjQ26JyefXMtLcIaw7n6p5qDnQ+TRM=;
        b=jqe1d6pl5Lf+Lc+FYIRvIhCVVu4sr1jQTGImFf7ESkDl4yyylQv92bW2X2VXJR9wbm
         gmj7dhZ9tcSHZYLbSzMy+sxDjsEJBOM9e6unVQIY9TeM6jmYJR7zMacy9OXhJOauJiCJ
         aviyxbs26TB+v3Cmeb4XOs/DlwrNfKDKsLWhRZ17PJ4qatVOABkPOT7aZFtvy78ymxTg
         QDkdyWihN7Tvf8P7HtFd2PXFWe5i5/HjT7L8nRRXxwyZkM4eqjlA3y3hLMXWj8Pk2EWL
         h3EOXpC4zaOaKfcvboCQQmfdF4Q+xNR+yuNl41VDNad9eJwtBoFYSc0ZtJLnNFHe3ySR
         aqGg==
X-Gm-Message-State: ACrzQf1/r/qzDisDLVQuwZTOsJrGSkJoAvB2S4KAZ+M9hcruu/uALWeL
        aQtOAE/v0K6hiQuIwJQkIcg0hVzoFoXc
X-Google-Smtp-Source: AMsMyM5wzLJqOnXFXtEkS8FRtDt4LXkptvSnhri12pbtDLvncr+7QPRHmD6zYLh6wTUHqUH0DkfZrzbvVXp6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:c1c3:0:b0:6bc:a97e:66e3 with SMTP id
 r186-20020a25c1c3000000b006bca97e66e3mr21989439ybf.22.1664849776587; Mon, 03
 Oct 2022 19:16:16 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:49 -0700
Message-Id: <20221004021612.325521-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 00/23] Improvements to Intel perf metrics
From:   Ian Rogers <irogers@google.com>
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
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For consistency with:
https://github.com/intel/perfmon-metrics
rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.

Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
are correctly expanded in the single main metric. Fix perf expr to
allow a double if to be correctly processed.

Add all 6 levels of TMA metrics. Child metrics are placed in a group
named after their parent allowing children of a metric to be
easily measured using the metric name with a _group suffix.

Don't drop TMA metrics if they contain topdown events.

The ## and ##? operators are correctly expanded.

The locate-with column is added to the long description describing a
sampling event.

Metrics are written in terms of other metrics to reduce the expression
size and increase readability.

Following this the pmu-events/arch/x86 directories match those created
by the script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
with updates at:
https://github.com/captain5050/event-converter-for-linux-perf


v3. Fix a parse metrics test failure due to making metrics referring
    to other metrics case sensitive - make the cases in the test
    metric match.
v2. Fixes commit message wrt missing mapfile.csv updates as noted by
    Zhengjun Xing <zhengjun.xing@linux.intel.com>. ScaleUnit is added
    for TMA metrics. Metrics with topdown events have have a missing
    slots event added if necessary. The latest metrics at:
    https://github.com/intel/perfmon-metrics are used, however, the
    event-converter-for-linux-perf scripts now prefer their own
    metrics in case of mismatched units when a metric is written in
    terms of another.  Additional testing was performed on broadwell,
    broadwellde, cascadelakex, haswellx, sapphirerapids and tigerlake
    CPUs.

Ian Rogers (23):
  perf expr: Allow a double if expression
  perf test: Adjust case of test metrics
  perf expr: Remove jevents case workaround
  perf metrics: Don't scale counts going into metrics
  perf vendor events: Update Intel skylakex
  perf vendor events: Update Intel alderlake
  perf vendor events: Update Intel broadwell
  perf vendor events: Update Intel broadwellx
  perf vendor events: Update Intel cascadelakex
  perf vendor events: Update elkhartlake cpuids
  perf vendor events: Update Intel haswell
  perf vendor events: Update Intel haswellx
  perf vendor events: Update Intel icelake
  perf vendor events: Update Intel icelakex
  perf vendor events: Update Intel ivybridge
  perf vendor events: Update Intel ivytown
  perf vendor events: Update Intel jaketown
  perf vendor events: Update Intel sandybridge
  perf vendor events: Update Intel sapphirerapids
  perf vendor events: Update silvermont cpuids
  perf vendor events: Update Intel skylake
  perf vendor events: Update Intel tigerlake
  perf vendor events: Update Intel broadwellde

 .../arch/test/test_soc/cpu/metrics.json       |    6 +-
 .../arch/x86/alderlake/adl-metrics.json       | 1353 ++++++++++++++++-
 .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
 .../arch/x86/alderlake/frontend.json          |   12 +
 .../pmu-events/arch/x86/alderlake/memory.json |   22 +
 .../pmu-events/arch/x86/alderlake/other.json  |   22 +
 .../arch/x86/alderlake/pipeline.json          |   14 +-
 .../arch/x86/broadwell/bdw-metrics.json       |  679 +++++++--
 .../arch/x86/broadwellde/bdwde-metrics.json   |  711 +++++++--
 .../arch/x86/broadwellx/bdx-metrics.json      |  965 +++++++-----
 .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
 .../x86/broadwellx/uncore-interconnect.json   |   18 +-
 .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
 .../arch/x86/cascadelakex/clx-metrics.json    | 1285 ++++++++++------
 .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
 .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
 .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
 .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
 .../arch/x86/haswell/hsw-metrics.json         |  570 ++++++-
 .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
 .../arch/x86/haswellx/frontend.json           |   12 +-
 .../arch/x86/haswellx/hsx-metrics.json        |  919 +++++++----
 .../x86/haswellx/uncore-interconnect.json     |   18 +-
 .../arch/x86/haswellx/uncore-memory.json      |   18 +-
 .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
 .../arch/x86/icelake/icl-metrics.json         |  808 +++++++++-
 .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
 .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
 .../arch/x86/icelakex/icx-metrics.json        | 1155 ++++++++++----
 .../arch/x86/icelakex/pipeline.json           |    2 +-
 .../arch/x86/icelakex/uncore-other.json       |    2 +-
 .../arch/x86/ivybridge/ivb-metrics.json       |  594 ++++++--
 .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
 .../arch/x86/ivytown/floating-point.json      |    2 +-
 .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
 .../arch/x86/ivytown/ivt-metrics.json         |  630 ++++++--
 .../arch/x86/ivytown/uncore-cache.json        |   58 +-
 .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
 .../arch/x86/ivytown/uncore-memory.json       |    2 +-
 .../arch/x86/ivytown/uncore-other.json        |    6 +-
 .../arch/x86/ivytown/uncore-power.json        |    8 +-
 .../arch/x86/jaketown/jkt-metrics.json        |  327 +++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
 .../arch/x86/sandybridge/snb-metrics.json     |  315 +++-
 .../arch/x86/sapphirerapids/cache.json        |    4 +-
 .../arch/x86/sapphirerapids/frontend.json     |   11 +
 .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 1249 ++++++++++-----
 .../arch/x86/skylake/skl-metrics.json         |  861 ++++++++---
 .../arch/x86/skylakex/skx-metrics.json        | 1262 +++++++++------
 .../arch/x86/skylakex/uncore-memory.json      |   18 +-
 .../arch/x86/skylakex/uncore-other.json       |   19 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  810 +++++++++-
 tools/perf/pmu-events/empty-pmu-events.c      |    6 +-
 tools/perf/tests/expr.c                       |    4 +
 tools/perf/util/expr.c                        |   11 +-
 tools/perf/util/expr.y                        |    2 +-
 tools/perf/util/stat-shadow.c                 |    9 +-
 58 files changed, 11514 insertions(+), 3630 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

