From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v3 1/5] perf/pmu-events/jevents: Add enum to store aggregation like PerPkg
Date: Thu, 16 Jul 2020 15:12:12 +0530
Message-ID: <20200716094216.1418659-2-kjain@linux.ibm.com>
References: <20200716094216.1418659-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716094216.1418659-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Initially, every time we want to add new terms like chip, core thread etc,
we need to create corrsponding fields in pmu_events and event struct.
This patch adds an enum called 'aggr_mode_class' which store all these
aggregation like perpkg/percore. It also adds new field 'aggr_mode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.c    | 39 +++++++++++++++++++-----------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  6 ++++-
 tools/perf/tests/pmu-events.c      |  8 +++---
 tools/perf/util/pmu.c              |  6 ++---
 5 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..b2f59f0af63d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -53,6 +53,17 @@
 int verbose;
 char *prog;
 
+enum aggr_mode_class {
+	PerPkg = 1
+};
+
+enum aggr_mode_class convert(const char *aggr_mode)
+{
+	if (!strcmp(aggr_mode, "PerPkg"))
+		return PerPkg;
+	return -1;
+}
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -320,7 +331,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 
 static int print_events_table_entry(void *data, char *name, char *event,
 				    char *desc, char *long_desc,
-				    char *pmu, char *unit, char *perpkg,
+				    char *pmu, char *unit, char *aggr_mode,
 				    char *metric_expr,
 				    char *metric_name, char *metric_group,
 				    char *deprecated, char *metric_constraint)
@@ -345,10 +356,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
 	if (pmu)
 		fprintf(outfp, "\t.pmu = \"%s\",\n", pmu);
+	if (aggr_mode)
+		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(aggr_mode));
 	if (unit)
 		fprintf(outfp, "\t.unit = \"%s\",\n", unit);
-	if (perpkg)
-		fprintf(outfp, "\t.perpkg = \"%s\",\n", perpkg);
 	if (metric_expr)
 		fprintf(outfp, "\t.metric_expr = \"%s\",\n", metric_expr);
 	if (metric_name)
@@ -372,7 +383,7 @@ struct event_struct {
 	char *long_desc;
 	char *pmu;
 	char *unit;
-	char *perpkg;
+	char *aggr_mode;
 	char *metric_expr;
 	char *metric_name;
 	char *metric_group;
@@ -401,7 +412,7 @@ struct event_struct {
 	op(long_desc);						\
 	op(pmu);						\
 	op(unit);						\
-	op(perpkg);						\
+	op(aggr_mode);					\
 	op(metric_expr);					\
 	op(metric_name);					\
 	op(metric_group);					\
@@ -423,7 +434,7 @@ static void free_arch_std_events(void)
 
 static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
+				char *unit, char *aggr_mode, char *metric_expr,
 				char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint)
 {
@@ -487,7 +498,7 @@ static char *real_event(const char *name, char *event)
 static int
 try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
-	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
+	  char **aggr_mode, char **unit, char **metric_expr, char **metric_name,
 	  char **metric_group, unsigned long long eventcode,
 	  char **deprecated, char **metric_constraint)
 {
@@ -515,7 +526,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
 		      char *long_desc,
-		      char *pmu, char *unit, char *perpkg,
+		      char *pmu, char *unit, char *aggr_mode,
 		      char *metric_expr,
 		      char *metric_name, char *metric_group,
 		      char *deprecated, char *metric_constraint),
@@ -542,7 +553,7 @@ int json_events(const char *fn,
 		char *extra_desc = NULL;
 		char *pmu = NULL;
 		char *filter = NULL;
-		char *perpkg = NULL;
+		char *aggr_mode = NULL;
 		char *unit = NULL;
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
@@ -625,8 +636,8 @@ int json_events(const char *fn,
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
 				addfield(map, &unit, "", "", val);
-			} else if (json_streq(map, field, "PerPkg")) {
-				addfield(map, &perpkg, "", "", val);
+			} else if (json_streq(map, field, "AggregationMode")) {
+				addfield(map, &aggr_mode, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
@@ -673,7 +684,7 @@ int json_events(const char *fn,
 			 * fixup any unassigned values.
 			 */
 			err = try_fixup(fn, arch_std, &event, &desc, &name,
-					&long_desc, &pmu, &filter, &perpkg,
+					&long_desc, &pmu, &filter, &aggr_mode,
 					&unit, &metric_expr, &metric_name,
 					&metric_group, eventcode,
 					&deprecated, &metric_constraint);
@@ -681,7 +692,7 @@ int json_events(const char *fn,
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
+			   pmu, unit, aggr_mode, metric_expr, metric_name,
 			   metric_group, deprecated, metric_constraint);
 free_strings:
 		free(event);
@@ -691,7 +702,7 @@ int json_events(const char *fn,
 		free(extra_desc);
 		free(pmu);
 		free(filter);
-		free(perpkg);
+		free(aggr_mode);
 		free(deprecated);
 		free(unit);
 		free(metric_expr);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2afc8304529e..63e72c0c312f 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -6,7 +6,7 @@ int json_events(const char *fn,
 		int (*func)(void *data, char *name, char *event, char *desc,
 				char *long_desc,
 				char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
+				char *unit, char *aggr_mode, char *metric_expr,
 				char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint),
 		void *data);
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c8f306b572f4..71b7aa6278d0 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -2,6 +2,10 @@
 #ifndef PMU_EVENTS_H
 #define PMU_EVENTS_H
 
+enum aggr_mode_class {
+	PerPkg = 1
+};
+
 /*
  * Describe each PMU event. Each CPU has a table of PMU events.
  */
@@ -13,7 +17,7 @@ struct pmu_event {
 	const char *long_desc;
 	const char *pmu;
 	const char *unit;
-	const char *perpkg;
+	const char *aggr_mode;
 	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_group;
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index b66b021476ec..377211d4c849 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -206,10 +206,10 @@ static int test_pmu_event_table(void)
 				return -1;
 			}
 
-			if (!is_same(table->perpkg, te->perpkg)) {
-				pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
-					  table->name, table->perpkg,
-					  te->perpkg);
+			if (!is_same(table->aggr_mode, te->aggr_mode)) {
+				pr_debug2("testing event table %s: mismatched aggr_mode, %s vs %s\n",
+					  table->name, table->aggr_mode,
+					  te->aggr_mode);
 				return -1;
 			}
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f1688e1f6ed7..a0e3ea75a3c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -308,7 +308,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *desc, char *val,
 				 char *long_desc, char *topic,
-				 char *unit, char *perpkg,
+				 char *unit, char *aggr_mode,
 				 char *metric_expr,
 				 char *metric_name,
 				 char *deprecated)
@@ -380,7 +380,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
+	alias->per_pkg = aggr_mode && sscanf(aggr_mode, "%d", &num) == 1 && num == PerPkg;
 	alias->str = strdup(newval);
 
 	if (deprecated)
@@ -778,7 +778,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,
 				(char *)pe->long_desc, (char *)pe->topic,
-				(char *)pe->unit, (char *)pe->perpkg,
+				(char *)pe->unit, (char *)pe->aggr_mode,
 				(char *)pe->metric_expr,
 				(char *)pe->metric_name,
 				(char *)pe->deprecated);
-- 
2.26.2
