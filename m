From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/28] perf hist: Remove dummy entries when finding real ones.
Date: Wed, 14 Aug 2019 15:40:33 -0300
Message-ID: <20190814184051.3125-11-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When he have an event group we have multiple struct hist instances, one
per evsel, and in each of these hists we may have hist_entries that
point to the same thing being observed, say a symbol, i.e. if we're
looking at instructions and cycles, then we'll have one hist_entry in
the "instructions" evsel and another in the "cycles" evsel.

We need to link those to then show one column for each. When we're
looking at some other pair of events, say instructions and cache misses,
we may have just the "instructions" hist entry and not one for "cache
misses", as instructions not necessarily generate cache misses, as the
logic expects one hist_entry per evsel, we end up adding "dummy"
hist_entries.

This is enough for 'perf report', that does this matching operation
(hists__match()) just once after processing all events, but for 'perf
top', we do this at each refresh, so we may finally find events matching
and then we need to trow away the dummies and link with the real events.

So if we find a match, traverse the link of matches and trow away
dummies for that hists.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dwvtjqqifsbsczeb35q6mqkk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index d923a5bb7b48..8efbf58dc3d0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2436,7 +2436,7 @@ void hists__match(struct hists *leader, struct hists *other)
 {
 	struct rb_root_cached *root;
 	struct rb_node *nd;
-	struct hist_entry *pos, *pair;
+	struct hist_entry *pos, *pair, *pos_pair, *tmp_pair;
 
 	if (symbol_conf.report_hierarchy) {
 		/* hierarchy report always collapses entries */
@@ -2453,8 +2453,24 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair && list_empty(&pair->pairs.node))
+		if (pair && list_empty(&pair->pairs.node)) {
+			list_for_each_entry_safe(pos_pair, tmp_pair, &pos->pairs.head, pairs.node) {
+				if (pos_pair->hists == other) {
+					/*
+					 * XXX maybe decayed entries can appear
+					 * here?  but then we would have use
+					 * after free, as decayed entries are
+					 * freed see hists__delete_entry
+					 */
+					BUG_ON(!pos_pair->dummy);
+					list_del_init(&pos_pair->pairs.node);
+					hist_entry__delete(pos_pair);
+					break;
+				}
+			}
+
 			hist_entry__add_pair(pair, pos);
+		}
 	}
 }
 
-- 
2.21.0
