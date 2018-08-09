From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/44] perf annotate: Switch struct annotation_data::percent to array
Date: Thu,  9 Aug 2018 11:57:58 -0300
Message-ID: <20180809145822.21391-21-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So we can hold multiple percent values for annotation line.

The first member of this array is current local hits percent value
(PERCENT_HITS_LOCAL index), so no functional change is expected.

Adding annotation_data__percent function to return requested percent
value from struct annotation_data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  9 ++++---
 tools/perf/util/annotate.c        | 57 ++++++++++++++++++++++++++-------------
 tools/perf/util/annotate.h        | 13 ++++++++-
 3 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d648d1e153f3..81876c3923d2 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -315,10 +315,13 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		}
 
 		for (i = 0; i < pos->al.data_nr; i++) {
-			struct annotation_data *sample = &pos->al.data[i];
+			double percent;
 
-			if (max_percent < sample->percent)
-				max_percent = sample->percent;
+			percent = annotation_data__percent(&pos->al.data[i],
+							   PERCENT_HITS_LOCAL);
+
+			if (max_percent < percent)
+				max_percent = percent;
 		}
 
 		if (max_percent < 0.01 && pos->al.ipc == 0) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 34d4bb73aa84..074adb2a831e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1310,10 +1310,13 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		struct annotation *notes = symbol__annotation(sym);
 
 		for (i = 0; i < al->data_nr; i++) {
-			struct annotation_data *data = &al->data[i];
+			double percent;
+
+			percent = annotation_data__percent(&al->data[i],
+							   PERCENT_HITS_LOCAL);
 
-			if (data->percent > max_percent)
-				max_percent = data->percent;
+			if (percent > max_percent)
+				max_percent = percent;
 		}
 
 		if (al->data_nr > nr_percent)
@@ -1352,8 +1355,10 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 
 		for (i = 0; i < nr_percent; i++) {
 			struct annotation_data *data = &al->data[i];
+			double percent;
 
-			color = get_percent_color(data->percent);
+			percent = annotation_data__percent(data, PERCENT_HITS_LOCAL);
+			color = get_percent_color(percent);
 
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %11" PRIu64,
@@ -1362,7 +1367,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				color_fprintf(stdout, color, " %7" PRIu64,
 					      data->he.nr_samples);
 			else
-				color_fprintf(stdout, color, " %7.2f", data->percent);
+				color_fprintf(stdout, color, " %7.2f", percent);
 		}
 
 		printf(" : ");
@@ -1769,7 +1774,7 @@ static void calc_percent(struct sym_hist *sym_hist,
 	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
-		data->percent = 100.0 * hits / sym_hist->nr_samples;
+		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
 }
 
@@ -1862,8 +1867,10 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 
 		ret = strcmp(iter->path, al->path);
 		if (ret == 0) {
-			for (i = 0; i < al->data_nr; i++)
-				iter->data[i].percent_sum += al->data[i].percent;
+			for (i = 0; i < al->data_nr; i++) {
+				iter->data[i].percent_sum += annotation_data__percent(&al->data[i],
+										      PERCENT_HITS_LOCAL);
+			}
 			return;
 		}
 
@@ -1873,8 +1880,10 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 			p = &(*p)->rb_right;
 	}
 
-	for (i = 0; i < al->data_nr; i++)
-		al->data[i].percent_sum = al->data[i].percent;
+	for (i = 0; i < al->data_nr; i++) {
+		al->data[i].percent_sum = annotation_data__percent(&al->data[i],
+								   PERCENT_HITS_LOCAL);
+	}
 
 	rb_link_node(&al->rb_node, parent, p);
 	rb_insert_color(&al->rb_node, root);
@@ -2359,12 +2368,13 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		int i;
 
 		for (i = 0; i < al->data_nr; i++) {
-			struct annotation_data *data;
+			double percent;
 
-			data = &al->data[i];
+			percent = annotation_data__percent(&al->data[i],
+							   PERCENT_HITS_LOCAL);
 
-			if (data->percent > percent_max)
-				percent_max = data->percent;
+			if (percent > percent_max)
+				percent_max = percent;
 		}
 
 		if (percent_max <= 0.5)
@@ -2451,8 +2461,13 @@ static double annotation_line__max_percent(struct annotation_line *al,
 	int i;
 
 	for (i = 0; i < notes->nr_events; i++) {
-		if (al->data[i].percent > percent_max)
-			percent_max = al->data[i].percent;
+		double percent;
+
+		percent = annotation_data__percent(&al->data[i],
+						   PERCENT_HITS_LOCAL);
+
+		if (percent > percent_max)
+			percent_max = percent;
 	}
 
 	return percent_max;
@@ -2518,15 +2533,19 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		int i;
 
 		for (i = 0; i < notes->nr_events; i++) {
-			obj__set_percent_color(obj, al->data[i].percent, current_entry);
+			double percent;
+
+			percent = annotation_data__percent(&al->data[i],
+							   PERCENT_HITS_LOCAL);
+
+			obj__set_percent_color(obj, percent, current_entry);
 			if (notes->options->show_total_period) {
 				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
 			} else if (notes->options->show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
 						   al->data[i].he.nr_samples);
 			} else {
-				obj__printf(obj, "%6.2f ",
-						   al->data[i].percent);
+				obj__printf(obj, "%6.2f ", percent);
 			}
 		}
 	} else {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 58aa14c55bab..0afbf8075fca 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -101,8 +101,13 @@ struct sym_hist_entry {
 	u64		period;
 };
 
+enum {
+	PERCENT_HITS_LOCAL,
+	PERCENT_MAX,
+};
+
 struct annotation_data {
-	double			 percent;
+	double			 percent[PERCENT_MAX];
 	double			 percent_sum;
 	struct sym_hist_entry	 he;
 };
@@ -134,6 +139,12 @@ struct disasm_line {
 	struct annotation_line	 al;
 };
 
+static inline double annotation_data__percent(struct annotation_data *data,
+					      unsigned int which)
+{
+	return which < PERCENT_MAX ? data->percent[which] : -1;
+}
+
 static inline struct disasm_line *disasm_line(struct annotation_line *al)
 {
 	return al ? container_of(al, struct disasm_line, al) : NULL;
-- 
2.14.4
