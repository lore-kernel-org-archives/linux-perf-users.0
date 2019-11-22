From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/26] perf util: Move block TUI function to ui browsers
Date: Fri, 22 Nov 2019 11:56:52 -0300
Message-ID: <20191122145711.3171-8-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

It would be nice if we could jump to the assembler/source view (like the
normal perf report) from total cycles view.

This patch moves the block_hists_tui_browse from block-info.c to
ui/browsers/hists.c in order to reuse some browser codes (i.e
do_annotate) for implementing new annotation view.

 v2:
 ---
 Fix the 'make NO_SLANG=1' error. (Change 'int block_hists_tui_browse()'
 to 'static inline int block_hists_tui_browse()')

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191118140849.20714-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 55 ++++++++++++++++++++++++++++
 tools/perf/util/block-info.c   | 65 +---------------------------------
 tools/perf/util/hist.h         | 12 +++++++
 3 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 4d2d0acfd41a..87405dc4750c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3444,3 +3444,58 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
 					       warn_lost_event,
 					       annotation_opts);
 }
+
+static int block_hists_browser__title(struct hist_browser *browser, char *bf,
+				      size_t size)
+{
+	struct hists *hists = evsel__hists(browser->block_evsel);
+	const char *evname = perf_evsel__name(browser->block_evsel);
+	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	int ret;
+
+	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
+	if (evname)
+		scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
+
+	return 0;
+}
+
+int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
+			   float min_percent)
+{
+	struct hists *hists = &bh->block_hists;
+	struct hist_browser *browser;
+	int key = -1;
+	static const char help[] =
+	" q             Quit \n";
+
+	browser = hist_browser__new(hists);
+	if (!browser)
+		return -1;
+
+	browser->block_evsel = evsel;
+	browser->title = block_hists_browser__title;
+	browser->min_pcnt = min_percent;
+
+	/* reset abort key so that it can get Ctrl-C as a key */
+	SLang_reset_tty();
+	SLang_init_tty(0, 0, 0);
+
+	while (1) {
+		key = hist_browser__run(browser, "? - help", true);
+
+		switch (key) {
+		case 'q':
+			goto out;
+		case '?':
+			ui_browser__help_window(&browser->b, help);
+			break;
+		default:
+			break;
+		}
+	}
+
+out:
+	hist_browser__delete(browser);
+	return 0;
+}
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 9abc201ebe63..5887f8f9149f 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -10,6 +10,7 @@
 #include "map.h"
 #include "srcline.h"
 #include "evlist.h"
+#include "hist.h"
 #include "ui/browsers/hists.h"
 
 static struct block_header_column {
@@ -439,70 +440,6 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 	return block_reports;
 }
 
-#ifdef HAVE_SLANG_SUPPORT
-static int block_hists_browser__title(struct hist_browser *browser, char *bf,
-				      size_t size)
-{
-	struct hists *hists = evsel__hists(browser->block_evsel);
-	const char *evname = perf_evsel__name(browser->block_evsel);
-	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
-	int ret;
-
-	ret = scnprintf(bf, size, "# Samples: %lu", nr_samples);
-	if (evname)
-		scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
-
-	return 0;
-}
-
-static int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
-				  float min_percent)
-{
-	struct hists *hists = &bh->block_hists;
-	struct hist_browser *browser;
-	int key = -1;
-	static const char help[] =
-	" q             Quit \n";
-
-	browser = hist_browser__new(hists);
-	if (!browser)
-		return -1;
-
-	browser->block_evsel = evsel;
-	browser->title = block_hists_browser__title;
-	browser->min_pcnt = min_percent;
-
-	/* reset abort key so that it can get Ctrl-C as a key */
-	SLang_reset_tty();
-	SLang_init_tty(0, 0, 0);
-
-	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
-
-		switch (key) {
-		case 'q':
-			goto out;
-		case '?':
-			ui_browser__help_window(&browser->b, help);
-			break;
-		default:
-			break;
-		}
-	}
-
-out:
-	hist_browser__delete(browser);
-	return 0;
-}
-#else
-static int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
-				  struct evsel *evsel __maybe_unused,
-				  float min_percent __maybe_unused)
-{
-	return 0;
-}
-#endif
-
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel)
 {
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4d87c7b4c1b2..2aca8ce16b2c 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -449,6 +449,8 @@ enum rstype {
 	A_SOURCE
 };
 
+struct block_hist;
+
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
@@ -474,6 +476,9 @@ void run_script(char *cmd);
 int res_sample_browse(struct res_sample *res_samples, int num_res,
 		      struct evsel *evsel, enum rstype rstype);
 void res_sample_init(void);
+
+int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
+			   float min_percent);
 #else
 static inline
 int perf_evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
@@ -518,6 +523,13 @@ static inline int res_sample_browse(struct res_sample *res_samples __maybe_unuse
 
 static inline void res_sample_init(void) {}
 
+static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
+					 struct evsel *evsel __maybe_unused,
+					 float min_percent __maybe_unused)
+{
+	return 0;
+}
+
 #define K_LEFT  -1000
 #define K_RIGHT -2000
 #define K_SWITCH_INPUT_DATA -3000
-- 
2.21.0
