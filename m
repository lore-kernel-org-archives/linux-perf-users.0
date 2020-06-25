From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC 1/3] perf jevents: Add support for parsing perchip/percore events
Date: Thu, 25 Jun 2020 17:17:16 +0530
Message-ID: <20200625114718.229911-2-kjain@linux.ibm.com>
References: <20200625114718.229911-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200625114718.229911-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Set up the "PerChip" field  so that perf knows they are
per chip events.

Set up the "PerCore" field  so that perf knows they are
per core events and add these fields to pmu_event structure.

Similar to the way we had "PerPkg field
to specify perpkg events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.c    | 34 ++++++++++++++++++++++++------
 tools/perf/pmu-events/jevents.h    |  3 ++-
 tools/perf/pmu-events/pmu-events.h |  2 ++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..21fd7990ded5 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -323,7 +323,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 				    char *pmu, char *unit, char *perpkg,
 				    char *metric_expr,
 				    char *metric_name, char *metric_group,
-				    char *deprecated, char *metric_constraint)
+				    char *deprecated, char *perchip, char *percore,
+				    char *metric_constraint)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -357,6 +358,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
 	if (deprecated)
 		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
+	if (perchip)
+		fprintf(outfp, "\t.perchip = \"%s\",\n", perchip);
+	if (percore)
+		fprintf(outfp, "\t.percore = \"%s\",\n", percore);
 	if (metric_constraint)
 		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
 	fprintf(outfp, "},\n");
@@ -378,6 +383,8 @@ struct event_struct {
 	char *metric_group;
 	char *deprecated;
 	char *metric_constraint;
+	char *perchip;
+	char *percore;
 };
 
 #define ADD_EVENT_FIELD(field) do { if (field) {		\
@@ -406,6 +413,8 @@ struct event_struct {
 	op(metric_name);					\
 	op(metric_group);					\
 	op(deprecated);						\
+	op(perchip);						\
+	op(percore);						\
 } while (0)
 
 static LIST_HEAD(arch_std_events);
@@ -425,7 +434,8 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint)
+				char *deprecated, char *perchip, char *percore,
+				char *metric_constraint)
 {
 	struct event_struct *es;
 
@@ -489,7 +499,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
 	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
 	  char **metric_group, unsigned long long eventcode,
-	  char **deprecated, char **metric_constraint)
+	  char **deprecated, char **perchip, char **percore,
+	  char **metric_constraint)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -518,7 +529,8 @@ int json_events(const char *fn,
 		      char *pmu, char *unit, char *perpkg,
 		      char *metric_expr,
 		      char *metric_name, char *metric_group,
-		      char *deprecated, char *metric_constraint),
+		      char *deprecated, char *perchip, char *percore,
+		      char *metric_constraint),
 	  void *data)
 {
 	int err;
@@ -548,6 +560,8 @@ int json_events(const char *fn,
 		char *metric_name = NULL;
 		char *metric_group = NULL;
 		char *deprecated = NULL;
+		char *perchip = NULL;
+		char *percore = NULL;
 		char *metric_constraint = NULL;
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
@@ -629,6 +643,10 @@ int json_events(const char *fn,
 				addfield(map, &perpkg, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &deprecated, "", "", val);
+			} else if (json_streq(map, field, "PerChip")) {
+				addfield(map, &perchip, "", "", val);
+			} else if (json_streq(map, field, "PerCore")) {
+				addfield(map, &percore, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
 				addfield(map, &metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
@@ -676,13 +694,15 @@ int json_events(const char *fn,
 					&long_desc, &pmu, &filter, &perpkg,
 					&unit, &metric_expr, &metric_name,
 					&metric_group, eventcode,
-					&deprecated, &metric_constraint);
+					&deprecated, &perchip, &percore,
+					&metric_constraint);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
 			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated, metric_constraint);
+			   metric_group, deprecated, perchip, percore,
+			   metric_constraint);
 free_strings:
 		free(event);
 		free(desc);
@@ -693,6 +713,8 @@ int json_events(const char *fn,
 		free(filter);
 		free(perpkg);
 		free(deprecated);
+		free(perchip);
+		free(percore);
 		free(unit);
 		free(metric_expr);
 		free(metric_name);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2afc8304529e..3c439ecdac7c 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -8,7 +8,8 @@ int json_events(const char *fn,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint),
+				char *deprecated, char *perchip, char *percore,
+				char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c8f306b572f4..13d96b732963 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -19,6 +19,8 @@ struct pmu_event {
 	const char *metric_group;
 	const char *deprecated;
 	const char *metric_constraint;
+	const char *perchip;
+	const char *percore;
 };
 
 /*
-- 
2.26.2
