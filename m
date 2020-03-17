From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/23] perf jevents: Support metric constraint
Date: Tue, 17 Mar 2020 18:32:38 -0300
Message-ID: <20200317213259.15494-3-acme@kernel.org>
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

A new field "MetricConstraint" is introduced in JSON event list.

Extend jevents to parse the field and save the value in
metric_constraint.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c    | 19 +++++++++++++------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 079c77b6a2fd..6d0f61ffee42 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -323,7 +323,7 @@ static int print_events_table_entry(void *data, char *name, char *event,
 				    char *pmu, char *unit, char *perpkg,
 				    char *metric_expr,
 				    char *metric_name, char *metric_group,
-				    char *deprecated)
+				    char *deprecated, char *metric_constraint)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -357,6 +357,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
 	if (deprecated)
 		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
+	if (metric_constraint)
+		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -375,6 +377,7 @@ struct event_struct {
 	char *metric_name;
 	char *metric_group;
 	char *deprecated;
+	char *metric_constraint;
 };
 
 #define ADD_EVENT_FIELD(field) do { if (field) {		\
@@ -422,7 +425,7 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated)
+				char *deprecated, char *metric_constraint)
 {
 	struct event_struct *es;
 
@@ -486,7 +489,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
 	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
 	  char **metric_group, unsigned long long eventcode,
-	  char **deprecated)
+	  char **deprecated, char **metric_constraint)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -515,7 +518,7 @@ int json_events(const char *fn,
 		      char *pmu, char *unit, char *perpkg,
 		      char *metric_expr,
 		      char *metric_name, char *metric_group,
-		      char *deprecated),
+		      char *deprecated, char *metric_constraint),
 	  void *data)
 {
 	int err;
@@ -545,6 +548,7 @@ int json_events(const char *fn,
 		char *metric_name = NULL;
 		char *metric_group = NULL;
 		char *deprecated = NULL;
+		char *metric_constraint = NULL;
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
@@ -629,6 +633,8 @@ int json_events(const char *fn,
 				addfield(map, &metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
 				addfield(map, &metric_group, "", "", val);
+			} else if (json_streq(map, field, "MetricConstraint")) {
+				addfield(map, &metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
 				addfield(map, &metric_expr, "", "", val);
 				for (s = metric_expr; *s; s++)
@@ -670,13 +676,13 @@ int json_events(const char *fn,
 					&long_desc, &pmu, &filter, &perpkg,
 					&unit, &metric_expr, &metric_name,
 					&metric_group, eventcode,
-					&deprecated);
+					&deprecated, &metric_constraint);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
 			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated);
+			   metric_group, deprecated, metric_constraint);
 free_strings:
 		free(event);
 		free(desc);
@@ -691,6 +697,7 @@ int json_events(const char *fn,
 		free(metric_expr);
 		free(metric_name);
 		free(metric_group);
+		free(metric_constraint);
 		free(arch_std);
 
 		if (err)
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 5cda49a42143..2afc8304529e 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -8,7 +8,7 @@ int json_events(const char *fn,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated),
+				char *deprecated, char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index caeb577d36c9..53e76d5d5b37 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -18,6 +18,7 @@ struct pmu_event {
 	const char *metric_name;
 	const char *metric_group;
 	const char *deprecated;
+	const char *metric_constraint;
 };
 
 /*
-- 
2.21.1
