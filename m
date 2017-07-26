From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/40] perf annotate: Introduce struct sym_hist_entry
Date: Wed, 26 Jul 2017 11:17:07 -0300
Message-ID: <20170726141730.30750-18-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbdGZOTZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jul 2017 10:19:25 -0400
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Taeung Song <treeze.taeung@gmail.com>

struct sym_hist has addr[] but it should have not only number of samples
but also the sample period.  So use new struct symhist_entry to pave the
way to have that.

Committer notes:

This initial patch will only introduce the struct sym_hist_entry and use
only the nr_samples member, which makes the code clearer and paves the
way to save the period as well.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1500500205-16553-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  6 +++---
 tools/perf/ui/gtk/annotate.c      |  4 ++--
 tools/perf/util/annotate.c        | 45 ++++++++++++++++++++-------------------
 tools/perf/util/annotate.h        |  9 ++++++--
 4 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 6794a8bec404..dbe4e630b90f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -450,14 +450,14 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		next = disasm__get_next_ip_line(&notes->src->source, pos);
 
 		for (i = 0; i < browser->nr_events; i++) {
-			u64 nr_samples;
+			struct sym_hist_entry sample;
 
 			bpos->samples[i].percent = disasm__calc_percent(notes,
 						evsel->idx + i,
 						pos->offset,
 						next ? next->offset : len,
-						&path, &nr_samples);
-			bpos->samples[i].nr = nr_samples;
+						&path, &sample);
+			bpos->samples[i].nr = sample.nr_samples;
 
 			if (max_percent < bpos->samples[i].percent)
 				max_percent = bpos->samples[i].percent;
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 87e3760624f2..d736fd57ab9b 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -34,10 +34,10 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 		return 0;
 
 	symhist = annotation__histogram(symbol__annotation(sym), evidx);
-	if (!symbol_conf.event_group && !symhist->addr[dl->offset])
+	if (!symbol_conf.event_group && !symhist->addr[dl->offset].nr_samples)
 		return 0;
 
-	percent = 100.0 * symhist->addr[dl->offset] / symhist->sum;
+	percent = 100.0 * symhist->addr[dl->offset].nr_samples / symhist->sum;
 
 	markup = perf_gtk__get_percent_color(percent);
 	if (markup)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1742510f0120..c3829555ce1c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -610,10 +610,10 @@ int symbol__alloc_hist(struct symbol *sym)
 	size_t sizeof_sym_hist;
 
 	/* Check for overflow when calculating sizeof_sym_hist */
-	if (size > (SIZE_MAX - sizeof(struct sym_hist)) / sizeof(u64))
+	if (size > (SIZE_MAX - sizeof(struct sym_hist)) / sizeof(struct sym_hist_entry))
 		return -1;
 
-	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(u64));
+	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
 
 	/* Check for overflow in zalloc argument */
 	if (sizeof_sym_hist > (SIZE_MAX - sizeof(*notes->src))
@@ -714,11 +714,11 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	offset = addr - sym->start;
 	h = annotation__histogram(notes, evidx);
 	h->sum++;
-	h->addr[offset]++;
+	h->addr[offset].nr_samples++;
 
 	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
 		  ", evidx=%d] => %" PRIu64 "\n", sym->start, sym->name,
-		  addr, addr - sym->start, evidx, h->addr[offset]);
+		  addr, addr - sym->start, evidx, h->addr[offset].nr_samples);
 	return 0;
 }
 
@@ -928,11 +928,12 @@ struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disa
 }
 
 double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
-			    s64 end, const char **path, u64 *nr_samples)
+			    s64 end, const char **path, struct sym_hist_entry *sample)
 {
 	struct source_line *src_line = notes->src->lines;
 	double percent = 0.0;
-	*nr_samples = 0;
+
+	sample->nr_samples = 0;
 
 	if (src_line) {
 		size_t sizeof_src_line = sizeof(*src_line) +
@@ -946,7 +947,7 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 				*path = src_line->path;
 
 			percent += src_line->samples[evidx].percent;
-			*nr_samples += src_line->samples[evidx].nr;
+			sample->nr_samples += src_line->samples[evidx].nr;
 			offset++;
 		}
 	} else {
@@ -954,10 +955,10 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 		unsigned int hits = 0;
 
 		while (offset < end)
-			hits += h->addr[offset++];
+			hits += h->addr[offset++].nr_samples;
 
 		if (h->sum) {
-			*nr_samples = hits;
+			sample->nr_samples = hits;
 			percent = 100.0 * hits / h->sum;
 		}
 	}
