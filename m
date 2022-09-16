Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD9DC6FA90
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 02:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIPCWM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Sep 2022 22:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIPCWK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Sep 2022 22:22:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBC08C007
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Sep 2022 19:22:09 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTHmH6ZjbzlVxC;
        Fri, 16 Sep 2022 10:18:07 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 10:22:08 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 10:22:03 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 5/8] perf report: Fix error return code in cmd_report
Date:   Fri, 16 Sep 2022 10:56:24 +0800
Message-ID: <20220916025627.13967-6-shangxiaojing@huawei.com>
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

Reset the error return code in cmd_report as -EINVAL after assigned by
evswitch__init. Set the error code as -EINVAL when symbol__init failed.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-report.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8361890176c2..094256bde981 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1481,6 +1481,8 @@ int cmd_report(int argc, const char **argv)
 		goto error;
 	}
 
+	ret = -EINVAL;
+
 	if (itrace_synth_opts.last_branch || itrace_synth_opts.add_last_branch)
 		has_br_stack = true;
 
@@ -1644,8 +1646,10 @@ int cmd_report(int argc, const char **argv)
 		annotation_config__init(&report.annotation_opts);
 	}
 
-	if (symbol__init(&session->header.env) < 0)
+	if (symbol__init(&session->header.env) < 0) {
+		ret = -EINVAL;
 		goto error;
+	}
 
 	if (report.time_str) {
 		ret = perf_time__parse_for_ranges(report.time_str, session,
-- 
2.17.1

