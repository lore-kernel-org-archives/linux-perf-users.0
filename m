Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83782C77B7D
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 May 2023 07:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjEMHkW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 May 2023 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjEMHkV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 May 2023 03:40:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70135B5;
        Sat, 13 May 2023 00:40:17 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QJHVl3wxQz18LQJ;
        Sat, 13 May 2023 15:35:59 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 13 May 2023 15:40:13 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf: ftrace: flush output after each writing
Date:   Sat, 13 May 2023 15:40:00 +0800
Message-ID: <20230513074000.733550-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pager will result stdout in full buffering mode instead of line
buffering. We need to make the trace visible timely.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 810e3376c7d6..ad2a9ae041f6 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -650,6 +650,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			if (fwrite(buf, n, 1, stdout) != 1)
 				break;
+			/* flush output since stdout is in full buffering mode due to pager */
+			fflush(stdout);
 		}
 	}
 
-- 
2.25.1

