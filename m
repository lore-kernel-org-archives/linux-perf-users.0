From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/77] perf stat: Move 'initial_delay' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:03:50 -0300
Message-ID: <20180905220440.20256-28-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'initial_delay' variable to 'struct perf_stat_config',
so it can be passed around and used outside the 'perf stat' command.

Add 'struct perf_stat_config' argument to create_perf_stat_counter() and
use its 'initial_delay' member instead of the static one.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 16 ++++++++--------
 tools/perf/util/stat.h    | 18 ++++++++++--------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d389ed623715..719abdd3b7de 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,7 +164,6 @@ static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
-static unsigned int		initial_delay			= 0;
 static unsigned int		unit_width			= 4; /* strlen("unit") */
 static bool			forever				= false;
 static bool			metric_only			= false;
@@ -236,7 +235,8 @@ static void perf_stat__reset_stats(void)
 		perf_stat__reset_shadow_per_stat(&stat_config.stats[i]);
 }
 
-static int create_perf_stat_counter(struct perf_evsel *evsel)
+static int create_perf_stat_counter(struct perf_evsel *evsel,
+				    struct perf_stat_config *config)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	struct perf_evsel *leader = evsel->leader;
@@ -286,7 +286,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
 		 * In case of initial_delay we enable tracee
 		 * events manually.
 		 */
-		if (target__none(&target) && !initial_delay)
+		if (target__none(&target) && !config->initial_delay)
 			attr->enable_on_exec = 1;
 	}
 
@@ -428,15 +428,15 @@ static void process_interval(void)
 
 static void enable_counters(void)
 {
-	if (initial_delay)
-		usleep(initial_delay * USEC_PER_MSEC);
+	if (stat_config.initial_delay)
+		usleep(stat_config.initial_delay * USEC_PER_MSEC);
 
 	/*
 	 * We need to enable counters only if:
 	 * - we don't have tracee (attaching to task or cpu)
 	 * - we have initial delay configured
 	 */
-	if (!target__none(&target) || initial_delay)
+	if (!target__none(&target) || stat_config.initial_delay)
 		perf_evlist__enable(evsel_list);
 }
 
@@ -609,7 +609,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	evlist__for_each_entry(evsel_list, counter) {
 try_again:
-		if (create_perf_stat_counter(counter) < 0) {
+		if (create_perf_stat_counter(counter, &stat_config) < 0) {
 
 			/* Weak group failed. Reset the group. */
 			if ((errno == EINVAL || errno == EBADF) &&
@@ -2027,7 +2027,7 @@ static const struct option stat_options[] = {
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
 		     "aggregate counts per thread", AGGR_THREAD),
-	OPT_UINTEGER('D', "delay", &initial_delay,
+	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
 		     "ms to wait before starting measurement after program start"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &metric_only, NULL,
 			"Only print computed metrics. No raw values", enable_metric_only),
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 36efb986f7fc..91e6609fce6e 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include "xyarray.h"
 #include "rblist.h"
+#include "perf.h"
 
 struct stats {
 	double n, mean, M2;
@@ -85,14 +86,15 @@ struct runtime_stat {
 };
 
 struct perf_stat_config {
-	enum aggr_mode	aggr_mode;
-	bool		scale;
-	FILE		*output;
-	unsigned int	interval;
-	unsigned int	timeout;
-	int		times;
-	struct runtime_stat *stats;
-	int		stats_num;
+	enum aggr_mode		 aggr_mode;
+	bool			 scale;
+	FILE			*output;
+	unsigned int		 interval;
+	unsigned int		 timeout;
+	unsigned int		 initial_delay;
+	int			 times;
+	struct runtime_stat	*stats;
+	int			 stats_num;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.14.4
