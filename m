Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA61BC678D4
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 04:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCBEMj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 23:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCBEMi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Mar 2023 23:12:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F83B3F2
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Mar 2023 20:12:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a545bfbaso305159797b3.20
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Mar 2023 20:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730356;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LAF/AgK1HRYrzi87aj0ZroDBvPnZklwy00LEUIfbuo=;
        b=CPfp8goIzicDcS9LgF3shufrgSj4gAVtdqdQCkjveYkYtd+xXUW+MJN1gUC6qCnokc
         dP2+dLPHZzpcAhqmyCXrs+xxDsCscpum0pL8YvQPgdmHg39/KqCrdL+ioIV2nfASnBom
         xFPsZxfRSH5T2O4DJXDWqANz7sD2FvuWUZRmb/EBXTwIWIflLLJCu0Zuz29s6qRGmHeT
         aMVVtMkuxHYaXQR0GXY7bKELBtXj/GSGddlEn9Ci60/AAsZ9N0hyIDlQap3yMp2tgDWF
         2FAT03oYpxxWd1cU1lrNJFotT/4srvQkpLyyZ5gdruq9Uu6ulMtFB4ltT5zPBe6y9JMk
         LpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730356;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LAF/AgK1HRYrzi87aj0ZroDBvPnZklwy00LEUIfbuo=;
        b=ppnUeC/xPU5tDjn3Jh42isd8tPAW5G9G9xig4aZcx4Nsz+LF00hvegIRBWtEv4K5eF
         9V/8tYhqSDON2adD2Oe1CpJxbWZlrdyjN0KvXZvOZLh/psCP3zfBazD6aRpxPWMcWhBk
         DErFeLgdR3Rlx84MyyWXy3VtmHXsxDu+Y4/psEzZDULMF/x9FIac/ErGB/4Ee2hD4z0h
         45lG3E5KtJBTCFssVacOW/BupVmIPR5vgKCOpHPEvzLH/v+JmUVNPkggBZksMW3bdVND
         T8lPjHk/zDp9+F1ullpGJAu5LzwzwXCJxBI3R7SvPkErUH0T5oHZv+KiRX0lgGq82uRi
         m/Yw==
X-Gm-Message-State: AO0yUKWG4CEq/NPhjEuTWlbC42uPlc1joWo3XSJ/pG0hdi1TjtXb28Bv
        7QRjYnViQUMZKWGS9ReZ15fUyeeENmhg
X-Google-Smtp-Source: AK7set9B05gBEoUSyInp6RerniFlMwoQQi++2P7JiMO6aVzPT3ulpltquldvz486F4UNhwF4d4jx94UQet5C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a81:ac61:0:b0:53c:7047:14c4 with SMTP id
 z33-20020a81ac61000000b0053c704714c4mr2497162ywj.8.1677730356300; Wed, 01 Mar
 2023 20:12:36 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:01 -0800
Message-Id: <20230302041211.852330-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 00/10] Better fixes for  grouping of events
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

Ian Rogers (10):
  libperf evlist: Avoid a use of evsel idx
  perf stat: Don't remove all grouped events when CPU maps disagree
  perf record: Early auxtrace initialization before event parsing
  perf stat: Modify the group test
  perf evsel: Limit in group test to CPUs
  perf evsel: Allow const evsel for certain accesses
  perf evsel: Add function to compute pmu_name
  perf parse-events: Pass ownership of the group name
  perf parse-events: Sort and group parsed events
  perf evsel: Remove use_uncore_alias

 tools/lib/perf/evlist.c             |  13 +-
 tools/perf/arch/x86/util/auxtrace.c |  17 +-
 tools/perf/arch/x86/util/evlist.c   |  39 ++---
 tools/perf/arch/x86/util/evsel.c    |   3 +
 tools/perf/builtin-record.c         |   6 +
 tools/perf/builtin-stat.c           |  24 ++-
 tools/perf/util/auxtrace.h          |   2 +
 tools/perf/util/evlist.h            |   2 +-
 tools/perf/util/evsel.c             |  27 ++-
 tools/perf/util/evsel.h             |   8 +-
 tools/perf/util/parse-events.c      | 253 +++++++++++++---------------
 tools/perf/util/parse-events.h      |   6 +-
 tools/perf/util/parse-events.y      |  17 +-
 tools/perf/util/pmu.c               |   6 +-
 tools/perf/util/python.c            |   2 +-
 tools/perf/util/stat-shadow.c       |   2 +-
 16 files changed, 228 insertions(+), 199 deletions(-)

-- 
2.39.2.722.g9855ee24e9-goog

