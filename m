From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/30] perf report: Support running scripts for current time range
Date: Mon, 11 Mar 2019 23:01:58 -0300
Message-ID: <20190312020204.22092-25-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When using the time sort key, add new context menus to run scripts for
only the currently selected time range. Compute the correct range for
the selection add pass it as the --time option to perf script.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-6-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 83 +++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index aef800d97ea1..f98aeac607dd 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <linux/rbtree.h>
 #include <sys/ttydefaults.h>
+#include <linux/time64.h>
 
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
@@ -30,6 +31,7 @@
 #include "srcline.h"
 #include "string2.h"
 #include "units.h"
+#include "time-utils.h"
 
 #include "sane_ctype.h"
 
@@ -2338,6 +2340,7 @@ static int switch_data_file(void)
 }
 
 struct popup_action {
+	unsigned long		time;
 	struct thread 		*thread;
 	struct map_symbol 	ms;
 	int			socket;
@@ -2527,36 +2530,64 @@ static int
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
+		char start[32], end[32];
+		unsigned long starttime = act->time;
+		unsigned long endtime = act->time + symbol_conf.time_quantum;
+
+		if (starttime == endtime) { /* Display 1ms as fallback */
+			starttime -= 1*NSEC_PER_MSEC;
+			endtime += 1*NSEC_PER_MSEC;
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
 
@@ -2566,6 +2597,36 @@ add_script_opt(struct hist_browser *browser __maybe_unused,
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
2.20.1
