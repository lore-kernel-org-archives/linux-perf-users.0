From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/18] perf diff: Print the basic block cycles diff
Date: Wed,  3 Jul 2019 00:27:35 -0300
Message-ID: <20190703032746.21692-8-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

 $ perf record -b ./div
 $ perf record -b ./div

Following is the default perf diff output

 $ perf diff

 # Event 'cycles'
 #
 # Baseline  Delta Abs  Shared Object     Symbol
 # ........  .........  ................  ..................................
 #
     48.75%     +0.33%  div               [.] main
      8.21%     -0.20%  div               [.] compute_flag
     19.02%     -0.12%  libc-2.23.so      [.] __random_r
     16.17%     -0.09%  libc-2.23.so      [.] __random
      2.27%     -0.03%  div               [.] rand@plt
                +0.02%  [i915]            [k] gen8_irq_handler
      5.52%     +0.02%  libc-2.23.so      [.] rand

This patch creates a new computation selection 'cycles'.

 $ perf diff -c cycles

 # Event 'cycles'
 #
 # Baseline       [Program Block Range] Cycles Diff Shared Object Symbol
 # ........ ....................................... .........................................
 #
     48.75%             [div.c:42 -> div.c:45]  147 div           [.] main
     48.75%             [div.c:31 -> div.c:40]    4 div           [.] main
     48.75%             [div.c:40 -> div.c:40]    0 div           [.] main
     48.75%             [div.c:42 -> div.c:42]    0 div           [.] main
     48.75%             [div.c:42 -> div.c:44]    0 div           [.] main
     19.02% [random_r.c:357 -> random_r.c:360]    0 libc-2.23.so  [.] __random_r
     19.02% [random_r.c:357 -> random_r.c:373]    0 libc-2.23.so  [.] __random_r
     19.02% [random_r.c:357 -> random_r.c:376]    0 libc-2.23.so  [.] __random_r
     19.02% [random_r.c:357 -> random_r.c:380]    0 libc-2.23.so  [.] __random_r
     19.02% [random_r.c:357 -> random_r.c:392]    0 libc-2.23.so  [.] __random_r
     16.17%     [random.c:288 -> random.c:291]    0 libc-2.23.so  [.] __random
     16.17%     [random.c:288 -> random.c:291]    0 libc-2.23.so  [.] __random
     16.17%     [random.c:288 -> random.c:295]    0 libc-2.23.so  [.] __random
     16.17%     [random.c:288 -> random.c:297]    0 libc-2.23.so  [.] __random
     16.17%     [random.c:291 -> random.c:291]    0 libc-2.23.so  [.] __random
     16.17%     [random.c:293 -> random.c:293]    0 libc-2.23.so  [.] __random
      8.21%             [div.c:22 -> div.c:22]  148 div           [.] compute_flag
      8.21%             [div.c:22 -> div.c:25]    0 div           [.] compute_flag
      8.21%             [div.c:27 -> div.c:28]    0 div           [.] compute_flag
      5.52%           [rand.c:26 -> rand.c:27]    0 libc-2.23.so  [.] rand
      5.52%           [rand.c:26 -> rand.c:28]    0 libc-2.23.so  [.] rand
      2.27%         [rand@plt+0 -> rand@plt+0]    0 div           [.] rand@plt
      0.01% [entry_64.S:694 -> entry_64.S:694]   16 [vmlinux]     [k] native_irq_return_iret
      0.00%       [fair.c:7676 -> fair.c:7665]  162 [vmlinux]     [k] update_blocked_averages

"[Program Block Range]" indicates the range of program basic block
(start -> end). If we can find the source line it prints the source line
otherwise it prints the symbol+offset instead.

 v4:
 ---
 Use source lines or symbol+offset to indicate the basic block. It should
 be easier to understand.

 v3:
 ---
 Cast 'struct hist_entry' to 'struct block_hist' in hist_entry__block_fprintf.
 Use symbol_conf.report_block to check if executing hist_entry__block_fprintf.

 v2:
 ---
 Keep standard perf diff format and display the 'Baseline' and
 'Shared Object'.

The output is sorted by "Baseline" and the basic blocks in the same
function are sorted by cycles diff.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-7-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c     | 80 +++++++++++++++++++++++++++++++++--
 tools/perf/ui/stdio/hist.c    | 27 ++++++++++++
 tools/perf/util/hist.c        | 18 ++++++++
 tools/perf/util/hist.h        |  3 ++
 tools/perf/util/srcline.c     |  4 +-
 tools/perf/util/symbol_conf.h |  4 +-
 6 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index fafb7b3f58fb..f924b46910b5 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -21,6 +21,7 @@
 #include "util/config.h"
 #include "util/time-utils.h"
 #include "util/annotate.h"
