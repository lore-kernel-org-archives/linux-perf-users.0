Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91972305057
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788118515; cv=none; b=ga8aom4SufIwQVF6FbFFaG4/CM+6lCd5HkJmdaF5aroUA9JokVC0fVRIXqAS0znGMPxmJZ0wFG6W5/DDeSvWxQLcza1zByDfchdsTj6uKh+dE1MWI3XFtxOY7/clXvFW09TPhLONzw7Fw/DcG81W4cexwnrsAGg59TjV2gMum9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788118515; c=relaxed/simple;
	bh=9dWZ6y8rPGNy0nPwzqv+nJgSuvQpPXYt60y0iVHH0KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwxaHT6a48HqJ9IQyfGFHelU2O5uO/bcmVkTdChUk17WVS0bVCTknP00eQ0IiAzyz7WBmKbGfGHQyzHKUa592yoBwBghJjW14hKHajyNP3t/01w1DG4oTMCRCXpVEBRgyZje4apgWfcy2YHwd34l9xdoyH/UtWfQU0WOKGt/eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWezhDJJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWezhDJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788118513; x=1819654513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dWZ6y8rPGNy0nPwzqv+nJgSuvQpPXYt60y0iVHH0KY=;
  b=GWezhDJJT0WufwAd66eKsaiqWOH+55CgzDCYZJmEelRiKysZhSMJJVC8
   4J8X3GJeojcGTZntkfLiQKi84kRcqIU94/d4cTfGRmsp9GxNKvUmD+e2H
   wYbOs0p0XNg68dDxJWIymHWYehOm7vQeMx4BfhSi0xdKyX2X88kiDWlOH
   oWTGSv7V7gptR0/5CD5K1we313lzJluFBMarL+7Uoce1tw5citenspSMW
   bsRaBHu8MzZuJf2L7rtMPgT5ZxzLg60uc6VS55+KRFHqR6DtNA+2Y7eCN
   aA/WPD9DoW8YolRNAaWcMdXKmg9pBM7Z2f2kxIDU7py2xMk6ly0bWts/a
   A==;
X-CSE-ConnectionGUID: qxrrGR7NR+mg9Xly3PdFvw==
X-CSE-MsgGUID: iYA6G7eST9+2j3kbxb+LWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87667338"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="87667338"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:08 -0700
X-CSE-ConnectionGUID: ALcDLwyOTAylVQgF8JmeRQ==
X-CSE-MsgGUID: EP8ts6jhQy6c9rVjMMVi/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="292118656"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:08 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 3/4] perf tools: Add support for displaying weights in annotate
Date: Sun, 30 Aug 2026 12:34:39 -0700
Message-ID: <20260830193459.2840519-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830193459.2840519-1-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
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
 tools/perf/Documentation/perf-report.txt   |   6 +
 tools/perf/builtin-annotate.c              |   3 +
 tools/perf/builtin-report.c                |   3 +
 tools/perf/ui/browsers/annotate.c          |  20 +++-
 tools/perf/util/annotate.c                 | 121 +++++++++++++++++++--
 tools/perf/util/annotate.h                 |  44 +++++++-
 tools/perf/util/symbol_conf.h              |  13 ++-
 8 files changed, 194 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index a688738809c4..1a90b09a12d5 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -95,6 +95,9 @@ include::itrace.txt[]
 
 --gtk:: Use the GTK interface.
 
+--weights:: Show or hide (with `--no-weights`) weight columns in annotation output.
+	    By default, weight columns are shown when samples contain non-zero weights.
+
 -C::
 --cpu=<cpu>:: Only report samples for the list of CPUs provided. Multiple CPUs can
 	be provided as a comma-separated list with no space: 0,1. Ranges of
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 22f87eaa3279..ae68ca402d0b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -64,6 +64,9 @@ OPTIONS
 --symbol-filter=::
 	Only show symbols that match (partially) with this filter.
 
+--weights:: Show or hide (with `--no-weights`) weight columns in annotation output.
+	    By default, weight columns are shown when samples contain non-zero weights.
+
 -U::
 --hide-unresolved::
         Only display entries resolved to a symbol.
@@ -353,6 +356,9 @@ OPTIONS
 
 --gtk:: Use the GTK2 interface.
 
