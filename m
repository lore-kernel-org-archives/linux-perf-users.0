From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/83] perf annotate browser: Use struct annotation_line in find functions
Date: Fri, 17 Nov 2017 17:15:11 -0300
Message-ID: <20171117201601.24110-34-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758382AbdKQUSI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:08 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Use struct annotation_line in find functions:

  annotate_browser__find_string
  annotate_browser__find_string_reverse

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-33-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 40 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index fb83deb8c909..8f75e56aedc2 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -606,23 +606,23 @@ static bool annotate_browser__jump(struct annotate_browser *browser)
 }
 
 static
-struct disasm_line *annotate_browser__find_string(struct annotate_browser *browser,
+struct annotation_line *annotate_browser__find_string(struct annotate_browser *browser,
 					  char *s, s64 *idx)
 {
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *pos = disasm_line(browser->selection);
+	struct annotation_line *al = browser->selection;
 
 	*idx = browser->b.index;
-	list_for_each_entry_continue(pos, &notes->src->source, al.node) {
-		if (disasm_line__filter(&browser->b, &pos->al.node))
+	list_for_each_entry_continue(al, &notes->src->source, node) {
+		if (disasm_line__filter(&browser->b, &al->node))
 			continue;
 
 		++*idx;
 
-		if (pos->al.line && strstr(pos->al.line, s) != NULL)
-			return pos;
+		if (al->line && strstr(al->line, s) != NULL)
+			return al;
 	}
 
 	return NULL;
@@ -630,38 +630,38 @@ struct disasm_line *annotate_browser__find_string(struct annotate_browser *brows
 
 static bool __annotate_browser__search(struct annotate_browser *browser)
 {
-	struct disasm_line *dl;
+	struct annotation_line *al;
 	s64 idx;
 
-	dl = annotate_browser__find_string(browser, browser->search_bf, &idx);
-	if (dl == NULL) {
+	al = annotate_browser__find_string(browser, browser->search_bf, &idx);
+	if (al == NULL) {
 		ui_helpline__puts("String not found!");
 		return false;
 	}
 
-	annotate_browser__set_top(browser, dl, idx);
+	annotate_browser__set_top(browser, disasm_line(al), idx);
 	browser->searching_backwards = false;
 	return true;
 }
 
 static
-struct disasm_line *annotate_browser__find_string_reverse(struct annotate_browser *browser,
+struct annotation_line *annotate_browser__find_string_reverse(struct annotate_browser *browser,
 						  char *s, s64 *idx)
 {
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *pos = disasm_line(browser->selection);
+	struct annotation_line *al = browser->selection;
 
 	*idx = browser->b.index;
-	list_for_each_entry_continue_reverse(pos, &notes->src->source, al.node) {
-		if (disasm_line__filter(&browser->b, &pos->al.node))
+	list_for_each_entry_continue_reverse(al, &notes->src->source, node) {
+		if (disasm_line__filter(&browser->b, &al->node))
 			continue;
 
 		--*idx;
 
-		if (pos->al.line && strstr(pos->al.line, s) != NULL)
-			return pos;
+		if (al->line && strstr(al->line, s) != NULL)
+			return al;
 	}
 
 	return NULL;
@@ -669,16 +669,16 @@ struct disasm_line *annotate_browser__find_string_reverse(struct annotate_browse
 
 static bool __annotate_browser__search_reverse(struct annotate_browser *browser)
 {
-	struct disasm_line *dl;
+	struct annotation_line *al;
 	s64 idx;
 
-	dl = annotate_browser__find_string_reverse(browser, browser->search_bf, &idx);
-	if (dl == NULL) {
+	al = annotate_browser__find_string_reverse(browser, browser->search_bf, &idx);
+	if (al == NULL) {
 		ui_helpline__puts("String not found!");
 		return false;
 	}
 
-	annotate_browser__set_top(browser, dl, idx);
+	annotate_browser__set_top(browser, disasm_line(al), idx);
 	browser->searching_backwards = true;
 	return true;
 }
-- 
2.13.6
