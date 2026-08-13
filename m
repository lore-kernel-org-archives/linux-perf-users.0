Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8873C5526
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627768; cv=none; b=GUOFi4U+xEIWYdn+Z1GqMoaNZe4I+NOBvxMIXYcpES6Ea2bMy/ci1YVHDacDJnC46fzADHPEfUP8z0egyKbHb4ujL9/bJCLqGHkd3V5Xg4puvrnFpANXeAo3dZTqcx8x6PFzgtd+ZshGYVkhtL2tK6QGxAvDIG+joF55GuZE9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627768; c=relaxed/simple;
	bh=j4q/yjmmADc28xvlT/hVe9ur9pUGWtqh04eMSnohoVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS4mh8NQ3XmKJWXBqIraZI9n5NXyx2D1lTLWs9hcAlJip9qrGFTKqBXdTTXHQQ1oldg+5P6WHcYcLXjrs08XC4QjvwEK1tPoMIzok6ZqTsV1iwrnHTX+jz03hKGKxwNn546Mj/lzunb7NrHxm3tdAH4whfEGpF17yjwQ9/1r2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3gkReqf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3gkReqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786627766; x=1818163766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j4q/yjmmADc28xvlT/hVe9ur9pUGWtqh04eMSnohoVA=;
  b=W3gkReqf5qLT2Lv2OFJTq185wpq8I8ocGOyRtgwEFgvfpJt2WRYQLq2f
   m3CcMohKHsHnnJtkOfiZWPTFBmqFsU9UhaaRUxwQyR5ihbdDmXKU29bus
   V3t4LvKMHuzt8kn8pJzHVmisjvZBs2iBj1zW/hdPGqXmK1zlf2G1i8zvQ
   JrDUjlmVwgswcyCDdBMZu9lSeHIbSHlEAbR9VlGTYWIn/p8vNSULus5uN
   YyVHR5gHLOMquSqBOWNYsMLRvCrBCSQoFwDNK26Ty3LsWLZYBFTy6QYMD
   ibz3MsmdbsE7OcTr/bYH9o4VL4XdnWECI7sS3EbGDaxvY+1+sXR88Xs1p
   w==;
X-CSE-ConnectionGUID: nq9R7xEDQsedsTYOzXchkA==
X-CSE-MsgGUID: vgptq5OETq6jg1uAuUvymQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89720109"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="89720109"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:26 -0700
X-CSE-ConnectionGUID: ZRUaSJo7QMWjZtk0fIQTAQ==
X-CSE-MsgGUID: ZWQdnZmbTLuOG39fRcbEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="267455275"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:26 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 3/4] perf tools: Add support for displaying weights in annotate
Date: Thu, 13 Aug 2026 06:29:06 -0700
Message-ID: <20260813132907.50738-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813132907.50738-1-ak@linux.intel.com>
References: <20260813132907.50738-1-ak@linux.intel.com>
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
 tools/perf/Documentation/perf-annotate.txt |  3 +
 tools/perf/builtin-annotate.c              |  4 +
 tools/perf/builtin-report.c                |  2 +
 tools/perf/builtin-top.c                   |  1 +
 tools/perf/ui/browsers/annotate.c          | 13 ++-
 tools/perf/util/annotate.c                 | 94 +++++++++++++++++++---
 tools/perf/util/annotate.h                 |  6 +-
 tools/perf/util/symbol.c                   | 11 +++
 tools/perf/util/symbol_conf.h              | 18 ++++-
 9 files changed, 140 insertions(+), 12 deletions(-)

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
index 69cb72b2082a..a78decad3f40 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -259,6 +259,8 @@ static int add_sample(struct perf_sample *sample,
 		return 0;
 	}
 
