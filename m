From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/83] perf annotate: Move line/offset into annotation_line struct
Date: Fri, 17 Nov 2017 17:14:42 -0300
Message-ID: <20171117201601.24110-5-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758305AbdKQUQc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:32 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Move the line/line_nr/offset menbers to the annotation_line struct to be
used as generic members for any annotation source.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 45 ++++++++++++++++++++-------------------
 tools/perf/ui/gtk/annotate.c      | 14 ++++++------
 tools/perf/util/annotate.c        | 41 ++++++++++++++++++-----------------
 tools/perf/util/annotate.h        |  6 +++---
 4 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index a8c2f7405a41..73d921c3e3ec 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -84,8 +84,9 @@ static bool disasm_line__filter(struct ui_browser *browser __maybe_unused,
 				void *entry)
 {
 	if (annotate_browser__opts.hide_src_code) {
-		struct disasm_line *dl = list_entry(entry, struct disasm_line, al.node);
-		return dl->offset == -1;
+		struct annotation_line *al = list_entry(entry, struct annotation_line, node);
+
+		return al->offset == -1;
 	}
 
 	return false;
@@ -141,7 +142,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			percent_max = bdl->samples[i].percent;
 	}
 
-	if ((row == 0) && (dl->offset == -1 || percent_max == 0.0)) {
+	if ((row == 0) && (dl->al.offset == -1 || percent_max == 0.0)) {
 		if (ab->have_cycles) {
 			if (dl->ipc == 0.0 && dl->cycles == 0)
 				show_title = true;
@@ -149,7 +150,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			show_title = true;
 	}
 
-	if (dl->offset != -1 && percent_max != 0.0) {
+	if (dl->al.offset != -1 && percent_max != 0.0) {
 		for (i = 0; i < ab->nr_events; i++) {
 			ui_browser__set_percent_color(browser,
 						bdl->samples[i].percent,
@@ -199,19 +200,19 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		width += 1;
 
-	if (!*dl->line)
+	if (!*dl->al.line)
 		ui_browser__write_nstring(browser, " ", width - pcnt_width - cycles_width);
-	else if (dl->offset == -1) {
-		if (dl->line_nr && annotate_browser__opts.show_linenr)
+	else if (dl->al.offset == -1) {
+		if (dl->al.line_nr && annotate_browser__opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
-					ab->addr_width + 1, dl->line_nr);
+					ab->addr_width + 1, dl->al.line_nr);
 		else
 			printed = scnprintf(bf, sizeof(bf), "%*s  ",
 				    ab->addr_width, " ");
 		ui_browser__write_nstring(browser, bf, printed);
-		ui_browser__write_nstring(browser, dl->line, width - printed - pcnt_width - cycles_width + 1);
+		ui_browser__write_nstring(browser, dl->al.line, width - printed - pcnt_width - cycles_width + 1);
 	} else {
-		u64 addr = dl->offset;
+		u64 addr = dl->al.offset;
 		int color = -1;
 
 		if (!annotate_browser__opts.use_offset)
@@ -247,7 +248,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			ui_browser__set_color(browser, color);
 		if (dl->ins.ops && dl->ins.ops->scnprintf) {
 			if (ins__is_jump(&dl->ins)) {
-				bool fwd = dl->ops.target.offset > dl->offset;
+				bool fwd = dl->ops.target.offset > dl->al.offset;
 
 				ui_browser__write_graph(browser, fwd ? SLSMG_DARROW_CHAR :
 								    SLSMG_UARROW_CHAR);
@@ -452,7 +453,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		double max_percent = 0.0;
 		int i;
 
-		if (pos->offset == -1) {
+		if (pos->al.offset == -1) {
 			RB_CLEAR_NODE(&bpos->rb_node);
 			continue;
 		}
@@ -464,8 +465,8 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 			bpos->samples[i].percent = disasm__calc_percent(notes,
 						evsel->idx + i,
-						pos->offset,
-						next ? next->offset : len,
+						pos->al.offset,
+						next ? next->al.offset : len,
 						&path, &sample);
 			bpos->samples[i].he = sample;
 
@@ -590,7 +591,7 @@ struct disasm_line *annotate_browser__find_offset(struct annotate_browser *brows
 
 	*idx = 0;
 	list_for_each_entry(pos, &notes->src->source, al.node) {
-		if (pos->offset == offset)
+		if (pos->al.offset == offset)
 			return pos;
 		if (!disasm_line__filter(&browser->b, &pos->al.node))
 			++*idx;
@@ -636,7 +637,7 @@ struct disasm_line *annotate_browser__find_string(struct annotate_browser *brows
 
 		++*idx;
 
-		if (pos->line && strstr(pos->line, s) != NULL)
+		if (pos->al.line && strstr(pos->al.line, s) != NULL)
 			return pos;
 	}
 
@@ -675,7 +676,7 @@ struct disasm_line *annotate_browser__find_string_reverse(struct annotate_browse
 
 		--*idx;
 
-		if (pos->line && strstr(pos->line, s) != NULL)
+		if (pos->al.line && strstr(pos->al.line, s) != NULL)
 			return pos;
 	}
 
@@ -901,7 +902,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case K_RIGHT:
 			if (browser->selection == NULL)
 				ui_helpline__puts("Huh? No selection. Report to linux-kernel@vger.kernel.org");
-			else if (browser->selection->offset == -1)
+			else if (browser->selection->al.offset == -1)
 				ui_helpline__puts("Actions are only available for assembly lines.");
 			else if (!browser->selection->ins.ops)
 				goto show_sup_ins;
@@ -1136,13 +1137,13 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 	list_for_each_entry(pos, &notes->src->source, al.node) {
 		struct browser_disasm_line *bpos;
-		size_t line_len = strlen(pos->line);
+		size_t line_len = strlen(pos->al.line);
 
 		if (browser.b.width < line_len)
 			browser.b.width = line_len;
 		bpos = disasm_line__browser(pos);
 		bpos->idx = browser.nr_entries++;
-		if (pos->offset != -1) {
+		if (pos->al.offset != -1) {
 			bpos->idx_asm = browser.nr_asm_entries++;
 			/*
 			 * FIXME: short term bandaid to cope with assembly
@@ -1151,8 +1152,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 *
 			 * E.g. copy_user_generic_unrolled
  			 */
-			if (pos->offset < (s64)size)
-				browser.offsets[pos->offset] = pos;
+			if (pos->al.offset < (s64)size)
+				browser.offsets[pos->al.offset] = pos;
 		} else
 			bpos->idx_asm = -1;
 	}
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index cf8092676c7a..162f15712d2d 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -31,14 +31,14 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 
 	strcpy(buf, "");
 
-	if (dl->offset == (s64) -1)
+	if (dl->al.offset == (s64) -1)
 		return 0;
 
 	symhist = annotation__histogram(symbol__annotation(sym), evidx);
-	if (!symbol_conf.event_group && !symhist->addr[dl->offset].nr_samples)
+	if (!symbol_conf.event_group && !symhist->addr[dl->al.offset].nr_samples)
 		return 0;
 
-	percent = 100.0 * symhist->addr[dl->offset].nr_samples / symhist->nr_samples;
+	percent = 100.0 * symhist->addr[dl->al.offset].nr_samples / symhist->nr_samples;
 
 	markup = perf_gtk__get_percent_color(percent);
 	if (markup)
@@ -57,16 +57,16 @@ static int perf_gtk__get_offset(char *buf, size_t size, struct symbol *sym,
 
 	strcpy(buf, "");
 
-	if (dl->offset == (s64) -1)
+	if (dl->al.offset == (s64) -1)
 		return 0;
 
-	return scnprintf(buf, size, "%"PRIx64, start + dl->offset);
+	return scnprintf(buf, size, "%"PRIx64, start + dl->al.offset);
 }
 
 static int perf_gtk__get_line(char *buf, size_t size, struct disasm_line *dl)
 {
 	int ret = 0;
-	char *line = g_markup_escape_text(dl->line, -1);
+	char *line = g_markup_escape_text(dl->al.line, -1);
 	const char *markup = "<span fgcolor='gray'>";
 
 	strcpy(buf, "");
@@ -74,7 +74,7 @@ static int perf_gtk__get_line(char *buf, size_t size, struct disasm_line *dl)
 	if (!line)
 		return 0;
 
-	if (dl->offset != (s64) -1)
+	if (dl->al.offset != (s64) -1)
 		markup = NULL;
 
 	if (markup)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 004e33dc897c..e8b69001229d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -886,14 +886,15 @@ static struct disasm_line *disasm_line__new(s64 offset, char *line,
 	struct disasm_line *dl = zalloc(sizeof(*dl) + privsize);
 
 	if (dl != NULL) {
-		dl->offset = offset;
-		dl->line = strdup(line);
-		dl->line_nr = line_nr;
-		if (dl->line == NULL)
+		dl->al.offset  = offset;
+		dl->al.line    = strdup(line);
+		dl->al.line_nr = line_nr;
+
+		if (dl->al.line == NULL)
 			goto out_delete;
 
 		if (offset != -1) {
-			if (disasm_line__parse(dl->line, &dl->ins.name, &dl->ops.raw) < 0)
+			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 				goto out_free_line;
 
 			disasm_line__init_ins(dl, arch, map);
@@ -903,7 +904,7 @@ static struct disasm_line *disasm_line__new(s64 offset, char *line,
 	return dl;
 
 out_free_line:
-	zfree(&dl->line);
+	zfree(&dl->al.line);
 out_delete:
 	free(dl);
 	return NULL;
@@ -911,7 +912,7 @@ static struct disasm_line *disasm_line__new(s64 offset, char *line,
 
 void disasm_line__free(struct disasm_line *dl)
 {
-	zfree(&dl->line);
+	zfree(&dl->al.line);
 	if (dl->ins.ops && dl->ins.ops->free)
 		dl->ins.ops->free(&dl->ops);
 	else
@@ -937,7 +938,7 @@ static void disasm__add(struct list_head *head, struct disasm_line *line)
 struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disasm_line *pos)
 {
 	list_for_each_entry_continue(pos, head, al.node)
-		if (pos->offset >= 0)
+		if (pos->al.offset >= 0)
 			return pos;
 
 	return NULL;
@@ -1077,7 +1078,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 	static const char *prev_line;
 	static const char *prev_color;
 
-	if (dl->offset != -1) {
+	if (dl->al.offset != -1) {
 		const char *path = NULL;
 		double percent, max_percent = 0.0;
 		double *ppercents = &percent;
@@ -1086,7 +1087,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		int i, nr_percent = 1;
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
-		s64 offset = dl->offset;
+		s64 offset = dl->al.offset;
 		const u64 addr = start + offset;
 		struct disasm_line *next;
 		struct block_range *br;
@@ -1106,7 +1107,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 			percent = disasm__calc_percent(notes,
 					notes->src->lines ? i : evsel->idx + i,
 					offset,
-					next ? next->offset : (s64) len,
+					next ? next->al.offset : (s64) len,
 					&path, &sample);
 
 			ppercents[i] = percent;
@@ -1165,7 +1166,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 
 		br = block_range__find(addr);
 		color_fprintf(stdout, annotate__address_color(br), "  %" PRIx64 ":", addr);
-		color_fprintf(stdout, annotate__asm_color(br), "%s", dl->line);
+		color_fprintf(stdout, annotate__asm_color(br), "%s", dl->al.line);
 		annotate__branch_printf(br, addr);
 		printf("\n");
 
@@ -1186,10 +1187,10 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		if (perf_evsel__is_group_event(evsel))
 			width *= evsel->nr_members;
 
-		if (!*dl->line)
+		if (!*dl->al.line)
 			printf(" %*s:\n", width, " ");
 		else
-			printf(" %*s:	%s\n", width, " ", dl->line);
+			printf(" %*s:	%s\n", width, " ", dl->al.line);
 	}
 
 	return 0;
@@ -1311,9 +1312,9 @@ static void delete_last_nop(struct symbol *sym)
 			if (dl->ins.ops != &nop_ops)
 				return;
 		} else {
-			if (!strstr(dl->line, " nop ") &&
-			    !strstr(dl->line, " nopl ") &&
-			    !strstr(dl->line, " nopw "))
+			if (!strstr(dl->al.line, " nop ") &&
+			    !strstr(dl->al.line, " nopl ") &&
+			    !strstr(dl->al.line, " nopw "))
 				return;
 		}
 
@@ -1921,10 +1922,10 @@ static size_t disasm_line__fprintf(struct disasm_line *dl, FILE *fp)
 {
 	size_t printed;
 
-	if (dl->offset == -1)
-		return fprintf(fp, "%s\n", dl->line);
+	if (dl->al.offset == -1)
+		return fprintf(fp, "%s\n", dl->al.line);
 
-	printed = fprintf(fp, "%#" PRIx64 " %s", dl->offset, dl->ins.name);
+	printed = fprintf(fp, "%#" PRIx64 " %s", dl->al.offset, dl->ins.name);
 
 	if (dl->ops.raw[0] != '\0') {
 		printed += fprintf(fp, "%.*s %s\n", 6 - (int)printed, " ",
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index cc3cf6b50d55..b7ca62855760 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -61,14 +61,14 @@ struct annotation;
 
 struct annotation_line {
 	struct list_head	 node;
+	s64			 offset;
+	char			*line;
+	int			 line_nr;
 };
 
 struct disasm_line {
 	struct annotation_line	 al;
-	s64			 offset;
-	char			*line;
 	struct ins		 ins;
-	int			 line_nr;
 	float			 ipc;
 	u64			 cycles;
 	struct ins_operands	 ops;
-- 
2.13.6
