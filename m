From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/83] perf annotate browser: Change selection to struct annotation_line
Date: Fri, 17 Nov 2017 17:15:08 -0300
Message-ID: <20171117201601.24110-31-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Use struct annotation_line as a browser::selection.

We want to be able to use the annotate_browser for all sorts of source
data, so it needs to be able to work over the generic struct
annotation_line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171106105617.GC20858@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 63 +++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3691dc8cef4c..657811669a6c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -47,26 +47,26 @@ static struct annotate_browser_opt {
 struct arch;
 
 struct annotate_browser {
-	struct ui_browser b;
-	struct rb_root	  entries;
-	struct rb_node	  *curr_hot;
-	struct disasm_line  *selection;
-	struct disasm_line  **offsets;
-	struct arch	    *arch;
-	int		    nr_events;
-	u64		    start;
-	int		    nr_asm_entries;
-	int		    nr_entries;
-	int		    max_jump_sources;
-	int		    nr_jumps;
-	bool		    searching_backwards;
-	bool		    have_cycles;
-	u8		    addr_width;
-	u8		    jumps_width;
-	u8		    target_width;
-	u8		    min_addr_width;
-	u8		    max_addr_width;
-	char		    search_bf[128];
+	struct ui_browser	    b;
+	struct rb_root		    entries;
+	struct rb_node		   *curr_hot;
+	struct annotation_line	   *selection;
+	struct disasm_line	  **offsets;
+	struct arch		   *arch;
+	int			    nr_events;
+	u64			    start;
+	int			    nr_asm_entries;
+	int			    nr_entries;
+	int			    max_jump_sources;
+	int			    nr_jumps;
+	bool			    searching_backwards;
+	bool			    have_cycles;
+	u8			    addr_width;
+	u8			    jumps_width;
+	u8			    target_width;
+	u8			    min_addr_width;
+	u8			    max_addr_width;
+	char			    search_bf[128];
 };
 
 static inline struct browser_line *browser_line(struct disasm_line *dl)
@@ -265,7 +265,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	}
 
 	if (current_entry)
-		ab->selection = dl;
+		ab->selection = &dl->al;
 }
 
 static bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym)
@@ -301,7 +301,8 @@ static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
 static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
-	struct disasm_line *cursor = ab->selection, *target;
+	struct disasm_line *cursor = disasm_line(ab->selection);
+	struct disasm_line *target;
 	struct browser_line *btarget, *bcursor;
 	unsigned int from, to;
 	struct map_symbol *ms = ab->b.priv;
@@ -526,7 +527,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 				    struct hist_browser_timer *hbt)
 {
 	struct map_symbol *ms = browser->b.priv;
-	struct disasm_line *dl = browser->selection;
+	struct disasm_line *dl = disasm_line(browser->selection);
 	struct annotation *notes;
 	struct addr_map_symbol target = {
 		.map = ms->map,
@@ -584,7 +585,7 @@ struct disasm_line *annotate_browser__find_offset(struct annotate_browser *brows
 
 static bool annotate_browser__jump(struct annotate_browser *browser)
 {
-	struct disasm_line *dl = browser->selection;
+	struct disasm_line *dl = disasm_line(browser->selection);
 	u64 offset;
 	s64 idx;
 
@@ -610,7 +611,7 @@ struct disasm_line *annotate_browser__find_string(struct annotate_browser *brows
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *pos = browser->selection;
+	struct disasm_line *pos = disasm_line(browser->selection);
 
 	*idx = browser->b.index;
 	list_for_each_entry_continue(pos, &notes->src->source, al.node) {
@@ -649,7 +650,7 @@ struct disasm_line *annotate_browser__find_string_reverse(struct annotate_browse
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *pos = browser->selection;
+	struct disasm_line *pos = disasm_line(browser->selection);
 
 	*idx = browser->b.index;
 	list_for_each_entry_continue_reverse(pos, &notes->src->source, al.node) {
@@ -882,13 +883,16 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		case K_ENTER:
 		case K_RIGHT:
+		{
+			struct disasm_line *dl = disasm_line(browser->selection);
+
 			if (browser->selection == NULL)
 				ui_helpline__puts("Huh? No selection. Report to linux-kernel@vger.kernel.org");
-			else if (browser->selection->al.offset == -1)
+			else if (browser->selection->offset == -1)
 				ui_helpline__puts("Actions are only available for assembly lines.");
-			else if (!browser->selection->ins.ops)
+			else if (!dl->ins.ops)
 				goto show_sup_ins;
-			else if (ins__is_ret(&browser->selection->ins))
+			else if (ins__is_ret(&dl->ins))
 				goto out;
 			else if (!(annotate_browser__jump(browser) ||
 				     annotate_browser__callq(browser, evsel, hbt))) {
@@ -896,6 +900,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				ui_helpline__puts("Actions are only available for function call/return & jump/branch instructions.");
 			}
 			continue;
+		}
 		case 't':
 			if (annotate_browser__opts.show_total_period) {
 				annotate_browser__opts.show_total_period = false;
-- 
2.13.6