+	symbol_conf__set_weight_mode(&symbol_conf, sample);
+
 	/*
 	 * XXX filtered samples can still have branch entries pointing into our
 	 * symbol and are missed.
@@ -719,6 +721,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 #endif
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
+	OPT_BOOLEAN(0, "no-weights", &symbol_conf.hide_weight,
+		    "Hide weight columns in annotation"),
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
                     "don't load vmlinux even if found"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 60d1f166629e..5ee7bc62b6b6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -329,6 +329,8 @@ static int process_sample_event(const struct perf_tool *tool,
 				     &rep->total_cycles);
 	}
 
+	symbol_conf__set_weight_mode(&symbol_conf, sample);
+
 	rep->total_samples++;
 	if (al.parallelism == 1)
 		rep->singlethreaded_samples++;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2888ac3b7b92..32bd6e23f6fd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -827,6 +827,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 			top->vmlinux_warned = true;
 		}
 	}
+	symbol_conf__set_weight_mode(&symbol_conf, sample);
 
 	if (al.sym == NULL ||
 	    !symbol__is_idle(al.sym, al.map ? map__dso(al.map) : NULL, machine->env)) {
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e47a46775089..dada5fa6d29f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -972,6 +972,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"O             Bump offset level (jump targets -> +call -> all -> cycle thru)\n"
 		"s             Toggle source code view\n"
 		"t             Circulate percent, total period, samples view\n"
+		"w             Toggle weight columns\n"
 		"c             Show min/max cycle\n"
 		"/             Search string\n"
 		"k             Toggle line numbers\n"
@@ -1091,6 +1092,14 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				symbol_conf.show_total_period = true;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'w':
+			symbol_conf.hide_weight = !symbol_conf.hide_weight;
+			symbol_conf.weight_mask = symbol_conf.hide_weight ? 0 :
+				annotation__histogram(notes, evsel)->weight_mask;
+			browser->b.width = notes->src->widths.max_line_len +
+				annotation__pcnt_width(notes);
+			ui_browser__refresh_dimensions(&browser->b);
+			continue;
 		case 'c':
 			if (annotate_opts.show_minmax_cycle)
 				annotate_opts.show_minmax_cycle = false;
@@ -1225,10 +1234,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 		browser.type_hash = hashmap__new(type_hash, type_equal, /*ctx=*/NULL);
 	}
 
+	symbol_conf.weight_mask = symbol_conf.hide_weight ? 0 :
+		annotation__histogram(notes, evsel)->weight_mask;
 	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
 	browser.b.entries = &notes->src->source;
-	browser.b.width += 18; /* Percentage */
+	browser.b.width += annotation__pcnt_width(notes);
 
 	if (annotate_opts.hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index df70e95a8470..6be6ec47f298 100644
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
+			h->weight_mask |= BIT(WEIGHT_WEIGHT);
+	}
+	if (sample->evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		entry->weight_sum[WEIGHT_INSNLAT] += sample->ins_lat;
+		entry->weight_num[WEIGHT_INSNLAT]++;
+		entry->weight_sum[WEIGHT_WEIGHT3] += sample->weight3;
+		entry->weight_num[WEIGHT_WEIGHT3]++;
+		if (sample->ins_lat)
+			h->weight_mask |= BIT(WEIGHT_INSNLAT);
+		if (sample->weight3)
+			h->weight_mask |= BIT(WEIGHT_WEIGHT3);
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
 
@@ -778,6 +797,34 @@ static bool needs_type_info(struct annotated_data_type *data_type)
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
+static void annotation__column_title(char *buf, size_t size)
+{
+	const char *base = symbol_conf.show_total_period ? "Period" :
+			symbol_conf.show_nr_samples ? "Samples" : "Percent";
+	int i;
+	scnprintf(buf, size, "%s", base);
+	for_each_weight(i)
+		if (symbol_conf.weight_mask & BIT(i))
+			scnprintf(buf + strlen(buf), size - strlen(buf), " %s",
+				  annotation__weight_mode_str(i));
+}
+
 static int
 annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
 		       struct annotation_options *opts, int printed,
@@ -845,6 +892,12 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
 					      data->he.nr_samples);
 			else
 				color_fprintf(stdout, color, " %7.2f", percent);
+			for_each_weight(i) {
+				if (symbol_conf.weight_mask & BIT(i))
+					color_fprintf(stdout, color, " %7" PRIu64,
+							data->he.weight_num[i] ?
+							data->he.weight_sum[i] / data->he.weight_num[i] : 0);
+			}
 		}
 
 		printf(" : ");
