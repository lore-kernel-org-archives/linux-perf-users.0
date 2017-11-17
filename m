From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/83] perf annotate: Remove disasm__calc_percent() from disasm_line__print()
Date: Fri, 17 Nov 2017 17:14:58 -0300
Message-ID: <20171117201601.24110-21-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Remove disasm__calc_percent() from disasm_line__print(), because we
already have the data calculated in struct annotation_line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c   |  3 +++
 tools/perf/util/annotate.c | 59 ++++++++++++----------------------------------
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index adfeeb488f1a..0789f95ca2f3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -226,6 +226,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 static void perf_top__show_details(struct perf_top *top)
 {
 	struct hist_entry *he = top->sym_filter_entry;
+	struct perf_evsel *evsel = hists_to_evsel(he->hists);
 	struct annotation *notes;
 	struct symbol *symbol;
 	int more;
@@ -238,6 +239,8 @@ static void perf_top__show_details(struct perf_top *top)
 
 	pthread_mutex_lock(&notes->lock);
 
+	symbol__calc_percent(symbol, evsel);
+
 	if (notes->src == NULL)
 		goto out_unlock;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 96cf6767b5ce..209a25545542 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1145,41 +1145,19 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 	static const char *prev_color;
 
 	if (dl->al.offset != -1) {
-		const char *path = NULL;
-		double percent, max_percent = 0.0;
-		double *ppercents = &percent;
-		struct sym_hist_entry sample;
-		struct sym_hist_entry *psamples = &sample;
+		double max_percent = 0.0;
 		int i, nr_percent = 1;
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
 		s64 offset = dl->al.offset;
 		const u64 addr = start + offset;
-		struct annotation_line *next;
 		struct block_range *br;
 
-		next = annotation_line__next(&dl->al, &notes->src->source);
+		for (i = 0; i < dl->al.samples_nr; i++) {
+			struct annotation_data *sample = &dl->al.samples[i];
 
-		if (perf_evsel__is_group_event(evsel)) {
-			nr_percent = evsel->nr_members;
-			ppercents = calloc(nr_percent, sizeof(double));
-			psamples = calloc(nr_percent, sizeof(struct sym_hist_entry));
-			if (ppercents == NULL || psamples == NULL) {
-				return -1;
-			}
-		}
-
-		for (i = 0; i < nr_percent; i++) {
-			percent = disasm__calc_percent(notes,
-					notes->src->lines ? i : evsel->idx + i,
-					offset,
-					next ? next->offset : (s64) len,
-					&path, &sample);
-
-			ppercents[i] = percent;
-			psamples[i] = sample;
-			if (percent > max_percent)
-				max_percent = percent;
+			if (sample->percent > max_percent)
+				max_percent = sample->percent;
 		}
 
 		if (max_percent < min_pcnt)
@@ -1204,28 +1182,28 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		 * the same color than the percentage. Don't print it
 		 * twice for close colored addr with the same filename:line
 		 */
-		if (path) {
-			if (!prev_line || strcmp(prev_line, path)
+		if (dl->al.path) {
+			if (!prev_line || strcmp(prev_line, dl->al.path)
 				       || color != prev_color) {
-				color_fprintf(stdout, color, " %s", path);
-				prev_line = path;
+				color_fprintf(stdout, color, " %s", dl->al.path);
+				prev_line = dl->al.path;
 				prev_color = color;
 			}
 		}
 
 		for (i = 0; i < nr_percent; i++) {
-			percent = ppercents[i];
-			sample = psamples[i];
-			color = get_percent_color(percent);
+			struct annotation_data *sample = &dl->al.samples[i];
+
+			color = get_percent_color(sample->percent);
 
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %11" PRIu64,
-					      sample.period);
+					      sample->he.period);
 			else if (symbol_conf.show_nr_samples)
 				color_fprintf(stdout, color, " %7" PRIu64,
-					      sample.nr_samples);
+					      sample->he.nr_samples);
 			else
-				color_fprintf(stdout, color, " %7.2f", percent);
+				color_fprintf(stdout, color, " %7.2f", sample->percent);
 		}
 
 		printf(" :	");
@@ -1235,13 +1213,6 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		color_fprintf(stdout, annotate__asm_color(br), "%s", dl->al.line);
 		annotate__branch_printf(br, addr);
 		printf("\n");
-
-		if (ppercents != &percent)
-			free(ppercents);
-
-		if (psamples != &sample)
-			free(psamples);
-
 	} else if (max_lines && printed >= max_lines)
 		return 1;
 	else {
-- 
2.13.6
