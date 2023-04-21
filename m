Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45719C7618E
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Apr 2023 03:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjDUDCr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Apr 2023 23:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjDUDB6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Apr 2023 23:01:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198F193;
        Thu, 20 Apr 2023 20:01:55 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q2fNH6x7hz17W42;
        Fri, 21 Apr 2023 10:58:07 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 11:01:52 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf tracepoint: Fix memory leak in is_valid_tracepoint()
Date:   Fri, 21 Apr 2023 02:59:53 +0000
Message-ID: <20230421025953.173826-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When is_valid_tracepoint() returns 1, need to call put_events_file() to
free `dir_path`.

Fixes: 25a7d914274d ("perf parse-events: Use get/put_events_file()")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/tracepoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
index 89ef56c43311..92dd8b455b90 100644
--- a/tools/perf/util/tracepoint.c
+++ b/tools/perf/util/tracepoint.c
@@ -50,6 +50,7 @@ int is_valid_tracepoint(const char *event_string)
 				 sys_dirent->d_name, evt_dirent->d_name);
 			if (!strcmp(evt_path, event_string)) {
 				closedir(evt_dir);
+				put_events_file(dir_path);
 				closedir(sys_dir);
 				return 1;
 			}
-- 
2.30.GIT

