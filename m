From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/11] perf record: Synthesize unit/scale/... in event update
Date: Fri, 24 Nov 2017 12:02:26 -0300
Message-ID: <20171124150232.18676-6-acme@kernel.org>
References: <20171124150232.18676-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171124150232.18676-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Move the code to synthesize event updates for scale/unit/cpus to a
common utility file, and use it both from stat and record.

This allows to access scale and other extra qualifiers from perf script.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171117214300.32746-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  9 ++++++
 tools/perf/builtin-stat.c   | 62 +++--------------------------------------
 tools/perf/util/header.c    | 68 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h    |  5 ++++
 4 files changed, 86 insertions(+), 58 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 003255910c05..b92d6d67bca8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -372,6 +372,8 @@ static int record__open(struct record *rec)
 			ui__error("%s\n", msg);
 			goto out;
 		}
+
+		pos->supported = true;
 	}
 
 	if (perf_evlist__apply_filters(evlist, &pos)) {
@@ -784,6 +786,13 @@ static int record__synthesize(struct record *rec, bool tail)
 					 perf_event__synthesize_guest_os, tool);
 	}
 
+	err = perf_event__synthesize_extra_attr(&rec->tool,
+						rec->evlist,
+						process_synthesized_event,
+						data->is_pipe);
+	if (err)
+		goto out;
+
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,
 					    opts->proc_map_timeout, 1);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 59af5a8419e2..a027b4712e48 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -458,19 +458,8 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static bool has_unit(struct perf_evsel *counter)
-{
-	return counter->unit && *counter->unit;
-}
-
-static bool has_scale(struct perf_evsel *counter)
-{
-	return counter->scale != 1;
-}
-
 static int perf_stat_synthesize_config(bool is_pipe)
 {
-	struct perf_evsel *counter;
 	int err;
 
 	if (is_pipe) {
@@ -482,53 +471,10 @@ static int perf_stat_synthesize_config(bool is_pipe)
 		}
 	}
 
-	/*
-	 * Synthesize other events stuff not carried within
-	 * attr event - unit, scale, name
-	 */
-	evlist__for_each_entry(evsel_list, counter) {
-		if (!counter->supported)
-			continue;
-
-		/*
-		 * Synthesize unit and scale only if it's defined.
-		 */
-		if (has_unit(counter)) {
-			err = perf_event__synthesize_event_update_unit(NULL, counter, process_synthesized_event);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel unit.\n");
-				return err;
-			}
-		}
-
-		if (has_scale(counter)) {
-			err = perf_event__synthesize_event_update_scale(NULL, counter, process_synthesized_event);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel scale.\n");
-				return err;
-			}
-		}
-
-		if (counter->own_cpus) {
-			err = perf_event__synthesize_event_update_cpus(NULL, counter, process_synthesized_event);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel scale.\n");
-				return err;
-			}
-		}
-
-		/*
-		 * Name is needed only for pipe output,
-		 * perf.data carries event names.
-		 */
-		if (is_pipe) {
-			err = perf_event__synthesize_event_update_name(NULL, counter, process_synthesized_event);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel name.\n");
-				return err;
-			}
-		}
-	}
+	err = perf_event__synthesize_extra_attr(NULL,
+						evsel_list,
+						process_synthesized_event,
+						is_pipe);
 
 	err = perf_event__synthesize_thread_map2(NULL, evsel_list->threads,
 						process_synthesized_event,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7c0e9d587bfa..5890e08e0754 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3258,6 +3258,74 @@ int perf_event__synthesize_attrs(struct perf_tool *tool,
 	return err;
 }
 
+static bool has_unit(struct perf_evsel *counter)
+{
+	return counter->unit && *counter->unit;
+}
+
+static bool has_scale(struct perf_evsel *counter)
+{
+	return counter->scale != 1;
+}
+
+int perf_event__synthesize_extra_attr(struct perf_tool *tool,
+				      struct perf_evlist *evsel_list,
+				      perf_event__handler_t process,
+				      bool is_pipe)
+{
+	struct perf_evsel *counter;
+	int err;
+
+	/*
+	 * Synthesize other events stuff not carried within
+	 * attr event - unit, scale, name
+	 */
+	evlist__for_each_entry(evsel_list, counter) {
+		if (!counter->supported)
+			continue;
+
+		/*
+		 * Synthesize unit and scale only if it's defined.
+		 */
+		if (has_unit(counter)) {
+			err = perf_event__synthesize_event_update_unit(tool, counter, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel unit.\n");
+				return err;
+			}
+		}
+
+		if (has_scale(counter)) {
+			err = perf_event__synthesize_event_update_scale(tool, counter, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel counter.\n");
+				return err;
+			}
+		}
+
+		if (counter->own_cpus) {
+			err = perf_event__synthesize_event_update_cpus(tool, counter, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel cpus.\n");
+				return err;
+			}
+		}
+
+		/*
+		 * Name is needed only for pipe output,
+		 * perf.data carries event names.
+		 */
+		if (is_pipe) {
+			err = perf_event__synthesize_event_update_name(tool, counter, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel name.\n");
+				return err;
+			}
+		}
+	}
+	return 0;
+}
+
 int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_evlist **pevlist)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 29ccbfdf8724..91befc3b550d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -107,6 +107,11 @@ int perf_event__synthesize_features(struct perf_tool *tool,
 				    struct perf_evlist *evlist,
 				    perf_event__handler_t process);
 
+int perf_event__synthesize_extra_attr(struct perf_tool *tool,
+				      struct perf_evlist *evsel_list,
+				      perf_event__handler_t process,
+				      bool is_pipe);
+
 int perf_event__process_feature(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_session *session);
-- 
2.13.6
