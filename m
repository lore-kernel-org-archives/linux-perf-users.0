From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/77] perf stat: Move 'big_num' data to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:26 -0300
Message-ID: <20180905220440.20256-64-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static variable 'big_num' to 'struct perf_stat_config', so that
it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-39-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 445673f688de..8ca85017a973 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -151,7 +151,6 @@ static bool			transaction_run;
 static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
-static bool			big_num				=  true;
 static int			big_num_opt			=  -1;
 static bool			group				= false;
 static const char		*pre_cmd			= NULL;
@@ -192,6 +191,7 @@ static struct perf_stat_config stat_config = {
 	.run_count		= 1,
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
+	.big_num		= true,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -945,7 +945,7 @@ static void abs_printout(struct perf_stat_config *config,
 	if (config->csv_output) {
 		fmt = floor(sc) != sc ?  "%.2f%s" : "%.0f%s";
 	} else {
-		if (big_num)
+		if (config->big_num)
 			fmt = floor(sc) != sc ? "%'18.2f%s" : "%'18.0f%s";
 		else
 			fmt = floor(sc) != sc ? "%18.2f%s" : "%18.0f%s";
@@ -2847,9 +2847,9 @@ int cmd_stat(int argc, const char **argv)
 			parse_options_usage(NULL, stat_options, "x", 1);
 			goto out;
 		} else /* Nope, so disable big number formatting */
-			big_num = false;
+			stat_config.big_num = false;
 	} else if (big_num_opt == 0) /* User passed --no-big-num */
-		big_num = false;
+		stat_config.big_num = false;
 
 	setup_system_wide(argc);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index be202b066e62..843672214cca 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	bool			 metric_only;
 	bool			 null_run;
 	bool			 ru_display;
+	bool			 big_num;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4
