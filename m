Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDA42DA29
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657316; cv=none; b=FJhf82m/hmK+KT+mxtgEp8Qf0IJie6xct4LbQQB5/JZoENIgS5RM2Dhyf88o2vbGYsPDMMRKGebuI0/UXWPMJIN9+44QxI8HHCd3+C+9sBROAVMLSvZNmig5y2XhHRhnSvPEecaby6Sh/BLxcawDbYyk/0j1aahDTpRih0LPg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657316; c=relaxed/simple;
	bh=8QuvT9/lnLWQvmPErL0qgjrKgQvbBq/pSVvk4MVK00w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/ltTsd96AyRnLvjvgHQw7WFOzEh057NL6zwdVKF/ZnF2Og5EJOL0gtSgiKtW1J3N7mr5DGDqA/YjUOl/RDd31IsD0UMnAN0jUhxbf9tuDIRN/CbguAZmcMJNv21m3K4uur566qJb7y1FOc372hIgF3kcvvcydlaSXCQ9mIhLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHeAr0ct; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHeAr0ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786657314; x=1818193314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8QuvT9/lnLWQvmPErL0qgjrKgQvbBq/pSVvk4MVK00w=;
  b=kHeAr0ctDkntrqSuUzdrW2dS5zIgLPrvsaIiioxStZ9UfP2t91noYj2F
   Fv4IiT1iYh1PFTTLNcU6SAyrDPv62UqYd0iOAWqxcd/WTgbmEr5FwhUuI
   LUMsoVuo7f3Cz/f5O70aBNuXEaD1iZPco088ybhzBcIWhnZZYzNJEzOWf
   5qHV9TGJq6TmUGXQF38X7Uk6sCPrk0qZbqC5U06zLp04/W+zEvc4DocuE
   LBR2rg8dkcsD5OdouLSOc9AJgOwZdXxZHVquMvKh2Yeu4+zCmRVSTTxjM
   Gtwpz+xuEu2mJ1Z+u1BnzjdXVDSS16WRXcjsjkomGgaOT0U1k+P1X+lAT
   w==;
X-CSE-ConnectionGUID: Bie5B/LORLyfjjvU9cXUgw==
X-CSE-MsgGUID: mJvyyAoRSMepF+Xvp1haUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89761875"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89761875"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:50 -0700
X-CSE-ConnectionGUID: w9TnHUUJQBq9TsqxQsoDJw==
X-CSE-MsgGUID: FAdUW4bESUWEooDOeTPTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267909911"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:50 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 3/4] perf tools: Add support for displaying weights in annotate
Date: Thu, 13 Aug 2026 14:40:58 -0700
Message-ID: <20260813214143.253418-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813214143.253418-1-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for showing all the three possible per IP weights in
annotate. The weights are shown by defaults if any are non zero. This
is useful, especially with the new insn lat statistics, but also
for all the existing weights.

Add a hotkey to the interactive browser to turn them off (w), as well
as a perf annotate command line option.

The weights are stored unconditionally in the sym_hist_entry, which
will increase memory consumption somewhat.

Assisted-by: omp:GPT-5.6-Luna
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-annotate.txt |   3 +
 tools/perf/builtin-annotate.c              |   2 +
 tools/perf/ui/browsers/annotate.c          |  17 +++-
 tools/perf/util/annotate.c                 | 110 ++++++++++++++++++---
 tools/perf/util/annotate.h                 |  32 +++++-
 tools/perf/util/symbol_conf.h              |  15 ++-
 6 files changed, 161 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index a688738809c4..50c6ea680d0d 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -79,6 +79,9 @@ include::itrace.txt[]
 
 --stdio:: Use the stdio interface.
 
+--no-weights:: Hide weight columns in annotation output. By default, weight columns
+	are shown when samples contain non-zero weights.
+
 --stdio2:: Use the stdio2 interface, non-interactive, uses the TUI formatting.
 
 --stdio-color=<mode>::
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 69cb72b2082a..7f489e2af333 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -719,6 +719,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 #endif
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
+	OPT_BOOLEAN(0, "no-weights", &symbol_conf.hide_weight,
+		    "Hide weight columns in annotation"),
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
                     "don't load vmlinux even if found"),
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e47a46775089..d6126a7d51e4 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -189,7 +189,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct map_symbol *ms = ab->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	u8 pcnt_width = annotation__pcnt_width(notes);
+	u8 pcnt_width = annotation__pcnt_width(notes, ab->evsel);
 	u8 cntr_width = annotation__br_cntr_width();
 	int width;
 	int diff = 0;
