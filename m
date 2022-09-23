Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4CC6FA8B
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 13:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIWN1o (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWN1i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 09:27:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC2E12578B
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 06:27:37 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYtF01G8zzHqS0;
        Fri, 23 Sep 2022 21:25:24 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 21:27:35 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 21:27:34 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <alexey.v.bayduraev@linux.intel.com>, <yao.jin@linux.intel.com>,
        <dsahern@gmail.com>, <alexander.antonov@linux.intel.com>,
        <shangxiaojing@huawei.com>
Subject: [PATCH v2 6/7] perf stat: Fix error return code in cmd_stat()
Date:   Fri, 23 Sep 2022 22:01:42 +0800
Message-ID: <20220923140143.21552-7-shangxiaojing@huawei.com>
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

Commit f07952b17969 ("perf stat: Basic support for iostat in perf")
inserts check function iostat_prepare(), which assign to the error
code but not reset. Reset the error return value in cmd_stat() as
-EINVAL after assigned.

Fixes: f07952b17969 ("perf stat: Basic support for iostat in perf")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Cc: Alexander Antonov <alexander.antonov@linux.intel.com>
---
changes in v2:
- discard meaningless change.
- add fix msg.
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e05fe72c1d87..bd8a91597227 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2438,6 +2438,7 @@ int cmd_stat(int argc, const char **argv)
 			iostat_list(evsel_list, &stat_config);
 		if (iostat_mode == IOSTAT_RUN && !target__has_cpu(&target))
 			target.system_wide = true;
+		status = -EINVAL;
 	}
 
 	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
-- 
2.17.1

