Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CCEC6FA92
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 02:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIPCWO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIPCWL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 22:22:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C5910A8
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 19:22:10 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTHpX2h4gzBsMd;
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
Subject: [PATCH 6/8] perf sched: Fix error return code in perf_sched__timehist
Date:   Fri, 16 Sep 2022 10:56:25 +0800
Message-ID: <20220916025627.13967-7-shangxiaojing@huawei.com>
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

Reset the error return code in perf_sched__timehist to -1 after assigned
by perf_session__cpu_bitmap, to ensure the following checks wont return
the error code of perf_session__cpu_bitmap.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index a92610eac4bf..4b9d2bc916b3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3027,6 +3027,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
 		if (err < 0)
 			goto out;
+		err = -1;
 	}
 
 	evlist = session->evlist;
-- 
2.17.1

