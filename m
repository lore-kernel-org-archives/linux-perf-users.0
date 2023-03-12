Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB3DC61DA4
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCLCP5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCLCP4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:15:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC87BDD8
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:15:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bf649e70so96138277b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587355;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DiqHA2sh2qjdCAr0BvIE9FBHTrsJoQpwQKJS30o1Ors=;
        b=oKgHsOgp/LJThxtOOD0BmOMUoxa9vj7/aLhUxYKjIbC+sQBspp+SbeZUjwaK3aR3xQ
         iPRiDp6PNbENy8fnbsYvJHvXSRmsGNHrqrAr0eoVzSJwV+u8ylib2UySB1/nQbERcSeO
         AXXpfYnOm6YaoCLJkjprvjW2+nDkYnfgxFd8P8H1msyGG/RMe1yAw/jxxD2Q5Sxh5TNU
         L54mIw6mL/cbafd4xoXpi22zf73afZwjVnTd3MFxqqMMGhi07pOnHvykYR0vK9VuI+wR
         3H94gjSUI05Prvb3SJOJ0LC4Zl6VmJ3mkzkKAyewdx6b54rbDayKDYE51zlD7gzw0wOc
         +ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587355;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiqHA2sh2qjdCAr0BvIE9FBHTrsJoQpwQKJS30o1Ors=;
        b=DRQ1QKWSdakC4KC4S2Sevyd69lVgG6xZX9jlrGGv6g6P7MBPLCvUJ+iMDjDaGXTzJN
         wAIk0zbHPXmiQpQW70MX23LygTxc4kc1Yc4OAN3fg6Y72W/AoRkxCTugDY6/5eGiXxSF
         4tz3OPXb9XY0l160fxdjIxLB6IxG1WCuMdZ24CR232yOJz7HGOH32xZuc6yF2aMSlYKo
         49WzgufQC9YJUxVtfG9O1aDJ0ZwIfmXvAlMonHKG6/HzyT0ZyJ+3JE0vaRQI3PubkOFz
         uJwTL5SD08Vi7haezCf04rL+3UkdnTQ3MIMYF2DSn4VJWTXMGwryBtVoXOPZOhxDX5sW
         8x+A==
X-Gm-Message-State: AO0yUKWdecM0u7zGGr/oQNnzNl7WfK2CGMBae+rCRxSHgeOfhgnndtfM
        Ww2Sh4DHlqy22NhqV5IaemCiU+BlOnyE
X-Google-Smtp-Source: AK7set9NvAk7wdlKpPiZi5gsiSFQeqThHIKtHvjJxz+x9tnLa1bWROIho+Z0sdoVs9Tg4jwmqE/Ybr3gQMHD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a81:7bd5:0:b0:52e:f77a:c3c with SMTP id
 w204-20020a817bd5000000b0052ef77a0c3cmr7ywc.454.1678587354723; Sat, 11 Mar
 2023 18:15:54 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:32 -0800
Message-Id: <20230312021543.3060328-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 00/11] Better fixes for  grouping of events
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

v5. Add Adrian's Acked-by on patch 3, add a fix to the warning logic
    for multiple event groups as reported by Adrian.
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
 tools/perf/util/parse-events.c           | 275 ++++++++++++-----------
 tools/perf/util/parse-events.h           |  14 +-
 tools/perf/util/parse-events.y           |  28 +--
 tools/perf/util/pfm.c                    |   1 -
 tools/perf/util/pmu.c                    |   6 +-
 tools/perf/util/python.c                 |   2 +-
 tools/perf/util/stat-shadow.c            |   2 +-
 26 files changed, 284 insertions(+), 246 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

