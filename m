Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88532C6FA86
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 02:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIPCWN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIPCWL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 22:22:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E53A910BA
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 19:22:10 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTHpX43TCzBsMv;
        Fri, 16 Sep 2022 10:20:04 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 10:22:08 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 10:22:04 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 7/8] perf stat: Fix error return code in cmd_stat
Date:   Fri, 16 Sep 2022 10:56:26 +0800
Message-ID: <20220916025627.13967-8-shangxiaojing@huawei.com>
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

Reset the error return value in cmd_stat as -EINVAL after assigned, and
use the specific error code of evlist__expand_cgroup, for correct error
code.

BTW, change the default error code of evlist__expand_cgroup to ensure it
can return specific value instead of -1.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-stat.c | 9 +++++++--
 tools/perf/util/cgroup.c  | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 54cd29d07ca8..559ffa107218 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2427,6 +2427,7 @@ int cmd_stat(int argc, const char **argv)
 			iostat_list(evsel_list, &stat_config);
 		if (iostat_mode == IOSTAT_RUN && !target__has_cpu(&target))
 			target.system_wide = true;
+		status = -EINVAL;
 	}
 
 	if (add_default_attributes())
@@ -2440,12 +2441,16 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 
-		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
-					  &stat_config.metric_events, true) < 0) {
+		status = evlist__expand_cgroup(evsel_list,
+					       stat_config.cgroup_list,
+					       &stat_config.metric_events,
+					       true);
+		if (status < 0) {
 			parse_options_usage(stat_usage, stat_options,
 					    "for-each-cgroup", 0);
 			goto out;
 		}
+		status = -EINVAL;
 	}
 
 	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index e99b41f9be45..e3c6fc54dde5 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -400,7 +400,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 	struct rblist orig_metric_events;
 	struct cgroup *cgrp = NULL;
 	struct cgroup_name *cn;
-	int ret = -1;
+	int ret = -EINVAL;
 	int prefix_len;
 
 	if (evlist->core.nr_entries == 0) {
-- 
2.17.1

