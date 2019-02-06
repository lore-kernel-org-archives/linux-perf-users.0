From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/53] perf evsel: Add output_resort_cb method
Date: Wed,  6 Feb 2019 15:48:43 -0300
Message-ID: <20190206184903.24054-34-acme@kernel.org>
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

Add perf_evsel__output_resort_cb() so we have an interface with a
callback for each hist entry. It will be used in the following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 10 ++++++++--
 tools/perf/util/hist.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 64ad603a0592..669f961316f0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1775,7 +1775,8 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
 	}
 }
 
-void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog)
+void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+				  hists__resort_cb_t cb, void *cb_arg)
 {
 	bool use_callchain;
 
@@ -1786,7 +1787,12 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 
 	use_callchain |= symbol_conf.show_branchflag_count;
 
-	output_resort(evsel__hists(evsel), prog, use_callchain, NULL, NULL);
+	output_resort(evsel__hists(evsel), prog, use_callchain, cb, cb_arg);
+}
+
+void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog)
+{
+	return perf_evsel__output_resort_cb(evsel, prog, NULL, NULL);
 }
 
 void hists__output_resort(struct hists *hists, struct ui_progress *prog)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 69a367d4aeaf..4af27fbab24f 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -165,6 +165,8 @@ void hist_entry__delete(struct hist_entry *he);
 
 typedef int (*hists__resort_cb_t)(struct hist_entry *he, void *arg);
 
+void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+				  hists__resort_cb_t cb, void *cb_arg);
 void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog);
 void hists__output_resort(struct hists *hists, struct ui_progress *prog);
 void hists__output_resort_cb(struct hists *hists, struct ui_progress *prog,
-- 
2.20.1
