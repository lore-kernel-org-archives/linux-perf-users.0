From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/77] perf stat: Move create_perf_stat_counter() to stat.c
Date: Wed,  5 Sep 2018 19:03:56 -0300
Message-ID: <20180905220440.20256-34-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move create_perf_stat_counter() to the 'stat' class, so that we can use
it globally.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 54 +----------------------------------------------
 tools/perf/util/stat.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  4 ++++
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 45bbd156d496..142cff8eb12b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -234,58 +234,6 @@ static void perf_stat__reset_stats(void)
 		perf_stat__reset_shadow_per_stat(&stat_config.stats[i]);
 }
 
-static int create_perf_stat_counter(struct perf_evsel *evsel,
-				    struct perf_stat_config *config)
-{
-	struct perf_event_attr *attr = &evsel->attr;
-	struct perf_evsel *leader = evsel->leader;
-
-	if (config->scale) {
-		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
-				    PERF_FORMAT_TOTAL_TIME_RUNNING;
-	}
-
-	/*
-	 * The event is part of non trivial group, let's enable
-	 * the group read (for leader) and ID retrieval for all
-	 * members.
-	 */
-	if (leader->nr_members > 1)
-		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
-
-	attr->inherit = !config->no_inherit;
-
-	/*
-	 * Some events get initialized with sample_(period/type) set,
-	 * like tracepoints. Clear it up for counting.
-	 */
-	attr->sample_period = 0;
-
-	if (config->identifier)
-		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
-
-	/*
-	 * Disabling all counters initially, they will be enabled
-	 * either manually by us or by kernel via enable_on_exec
-	 * set later.
-	 */
-	if (perf_evsel__is_group_leader(evsel)) {
-		attr->disabled = 1;
-
-		/*
-		 * In case of initial_delay we enable tracee
-		 * events manually.
-		 */
-		if (target__none(&target) && !config->initial_delay)
-			attr->enable_on_exec = 1;
-	}
-
-	if (target__has_cpu(&target) && !target__has_per_thread(&target))
-		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
-
-	return perf_evsel__open_per_thread(evsel, evsel->threads);
-}
-
 static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -568,7 +516,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	evlist__for_each_entry(evsel_list, counter) {
 try_again:
-		if (create_perf_stat_counter(counter, &stat_config) < 0) {
+		if (create_perf_stat_counter(counter, &stat_config, &target) < 0) {
 
 			/* Weak group failed. Reset the group. */
 			if ((errno == EINVAL || errno == EBADF) &&
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index a0061e0b0fad..3bd24255376a 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -435,3 +435,56 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 
 	return ret;
 }
+
+int create_perf_stat_counter(struct perf_evsel *evsel,
+			     struct perf_stat_config *config,
+			     struct target *target)
+{
+	struct perf_event_attr *attr = &evsel->attr;
+	struct perf_evsel *leader = evsel->leader;
+
+	if (config->scale) {
+		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+				    PERF_FORMAT_TOTAL_TIME_RUNNING;
+	}
+
+	/*
+	 * The event is part of non trivial group, let's enable
+	 * the group read (for leader) and ID retrieval for all
+	 * members.
+	 */
+	if (leader->nr_members > 1)
+		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
+
+	attr->inherit = !config->no_inherit;
+
+	/*
+	 * Some events get initialized with sample_(period/type) set,
+	 * like tracepoints. Clear it up for counting.
+	 */
+	attr->sample_period = 0;
+
+	if (config->identifier)
+		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
+
+	/*
+	 * Disabling all counters initially, they will be enabled
+	 * either manually by us or by kernel via enable_on_exec
+	 * set later.
+	 */
+	if (perf_evsel__is_group_leader(evsel)) {
+		attr->disabled = 1;
+
+		/*
+		 * In case of initial_delay we enable tracee
+		 * events manually.
+		 */
+		if (target__none(target) && !config->initial_delay)
+			attr->enable_on_exec = 1;
+	}
+
+	if (target__has_cpu(target) && !target__has_per_thread(target))
+		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
+
+	return perf_evsel__open_per_thread(evsel, evsel->threads);
+}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 918cde064cdc..8fb596641545 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -175,4 +175,8 @@ int perf_event__process_stat_event(struct perf_tool *tool,
 size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
+
+int create_perf_stat_counter(struct perf_evsel *evsel,
+			     struct perf_stat_config *config,
+			     struct target *target);
 #endif
-- 
2.14.4
