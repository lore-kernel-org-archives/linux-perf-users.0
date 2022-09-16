Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B2C6FA86
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 02:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIPCWL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIPCWK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 22:22:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6B80E80
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 19:22:09 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTHmW6cTjzmVDQ;
        Fri, 16 Sep 2022 10:18:19 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 10:22:07 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 10:22:02 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 3/8] perf probe: Fix error return code in perf_del_probe_events
Date:   Fri, 16 Sep 2022 10:56:22 +0800
Message-ID: <20220916025627.13967-4-shangxiaojing@huawei.com>
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

Set the error return code in perf_del_probe_events as ret2 when the
correct error code is recorded in ret2.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-probe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index f62298f5db3b..b1a7876d9031 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -465,10 +465,14 @@ static int perf_del_probe_events(struct strfilter *filter)
 			pr_info("Removed event: %s\n", ent->s);
 
 		ret2 = probe_file__del_strlist(ufd, ulist);
-		if (ret2 < 0)
+		if (ret2 < 0) {
+			ret = ret2;
 			goto error;
-	} else if (ret2 == -ENOMEM)
+		}
+	} else if (ret2 == -ENOMEM) {
+		ret = ret2;
 		goto error;
+	}
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
 		pr_warning("\"%s\" does not hit any event.\n", str);
-- 
2.17.1

