From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/77] perf stat: Move 'no_inherit' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:03:51 -0300
Message-ID: <20180905220440.20256-29-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'no_inherit' variable to 'struct perf_stat_config', so
it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 719abdd3b7de..84dbac526925 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -148,7 +148,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 #define METRIC_ONLY_LEN 20
 
 static int			run_count			=  1;
-static bool			no_inherit			= false;
 static volatile pid_t		child_pid			= -1;
 static bool			null_run			=  false;
 static int			detailed_run			=  0;
@@ -254,7 +253,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel,
 	if (leader->nr_members > 1)
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
-	attr->inherit = !no_inherit;
+	attr->inherit = !config->no_inherit;
 
 	/*
 	 * Some events get initialized with sample_(period/type) set,
@@ -1969,7 +1968,7 @@ static const struct option stat_options[] = {
 		     parse_events_option),
 	OPT_CALLBACK(0, "filter", &evsel_list, "filter",
 		     "event filter", parse_filter),
-	OPT_BOOLEAN('i', "no-inherit", &no_inherit,
+	OPT_BOOLEAN('i', "no-inherit", &stat_config.no_inherit,
 		    "child tasks do not inherit counters"),
 	OPT_STRING('p', "pid", &target.pid, "pid",
 		   "stat events on existing process id"),
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 91e6609fce6e..53b2415ba3f3 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -88,6 +88,7 @@ struct runtime_stat {
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
+	bool			 no_inherit;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4
