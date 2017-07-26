From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/40] perf annotate: Rename 'sum' to 'nr_samples' in struct sym_hist
Date: Wed, 26 Jul 2017 11:17:08 -0300
Message-ID: <20170726141730.30750-19-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

To make it more clear that it is the sum of all the nr_samples fields in the
addr[] entries, i.e.:

  sym_hist->nr_samples = sum(sym_hist->addr[0 ..  symbol__size(sym)]->nr_samples)

Committer notes:

Taeung had renamed it to total_samples, but using nr_samples, as in the
added explanation above, looks clearer and establishes the direct
connection, making clear it is about the _number_ of samples.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1500500211-16599-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/annotate.c |  2 +-
 tools/perf/util/annotate.c   | 26 +++++++++++++-------------
 tools/perf/util/annotate.h   |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index d736fd57ab9b..02176193f427 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -37,7 +37,7 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 	if (!symbol_conf.event_group && !symhist->addr[dl->offset].nr_samples)
 		return 0;
 
-	percent = 100.0 * symhist->addr[dl->offset].nr_samples / symhist->sum;
+	percent = 100.0 * symhist->addr[dl->offset].nr_samples / symhist->nr_samples;
 
 	markup = perf_gtk__get_percent_color(percent);
 	if (markup)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c3829555ce1c..58c6b63ff049 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -713,7 +713,7 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 
 	offset = addr - sym->start;
 	h = annotation__histogram(notes, evidx);
-	h->sum++;
+	h->nr_samples++;
 	h->addr[offset].nr_samples++;
 
 	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
@@ -957,9 +957,9 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 		while (offset < end)
 			hits += h->addr[offset++].nr_samples;
 
-		if (h->sum) {
+		if (h->nr_samples) {
 			sample->nr_samples = hits;
-			percent = 100.0 * hits / h->sum;
+			percent = 100.0 * hits / h->nr_samples;
 		}
 	}
 
@@ -1672,19 +1672,19 @@ static int symbol__get_source_line(struct symbol *sym, struct map *map,
 	struct sym_hist *h = annotation__histogram(notes, evidx);
 	struct rb_root tmp_root = RB_ROOT;
 	int nr_pcnt = 1;
-	u64 h_sum = h->sum;
+	u64 nr_samples = h->nr_samples;
 	size_t sizeof_src_line = sizeof(struct source_line);
 
 	if (perf_evsel__is_group_event(evsel)) {
 		for (i = 1; i < evsel->nr_members; i++) {
 			h = annotation__histogram(notes, evidx + i);
-			h_sum += h->sum;
+			nr_samples += h->nr_samples;
 		}
 		nr_pcnt = evsel->nr_members;
 		sizeof_src_line += (nr_pcnt - 1) * sizeof(src_line->samples);
 	}
 
-	if (!h_sum)
+	if (!nr_samples)
 		return 0;
 
 	src_line = notes->src->lines = calloc(len, sizeof_src_line);
@@ -1694,7 +1694,7 @@ static int symbol__get_source_line(struct symbol *sym, struct map *map,
 	start = map__rip_2objdump(map, sym->start);
 
 	for (i = 0; i < len; i++) {
-		u64 offset, nr_samples;
+		u64 offset;
 		double percent_max = 0.0;
 
 		src_line->nr_pcnt = nr_pcnt;
@@ -1704,8 +1704,8 @@ static int symbol__get_source_line(struct symbol *sym, struct map *map,
 
 			h = annotation__histogram(notes, evidx + k);
 			nr_samples = h->addr[i].nr_samples;
-			if (h->sum)
-				percent = 100.0 * nr_samples / h->sum;
+			if (h->nr_samples)
+				percent = 100.0 * nr_samples / h->nr_samples;
 
 			if (percent > percent_max)
 				percent_max = percent;
@@ -1777,7 +1777,7 @@ static void symbol__annotate_hits(struct symbol *sym, struct perf_evsel *evsel)
 		if (h->addr[offset].nr_samples != 0)
 			printf("%*" PRIx64 ": %" PRIu64 "\n", BITS_PER_LONG / 2,
 			       sym->start + offset, h->addr[offset].nr_samples);
-	printf("%*s: %" PRIu64 "\n", BITS_PER_LONG / 2, "h->sum", h->sum);
+	printf("%*s: %" PRIu64 "\n", BITS_PER_LONG / 2, "h->nr_samples", h->nr_samples);
 }
 
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
@@ -1813,7 +1813,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		width *= evsel->nr_members;
 
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
-	       width, width, "Percent", d_filename, evsel_name, h->sum);
+	       width, width, "Percent", d_filename, evsel_name, h->nr_samples);
 
 	printf("%-*.*s----\n",
 	       graph_dotted_len, graph_dotted_len, graph_dotted_line);
@@ -1877,10 +1877,10 @@ void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
 	struct sym_hist *h = annotation__histogram(notes, evidx);
 	int len = symbol__size(sym), offset;
 
-	h->sum = 0;
+	h->nr_samples = 0;
 	for (offset = 0; offset < len; ++offset) {
 		h->addr[offset].nr_samples = h->addr[offset].nr_samples * 7 / 8;
-		h->sum += h->addr[offset].nr_samples;
+		h->nr_samples += h->addr[offset].nr_samples;
 	}
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3a176633b324..e8c246ec53df 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -87,7 +87,7 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 			    s64 end, const char **path, struct sym_hist_entry *sample);
 
 struct sym_hist {
-	u64		sum;
+	u64		      nr_samples;
 	struct sym_hist_entry addr[0];
 };
 
-- 
2.9.4
