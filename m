From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/12] perf report/top: Make ENTER consistently bring up menu
Date: Tue, 17 Dec 2019 11:48:18 -0300
Message-ID: <20191217144828.2460-3-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When callchains are present the ENTER key switches from bringing up the
menu that offers Annotation, Zoom by DSO, etc to expanding/collapsing
one callchain level, causing confusion, fix it by making it consistently
bring up the menu and use '+' to expand/collapse one callchain level.

Next patch will also add an entry to the menu to allow
expanding/collapsing, so that people used to ENTER expanding one
callchain level can quickly find it and use it instead.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bjz35omktig8cwn6lbj1ifns@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index cfc6172ecab7..fefa505d4fa8 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -706,7 +706,7 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 			browser->show_headers = !browser->show_headers;
 			hist_browser__update_rows(browser);
 			break;
-		case K_ENTER:
+		case '+':
 			if (hist_browser__toggle_fold(browser))
 				break;
 			/* fall thru */
@@ -2858,6 +2858,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"For symbolic views (--sort has sym):\n\n"			\
 	"ENTER         Zoom into DSO/Threads & Annotate current symbol\n" \
 	"ESC           Zoom out\n"					\
+	"+             Expand/Collapse one callchain level\n"		\
 	"a             Annotate current symbol\n"			\
 	"C             Collapse all callchains\n"			\
 	"d             Zoom into current DSO\n"				\
-- 
2.21.0
