Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C726C6FA91
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 13:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIWN1n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIWN1h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 09:27:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38F13BCCA
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 06:27:36 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYtB32JqJzMpWg;
        Fri, 23 Sep 2022 21:22:51 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 21:27:34 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 21:27:33 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <alexey.v.bayduraev@linux.intel.com>, <yao.jin@linux.intel.com>,
        <dsahern@gmail.com>, <alexander.antonov@linux.intel.com>,
        <shangxiaojing@huawei.com>
Subject: [PATCH v2 5/7] perf sched: Fix error return code in perf_sched__timehist()
Date:   Fri, 23 Sep 2022 22:01:41 +0800
Message-ID: <20220923140143.21552-6-shangxiaojing@huawei.com>
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

Commit c30d630d1bcf ("perf sched timehist: Add support for filtering on
CPU") inserts check function perf_session__cpu_bitmap() in
perf_sched__timehist(), which assigned to the error code but not reset.
Reset the error return code in perf_sched__timehist to -1 after assigned.

Fixes: c30d630d1bcf ("perf sched timehist: Add support for filtering on
CPU")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Cc: David Ahern <dsahern@gmail.com>
---
changes in v2:
- add fix msg
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f93737eef07b..0c5e28e8251a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3048,6 +3048,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
 		if (err < 0)
 			goto out;
+		err = -1;
 	}
 
 	evlist = session->evlist;
-- 
2.17.1

