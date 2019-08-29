From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/37] perf top: Fix event group with more than two events
Date: Thu, 29 Aug 2019 11:38:51 -0300
Message-ID: <20190829143917.29745-12-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The event group feature links relevant hist entries among events so that
they can be displayed together.  During the link process, each hist
entry in non-leader events is connected to a hist entry in the leader
event.  This is done in order of events specified in the command line so
it assumes that events are linked in the order.

But 'perf top' can break the assumption since it does the link process
multiple times.  For example, a hist entry can be in the third event
only at first so it's linked after the leader.  Some time later, second
event has a hist entry for it and it'll be linked after the entry of the
third event.

This makes the code compilicated to deal with such unordered entries.
This patch simply unlink all the entries after it's printed so that they
can assume the correct order after the repeated link process.  Also it'd
be easy to deal with decaying old entries IMHO.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190827231555.121411-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c |  6 ++++++
 tools/perf/util/hist.c   | 39 +++++++++++++++++++++------------------
 tools/perf/util/hist.h   |  1 +
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 104dbb1095c5..c3f95440e99c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -273,6 +273,12 @@ static void perf_top__resort_hists(struct perf_top *t)
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
+		/*
+		 * unlink existing entries so that they can be linked
+		 * in a correct order in hists__match() below.
+		 */
+		hists__unlink(hists);
+
 		if (evlist->enabled) {
 			if (t->zero) {
 				hists__delete_entries(hists);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 33702675073c..e0b149673a88 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2439,7 +2439,7 @@ void hists__match(struct hists *leader, struct hists *other)
 {
 	struct rb_root_cached *root;
 	struct rb_node *nd;
-	struct hist_entry *pos, *pair, *pos_pair, *tmp_pair;
+	struct hist_entry *pos, *pair;
 
 	if (symbol_conf.report_hierarchy) {
 		/* hierarchy report always collapses entries */
@@ -2456,24 +2456,8 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair && list_empty(&pair->pairs.node)) {
-			list_for_each_entry_safe(pos_pair, tmp_pair, &pos->pairs.head, pairs.node) {
-				if (pos_pair->hists == other) {
-					/*
-					 * XXX maybe decayed entries can appear
-					 * here?  but then we would have use
-					 * after free, as decayed entries are
-					 * freed see hists__delete_entry
-					 */
-					BUG_ON(!pos_pair->dummy);
-					list_del_init(&pos_pair->pairs.node);
-					hist_entry__delete(pos_pair);
-					break;
-				}
-			}
-
+		if (pair)
 			hist_entry__add_pair(pair, pos);
-		}
 	}
 }
 
@@ -2558,6 +2542,25 @@ int hists__link(struct hists *leader, struct hists *other)
 	return 0;
 }
 
+int hists__unlink(struct hists *hists)
+{
+	struct rb_root_cached *root;
+	struct rb_node *nd;
+	struct hist_entry *pos;
+
+	if (hists__has(hists, need_collapse))
+		root = &hists->entries_collapsed;
+	else
+		root = hists->entries_in;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		pos = rb_entry(nd, struct hist_entry, rb_node_in);
+		list_del_init(&pos->pairs.node);
+	}
+
+	return 0;
+}
+
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode)
 {
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 83d5fc15429c..7b9267ebebeb 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -217,6 +217,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *he);
 
 void hists__match(struct hists *leader, struct hists *other);
 int hists__link(struct hists *leader, struct hists *other);
+int hists__unlink(struct hists *hists);
 
 struct hists_evsel {
 	struct evsel evsel;
-- 
2.21.0
