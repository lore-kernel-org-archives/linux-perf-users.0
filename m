Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ADEC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 09:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiKNJSk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiKNJSj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 04:18:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4E5FD6
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 01:18:37 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N9kCs0jZ3zqSPN;
        Mon, 14 Nov 2022 17:14:49 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 17:18:34 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <ravi.bangoria@amd.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-perf-users@vger.kernel.org>
Subject: [PATCH -next] perf: Fix IS_ERR() vs NULL check in inherit_event()
Date:   Mon, 14 Nov 2022 17:18:33 +0800
Message-ID: <20221114091833.1492575-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The find_get_pmu_context() returns an ERR_PTR() on failure, we should use
IS_ERR() to check the return value.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c7157f8d8d2f..9ea1f2514fa4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13187,7 +13187,7 @@ inherit_event(struct perf_event *parent_event,
 		return child_event;
 
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
-	if (!pmu_ctx) {
+	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
 		return NULL;
 	}
-- 
2.25.1

