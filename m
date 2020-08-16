From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v5 1/3] perf jevents: Add support for parsing perchip/percore events
Date: Sun, 16 Aug 2020 14:37:17 +0530
Message-ID: <20200816090719.72018-2-kjain@linux.ibm.com>
References: <20200816090719.72018-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200816090719.72018-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Initially, every time we want to add new terms like chip, core thread etc,
we need to create corrsponding fields in pmu_events and event struct.
This patch adds an enum called 'aggr_mode_class' which store all these
aggregation like perchip/percore. It also adds new field 'aggr_mode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c    | 32 +++++++++++++++++++++++-------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  6 ++++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..f97394dac1db 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -49,10 +49,20 @@
 #include "jsmn.h"
 #include "json.h"
 #include "jevents.h"
+#include "pmu-events.h"
 
 int verbose;
 char *prog;
 
+enum aggr_mode_class convert(const char *aggr_mode)
+{
+	if (!strcmp(aggr_mode, "PerCore"))
+		return PerCore;
+	else if (!strcmp(aggr_mode, "PerChip"))
+		return PerChip;
+	return -1;
+}
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -321,7 +331,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 static int print_events_table_entry(void *data, char *name, char *event,
 				    char *desc, char *long_desc,
 				    char *pmu, char *unit, char *perpkg,
-				    char *metric_expr,
+				    char *metric_expr, char *aggr_mode,
 				    char *metric_name, char *metric_group,
 				    char *deprecated, char *metric_constraint)
 {
@@ -345,6 +355,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
 	if (pmu)
 		fprintf(outfp, "\t.pmu = \"%s\",\n", pmu);
+	if (aggr_mode)
+		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(aggr_mode));
 	if (unit)
 		fprintf(outfp, "\t.unit = \"%s\",\n", unit);
 	if (perpkg)
@@ -372,6 +384,7 @@ struct event_struct {
 	char *long_desc;
 	char *pmu;
 	char *unit;
+	char *aggr_mode;
 	char *perpkg;
 	char *metric_expr;
 	char *metric_name;
@@ -402,6 +415,7 @@ struct event_struct {
 	op(pmu);						\
 	op(unit);						\
 	op(perpkg);						\
+	op(aggr_mode);						\
 	op(metric_expr);					\
 	op(metric_name);					\
 	op(metric_group);					\
@@ -424,7 +438,7 @@ static void free_arch_std_events(void)
 static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
+				char *aggr_mode, char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint)
 {
 	struct event_struct *es;
@@ -487,8 +501,8 @@ static char *real_event(const char *name, char *event)
 static int
 try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
-	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
-	  char **metric_group, unsigned long long eventcode,
+	  char **perpkg, char **unit, char **metric_expr, char **aggr_mode,
+	  char **metric_name, char **metric_group, unsigned long long eventcode,
 	  char **deprecated, char **metric_constraint)
 {
 	/* try to find matching event from arch standard values */
@@ -516,7 +530,7 @@ int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
 		      char *long_desc,
 		      char *pmu, char *unit, char *perpkg,
-		      char *metric_expr,
+		      char *metric_expr, char *aggr_mode,
 		      char *metric_name, char *metric_group,
 		      char *deprecated, char *metric_constraint),
 	  void *data)
@@ -543,6 +557,7 @@ int json_events(const char *fn,
 		char *pmu = NULL;
 		char *filter = NULL;
 		char *perpkg = NULL;
+		char *aggr_mode = NULL;
 		char *unit = NULL;
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
@@ -627,6 +642,8 @@ int json_events(const char *fn,
 				addfield(map, &unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
 				addfield(map, &perpkg, "", "", val);
+			} else if (json_streq(map, field, "AggregationMode")) {
+				addfield(map, &aggr_mode, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
@@ -674,14 +691,14 @@ int json_events(const char *fn,
 			 */
 			err = try_fixup(fn, arch_std, &event, &desc, &name,
 					&long_desc, &pmu, &filter, &perpkg,
-					&unit, &metric_expr, &metric_name,
+					&unit, &metric_expr, &aggr_mode, &metric_name,
 					&metric_group, eventcode,
 					&deprecated, &metric_constraint);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
+			   pmu, unit, perpkg, metric_expr, aggr_mode, metric_name,
 			   metric_group, deprecated, metric_constraint);
 free_strings:
 		free(event);
@@ -692,6 +709,7 @@ int json_events(const char *fn,
 		free(pmu);
 		free(filter);
 		free(perpkg);
+		free(aggr_mode);
 		free(deprecated);
 		free(unit);
 		free(metric_expr);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2afc8304529e..f64d6ebb245f 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -7,7 +7,7 @@ int json_events(const char *fn,
 				char *long_desc,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
+				char *aggr_mode, char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c8f306b572f4..e84496527611 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -2,6 +2,11 @@
 #ifndef PMU_EVENTS_H
 #define PMU_EVENTS_H
 
+enum aggr_mode_class {
+	PerChip = 1,
+	PerCore
+};
+
 /*
  * Describe each PMU event. Each CPU has a table of PMU events.
  */
@@ -15,6 +20,7 @@ struct pmu_event {
 	const char *unit;
 	const char *perpkg;
 	const char *metric_expr;
+	const char *aggr_mode;
 	const char *metric_name;
 	const char *metric_group;
 	const char *deprecated;
-- 
2.26.2
