From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/12] perf report/top: Make 'e' visible in the help and make it toggle showing callchains
Date: Tue, 17 Dec 2019 11:48:27 -0300
Message-ID: <20191217144828.2460-12-acme@kernel.org>
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

The 'e' and 'c' hotkeys were present for a long time, but not documented
in the help window, change 'e' to be a toggle so that it gets consistent
with other toggles like '+' and document it in the help window.

Keep 'c' as is for people used to it but don't document, as it is easier
to just use 'e' to show/hide all the callchains for a top level
histogram entry.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-84s2zp381n4vquc1byexania@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3f10e1a070c5..fa3a16c49398 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -407,6 +407,11 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
 	return container_of(ms, struct callchain_list, ms)->has_children;
 }
 
+static bool hist_browser__he_selection_unfolded(struct hist_browser *browser)
+{
+	return browser->he_selection ? browser->he_selection->unfolded : false;
+}
+
 static bool hist_browser__selection_unfolded(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -750,7 +755,7 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 			break;
 		case 'e':
 			/* Expand the selected entry. */
-			hist_browser__set_folding_selected(browser, true);
+			hist_browser__set_folding_selected(browser, !hist_browser__he_selection_unfolded(browser));
 			break;
 		case 'H':
 			browser->show_headers = !browser->show_headers;
@@ -2938,6 +2943,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"a             Annotate current symbol\n"			\
 	"C             Collapse all callchains\n"			\
 	"d             Zoom into current DSO\n"				\
+	"e             Expand/Collapse main entry callchains\n"	\
 	"E             Expand all callchains\n"				\
 	"F             Toggle percentage of filtered entries\n"		\
 	"H             Display column headers\n"			\
-- 
2.21.0
