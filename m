Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1DC64EC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 08:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCHIRv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCHIRu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 03:17:50 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619EB574C2
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 00:17:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536b7eb9117so163263307b3.14
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263468;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/COzSLgkLIeXn3ru2UHUKbjCwKMR6TuDI+u2ooPKbi0=;
        b=BsZGOfu5fmj7GMyuBNAoLFz0igLDPtb81KRWfh282pq+isIkgREAIZJ4Jwx5ATDWs9
         khwAvhkV9qV+NypYwYilRVyIkVPwMF+XkfUumVJJqembQ5nvLumVsNUoOm1O5UGTOyJg
         cp2jpkhqkT/HbM4kWwQHmw8ZAF69QLul0/NDaOfC9wSHb9MdNfPhNgNkHHzPdcuPXMBv
         J4EMyLQ2Hw3/y9N+7K+qed9eK/XVfCQBlLh3Bsmi10DRXvdYsFgSVHLN/SjbNE/IH9eb
         YqfKWLp2zBZcd/8Q+N21mqHvRChcARMnCuwNUjRkWlOqpNxgvN8Sag0tBwQpIWvhtpJ4
         XddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263468;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/COzSLgkLIeXn3ru2UHUKbjCwKMR6TuDI+u2ooPKbi0=;
        b=1TkZRP+rxYBcEJLWkwkJQhTOLIJSqWbwrDAK2DRUD0ZVhUvDhceewVez7g9rpmqt+E
         6COrjMjwzRIFGjE24/zyJ7FxdG3Ky1mRXHWqJCxNSa64zzk2ZiarZlsIsYiNqqAG4Ql1
         LE7AwTtR7JqgtSEFT221/uUk8NaKYsHCYha/xCB/U3qM0O/1UVDgW0RMHwxe9mbj7nPe
         ujtPKhvfjlk1zorcSNVF6S+/iJJcCudnPsXFPjL0H8lgtO4bhWRw474S+Jfwn+SWYM2i
         iXqu734wWwVi0FcMY/Q5UDLVFmYEK5Ks4ZFX0csZu6StzuZnLaPQWxrX7NKXmff6T6ie
         x8Bw==
X-Gm-Message-State: AO0yUKXMJXIkj0D7+DDxvDk5gfp/VagnVMyVggRDwvegb73STj4UqgoU
        eCWJnIWBBxpbbcdsbJ183brfM6CpgV1C
X-Google-Smtp-Source: AK7set+pDqWMUu4JMQMthAW4mpSF29sGDsh32IqJc0ToyH+IKgDK1ATpEZqtfHvM6b2EenSX1smzfdsleT6B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP id
 o14-20020a056902010e00b0098e628074camr8503055ybh.1.1678263468638; Wed, 08 Mar
 2023 00:17:48 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:20 -0800
Message-Id: <20230308081731.1887278-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 00/11] Better fixes for  grouping of events
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
        Qi Liu <liuqi115@huawei.com>,
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

v3. Rename pmu_name to group_pmu_name and add patch to warn when events are regrouped
    as requested by Namhyung.
v2. Fix up the commit message on 4/10 (thanks Arnaldo). Drop
    unnecessary v1 5/10 (thanks Kan). evlist->core.nr_groups wasn't
    being correctly maintained after the sort/regrouping and so the
    new patch 10/10 removes that variable and computes it from the
    evlist when necessary, generally just tests.

Ian Rogers (11):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf record: Early auxtrace initialization before event parsing
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
 tools/perf/arch/x86/util/auxtrace.c      |  17 +-
 tools/perf/arch/x86/util/evlist.c        |  39 ++--
 tools/perf/builtin-record.c              |   8 +-
 tools/perf/builtin-report.c              |   2 +-
 tools/perf/builtin-stat.c                |  24 +-
 tools/perf/tests/bpf.c                   |   1 -
 tools/perf/tests/parse-events.c          |  24 +-
 tools/perf/tests/pfm.c                   |  12 +-
 tools/perf/tests/pmu-events.c            |   2 +-
 tools/perf/util/auxtrace.h               |   2 +
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
 26 files changed, 292 insertions(+), 244 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

