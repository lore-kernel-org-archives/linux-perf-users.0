From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/83] perf annotate: Add annotation_line struct
Date: Fri, 17 Nov 2017 17:14:41 -0300
Message-ID: <20171117201601.24110-4-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdKQUQa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:30 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

In order to make the annotation support generic, addadding 'struct
annotation_line', which will hold generic data common to annotation
sources (such as the one for python scripts, coming on upcoming
patches).

Having this, we can add different annotation line support other than
objdump disasm.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 34 +++++++++++++++++-----------------
 tools/perf/ui/gtk/annotate.c      |  6 +++---
 tools/perf/util/annotate.c        | 20 ++++++++++----------
 tools/perf/util/annotate.h        | 20 ++++++++++++--------
 4 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8f7f59d1a2b5..a8c2f7405a41 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -84,7 +84,7 @@ static bool disasm_line__filter(struct ui_browser *browser __maybe_unused,
 				void *entry)
 {
 	if (annotate_browser__opts.hide_src_code) {
-		struct disasm_line *dl = list_entry(entry, struct disasm_line, node);
+		struct disasm_line *dl = list_entry(entry, struct disasm_line, al.node);
 		return dl->offset == -1;
 	}
 
@@ -123,7 +123,7 @@ static int annotate_browser__cycles_width(struct annotate_browser *ab)
 static void annotate_browser__write(struct ui_browser *browser, void *entry, int row)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
-	struct disasm_line *dl = list_entry(entry, struct disasm_line, node);
+	struct disasm_line *dl = list_entry(entry, struct disasm_line, al.node);
 	struct browser_disasm_line *bdl = disasm_line__browser(dl);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	bool change_color = (!annotate_browser__opts.hide_src_code &&
@@ -286,7 +286,7 @@ static bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sy
 
 static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
 {
-	struct disasm_line *pos = list_prev_entry(cursor, node);
+	struct disasm_line *pos = list_prev_entry(cursor, al.node);
 	const char *name;
 
 	if (!pos)
@@ -404,16 +404,16 @@ static void annotate_browser__set_top(struct annotate_browser *browser,
 	browser->b.top_idx = browser->b.index = idx;
 
 	while (browser->b.top_idx != 0 && back != 0) {
-		pos = list_entry(pos->node.prev, struct disasm_line, node);
+		pos = list_entry(pos->al.node.prev, struct disasm_line, al.node);
 
-		if (disasm_line__filter(&browser->b, &pos->node))
+		if (disasm_line__filter(&browser->b, &pos->al.node))
 			continue;
 
 		--browser->b.top_idx;
 		--back;
 	}
 
-	browser->b.top = pos;
+	browser->b.top = &pos->al;
 	browser->b.navkeypressed = true;
 }
 
@@ -446,7 +446,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 	pthread_mutex_lock(&notes->lock);
 
-	list_for_each_entry(pos, &notes->src->source, node) {
+	list_for_each_entry(pos, &notes->src->source, al.node) {
 		struct browser_disasm_line *bpos = disasm_line__browser(pos);
 		const char *path = NULL;
 		double max_percent = 0.0;
@@ -492,7 +492,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 	off_t offset = browser->b.index - browser->b.top_idx;
 
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
-	dl = list_entry(browser->b.top, struct disasm_line, node);
+	dl = list_entry(browser->b.top, struct disasm_line, al.node);
 	bdl = disasm_line__browser(dl);
 
 	if (annotate_browser__opts.hide_src_code) {
@@ -589,10 +589,10 @@ struct disasm_line *annotate_browser__find_offset(struct annotate_browser *brows
 	struct disasm_line *pos;
 
 	*idx = 0;
-	list_for_each_entry(pos, &notes->src->source, node) {
+	list_for_each_entry(pos, &notes->src->source, al.node) {
 		if (pos->offset == offset)
 			return pos;
-		if (!disasm_line__filter(&browser->b, &pos->node))
+		if (!disasm_line__filter(&browser->b, &pos->al.node))
 			++*idx;
 	}
 
@@ -630,8 +630,8 @@ struct disasm_line *annotate_browser__find_string(struct annotate_browser *brows
 	struct disasm_line *pos = browser->selection;
 
 	*idx = browser->b.index;
-	list_for_each_entry_continue(pos, &notes->src->source, node) {
-		if (disasm_line__filter(&browser->b, &pos->node))
+	list_for_each_entry_continue(pos, &notes->src->source, al.node) {
+		if (disasm_line__filter(&browser->b, &pos->al.node))
 			continue;
 
 		++*idx;
@@ -669,8 +669,8 @@ struct disasm_line *annotate_browser__find_string_reverse(struct annotate_browse
 	struct disasm_line *pos = browser->selection;
 
 	*idx = browser->b.index;
-	list_for_each_entry_continue_reverse(pos, &notes->src->source, node) {
-		if (disasm_line__filter(&browser->b, &pos->node))
+	list_for_each_entry_continue_reverse(pos, &notes->src->source, al.node) {
+		if (disasm_line__filter(&browser->b, &pos->al.node))
 			continue;
 
 		--*idx;
@@ -1134,7 +1134,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	notes = symbol__annotation(sym);
 	browser.start = map__rip_2objdump(map, sym->start);
 
-	list_for_each_entry(pos, &notes->src->source, node) {
+	list_for_each_entry(pos, &notes->src->source, al.node) {
 		struct browser_disasm_line *bpos;
 		size_t line_len = strlen(pos->line);
 
@@ -1174,8 +1174,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	annotate_browser__update_addr_width(&browser);
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
-	list_for_each_entry_safe(pos, n, &notes->src->source, node) {
-		list_del(&pos->node);
+	list_for_each_entry_safe(pos, n, &notes->src->source, al.node) {
+		list_del(&pos->al.node);
 		disasm_line__free(pos);
 	}
 
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index fc7a2e105bfd..cf8092676c7a 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -119,7 +119,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
 	gtk_tree_view_set_model(GTK_TREE_VIEW(view), GTK_TREE_MODEL(store));
 	g_object_unref(GTK_TREE_MODEL(store));
 
-	list_for_each_entry(pos, &notes->src->source, node) {
+	list_for_each_entry(pos, &notes->src->source, al.node) {
 		GtkTreeIter iter;
 		int ret = 0;
 
@@ -148,8 +148,8 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct symbol *sym,
 
 	gtk_container_add(GTK_CONTAINER(window), view);
 
-	list_for_each_entry_safe(pos, n, &notes->src->source, node) {
-		list_del(&pos->node);
+	list_for_each_entry_safe(pos, n, &notes->src->source, al.node) {
+		list_del(&pos->al.node);
 		disasm_line__free(pos);
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index da1c4c4a0dd8..004e33dc897c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -931,12 +931,12 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 
 static void disasm__add(struct list_head *head, struct disasm_line *line)
 {
-	list_add_tail(&line->node, head);
+	list_add_tail(&line->al.node, head);
 }
 
 struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disasm_line *pos)
 {
-	list_for_each_entry_continue(pos, head, node)
+	list_for_each_entry_continue(pos, head, al.node)
 		if (pos->offset >= 0)
 			return pos;
 
@@ -1122,7 +1122,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 			return 1;
 
 		if (queue != NULL) {
-			list_for_each_entry_from(queue, &notes->src->source, node) {
+			list_for_each_entry_from(queue, &notes->src->source, al.node) {
 				if (queue == dl)
 					break;
 				disasm_line__print(queue, sym, start, evsel, len,
@@ -1305,7 +1305,7 @@ static void delete_last_nop(struct symbol *sym)
 	struct disasm_line *dl;
 
 	while (!list_empty(list)) {
-		dl = list_entry(list->prev, struct disasm_line, node);
+		dl = list_entry(list->prev, struct disasm_line, al.node);
 
 		if (dl->ins.ops) {
 			if (dl->ins.ops != &nop_ops)
@@ -1317,7 +1317,7 @@ static void delete_last_nop(struct symbol *sym)
 				return;
 		}
 
-		list_del(&dl->node);
+		list_del(&dl->al.node);
 		disasm_line__free(dl);
 	}
 }
@@ -1844,7 +1844,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	if (verbose > 0)
 		symbol__annotate_hits(sym, evsel);
 
-	list_for_each_entry(pos, &notes->src->source, node) {
+	list_for_each_entry(pos, &notes->src->source, al.node) {
 		if (context && queue == NULL) {
 			queue = pos;
 			queue_len = 0;
@@ -1874,7 +1874,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			if (!context)
 				break;
 			if (queue_len == context)
-				queue = list_entry(queue->node.next, typeof(*queue), node);
+				queue = list_entry(queue->al.node.next, typeof(*queue), al.node);
 			else
 				++queue_len;
 			break;
@@ -1911,8 +1911,8 @@ void disasm__purge(struct list_head *head)
 {
 	struct disasm_line *pos, *n;
 
-	list_for_each_entry_safe(pos, n, head, node) {
-		list_del(&pos->node);
+	list_for_each_entry_safe(pos, n, head, al.node) {
+		list_del(&pos->al.node);
 		disasm_line__free(pos);
 	}
 }
@@ -1939,7 +1939,7 @@ size_t disasm__fprintf(struct list_head *head, FILE *fp)
 	struct disasm_line *pos;
 	size_t printed = 0;
 
-	list_for_each_entry(pos, head, node)
+	list_for_each_entry(pos, head, al.node)
 		printed += disasm_line__fprintf(pos, fp);
 
 	return printed;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index f6ba3560de5e..cc3cf6b50d55 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -59,15 +59,19 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
 struct annotation;
 
+struct annotation_line {
+	struct list_head	 node;
+};
+
 struct disasm_line {
-	struct list_head    node;
-	s64		    offset;
-	char		    *line;
-	struct ins	    ins;
-	int		    line_nr;
-	float		    ipc;
-	u64		    cycles;
-	struct ins_operands ops;
+	struct annotation_line	 al;
+	s64			 offset;
+	char			*line;
+	struct ins		 ins;
+	int			 line_nr;
+	float			 ipc;
+	u64			 cycles;
+	struct ins_operands	 ops;
 };
 
 static inline bool disasm_line__has_offset(const struct disasm_line *dl)
-- 
2.13.6
