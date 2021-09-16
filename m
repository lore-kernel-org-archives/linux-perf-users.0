Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C231AC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76C760F6D
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhIPMkr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:40:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3836 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbhIPMkq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:46 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H9Gmz2s5Wz67bGM;
        Thu, 16 Sep 2021 20:37:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 14:39:23 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 13:39:19 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <irogers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <liuqi115@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] Improve perf list support for hisi uncore PMUs
Date:   Thu, 16 Sep 2021 20:34:20 +0800
Message-ID: <1631795665-240946-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently event aliases are supported for HiSilicon uncore PMUs, such that
we get events listed like the following:

$perf list
...
uncore ddrc:
  uncore_hisi_ddrc.act_cmd
       [DDRC active commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.flux_rcmd
       [DDRC read commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.flux_rd 
       [DDRC total read operations. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.flux_wcmd
... 

However we still get the events listed from the PMUs event files, like:

$perf list
...
  hisi_sccl1_ddrc0/act_cmd/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_rcmd/                        [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_rd/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_wcmd/                        [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_wr/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/pre_cmd/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/rnk_chg/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/rw_chg/                           [Kernel PMU event]
  hisi_sccl1_ddrc1/act_cmd/                          [Kernel PMU event]
...   

The list of events will include every event for every PMU in the sysfs event
folder, so the list can be huge:

$perf list | grep hisi_scc | wc -l
783

And it will get larger for the next gen of HiSi SoCs, which has more PMUs.

Fortunately the perf PMU code can merge events when an alias with the
same name exists. So renaming the events in the JSONs to remove the
"uncore_hisi_XXX." prefix from the name to fully match the sysfs
name will mean events are merged. The list will then not show the
individual events per PMU, and rather just the aliases:

$perf list
...
uncore ddrc:
  act_cmd
       [DDRC active commands. Unit: hisi_sccl,ddrc]
  flux_rcmd
       [DDRC read commands. Unit: hisi_sccl,ddrc]
  flux_rd
       [DDRC total read operations. Unit: hisi_sccl,ddrc]
  flux_wcmd
       [DDRC write commands. Unit: hisi_sccl,ddrc]
...

To get the stat for the event, just run something like this:

$perf stat -v -e act_cmd sleep 1                
Using CPUID 0x00000000480fd010
act_cmd -> hisi_sccl1_ddrc0/config=0x5/
act_cmd -> hisi_sccl3_ddrc1/config=0x5/
act_cmd -> hisi_sccl5_ddrc2/config=0x5/
act_cmd -> hisi_sccl7_ddrc3/config=0x5/
act_cmd -> hisi_sccl5_ddrc0/config=0x5/
Control descriptor is not initialized
act_cmd: 0 1001546260 1001546260
act_cmd: 0 1001542780 1001542780
act_cmd: 0 1001531630 1001531630
act_cmd: 0 1001518570 1001518570
act_cmd: 0 1001527830 1001527830

 Performance counter stats for 'system wide':  

            48,142      act_cmd

       1.001518294 seconds time elapsed

And to run for an individual PMU, run something like this:

$perf stat -v -e hisi_sccl1_ddrc0/act_cmd/ sleep 1

hisi_sccl1_ddrc0/act_cmd/: 0 1000818310 1000818310

 Performance counter stats for 'system wide':

                 0      hisi_sccl1_ddrc0/act_cmd/

       1.000827061 seconds time elapsed

I expect that having the same event name for different types of PMUs
may give unexpected results, so best to use -v option to verify the 
PMUs used are as expected.

John Garry (5):
  perf parse-events: Set numeric term config
  perf jevents: Support ConfigCode
  perf test: Verify more event members in pmu-events test
  perf test: Add pmu-event test for event described as "config="
  perf vendor events arm64: Revise hip08 uncore events

 .../arm64/hisilicon/hip08/uncore-ddrc.json    |  32 ++---
 .../arm64/hisilicon/hip08/uncore-hha.json     | 120 +++++++++++++++---
 .../arm64/hisilicon/hip08/uncore-l3c.json     |  52 ++++----
 .../arch/test/test_soc/sys/uncore.json        |   7 +
 tools/perf/pmu-events/jevents.c               |  13 +-
 tools/perf/tests/parse-events.c               |   8 +-
 tools/perf/tests/pmu-events.c                 |  81 ++++++++++--
 tools/perf/util/parse-events.c                |   2 +-
 8 files changed, 234 insertions(+), 81 deletions(-)

-- 
2.26.2

