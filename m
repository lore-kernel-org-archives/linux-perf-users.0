From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/23] perf metricgroup: Factor out metricgroup__add_metric_weak_group()
Date: Tue, 17 Mar 2020 18:32:39 -0300
Message-ID: <20200317213259.15494-4-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Factor out metricgroup__add_metric_weak_group() which add metrics into a
weak group. The change can improve code readability. Because following
patch will introduce a function which add standalone metrics.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 57 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 02aee946b6c1..1cd042cb262e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -399,13 +399,42 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	strlist__delete(metriclist);
 }
 
+static void metricgroup__add_metric_weak_group(struct strbuf *events,
+					       const char **ids,
+					       int idnum)
+{
+	bool no_group = false;
+	int i;
+
+	for (i = 0; i < idnum; i++) {
+		pr_debug("found event %s\n", ids[i]);
+		/*
+		 * Duration time maps to a software event and can make
+		 * groups not count. Always use it outside a
+		 * group.
+		 */
+		if (!strcmp(ids[i], "duration_time")) {
+			if (i > 0)
+				strbuf_addf(events, "}:W,");
+			strbuf_addf(events, "duration_time");
+			no_group = true;
+			continue;
+		}
+		strbuf_addf(events, "%s%s",
+			i == 0 || no_group ? "{" : ",",
+			ids[i]);
+		no_group = false;
+	}
+	if (!no_group)
+		strbuf_addf(events, "}:W");
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
-	int ret = -EINVAL;
-	int i, j;
+	int i, ret = -EINVAL;
 
 	if (!map)
 		return 0;
@@ -422,7 +451,6 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			const char **ids;
 			int idnum;
 			struct egroup *eg;
-			bool no_group = false;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
@@ -431,27 +459,8 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				continue;
 			if (events->len > 0)
 				strbuf_addf(events, ",");
-			for (j = 0; j < idnum; j++) {
-				pr_debug("found event %s\n", ids[j]);
-				/*
-				 * Duration time maps to a software event and can make
-				 * groups not count. Always use it outside a
-				 * group.
-				 */
-				if (!strcmp(ids[j], "duration_time")) {
-					if (j > 0)
-						strbuf_addf(events, "}:W,");
-					strbuf_addf(events, "duration_time");
-					no_group = true;
-					continue;
-				}
-				strbuf_addf(events, "%s%s",
-					j == 0 || no_group ? "{" : ",",
-					ids[j]);
-				no_group = false;
-			}
-			if (!no_group)
-				strbuf_addf(events, "}:W");
+
+			metricgroup__add_metric_weak_group(events, ids, idnum);
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
-- 
2.21.1
