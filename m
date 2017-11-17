From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/83] perf annotate browser: Add disasm_line__write function
Date: Fri, 17 Nov 2017 17:15:13 -0300
Message-ID: <20171117201601.24110-36-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Factor disasm_line__write function from annotate_browser__write, which
now keeps only generic display code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-35-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 98 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 45 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index f0f27cf9db85..5a2f37a91feb 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -118,11 +118,37 @@ static int annotate_browser__cycles_width(struct annotate_browser *ab)
 	return ab->have_cycles ? IPC_WIDTH + CYCLES_WIDTH : 0;
 }
 
+static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
+			       char *bf, size_t size)
+{
+	if (dl->ins.ops && dl->ins.ops->scnprintf) {
+		if (ins__is_jump(&dl->ins)) {
+			bool fwd = dl->ops.target.offset > dl->al.offset;
+
+			ui_browser__write_graph(browser, fwd ? SLSMG_DARROW_CHAR :
+							    SLSMG_UARROW_CHAR);
+			SLsmg_write_char(' ');
+		} else if (ins__is_call(&dl->ins)) {
+			ui_browser__write_graph(browser, SLSMG_RARROW_CHAR);
+			SLsmg_write_char(' ');
+		} else if (ins__is_ret(&dl->ins)) {
+			ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
+			SLsmg_write_char(' ');
+		} else {
+			ui_browser__write_nstring(browser, " ", 2);
+		}
+	} else {
+		ui_browser__write_nstring(browser, " ", 2);
+	}
+
+	disasm_line__scnprintf(dl, bf, size, !annotate_browser__opts.use_offset);
+}
+
 static void annotate_browser__write(struct ui_browser *browser, void *entry, int row)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
