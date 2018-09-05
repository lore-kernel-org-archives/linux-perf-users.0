From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 64/77] perf stat: Move 'no_merge' data to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:27 -0300
Message-ID: <20180905220440.20256-65-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static variable 'no_merge' to 'struct perf_stat_config', so
that it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-40-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8ca85017a973..c4df076f1e54 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -158,7 +158,6 @@ static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
 static bool			forever				= false;
 static bool			force_metric_only		= false;
-static bool			no_merge			= false;
 static bool			walltime_run_table		= false;
 static struct timespec		ref_time;
 static bool			append_file;
@@ -1173,7 +1172,7 @@ static bool collect_data(struct perf_stat_config *config, struct perf_evsel *cou
 	if (counter->merged_stat)
 		return false;
 	cb(config, counter, data, true);
-	if (no_merge)
+	if (config->no_merge)
 		uniquify_event_name(counter);
 	else if (counter->auto_merge_stats)
 		collect_all_aliases(config, counter, cb, data);
@@ -1902,7 +1901,7 @@ static const struct option stat_options[] = {
 		    "list of cpus to monitor in system-wide"),
 	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
 		    "disable CPU count aggregation", AGGR_NONE),
-	OPT_BOOLEAN(0, "no-merge", &no_merge, "Do not merge identical named events"),
+	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 843672214cca..0758107fe56f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -104,6 +104,7 @@ struct perf_stat_config {
 	bool			 null_run;
 	bool			 ru_display;
 	bool			 big_num;
+	bool			 no_merge;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4
