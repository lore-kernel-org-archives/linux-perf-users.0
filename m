Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C57C38A02
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Oct 2022 03:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ2Dld (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ2Dlc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2022 23:41:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890553679B
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 20:41:28 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MzlSr4DxdzmVRs;
        Sat, 29 Oct 2022 11:36:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 11:41:25 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 29 Oct
 2022 11:41:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <ravi.bangoria@amd.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] perf/core: Using kfree_rcu() to simplify the code in put_ctx()
Date:   Sat, 29 Oct 2022 11:40:27 +0800
Message-ID: <20221029034027.2006045-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

After commit 983bd8543b5a ("perf: Rewrite core context handling"),
the callback function of call_rcu() just calls a kfree(), so we
can use kfree_rcu() instead of call_rcu() + callback function.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/events/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ebd9ebd53238..9bb274dd2aa6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1157,14 +1157,6 @@ static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
 		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
 }
 
-static void free_ctx(struct rcu_head *head)
-{
-	struct perf_event_context *ctx;
-
-	ctx = container_of(head, struct perf_event_context, rcu_head);
-	kfree(ctx);
-}
-
 static void put_ctx(struct perf_event_context *ctx)
 {
 	if (refcount_dec_and_test(&ctx->refcount)) {
@@ -1172,7 +1164,7 @@ static void put_ctx(struct perf_event_context *ctx)
 			put_ctx(ctx->parent_ctx);
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
 			put_task_struct(ctx->task);
-		call_rcu(&ctx->rcu_head, free_ctx);
+		kfree_rcu(ctx, rcu_head);
 	}
 }
 
-- 
2.25.1

