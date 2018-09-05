From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 65/77] perf stat: Propagate 'struct target' arg to sort_aggr_thread()
Date: Wed,  5 Sep 2018 19:04:28 -0300
Message-ID: <20180905220440.20256-66-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Propagate the 'struct target' arg to sort_aggr_thread() so that the
function does not depend on the 'perf stat' command object local
variable 'target' and can be moved out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-41-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c4df076f1e54..486b0cf7818d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1284,7 +1284,8 @@ static int cmp_val(const void *a, const void *b)
 static struct perf_aggr_thread_value *sort_aggr_thread(
 					struct perf_evsel *counter,
 					int nthreads, int ncpus,
-					int *ret)
+					int *ret,
+					struct target *_target)
 {
 	int cpu, thread, i = 0;
 	double uval;
@@ -1309,7 +1310,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 		 * Skip value 0 when enabling --per-thread globally,
 		 * otherwise too many 0 output.
 		 */
-		if (uval == 0.0 && target__has_per_thread(&target))
+		if (uval == 0.0 && target__has_per_thread(_target))
 			continue;
 
 		buf[i].counter = counter;
@@ -1330,6 +1331,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 }
 
 static void print_aggr_thread(struct perf_stat_config *config,
+			      struct target *_target,
 			      struct perf_evsel *counter, char *prefix)
 {
 	FILE *output = config->output;
@@ -1338,7 +1340,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
 	int thread, sorted_threads, id;
 	struct perf_aggr_thread_value *buf;
 
-	buf = sort_aggr_thread(counter, nthreads, ncpus, &sorted_threads);
+	buf = sort_aggr_thread(counter, nthreads, ncpus, &sorted_threads, _target);
 	if (!buf) {
 		perror("cannot sort aggr thread");
 		return;
@@ -1754,7 +1756,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
-			print_aggr_thread(config, counter, prefix);
+			print_aggr_thread(config, _target, counter, prefix);
 		}
 		break;
 	case AGGR_GLOBAL:
-- 
2.14.4
