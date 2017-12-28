From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/35] perf stat: Update or print per-thread stats
Date: Thu, 28 Dec 2017 11:30:00 -0300
Message-ID: <20171228143027.30547-9-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

If the stats pointer in stat_config structure is not null, it will
update the per-thread stats or print the per-thread stats on this
buffer.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-9-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c |  9 +++++++--
 tools/perf/util/stat.c    | 11 ++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4c492ac3ac07..f4129a5fbb01 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1372,8 +1372,13 @@ static void print_aggr_thread(struct perf_evsel *counter, char *prefix)
 			fprintf(output, "%s", prefix);
 
 		uval = val * counter->scale;
-		printout(thread, 0, counter, uval, prefix, run, ena, 1.0,
-			 &rt_stat);
+
+		if (stat_config.stats)
+			printout(thread, 0, counter, uval, prefix, run, ena,
+				 1.0, &stat_config.stats[thread]);
+		else
+			printout(thread, 0, counter, uval, prefix, run, ena,
+				 1.0, &rt_stat);
 		fputc('\n', output);
 	}
 }
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 78abfd40b135..32235657c1ac 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -280,9 +280,14 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 		if (config->aggr_mode == AGGR_NONE)
 			perf_stat__update_shadow_stats(evsel, count->val, cpu,
 						       &rt_stat);
-		if (config->aggr_mode == AGGR_THREAD)
-			perf_stat__update_shadow_stats(evsel, count->val, 0,
-						       &rt_stat);
+		if (config->aggr_mode == AGGR_THREAD) {
+			if (config->stats)
+				perf_stat__update_shadow_stats(evsel,
+					count->val, 0, &config->stats[thread]);
+			else
+				perf_stat__update_shadow_stats(evsel,
+					count->val, 0, &rt_stat);
+		}
 		break;
 	case AGGR_GLOBAL:
 		aggr->val += count->val;
-- 
2.13.6
