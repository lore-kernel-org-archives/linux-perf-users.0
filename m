From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v2 05/11] perf tools report: Use less for scripts output
Date: Mon, 25 Feb 2019 19:04:06 -0800
Message-ID: <20190226030412.23485-6-andi@firstfloor.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226030412.23485-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The UI viewer for scripts output has a lot of limitations: limited size,
no search or save function, slow, and various other issues.

Just use 'less' to display directly on the terminal instead.

This won't work in gtk mode, but gtk doesn't support these
context menus anyways. If that is ever done could use an terminal
for the output.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2:
Remove some unneeded headers
---
 tools/perf/ui/browsers/scripts.c | 130 ++++---------------------------
 1 file changed, 17 insertions(+), 113 deletions(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 90a32ac69e76..7f36630694bf 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,35 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <elf.h>
-#include <inttypes.h>
-#include <sys/ttydefaults.h>
-#include <string.h>
 #include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
-#include "../helpline.h"
 #include "../libslang.h"
 
-/* 2048 lines should be enough for a script output */
-#define MAX_LINES		2048
-
-/* 160 bytes for one output line */
-#define AVERAGE_LINE_LEN	160
-
-struct script_line {
-	struct list_head node;
-	char line[AVERAGE_LINE_LEN];
-};
-
-struct perf_script_browser {
-	struct ui_browser b;
-	struct list_head entries;
-	const char *script_name;
-	int nr_lines;
-};
-
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
 /*
@@ -73,69 +50,29 @@ static int list_scripts(char *script_name)
 	return ret;
 }
 
-static void script_browser__write(struct ui_browser *browser,
-				   void *entry, int row)
+static void run_script(char *cmd)
 {
-	struct script_line *sline = list_entry(entry, struct script_line, node);
-	bool current_entry = ui_browser__is_current_entry(browser, row);
-
-	ui_browser__set_color(browser, current_entry ? HE_COLORSET_SELECTED :
-						       HE_COLORSET_NORMAL);
-
-	ui_browser__write_nstring(browser, sline->line, browser->width);
+	pr_debug("Running %s\n", cmd);
+	SLang_reset_tty();
+	if (system(cmd) < 0)
+		pr_warning("Cannot run %s\n", cmd);
+	/*
+	 * SLang doesn't seem to reset the whole terminal, so be more
+	 * forceful to get back to the original state.
+	 */
+	printf("\033[c\033[H\033[J");
+	fflush(stdout);
+	SLang_init_tty(0, 0, 0);
+	SLsmg_refresh();
 }
 
-static int script_browser__run(struct perf_script_browser *browser)
-{
-	int key;
-
-	if (ui_browser__show(&browser->b, browser->script_name,
-			     "Press ESC to exit") < 0)
-		return -1;
-
-	while (1) {
-		key = ui_browser__run(&browser->b, 0);
-
-		/* We can add some special key handling here if needed */
-		break;
-	}
-
-	ui_browser__hide(&browser->b);
-	return key;
-}
-
-
 int script_browse(const char *script_opt)
 {
 	char cmd[SCRIPT_FULLPATH_LEN*2], script_name[SCRIPT_FULLPATH_LEN];
-	char *line = NULL;
-	size_t len = 0;
-	ssize_t retlen;
-	int ret = -1, nr_entries = 0;
-	FILE *fp;
-	void *buf;
-	struct script_line *sline;
-
-	struct perf_script_browser script = {
-		.b = {
-			.refresh    = ui_browser__list_head_refresh,
-			.seek	    = ui_browser__list_head_seek,
-			.write	    = script_browser__write,
-		},
-		.script_name = script_name,
-	};
-
-	INIT_LIST_HEAD(&script.entries);
-
-	/* Save each line of the output in one struct script_line object. */
-	buf = zalloc((sizeof(*sline)) * MAX_LINES);
-	if (!buf)
-		return -1;
-	sline = buf;
 
 	memset(script_name, 0, SCRIPT_FULLPATH_LEN);
 	if (list_scripts(script_name))
-		goto exit;
+		return -1;
 
 	sprintf(cmd, "perf script -s %s ", script_name);
 
@@ -147,42 +84,9 @@ int script_browse(const char *script_opt)
 		strcat(cmd, input_name);
 	}
 
-	strcat(cmd, " 2>&1");
-
-	fp = popen(cmd, "r");
-	if (!fp)
-		goto exit;
-
-	while ((retlen = getline(&line, &len, fp)) != -1) {
-		strncpy(sline->line, line, AVERAGE_LINE_LEN);
-
-		/* If one output line is very large, just cut it short */
-		if (retlen >= AVERAGE_LINE_LEN) {
-			sline->line[AVERAGE_LINE_LEN - 1] = '\0';
-			sline->line[AVERAGE_LINE_LEN - 2] = '\n';
-		}
-		list_add_tail(&sline->node, &script.entries);
-
-		if (script.b.width < retlen)
-			script.b.width = retlen;
-
-		if (nr_entries++ >= MAX_LINES - 1)
-			break;
-		sline++;
-	}
-
-	if (script.b.width > AVERAGE_LINE_LEN)
-		script.b.width = AVERAGE_LINE_LEN;
-
-	free(line);
-	pclose(fp);
+	strcat(cmd, " 2>&1 | less");
 
-	script.nr_lines = nr_entries;
-	script.b.nr_entries = nr_entries;
-	script.b.entries = &script.entries;
+	run_script(cmd);
 
-	ret = script_browser__run(&script);
-exit:
-	free(buf);
-	return ret;
+	return 0;
 }
-- 
2.17.2
