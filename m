Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4BBC3DA6E
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Dec 2022 03:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiLTD7y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 22:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiLTD7x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 22:59:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03D13E04;
        Mon, 19 Dec 2022 19:59:52 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbjQk62wKzqT7Z;
        Tue, 20 Dec 2022 11:55:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 11:59:49 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <ravi.bangoria@amd.com>, <martin.lau@kernel.org>,
        <adrian.hunter@intel.com>, <ak@linux.intel.com>,
        <masami.hiramatsu.pt@hitachi.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 3/3] perf probe: Check -v and -q options in the right place
Date:   Tue, 20 Dec 2022 11:57:02 +0800
Message-ID: <20221220035702.188413-4-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20221220035702.188413-1-yangjihong1@huawei.com>
References: <20221220035702.188413-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Check the -q and -v options first to return earlier on error.

Before:
  # perf probe -q -v test
  probe-definition(0): test
  symbol:test file:(null) line:0 offset:0 return:0 lazy:(null)
  0 arguments
    Error: -v and -q are exclusive.

After:
  # perf probe -q -v test
    Error: -v and -q are exclusive.

Fixes: 5e17b28f1e24 ("perf probe: Add --quiet option to suppress output result message")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-probe.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 2ae50fc9e597..ed73d0b89ca2 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -612,6 +612,15 @@ __cmd_probe(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, probe_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (quiet) {
+		if (verbose != 0) {
+			pr_err("  Error: -v and -q are exclusive.\n");
+			return -EINVAL;
+		}
+		verbose = -1;
+	}
+
 	if (argc > 0) {
 		if (strcmp(argv[0], "-") == 0) {
 			usage_with_options_msg(probe_usage, options,
@@ -633,14 +642,6 @@ __cmd_probe(int argc, const char **argv)
 	if (ret)
 		return ret;
 
-	if (quiet) {
-		if (verbose != 0) {
-			pr_err("  Error: -v and -q are exclusive.\n");
-			return -EINVAL;
-		}
-		verbose = -1;
-	}
-
 	if (probe_conf.max_probes == 0)
 		probe_conf.max_probes = MAX_PROBES;
 
-- 
2.30.GIT

