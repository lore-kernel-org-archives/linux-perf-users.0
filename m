Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D0C6FA8B
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIWN1k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIWN1d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 09:27:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F30713BCC5
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 06:27:32 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYtBq5cRQzWh8R;
        Fri, 23 Sep 2022 21:23:31 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 21:27:30 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 21:27:29 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <alexey.v.bayduraev@linux.intel.com>, <yao.jin@linux.intel.com>,
        <dsahern@gmail.com>, <alexander.antonov@linux.intel.com>,
        <shangxiaojing@huawei.com>
Subject: [PATCH v2 1/7] perf lock: Fix error return code in __cmd_contention()
Date:   Fri, 23 Sep 2022 22:01:37 +0800
Message-ID: <20220923140143.21552-2-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220923140143.21552-1-shangxiaojing@huawei.com>
References: <20220923140143.21552-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 6fda2405f414 ("perf lock: Implement cpu and task filters for
BPF") inserts code to the __cmd_contention() that assigns to the error
code, but not assigned when lock_contention_prepare failed. Besides, 
the following checks should return the default error code when failed.

BTW, the error code of add_output_field is also changed to ensure
setup_output_field can return specific error code instead of -1.

Fixes: 6fda2405f414 ("perf lock: Implement cpu and task filters for
BPF")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
changes in v2:
- add fix msg
---
 tools/perf/builtin-lock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 52a6a10a610c..8c4a641ea9ad 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -335,7 +335,7 @@ static int add_output_field(bool contention, char *name)
 	}
 
 	pr_err("Unknown output field: %s\n", name);
-	return -1;
+	return -EINVAL;
 }
 
 static int setup_output_field(bool contention, const char *str)
@@ -1626,6 +1626,7 @@ static int __cmd_contention(int argc, const char **argv)
 
 		if (lock_contention_prepare(&con) < 0) {
 			pr_err("lock contention BPF setup failed\n");
+			err = -EINVAL;
 			goto out_delete;
 		}
 	} else {
@@ -1645,11 +1646,14 @@ static int __cmd_contention(int argc, const char **argv)
 		}
 	}
 
-	if (setup_output_field(true, output_fields))
+	err = setup_output_field(true, output_fields);
+	if (err < 0)
 		goto out_delete;
 
-	if (select_key(true))
+	if (select_key(true)) {
+		err = -EINVAL;
 		goto out_delete;
+	}
 
 	if (show_thread_stats)
 		aggr_mode = LOCK_AGGR_TASK;
-- 
2.17.1

