From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/19] perf diff: Use __block_info__cmp() to replace block_pair_cmp()
Date: Tue, 10 Mar 2020 08:15:49 -0300
Message-ID: <20200310111551.25160-18-acme@kernel.org>
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

'perf diff' uses block_pair_cmp() to compare two blocks. But
block_info__cmp() has the similar functionality and it's a bit more
complete.

This patch removes block_pair_cmp() and uses __block_info__cmp()
instead. __block_info__cmp() is wrapped by block_info__cmp() and it
doesn't receives a perf_hpp_fmt parameter.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200202141655.32053-3-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c    | 21 ++-------------------
 tools/perf/util/block-info.c |  9 +++++++--
 tools/perf/util/block-info.h |  2 ++
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c03c36fde7e2..5e697cd2224a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -572,29 +572,12 @@ static void init_block_hist(struct block_hist *bh)
 	bh->valid = true;
 }
 
-static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
-{
-	struct block_info *bi_a = a->block_info;
-	struct block_info *bi_b = b->block_info;
-	int cmp;
-
-	if (!bi_a->sym || !bi_b->sym)
-		return -1;
-
-	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
-
-	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
-		return 0;
-
-	return -1;
-}
-
 static struct hist_entry *get_block_pair(struct hist_entry *he,
 					 struct hists *hists_pair)
 {
 	struct rb_root_cached *root = hists_pair->entries_in;
 	struct rb_node *next = rb_first_cached(root);
-	int cmp;
+	int64_t cmp;
 
 	while (next != NULL) {
 		struct hist_entry *he_pair = rb_entry(next, struct hist_entry,
@@ -602,7 +585,7 @@ static struct hist_entry *get_block_pair(struct hist_entry *he,
 
 		next = rb_next(&he_pair->rb_node_in);
 
-		cmp = block_pair_cmp(he_pair, he);
+		cmp = __block_info__cmp(he_pair, he);
 		if (!cmp)
 			return he_pair;
 	}
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 5b4214656e29..25f6422c548b 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -65,8 +65,7 @@ struct block_info *block_info__new(void)
 	return bi;
 }
 
-int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
-			struct hist_entry *left, struct hist_entry *right)
+int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	struct block_info *bi_l = left->block_info;
 	struct block_info *bi_r = right->block_info;
@@ -91,6 +90,12 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return (int64_t)(bi_r->end - bi_l->end);
 }
 
+int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			struct hist_entry *left, struct hist_entry *right)
+{
+	return __block_info__cmp(left, right);
+}
+
 static void init_block_info(struct block_info *bi, struct symbol *sym,
 			    struct cyc_hist *ch, int offset,
 			    u64 total_cycles)
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index bef0d75e9819..a0fa9fefeaf0 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -61,6 +61,8 @@ static inline void __block_info__zput(struct block_info **bi)
 
 #define block_info__zput(bi) __block_info__zput(&bi)
 
+int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right);
+
 int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			struct hist_entry *left, struct hist_entry *right);
 
-- 
2.21.1
