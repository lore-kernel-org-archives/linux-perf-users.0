From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/20] perf report/top: Add menu entry for toggling callchain expansion
Date: Mon,  6 Jan 2020 13:06:56 -0300
Message-ID: <20200106160705.10899-12-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since previously pressing ENTER toggled expansion/collapse of callchain
entries and now brings up the same menu used when callchains are not
present, add an entry so that users can quickly figure out the change in
behaviour.

Its worth mentioning that we also always had 'e'/'c' to expand/collapse
all entries in a hist entry and 'E'/'C' for all hist entries.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f9o03jo29fypvd8ly3j49d36@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index fefa505d4fa8..1b5a5990dddb 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2527,6 +2527,26 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	return 1;
 }
 
+static int do_toggle_callchain(struct hist_browser *browser, struct popup_action *act __maybe_unused)
+{
+	hist_browser__toggle_fold(browser);
+	return 0;
+}
+
+static int add_callchain_toggle_opt(struct hist_browser *browser, struct popup_action *act, char **optstr)
+{
+	struct hist_entry *he = browser->he_selection;
+
+        if (!he->has_children)
+                return 0;
+
+	if (asprintf(optstr, "Expand/Collapse callchain") < 0)
+		return 0;
+
+	act->fn = do_toggle_callchain;
+	return 1;
+}
+
 static int
 do_browse_map(struct hist_browser *browser __maybe_unused,
 	      struct popup_action *act)
@@ -3137,6 +3157,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 					     &options[nr_options], thread);
 		nr_options += add_dso_opt(browser, &actions[nr_options],
 					  &options[nr_options], map);
+		nr_options += add_callchain_toggle_opt(browser, &actions[nr_options], &options[nr_options]);
 		nr_options += add_map_opt(browser, &actions[nr_options],
 					  &options[nr_options],
 					  browser->selection ?
-- 
2.21.1
