Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A6C43217
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 08:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJUIyj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJUIyc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 04:54:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3144F38E
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 01:54:28 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtynv6qt0zmVJL;
        Fri, 21 Oct 2022 16:49:39 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:54:14 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 16:54:13 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 0/3] perf vendor events arm64: Fix incorrect metrics and improve readability
Date:   Fri, 21 Oct 2022 16:53:23 +0800
Message-ID: <20221021085326.17139-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

First fix the incorrect hip08 metrics, then add some core events to the
JSON file. Last, change the event code to the event name for improving
readability.

Shang XiaoJing (3):
  perf vendor events arm64: Fix incorrect Hisi hip08 L3 metrics
  perf vendor events arm64: Add HiSilicon hip08 core events
  perf vendor events arm64: Use event name instead of event code

 .../arm64/hisilicon/hip08/core-imp-def.json   | 132 ++++++++++++++++++
 .../arch/arm64/hisilicon/hip08/metrics.json   |  50 +++----
 2 files changed, 157 insertions(+), 25 deletions(-)

-- 
2.17.1

