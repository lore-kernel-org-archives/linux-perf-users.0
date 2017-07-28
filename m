From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/15] perf annotate TUI: Clarify calculation of column header widths
Date: Fri, 28 Jul 2017 17:00:16 -0300
Message-ID: <20170728200021.11389-11-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Taeung Song <treeze.taeung@gmail.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In commit f8f4aaead579 ("perf annotate: Finally display IPC and cycle
accounting") the 'pcnt_width' variable was abused in a few places to
also include the optional width of the "IPC" and "cycles" columns, while
in other places we stopped using 'pcnt_width' and instead its previous
equation...

Now that we need to tap into annotate_browser__pcnt_width() to consider
if --show-total-period is being used and instead of that hardcoded 7
(strlen("Percent")) we need to use it or strlen("Event count") we need
this properly clarified to avoid having to touch all the (7 * nr_events)
places.

Clarify this by introducing a separate annotate_browser__cycles_width()
to leave the pcnt_width calculate just what its name implies.

Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/n/tip-szgb07t4k5wtvks8nzwkg710@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c382b1d8af42..0f4bcc0d140c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -110,11 +110,12 @@ static int annotate_browser__set_jumps_percent_color(struct annotate_browser *br
 
 static int annotate_browser__pcnt_width(struct annotate_browser *ab)
 {
-	int w = 7 * ab->nr_events;
+	return 7 * ab->nr_events;
+}
 
-	if (ab->have_cycles)
-		w += IPC_WIDTH + CYCLES_WIDTH;
-	return w;
+static int annotate_browser__cycles_width(struct annotate_browser *ab)
+{
+	return ab->have_cycles ? IPC_WIDTH + CYCLES_WIDTH : 0;
 }
 
 static void annotate_browser__write(struct ui_browser *browser, void *entry, int row)
@@ -127,7 +128,8 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			     (!current_entry || (browser->use_navkeypressed &&
 					         !browser->navkeypressed)));
 	int width = browser->width, printed;
-	int i, pcnt_width = annotate_browser__pcnt_width(ab);
+	int i, pcnt_width = annotate_browser__pcnt_width(ab),
+	       cycles_width = annotate_browser__cycles_width(ab);
 	double percent_max = 0.0;
 	char bf[256];
 	bool show_title = false;
@@ -162,7 +164,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		ui_browser__set_percent_color(browser, 0, current_entry);
 
 		if (!show_title)
-			ui_browser__write_nstring(browser, " ", 7 * ab->nr_events);
+			ui_browser__write_nstring(browser, " ", pcnt_width);
 		else
 			ui_browser__printf(browser, "%*s", 7, "Percent");
 	}
@@ -190,7 +192,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		width += 1;
 
 	if (!*dl->line)
-		ui_browser__write_nstring(browser, " ", width - pcnt_width);
+		ui_browser__write_nstring(browser, " ", width - pcnt_width - cycles_width);
 	else if (dl->offset == -1) {
 		if (dl->line_nr && annotate_browser__opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
@@ -199,7 +201,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			printed = scnprintf(bf, sizeof(bf), "%*s  ",
 				    ab->addr_width, " ");
 		ui_browser__write_nstring(browser, bf, printed);
-		ui_browser__write_nstring(browser, dl->line, width - printed - pcnt_width + 1);
+		ui_browser__write_nstring(browser, dl->line, width - printed - pcnt_width - cycles_width + 1);
 	} else {
 		u64 addr = dl->offset;
 		int color = -1;
@@ -256,7 +258,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		}
 
 		disasm_line__scnprintf(dl, bf, sizeof(bf), !annotate_browser__opts.use_offset);
-		ui_browser__write_nstring(browser, bf, width - pcnt_width - 3 - printed);
+		ui_browser__write_nstring(browser, bf, width - pcnt_width - cycles_width - 3 - printed);
 	}
 
 	if (current_entry)
-- 
2.9.4
