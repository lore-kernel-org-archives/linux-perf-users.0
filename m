Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5A9C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 03:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2569461002
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 03:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhHIDub (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 8 Aug 2021 23:50:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16997 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhHIDua (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 Aug 2021 23:50:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GjhpH5GTSzZywR;
        Mon,  9 Aug 2021 11:46:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 11:50:09 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 11:50:08 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] perf/core: Add missing device_remove_file() in pmu_dev_alloc()
Date:   Mon, 9 Aug 2021 11:49:41 +0800
Message-ID: <20210809034941.2264-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The device attribute file 'nr_addr_filters' should be removed when
sysfs_update_groups() fails.

Fixes: f3a3a8257e5a ("perf/core: Add attr_groups_update into struct pmu")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/events/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 464917096e73..7d465584445b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10980,11 +10980,15 @@ static int pmu_dev_alloc(struct pmu *pmu)
 		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
 
 	if (ret)
-		goto del_dev;
+		goto remove_file;
 
 out:
 	return ret;
 
+remove_file:
+	if (pmu->nr_addr_filters)
+		device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
+
 del_dev:
 	device_del(pmu->dev);
 
-- 
2.25.1

