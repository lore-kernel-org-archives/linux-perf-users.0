Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E24C04A6A
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 13:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjHONVU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHONUv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 09:20:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4864198A
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 06:20:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQBd74DZzzNmPB;
        Tue, 15 Aug 2023 21:17:15 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 21:20:46 +0800
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
Subject: [PATCH] perf scripts python: Support syscall name parsing on arm64
Date:   Tue, 15 Aug 2023 21:17:35 +0800
Message-ID: <20230815131735.1237221-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In the result of "perf script syscall-counts" on arm64, the syscall
events are not resolved currently. Add "aarch64" to audit uname list to
support name parsing.

* After the patch:

[root@localhost ~]# perf script syscall-counts sleep 1
Press control+C to stop and show the summary

syscall events:

event                                          count
----------------------------------------  -----------
mmap                                               6
close                                              5
mprotect                                           4
brk                                                3
newfstatat                                         3
openat                                             3
getrandom                                          1
prlimit64                                          1
munmap                                             1
clock_nanosleep                                    1
set_robust_list                                    1
set_tid_address                                    1
exit_group                                         1
read                                               1
faccessat                                          1

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
index 84536b1a27ba..b75d31858e54 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
@@ -54,6 +54,7 @@ try:
 	import audit
 	machine_to_id = {
 		'x86_64': audit.MACH_86_64,
+		'aarch64': audit.MACH_AARCH64,
 		'alpha'	: audit.MACH_ALPHA,
 		'ia64'	: audit.MACH_IA64,
 		'ppc'	: audit.MACH_PPC,
-- 
2.25.1

