Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A09C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 10:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJUKvg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJUKvf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 06:51:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30224D8A0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 03:51:33 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mv1P12XKdz15Ly4;
        Fri, 21 Oct 2022 18:46:45 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:51:24 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 18:51:23 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2 1/3] perf vendor events arm64: Fix incorrect Hisi hip08 L3 metrics
Date:   Fri, 21 Oct 2022 18:50:33 +0800
Message-ID: <20221021105035.10000-2-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021105035.10000-1-shangxiaojing@huawei.com>
References: <20221021105035.10000-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3
metrics") add L3 metrics of hip08, but some metrics (IF_BP_MISP_BR_RET,
IF_BP_MISP_BR_RET, IF_BP_MISP_BR_BL) have incorrect event number due to
the mistakes in document, which caused incorrect result. Fix the
incorrect metrics.

before:
65,811,214,308	armv8_pmuv3_0/event=0x1014/	# 18.87 push_branch
						# -40.19 other_branch
3,564,316,780	BR_MIS_PRED			# 0.51 indirect_branch
						# 21.81 pop_branch

after:
6,537,146,245	BR_MIS_PRED			# 0.48 indirect_branch
						# 0.47 pop_branch
						# 0.00 push_branch
						# 0.05 other_branch

Fixes: 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3 metrics")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Cc: John Garry <john.garry@huawei.com>
Acked-by: James Clark <james.clark@arm.com>
---
changes in v2:
- adjust commit msg.
---
 .../perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
index 6970203cb247..6443a061e22a 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -112,21 +112,21 @@
         "MetricName": "indirect_branch"
     },
     {
-        "MetricExpr": "(armv8_pmuv3_0@event\\=0x1014@ + armv8_pmuv3_0@event\\=0x1018@) / BR_MIS_PRED",
+        "MetricExpr": "(armv8_pmuv3_0@event\\=0x1013@ + armv8_pmuv3_0@event\\=0x1016@) / BR_MIS_PRED",
         "PublicDescription": "Push branch L3 topdown metric",
         "BriefDescription": "Push branch L3 topdown metric",
         "MetricGroup": "TopDownL3",
         "MetricName": "push_branch"
     },
     {
-        "MetricExpr": "armv8_pmuv3_0@event\\=0x100c@ / BR_MIS_PRED",
+        "MetricExpr": "armv8_pmuv3_0@event\\=0x100d@ / BR_MIS_PRED",
         "PublicDescription": "Pop branch L3 topdown metric",
         "BriefDescription": "Pop branch L3 topdown metric",
         "MetricGroup": "TopDownL3",
         "MetricName": "pop_branch"
     },
     {
-        "MetricExpr": "(BR_MIS_PRED - armv8_pmuv3_0@event\\=0x1010@ - armv8_pmuv3_0@event\\=0x1014@ - armv8_pmuv3_0@event\\=0x1018@ - armv8_pmuv3_0@event\\=0x100c@) / BR_MIS_PRED",
+        "MetricExpr": "(BR_MIS_PRED - armv8_pmuv3_0@event\\=0x1010@ - armv8_pmuv3_0@event\\=0x1013@ - armv8_pmuv3_0@event\\=0x1016@ - armv8_pmuv3_0@event\\=0x100d@) / BR_MIS_PRED",
         "PublicDescription": "Other branch L3 topdown metric",
         "BriefDescription": "Other branch L3 topdown metric",
         "MetricGroup": "TopDownL3",
-- 
2.17.1