@@ -255,7 +255,8 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 {
 	struct annotation *notes = browser__annotation(browser);
 	int ret = ui_browser__list_head_refresh(browser);
-	int pcnt_width = annotation__pcnt_width(notes);
+	int pcnt_width = annotation__pcnt_width(notes,
+		container_of(browser, struct annotate_browser, b)->evsel);
 
 	if (annotate_opts.jump_arrows)
 		annotate_browser__draw_current_jump(browser);
@@ -972,6 +973,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"O             Bump offset level (jump targets -> +call -> all -> cycle thru)\n"
 		"s             Toggle source code view\n"
 		"t             Circulate percent, total period, samples view\n"
+		"w             Toggle weight columns\n"
 		"c             Show min/max cycle\n"
 		"/             Search string\n"
 		"k             Toggle line numbers\n"
@@ -1091,6 +1093,15 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				symbol_conf.show_total_period = true;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'w':
+			symbol_conf.hide_weight = !symbol_conf.hide_weight;
+			symbol_conf.weight_mask_user = true;
+			symbol_conf.weight_mask = symbol_conf.hide_weight ?
+				0 : sym_hist__weight_mask(annotation__histogram(notes, evsel));
+			browser->b.width = notes->src->widths.max_line_len +
+					   annotation__pcnt_width(notes, evsel);
+			ui_browser__refresh_dimensions(&browser->b);
+			continue;
 		case 'c':
 			if (annotate_opts.show_minmax_cycle)
 				annotate_opts.show_minmax_cycle = false;
@@ -1228,7 +1239,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
 	browser.b.entries = &notes->src->source;
-	browser.b.width += 18; /* Percentage */
+	browser.b.width += annotation__pcnt_width(notes, evsel);
 
 	if (annotate_opts.hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index df70e95a8470..d1b691a61253 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -222,6 +222,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	u64 offset;
 	struct sym_hist *h;
 	struct sym_hist_entry *entry;
+	u64 weight = sample->weight ?: sample->ins_lat ?: sample->weight3;
 
 	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map__unmap_ip(ms->map, addr));
 
@@ -256,10 +257,28 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	entry->nr_samples++;
 	entry->period += sample->period;
 
+	if (sample->evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
+		entry->weight_sum[WEIGHT_WEIGHT] += sample->weight;
+		entry->weight_num[WEIGHT_WEIGHT]++;
+		if (sample->weight)
+			sym_hist__set_weight_mask(h, BIT(WEIGHT_WEIGHT));
+	}
+	if (sample->evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		entry->weight_sum[WEIGHT_INSNLAT] += sample->ins_lat;
+		entry->weight_num[WEIGHT_INSNLAT]++;
+		entry->weight_sum[WEIGHT_WEIGHT3] += sample->weight3;
+		entry->weight_num[WEIGHT_WEIGHT3]++;
+		if (sample->ins_lat)
+			sym_hist__set_weight_mask(h, BIT(WEIGHT_INSNLAT));
+		if (sample->weight3)
+			sym_hist__set_weight_mask(h, BIT(WEIGHT_WEIGHT3));
+	}
+
 	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
-		  ", evidx=%d] => nr_samples: %" PRIu64 ", period: %" PRIu64 "\n",
+		  ", evidx=%d] => nr_samples: %" PRIu64 ", period: %" PRIu64
+		  " weight %" PRIu64 "\n",
 		  sym->start, sym->name, addr, addr - sym->start, evsel->core.idx,
-		  entry->nr_samples, entry->period);
+		  entry->nr_samples, entry->period, weight);
 	return 0;
 }
 
@@ -778,6 +797,41 @@ static bool needs_type_info(struct annotated_data_type *data_type)
 	return (data_type != &stackop_type) && (data_type != &canary_type);
 }
 
+static const char *annotation__weight_mode_str(enum symbol__weight_mode mode)
+{
+	switch (mode) {
+	case WEIGHT_NONE:
+		return "";
+	case WEIGHT_WEIGHT:
+		return "Weight";
+	case WEIGHT_INSNLAT:
+		return "InsnLat";
+	case WEIGHT_WEIGHT3:
+		return "Weight3";
+	default:
+		return "";
+	}
+}
+
+static void annotation__column_title(char *buf, size_t size,
+					     struct annotation *notes,
+					     const struct evsel *evsel)
+{
+	const char *base = symbol_conf.show_total_period ? "Period" :
+			symbol_conf.show_nr_samples ? "Samples" : "Percent";
+	int weight;
+	u8 weight_mask = annotation__weight_mask(notes, evsel);
+
+	scnprintf(buf, size, "%s", base);
+	for_each_weight(weight) {
+		if (weight_mask & BIT(weight))
+			scnprintf(buf + strlen(buf),
+				  size - strlen(buf),
+				  " %s",
+				  annotation__weight_mode_str(weight));
+	}
+}
+
 static int
 annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
 		       struct annotation_options *opts, int printed,
