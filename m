From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/19] perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE]
Date: Mon, 25 Jun 2018 14:40:45 -0300
Message-ID: <20180625174045.25765-20-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

perf_event__process_feature() accesses feat_ops[HEADER_LAST_FEATURE]
which is not defined and thus perf is crashing. HEADER_LAST_FEATURE is
used as an end marker for the perf report but it's unused for perf
script/annotate. Ignore HEADER_LAST_FEATURE for perf script/annotate,
just like it is done in 'perf report'.

Before:
  # perf record -o - ls | perf script
  <SNIP 'ls' output>
  Segmentation fault (core dumped)
  #

After:
  # perf record -o - ls | perf script
  <SNIP 'ls' output>
  Segmentation fault (core dumped)
  ls 7031 4392.099856:  250000 cpu-clock:uhH:  7f5e0ce7cd60
  ls 7031 4392.100355:  250000 cpu-clock:uhH:  7f5e0c706ef7
  #

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 57b5de463925 ("perf report: Support forced leader feature in pipe mode")
Link: http://lkml.kernel.org/r/20180625124220.6434-4-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 11 ++++++++++-
 tools/perf/builtin-report.c   |  3 ++-
 tools/perf/builtin-script.c   | 11 ++++++++++-
 tools/perf/util/header.c      |  2 +-
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5eb22cc56363..8180319285af 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,6 +283,15 @@ static int process_sample_event(struct perf_tool *tool,
 	return ret;
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_evsel *evsel,
 				    struct perf_annotate *ann)
@@ -471,7 +480,7 @@ int cmd_annotate(int argc, const char **argv)
 			.attr	= perf_event__process_attr,
 			.build_id = perf_event__process_build_id,
 			.tracing_data   = perf_event__process_tracing_data,
-			.feature	= perf_event__process_feature,
+			.feature	= process_feature_event,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index cdb5b6949832..c04dc7b53797 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -217,7 +217,8 @@ static int process_feature_event(struct perf_tool *tool,
 	}
 
 	/*
-	 * All features are received, we can force the
+	 * (feat_id = HEADER_LAST_FEATURE) is the end marker which
+	 * means all features are received, now we can force the
 	 * group if needed.
 	 */
 	setup_forced_leader(rep, session->evlist);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ad2ac1300420..568ddfac3213 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3044,6 +3044,15 @@ int process_cpu_map_event(struct perf_tool *tool __maybe_unused,
 	return set_maps(script);
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 static int perf_script__process_auxtrace_info(struct perf_tool *tool,
 					      union perf_event *event,
@@ -3088,7 +3097,7 @@ int cmd_script(int argc, const char **argv)
 			.attr		 = process_attr,
 			.event_update   = perf_event__process_event_update,
 			.tracing_data	 = perf_event__process_tracing_data,
-			.feature	 = perf_event__process_feature,
+			.feature	 = process_feature_event,
 			.build_id	 = perf_event__process_build_id,
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_script__process_auxtrace_info,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 59fcc790c865..653ff65aa2c3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3464,7 +3464,7 @@ int perf_event__process_feature(struct perf_tool *tool,
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return 0;
 	}
-	if (feat == HEADER_RESERVED || feat > HEADER_LAST_FEATURE) {
+	if (feat == HEADER_RESERVED || feat >= HEADER_LAST_FEATURE) {
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return -1;
 	}
-- 
2.14.3
