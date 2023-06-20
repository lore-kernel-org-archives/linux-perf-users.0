Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480BEEB64DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jun 2023 07:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjFTHMw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 03:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFTHMv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jun 2023 03:12:51 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B346E7;
        Tue, 20 Jun 2023 00:12:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VlamlVY_1687245158;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VlamlVY_1687245158)
          by smtp.aliyun-inc.com;
          Tue, 20 Jun 2023 15:12:44 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.g.garry@oracle.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v4 0/4] Add JSON metrics for Yitian710 DDR
Date:   Tue, 20 Jun 2023 15:12:32 +0800
Message-Id: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all,

I add an identifier sysfs file for the yitian710 SoC DDR to allow
userspace to identify the specific implementation of the device,
so that the perf tool can match the corresponding uncore events and
metrics through the identifier. Then added yitian710 SoC DDR
metrics and events alias.

Change since v3:
- Split the CMN and ali_drw patches. This patchset only contains
  ali_drw PMU related patches. The CMN metric related patches will
  be in another patchset.
- Link: https://lore.kernel.org/all/1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com/

$perf list:
...
ali_drw:
  chi_rxdat
       [A packet at CHI RXDAT interface (write data). Unit: ali_drw]
  chi_rxrsp
       [A packet at CHI RXRSP interface. Unit: ali_drw]
  chi_txdat
       [A packet at CHI TXDAT interface (read data). Unit: ali_drw]
  chi_txreq
       [A packet at CHI TXREQ interface (request). Unit: ali_drw]
  cycle
       [The ddr cycle. Unit: ali_drw]
...
ali_drw:
  ddr_read_bandwidth.all
       [The ddr read bandwidth(MB/s). Unit: ali_drw ]
  ddr_write_bandwidth.all
       [The ddr write bandwidth(MB/s). Unit: ali_drw ]
...

$perf stat -M ddr_read_bandwidth.all ./test

Performance counter stats for 'system wide':

            38,150      hif_rd        #  2.4 MB/s  ddr_read_bandwidth.all
     1,000,957,941 ns   duration_time

       1.000957941 seconds time elapsed

Jing Zhang (4):
  driver/perf: Add identifier sysfs file for Yitian 710 DDR
  perf jevents: Add support for Yitian 710 DDR PMU aliasing
  perf vendor events: Add JSON metrics for Yitian 710 DDR
  docs: perf: Update metric usage for Alibaba's T-Head PMU driver

 Documentation/admin-guide/perf/alibaba_pmu.rst     |   5 +
 drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
 .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
 .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
 tools/perf/pmu-events/jevents.py                   |   1 +
 5 files changed, 426 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json

-- 
1.8.3.1

