From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/83] perf annotate browser: Use struct annotation_line in browser_line
Date: Fri, 17 Nov 2017 17:15:10 -0300
Message-ID: <20171117201601.24110-33-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Using struct annotation_line arg in browser_line
function to make it generic.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-32-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 60 ++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 911f06ce0f1b..fb83deb8c909 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -69,9 +69,12 @@ struct annotate_browser {
 	char			    search_bf[128];
 };
 
-static inline struct browser_line *browser_line(struct disasm_line *dl)
+static inline struct browser_line *browser_line(struct annotation_line *al)
 {
-	return (void *) dl - sizeof(struct browser_line);
+	void *ptr = al;
+
+	ptr = container_of(al, struct disasm_line, al);
+	return ptr - sizeof(struct browser_line);
 }
 
 static bool disasm_line__filter(struct ui_browser *browser __maybe_unused,
@@ -119,7 +122,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct disasm_line *dl = list_entry(entry, struct disasm_line, al.node);
-	struct browser_line *bdl = browser_line(dl);
+	struct browser_line *bdl = browser_line(&dl->al);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	bool change_color = (!annotate_browser__opts.hide_src_code &&
 			     (!current_entry || (browser->use_navkeypressed &&
@@ -302,8 +305,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct disasm_line *cursor = disasm_line(ab->selection);
-	struct disasm_line *target;
-	struct annotation_line *al;
+	struct annotation_line *target;
 	struct browser_line *btarget, *bcursor;
 	unsigned int from, to;
 	struct map_symbol *ms = ab->b.priv;
@@ -317,13 +319,9 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	if (!disasm_line__is_valid_jump(cursor, sym))
 		return;
 
-	al = ab->offsets[cursor->ops.target.offset];
-	if (!al)
-		return;
-
-	target = disasm_line(al);
+	target = ab->offsets[cursor->ops.target.offset];
 
-	bcursor = browser_line(cursor);
+	bcursor = browser_line(&cursor->al);
 	btarget = browser_line(target);
 
 	if (annotate_browser__opts.hide_src_code) {
@@ -422,7 +420,7 @@ static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 	u32 idx;
 
 	pos = rb_entry(nd, struct disasm_line, al.rb_node);
-	bpos = browser_line(pos);
+	bpos = browser_line(&pos->al);
 
 	idx = bpos->idx;
 	if (annotate_browser__opts.hide_src_code)
@@ -475,37 +473,37 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
 	struct disasm_line *dl;
-	struct browser_line *bdl;
+	struct browser_line *bl;
 	off_t offset = browser->b.index - browser->b.top_idx;
 
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
 	dl = list_entry(browser->b.top, struct disasm_line, al.node);
-	bdl = browser_line(dl);
+	bl = browser_line(&dl->al);
 
 	if (annotate_browser__opts.hide_src_code) {
-		if (bdl->idx_asm < offset)
-			offset = bdl->idx;
+		if (bl->idx_asm < offset)
+			offset = bl->idx;
 
 		browser->b.nr_entries = browser->nr_entries;
 		annotate_browser__opts.hide_src_code = false;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
-		browser->b.top_idx = bdl->idx - offset;
-		browser->b.index = bdl->idx;
+		browser->b.top_idx = bl->idx - offset;
+		browser->b.index = bl->idx;
 	} else {
-		if (bdl->idx_asm < 0) {
+		if (bl->idx_asm < 0) {
 			ui_helpline__puts("Only available for assembly lines.");
 			browser->b.seek(&browser->b, -offset, SEEK_CUR);
 			return false;
 		}
 
-		if (bdl->idx_asm < offset)
-			offset = bdl->idx_asm;
+		if (bl->idx_asm < offset)
+			offset = bl->idx_asm;
 
 		browser->b.nr_entries = browser->nr_asm_entries;
 		annotate_browser__opts.hide_src_code = true;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
-		browser->b.top_idx = bdl->idx_asm - offset;
-		browser->b.index = bdl->idx_asm;
+		browser->b.top_idx = bl->idx_asm - offset;
+		browser->b.index = bl->idx_asm;
 	}
 
 	return true;
@@ -1035,8 +1033,8 @@ static void annotate_browser__mark_jump_targets(struct annotate_browser *browser
 
 	for (offset = 0; offset < size; ++offset) {
 		struct annotation_line *al = browser->offsets[offset];
-		struct disasm_line *dl, *dlt;
-		struct browser_line *bdlt;
+		struct disasm_line *dl;
+		struct browser_line *blt;
 
 		dl = disasm_line(al);
 
@@ -1044,18 +1042,17 @@ static void annotate_browser__mark_jump_targets(struct annotate_browser *browser
 			continue;
 
 		al = browser->offsets[dl->ops.target.offset];
-		dlt = disasm_line(al);
 
 		/*
  		 * FIXME: Oops, no jump target? Buggy disassembler? Or do we
  		 * have to adjust to the previous offset?
  		 */
-		if (dlt == NULL)
+		if (al == NULL)
 			continue;
 
-		bdlt = browser_line(dlt);
-		if (++bdlt->jump_sources > browser->max_jump_sources)
-			browser->max_jump_sources = bdlt->jump_sources;
+		blt = browser_line(al);
+		if (++blt->jump_sources > browser->max_jump_sources)
+			browser->max_jump_sources = blt->jump_sources;
 
 		++browser->nr_jumps;
 	}
@@ -1127,13 +1124,12 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	browser.start = map__rip_2objdump(map, sym->start);
 
 	list_for_each_entry(al, &notes->src->source, node) {
-		struct disasm_line *dl = disasm_line(al);
 		struct browser_line *bpos;
 		size_t line_len = strlen(al->line);
 
 		if (browser.b.width < line_len)
 			browser.b.width = line_len;
-		bpos = browser_line(dl);
+		bpos = browser_line(al);
 		bpos->idx = browser.nr_entries++;
 		if (al->offset != -1) {
 			bpos->idx_asm = browser.nr_asm_entries++;
-- 
2.13.6
