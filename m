From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/53] perf report: Move symbol annotation to the resort phase
Date: Wed,  6 Feb 2019 15:48:44 -0300
Message-ID: <20190206184903.24054-35-acme@kernel.org>
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

Currently we make the annotation for the IPC column during the entry
display, already outside of the progress bar scope, so it appears like
'perf report' is stuck.

Move the annotation retrieval to the resort phase, so that all the data
are ready for display.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 21 +++++++++++++++++++--
 tools/perf/util/sort.c      |  7 -------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a007ea9a3874..2e8c74d6430c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -616,6 +616,21 @@ static int report__collapse_hists(struct report *rep)
 	return ret;
 }
 
+static int hists__resort_cb(struct hist_entry *he, void *arg)
+{
+	struct report *rep = arg;
+	struct symbol *sym = he->ms.sym;
+
+	if (rep->symbol_ipc && sym && !sym->annotate2) {
+		struct perf_evsel *evsel = hists_to_evsel(he->hists);
+
+		symbol__annotate2(sym, he->ms.map, evsel,
+				  &annotation__default_options, NULL);
+	}
+
+	return 0;
+}
+
 static void report__output_resort(struct report *rep)
 {
 	struct ui_progress prog;
@@ -623,8 +638,10 @@ static void report__output_resort(struct report *rep)
 
 	ui_progress__init(&prog, rep->nr_entries, "Sorting events for output...");
 
-	evlist__for_each_entry(rep->session->evlist, pos)
-		perf_evsel__output_resort(pos, &prog);
+	evlist__for_each_entry(rep->session->evlist, pos) {
+		perf_evsel__output_resort_cb(pos, &prog,
+					     hists__resort_cb, rep);
+	}
 
 	ui_progress__finish();
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 79e794406bef..2b6c1ccb878c 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -429,8 +429,6 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 {
 
 	struct symbol *sym = he->ms.sym;
-	struct map *map = he->ms.map;
-	struct perf_evsel *evsel = hists_to_evsel(he->hists);
 	struct annotation *notes;
 	double ipc = 0.0, coverage = 0.0;
 	char tmp[64];
@@ -438,11 +436,6 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 	if (!sym)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 
-	if (!sym->annotate2 && symbol__annotate2(sym, map, evsel,
-		&annotation__default_options, NULL) < 0) {
-		return 0;
-	}
-
 	notes = symbol__annotation(sym);
 
 	if (notes->hit_cycles)
-- 
2.20.1
