Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126BAC07E9D
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Sep 2022 01:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiI0BmO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiI0BmN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 21:42:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5AA00CF
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 18:42:11 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc2NL5nQKzpVM8;
        Tue, 27 Sep 2022 09:39:14 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 09:42:09 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 3/5] perf metric: Remove unused struct metric_ref_node
Date:   Tue, 27 Sep 2022 01:39:29 +0000
Message-ID: <20220927013931.110475-4-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927013931.110475-1-yuancan@huawei.com>
References: <20220927013931.110475-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

After commit 46bdc0bf8d21("perf metric: Simplify metric_refs calculation"), no
one use struct metric_ref_node, so remove it.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 tools/perf/util/metricgroup.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b18da1a62a55..4c98ac29ee13 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -109,17 +109,6 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
 	rblist__exit(metric_events);
 }
 
-/*
- * A node in the list of referenced metrics. metric_expr
- * is held as a convenience to avoid a search through the
- * metric list.
- */
-struct metric_ref_node {
-	const char *metric_name;
-	const char *metric_expr;
-	struct list_head list;
-};
-
 /**
  * The metric under construction. The data held here will be placed in a
  * metric_expr.
-- 
2.17.1

