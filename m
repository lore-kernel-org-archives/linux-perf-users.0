Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9271CD13D8
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Sep 2023 11:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbjIRLxH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Sep 2023 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241750AbjIRLw4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2023 07:52:56 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BFEA;
        Mon, 18 Sep 2023 04:52:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VsMQsgH_1695037957;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VsMQsgH_1695037957)
          by smtp.aliyun-inc.com;
          Mon, 18 Sep 2023 19:52:44 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v9 0/7] Add metrics for Arm CMN
Date:   Mon, 18 Sep 2023 19:52:28 +0800
Message-Id: <1695037955-107983-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v8:
- Compat uses regular expression matching identifier as suggested by Ian.
- Remove [PATCH v8 3/8] and workaround CMN event description issues
  through jevent.py as suggested by Ian.
- Link: https://lore.kernel.org/all/1694087913-46144-1-git-send-email-renyu.zj@linux.alibaba.com/

Jing Zhang (7):
  perf pmu: "Compat" supports regular expression matching identifiers
  perf metric: "Compat" supports regular expression matching identifiers
  perf jevents: Support EventidCode and NodeType
  perf test: Make matching_pmu effective
  perf test: Add pmu-event test for "Compat" and new event_field.
  perf jevents: Add support for Arm CMN PMU aliasing
  perf vendor events: Add JSON metrics for Arm CMN

 .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
 .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
 .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
 tools/perf/pmu-events/empty-pmu-events.c           |   8 +
 tools/perf/pmu-events/jevents.py                   |  11 +-
 tools/perf/tests/pmu-events.c                      |  65 ++++-
 tools/perf/util/metricgroup.c                      |   2 +-
 tools/perf/util/pmu.c                              |  23 +-
 tools/perf/util/pmu.h                              |   1 +
 9 files changed, 452 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json

-- 
1.8.3.1

