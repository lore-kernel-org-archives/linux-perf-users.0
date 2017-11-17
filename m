From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/83] perf annotate browser: Change offsets to struct annotation_line
Date: Fri, 17 Nov 2017 17:15:09 -0300
Message-ID: <20171117201601.24110-32-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use struct annotation_line as a browser::offsets array entry.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-31-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 49 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 657811669a6c..911f06ce0f1b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -51,7 +51,7 @@ struct annotate_browser {
 	struct rb_root		    entries;
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
-	struct disasm_line	  **offsets;
+	struct annotation_line	  **offsets;
 	struct arch		   *arch;
 	int			    nr_events;
 	u64			    start;
@@ -303,6 +303,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct disasm_line *cursor = disasm_line(ab->selection);
 	struct disasm_line *target;
+	struct annotation_line *al;
 	struct browser_line *btarget, *bcursor;
 	unsigned int from, to;
 	struct map_symbol *ms = ab->b.priv;
@@ -316,10 +317,12 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	if (!disasm_line__is_valid_jump(cursor, sym))
 		return;
 
-	target = ab->offsets[cursor->ops.target.offset];
-	if (!target)
+	al = ab->offsets[cursor->ops.target.offset];
+	if (!al)
 		return;
 
+	target = disasm_line(al);
+
 	bcursor = browser_line(cursor);
 	btarget = browser_line(target);
 
@@ -978,10 +981,10 @@ static void count_and_fill(struct annotate_browser *browser, u64 start, u64 end,
 			return;
 
 		for (offset = start; offset <= end; offset++) {
-			struct disasm_line *dl = browser->offsets[offset];
+			struct annotation_line *al = browser->offsets[offset];
 
-			if (dl)
-				dl->al.ipc = ipc;
+			if (al)
+				al->ipc = ipc;
 		}
 	}
 }
@@ -1006,13 +1009,13 @@ static void annotate__compute_ipc(struct annotate_browser *browser, size_t size,
 
 		ch = &notes->src->cycles_hist[offset];
 		if (ch && ch->cycles) {
-			struct disasm_line *dl;
+			struct annotation_line *al;
 
 			if (ch->have_start)
 				count_and_fill(browser, ch->start, offset, ch);
-			dl = browser->offsets[offset];
-			if (dl && ch->num_aggr)
-				dl->al.cycles = ch->cycles_aggr / ch->num_aggr;
+			al = browser->offsets[offset];
+			if (al && ch->num_aggr)
+				al->cycles = ch->cycles_aggr / ch->num_aggr;
 			browser->have_cycles = true;
 		}
 	}
@@ -1031,13 +1034,18 @@ static void annotate_browser__mark_jump_targets(struct annotate_browser *browser
 		return;
 
 	for (offset = 0; offset < size; ++offset) {
-		struct disasm_line *dl = browser->offsets[offset], *dlt;
+		struct annotation_line *al = browser->offsets[offset];
+		struct disasm_line *dl, *dlt;
 		struct browser_line *bdlt;
 
+		dl = disasm_line(al);
+
 		if (!disasm_line__is_valid_jump(dl, sym))
 			continue;
 
-		dlt = browser->offsets[dl->ops.target.offset];
+		al = browser->offsets[dl->ops.target.offset];
+		dlt = disasm_line(al);
+
 		/*
  		 * FIXME: Oops, no jump target? Buggy disassembler? Or do we
  		 * have to adjust to the previous offset?
@@ -1066,7 +1074,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
 			 struct hist_browser_timer *hbt)
 {
-	struct disasm_line *pos;
+	struct annotation_line *al;
 	struct annotation *notes;
 	size_t size;
 	struct map_symbol ms = {
@@ -1094,7 +1102,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	browser.offsets = zalloc(size * sizeof(struct disasm_line *));
+	browser.offsets = zalloc(size * sizeof(struct annotation_line *));
 	if (browser.offsets == NULL) {
 		ui__error("Not enough memory!");
 		return -1;
@@ -1118,15 +1126,16 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	notes = symbol__annotation(sym);
 	browser.start = map__rip_2objdump(map, sym->start);
 
-	list_for_each_entry(pos, &notes->src->source, al.node) {
+	list_for_each_entry(al, &notes->src->source, node) {
+		struct disasm_line *dl = disasm_line(al);
 		struct browser_line *bpos;
-		size_t line_len = strlen(pos->al.line);
+		size_t line_len = strlen(al->line);
 
 		if (browser.b.width < line_len)
 			browser.b.width = line_len;
-		bpos = browser_line(pos);
+		bpos = browser_line(dl);
 		bpos->idx = browser.nr_entries++;
-		if (pos->al.offset != -1) {
+		if (al->offset != -1) {
 			bpos->idx_asm = browser.nr_asm_entries++;
 			/*
 			 * FIXME: short term bandaid to cope with assembly
@@ -1135,8 +1144,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 *
 			 * E.g. copy_user_generic_unrolled
  			 */
-			if (pos->al.offset < (s64)size)
-				browser.offsets[pos->al.offset] = pos;
+			if (al->offset < (s64)size)
+				browser.offsets[al->offset] = al;
 		} else
 			bpos->idx_asm = -1;
 	}
-- 
2.13.6
