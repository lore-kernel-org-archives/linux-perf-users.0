From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/12] perf report/top: Do not offer annotation for symbols without samples
Date: Tue, 17 Dec 2019 11:48:26 -0300
Message-ID: <20191217144828.2460-11-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This can happen in the --children mode, i.e. the default mode when
callchains are present, where one of the main entries may be a callchain
entry with no samples.

So far we were not providing any information about why an annotation
couldn't be provided even offering the Annotation option in the popup
menu.

Work is needed to allow for no-samples "annotation', i.e. to show the
disassembly anyway and allow for navigation, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0hhzj2de15o88cguy7h66zre@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 7f653b9f5cd8..3f10e1a070c5 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2461,7 +2461,8 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct popup_action *act, char **optstr,
 		 struct map_symbol *ms)
 {
-	if (ms->sym == NULL || ms->map->dso->annotate_warned)
+	if (ms->sym == NULL || ms->map->dso->annotate_warned ||
+	    symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
@@ -3027,6 +3028,14 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			    browser->selection->map->dso->annotate_warned)
 				continue;
 
+			if (symbol__annotation(browser->selection->sym)->src == NULL) {
+				ui_browser__warning(&browser->b, delay_secs * 2,
+						    "No samples for the \"%s\" symbol.\n\n"
+						    "Probably appeared just in a callchain",
+						    browser->selection->sym->name);
+				continue;
+			}
+
 			actions->ms.map = browser->selection->map;
 			actions->ms.sym = browser->selection->sym;
 			do_annotate(browser, actions);
-- 
2.21.0
