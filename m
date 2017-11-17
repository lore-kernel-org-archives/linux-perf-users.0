From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/83] perf annotate browser: Use struct annotation_line in browser top
Date: Fri, 17 Nov 2017 17:15:12 -0300
Message-ID: <20171117201601.24110-35-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use struct annotation_line in browser::b::top.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-34-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8f75e56aedc2..f0f27cf9db85 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -390,7 +390,7 @@ static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line
 }
 
 static void annotate_browser__set_top(struct annotate_browser *browser,
-				      struct disasm_line *pos, u32 idx)
+				      struct annotation_line *pos, u32 idx)
 {
 	unsigned back;
 
@@ -399,16 +399,16 @@ static void annotate_browser__set_top(struct annotate_browser *browser,
 	browser->b.top_idx = browser->b.index = idx;
 
 	while (browser->b.top_idx != 0 && back != 0) {
-		pos = list_entry(pos->al.node.prev, struct disasm_line, al.node);
+		pos = list_entry(pos->node.prev, struct annotation_line, node);
 
-		if (disasm_line__filter(&browser->b, &pos->al.node))
+		if (disasm_line__filter(&browser->b, &pos->node))
 			continue;
 
 		--browser->b.top_idx;
 		--back;
 	}
 
-	browser->b.top = &pos->al;
+	browser->b.top = pos;
 	browser->b.navkeypressed = true;
 }
 
@@ -416,11 +416,11 @@ static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 					 struct rb_node *nd)
 {
 	struct browser_line *bpos;
-	struct disasm_line *pos;
+	struct annotation_line *pos;
 	u32 idx;
 
-	pos = rb_entry(nd, struct disasm_line, al.rb_node);
-	bpos = browser_line(&pos->al);
+	pos = rb_entry(nd, struct annotation_line, rb_node);
+	bpos = browser_line(pos);
 
 	idx = bpos->idx;
 	if (annotate_browser__opts.hide_src_code)
@@ -472,13 +472,13 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
-	struct disasm_line *dl;
+	struct annotation_line *al;
 	struct browser_line *bl;
 	off_t offset = browser->b.index - browser->b.top_idx;
 
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
-	dl = list_entry(browser->b.top, struct disasm_line, al.node);
-	bl = browser_line(&dl->al);
+	al = list_entry(browser->b.top, struct annotation_line, node);
+	bl = browser_line(al);
 
 	if (annotate_browser__opts.hide_src_code) {
 		if (bl->idx_asm < offset)
@@ -600,7 +600,7 @@ static bool annotate_browser__jump(struct annotate_browser *browser)
 		return true;
 	}
 
-	annotate_browser__set_top(browser, dl, idx);
+	annotate_browser__set_top(browser, &dl->al, idx);
 
 	return true;
 }
@@ -639,7 +639,7 @@ static bool __annotate_browser__search(struct annotate_browser *browser)
 		return false;
 	}
 
-	annotate_browser__set_top(browser, disasm_line(al), idx);
+	annotate_browser__set_top(browser, al, idx);
 	browser->searching_backwards = false;
 	return true;
 }
@@ -678,7 +678,7 @@ static bool __annotate_browser__search_reverse(struct annotate_browser *browser)
 		return false;
 	}
 
-	annotate_browser__set_top(browser, disasm_line(al), idx);
+	annotate_browser__set_top(browser, al, idx);
 	browser->searching_backwards = true;
 	return true;
 }
-- 
2.13.6