-	struct disasm_line *dl = list_entry(entry, struct disasm_line, al.node);
-	struct browser_line *bdl = browser_line(&dl->al);
+	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
+	struct browser_line *bl = browser_line(al);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	bool change_color = (!annotate_browser__opts.hide_src_code &&
 			     (!current_entry || (browser->use_navkeypressed &&
@@ -135,32 +161,32 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	bool show_title = false;
 
 	for (i = 0; i < ab->nr_events; i++) {
-		if (dl->al.samples[i].percent > percent_max)
-			percent_max = dl->al.samples[i].percent;
+		if (al->samples[i].percent > percent_max)
+			percent_max = al->samples[i].percent;
 	}
 
-	if ((row == 0) && (dl->al.offset == -1 || percent_max == 0.0)) {
+	if ((row == 0) && (al->offset == -1 || percent_max == 0.0)) {
 		if (ab->have_cycles) {
-			if (dl->al.ipc == 0.0 && dl->al.cycles == 0)
+			if (al->ipc == 0.0 && al->cycles == 0)
 				show_title = true;
 		} else
 			show_title = true;
 	}
 
-	if (dl->al.offset != -1 && percent_max != 0.0) {
+	if (al->offset != -1 && percent_max != 0.0) {
 		for (i = 0; i < ab->nr_events; i++) {
 			ui_browser__set_percent_color(browser,
-						dl->al.samples[i].percent,
+						al->samples[i].percent,
 						current_entry);
 			if (annotate_browser__opts.show_total_period) {
 				ui_browser__printf(browser, "%11" PRIu64 " ",
-						   dl->al.samples[i].he.period);
+						   al->samples[i].he.period);
 			} else if (annotate_browser__opts.show_nr_samples) {
 				ui_browser__printf(browser, "%6" PRIu64 " ",
-						   dl->al.samples[i].he.nr_samples);
+						   al->samples[i].he.nr_samples);
 			} else {
 				ui_browser__printf(browser, "%6.2f ",
-						   dl->al.samples[i].percent);
+						   al->samples[i].percent);
 			}
 		}
 	} else {
@@ -175,16 +201,16 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		}
 	}
 	if (ab->have_cycles) {
-		if (dl->al.ipc)
-			ui_browser__printf(browser, "%*.2f ", IPC_WIDTH - 1, dl->al.ipc);
+		if (al->ipc)
+			ui_browser__printf(browser, "%*.2f ", IPC_WIDTH - 1, al->ipc);
 		else if (!show_title)
 			ui_browser__write_nstring(browser, " ", IPC_WIDTH);
 		else
 			ui_browser__printf(browser, "%*s ", IPC_WIDTH - 1, "IPC");
 
-		if (dl->al.cycles)
+		if (al->cycles)
 			ui_browser__printf(browser, "%*" PRIu64 " ",
-					   CYCLES_WIDTH - 1, dl->al.cycles);
+					   CYCLES_WIDTH - 1, al->cycles);
 		else if (!show_title)
 			ui_browser__write_nstring(browser, " ", CYCLES_WIDTH);
 		else
@@ -197,19 +223,19 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		width += 1;
 
-	if (!*dl->al.line)
+	if (!*al->line)
 		ui_browser__write_nstring(browser, " ", width - pcnt_width - cycles_width);
-	else if (dl->al.offset == -1) {
-		if (dl->al.line_nr && annotate_browser__opts.show_linenr)
+	else if (al->offset == -1) {
+		if (al->line_nr && annotate_browser__opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
-					ab->addr_width + 1, dl->al.line_nr);
+					ab->addr_width + 1, al->line_nr);
 		else
 			printed = scnprintf(bf, sizeof(bf), "%*s  ",
 				    ab->addr_width, " ");
 		ui_browser__write_nstring(browser, bf, printed);
-		ui_browser__write_nstring(browser, dl->al.line, width - printed - pcnt_width - cycles_width + 1);
+		ui_browser__write_nstring(browser, al->line, width - printed - pcnt_width - cycles_width + 1);
 	} else {
-		u64 addr = dl->al.offset;
+		u64 addr = al->offset;
 		int color = -1;
 
 		if (!annotate_browser__opts.use_offset)
@@ -218,13 +244,13 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		if (!annotate_browser__opts.use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
 		} else {
-			if (bdl->jump_sources) {
+			if (bl->jump_sources) {
 				if (annotate_browser__opts.show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
 							    ab->jumps_width,
-							    bdl->jump_sources);
-					prev = annotate_browser__set_jumps_percent_color(ab, bdl->jump_sources,
+							    bl->jump_sources);
+					prev = annotate_browser__set_jumps_percent_color(ab, bl->jump_sources,
 											 current_entry);
 					ui_browser__write_nstring(browser, bf, printed);
 					ui_browser__set_color(browser, prev);
@@ -243,32 +269,14 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		ui_browser__write_nstring(browser, bf, printed);
 		if (change_color)
 			ui_browser__set_color(browser, color);
-		if (dl->ins.ops && dl->ins.ops->scnprintf) {
-			if (ins__is_jump(&dl->ins)) {
-				bool fwd = dl->ops.target.offset > dl->al.offset;
-
-				ui_browser__write_graph(browser, fwd ? SLSMG_DARROW_CHAR :
-								    SLSMG_UARROW_CHAR);
-				SLsmg_write_char(' ');
-			} else if (ins__is_call(&dl->ins)) {
-				ui_browser__write_graph(browser, SLSMG_RARROW_CHAR);
-				SLsmg_write_char(' ');
-			} else if (ins__is_ret(&dl->ins)) {
-				ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
-				SLsmg_write_char(' ');
-			} else {
-				ui_browser__write_nstring(browser, " ", 2);
-			}
-		} else {
-			ui_browser__write_nstring(browser, " ", 2);
-		}
 
-		disasm_line__scnprintf(dl, bf, sizeof(bf), !annotate_browser__opts.use_offset);
+		disasm_line__write(disasm_line(al), browser, bf, sizeof(bf));
+
 		ui_browser__write_nstring(browser, bf, width - pcnt_width - cycles_width - 3 - printed);
 	}
 
 	if (current_entry)
-		ab->selection = &dl->al;
+		ab->selection = al;
 }
 
 static bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym)
-- 
2.13.6
