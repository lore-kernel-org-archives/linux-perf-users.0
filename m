From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v3 07/11] perf tools report: Support running scripts for current time range
Date: Thu, 28 Feb 2019 10:35:46 -0800
Message-ID: <20190228183550.14126-8-andi@firstfloor.org>
References: <20190228183550.14126-1-andi@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228183550.14126-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When using the time sort key, add new context menus to run
scripts for only the currently selected time range. Compute
the correct range for the selection add pass it as the --time option to
perf script.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Use symbol_conf.time_quantum
v3:
Work around gcc bug that triggers bogus warning.
---
 tools/perf/ui/browsers/hists.c | 82 +++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index aef800d97ea1..691056b99b76 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -30,6 +30,7 @@
 #include "srcline.h"
 #include "string2.h"
 #include "units.h"
+#include "time-utils.h"
 
 #include "sane_ctype.h"
 
@@ -2338,6 +2339,7 @@ static int switch_data_file(void)
 }
 
 struct popup_action {
+	unsigned long		time;
 	struct thread 		*thread;
 	struct map_symbol 	ms;
 	int			socket;
@@ -2527,36 +2529,64 @@ static int
 do_run_script(struct hist_browser *browser __maybe_unused,
 	      struct popup_action *act)
 {
-	char script_opt[64];
-	memset(script_opt, 0, sizeof(script_opt));
+	char *script_opt;
+	int len;
+	int n = 0;
+
+	len = 100;
+	if (act->thread)
+		len += strlen(thread__comm_str(act->thread));
+	else if (act->ms.sym)
+		len += strlen(act->ms.sym->name);
+	script_opt = malloc(len);
+	if (!script_opt)
+		return -1;
 
+	script_opt[0] = 0;
 	if (act->thread) {
-		scnprintf(script_opt, sizeof(script_opt), " -c %s ",
+		n = scnprintf(script_opt, len, " -c %s ",
 			  thread__comm_str(act->thread));
 	} else if (act->ms.sym) {
-		scnprintf(script_opt, sizeof(script_opt), " -S %s ",
+		n = scnprintf(script_opt, len, " -S %s ",
 			  act->ms.sym->name);
 	}
 
+	if (act->time) {
+		char start[22], end[22];
+		unsigned long starttime = act->time;
+		unsigned long endtime = act->time + symbol_conf.time_quantum;
+
+		if (starttime == endtime) { /* Display 1ms as fallback */
+			starttime -= 1*1000000;
+			endtime += 1*1000000;
+		}
+		timestamp__scnprintf_usec(starttime, start, sizeof start);
+		timestamp__scnprintf_usec(endtime, end, sizeof end);
+		n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
+	}
+
 	script_browse(script_opt);
+	free(script_opt);
 	return 0;
 }
 
 static int
-add_script_opt(struct hist_browser *browser __maybe_unused,
+add_script_opt_2(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act, char **optstr,
-	       struct thread *thread, struct symbol *sym)
+	       struct thread *thread, struct symbol *sym,
+	       const char *tstr)
 {
+
 	if (thread) {
-		if (asprintf(optstr, "Run scripts for samples of thread [%s]",
-			     thread__comm_str(thread)) < 0)
+		if (asprintf(optstr, "Run scripts for samples of thread [%s]%s",
+			     thread__comm_str(thread), tstr) < 0)
 			return 0;
 	} else if (sym) {
-		if (asprintf(optstr, "Run scripts for samples of symbol [%s]",
-			     sym->name) < 0)
+		if (asprintf(optstr, "Run scripts for samples of symbol [%s]%s",
+			     sym->name, tstr) < 0)
 			return 0;
 	} else {
-		if (asprintf(optstr, "Run scripts for all samples") < 0)
+		if (asprintf(optstr, "Run scripts for all samples%s", tstr) < 0)
 			return 0;
 	}
 
@@ -2566,6 +2596,36 @@ add_script_opt(struct hist_browser *browser __maybe_unused,
 	return 1;
 }
 
+static int
+add_script_opt(struct hist_browser *browser,
+	       struct popup_action *act, char **optstr,
+	       struct thread *thread, struct symbol *sym)
+{
+	int n, j;
+	struct hist_entry *he;
+
+	n = add_script_opt_2(browser, act, optstr, thread, sym, "");
+
+	he = hist_browser__selected_entry(browser);
+	if (sort_order && strstr(sort_order, "time")) {
+		char tstr[128];
+
+		optstr++;
+		act++;
+		j = sprintf(tstr, " in ");
+		j += timestamp__scnprintf_usec(he->time, tstr + j,
+					       sizeof tstr - j);
+		j += sprintf(tstr + j, "-");
+		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
+				          tstr + j,
+				          sizeof tstr - j);
+		n += add_script_opt_2(browser, act, optstr, thread, sym,
+					  tstr);
+		act->time = he->time;
+	}
+	return n;
+}
+
 static int
 do_switch_data(struct hist_browser *browser __maybe_unused,
 	       struct popup_action *act __maybe_unused)
-- 
2.17.2
