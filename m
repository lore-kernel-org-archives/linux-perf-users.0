Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD44C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 07:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF80661353
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 07:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhJSH1U (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 03:27:20 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25167 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhJSH1R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 03:27:17 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HYQFf4jrrz1DHjK;
        Tue, 19 Oct 2021 15:23:18 +0800 (CST)
Received: from huawei.com (10.67.189.2) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 15:25:03 +0800
From:   Lexi Shao <shaolexi@huawei.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <mark.rutland@arm.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <shaolexi@huawei.com>,
        <qiuxi1@huawei.com>, <nixiaoming@huawei.com>,
        <wangbing6@huawei.com>
Subject: [PATCH] perf script: Show binary offsets for userspace addr
Date:   Tue, 19 Oct 2021 15:24:17 +0800
Message-ID: <20211019072417.122576-1-shaolexi@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Show binary offsets for userspace addr with map in perf script output
with callchain.

In commit 19610184693c("perf script: Show virtual addresses instead of
offsets"), the addr shown in perf script output with callchain is changed
from binary offsets to virtual address to fix the incorrectness when
displaying symbol offset.

This is inconvenient in scenario that the binary is stripped and
symbol cannot be resolved. If someone wants to further resolve symbols for
specific binaries later, he would need an extra step to translate virtual
address to binary offset with mapping information recorded in perf.data,
which can be difficult for people not familiar with perf.

This patch modifies function sample__fprintf_callchain to print binary
offset for userspace addr with dsos, and virtual address otherwise. It
does not affect symbol offset calculation so symoff remains correct.

Before applying this patch:
test  1512    78.711307:     533129 cycles:
	aaaae0da07f4 [unknown] (/tmp/test)
	aaaae0da0704 [unknown] (/tmp/test)
	ffffbe9f7ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)

After this patch:
test  1519   111.330127:     406953 cycles:
	7f4 [unknown] (/tmp/test)
	704 [unknown] (/tmp/test)
	20ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)

Fixes: 19610184693c("perf script: Show virtual addresses instead of offsets")

Signed-off-by: Lexi Shao <shaolexi@huawei.com>
---
 tools/perf/util/evsel_fprintf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index bfedd7b23521..8c2ea8001329 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -11,6 +11,7 @@
 #include "strlist.h"
 #include "symbol.h"
 #include "srcline.h"
+#include "dso.h"
 
 static int comma_fprintf(FILE *fp, bool *first, const char *fmt, ...)
 {
@@ -144,12 +145,17 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_arrow && !first)
 				printed += fprintf(fp, " <-");
 
-			if (print_ip)
-				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
-
 			if (map)
 				addr = map->map_ip(map, node->ip);
 
+			if (print_ip) {
+				/* Show binary offset for userspace addr */
+				if (map && !map->dso->kernel)
+					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
+				else
+					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
+			}
+
 			if (print_sym) {
 				printed += fprintf(fp, " ");
 				node_al.addr = addr;
-- 
2.12.3

