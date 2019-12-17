From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/12] perf hists browser: Allow passing an initial hotkey
Date: Tue, 17 Dec 2019 11:48:23 -0300
Message-ID: <20191217144828.2460-8-acme@kernel.org>
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

Sometimes we're in an outer code, like the main hists browser popup menu
and the user follows a suggestion about using some hotkey, and that
hotkey is really handled by hists_browser__run(), so allow for calling
it with that hotkey, making it handle it instead of waiting for the user
to press one.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-i0kwpuicoy4p1tyrw5k054zq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c       |  4 ++--
 tools/perf/ui/browsers/hists.c | 13 +++++++------
 tools/perf/ui/browsers/hists.h |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e69f44941aad..346351260c0b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2384,7 +2384,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 's':
@@ -2453,7 +2453,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6dfdd8d5a743..3b7af5a8d101 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -673,9 +673,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 }
 
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event)
+		      bool warn_lost_event, int key)
 {
-	int key;
 	char title[160];
 	struct hist_browser_timer *hbt = browser->hbt;
 	int delay_secs = hbt ? hbt->refresh : 0;
@@ -688,9 +687,12 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
 		return -1;
 
+	if (key)
+		goto do_hotkey;
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
-
+do_hotkey:
 		switch (key) {
 		case K_TIMER: {
 			u64 nr_entries;
@@ -2994,8 +2996,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 
 		nr_options = 0;
 
-		key = hist_browser__run(browser, helpline,
-					warn_lost_event);
+		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3573,7 +3574,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
 	memset(&action, 0, sizeof(action));
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index 078f2f2c7abd..1e938d9ffa5e 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -34,7 +34,7 @@ struct hist_browser {
 struct hist_browser *hist_browser__new(struct hists *hists);
 void hist_browser__delete(struct hist_browser *browser);
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event);
+		      bool warn_lost_event, int key);
 void hist_browser__init(struct hist_browser *browser,
 			struct hists *hists);
 #endif /* _PERF_UI_BROWSER_HISTS_H_ */
-- 
2.21.0
