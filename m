Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8176ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 13:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiIWN1p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIWN1j (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 09:27:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2027B0F
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 06:27:38 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYtF11jdjzHqS6;
        Fri, 23 Sep 2022 21:25:25 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 21:27:36 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 21:27:35 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <alexey.v.bayduraev@linux.intel.com>, <yao.jin@linux.intel.com>,
        <dsahern@gmail.com>, <alexander.antonov@linux.intel.com>,
        <shangxiaojing@huawei.com>
Subject: [PATCH v2 7/7] perf trace: Fix error return code in trace__replay() and cmd_trace()
Date:   Fri, 23 Sep 2022 22:01:43 +0800
Message-ID: <20220923140143.21552-8-shangxiaojing@huawei.com>
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

Reset the error return code in trace__replay() to -1 to ensure the
following checks can return correct error code when they failed.

Use PTR_ERR(evsel) as the error code in cmd_trace for more accurate.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- adjust commit msg.
---
 tools/perf/builtin-trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3ecc31375f90..57a6ba158bf1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4277,6 +4277,8 @@ static int trace__replay(struct trace *trace)
 	if (err)
 		goto out;
 
+	err = -1;
+
 	evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_enter");
 	trace->syscalls.events.sys_enter = evsel;
 	/* older kernels have syscalls tp versus raw_syscalls */
@@ -4972,9 +4974,12 @@ int cmd_trace(int argc, const char **argv)
 	if (IS_ERR(evsel)) {
 		bpf__strerror_setup_output_event(trace.evlist, PTR_ERR(evsel), bf, sizeof(bf));
 		pr_err("ERROR: Setup trace syscalls enter failed: %s\n", bf);
+		err = PTR_ERR(evsel);
 		goto out;
 	}
 
+	err = -1;
+
 	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
 
-- 
2.17.1

