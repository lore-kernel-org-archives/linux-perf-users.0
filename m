Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBBC76196
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Apr 2023 05:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjDGFwl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Apr 2023 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDGFwk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Apr 2023 01:52:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B39EF9;
        Thu,  6 Apr 2023 22:52:38 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pt6qg4bHHzSlxg;
        Fri,  7 Apr 2023 13:48:47 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Apr 2023 13:52:35 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 1/2] perf script: print raw ip instead of binary offset for callchain
Date:   Fri, 7 Apr 2023 13:52:11 +0800
Message-ID: <20230407055212.2701635-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407055212.2701635-1-changbin.du@huawei.com>
References: <20230407055212.2701635-1-changbin.du@huawei.com>
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

Before this, the raw ip is printed for non-callchain and dso offset for
callchain. This inconsistent output for address may confuse people. And
mostly what we expect is the raw ip.

'dso offset' is printed in callchain:
$ perf script
...
ls 1341034 2739463.008343:    2162417 cycles:
        ffffffff99d657a7 [unknown] ([unknown])
        ffffffff99e00b67 [unknown] ([unknown])
                   235d3 memset+0x53 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)  # dso offset
                    a61b _dl_map_object+0x1bb (/usr/lib/x86_64-linux-gnu/ld-2.31.so)

raw ip is printed for non-callchain:
$ perf script  -G
	...
        ls 1341034 2739463.008876:    2053304 cycles:  ffffffffc1596923 [unknown] ([unknown])
        ls 1341034 2739463.009381:    1917049 cycles:      14def8e149e6 __strcoll_l+0xd96 (/usr/lib/x86_64-linux-gnu/libc-2.31.so) # raw ip

Let's have consistent output for it. Later I'll add a new field 'dsoff' to
print dso offset.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/evsel_fprintf.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index bd22c4932d10..1fb8044d402e 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -153,13 +153,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (map)
 				addr = map->map_ip(map, node->ip);
 
-			if (print_ip) {
-				/* Show binary offset for userspace addr */
-				if (map && !map->dso->kernel)
-					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
-				else
-					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
-			}
+			if (print_ip)
+				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
 
 			if (print_sym) {
 				printed += fprintf(fp, " ");
-- 
2.25.1

