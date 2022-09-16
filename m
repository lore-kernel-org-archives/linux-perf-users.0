Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F7ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 02:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIPCWK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiIPCWK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 22:22:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C3792E5
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 19:22:09 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTHmW5FkrzmVC7;
        Fri, 16 Sep 2022 10:18:19 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 10:22:07 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 10:22:01 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 2/8] perf lock: Fix error return code in __cmd_contention
Date:   Fri, 16 Sep 2022 10:56:21 +0800
Message-ID: <20220916025627.13967-3-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220916025627.13967-1-shangxiaojing@huawei.com>
References: <20220916025627.13967-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As the return error code in __cmd_contention may has been assigned when
use_bpf is true, set the error code to -EINVAL or the specific error code
of the function.

BTW, the error code of add_output_field is also changed to ensure
setup_output_field can return specific error code instead of -1.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-lock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 44a47648b7fe..c11ee901c238 100644
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

