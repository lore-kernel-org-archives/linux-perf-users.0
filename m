From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/83] perf annotate browser: Rename disasm_line__browser to browser_line
Date: Fri, 17 Nov 2017 17:15:07 -0300
Message-ID: <20171117201601.24110-30-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753139AbdKQURy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:54 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@redhat.com>

Rename disasm_line__browser function to browser_line, because the browser got
generic and is no longer disasm specific.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171106105552.GB20858@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 5ed6c158af40..3691dc8cef4c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -69,7 +69,7 @@ struct annotate_browser {
 	char		    search_bf[128];
 };
 
-static inline struct browser_line *disasm_line__browser(struct disasm_line *dl)
+static inline struct browser_line *browser_line(struct disasm_line *dl)
 {
 	return (void *) dl - sizeof(struct browser_line);
 }
@@ -119,7 +119,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct disasm_line *dl = list_entry(entry, struct disasm_line, al.node);
-	struct browser_line *bdl = disasm_line__browser(dl);
+	struct browser_line *bdl = browser_line(dl);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	bool change_color = (!annotate_browser__opts.hide_src_code &&
 			     (!current_entry || (browser->use_navkeypressed &&
@@ -319,8 +319,8 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	if (!target)
 		return;
 
-	bcursor = disasm_line__browser(cursor);
-	btarget = disasm_line__browser(target);
+	bcursor = browser_line(cursor);
+	btarget = browser_line(target);
 
 	if (annotate_browser__opts.hide_src_code) {
 		from = bcursor->idx_asm;
@@ -418,7 +418,7 @@ static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 	u32 idx;
 
 	pos = rb_entry(nd, struct disasm_line, al.rb_node);
-	bpos = disasm_line__browser(pos);
+	bpos = browser_line(pos);
 
 	idx = bpos->idx;
 	if (annotate_browser__opts.hide_src_code)
@@ -476,7 +476,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
 	dl = list_entry(browser->b.top, struct disasm_line, al.node);
-	bdl = disasm_line__browser(dl);
+	bdl = browser_line(dl);
 
 	if (annotate_browser__opts.hide_src_code) {
 		if (bdl->idx_asm < offset)
@@ -1040,7 +1040,7 @@ static void annotate_browser__mark_jump_targets(struct annotate_browser *browser
 		if (dlt == NULL)
 			continue;
 
-		bdlt = disasm_line__browser(dlt);
+		bdlt = browser_line(dlt);
 		if (++bdlt->jump_sources > browser->max_jump_sources)
 			browser->max_jump_sources = bdlt->jump_sources;
 
@@ -1119,7 +1119,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 		if (browser.b.width < line_len)
 			browser.b.width = line_len;
-		bpos = disasm_line__browser(pos);
+		bpos = browser_line(pos);
 		bpos->idx = browser.nr_entries++;
 		if (pos->al.offset != -1) {
 			bpos->idx_asm = browser.nr_asm_entries++;
-- 
2.13.6
