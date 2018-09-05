From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 62/77] perf stat: Do not use the global 'evsel_list' in print functions
Date: Wed,  5 Sep 2018 19:04:25 -0300
Message-ID: <20180905220440.20256-63-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Get rid of the the 'evsel_list' global variable dependency, here we can
use the 'evlist' pointer from the evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-38-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2f606f76b66a..445673f688de 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -914,6 +914,7 @@ static void print_metric_header(struct perf_stat_config *config,
 static int first_shadow_cpu(struct perf_stat_config *config,
 			    struct perf_evsel *evsel, int id)
 {
+	struct perf_evlist *evlist = evsel->evlist;
 	int i;
 
 	if (!config->aggr_get_id)
@@ -928,7 +929,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
 		int cpu2 = perf_evsel__cpus(evsel)->map[i];
 
-		if (config->aggr_get_id(config, evsel_list->cpus, cpu2) == id)
+		if (config->aggr_get_id(config, evlist->cpus, cpu2) == id)
 			return cpu2;
 	}
 	return 0;
@@ -1103,7 +1104,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evsel_list->cpus, cpu);
+				s2 = config->aggr_get_id(config, evlist->cpus, cpu);
 				if (s2 != id)
 					continue;
 				val += perf_counts(counter->counts, cpu, 0)->val;
-- 
2.14.4
