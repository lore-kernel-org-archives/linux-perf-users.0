Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77519C77B71
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Apr 2023 03:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDRDTD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Apr 2023 23:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDRDSz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Apr 2023 23:18:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F55FC5;
        Mon, 17 Apr 2023 20:18:49 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [7.221.188.120])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q0pvF2R4zzncDk;
        Tue, 18 Apr 2023 11:15:05 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 11:18:46 +0800
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
Subject: [PATCH v5 2/3] perf: add helper map__fprintf_dsoname_dsoff
Date:   Tue, 18 Apr 2023 11:18:24 +0800
Message-ID: <20230418031825.1262579-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418031825.1262579-1-changbin.du@huawei.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This adds a helper function map__fprintf_dsoname_dsoff() to print dsoname
with optional dso offset.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/map.c | 13 +++++++++++++
 tools/perf/util/map.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d81b6ca18ee9..7da96b41100f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -445,6 +445,19 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 	return fprintf(fp, "%s", dsoname);
 }
 
+size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
+{
+	int printed = 0;
+
+	printed += fprintf(fp, " (");
+	printed += map__fprintf_dsoname(map, fp);
+	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
+		printed += fprintf(fp, "+0x%" PRIx64, addr);
+	printed += fprintf(fp, ")");
+
+	return printed;
+}
+
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
 {
 	if (map == NULL)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f89ab7c2d327..4cca211b6e66 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -175,6 +175,7 @@ static inline void __map__zput(struct map **map)
 
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
+size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp);
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
-- 
2.25.1

