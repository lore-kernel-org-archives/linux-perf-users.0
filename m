Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF6DC6FA82
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 13:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIWN1n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiIWN1g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 09:27:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F55D13BCC8
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 06:27:35 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYtDw6TpYzHqRs;
        Fri, 23 Sep 2022 21:25:20 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 21:27:32 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 21:27:31 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <alexey.v.bayduraev@linux.intel.com>, <yao.jin@linux.intel.com>,
        <dsahern@gmail.com>, <alexander.antonov@linux.intel.com>,
        <shangxiaojing@huawei.com>
Subject: [PATCH v2 3/7] perf record: Fix error return code in cmd_record()
Date:   Fri, 23 Sep 2022 22:01:39 +0800
Message-ID: <20220923140143.21552-4-shangxiaojing@huawei.com>
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

Commit b5f2511d4b397 ("perf record: Implement compatibility checks")
inserts check functions in cmd_record(), but not assign to the error
code. So does the evlist__fix_hybrid_cpus() added by commit
1d3351e631fc3 ("perf tools: Enable on a list of CPUs for hybrid").
Set the untimely updated error code in cmd_record as -EINVAL when there
encounters the error.

Fixes: b5f2511d4b397 ("perf record: Implement compatibility checks")
Fixes: 1d3351e631fc3 ("perf tools: Enable on a list of CPUs for hybrid")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
---
changes in v2:
- add fix msg.
---
 tools/perf/builtin-record.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02e38f50a138..959a639f95f1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4015,10 +4015,12 @@ int cmd_record(int argc, const char **argv)
 	if (record__threads_enabled(rec)) {
 		if (rec->opts.affinity != PERF_AFFINITY_SYS) {
 			pr_err("--affinity option is mutually exclusive to parallel streaming mode.\n");
+			err = -EINVAL;
 			goto out_opts;
 		}
 		if (record__aio_enabled(rec)) {
 			pr_err("Asynchronous streaming mode (--aio) is mutually exclusive to parallel streaming mode.\n");
+			err = -EINVAL;
 			goto out_opts;
 		}
 	}
@@ -4161,6 +4163,7 @@ int cmd_record(int argc, const char **argv)
 	if (evlist__fix_hybrid_cpus(rec->evlist, rec->opts.target.cpu_list)) {
 		pr_err("failed to use cpu list %s\n",
 		       rec->opts.target.cpu_list);
+		err = -EINVAL;
 		goto out;
 	}
 
-- 
2.17.1

