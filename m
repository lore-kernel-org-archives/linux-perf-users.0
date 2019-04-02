From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/44] perf stat: Revert checks for duration_time
Date: Tue,  2 Apr 2019 13:05:12 -0300
Message-ID: <20190402160549.13544-8-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This reverts e864c5ca145e ("perf stat: Hide internal duration_time
counter") but doing it manually since the code has now moved to a
different file.

The next patch will properly implement duration_time as a full event, so
no need to hide it anymore.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190326221823.11518-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d043c78f3c2..3324f23c7efc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -18,11 +18,6 @@
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
 
-static bool is_duration_time(struct perf_evsel *evsel)
-{
-	return !strcmp(evsel->name, "duration_time");
-}
-
 static void print_running(struct perf_stat_config *config,
 			  u64 run, u64 ena)
 {
@@ -628,9 +623,6 @@ static void print_aggr(struct perf_stat_config *config,
 		ad.id = id = config->aggr_map->map[s];
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
-
 			ad.val = ad.ena = ad.run = 0;
 			ad.nr = 0;
 			if (!collect_data(config, counter, aggr_cb, &ad))
@@ -848,8 +840,6 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 		if (prefix)
 			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
 			if (first) {
 				aggr_printout(config, counter, cpu, 0);
 				first = false;
@@ -906,8 +896,6 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
-		if (is_duration_time(counter))
-			continue;
 		os.evsel = counter;
 		out.ctx = &os;
 		out.print_metric = print_metric_header;
@@ -1136,15 +1124,11 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		break;
 	case AGGR_THREAD:
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
 			print_aggr_thread(config, _target, counter, prefix);
 		}
 		break;
 	case AGGR_GLOBAL:
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
 			print_counter_aggr(config, counter, prefix);
 		}
 		if (metric_only)
@@ -1155,8 +1139,6 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_no_aggr_metric(config, evlist, prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
-				if (is_duration_time(counter))
-					continue;
 				print_counter(config, counter, prefix);
 			}
 		}
-- 
2.20.1
