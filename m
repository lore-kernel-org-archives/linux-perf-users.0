Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AFAC32771
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 02:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIPCWL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIPCWK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 22:22:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F279638
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 19:22:09 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTHmH18v5zlVwY;
        Fri, 16 Sep 2022 10:18:07 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 10:22:07 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 10:22:00 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 1/8] perf c2c: Fix error return code in perf_c2c__report
Date:   Fri, 16 Sep 2022 10:56:20 +0800
Message-ID: <20220916025627.13967-2-shangxiaojing@huawei.com>
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

As the return error code of perf_c2c__report may has been assigned in
front, set the error code to -EINVAL or the specific error code of the
function.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-c2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 12f272811487..1fe5650d9b51 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3110,6 +3110,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (err)
 		goto out_mem2node;
 
+	err = -EINVAL;
+
 	if (symbol__init(&session->header.env) < 0)
 		goto out_mem2node;
 
@@ -3182,7 +3184,8 @@ static int perf_c2c__report(int argc, const char **argv)
 
 	ui_progress__finish();
 
-	if (ui_quirks()) {
+	err = ui_quirks();
+	if (err) {
 		pr_err("failed to setup UI\n");
 		goto out_mem2node;
 	}
-- 
2.17.1