+#include "util/map.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -46,6 +47,7 @@ enum {
 	PERF_HPP_DIFF__WEIGHTED_DIFF,
 	PERF_HPP_DIFF__FORMULA,
 	PERF_HPP_DIFF__DELTA_ABS,
+	PERF_HPP_DIFF__CYCLES,
 
 	PERF_HPP_DIFF__MAX_INDEX
 };
@@ -114,6 +116,7 @@ static int compute_2_hpp[COMPUTE_MAX] = {
 	[COMPUTE_DELTA_ABS]	= PERF_HPP_DIFF__DELTA_ABS,
 	[COMPUTE_RATIO]		= PERF_HPP_DIFF__RATIO,
 	[COMPUTE_WEIGHTED_DIFF]	= PERF_HPP_DIFF__WEIGHTED_DIFF,
+	[COMPUTE_CYCLES]	= PERF_HPP_DIFF__CYCLES,
 };
 
 #define MAX_COL_WIDTH 70
@@ -152,6 +155,10 @@ static struct header_column {
 	[PERF_HPP_DIFF__FORMULA] = {
 		.name  = "Formula",
 		.width = MAX_COL_WIDTH,
+	},
+	[PERF_HPP_DIFF__CYCLES] = {
+		.name  = "[Program Block Range] Cycles Diff",
+		.width = 70,
 	}
 };
 
@@ -239,8 +246,6 @@ static int setup_compute(const struct option *opt, const char *str,
 	for (i = 0; i < COMPUTE_MAX; i++)
 		if (!strcmp(cstr, compute_names[i])) {
 			*cp = i;
-			if (i == COMPUTE_CYCLES)
-				break;
 			return setup_compute_opt(option);
 		}
 
@@ -980,6 +985,9 @@ static void hists__process(struct hists *hists)
 	hists__precompute(hists);
 	hists__output_resort(hists, NULL);
 
+	if (compute == COMPUTE_CYCLES)
+		symbol_conf.report_block = true;
+
 	hists__fprintf(hists, !quiet, 0, 0, 0, stdout,
 		       !symbol_conf.use_callchain);
 }
@@ -1235,7 +1243,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN('b', "baseline-only", &show_baseline_only,
 		    "Show only items with match in baseline"),
 	OPT_CALLBACK('c', "compute", &compute,
-		     "delta,delta-abs,ratio,wdiff:w1,w2 (default delta-abs)",
+		     "delta,delta-abs,ratio,wdiff:w1,w2 (default delta-abs),cycles",
 		     "Entries differential computation selection",
 		     setup_compute),
 	OPT_BOOLEAN('p', "period", &show_period,
@@ -1313,6 +1321,49 @@ static int hpp__entry_baseline(struct hist_entry *he, char *buf, size_t size)
 	return ret;
 }
 
+static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
+			 struct perf_hpp *hpp, int width)
+{
+	struct block_hist *bh = container_of(he, struct block_hist, he);
+	struct block_hist *bh_pair = container_of(pair, struct block_hist, he);
+	struct hist_entry *block_he;
+	struct block_info *bi;
+	char buf[128];
+	char *start_line, *end_line;
+
+	block_he = hists__get_entry(&bh_pair->block_hists, bh->block_idx);
+	if (!block_he) {
+		hpp->skip = true;
+		return 0;
+	}
+
+	/*
+	 * Avoid printing the warning "addr2line_init failed for ..."
+	 */
+	symbol_conf.disable_add2line_warn = true;
+
+	bi = block_he->block_info;
+
+	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
+				  he->ms.sym);
+
+	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
+				he->ms.sym);
+
+	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
+			  start_line, end_line, block_he->diff.cycles);
+	} else {
+		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
+			  bi->start, bi->end, block_he->diff.cycles);
+	}
+
+	free_srcline(start_line);
+	free_srcline(end_line);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 				struct perf_hpp *hpp, struct hist_entry *he,
 				int comparison_method)
@@ -1324,8 +1375,17 @@ static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 	s64 wdiff;
 	char pfmt[20] = " ";
 