@@ -915,6 +968,9 @@ static void calc_percent(struct annotation *notes,
 	struct sym_hist *sym_hist = annotation__histogram(notes, evsel);
 	unsigned int hits = 0;
 	u64 period = 0;
+	int i;
+	u64 weight_sum[WEIGHT_WEIGHT3 + 1] = { 0 };
+	u64 weight_num[WEIGHT_WEIGHT3 + 1] = { 0 };
 
 	while (offset < end) {
 		struct sym_hist_entry *entry;
@@ -923,6 +979,10 @@ static void calc_percent(struct annotation *notes,
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
@@ -930,6 +990,10 @@ static void calc_percent(struct annotation *notes,
 	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
+		for_each_weight(i) {
+			data->he.weight_sum[i] = weight_sum[i];
+			data->he.weight_num[i] = weight_num[i];
+		}
 		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
 
@@ -1252,9 +1316,12 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	int printed = 2, queue_len = 0;
 	int more = 0;
 	bool context = opts->context;
-	int width = annotation__pcnt_width(notes);
+	int width;
 	int graph_dotted_len;
+	char title[64];
 	char buf[512];
+	symbol_conf.weight_mask = symbol_conf.hide_weight ? 0 : h->weight_mask;
+	width = annotation__pcnt_width(notes);
 
 	filename = strdup(dso__long_name(dso));
 	if (!filename)
@@ -1275,10 +1342,10 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 		return ENOTSUP;
 	}
 
-	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
+	annotation__column_title(title, sizeof(title));
+	graph_dotted_len = printf(" %-*.*s|\tSource code & Disassembly of %s for %s (%" PRIu64 " samples, "
 				  "percent: %s)\n",
-				  width, width, symbol_conf.show_total_period ? "Period" :
-				  symbol_conf.show_nr_samples ? "Samples" : "Percent",
+				  width, width, title,
 				  d_filename, evsel_name, h->nr_samples,
 				  percent_type_str(opts->percent_type));
 
@@ -2062,6 +2129,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
 		for (i = 0; i < al->data_nr; i++) {
 			double percent;
+			int weight;
 
 			percent = annotation_data__percent(&al->data[i],
 							   annotate_opts.percent_type);
@@ -2075,6 +2143,14 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			} else {
 				obj__printf(obj, "%7.2f ", percent);
 			}
+
+			for_each_weight(weight) {
+				if (symbol_conf.weight_mask & BIT(weight))
+					obj__printf(obj, "%7" PRIu64 " ",
+								al->data[i].he.weight_num[weight] ?
+								al->data[i].he.weight_sum[weight] /
+								al->data[i].he.weight_num[weight] : 0);
+			}
 		}
 	} else {
 		obj__set_percent_color(obj, 0, current_entry);
@@ -2082,9 +2158,9 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		if (!show_title)
 			obj__printf(obj, "%-*s", pcnt_width, " ");
 		else {
-			obj__printf(obj, "%-*s", pcnt_width,
-					   symbol_conf.show_total_period ? "Period" :
-					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
+			char buf[64];
+			annotation__column_title(buf, sizeof(buf));
+			obj__printf(obj, "%-*s", pcnt_width, buf);
 		}
 	}
 	width -= pcnt_width;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fa08d09b80f7..0880605b4e1d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -86,6 +86,8 @@ struct annotation;
 struct sym_hist_entry {
 	u64		nr_samples;
 	u64		period;
+	u64		weight_sum[WEIGHT_WEIGHT3 + 1];
+	u64		weight_num[WEIGHT_WEIGHT3 + 1];
 };
 
 enum {
@@ -231,6 +233,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 struct sym_hist {
 	u64		      nr_samples;
 	u64		      period;
+	u8		      weight_mask;
 };
 
 /**
@@ -378,7 +381,8 @@ static inline int annotation__cycles_width(struct annotation *notes)
 
 static inline int annotation__pcnt_width(struct annotation *notes)
 {
-	return (symbol_conf.show_total_period ? 12 : 8) * notes->src->nr_events;
+	int extra = __builtin_popcount(symbol_conf.weight_mask) * 8;
+	return ((symbol_conf.show_total_period ? 12 : 8) + extra) * notes->src->nr_events;
 }
 
 static inline bool annotation_line__filter(struct annotation_line *al)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 94f9c8faedda..4b04320e35ec 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2763,3 +2763,14 @@ char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 
 	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
 }
+
+void symbol_conf__set_weight_mode(struct symbol_conf *c,
+				  struct perf_sample *sample)
+{
+	if (sample->weight)
+		c->weight_mask |= BIT(WEIGHT_WEIGHT);
+	if (sample->ins_lat)
+		c->weight_mask |= BIT(WEIGHT_INSNLAT);
+	if (sample->weight3)
+		c->weight_mask |= BIT(WEIGHT_WEIGHT3);
+}
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 0dee5aa6a534..36328edb635b 100644
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
@@ -69,7 +79,9 @@ struct symbol_conf {
 			annotate_data_sample,
 			skip_empty,
 			enable_latency,
-			prefer_latency;
+			prefer_latency,
+			hide_weight;
+	u8		weight_mask;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
@@ -114,4 +126,8 @@ struct symbol_conf {
 
 extern struct symbol_conf symbol_conf;
 
+struct perf_sample;
+void symbol_conf__set_weight_mode(struct symbol_conf *c,
+				  struct perf_sample *sample);
+
 #endif // __PERF_SYMBOL_CONF
-- 
2.55.0

