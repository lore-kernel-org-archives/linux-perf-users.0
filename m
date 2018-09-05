From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/77] perf stat: Move 'unit_width' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:11 -0300
Message-ID: <20180905220440.20256-49-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'unit_width' variable to 'struct perf_stat_config',
so it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 11 ++++++-----
 tools/perf/util/stat.h    |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 397cb4f28d7f..24171aa6c41f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -161,7 +161,6 @@ static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
-static unsigned int		unit_width			= 4; /* strlen("unit") */
 static bool			forever				= false;
 static bool			force_metric_only		= false;
 static bool			no_merge			= false;
@@ -200,6 +199,7 @@ static volatile int done = 0;
 static struct perf_stat_config stat_config = {
 	.aggr_mode	= AGGR_GLOBAL,
 	.scale		= true,
+	.unit_width	= 4, /* strlen("unit") */
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -524,8 +524,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		counter->supported = true;
 
 		l = strlen(counter->unit);
-		if (l > unit_width)
-			unit_width = l;
+		if (l > stat_config.unit_width)
+			stat_config.unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
 		    perf_evsel__store_ids(counter, evsel_list))
@@ -963,7 +963,7 @@ static void abs_printout(struct perf_stat_config *config,
 
 	if (evsel->unit)
 		fprintf(output, "%-*s%s",
-			config->csv_output ? 0 : unit_width,
+			config->csv_output ? 0 : config->unit_width,
 			evsel->unit, config->csv_sep);
 
 	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
@@ -1056,7 +1056,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		}
 
 		fprintf(config->output, "%-*s%s",
-			config->csv_output ? 0 : unit_width,
+			config->csv_output ? 0 : config->unit_width,
 			counter->unit, config->csv_sep);
 
 		fprintf(config->output, "%*s",
@@ -1542,6 +1542,7 @@ static void print_interval(struct perf_stat_config *config,
 			   char *prefix, struct timespec *ts)
 {
 	bool metric_only = config->metric_only;
+	unsigned int unit_width = config->unit_width;
 	FILE *output = config->output;
 	static int num_print_interval;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index da838182b99c..2dc66e0ba4b8 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -98,6 +98,7 @@ struct perf_stat_config {
 	unsigned int		 interval;
 	unsigned int		 timeout;
 	unsigned int		 initial_delay;
+	unsigned int		 unit_width;
 	int			 times;
 	struct runtime_stat	*stats;
 	int			 stats_num;
-- 
2.14.4
