Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF33C4167D
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiKNSNN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbiKNSNJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC028E3E
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m4-20020a258004000000b006cbf32f7ed8so10925483ybk.9
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lOO9C7JbCmkD1UBVZhc67PcVihTD9v0alGeZxPKLO3A=;
        b=ibO/iIFTGjanA6GA/lOfrzAyxKO5GHieanh/jSZ55L5rgRPKAMtZe+9I8Y4RNoGDzI
         BH2oC+kglLsPL0SVwn+DeGgXC5ZoXlPWF11knUMhKtbaBxb4Vfc71PfWtnWIlaItAjbW
         mgXc0QUs4wxKbH0p/H6M/EuEBWJOXHMQVgawwVFFwMIZhdNBLemxDnlhX6fiNPd8Ed2f
         ADaaWJdNuLyXXwxdG49DaescQXLpbsulN0CD85jLEdh2jhImq9Kz+XE07sgDhrWRw1MM
         gWdyPPYpPG5TML6dQCUL+er6xNDPM1fpCtIQMgxNyMKpk/oyFCRTgPo15SIOIJ6RNxsS
         S8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOO9C7JbCmkD1UBVZhc67PcVihTD9v0alGeZxPKLO3A=;
        b=IdDdbcBbTFhMceil+FdGNSvjeIwHNxOWi0Pa0AoJjlMj10fF+NwifgTuFFUEHWUfd5
         zMBGduToFHnyjyQ8NTItTJKTMvWCfgbsWTkt4yfLP99ul7/pgpq1Cqgq8bKY8icACykZ
         v5aN/WGYi3chckyAdC1IeXNh/LLbJqqKytHGDx4Qsf/S0BHNpB+YJGp1fhJG50eKe1LK
         bE3RTZ2FpcIE3HfPWjnrsFCqBX3+nxLQ9gwFbsepU5sZbSyt+tirJG7862TvD5q/6sMz
         popKrEp0QweZ3/KgE2AAz2GlIsh0NsPE/53kW2BecvI7a6+fLxaxDRp9sybvPHjSkjUT
         DSMg==
X-Gm-Message-State: ANoB5pn9/GZMIauv8qXOXX9UKDfz8yGmPfeIekKpFNngOBEiwjCLQBQI
        dwOM+6JVL0ZZrjeD1WlewVIq/UCwlSNe
X-Google-Smtp-Source: AA0mqf7MNZsL+9wa64JdJ0Hw2HcuMtgE8QV7P0ONuqSOPgqBRpvEE6y9979LmBwFiTKEVD2AM3He6ijDzbAN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a05:6902:18a:b0:6e0:4bb5:b391 with SMTP id
 t10-20020a056902018a00b006e04bb5b391mr0ybh.533.1668449587340; Mon, 14 Nov
 2022 10:13:07 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:42 -0800
Message-Id: <20221114181251.2683871-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 0/9] Restructure perf list and add json output
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Restructure perf list so that it uses callbacks to print events and
metrics. Use the callbacks to implement json output. In the process
add documentation to pmu.h, avoid some sorting of events, fix some
command line and output bugs.

v2. Address feedback from Adrian Hunter <adrian.hunter@intel.com> and
    make kerneldoc work.

Ian Rogers (9):
  perf pmu: Add documentation
  tools lib api fs tracing_path: Add scandir alphasort
  perf tracepoint: Sort events in iterator
  perf list: Generalize limiting to a PMU name
  perf list: Simplify cache event printing
  perf list: Simplify symbol event printing
  perf pmu: Restructure print_pmu_events
  perf list: Reorganize to use callbacks
  perf list: Add json output option

 tools/lib/api/fs/tracing_path.c        |  16 +
 tools/lib/api/fs/tracing_path.h        |   1 +
 tools/perf/Documentation/perf-list.txt |  10 +-
 tools/perf/builtin-list.c              | 503 +++++++++++++++++---
 tools/perf/util/metricgroup.c          | 238 +++-------
 tools/perf/util/metricgroup.h          |   4 +-
 tools/perf/util/pmu.c                  | 279 +++++------
 tools/perf/util/pmu.h                  | 128 ++++-
 tools/perf/util/print-events.c         | 630 ++++++++++---------------
 tools/perf/util/print-events.h         |  40 +-
 10 files changed, 1054 insertions(+), 795 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

