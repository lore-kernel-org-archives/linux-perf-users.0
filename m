From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/41] perf stat: Hide internal duration_time counter
Date: Tue, 12 Sep 2017 12:09:59 -0300
Message-ID: <20170912151029.6612-12-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Some perf stat metrics use an internal "duration_time" metric. It is not
correctly printed however. So hide it during output to avoid confusing
users with 0 counts.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-11-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 12884d21ef04..f783b498e5c5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -195,6 +195,11 @@ static struct perf_stat_config stat_config = {
 	.scale		= true,
 };
 
+static bool is_duration_time(struct perf_evsel *evsel)
+{
+	return !strcmp(evsel->name, "duration_time");
+}
+
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
 				 struct timespec *b)
 {
@@ -1363,6 +1368,9 @@ static void print_aggr(char *prefix)
 		ad.id = id = aggr_map->map[s];
 		first = true;
 		evlist__for_each_entry(evsel_list, counter) {
+			if (is_duration_time(counter))
+				continue;
+
 			ad.val = ad.ena = ad.run = 0;
 			ad.nr = 0;
 			if (!collect_data(counter, aggr_cb, &ad))
@@ -1506,6 +1514,8 @@ static void print_no_aggr_metric(char *prefix)
 		if (prefix)
 			fputs(prefix, stat_config.output);
 		evlist__for_each_entry(evsel_list, counter) {
+			if (is_duration_time(counter))
+				continue;
 			if (first) {
 				aggr_printout(counter, cpu, 0);
 				first = false;
@@ -1560,6 +1570,8 @@ static void print_metric_headers(const char *prefix, bool no_indent)
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evsel_list, counter) {
+		if (is_duration_time(counter))
+			continue;
 		os.evsel = counter;
 		out.ctx = &os;
 		out.print_metric = print_metric_header;
@@ -1707,12 +1719,18 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 		print_aggr(prefix);
 		break;
 	case AGGR_THREAD:
-		evlist__for_each_entry(evsel_list, counter)
+		evlist__for_each_entry(evsel_list, counter) {
+			if (is_duration_time(counter))
+				continue;
 			print_aggr_thread(counter, prefix);
+		}
 		break;
 	case AGGR_GLOBAL:
-		evlist__for_each_entry(evsel_list, counter)
+		evlist__for_each_entry(evsel_list, counter) {
+			if (is_duration_time(counter))
+				continue;
 			print_counter_aggr(counter, prefix);
+		}
 		if (metric_only)
 			fputc('\n', stat_config.output);
 		break;
@@ -1720,8 +1738,11 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 		if (metric_only)
 			print_no_aggr_metric(prefix);
 		else {
-			evlist__for_each_entry(evsel_list, counter)
+			evlist__for_each_entry(evsel_list, counter) {
+				if (is_duration_time(counter))
+					continue;
 				print_counter(counter, prefix);
+			}
 		}
 		break;
 	case AGGR_UNSET:
-- 
2.13.5
