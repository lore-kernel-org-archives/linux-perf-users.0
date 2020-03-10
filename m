From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/19] perf block-info: Support color ops to print block percents in color
Date: Tue, 10 Mar 2020 08:15:51 -0300
Message-ID: <20200310111551.25160-20-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

It would be nice to print the block percents with colors.

This patch supports the 'Sampled Cycles%' and 'Avg Cycles%' printed in
colors.

For example,

perf record -b ...
perf report --total-cycles or perf report --total-cycles --stdio

percent > 5%, colored in red
percent > 0.5%, colored in green
percent < 0.5%, default color

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200202141655.32053-5-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/block-info.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index debb8b12cf51..423ec69bda6c 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -181,6 +181,17 @@ static int block_column_width(struct perf_hpp_fmt *fmt,
 	return block_fmt->width;
 }
 
+static int color_pct(struct perf_hpp *hpp, int width, double pct)
+{
+#ifdef HAVE_SLANG_SUPPORT
+	if (use_browser) {
+		return __hpp__slsmg_color_printf(hpp, "%*.2f%%",
+						 width - 1, pct);
+	}
+#endif
+	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, pct);
+}
+
 static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
 					struct perf_hpp *hpp,
 					struct hist_entry *he)
@@ -188,14 +199,11 @@ static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
 	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
 	struct block_info *bi = he->block_info;
 	double ratio = 0.0;
-	char buf[16];
 
 	if (block_fmt->total_cycles)
 		ratio = (double)bi->cycles / (double)block_fmt->total_cycles;
 
-	sprintf(buf, "%.2f%%", 100.0 * ratio);
-
-	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
 }
 
 static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
@@ -248,16 +256,13 @@ static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
 	struct block_info *bi = he->block_info;
 	double ratio = 0.0;
 	u64 avg;
-	char buf[16];
 
 	if (block_fmt->block_cycles && bi->num_aggr) {
 		avg = bi->cycles_aggr / bi->num_aggr;
 		ratio = (double)avg / (double)block_fmt->block_cycles;
 	}
 
-	sprintf(buf, "%.2f%%", 100.0 * ratio);
-
-	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
 }
 
 static int block_avg_cycles_entry(struct perf_hpp_fmt *fmt,
@@ -345,7 +350,7 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
 
 	switch (idx) {
 	case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
-		fmt->entry = block_total_cycles_pct_entry;
+		fmt->color = block_total_cycles_pct_entry;
 		fmt->cmp = block_info__cmp;
 		fmt->sort = block_total_cycles_pct_sort;
 		break;
@@ -353,7 +358,7 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
 		fmt->entry = block_cycles_lbr_entry;
 		break;
 	case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
-		fmt->entry = block_cycles_pct_entry;
+		fmt->color = block_cycles_pct_entry;
 		break;
 	case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
 		fmt->entry = block_avg_cycles_entry;
-- 
2.21.1
