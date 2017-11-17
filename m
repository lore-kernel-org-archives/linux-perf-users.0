From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/83] perf annotate: Add symbol__calc_lines function
Date: Fri, 17 Nov 2017 17:14:57 -0300
Message-ID: <20171117201601.24110-20-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161382AbdKQURV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:21 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Replace symbol__get_source_line() with symbol__calc_lines(), which
calculates the source line tree over the struct annotation_line.

This will allow us to remove redundant struct source_line in following
patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 186 ++++++++++++++++-----------------------------
 tools/perf/util/annotate.h |   2 +
 2 files changed, 68 insertions(+), 120 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ff1036096347..96cf6767b5ce 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -892,6 +892,7 @@ static void annotation_line__delete(struct annotation_line *al)
 {
 	void *ptr = (void *) al - al->privsize;
 
+	free_srcline(al->path);
 	zfree(&al->line);
 	free(ptr);
 }
@@ -1726,21 +1727,21 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	return symbol__calc_percent(sym, evsel);
 }
 
-static void insert_source_line(struct rb_root *root, struct source_line *src_line)
+static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 {
-	struct source_line *iter;
+	struct annotation_line *iter;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 	int i, ret;
 
 	while (*p != NULL) {
 		parent = *p;
-		iter = rb_entry(parent, struct source_line, node);
+		iter = rb_entry(parent, struct annotation_line, rb_node);
 
-		ret = strcmp(iter->path, src_line->path);
+		ret = strcmp(iter->path, al->path);
 		if (ret == 0) {
-			for (i = 0; i < src_line->nr_pcnt; i++)
-				iter->samples[i].percent_sum += src_line->samples[i].percent;
+			for (i = 0; i < al->samples_nr; i++)
+				iter->samples[i].percent_sum += al->samples[i].percent;
 			return;
 		}
 
@@ -1750,18 +1751,18 @@ static void insert_source_line(struct rb_root *root, struct source_line *src_lin
 			p = &(*p)->rb_right;
 	}
 
-	for (i = 0; i < src_line->nr_pcnt; i++)
-		src_line->samples[i].percent_sum = src_line->samples[i].percent;
+	for (i = 0; i < al->samples_nr; i++)
+		al->samples[i].percent_sum = al->samples[i].percent;
 
-	rb_link_node(&src_line->node, parent, p);
-	rb_insert_color(&src_line->node, root);
+	rb_link_node(&al->rb_node, parent, p);
+	rb_insert_color(&al->rb_node, root);
 }
 
-static int cmp_source_line(struct source_line *a, struct source_line *b)
+static int cmp_source_line(struct annotation_line *a, struct annotation_line *b)
 {
 	int i;
 
-	for (i = 0; i < a->nr_pcnt; i++) {
+	for (i = 0; i < a->samples_nr; i++) {
 		if (a->samples[i].percent_sum == b->samples[i].percent_sum)
 			continue;
 		return a->samples[i].percent_sum > b->samples[i].percent_sum;
@@ -1770,135 +1771,47 @@ static int cmp_source_line(struct source_line *a, struct source_line *b)
 	return 0;
 }
 
-static void __resort_source_line(struct rb_root *root, struct source_line *src_line)
+static void __resort_source_line(struct rb_root *root, struct annotation_line *al)
 {
-	struct source_line *iter;
+	struct annotation_line *iter;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 
 	while (*p != NULL) {
 		parent = *p;
-		iter = rb_entry(parent, struct source_line, node);
+		iter = rb_entry(parent, struct annotation_line, rb_node);
 
-		if (cmp_source_line(src_line, iter))
+		if (cmp_source_line(al, iter))
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
 	}
 
-	rb_link_node(&src_line->node, parent, p);
-	rb_insert_color(&src_line->node, root);
+	rb_link_node(&al->rb_node, parent, p);
+	rb_insert_color(&al->rb_node, root);
 }
 
 static void resort_source_line(struct rb_root *dest_root, struct rb_root *src_root)
 {
-	struct source_line *src_line;
+	struct annotation_line *al;
 	struct rb_node *node;
 
 	node = rb_first(src_root);
 	while (node) {
 		struct rb_node *next;
 
-		src_line = rb_entry(node, struct source_line, node);
+		al = rb_entry(node, struct annotation_line, rb_node);
 		next = rb_next(node);
 		rb_erase(node, src_root);
 
-		__resort_source_line(dest_root, src_line);
+		__resort_source_line(dest_root, al);
 		node = next;
 	}
 }
 
-static void symbol__free_source_line(struct symbol *sym, int len)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct source_line *src_line = notes->src->lines;
-	size_t sizeof_src_line;
-	int i;
-
-	sizeof_src_line = sizeof(*src_line) +
-			  (sizeof(src_line->samples) * (src_line->nr_pcnt - 1));
-
-	for (i = 0; i < len; i++) {
-		free_srcline(src_line->path);
-		src_line = (void *)src_line + sizeof_src_line;
-	}
-
-	zfree(&notes->src->lines);
-}
-
-/* Get the filename:line for the colored entries */
-static int symbol__get_source_line(struct symbol *sym, struct map *map,
-				   struct perf_evsel *evsel,
-				   struct rb_root *root, int len)
-{
-	u64 start;
-	int i, k;
-	int evidx = evsel->idx;
-	struct source_line *src_line;
-	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evidx);
-	struct rb_root tmp_root = RB_ROOT;
-	int nr_pcnt = 1;
-	u64 nr_samples = h->nr_samples;
-	size_t sizeof_src_line = sizeof(struct source_line);
-
-	if (perf_evsel__is_group_event(evsel)) {
-		for (i = 1; i < evsel->nr_members; i++) {
-			h = annotation__histogram(notes, evidx + i);
-			nr_samples += h->nr_samples;
-		}
-		nr_pcnt = evsel->nr_members;
-		sizeof_src_line += (nr_pcnt - 1) * sizeof(src_line->samples);
-	}
-
-	if (!nr_samples)
-		return 0;
-
-	src_line = notes->src->lines = calloc(len, sizeof_src_line);
-	if (!notes->src->lines)
-		return -1;
-
-	start = map__rip_2objdump(map, sym->start);
-
-	for (i = 0; i < len; i++) {
-		u64 offset;
-		double percent_max = 0.0;
-
-		src_line->nr_pcnt = nr_pcnt;
-
-		for (k = 0; k < nr_pcnt; k++) {
-			double percent = 0.0;
-
-			h = annotation__histogram(notes, evidx + k);
-			nr_samples = h->addr[i].nr_samples;
-			if (h->nr_samples)
-				percent = 100.0 * nr_samples / h->nr_samples;
-
-			if (percent > percent_max)
-				percent_max = percent;
-			src_line->samples[k].percent = percent;
-			src_line->samples[k].nr = nr_samples;
-		}
-
-		if (percent_max <= 0.5)
-			goto next;
-
-		offset = start + i;
-		src_line->path = get_srcline(map->dso, offset, NULL,
-					     false, true);
-		insert_source_line(&tmp_root, src_line);
-
-	next:
-		src_line = (void *)src_line + sizeof_src_line;
-	}
-
-	resort_source_line(root, &tmp_root);
-	return 0;
-}
-
 static void print_summary(struct rb_root *root, const char *filename)
 {
-	struct source_line *src_line;
+	struct annotation_line *al;
 	struct rb_node *node;
 
 	printf("\nSorted summary for file %s\n", filename);
@@ -1916,9 +1829,9 @@ static void print_summary(struct rb_root *root, const char *filename)
 		char *path;
 		int i;
 
-		src_line = rb_entry(node, struct source_line, node);
-		for (i = 0; i < src_line->nr_pcnt; i++) {
-			percent = src_line->samples[i].percent_sum;
+		al = rb_entry(node, struct annotation_line, rb_node);
+		for (i = 0; i < al->samples_nr; i++) {
+			percent = al->samples[i].percent_sum;
 			color = get_percent_color(percent);
 			color_fprintf(stdout, color, " %7.2f", percent);
 
@@ -1926,7 +1839,7 @@ static void print_summary(struct rb_root *root, const char *filename)
 				percent_max = percent;
 		}
 
-		path = src_line->path;
+		path = al->path;
 		color = get_percent_color(percent_max);
 		color_fprintf(stdout, color, " %s\n", path);
 
@@ -2091,29 +2004,62 @@ size_t disasm__fprintf(struct list_head *head, FILE *fp)
 	return printed;
 }
 
+static void annotation__calc_lines(struct annotation *notes, struct map *map,
+				  struct rb_root *root, u64 start)
+{
+	struct annotation_line *al;
+	struct rb_root tmp_root = RB_ROOT;
+
+	list_for_each_entry(al, &notes->src->source, node) {
+		double percent_max = 0.0;
+		int i;
+
+		for (i = 0; i < al->samples_nr; i++) {
+			struct annotation_data *sample;
+
+			sample = &al->samples[i];
+
+			if (sample->percent > percent_max)
+				percent_max = sample->percent;
+		}
+
+		if (percent_max <= 0.5)
+			continue;
+
+		al->path = get_srcline(map->dso, start + al->offset, NULL, false, true);
+		insert_source_line(&tmp_root, al);
+	}
+
+	resort_source_line(root, &tmp_root);
+}
+
+static void symbol__calc_lines(struct symbol *sym, struct map *map,
+			      struct rb_root *root)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	u64 start = map__rip_2objdump(map, sym->start);
+
+	annotation__calc_lines(notes, map, root, start);
+}
+
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel, bool print_lines,
 			 bool full_paths, int min_pcnt, int max_lines)
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	u64 len;
 
 	if (symbol__annotate(sym, map, evsel, 0, NULL, NULL) < 0)
 		return -1;
 
-	len = symbol__size(sym);
-
 	if (print_lines) {
 		srcline_full_filename = full_paths;
-		symbol__get_source_line(sym, map, evsel, &source_line, len);
+		symbol__calc_lines(sym, map, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
 
 	symbol__annotate_printf(sym, map, evsel, full_paths,
 				min_pcnt, max_lines, 0);
-	if (print_lines)
-		symbol__free_source_line(sym, len);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6056840da4c9..927810b19f0d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -66,6 +66,7 @@ struct sym_hist_entry {
 
 struct annotation_data {
 	double			 percent;
+	double			 percent_sum;
 	struct sym_hist_entry	 he;
 };
 
@@ -78,6 +79,7 @@ struct annotation_line {
 	float			 ipc;
 	u64			 cycles;
 	size_t			 privsize;
+	char			*path;
 	int			 samples_nr;
 	struct annotation_data	 samples[0];
 };
-- 
2.13.6
