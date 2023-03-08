Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD768C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 22:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHW70 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCHW7Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 17:59:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6ECAF6B4
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 14:59:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2514d5000000b00a3637aea9e1so215219ybu.17
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316363;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qq2+WbA4CZB7R5+5mu+QD0vLjVM2X0KIBKUyv0u83m4=;
        b=LfLD77ZHpduvLiNrC1U75xe3jFTFomqIZUMWJ49iMQmXRm3mDbwab7Juk3PoCo6aqo
         YwrVGnocEQ7NUPKP9XtH/8K8vxCnPyxIZcYQuJzdWqtik8FDoZUgUkexltsq/oLN0NZm
         X95qXOHNI73VPrM2AZ66atX95bZEJSXsJYdwGcI54XRxRY4JVVq9CK2l3HoutfgcPuRE
         H+Wg6of+wVveAYQ8+J70/3pp1+3WXOIOTUEQWWN5WKWyT6RcPYL/b0Suq5gyzJQISiYs
         1JV5kMfSYi6D0OxFF1SlPPUEoPFHmGnAfLoB0hqsiovvTv/Sm/cgkhDoe1RGXGF3wn0u
         EO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316363;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qq2+WbA4CZB7R5+5mu+QD0vLjVM2X0KIBKUyv0u83m4=;
        b=i2zgbJqUJ5kDNJ8pAWFcYW2aMtc1ovdo+53MP06h+R/yRpX0TYO5sJNU7ITEDwQ1Wt
         eE2kxR40mjvPlxXTZCnOsnPS2ua7GYnaMv+lUo+X4UudE9mbAJmGvE0gCCcdi/Lkp7UB
         dRdTxNVY2KEqBNvqJMgplyifDBDRFPEGUU0C1Rp0mKH3cgwymJ0JpQfvqJimaRP9zbZn
         vPPBK3Hpw5mp3s8K5Fk7x5DWQLuNt/JxcJ0QjQVtFOaMeOZt8XRlq0/PlCmUv2S987Fh
         aJoBcmv8TyOma3mbREKmkKASxhAbt7Wd/q404TJ9zB7+qBTTtiW0preX9M33uS/h1dap
         8tlg==
X-Gm-Message-State: AO0yUKUM6p/j1b5UsKjzpBSv9XQ0diNnPFA5XZr8e24I4XqzWv2+NnCW
        Q9WYdaF2lFY1LM6ufgIOt3D+G8vGw95z
X-Google-Smtp-Source: AK7set9TI82AzpgyqtsTt7dn+S+kHo/akNycgOG8+GdhJ6NpnIqqI96aiieVz1xc5TxYGWdEEtfGUAwf6zgF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a81:4ac3:0:b0:527:a386:a4e9 with SMTP id
 x186-20020a814ac3000000b00527a386a4e9mr2ywa.17.1678316363481; Wed, 08 Mar
 2023 14:59:23 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:01 -0800
Message-Id: <20230308225912.1960990-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 00/11] Better fixes for  grouping of events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The rules for grouping events have grown more complex. Topdown events
must be grouped, but flags like --metric-no-group and flags on metrics
don't respect this. Uncore events may be expanded using wild cards for
PMU names, but then the events need reordering so the group members
are adjacent. Rather than fixing metrics, this change fixes the main
event parsing code to first sort and then regroup evsels.

As this is shared functionality changes to it should cause
concern. The change is done with the intent of simplifying and making
more robust the grouping logic, examples are given. If additional
changes are necessary, they are most likely necessary to the
evsel__group_pmu_name logic as the code avoids breaking groups that
are on the same "group" PMU. The group_pmu_name is a variant of the
pmu_name tweaked in the case of software and aux events, that use
groups in a slightly different manner to conventional events.

The code was manually tested as well as passing perf test on a Intel
tigerlake CPU with intel-pt.

v4. Move the Intel pmu->auxtrace initialization to the existing
    perf_pmu__get_default_config as suggested by Adrian Hunter.
v3. Rename pmu_name to group_pmu_name and add patch to warn when
    events are regrouped as requested by Namhyung.
v2. Fix up the commit message on 4/10 (thanks Arnaldo). Drop
    unnecessary v1 5/10 (thanks Kan). evlist->core.nr_groups wasn't
    being correctly maintained after the sort/regrouping and so the
    new patch 10/10 removes that variable and computes it from the
    evlist when necessary, generally just tests.

Ian Rogers (11):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf pmu: Earlier PMU auxtrace initialization
  perf stat: Modify the group test
  perf evsel: Allow const evsel for certain accesses
  perf evsel: Add function to compute group PMU name
  perf parse-events: Pass ownership of the group name
  perf parse-events: Sort and group parsed events
  perf evsel: Remove use_uncore_alias
  perf evlist: Remove nr_groups
  perf parse-events: Warn when events are regrouped

 tools/lib/perf/evlist.c                  |  31 ++-
 tools/lib/perf/include/internal/evlist.h |   1 -
 tools/lib/perf/include/perf/evlist.h     |   1 +
 tools/perf/arch/x86/util/auxtrace.c      |   4 -
 tools/perf/arch/x86/util/evlist.c        |  39 ++--
 tools/perf/arch/x86/util/pmu.c           |   8 +-
 tools/perf/builtin-record.c              |   2 +-
 tools/perf/builtin-report.c              |   2 +-
 tools/perf/builtin-stat.c                |  24 +-
 tools/perf/tests/bpf.c                   |   1 -
 tools/perf/tests/parse-events.c          |  24 +-
 tools/perf/tests/pfm.c                   |  12 +-
 tools/perf/tests/pmu-events.c            |   2 +-
 tools/perf/util/evlist.c                 |   2 +-
 tools/perf/util/evlist.h                 |   8 +-
 tools/perf/util/evsel.c                  |  27 ++-
 tools/perf/util/evsel.h                  |   8 +-
 tools/perf/util/header.c                 |   3 +-
 tools/perf/util/metricgroup.c            |   3 +-
 tools/perf/util/parse-events.c           | 268 +++++++++++------------
 tools/perf/util/parse-events.h           |  14 +-
 tools/perf/util/parse-events.y           |  28 +--
 tools/perf/util/pfm.c                    |   1 -
 tools/perf/util/pmu.c                    |   6 +-
 tools/perf/util/python.c                 |   2 +-
 tools/perf/util/stat-shadow.c            |   2 +-
 26 files changed, 277 insertions(+), 246 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

