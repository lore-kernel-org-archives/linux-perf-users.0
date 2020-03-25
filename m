From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/24] perf report/top TUI: Support hotkey 'a' for annotation of unresolved addresses
Date: Wed, 25 Mar 2020 09:41:05 -0300
Message-ID: <20200325124124.32648-6-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

In previous patch, we have supported the annotation functionality even
without symbols.

For this patch, it supports the hotkey 'a' on address in report view.
Note that, for branch mode, we only support the annotation for "branch
to" address.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200227043939.4403-4-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 46 ++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d0f9745856fd..1103a019d83f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3061,21 +3061,45 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 				continue;
 			}
 
-			if (browser->selection == NULL ||
-			    browser->selection->sym == NULL ||
-			    browser->selection->map->dso->annotate_warned)
+			if (!browser->selection ||
+			    !browser->selection->map ||
+			    !browser->selection->map->dso ||
+			    browser->selection->map->dso->annotate_warned) {
 				continue;
+			}
 
-			if (symbol__annotation(browser->selection->sym)->src == NULL) {
-				ui_browser__warning(&browser->b, delay_secs * 2,
-						    "No samples for the \"%s\" symbol.\n\n"
-						    "Probably appeared just in a callchain",
-						    browser->selection->sym->name);
-				continue;
+			if (!browser->selection->sym) {
+				if (!browser->he_selection)
+					continue;
+
+				if (sort__mode == SORT_MODE__BRANCH) {
+					bi = browser->he_selection->branch_info;
+					if (!bi || !bi->to.ms.map)
+						continue;
+
+					actions->ms.sym = symbol__new_unresolved(bi->to.al_addr, bi->to.ms.map);
+					actions->ms.map = bi->to.ms.map;
+				} else {
+					actions->ms.sym = symbol__new_unresolved(browser->he_selection->ip,
+										 browser->selection->map);
+					actions->ms.map = browser->selection->map;
+				}
+
+				if (!actions->ms.sym)
+					continue;
+			} else {
+				if (symbol__annotation(browser->selection->sym)->src == NULL) {
+					ui_browser__warning(&browser->b, delay_secs * 2,
+						"No samples for the \"%s\" symbol.\n\n"
+						"Probably appeared just in a callchain",
+						browser->selection->sym->name);
+					continue;
+				}
+
+				actions->ms.map = browser->selection->map;
+				actions->ms.sym = browser->selection->sym;
 			}
 
-			actions->ms.map = browser->selection->map;
-			actions->ms.sym = browser->selection->sym;
 			do_annotate(browser, actions);
 			continue;
 		case 'P':
-- 
2.21.1
