Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED73ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 02:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiIFCy1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Sep 2022 22:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiIFCy0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Sep 2022 22:54:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DC1DA5;
        Mon,  5 Sep 2022 19:54:24 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MM8yN0pkYz1P6r7;
        Tue,  6 Sep 2022 10:50:36 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 10:54:22 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 10:54:21 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2 1/3] perf clean: Add same_cmd_with_prefix helper
Date:   Tue, 6 Sep 2022 11:29:04 +0800
Message-ID: <20220906032906.21395-2-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906032906.21395-1-shangxiaojing@huawei.com>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wrap repeated code in helper function same_cmd_with_prefix for more
clearly.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
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