+--weights:: Show or hide (with `--no-weights`) weight columns in annotation output.
+           By default, weight columns are shown when samples contain non-zero weights.
+
 -k::
 --vmlinux=<file>::
         vmlinux pathname
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 69cb72b2082a..9e0b704c31f4 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -719,6 +719,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 #endif
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
+	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
+		    "Show or hide weight columns in annotation. Default show if non zero."),
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
                     "don't load vmlinux even if found"),
@@ -788,6 +790,7 @@ int cmd_annotate(int argc, const char **argv)
 
 	set_option_flag(options, 0, "show-total-period", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 0, "show-nr-samples", PARSE_OPT_EXCLUSIVE);
+	symbol_conf.annotate_weight = true;
 
 	annotation_options__init();
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 60d1f166629e..b55c01bb45b4 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1364,6 +1364,8 @@ int cmd_report(int argc, const char **argv)
 #endif
 	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
 		    "Use the stdio interface"),
+	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
+			"Show or hide weight columns in annotation. Default show if non-zero."),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
@@ -1525,6 +1527,7 @@ int cmd_report(int argc, const char **argv)
 	 * reference exited threads.
 	 */
 	symbol_conf.keep_exited_threads = true;
+	symbol_conf.annotate_weight = true;
 
 	annotation_options__init();
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e47a46775089..e8de644c0e9d 100644
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
@@ -1091,6 +1093,14 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				symbol_conf.show_total_period = true;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'w':
+			symbol_conf.annotate_weight = !symbol_conf.annotate_weight;
+			browser->b.width = notes->src->widths.max_line_len +
+					   annotation__pcnt_width(notes, evsel) +
+					   annotation__cycles_width(notes) +
+					   annotation__br_cntr_width();
+			ui_browser__refresh_dimensions(&browser->b);
+			continue;
 		case 'c':
 			if (annotate_opts.show_minmax_cycle)
 				annotate_opts.show_minmax_cycle = false;
@@ -1225,10 +1235,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 		browser.type_hash = hashmap__new(type_hash, type_equal, /*ctx=*/NULL);
 	}
 
-	browser.b.width = notes->src->widths.max_line_len;
+	browser.b.width = notes->src->widths.max_line_len +
+			   annotation__pcnt_width(notes, evsel) +
+			   annotation__cycles_width(notes) +
+			   annotation__br_cntr_width();
 	browser.b.nr_entries = notes->src->nr_entries;
 	browser.b.entries = &notes->src->source;
-	browser.b.width += 18; /* Percentage */
 
 	if (annotate_opts.hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index df70e95a8470..9304c21c686a 100644
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
 
@@ -778,6 +797,50 @@ static bool needs_type_info(struct annotated_data_type *data_type)
 	return (data_type != &stackop_type) && (data_type != &canary_type);
 }
 
+static const char *annotation__weight_mode_str(enum symbol__weight_mode mode,
+						 const struct evsel *evsel)
+{
+	switch (mode) {
+	case WEIGHT_NONE:
+		return "";
+	case WEIGHT_WEIGHT:
+		return "Weight";
+	case WEIGHT_INSNLAT:
+		return "InsnLat";
+	case WEIGHT_WEIGHT3:
+		switch (evsel__e_machine((struct evsel *)evsel, NULL)) {
+		case EM_PPC:
+		case EM_PPC64:
+			return "PCycleLat";
+		case EM_X86_64:
+			return "RetireLat";
+		default:
+			return "Weight3";
+		}
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
+				  annotation__weight_mode_str(weight, evsel));
+	}
+}
+
 static int
 annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
 		       struct annotation_options *opts, int printed,
@@ -833,6 +896,8 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 		for (i = 0; i < nr_percent; i++) {
 			struct annotation_data *data = &al->data[i];
 			double percent;
+			int weight;
+			u8 weight_mask = annotation__weight_mask(notes, apd->evsel);
 
 			percent = annotation_data__percent(data, percent_type);
 			color = get_percent_color(percent);
@@ -845,6 +910,14 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 					      data->he.nr_samples);
 			else
 				color_fprintf(stdout, color, " %7.2f", percent);
+			for_each_weight(weight) {
+				if (weight_mask & BIT(weight))
+					color_fprintf(stdout, color, " %7" PRIu64,
+						      data->he.weight_num[weight] ?
+						      data->he.weight_sum[weight] /
+						      data->he.weight_num[weight]
+						      : 0);
+			}
 		}
 
 		printf(" : ");
