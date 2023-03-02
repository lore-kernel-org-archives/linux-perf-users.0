Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A946BC7EE43
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 21:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCBV4D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 16:56:03 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:56308 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCBV4D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 16:56:03 -0500
Received: by mail-yb1-f202.google.com with SMTP id h3-20020a25d003000000b00a1a201a745aso264479ybg.22
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 13:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677794101;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ToIbaMj5AqTB1LrmzVhyr0yCG3hmCJZiHtcXsiBUWn0=;
        b=nx5xKJUe84VWOXS4yAPQ6wSIkVX78LhAx9EuESYbz/6gmi7aaAx/dqI5w3H+gxCODy
         a1Wd300CPseiQDbqp2tLbvzYbW+a+4jX1IP5w7Wg75NuqXBEmqicN0DOOV8fueUg6N07
         MsGEaJFs868m24qAGseyNrhCupdJnSZeKaFqH5WurQK6pKunTypofk6qfEn3RRHBk3uW
         Es3y5IZtDniW1UYJGIn+LA0DvtLFYYaxvECa/+oPZuHcMXrsTFPoxGbD0s8ML3744us3
         GFyxLrLFUW36Ey/4lbEi73ArVHE05upm8zo1BLEy1CE4fGNvN5VE4gdhwWhB1tVMlUDc
         5BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794101;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToIbaMj5AqTB1LrmzVhyr0yCG3hmCJZiHtcXsiBUWn0=;
        b=d6upsSLh9yU2Vj/upDg5CdL4WUv22kltPDftTMo3wGWFj0iJOH/31mu9tly6jgDuls
         Vy2o41JVIsofHM0LdCMxAN+BUgm7un96ybwwGF4LoMePIzwsWjlLGXqCe6nLETuvNvTU
         zSv7/uIZrob2GZ7d+YxMR0BiYzVipsH43k2XXzzrYiNt96ooteMG/2U8dPoxDC/9VUSA
         E8bw7mn7WqfPfSqxzuwF87Jc94ugjCO1pLANTP25GxJQC6Z0lRxjOXkLCD9aI7153k3j
         4XQ+J8dAwsFamf1AYN0/P17KACmHBl0sr03Aqb273hh5ZmA3THAR1Bhuha4YmBYn/MID
         zuRQ==
X-Gm-Message-State: AO0yUKVYotpc28Rm+UesN3bU2AERdTwy1fv2ISJHZDcHccd3Ivw1Cakw
        +Cx+E5qxt7TjFLxNK0ZpsRVSkHvEWHU+
X-Google-Smtp-Source: AK7set+74b/Jodt3t/RYWA8tUfU7KmkGxFW2btv6V1hUUOgY23HbfXPR8ohDHGGONCz9C522bsOXeXAt30U/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a5b:1cb:0:b0:9f5:af8a:3b61 with SMTP id
 f11-20020a5b01cb000000b009f5af8a3b61mr6433739ybp.4.1677792348374; Thu, 02 Mar
 2023 13:25:48 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:21 -0800
Message-Id: <20230302212531.1043318-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 00/10] Better fixes for  grouping of events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

The rules for grouping events has grown more complex. Topdown events
must be grouped, but flags like --metric-no-group and flags on metrics
don't respect this. Uncore events may be expanded using wild cards for
PMU names, but then the events need reordering so the group members
are adjacent. Rather than fixing metrics, this change fixes the main
event parsing code to first sort and then regroup evsels.

As this is shared functionality changes to it should cause
concern. The change is done with the intent of simplifying and making
more robust the grouping logic, examples are given. If additional
changes are necessary, they are most likely necessary to the
evsel__pmu_name logic as the code avoids breaking groups that are on
the same PMU. The pmu_name is tweaked in the case of software and aux
events, that use groups in a slightly different manner to conventional
events.

The code was manually tested as well as passing perf test on a Intel
tigerlake CPU with intel-pt.

v2. Fix up the commit message on 4/10 (thanks Arnaldo). Drop
    unnecessary v1 5/10 (thanks Kan). evlist->core.nr_groups wasn't
    being correctly maintained after the sort/regrouping and so the
    new patch 10/10 removes that variable and computes it from the
    evlist when necessary, generally just tests.

Ian Rogers (10):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf record: Early auxtrace initialization before event parsing
  perf stat: Modify the group test
  perf evsel: Allow const evsel for certain accesses
  perf evsel: Add function to compute pmu_name
  perf parse-events: Pass ownership of the group name
  perf parse-events: Sort and group parsed events
  perf evsel: Remove use_uncore_alias
  perf evlist: Remove nr_groups

 tools/lib/perf/evlist.c                  |  31 ++-
 tools/lib/perf/include/internal/evlist.h |   1 -
 tools/lib/perf/include/perf/evlist.h     |   1 +
 tools/perf/arch/x86/util/auxtrace.c      |  17 +-
 tools/perf/arch/x86/util/evlist.c        |  39 ++--
 tools/perf/builtin-record.c              |   8 +-
 tools/perf/builtin-report.c              |   2 +-
 tools/perf/builtin-stat.c                |  24 ++-
 tools/perf/tests/bpf.c                   |   1 -
 tools/perf/tests/parse-events.c          |  22 +-
 tools/perf/tests/pfm.c                   |  12 +-
 tools/perf/util/auxtrace.h               |   2 +
 tools/perf/util/evlist.c                 |   2 +-
 tools/perf/util/evlist.h                 |   8 +-
 tools/perf/util/evsel.c                  |  27 ++-
 tools/perf/util/evsel.h                  |   8 +-
 tools/perf/util/header.c                 |   3 +-
 tools/perf/util/parse-events.c           | 254 +++++++++++------------
 tools/perf/util/parse-events.h           |   7 +-
 tools/perf/util/parse-events.y           |  27 +--
 tools/perf/util/pfm.c                    |   1 -
 tools/perf/util/pmu.c                    |   6 +-
 tools/perf/util/python.c                 |   2 +-
 tools/perf/util/stat-shadow.c            |   2 +-
 24 files changed, 270 insertions(+), 237 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

