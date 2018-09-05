From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/77] perf stat: Pass 'evlist' to aggr_update_shadow()
Date: Wed,  5 Sep 2018 19:04:18 -0300
Message-ID: <20180905220440.20256-56-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pass a 'evlist' argument to aggr_update_shadow(), to get rid of the
global 'evsel_list' variable dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-31-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f5ac6545af34..2711d8f6e4b8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1099,7 +1099,8 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	}
 }
 
-static void aggr_update_shadow(struct perf_stat_config *config)
+static void aggr_update_shadow(struct perf_stat_config *config,
+			       struct perf_evlist *evlist)
 {
 	int cpu, s2, id, s;
 	u64 val;
@@ -1107,7 +1108,7 @@ static void aggr_update_shadow(struct perf_stat_config *config)
 
 	for (s = 0; s < aggr_map->nr; s++) {
 		id = aggr_map->map[s];
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
 				s2 = aggr_get_id(evsel_list->cpus, cpu);
@@ -1238,7 +1239,7 @@ static void print_aggr(struct perf_stat_config *config,
 	if (!(aggr_map || aggr_get_id))
 		return;
 
-	aggr_update_shadow(config);
+	aggr_update_shadow(config, evlist);
 
 	/*
 	 * With metric_only everything is on a single line.
-- 
2.14.4
