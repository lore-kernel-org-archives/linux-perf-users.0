Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5797C6FA82
	for <linux-perf-users@archiver.kernel.org>; Sat,  3 Sep 2022 06:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiICGvF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 3 Sep 2022 02:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiICGvC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 3 Sep 2022 02:51:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB22481C0;
        Fri,  2 Sep 2022 23:51:01 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MKQKv12F6zWfBL;
        Sat,  3 Sep 2022 14:46:27 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 3 Sep 2022 14:50:53 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 3 Sep
 2022 14:50:52 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 1/3] perf clean: Add same_cmd_with_prefix helper
Date:   Sat, 3 Sep 2022 15:25:40 +0800
Message-ID: <20220903072542.27678-2-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220903072542.27678-1-shangxiaojing@huawei.com>
References: <20220903072542.27678-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wrap repeated code in helper function same_cmd_with_prefix for more
clearly.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/perf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index c21b3973641a..7af135dea1cd 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -99,10 +99,16 @@ struct pager_config {
 	int val;
 };
 
+static bool same_cmd_with_prefix(const char *var, struct pager_config *c,
+				  const char *header)
+{
+	return (strstarts(var, header) && !strcmp(var + strlen(header), c->cmd));
+}
+
 static int pager_command_config(const char *var, const char *value, void *data)
 {
 	struct pager_config *c = data;
-	if (strstarts(var, "pager.") && !strcmp(var + 6, c->cmd))
+	if (same_cmd_with_prefix(var, c, "pager."))
 		c->val = perf_config_bool(var, value);
 	return 0;
 }
@@ -121,9 +127,9 @@ static int check_pager_config(const char *cmd)
 static int browser_command_config(const char *var, const char *value, void *data)
 {
 	struct pager_config *c = data;
-	if (strstarts(var, "tui.") && !strcmp(var + 4, c->cmd))
+	if (same_cmd_with_prefix(var, c, "tui."))
 		c->val = perf_config_bool(var, value);
-	if (strstarts(var, "gtk.") && !strcmp(var + 4, c->cmd))
+	if (same_cmd_with_prefix(var, c, "gtk."))
 		c->val = perf_config_bool(var, value) ? 2 : 0;
 	return 0;
 }
-- 
2.17.1

