From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/77] perf stat: Pass 'evlist' argument to print functions
Date: Wed,  5 Sep 2018 19:04:13 -0300
Message-ID: <20180905220440.20256-51-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'evlist' argument to print functions to get rid of the global
'evsel_list' variable dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 528f85146b59..46181ac492c5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1222,6 +1222,7 @@ static void aggr_cb(struct perf_evsel *counter, void *data, bool first)
 }
 
 static void print_aggr(struct perf_stat_config *config,
+		       struct perf_evlist *evlist,
 		       char *prefix)
 {
 	bool metric_only = config->metric_only;
@@ -1248,7 +1249,7 @@ static void print_aggr(struct perf_stat_config *config,
 
 		ad.id = id = aggr_map->map[s];
 		first = true;
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 
@@ -1449,6 +1450,7 @@ static void print_counter(struct perf_stat_config *config,
 }
 
 static void print_no_aggr_metric(struct perf_stat_config *config,
+				 struct perf_evlist *evlist,
 				 char *prefix)
 {
 	int cpu;
@@ -1457,13 +1459,13 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 	u64 ena, run, val;
 	double uval;
 
-	nrcpus = evsel_list->cpus->nr;
+	nrcpus = evlist->cpus->nr;
 	for (cpu = 0; cpu < nrcpus; cpu++) {
 		bool first = true;
 
 		if (prefix)
 			fputs(prefix, config->output);
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 			if (first) {
@@ -1499,6 +1501,7 @@ static const char *aggr_header_csv[] = {
 };
 
 static void print_metric_headers(struct perf_stat_config *config,
+				 struct perf_evlist *evlist,
 				 const char *prefix, bool no_indent)
 {
 	struct perf_stat_output_ctx out;
@@ -1520,7 +1523,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 	}
 
 	/* Print metrics headers only */
-	evlist__for_each_entry(evsel_list, counter) {
+	evlist__for_each_entry(evlist, counter) {
 		if (is_duration_time(counter))
 			continue;
 		os.evsel = counter;
@@ -1539,6 +1542,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 }
 
 static void print_interval(struct perf_stat_config *config,
+			   struct perf_evlist *evlist,
 			   char *prefix, struct timespec *ts)
 {
 	bool metric_only = config->metric_only;
@@ -1584,7 +1588,7 @@ static void print_interval(struct perf_stat_config *config,
 	}
 
 	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
-		print_metric_headers(config, " ", true);
+		print_metric_headers(config, evlist, " ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
 }
@@ -1727,7 +1731,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	char buf[64], *prefix = NULL;
 
 	if (interval)
-		print_interval(config, prefix = buf, ts);
+		print_interval(config, evlist, prefix = buf, ts);
 	else
 		print_header(config, _target, argc, argv);
 
@@ -1735,7 +1739,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		static int num_print_iv;
 
 		if (num_print_iv == 0 && !interval)
-			print_metric_headers(config, prefix, false);
+			print_metric_headers(config, evlist, prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
 		if (config->aggr_mode == AGGR_GLOBAL && prefix)
@@ -1745,7 +1749,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 	case AGGR_SOCKET:
-		print_aggr(config, prefix);
+		print_aggr(config, evlist, prefix);
 		break;
 	case AGGR_THREAD:
 		evlist__for_each_entry(evlist, counter) {
@@ -1765,7 +1769,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		break;
 	case AGGR_NONE:
 		if (metric_only)
-			print_no_aggr_metric(config, prefix);
+			print_no_aggr_metric(config, evlist, prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
 				if (is_duration_time(counter))
-- 
2.14.4
