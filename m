From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/5] perf callchains: Ask for PERF_RECORD_MMAP for data mmaps for DWARF unwinding
Date: Tue, 16 Jan 2018 11:24:38 -0300
Message-ID: <20180116142438.19520-6-acme@kernel.org>
References: <20180116142438.19520-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116142438.19520-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Noel Grandin <noelgrandin@gmail.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we use a global DWARF setting as in:

	perf record --call-graph dwarf

According to 5c0cf22477ea ("perf record: Store data mmaps for dwarf unwind") we need
to set up some extra perf_event_attr bits.

But when we instead do a per event dwarf setting:

	perf record -e cycles/call-graph=dwarf/

This was not being done, make them equivalent.

This didn't produce any output changes in my tests while fixing up loose
ends in the per-event settings, I found it just by comparing the
perf_event_attr fields trying to find an explanation for those problems.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Noel Grandin <noelgrandin@gmail.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-k26j3srv1pjbvwtak2c6yljc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8f971a2301d1..85eb84dfdf91 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -726,7 +726,7 @@ perf_evsel__reset_callgraph(struct perf_evsel *evsel,
 }
 
 static void apply_config_terms(struct perf_evsel *evsel,
-			       struct record_opts *opts)
+			       struct record_opts *opts, bool track)
 {
 	struct perf_evsel_config_term *term;
 	struct list_head *config_terms = &evsel->config_terms;
@@ -797,6 +797,8 @@ static void apply_config_terms(struct perf_evsel *evsel,
 
 	/* User explicitly set per-event callgraph, clear the old setting and reset. */
 	if ((callgraph_buf != NULL) || (dump_size > 0) || max_stack) {
+		bool sample_address = false;
+
 		if (max_stack) {
 			param.max_stack = max_stack;
 			if (callgraph_buf == NULL)
@@ -816,6 +818,8 @@ static void apply_config_terms(struct perf_evsel *evsel,
 					       evsel->name);
 					return;
 				}
+				if (param.record_mode == CALLCHAIN_DWARF)
+					sample_address = true;
 			}
 		}
 		if (dump_size > 0) {
@@ -828,8 +832,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			perf_evsel__reset_callgraph(evsel, &callchain_param);
 
 		/* set perf-event callgraph */
-		if (param.enabled)
+		if (param.enabled) {
+			if (sample_address) {
+				perf_evsel__set_sample_bit(evsel, ADDR);
+				perf_evsel__set_sample_bit(evsel, DATA_SRC);
+				evsel->attr.mmap_data = track;
+			}
 			perf_evsel__config_callchain(evsel, opts, &param);
+		}
 	}
 }
 
@@ -1060,7 +1070,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	 * Apply event specific term settings,
 	 * it overloads any global configuration.
 	 */
-	apply_config_terms(evsel, opts);
+	apply_config_terms(evsel, opts, track);
 
 	evsel->ignore_missing_thread = opts->ignore_missing_thread;
 }
-- 
2.14.3