@@ -1057,10 +1058,10 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 
 	if (dl->offset != -1) {
 		const char *path = NULL;
-		u64 nr_samples;
 		double percent, max_percent = 0.0;
 		double *ppercents = &percent;
-		u64 *psamples = &nr_samples;
+		struct sym_hist_entry sample;
+		struct sym_hist_entry *psamples = &sample;
 		int i, nr_percent = 1;
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
@@ -1074,7 +1075,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		if (perf_evsel__is_group_event(evsel)) {
 			nr_percent = evsel->nr_members;
 			ppercents = calloc(nr_percent, sizeof(double));
-			psamples = calloc(nr_percent, sizeof(u64));
+			psamples = calloc(nr_percent, sizeof(struct sym_hist_entry));
 			if (ppercents == NULL || psamples == NULL) {
 				return -1;
 			}
@@ -1085,10 +1086,10 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 					notes->src->lines ? i : evsel->idx + i,
 					offset,
 					next ? next->offset : (s64) len,
-					&path, &nr_samples);
+					&path, &sample);
 
 			ppercents[i] = percent;
-			psamples[i] = nr_samples;
+			psamples[i] = sample;
 			if (percent > max_percent)
 				max_percent = percent;
 		}
@@ -1126,12 +1127,12 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 
 		for (i = 0; i < nr_percent; i++) {
 			percent = ppercents[i];
-			nr_samples = psamples[i];
+			sample = psamples[i];
 			color = get_percent_color(percent);
 
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %7" PRIu64,
-					      nr_samples);
+					      sample.nr_samples);
 			else
 				color_fprintf(stdout, color, " %7.2f", percent);
 		}
@@ -1147,7 +1148,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		if (ppercents != &percent)
 			free(ppercents);
 
-		if (psamples != &nr_samples)
+		if (psamples != &sample)
 			free(psamples);
 
 	} else if (max_lines && printed >= max_lines)
@@ -1702,7 +1703,7 @@ static int symbol__get_source_line(struct symbol *sym, struct map *map,
 			double percent = 0.0;
 
 			h = annotation__histogram(notes, evidx + k);
-			nr_samples = h->addr[i];
+			nr_samples = h->addr[i].nr_samples;
 			if (h->sum)
 				percent = 100.0 * nr_samples / h->sum;
 
@@ -1773,9 +1774,9 @@ static void symbol__annotate_hits(struct symbol *sym, struct perf_evsel *evsel)
 	u64 len = symbol__size(sym), offset;
 
 	for (offset = 0; offset < len; ++offset)
-		if (h->addr[offset] != 0)
+		if (h->addr[offset].nr_samples != 0)
 			printf("%*" PRIx64 ": %" PRIu64 "\n", BITS_PER_LONG / 2,
-			       sym->start + offset, h->addr[offset]);
+			       sym->start + offset, h->addr[offset].nr_samples);
 	printf("%*s: %" PRIu64 "\n", BITS_PER_LONG / 2, "h->sum", h->sum);
 }
 
@@ -1878,8 +1879,8 @@ void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
 
 	h->sum = 0;
 	for (offset = 0; offset < len; ++offset) {
-		h->addr[offset] = h->addr[offset] * 7 / 8;
-		h->sum += h->addr[offset];
+		h->addr[offset].nr_samples = h->addr[offset].nr_samples * 7 / 8;
+		h->sum += h->addr[offset].nr_samples;
 	}
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index bac698d7cc6a..3a176633b324 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -74,16 +74,21 @@ static inline bool disasm_line__has_offset(const struct disasm_line *dl)
 	return dl->ops.target.offset_avail;
 }
 
+struct sym_hist_entry {
+	u64		nr_samples;
+	u64		period;
+};
+
 void disasm_line__free(struct disasm_line *dl);
 struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disasm_line *pos);
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
-			    s64 end, const char **path, u64 *nr_samples);
+			    s64 end, const char **path, struct sym_hist_entry *sample);
 
 struct sym_hist {
 	u64		sum;
-	u64		addr[0];
+	struct sym_hist_entry addr[0];
 };
 
 struct cyc_hist {
-- 
2.9.4