@@ -833,6 +887,8 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 		for (i = 0; i < nr_percent; i++) {
 			struct annotation_data *data = &al->data[i];
 			double percent;
+			int weight;
+			u8 weight_mask = annotation__weight_mask(notes, apd->evsel);
 
 			percent = annotation_data__percent(data, percent_type);
 			color = get_percent_color(percent);
@@ -845,6 +901,13 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 					      data->he.nr_samples);
 			else
 				color_fprintf(stdout, color, " %7.2f", percent);
+			for_each_weight(weight) {
+				if (weight_mask & BIT(weight))
+					color_fprintf(stdout, color, " %7" PRIu64,
+						      data->he.weight_num[weight] ?
+						      data->he.weight_sum[weight] / data->he.weight_num[weight]
+						      : 0);
+			}
 		}
 
 		printf(" : ");
@@ -891,7 +954,7 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 	} else if (max_lines && printed >= max_lines)
 		return 1;
 	else {
-		int width = annotation__pcnt_width(notes);
+		int width = annotation__pcnt_width(notes, apd->evsel);
 
 		if (queue)
 			return -1;
@@ -915,6 +978,9 @@ static void calc_percent(struct annotation *notes,
 	struct sym_hist *sym_hist = annotation__histogram(notes, evsel);
 	unsigned int hits = 0;
 	u64 period = 0;
+	int i;
+	u64 weight_sum[WEIGHT_WEIGHT3 + 1] = { 0 };
+	u64 weight_num[WEIGHT_WEIGHT3 + 1] = { 0 };
 
 	while (offset < end) {
 		struct sym_hist_entry *entry;
@@ -923,6 +989,10 @@ static void calc_percent(struct annotation *notes,
 		if (entry) {
 			hits   += entry->nr_samples;
 			period += entry->period;
+			for_each_weight(i) {
+				weight_sum[i] += entry->weight_sum[i];
+				weight_num[i] += entry->weight_num[i];
+			}
 		}
 		++offset;
 	}
@@ -930,6 +1000,10 @@ static void calc_percent(struct annotation *notes,
 	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
+		for_each_weight(i) {
+			data->he.weight_sum[i] = weight_sum[i];
+			data->he.weight_num[i] = weight_num[i];
+		}
 		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
 
@@ -1252,8 +1326,9 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	int printed = 2, queue_len = 0;
 	int more = 0;
 	bool context = opts->context;
-	int width = annotation__pcnt_width(notes);
+	int width = annotation__pcnt_width(notes, evsel);
 	int graph_dotted_len;
+	char title[64];
 	char buf[512];
 
 	filename = strdup(dso__long_name(dso));
@@ -1275,10 +1350,10 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 		return ENOTSUP;
 	}
 
-	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
+	annotation__column_title(title, sizeof(title), notes, evsel);
+	graph_dotted_len = printf(" %-*.*s|\tSource code & Disassembly of %s for %s (%" PRIu64 " samples, "
 				  "percent: %s)\n",
-				  width, width, symbol_conf.show_total_period ? "Period" :
-				  symbol_conf.show_nr_samples ? "Samples" : "Percent",
+				  width, width, title,
 				  d_filename, evsel_name, h->nr_samples,
 				  percent_type_str(opts->percent_type));
 
@@ -2029,7 +2104,8 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
 	return printed;
 }
 
-void annotation_line__write(struct annotation_line *al, struct annotation *notes,
+void annotation_line__write(struct annotation_line *al,
+			    struct annotation *notes,
 			    const struct annotation_write_ops *wops,
 			    struct annotation_print_data *apd)
 {
@@ -2037,7 +2113,8 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 	bool change_color = wops->change_color;
 	double percent_max = annotation_line__max_percent(al, annotate_opts.percent_type);
 	int width = wops->width;
-	int pcnt_width = annotation__pcnt_width(notes);
+	int pcnt_width = annotation__pcnt_width(notes, apd->evsel);
+	u8 weight_mask = annotation__weight_mask(notes, apd->evsel);
 	int cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
 	char bf[256];
@@ -2062,6 +2139,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
 		for (i = 0; i < al->data_nr; i++) {
 			double percent;
+			int weight;
 
 			percent = annotation_data__percent(&al->data[i],
 							   annotate_opts.percent_type);
@@ -2075,6 +2153,14 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			} else {
 				obj__printf(obj, "%7.2f ", percent);
 			}
+
+			for_each_weight(weight) {
+				if (weight_mask & BIT(weight))
+					obj__printf(obj, "%7" PRIu64 " ",
+						    al->data[i].he.weight_num[weight] ?
+						    al->data[i].he.weight_sum[weight] /	al->data[i].he.weight_num[weight] :
+						    0);
+			}
 		}
 	} else {
 		obj__set_percent_color(obj, 0, current_entry);
@@ -2082,9 +2168,9 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		if (!show_title)
 			obj__printf(obj, "%-*s", pcnt_width, " ");
 		else {
-			obj__printf(obj, "%-*s", pcnt_width,
-					   symbol_conf.show_total_period ? "Period" :
-					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
+			char buf[64];
+			annotation__column_title(buf, sizeof(buf), notes, apd->evsel);
+			obj__printf(obj, "%-*s", pcnt_width, buf);
 		}
 	}
 	width -= pcnt_width;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fa08d09b80f7..63bce7a920f3 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <linux/types.h>
+#include <linux/bitops.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <asm/bug.h>
@@ -86,6 +87,8 @@ struct annotation;
 struct sym_hist_entry {
 	u64		nr_samples;
 	u64		period;
+	u64		weight_sum[WEIGHT_WEIGHT3 + 1];
+	u64		weight_num[WEIGHT_WEIGHT3 + 1];
 };
 
 enum {
@@ -231,8 +234,20 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 struct sym_hist {
 	u64		      nr_samples;
 	u64		      period;
+	u8		      weight_mask;
 };
 
+/* Can be set asynchronously by top. */
+static inline u8 sym_hist__weight_mask(const struct sym_hist *hist)
+{
+	return __atomic_load_n(&hist->weight_mask, __ATOMIC_RELAXED);
+}
+
+static inline void sym_hist__set_weight_mask(struct sym_hist *hist, u8 mask)
+{
+	__atomic_fetch_or(&hist->weight_mask, mask, __ATOMIC_RELAXED);
+}
+
 /**
  * struct cyc_hist - (CPU) cycle histogram for a basic block
  *
@@ -376,9 +391,22 @@ static inline int annotation__cycles_width(struct annotation *notes)
 	return notes->branch ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
-static inline int annotation__pcnt_width(struct annotation *notes)
+static inline u8 annotation__weight_mask(struct annotation *notes,
+					 const struct evsel *evsel)
+{
+	if (symbol_conf.weight_mask_user)
+		return symbol_conf.weight_mask;
+	if (symbol_conf.hide_weight)
+		return 0;
+	return sym_hist__weight_mask(&notes->src->histograms[evsel->core.idx]);
+}
+
+static inline int annotation__pcnt_width(struct annotation *notes,
+					 const struct evsel *evsel)
 {
-	return (symbol_conf.show_total_period ? 12 : 8) * notes->src->nr_events;
+	int extra = hweight8(annotation__weight_mask(notes, evsel)) * 8;
+	return ((symbol_conf.show_total_period ? 12 : 8) + extra) *
+	       notes->src->nr_events;
 }
 
 static inline bool annotation_line__filter(struct annotation_line *al)
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 0dee5aa6a534..6931fa014255 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -27,6 +27,16 @@ enum a2l_style {
 };
 #define MAX_A2L_STYLE (A2L_STYLE_CMD + 1)
 
+enum symbol__weight_mode {
+	WEIGHT_NONE = 0,
+	WEIGHT_WEIGHT,
+	WEIGHT_INSNLAT,
+	WEIGHT_WEIGHT3,
+};
+
+#define for_each_weight(_weight) \
+	for ((_weight) = WEIGHT_WEIGHT; (_weight) <= WEIGHT_WEIGHT3; (_weight)++)
+
 struct symbol_conf {
 	bool		nanosecs;
 	unsigned short	priv_size;
@@ -69,7 +79,10 @@ struct symbol_conf {
 			annotate_data_sample,
 			skip_empty,
 			enable_latency,
-			prefer_latency;
+			prefer_latency,
+			hide_weight,
+			weight_mask_user;
+	u8		weight_mask;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.55.0

