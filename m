Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC1C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 06:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjG1GRg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjG1GRg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 02:17:36 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714491FF5;
        Thu, 27 Jul 2023 23:17:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VoOxEFh_1690525042;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoOxEFh_1690525042)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 14:17:29 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v5 0/5] Add aliases and metrics for Arm CMN
Date:   Fri, 28 Jul 2023 14:17:15 +0800
Message-Id: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v4:
- Support "Compat" to match multiple identifiers for regular events
  aliases as suggested by John.
- Add self-test cases for "Compat" new feature and new event_filed
  as suggested by John.
- Link: https://lore.kernel.org/all/1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com/

Jing Zhang (5):
  perf metric: Event "Compat" value supports matching multiple
    identifiers
  perf jevents: Support more event fields
  perf test: Add pmu-event test for "Compat" and new event_field.
  perf jevents: Add support for Arm CMN PMU aliasing
  perf vendor events: Add JSON metrics for Arm CMN

 .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
 .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
 .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
 tools/perf/pmu-events/jevents.py                   |  22 +-
 tools/perf/tests/pmu-events.c                      |  55 +++++
 tools/perf/util/metricgroup.c                      |   2 +-
 tools/perf/util/pmu.c                              |  27 ++-
 tools/perf/util/pmu.h                              |   1 +
 8 files changed, 445 insertions(+), 10 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json

-- 
1.8.3.1

