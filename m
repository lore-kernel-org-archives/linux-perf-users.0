From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/19] perf block-info: Fix wrong block address comparison in block_info__cmp()
Date: Tue, 10 Mar 2020 08:15:48 -0300
Message-ID: <20200310111551.25160-17-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Commit 6041441870ab ("perf block: Cleanup and refactor block info
functions") introduces block_info__cmp(), which compares two blocks.

But the issues are:

1. It should return the strcmp cmp value only if it's not 0.

2. When symbol names are matched, we need to compare the addresses
   of blocks further. But it wrongly uses the symbol addresses for
   comparison.

3. If the syms are both NULL, we can't consider these two blocks are
   matched.

This patch fixes above 3 issues.

Fixes: 6041441870ab ("perf block: Cleanup and refactor block info functions")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200202141655.32053-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/block-info.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index fbbb6d640dad..5b4214656e29 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -74,30 +74,21 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 
 	if (!bi_l->sym || !bi_r->sym) {
 		if (!bi_l->sym && !bi_r->sym)
-			return 0;
+			return -1;
 		else if (!bi_l->sym)
 			return -1;
 		else
 			return 1;
 	}
 
-	if (bi_l->sym == bi_r->sym) {
-		if (bi_l->start == bi_r->start) {
-			if (bi_l->end == bi_r->end)
-				return 0;
-			else
-				return (int64_t)(bi_r->end - bi_l->end);
-		} else
-			return (int64_t)(bi_r->start - bi_l->start);
-	} else {
-		cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+	cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+	if (cmp)
 		return cmp;
-	}
 
-	if (bi_l->sym->start != bi_r->sym->start)
-		return (int64_t)(bi_r->sym->start - bi_l->sym->start);
+	if (bi_l->start != bi_r->start)
+		return (int64_t)(bi_r->start - bi_l->start);
 
-	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
+	return (int64_t)(bi_r->end - bi_l->end);
 }
 
 static void init_block_info(struct block_info *bi, struct symbol *sym,
-- 
2.21.1
