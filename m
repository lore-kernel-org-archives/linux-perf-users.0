Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE1C0015E
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 13:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHONVV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjHONVN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 09:21:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278C198A
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 06:21:12 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQBdb1fMYzNmlq;
        Tue, 15 Aug 2023 21:17:39 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 21:21:09 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Wei Li <liwei391@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <huawei.libin@huawei.com>
Subject: [PATCH] perf scripts python: Update package name for python3
Date:   Tue, 15 Aug 2023 21:18:05 +0800
Message-ID: <20230815131805.1237491-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

'audit-libs-python' is the package for python2, update it for python3.
On Ubuntu and Fedora, the new package is 'python3-audit'.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 .../scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
index 7384dcb628c4..84536b1a27ba 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
@@ -73,9 +73,9 @@ try:
 except:
 	if not audit_package_warned:
 		audit_package_warned = True
-		print("Install the audit-libs-python package to get syscall names.\n"
-                    "For example:\n  # apt-get install python-audit (Ubuntu)"
-                    "\n  # yum install audit-libs-python (Fedora)"
+		print("Install the python-audit package to get syscall names.\n"
+                    "For example:\n  # apt-get install python3-audit (Ubuntu)"
+                    "\n  # yum install python3-audit (Fedora)"
                     "\n  etc.\n")
 
 def syscall_name(id):
-- 
2.25.1

