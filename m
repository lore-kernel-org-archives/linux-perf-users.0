Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C98C6FA82
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 08:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiIWILb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiIWILa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 04:11:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15512C1C2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 01:11:28 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYl9x5Lw7z1P6rZ;
        Fri, 23 Sep 2022 16:07:17 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 16:11:26 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 16:11:25 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <yao.jin@linux.intel.com>, <shangxiaojing@huawei.com>
Subject: [PATCH v2 1/6] perf block-info: Merge branches in __block_info__cmp
Date:   Fri, 23 Sep 2022 16:45:35 +0800
Message-ID: <20220923084540.25849-2-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220923084540.25849-1-shangxiaojing@huawei.com>
References: <20220923084540.25849-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 3e152aa984ff ("perf block-info: Fix wrong block address
comparison in block_info__cmp()") fixes the return value of
__block_info__cmp(), which result in the redundant if statment. Merge
the two branches having the same behavior in __block_info__cmp() into one.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
---
changes in v2:
- add 3e152aa984ff msg
---
 tools/perf/util/block-info.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 5ecd4f401f32..e901bb6c88f8 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -72,9 +72,7 @@ int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right)
 	int cmp;
 
 	if (!bi_l->sym || !bi_r->sym) {
-		if (!bi_l->sym && !bi_r->sym)
-			return -1;
-		else if (!bi_l->sym)
+		if (!bi_l->sym)
 			return -1;
 		else
 			return 1;
-- 
2.17.1

