From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/53] perf hists: Add argument to hists__resort_cb_t callback
Date: Wed,  6 Feb 2019 15:48:42 -0300
Message-ID: <20190206184903.24054-33-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add argument to hists__resort_cb_t so that we can pass data from upper
layers to the callback function. It will be used in the following
patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c |  8 ++++----
 tools/perf/util/hist.c   | 11 ++++++-----
 tools/perf/util/hist.h   |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b2bf117881f1..efaaab23c6fd 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1970,7 +1970,7 @@ static void calc_width(struct c2c_hist_entry *c2c_he)
 	set_nodestr(c2c_he);
 }
 
-static int filter_cb(struct hist_entry *he)
+static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 
@@ -1987,7 +1987,7 @@ static int filter_cb(struct hist_entry *he)
 	return 0;
 }
 
-static int resort_cl_cb(struct hist_entry *he)
+static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
@@ -2074,7 +2074,7 @@ static int setup_nodes(struct perf_session *session)
 
 #define HAS_HITMS(__h) ((__h)->stats.lcl_hitm || (__h)->stats.rmt_hitm)
 
-static int resort_hitm_cb(struct hist_entry *he)
+static int resort_hitm_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
@@ -2096,7 +2096,7 @@ static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb)
 		struct hist_entry *he;
 
 		he = rb_entry(next, struct hist_entry, rb_node);
-		ret = cb(he);
+		ret = cb(he, NULL);
 		if (ret)
 			break;
 		next = rb_next(&he->rb_node);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7f9df74ab893..64ad603a0592 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1721,7 +1721,8 @@ static void __hists__insert_output_entry(struct rb_root_cached *entries,
 }
 
 static void output_resort(struct hists *hists, struct ui_progress *prog,
-			  bool use_callchain, hists__resort_cb_t cb)
+			  bool use_callchain, hists__resort_cb_t cb,
+			  void *cb_arg)
 {
 	struct rb_root_cached *root;
 	struct rb_node *next;
@@ -1760,7 +1761,7 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
 		n = rb_entry(next, struct hist_entry, rb_node_in);
 		next = rb_next(&n->rb_node_in);
 
-		if (cb && cb(n))
+		if (cb && cb(n, cb_arg))
 			continue;
 
 		__hists__insert_output_entry(&hists->entries, n, min_callchain_hits, use_callchain);
@@ -1785,18 +1786,18 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 
 	use_callchain |= symbol_conf.show_branchflag_count;
 
-	output_resort(evsel__hists(evsel), prog, use_callchain, NULL);
+	output_resort(evsel__hists(evsel), prog, use_callchain, NULL, NULL);
 }
 
 void hists__output_resort(struct hists *hists, struct ui_progress *prog)
 {
-	output_resort(hists, prog, symbol_conf.use_callchain, NULL);
+	output_resort(hists, prog, symbol_conf.use_callchain, NULL, NULL);
 }
 
 void hists__output_resort_cb(struct hists *hists, struct ui_progress *prog,
 			     hists__resort_cb_t cb)
 {
-	output_resort(hists, prog, symbol_conf.use_callchain, cb);
+	output_resort(hists, prog, symbol_conf.use_callchain, cb, NULL);
 }
 
 static bool can_goto_child(struct hist_entry *he, enum hierarchy_move_dir hmd)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6b872079ead5..69a367d4aeaf 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -163,7 +163,7 @@ int hist_entry__snprintf_alignment(struct hist_entry *he, struct perf_hpp *hpp,
 				   struct perf_hpp_fmt *fmt, int printed);
 void hist_entry__delete(struct hist_entry *he);
 
-typedef int (*hists__resort_cb_t)(struct hist_entry *he);
+typedef int (*hists__resort_cb_t)(struct hist_entry *he, void *arg);
 
 void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog);
 void hists__output_resort(struct hists *hists, struct ui_progress *prog);
-- 
2.20.1
