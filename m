From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/34] perf stat: Allocate shadow stats buffer for threads
Date: Thu, 14 Dec 2017 14:42:20 -0300
Message-ID: <20171214174247.16841-8-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

After perf_evlist__create_maps() being executed, we can get all threads
from /proc. And via thread_map__nr(), we can also get the number of
threads.

With the number of threads, the patch allocates a buffer which will
record the shadow stats for these threads.

The buffer pointer is saved in stat_config.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-8-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/stat.h    |  2 ++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 097a694d16f2..4c492ac3ac07 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -214,8 +214,13 @@ static inline void diff_timespec(struct timespec *r, struct timespec *a,
 
 static void perf_stat__reset_stats(void)
 {
+	int i;
+
 	perf_evlist__reset_stats(evsel_list);
 	perf_stat__reset_shadow_stats();
+
+	for (i = 0; i < stat_config.stats_num; i++)
+		perf_stat__reset_shadow_per_stat(&stat_config.stats[i]);
 }
 
 static int create_perf_stat_counter(struct perf_evsel *evsel)
@@ -2495,6 +2500,35 @@ int process_cpu_map_event(struct perf_tool *tool,
 	return set_maps(st);
 }
 
+static int runtime_stat_new(struct perf_stat_config *config, int nthreads)
+{
+	int i;
+
+	config->stats = calloc(nthreads, sizeof(struct runtime_stat));
+	if (!config->stats)
+		return -1;
+
+	config->stats_num = nthreads;
+
+	for (i = 0; i < nthreads; i++)
+		runtime_stat__init(&config->stats[i]);
+
+	return 0;
+}
+
+static void runtime_stat_delete(struct perf_stat_config *config)
+{
+	int i;
+
+	if (!config->stats)
+		return;
+
+	for (i = 0; i < config->stats_num; i++)
+		runtime_stat__exit(&config->stats[i]);
+
+	free(config->stats);
+}
+
 static const char * const stat_report_usage[] = {
 	"perf stat report [<options>]",
 	NULL,
@@ -2750,8 +2784,15 @@ int cmd_stat(int argc, const char **argv)
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
 	 */
-	if (stat_config.aggr_mode == AGGR_THREAD)
+	if (stat_config.aggr_mode == AGGR_THREAD) {
 		thread_map__read_comms(evsel_list->threads);
+		if (target.system_wide) {
+			if (runtime_stat_new(&stat_config,
+				thread_map__nr(evsel_list->threads))) {
+				goto out;
+			}
+		}
+	}
 
 	if (interval && interval < 100) {
 		if (interval < 10) {
@@ -2841,5 +2882,8 @@ int cmd_stat(int argc, const char **argv)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
 
 	perf_evlist__delete(evsel_list);
+
+	runtime_stat_delete(&stat_config);
+
 	return status;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index cfe4fb899633..2ed95dc72784 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -90,6 +90,8 @@ struct perf_stat_config {
 	bool		scale;
 	FILE		*output;
 	unsigned int	interval;
+	struct runtime_stat *stats;
+	int		stats_num;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.13.6
