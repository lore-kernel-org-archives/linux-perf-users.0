From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/77] perf stat: Move perf_stat_synthesize_config() to stat.c
Date: Wed,  5 Sep 2018 19:04:02 -0300
Message-ID: <20180905220440.20256-40-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that it can be used globally.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 42 ------------------------------------------
 tools/perf/util/stat.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  6 ++++++
 3 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1171d4e00276..54768ec15dbc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -402,48 +402,6 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static int perf_stat_synthesize_config(struct perf_stat_config *config,
-				       struct perf_tool *tool,
-				       struct perf_evlist *evlist,
-				       perf_event__handler_t process,
-				       bool attrs)
-{
-	int err;
-
-	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evlist, process);
-		if (err < 0) {
-			pr_err("Couldn't synthesize attrs.\n");
-			return err;
-		}
-	}
-
-	err = perf_event__synthesize_extra_attr(tool, evlist, process,
-						attrs);
-
-	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
-						 process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize thread map.\n");
-		return err;
-	}
-
-	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
-					     process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize thread map.\n");
-		return err;
-	}
-
-	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize config.\n");
-		return err;
-	}
-
-	return 0;
-}
-
 static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 {
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 3bd24255376a..5d3172bcc4ae 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -488,3 +488,45 @@ int create_perf_stat_counter(struct perf_evsel *evsel,
 
 	return perf_evsel__open_per_thread(evsel, evsel->threads);
 }
+
+int perf_stat_synthesize_config(struct perf_stat_config *config,
+				struct perf_tool *tool,
+				struct perf_evlist *evlist,
+				perf_event__handler_t process,
+				bool attrs)
+{
+	int err;
+
+	if (attrs) {
+		err = perf_event__synthesize_attrs(tool, evlist, process);
+		if (err < 0) {
+			pr_err("Couldn't synthesize attrs.\n");
+			return err;
+		}
+	}
+
+	err = perf_event__synthesize_extra_attr(tool, evlist, process,
+						attrs);
+
+	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
+						 process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize thread map.\n");
+		return err;
+	}
+
+	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
+					     process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize thread map.\n");
+		return err;
+	}
+
+	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize config.\n");
+		return err;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 8fb596641545..da6a706daecc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -7,6 +7,7 @@
 #include "xyarray.h"
 #include "rblist.h"
 #include "perf.h"
+#include "event.h"
 
 struct stats {
 	double n, mean, M2;
@@ -179,4 +180,9 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 int create_perf_stat_counter(struct perf_evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target);
+int perf_stat_synthesize_config(struct perf_stat_config *config,
+				struct perf_tool *tool,
+				struct perf_evlist *evlist,
+				perf_event__handler_t process,
+				bool attrs);
 #endif
-- 
2.14.4
