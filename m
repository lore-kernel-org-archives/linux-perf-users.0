Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD0C25B4E
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 06:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjAXGd5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 01:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjAXGds (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 01:33:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9524E28854
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:33:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4fee82718afso112359177b3.5
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpj7Gdq7/2eqEdmcuGjQXxSe+BaC4YXzCOgMtim3MVs=;
        b=tXOi4G6TIWCid2GBDv+YeETXTAsaF4mBtTaPtRfyt/TbjLKL/UPUhpNk2BcdiTr5U2
         3WPe0PB0sCkyuxeWl4+B5tIdi3M1JFR1MiC/U223rq6v1cAoDTjYeMlSV8C2lq3vwDZc
         X2yeHiKuhHwc7ZtN9aXZz9yFCT2VmfmJLXliza90e3eSMqC/EOGcNnmh6Rj3kWCf0+Ql
         YmJbkRnS19W6jj+MIExyxpX/RFceUYwHlwy03ZquvmroV58Xc3AT/MIagO+sa2+oko2+
         9KK150BmMLgN+/fWwhQVxjmpaQGQPV2lNtwiGbxNH6/fIirQl3UIZuatXu2OWEx8zQ5u
         Tdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpj7Gdq7/2eqEdmcuGjQXxSe+BaC4YXzCOgMtim3MVs=;
        b=odaisMEaSE+TYqwGJZluzzm2BC3VydeYi+iFFlbUmdzFqvYgT6+h/GjJa3mJ5nFQKA
         BGLWqacgsS5LKrs8SSL/AUNG4DZ79XiXb2eIs1T7Ml0w3uOptQq5dPiVbEsQ/p2YrrQ5
         NT0o9H64qhy3aGFaP9JUtOQMtpA+fd6B6qU8BHg0bMhkviANyxB1CZpXFhlt28DTzq4W
         BR8qAP2w8AGSHRchnvZIZ/cUuYlE/CtgjzPxwJtM1lFg00Kg6EZKhdeKtLiYc3iHk9to
         EE4OQLrsmUt0SLrEfyv0ZpAJxFGjktWiSlWWaJXVvu3KQmzsfYG/RxhEgAg2aQWIsQVt
         QAzw==
X-Gm-Message-State: AFqh2kplpQLZBToCcuBLvhG8qdLWj5OW9kHoMYLW6/yNlvF9ysdS8u87
        qBklTH9yxbRBT+5rocEDvtxNjAcq7aHT
X-Google-Smtp-Source: AMrXdXv13hLeAIA1WIgftB2H2vtNjrNkmtRb40sCD+NeaSnu57nxATPzQOuxff7hq6heFp8rc1homLdk785L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a81:1191:0:b0:4ff:9c9b:aa0c with SMTP id
 139-20020a811191000000b004ff9c9baa0cmr1615712ywr.477.1674542010760; Mon, 23
 Jan 2023 22:33:30 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:33:09 -0800
Message-Id: <20230124063320.668917-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 00/11] jevents/pmu-events improvements
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add an optimization to jevents using the metric code, rewrite metrics
in terms of each other in order to minimize size and improve
readability. For example, on Power8
other_stall_cpi is rewritten from:
"PM_CMPLU_STALL / PM_RUN_INST_CMPL - PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_C=
MPL - PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_VSU / PM_RUN_I=
NST_CMPL - PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NTCG_FLUS=
H / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL"
to:
"stall_cpi - bru_cru_stall_cpi - fxu_stall_cpi - vsu_stall_cpi - lsu_stall_=
cpi - ntcg_flush_cpi - no_ntf_stall_cpi"
Which more closely matches the definition on Power9.

A limitation of the substitutions are that they depend on strict
equality and the shape of the tree. This means that for "a + b + c"
then a substitution of "a + b" will succeed while "b + c" will fail
(the LHS for "+ c" is "a + b" not just "b").

Separate out the events and metrics in the pmu-events tables saving
14.8% in the table size while making it that metrics no longer need to
iterate over all events and vice versa. These changes remove evsel's
direct metric support as the pmu_event no longer has a metric to
populate it. This is a minor issue as the code wasn't working
properly, metrics for this are rare and can still be properly ran
using '-M'.

Add an ability to just build certain models into the jevents generated
pmu-metrics.c code. This functionality is appropriate for operating
systems like ChromeOS, that aim to minimize binary size and know all
the target CPU models.

v3. Rebase an incorporate review comments from John Garry
    <john.g.garry@oracle.com>, in particular breaking apart patch 4
    into 3 patches. The no jevents breakage and then later fix is
    avoided in this series too.
v2. Rebase. Modify the code that skips rewriting a metric with the
    same name with itself, to make the name check case insensitive.

Ian Rogers (11):
  perf jevents metric: Correct Function equality
  perf jevents metric: Add ability to rewrite metrics in terms of others
  perf jevents: Rewrite metrics in the same file with each other
  perf pmu-events: Add separate metric from pmu_event
  perf pmu-events: Separate the metrics from events for no jevents
  perf pmu-events: Remove now unused event and metric variables
  perf stat: Remove evsel metric_name/expr
  perf jevents: Combine table prefix and suffix writing
  perf pmu-events: Introduce pmu_metrics_table
  perf jevents: Generate metrics and events as separate tables
  perf jevents: Add model list option

 tools/perf/arch/arm64/util/pmu.c         |  11 +-
 tools/perf/arch/powerpc/util/header.c    |   4 +-
 tools/perf/builtin-list.c                |  20 +-
 tools/perf/builtin-stat.c                |   1 -
 tools/perf/pmu-events/Build              |   3 +-
 tools/perf/pmu-events/empty-pmu-events.c | 108 ++++++-
 tools/perf/pmu-events/jevents.py         | 350 +++++++++++++++++++----
 tools/perf/pmu-events/metric.py          |  79 ++++-
 tools/perf/pmu-events/metric_test.py     |  10 +
 tools/perf/pmu-events/pmu-events.h       |  26 +-
 tools/perf/tests/expand-cgroup.c         |   4 +-
 tools/perf/tests/parse-metric.c          |   4 +-
 tools/perf/tests/pmu-events.c            |  68 ++---
 tools/perf/util/cgroup.c                 |   1 -
 tools/perf/util/evsel.c                  |   2 -
 tools/perf/util/evsel.h                  |   2 -
 tools/perf/util/metricgroup.c            | 203 +++++++------
 tools/perf/util/metricgroup.h            |   4 +-
 tools/perf/util/parse-events.c           |   2 -
 tools/perf/util/pmu.c                    |  44 +--
 tools/perf/util/pmu.h                    |  10 +-
 tools/perf/util/print-events.c           |  32 +--
 tools/perf/util/print-events.h           |   3 +-
 tools/perf/util/python.c                 |   7 -
 tools/perf/util/stat-shadow.c            | 112 --------
 tools/perf/util/stat.h                   |   1 -
 26 files changed, 650 insertions(+), 461 deletions(-)

--=20
2.39.0.246.g2a6d74b583-goog

