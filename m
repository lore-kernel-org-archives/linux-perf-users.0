Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C00C001E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 07:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjG1HKE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 03:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjG1HJy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 03:09:54 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43D73C1D;
        Fri, 28 Jul 2023 00:09:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VoP1osc_1690528178;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoP1osc_1690528178)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 15:09:42 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v5 0/3] Add aliases and JSON metrics for Yitian710 DDR
Date:   Fri, 28 Jul 2023 15:09:32 +0800
Message-Id: <1690528175-2499-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I add aliases and JSON metrics for Yitian710 DDR. The kernel part that
this series depends on has been applied to for-next/perf. And this series
have all been reviewed. Can you help to apply them? Thank you.

Thanks,
Jing

Change since v4:
- Kernel patch has applied to for-next/perf, so this patchset only has
  tools part and docs.
- Fixed patch conflicts.
- Link: https://lore.kernel.org/all/1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com/

Jing Zhang (3):
  perf jevents: Add support for Yitian 710 DDR PMU aliasing
  perf vendor events: Add JSON metrics for Yitian 710 DDR
  docs: perf: Update metric usage for Alibaba's T-Head PMU driver

 Documentation/admin-guide/perf/alibaba_pmu.rst     |   5 +
 .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
 .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
 tools/perf/pmu-events/jevents.py                   |   1 +
 4 files changed, 399 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json

-- 
1.8.3.1

