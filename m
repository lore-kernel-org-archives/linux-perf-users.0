Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E0DECAAD3
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 12:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiINMBF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiINMAm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 08:00:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE6E7EFE4
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 05:00:40 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSJhm3b0wzlVhx;
        Wed, 14 Sep 2022 19:56:40 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 20:00:38 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 20:00:37 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 2/5] perf block-range: Add block_range__insert_XXX helper
Date:   Wed, 14 Sep 2022 20:35:04 +0800
Message-ID: <20220914123507.23319-3-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914123507.23319-1-shangxiaojing@huawei.com>
References: <20220914123507.23319-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wrap repeated and correlated code in helper function
block_range__insert_left and block_range__insert_right, which used for
inserting the new block_range into rb_tree.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/util/block-range.c | 36 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 1be432657501..11c6f33524f0 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -71,6 +71,22 @@ static inline void rb_link_right_of_node(struct rb_node *right, struct rb_node *
 	rb_link_node(right, node, p);
 }
 
+static inline void block_range__insert_left(struct block_range *insert,
+					     struct block_range *parent)
+{
+	rb_link_left_of_node(&insert->node, &parent->node);
+	rb_insert_color(&insert->node, &block_ranges.root);
+	block_range__debug();
+}
+
+static inline void block_range__insert_right(struct block_range *insert,
+					      struct block_range *parent)
+{
+	rb_link_right_of_node(&insert->node, &parent->node);
+	rb_insert_color(&insert->node, &block_ranges.root);
+	block_range__debug();
+}
+
 /**
  * block_range__create
  * @start: branch target starting this basic block
@@ -128,9 +144,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 				.is_branch	= 0,
 			};
 
-			rb_link_left_of_node(&head->node, &next->node);
-			rb_insert_color(&head->node, &block_ranges.root);
-			block_range__debug();
+			block_range__insert_left(head, next);
 
 			iter.start = head;
 			goto do_tail;
@@ -182,9 +196,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 		entry->is_target	= 1;
 		entry->entry		= 0;
 
-		rb_link_left_of_node(&head->node, &entry->node);
-		rb_insert_color(&head->node, &block_ranges.root);
-		block_range__debug();
+		block_range__insert_left(head, entry);
 
 	} else if (entry->start == start)
 		entry->is_target = 1;
@@ -222,9 +234,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 			entry->taken		= 0;
 			entry->pred		= 0;
 
-			rb_link_right_of_node(&tail->node, &entry->node);
-			rb_insert_color(&tail->node, &block_ranges.root);
-			block_range__debug();
+			block_range__insert_right(tail, entry);
 
 			iter.end = entry;
 			goto done;
@@ -260,9 +270,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 				.is_branch	= 1,
 			};
 
-			rb_link_right_of_node(&tail->node, &entry->node);
-			rb_insert_color(&tail->node, &block_ranges.root);
-			block_range__debug();
+			block_range__insert_right(tail, entry);
 
 			iter.end = tail;
 			goto done;
@@ -283,9 +291,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 				.is_branch	= 0,
 			};
 
-			rb_link_left_of_node(&hole->node, &next->node);
-			rb_insert_color(&hole->node, &block_ranges.root);
-			block_range__debug();
+			block_range__insert_left(hole, next);
 		}
 
 		entry = next;
-- 
2.17.1