@@ -891,7 +964,7 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 	} else if (max_lines && printed >= max_lines)
 		return 1;
 	else {
-		int width = annotation__pcnt_width(notes);
+		int width = annotation__pcnt_width(notes, apd->evsel);
 
 		if (queue)
 			return -1;
@@ -915,6 +988,9 @@ static void calc_percent(struct annotation *notes,
 	struct sym_hist *sym_hist = annotation__histogram(notes, evsel);
 	unsigned int hits = 0;
 	u64 period = 0;
+	int i;
+	u64 weight_sum[WEIGHT_WEIGHT3 + 1] = { 0 };
+	u64 weight_num[WEIGHT_WEIGHT3 + 1] = { 0 };
 
 	while (offset < end) {
 		struct sym_hist_entry *entry;
@@ -923,6 +999,10 @@ static void calc_percent(struct annotation *notes,
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
@@ -930,6 +1010,10 @@ static void calc_percent(struct annotation *notes,
 	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
+		for_each_weight(i) {
+			data->he.weight_sum[i] = weight_sum[i];
+			data->he.weight_num[i] = weight_num[i];
+		}
 		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
 
@@ -1252,8 +1336,9 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	int printed = 2, queue_len = 0;
 	int more = 0;
 	bool context = opts->context;
-	int width = annotation__pcnt_width(notes);
+	int width = annotation__pcnt_width(notes, evsel);
 	int graph_dotted_len;
+	char title[64];
 	char buf[512];
 
 	filename = strdup(dso__long_name(dso));
@@ -1275,10 +1360,10 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
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
 
@@ -2029,7 +2114,8 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
 	return printed;
 }
 
-void annotation_line__write(struct annotation_line *al, struct annotation *notes,
+void annotation_line__write(struct annotation_line *al,
+			    struct annotation *notes,
 			    const struct annotation_write_ops *wops,
 			    struct annotation_print_data *apd)
 {
@@ -2037,7 +2123,8 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 	bool change_color = wops->change_color;
 	double percent_max = annotation_line__max_percent(al, annotate_opts.percent_type);
 	int width = wops->width;
-	int pcnt_width = annotation__pcnt_width(notes);
+	int pcnt_width = annotation__pcnt_width(notes, apd->evsel);
+	u8 weight_mask = annotation__weight_mask(notes, apd->evsel);
 	int cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
 	char bf[256];
@@ -2062,6 +2149,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
 		for (i = 0; i < al->data_nr; i++) {
 			double percent;
+			int weight;
 
 			percent = annotation_data__percent(&al->data[i],
 							   annotate_opts.percent_type);
@@ -2075,6 +2163,15 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			} else {
 				obj__printf(obj, "%7.2f ", percent);
 			}
+
+			for_each_weight(weight) {
+				if (weight_mask & BIT(weight))
+					obj__printf(obj, "%7" PRIu64 " ",
+						    al->data[i].he.weight_num[weight] ?
+						    al->data[i].he.weight_sum[weight] /
+						    al->data[i].he.weight_num[weight] :
+						    0);
+			}
 		}
 	} else {
 		obj__set_percent_color(obj, 0, current_entry);
@@ -2082,9 +2179,9 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
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
index fa08d09b80f7..d7807df6667f 100644
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
@@ -376,9 +391,34 @@ static inline int annotation__cycles_width(struct annotation *notes)
 	return notes->branch ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
-static inline int annotation__pcnt_width(struct annotation *notes)
+static inline u8 annotation__weight_mask(struct annotation *notes,
+					 const struct evsel *evsel)
+{
+	u8 mask = 0;
+	struct evsel *pos;
+	int i;
+
+	if (!symbol_conf.annotate_weight)
+		return 0;
+
+	if (evsel__is_group_event((struct evsel *)evsel)) {
+		pos = (struct evsel *)evsel;
+		for (i = 0; i < evsel->core.nr_members; i++) {
+			mask |= sym_hist__weight_mask(&notes->src->histograms[pos->core.idx]);
+			pos = evsel__next(pos);
+		}
+		return mask;
+	}
+
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
index 0dee5aa6a534..71f60081a85b 100644
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
@@ -69,7 +79,8 @@ struct symbol_conf {
 			annotate_data_sample,
 			skip_empty,
 			enable_latency,
-			prefer_latency;
+			prefer_latency,
+			annotate_weight;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.55.0

