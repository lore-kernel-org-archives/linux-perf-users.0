Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87458C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Apr 2022 11:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388622AbiDULO2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Apr 2022 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiDULO0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Apr 2022 07:14:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E646DFEB;
        Thu, 21 Apr 2022 04:11:37 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KkZbz6KDCzhXZq;
        Thu, 21 Apr 2022 19:11:27 +0800 (CST)
Received: from huawei.com (10.67.174.166) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 19:11:34 +0800
From:   Zucheng Zheng <zhengzucheng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] perf/x86/amd: Remove unused variable 'hwc'
Date:   Thu, 21 Apr 2022 19:10:31 +0800
Message-ID: <20220421111031.174698-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.166]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

'hwc' is never used in amd_pmu_enable_all(), so remove it.

-------------------------------

Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
---
 arch/x86/events/amd/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8e1e818f8195..d7f9500b876d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -714,14 +714,11 @@ static void amd_pmu_enable_event(struct perf_event *event)
 static void amd_pmu_enable_all(int added)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct hw_perf_event *hwc;
 	int idx;
 
 	amd_brs_enable_all();
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
-		hwc = &cpuc->events[idx]->hw;
-
 		/* only activate events which are marked as active */
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-- 
2.18.0.huawei.25

