From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/83] perf annotate browser: Rename struct browser_disasm_line to browser_line
Date: Fri, 17 Nov 2017 17:15:06 -0300
Message-ID: <20171117201601.24110-29-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161670AbdKQURv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:51 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@redhat.com>

Rename struct browser_disasm_line to browser_line, because the browser
operates now on generic lines and no longer on disasm lines.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171106105536.GA20858@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 67e5955b3c6f..5ed6c158af40 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -25,10 +25,10 @@ struct disasm_line_samples {
 #define IPC_WIDTH 6
 #define CYCLES_WIDTH 6
 
-struct browser_disasm_line {
-	u32				idx;
-	int				idx_asm;
-	int				jump_sources;
+struct browser_line {
+	u32	idx;
+	int	idx_asm;
+	int	jump_sources;
 };
 
 static struct annotate_browser_opt {
@@ -69,9 +69,9 @@ struct annotate_browser {
 	char		    search_bf[128];
 };
 
-static inline struct browser_disasm_line *disasm_line__browser(struct disasm_line *dl)
+static inline struct browser_line *disasm_line__browser(struct disasm_line *dl)
 {
-	return (void *) dl - sizeof(struct browser_disasm_line);
+	return (void *) dl - sizeof(struct browser_line);
 }
 
 static bool disasm_line__filter(struct ui_browser *browser __maybe_unused,
@@ -119,7 +119,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct disasm_line *dl = list_entry(entry, struct disasm_line, al.node);
-	struct browser_disasm_line *bdl = disasm_line__browser(dl);
+	struct browser_line *bdl = disasm_line__browser(dl);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	bool change_color = (!annotate_browser__opts.hide_src_code &&
 			     (!current_entry || (browser->use_navkeypressed &&
@@ -302,7 +302,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct disasm_line *cursor = ab->selection, *target;
-	struct browser_disasm_line *btarget, *bcursor;
+	struct browser_line *btarget, *bcursor;
 	unsigned int from, to;
 	struct map_symbol *ms = ab->b.priv;
 	struct symbol *sym = ms->sym;
@@ -413,7 +413,7 @@ static void annotate_browser__set_top(struct annotate_browser *browser,
 static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 					 struct rb_node *nd)
 {
-	struct browser_disasm_line *bpos;
+	struct browser_line *bpos;
 	struct disasm_line *pos;
 	u32 idx;
 
@@ -471,7 +471,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
 	struct disasm_line *dl;
-	struct browser_disasm_line *bdl;
+	struct browser_line *bdl;
 	off_t offset = browser->b.index - browser->b.top_idx;
 
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
@@ -1027,7 +1027,7 @@ static void annotate_browser__mark_jump_targets(struct annotate_browser *browser
 
 	for (offset = 0; offset < size; ++offset) {
 		struct disasm_line *dl = browser->offsets[offset], *dlt;
-		struct browser_disasm_line *bdlt;
+		struct browser_line *bdlt;
 
 		if (!disasm_line__is_valid_jump(dl, sym))
 			continue;
@@ -1099,7 +1099,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		nr_pcnt = evsel->nr_members;
 
 	err = symbol__annotate(sym, map, evsel,
-			       sizeof(struct browser_disasm_line), &browser.arch,
+			       sizeof(struct browser_line), &browser.arch,
 			       perf_evsel__env_cpuid(evsel));
 	if (err) {
 		char msg[BUFSIZ];
@@ -1114,7 +1114,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	browser.start = map__rip_2objdump(map, sym->start);
 
 	list_for_each_entry(pos, &notes->src->source, al.node) {
-		struct browser_disasm_line *bpos;
+		struct browser_line *bpos;
 		size_t line_len = strlen(pos->al.line);
 
 		if (browser.b.width < line_len)
-- 
2.13.6
