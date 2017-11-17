From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/83] perf annotate browser: Use samples data from struct annotation_line
Date: Fri, 17 Nov 2017 17:15:04 -0300
Message-ID: <20171117201601.24110-27-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We now carry the data in 'struct annotation_line', so using it instead
of samples from 'struct browser_disasm_line' and removing it and its
setup.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 57 ++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 37 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 613682432940..5d99429a03bc 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -29,11 +29,6 @@ struct browser_disasm_line {
 	u32				idx;
 	int				idx_asm;
 	int				jump_sources;
-	/*
-	 * actual length of this array is saved on the nr_events field
-	 * of the struct annotate_browser
-	 */
-	struct disasm_line_samples	samples[1];
 };
 
 static struct annotate_browser_opt {
@@ -76,9 +71,7 @@ struct annotate_browser {
 
 static inline struct browser_disasm_line *disasm_line__browser(struct disasm_line *dl)
 {
-	struct annotation_line *al = &dl->al;
-
-	return (void *) al - al->privsize;
+	return (void *) dl - sizeof(struct browser_disasm_line);
 }
 
 static bool disasm_line__filter(struct ui_browser *browser __maybe_unused,
@@ -139,8 +132,8 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	bool show_title = false;
 
 	for (i = 0; i < ab->nr_events; i++) {
-		if (bdl->samples[i].percent > percent_max)
-			percent_max = bdl->samples[i].percent;
+		if (dl->al.samples[i].percent > percent_max)
+			percent_max = dl->al.samples[i].percent;
 	}
 
 	if ((row == 0) && (dl->al.offset == -1 || percent_max == 0.0)) {
@@ -154,17 +147,17 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (dl->al.offset != -1 && percent_max != 0.0) {
 		for (i = 0; i < ab->nr_events; i++) {
 			ui_browser__set_percent_color(browser,
-						bdl->samples[i].percent,
+						dl->al.samples[i].percent,
 						current_entry);
 			if (annotate_browser__opts.show_total_period) {
 				ui_browser__printf(browser, "%11" PRIu64 " ",
-						   bdl->samples[i].he.period);
+						   dl->al.samples[i].he.period);
 			} else if (annotate_browser__opts.show_nr_samples) {
 				ui_browser__printf(browser, "%6" PRIu64 " ",
-						   bdl->samples[i].he.nr_samples);
+						   dl->al.samples[i].he.nr_samples);
 			} else {
 				ui_browser__printf(browser, "%6.2f ",
-						   bdl->samples[i].percent);
+						   dl->al.samples[i].percent);
 			}
 		}
 	} else {
@@ -363,11 +356,9 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 	return ret;
 }
 
-static int disasm__cmp(struct disasm_line *da,
-		       struct disasm_line *db, int nr_pcnt)
+static int disasm__cmp(struct annotation_line *a,
+		       struct annotation_line *b, int nr_pcnt)
 {
-	struct browser_disasm_line *a = disasm_line__browser(da);
-	struct browser_disasm_line *b = disasm_line__browser(db);
 	int i;
 
 	for (i = 0; i < nr_pcnt; i++) {
@@ -378,24 +369,24 @@ static int disasm__cmp(struct disasm_line *da,
 	return 0;
 }
 
-static void disasm_rb_tree__insert(struct rb_root *root, struct disasm_line *dl,
+static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line *al,
 				   int nr_events)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
-	struct disasm_line *l;
+	struct annotation_line *l;
 
 	while (*p != NULL) {
 		parent = *p;
-		l = rb_entry(parent, struct disasm_line, al.rb_node);
+		l = rb_entry(parent, struct annotation_line, rb_node);
 
-		if (disasm__cmp(dl, l, nr_events))
+		if (disasm__cmp(al, l, nr_events))
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
 	}
-	rb_link_node(&dl->al.rb_node, parent, p);
-	rb_insert_color(&dl->al.rb_node, root);
+	rb_link_node(&al->rb_node, parent, p);
+	rb_insert_color(&al->rb_node, root);
 }
 
 static void annotate_browser__set_top(struct annotate_browser *browser,
@@ -453,7 +444,6 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 	symbol__calc_percent(sym, evsel);
 
 	list_for_each_entry(pos, &notes->src->source, al.node) {
-		struct browser_disasm_line *bpos = disasm_line__browser(pos);
 		double max_percent = 0.0;
 		int i;
 
@@ -465,18 +455,15 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		for (i = 0; i < browser->nr_events; i++) {
 			struct annotation_data *sample = &pos->al.samples[i];
 
-			bpos->samples[i].percent = sample->percent;
-			bpos->samples[i].he      = sample->he;
-
-			if (max_percent < bpos->samples[i].percent)
-				max_percent = bpos->samples[i].percent;
+			if (max_percent < sample->percent)
+				max_percent = sample->percent;
 		}
 
 		if (max_percent < 0.01 && pos->al.ipc == 0) {
 			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
-		disasm_rb_tree__insert(&browser->entries, pos,
+		disasm_rb_tree__insert(&browser->entries, &pos->al,
 				       browser->nr_events);
 	}
 	pthread_mutex_unlock(&notes->lock);
@@ -1096,7 +1083,6 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	};
 	int ret = -1, err;
 	int nr_pcnt = 1;
-	size_t sizeof_bdl = sizeof(struct browser_disasm_line);
 
 	if (sym == NULL)
 		return -1;
@@ -1112,14 +1098,11 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		return -1;
 	}
 
-	if (perf_evsel__is_group_event(evsel)) {
+	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
-		sizeof_bdl += sizeof(struct disasm_line_samples) *
-		  (nr_pcnt - 1);
-	}
 
 	err = symbol__annotate(sym, map, evsel,
-			       sizeof_bdl, &browser.arch,
+			       sizeof(struct browser_disasm_line), &browser.arch,
 			       perf_evsel__env_cpuid(evsel));
 	if (err) {
 		char msg[BUFSIZ];
-- 
2.13.6
