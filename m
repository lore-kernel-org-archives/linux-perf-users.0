From: Ian Rogers <irogers@google.com>
Subject: [PATCH v2 2/7] perf metricgroup: Use early return in add_metric
Date: Wed, 20 May 2020 11:20:06 -0700
Message-ID: <20200520182011.32236-3-irogers@google.com>
References: <20200520182011.32236-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200520182011.32236-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Use early return in metricgroup__add_metric and try to make the intent
of the returns more intention revealing.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7a43ee0a2e40..5c0603ef4c75 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -524,7 +524,8 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
-	int i, ret = -EINVAL;
+	int i, ret;
+	bool has_match = false;
 
 	if (!map)
 		return 0;
@@ -532,17 +533,23 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 	for (i = 0; ; i++) {
 		pe = &map->table[i];
 
-		if (!pe->name && !pe->metric_group && !pe->metric_name)
+		if (!pe->name && !pe->metric_group && !pe->metric_name) {
+			/* End of pmu events. */
+			if (!has_match)
+				return -EINVAL;
 			break;
+		}
 		if (!pe->metric_expr)
 			continue;
 		if (match_metric(pe->metric_group, metric) ||
 		    match_metric(pe->metric_name, metric)) {
-
+			has_match = true;
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 			if (!strstr(pe->metric_expr, "?")) {
 				ret = __metricgroup__add_metric(events, group_list, pe, 1);
+				if (ret)
+					return ret;
 			} else {
 				int j, count;
 
@@ -553,14 +560,15 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				 * those events to group_list.
 				 */
 
-				for (j = 0; j < count; j++)
+				for (j = 0; j < count; j++) {
 					ret = __metricgroup__add_metric(events, group_list, pe, j);
+					if (ret)
+						return ret;
+				}
 			}
-			if (ret == -ENOMEM)
-				break;
 		}
 	}
-	return ret;
+	return 0;
 }
 
 static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
-- 
2.26.2.761.g0e0b3e54be-goog