-	if (!pair)
+	if (!pair) {
+		if (comparison_method == COMPUTE_CYCLES) {
+			struct block_hist *bh;
+
+			bh = container_of(he, struct block_hist, he);
+			if (bh->block_idx)
+				hpp->skip = true;
+		}
+
 		goto no_print;
+	}
 
 	switch (comparison_method) {
 	case COMPUTE_DELTA:
@@ -1360,6 +1420,8 @@ static int __hpp__color_compare(struct perf_hpp_fmt *fmt,
 		return color_snprintf(hpp->buf, hpp->size,
 				get_percent_color(wdiff),
 				pfmt, wdiff);
+	case COMPUTE_CYCLES:
+		return cycles_printf(he, pair, hpp, dfmt->header_width);
 	default:
 		BUG_ON(1);
 	}
@@ -1389,6 +1451,12 @@ static int hpp__color_wdiff(struct perf_hpp_fmt *fmt,
 	return __hpp__color_compare(fmt, hpp, he, COMPUTE_WEIGHTED_DIFF);
 }
 
+static int hpp__color_cycles(struct perf_hpp_fmt *fmt,
+			     struct perf_hpp *hpp, struct hist_entry *he)
+{
+	return __hpp__color_compare(fmt, hpp, he, COMPUTE_CYCLES);
+}
+
 static void
 hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
 {
@@ -1590,6 +1658,10 @@ static void data__hpp_register(struct data__file *d, int idx)
 		fmt->color = hpp__color_delta;
 		fmt->sort  = hist_entry__cmp_delta_abs;
 		break;
+	case PERF_HPP_DIFF__CYCLES:
+		fmt->color = hpp__color_cycles;
+		fmt->sort  = hist_entry__cmp_nop;
+		break;
 	default:
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 9eb0131c3ade..89393c79d870 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -531,6 +531,30 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 	return printed;
 }
 
+static int hist_entry__block_fprintf(struct hist_entry *he,
+				     char *bf, size_t size,
+				     FILE *fp)
+{
+	struct block_hist *bh = container_of(he, struct block_hist, he);
+	int ret = 0;
+
+	for (unsigned int i = 0; i < bh->block_hists.nr_entries; i++) {
+		struct perf_hpp hpp = {
+			.buf		= bf,
+			.size		= size,
+			.skip		= false,
+		};
+
+		bh->block_idx = i;
+		hist_entry__snprintf(he, &hpp);
+
+		if (!hpp.skip)
+			ret += fprintf(fp, "%s\n", bf);
+	}
+
+	return ret;
+}
+
 static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 			       char *bf, size_t bfsz, FILE *fp,
 			       bool ignore_callchains)
@@ -550,6 +574,9 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 	if (symbol_conf.report_hierarchy)
 		return hist_entry__hierarchy_fprintf(he, &hpp, hists, fp);
 
+	if (symbol_conf.report_block)
+		return hist_entry__block_fprintf(he, bf, size, fp);
+
 	hist_entry__snprintf(he, &hpp);
 
 	ret = fprintf(fp, "%s\n", bf);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index a6ba7d470eb8..27cecb59f866 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -376,6 +376,24 @@ void hists__delete_entries(struct hists *hists)
 	}
 }
 
+struct hist_entry *hists__get_entry(struct hists *hists, int idx)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	struct hist_entry *n;
+	int i = 0;
+
+	while (next) {
+		n = rb_entry(next, struct hist_entry, rb_node);
+		if (i == idx)
+			return n;
+
+		next = rb_next(&n->rb_node);
+		i++;
+	}
+
+	return NULL;
+}
+
 /*
  * histogram, sorted on item, collects periods
  */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c670122b4e40..24635f36148d 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -183,6 +183,8 @@ void hists__decay_entries(struct hists *hists, bool zap_user, bool zap_kernel);
 void hists__delete_entries(struct hists *hists);
 void hists__output_recalc_col_len(struct hists *hists, int max_rows);
 
+struct hist_entry *hists__get_entry(struct hists *hists, int idx);
+
 u64 hists__total_period(struct hists *hists);
 void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
@@ -248,6 +250,7 @@ struct perf_hpp {
 	size_t size;
 	const char *sep;
 	void *ptr;
+	bool skip;
 };
 
 struct perf_hpp_fmt {
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 1824cabe3512..dcad75daf5e4 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -11,6 +11,7 @@
 #include "util/util.h"
 #include "util/debug.h"
 #include "util/callchain.h"
+#include "util/symbol_conf.h"
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -288,7 +289,8 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 
 	if (a2l == NULL) {
-		pr_warning("addr2line_init failed for %s\n", dso_name);
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("addr2line_init failed for %s\n", dso_name);
 		return 0;
 	}
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 382ba63fc554..e6880789864c 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -39,7 +39,9 @@ struct symbol_conf {
 			hide_unresolved,
 			raw_trace,
 			report_hierarchy,
-			inline_name;
+			report_block,
+			inline_name,
+			disable_add2line_warn;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.20.1
