From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/13] perf annotate browser: Support --show-nr-samples option
Date: Mon, 21 Aug 2017 16:25:48 -0300
Message-ID: <20170821192549.17251-13-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

Support the --show-nr-samples in the TUI browser.

Committer notes:

Lift the restriction about --tui but leave it for --gtk:

  $ export LD_LIBRARY_PATH=~/lib64
  $ perf annotate --gtk --show-nr-samples --show-nr-samples is not available in --gtk mode at this time
  $

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1503046023-5646-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c     |  4 ++--
 tools/perf/ui/browsers/annotate.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 89fc0389dc76..c38373195c4a 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -474,8 +474,8 @@ int cmd_annotate(int argc, const char **argv)
 		annotate.sym_hist_filter = argv[0];
 	}
 
-	if (symbol_conf.show_nr_samples && !annotate.use_stdio) {
-		pr_err("--show-nr-samples is only available in --stdio mode at this time\n");
+	if (symbol_conf.show_nr_samples && annotate.use_gtk) {
+		pr_err("--show-nr-samples is not available in --gtk mode at this time\n");
 		return ret;
 	}
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 80f38dab9c3a..faca1b94496e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -42,6 +42,7 @@ static struct annotate_browser_opt {
 	     jump_arrows,
 	     show_linenr,
 	     show_nr_jumps,
+	     show_nr_samples,
 	     show_total_period;
 } annotate_browser__opts = {
 	.use_offset	= true,
@@ -155,6 +156,9 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			if (annotate_browser__opts.show_total_period) {
 				ui_browser__printf(browser, "%11" PRIu64 " ",
 						   bdl->samples[i].he.period);
+			} else if (annotate_browser__opts.show_nr_samples) {
+				ui_browser__printf(browser, "%6" PRIu64 " ",
+						   bdl->samples[i].he.nr_samples);
 			} else {
 				ui_browser__printf(browser, "%6.2f ",
 						   bdl->samples[i].percent);
@@ -167,7 +171,8 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			ui_browser__write_nstring(browser, " ", pcnt_width);
 		else {
 			ui_browser__printf(browser, "%*s", pcnt_width,
-					   annotate_browser__opts.show_total_period ? "Period" : "Percent");
+					   annotate_browser__opts.show_total_period ? "Period" :
+					   annotate_browser__opts.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
 	if (ab->have_cycles) {
@@ -931,9 +936,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
 			     struct hist_browser_timer *hbt)
 {
-	/* Set default value for show_total_period.  */
+	/* Set default value for show_total_period and show_nr_samples  */
 	annotate_browser__opts.show_total_period =
-	  symbol_conf.show_total_period;
+		symbol_conf.show_total_period;
+	annotate_browser__opts.show_nr_samples =
+		symbol_conf.show_nr_samples;
 
 	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt);
 }
@@ -1184,6 +1191,7 @@ static struct annotate_config {
 	ANNOTATE_CFG(jump_arrows),
 	ANNOTATE_CFG(show_linenr),
 	ANNOTATE_CFG(show_nr_jumps),
+	ANNOTATE_CFG(show_nr_samples),
 	ANNOTATE_CFG(show_total_period),
 	ANNOTATE_CFG(use_offset),
 };
-- 
2.13.5
