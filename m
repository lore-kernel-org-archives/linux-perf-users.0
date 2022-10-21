Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2FAC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 08:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJUIyz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiJUIyl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 04:54:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3BC4F38E
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 01:54:37 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mtyp51gmyz15Lxf;
        Fri, 21 Oct 2022 16:49:49 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:54:16 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 16:54:15 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 2/3] perf vendor events arm64: Add HiSilicon hip08 core events
Date:   Fri, 21 Oct 2022 16:53:25 +0800
Message-ID: <20221021085326.17139-3-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021085326.17139-1-shangxiaojing@huawei.com>
References: <20221021085326.17139-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add some core events of hip08 to the corresponding core-imp-def.json.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 .../arm64/hisilicon/hip08/core-imp-def.json   | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
index a4a6408639b4..f9a90d6a958d 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
@@ -53,6 +53,36 @@
     {
         "ArchStdEvent": "L2D_CACHE_INVAL"
     },
+    {
+        "PublicDescription": "Number of predictable branches predicted by static predictor",
+        "EventCode": "0x1001",
+        "EventName": "IF_BP_PRED_BR_SP",
+        "BriefDescription": "Static predictor predict count"
+    },
+    {
+        "PublicDescription": "Number of mispredicted procedure returns",
+        "EventCode": "0x100d",
+        "EventName": "IF_BP_MISP_BR_RET",
+        "BriefDescription": "Mispredicted procedures"
+    },
+    {
+        "PublicDescription": "Number of mispredicted indirect branches",
+        "EventCode": "0x1010",
+        "EventName": "IF_BP_MISP_BR_IND",
+        "BriefDescription": "Mispredicted indirect branches"
+    },
+    {
+        "PublicDescription": "Number of mispredicted BLR branches",
+        "EventCode": "0x1013",
+        "EventName": "IF_BP_MISP_BR_BLR",
+        "BriefDescription": "Mispredicted BLR branches"
+    },
+    {
+        "PublicDescription": "Number of mispredicted BL branches",
+        "EventCode": "0x1016",
+        "EventName": "IF_BP_MISP_BR_BL",
+        "BriefDescription": "Mispredicted BL branches"
+    },
     {
         "PublicDescription": "Level 1 instruction cache prefetch access count",
         "EventCode": "0x102e",
@@ -77,12 +107,90 @@
         "EventName": "IF_IS_STALL",
         "BriefDescription": "Instruction fetch stall cycles"
     },
+    {
+        "PublicDescription": "Number of times ROB is full",
+        "EventCode": "0x2004",
+        "EventName": "ROB_STALL",
+        "BriefDescription": "ROB stall"
+    },
+    {
+        "PublicDescription": "Number of times PC buffer is full",
+        "EventCode": "0x2005",
+        "EventName": "PCBUF_STALL",
+        "BriefDescription": "PC buffer stall"
+    },
+    {
+        "PublicDescription": "No INT ptag allocated from free list",
+        "EventCode": "0x2006",
+        "EventName": "INT_PTAG_STALL",
+        "BriefDescription": "INT ptag stall"
+    },
+    {
+        "PublicDescription": "No CC ptag allocated from free list",
+        "EventCode": "0x2007",
+        "EventName": "CC_PTAG_STALL",
+        "BriefDescription": "CC ptag stall"
+    },
+    {
+        "PublicDescription": "No VFP ptag allocated from free list",
+        "EventCode": "0x2008",
+        "EventName": "VFP_PTAG_STALL",
+        "BriefDescription": "VFP ptag stall"
+    },
+    {
+        "PublicDescription": "Issue queue of ALU is full",
+        "EventCode": "0x200b",
+        "EventName": "ALU_ISQ_STALL",
+        "BriefDescription": "ALU issue queue stall"
+    },
+    {
+        "PublicDescription": "Issue queue of LSU is full",
+        "EventCode": "0x200c",
+        "EventName": "LSU_ISQ_STALL",
+        "BriefDescription": "LSU issueQ stall"
+    },
+    {
+        "PublicDescription": "Issue queue of FSU is full",
+        "EventCode": "0x200d",
+        "EventName": "FSU_ISQ_STALL",
+        "BriefDescription": "FSU issueQ stall"
+    },
+    {
+        "PublicDescription": "Sync buffer is full",
+        "EventCode": "0x2010",
+        "EventName": "SYNC_STALL",
+        "BriefDescription": "Sync buffer stall"
+    },
+    {
+        "PublicDescription": "LSU nuke flush caused by incorrect data from speculative execution",
+        "EventCode": "0x2012",
+        "EventName": "NUKE_FLUSH",
+        "BriefDescription": "LSU nuke flush"
+    },
+    {
+        "PublicDescription": "OoO ROB flush",
+        "EventCode": "0x2013",
+        "EventName": "OOO_FLUSH",
+        "BriefDescription": "OoO ROB flush"
+    },
     {
         "PublicDescription": "Instructions can receive, but not send",
         "EventCode": "0x2014",
         "EventName": "FETCH_BUBBLE",
         "BriefDescription": "Instructions can receive, but not send"
     },
+    {
+        "PublicDescription": "Cycles of Fetch bubble >= 4",
+        "EventCode": "0x201d",
+        "EventName": "FETCH_BUBBLE_EXCEEDMIW",
+        "BriefDescription": "Cycles of Fetch bubble >= 4"
+    },
+    {
+        "PublicDescription": "SaveOp queue is full",
+        "EventCode": "0x201e",
+        "EventName": "SAVEOP_QUEUE_STALL",
+        "BriefDescription": "SaveOp queue stall"
+    },
     {
         "PublicDescription": "Prefetch request from LSU",
         "EventCode": "0x6013",
@@ -95,18 +203,42 @@
         "EventName": "HIT_ON_PRF",
         "BriefDescription": "Hit on prefetched data"
     },
+    {
+        "PublicDescription": "OoO Stall & Inst in OoO but No_Dispatch & IssueQ_can_Accept",
+        "EventCode": "0x7000",
+        "EventName": "RESOURCE_BOUND",
+        "BriefDescription": "OoO Stall & Inst in OoO but No_Dispatch & IssueQ_can_Accept"
+    },
     {
         "PublicDescription": "Cycles of that the number of issuing micro operations are less than 4",
         "EventCode": "0x7001",
         "EventName": "EXE_STALL_CYCLE",
         "BriefDescription": "Cycles of that the number of issue ups are less than 4"
     },
+    {
+        "PublicDescription": "No any micro operation is issued & no memstall & executing DIV operation",
+        "EventCode": "0x7002",
+        "EventName": "EXE_STALL_DIV",
+        "BriefDescription": "No any micro operation is issued & no memstall & executing DIV operation"
+    },
+    {
+        "PublicDescription": "No INT operation is issued & no FSU operation is issued & executing FSU operation",
+        "EventCode": "0x7003",
+        "EventName": "FSU_STALL",
+        "BriefDescription": "No INT operation is issued & no FSU operation is issued & executing FSU operation"
+    },
     {
         "PublicDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
         "EventCode": "0x7004",
         "EventName": "MEM_STALL_ANYLOAD",
         "BriefDescription": "No any micro operation is issued and meanwhile any load operation is not resolved"
     },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile any store operation is not resolved",
+        "EventCode": "0x7005",
+        "EventName": "MEM_STALL_ANYSTORE",
+        "BriefDescription": "No any micro operation is issued and meanwhile any store operation is not resolved"
+    },
     {
         "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
         "EventCode": "0x7006",
-- 
2.17.1

