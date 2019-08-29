From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/37] perf top: Decay all events in the evlist
Date: Thu, 29 Aug 2019 11:38:50 -0300
Message-ID: <20190829143917.29745-11-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Currently perf top only decays entries in a selected evsel.  I don't
know whether it's intended (maybe due to performance reason?) but anyway
it might show incorrect output when event group is used since users will
see leader event is decayed but others are not.

This patch moves the decay code into perf_top__resort_hists() so that
stdio and TUI code shared the logic.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190827231555.121411-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 42ba733c9045..104dbb1095c5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -265,13 +265,23 @@ static void perf_top__show_details(struct perf_top *top)
 	pthread_mutex_unlock(&notes->lock);
 }
 
-static void evlist__resort_hists(struct evlist *evlist)
+static void perf_top__resort_hists(struct perf_top *t)
 {
+	struct evlist *evlist = t->evlist;
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
+		if (evlist->enabled) {
+			if (t->zero) {
+				hists__delete_entries(hists);
+			} else {
+				hists__decay_entries(hists, t->hide_user_symbols,
+						     t->hide_kernel_symbols);
+			}
+		}
+
 		hists__collapse_resort(hists, NULL);
 
 		/* Non-group events are considered as leader */
@@ -320,16 +330,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 		return;
 	}
 
-	if (top->evlist->enabled) {
-		if (top->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, top->hide_user_symbols,
-					     top->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(top->evlist);
+	perf_top__resort_hists(top);
 
 	hists__output_recalc_col_len(hists, top->print_entries - printed);
 	putchar('\n');
@@ -577,24 +578,11 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 static void perf_top__sort_new_samples(void *arg)
 {
 	struct perf_top *t = arg;
-	struct evsel *evsel = t->sym_evsel;
-	struct hists *hists;
 
 	if (t->evlist->selected != NULL)
 		t->sym_evsel = t->evlist->selected;
 
-	hists = evsel__hists(evsel);
-
-	if (t->evlist->enabled) {
-		if (t->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, t->hide_user_symbols,
-					     t->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(t->evlist);
+	perf_top__resort_hists(t);
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-- 
2.21.0
