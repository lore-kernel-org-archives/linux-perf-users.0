Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72010C6FA91
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 13:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiIVNkf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiIVNk0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 09:40:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CFB57893
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 06:40:26 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYGZF4xFhzHqHS;
        Thu, 22 Sep 2022 21:38:13 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:40:24 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 21:40:23 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 2/4] perf stat: Merge cases in process_evlist
Date:   Thu, 22 Sep 2022 22:14:36 +0800
Message-ID: <20220922141438.22487-3-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922141438.22487-1-shangxiaojing@huawei.com>
References: <20220922141438.22487-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As two cases in process_evlist has same behavior, merge these cases.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-stat.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e05fe72c1d87..e10595f649bc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -662,9 +662,6 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
 		switch (cmd) {
 		case EVLIST_CTL_CMD_ENABLE:
-			if (interval)
-				process_interval();
-			break;
 		case EVLIST_CTL_CMD_DISABLE:
 			if (interval)
 				process_interval();
-- 
2.17.1

