From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 60/91] perf evsel: Rename perf_evsel__*filter*() to evsel__*filter*()
Date: Wed,  6 May 2020 12:22:03 -0300
Message-ID: <20200506152234.21977-61-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those are not 'struct evsel' methods, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c     |  7 +++----
 tools/perf/util/auxtrace.c     |  6 +++---
 tools/perf/util/evlist.c       |  4 ++--
 tools/perf/util/evsel.c        | 15 +++++++--------
 tools/perf/util/evsel.h        |  7 +++----
 tools/perf/util/parse-events.c |  6 +++---
 6 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1411e2735855..12b770abb87a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3164,10 +3164,9 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 	if (filter == NULL)
 		goto out_enomem;
 
-	if (!perf_evsel__append_tp_filter(trace->syscalls.events.sys_enter,
-					  filter)) {
+	if (!evsel__append_tp_filter(trace->syscalls.events.sys_enter, filter)) {
 		sys_exit = trace->syscalls.events.sys_exit;
-		err = perf_evsel__append_tp_filter(sys_exit, filter);
+		err = evsel__append_tp_filter(sys_exit, filter);
 	}
 
 	free(filter);
@@ -3801,7 +3800,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 	if (new_filter != evsel->filter) {
 		pr_debug("New filter for %s: %s\n", evsel->name, new_filter);
-		perf_evsel__set_filter(evsel, new_filter);
+		evsel__set_filter(evsel, new_filter);
 		free(new_filter);
 	}
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e12696fe6f65..c22ef2e3e079 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2522,7 +2522,7 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
 			goto out_exit;
 		}
 
-		if (perf_evsel__append_addr_filter(evsel, new_filter)) {
+		if (evsel__append_addr_filter(evsel, new_filter)) {
 			err = -ENOMEM;
 			goto out_exit;
 		}
@@ -2540,7 +2540,7 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
 	return err;
 }
 
-static int perf_evsel__nr_addr_filter(struct evsel *evsel)
+static int evsel__nr_addr_filter(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 	int nr_addr_filters = 0;
@@ -2561,7 +2561,7 @@ int auxtrace_parse_filters(struct evlist *evlist)
 
 	evlist__for_each_entry(evlist, evsel) {
 		filter = evsel->filter;
-		max_nr = perf_evsel__nr_addr_filter(evsel);
+		max_nr = evsel__nr_addr_filter(evsel);
 		if (!filter || !max_nr)
 			continue;
 		evsel->filter = NULL;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 58228a54ecd7..410cd834c39a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -995,7 +995,7 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 
-		err = perf_evsel__set_filter(evsel, filter);
+		err = evsel__set_filter(evsel, filter);
 		if (err)
 			break;
 	}
@@ -1015,7 +1015,7 @@ int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 
-		err = perf_evsel__append_tp_filter(evsel, filter);
+		err = evsel__append_tp_filter(evsel, filter);
 		if (err)
 			break;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f03500253e3..4f271764cbf2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1166,7 +1166,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
+int evsel__set_filter(struct evsel *evsel, const char *filter)
 {
 	char *new_filter = strdup(filter);
 
@@ -1179,13 +1179,12 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
 	return -1;
 }
 
-static int perf_evsel__append_filter(struct evsel *evsel,
-				     const char *fmt, const char *filter)
+static int evsel__append_filter(struct evsel *evsel, const char *fmt, const char *filter)
 {
 	char *new_filter;
 
 	if (evsel->filter == NULL)
-		return perf_evsel__set_filter(evsel, filter);
+		return evsel__set_filter(evsel, filter);
 
 	if (asprintf(&new_filter, fmt, evsel->filter, filter) > 0) {
 		free(evsel->filter);
@@ -1196,14 +1195,14 @@ static int perf_evsel__append_filter(struct evsel *evsel,
 	return -1;
 }
 
-int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter)
+int evsel__append_tp_filter(struct evsel *evsel, const char *filter)
 {
-	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
+	return evsel__append_filter(evsel, "(%s) && (%s)", filter);
 }
 
-int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
+int evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 {
-	return perf_evsel__append_filter(evsel, "%s,%s", filter);
+	return evsel__append_filter(evsel, "%s,%s", filter);
 }
 
 /* Caller has to clear disabled after going through all CPUs. */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ecd3ea89e12c..df64d89cd916 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -225,10 +225,9 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
 
 void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
-int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
-int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-int perf_evsel__append_addr_filter(struct evsel *evsel,
-				   const char *filter);
+int evsel__set_filter(struct evsel *evsel, const char *filter);
+int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
+int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
 int evsel__enable_cpu(struct evsel *evsel, int cpu);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2252f494ff9f..899ced466197 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2261,7 +2261,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 	}
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
-		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
+		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
 				"not enough memory to hold filter string\n");
 			return -1;
@@ -2286,7 +2286,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
+	if (evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
@@ -2317,7 +2317,7 @@ static int add_exclude_perf_filter(struct evsel *evsel,
 
 	snprintf(new_filter, sizeof(new_filter), "common_pid != %d", getpid());
 
-	if (perf_evsel__append_tp_filter(evsel, new_filter) < 0) {
+	if (evsel__append_tp_filter(evsel, new_filter) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
-- 
2.21.1
