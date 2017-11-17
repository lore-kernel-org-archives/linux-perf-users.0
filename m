From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/83] perf annotate: Move rb_node to struct annotation_line
Date: Fri, 17 Nov 2017 17:14:52 -0300
Message-ID: <20171117201601.24110-15-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move rb_node to struct annotation_line to make struct annotation_line
the rb tree node for sorted lines used in both stdio and TUI code.

This way we can unite the sorted lines lines codes for both TUI and
stdio in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 30 ++++++++++++++++--------------
 tools/perf/util/annotate.h        |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 881ad6122057..cfde5a2ca3f4 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -26,7 +26,6 @@ struct disasm_line_samples {
 #define CYCLES_WIDTH 6
 
 struct browser_disasm_line {
-	struct rb_node			rb_node;
 	u32				idx;
 	int				idx_asm;
 	int				jump_sources;
@@ -362,9 +361,11 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 	return ret;
 }
 
-static int disasm__cmp(struct browser_disasm_line *a,
-		       struct browser_disasm_line *b, int nr_pcnt)
+static int disasm__cmp(struct disasm_line *da,
+		       struct disasm_line *db, int nr_pcnt)
 {
+	struct browser_disasm_line *a = disasm_line__browser(da);
+	struct browser_disasm_line *b = disasm_line__browser(db);
 	int i;
 
 	for (i = 0; i < nr_pcnt; i++) {
@@ -375,24 +376,24 @@ static int disasm__cmp(struct browser_disasm_line *a,
 	return 0;
 }
 
-static void disasm_rb_tree__insert(struct rb_root *root, struct browser_disasm_line *bdl,
+static void disasm_rb_tree__insert(struct rb_root *root, struct disasm_line *dl,
 				   int nr_events)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
-	struct browser_disasm_line *l;
+	struct disasm_line *l;
 
 	while (*p != NULL) {
 		parent = *p;
-		l = rb_entry(parent, struct browser_disasm_line, rb_node);
+		l = rb_entry(parent, struct disasm_line, al.rb_node);
 
-		if (disasm__cmp(bdl, l, nr_events))
+		if (disasm__cmp(dl, l, nr_events))
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
 	}
-	rb_link_node(&bdl->rb_node, parent, p);
-	rb_insert_color(&bdl->rb_node, root);
+	rb_link_node(&dl->al.rb_node, parent, p);
+	rb_insert_color(&dl->al.rb_node, root);
 }
 
 static void annotate_browser__set_top(struct annotate_browser *browser,
@@ -425,8 +426,9 @@ static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 	struct disasm_line *pos;
 	u32 idx;
 
-	bpos = rb_entry(nd, struct browser_disasm_line, rb_node);
-	pos = ((struct disasm_line *)bpos) - 1;
+	pos = rb_entry(nd, struct disasm_line, al.rb_node);
+	bpos = disasm_line__browser(pos);
+
 	idx = bpos->idx;
 	if (annotate_browser__opts.hide_src_code)
 		idx = bpos->idx_asm;
@@ -455,7 +457,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		int i;
 
 		if (pos->al.offset == -1) {
-			RB_CLEAR_NODE(&bpos->rb_node);
+			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
 
@@ -476,10 +478,10 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		}
 
 		if (max_percent < 0.01 && pos->al.ipc == 0) {
-			RB_CLEAR_NODE(&bpos->rb_node);
+			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
-		disasm_rb_tree__insert(&browser->entries, bpos,
+		disasm_rb_tree__insert(&browser->entries, pos,
 				       browser->nr_events);
 	}
 	pthread_mutex_unlock(&notes->lock);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 43bef6cacbc4..6f01e6117936 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -61,6 +61,7 @@ struct annotation;
 
 struct annotation_line {
 	struct list_head	 node;
+	struct rb_node		 rb_node;
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
-- 
2.13.6
