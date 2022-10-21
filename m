Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D9CC4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 10:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJUKwB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJUKv7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 06:51:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1D11E1945
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 03:51:58 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mv1Vp4J3kzHv8X;
        Fri, 21 Oct 2022 18:51:46 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:51:23 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 18:51:22 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2 0/3] perf vendor events arm64: Fix incorrect metrics and improve readability
Date:   Fri, 21 Oct 2022 18:50:32 +0800
Message-ID: <20221021105035.10000-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

First fix the incorrect hip08 metrics, then add some core events to the
JSON file. Last, change the event code to the event name for improving
readability.

---
changes in v2:
- adjust commit msg of 1st patch.
- fix tab in 3rd patch.
---

Shang XiaoJing (3):
  perf vendor events arm64: Fix incorrect Hisi hip08 L3 metrics
  perf vendor events arm64: Add HiSilicon hip08 core events
  perf vendor events arm64: Use event name instead of event code

 .../arm64/hisilicon/hip08/core-imp-def.json   | 132 ++++++++++++++++++
 .../arch/arm64/hisilicon/hip08/metrics.json   |  48 +++----
 2 files changed, 156 insertions(+), 24 deletions(-)

-- 
2.17.1

