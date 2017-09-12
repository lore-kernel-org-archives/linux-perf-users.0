From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/41] perf vendor events: Support metric_group and no event name in JSON parser
Date: Tue, 12 Sep 2017 12:09:51 -0300
Message-ID: <20170912151029.6612-4-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbdILPKs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 11:10:48 -0400
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Andi Kleen <ak@linux.intel.com>

Some enhancements to the JSON parser to prepare for metrics support

- Parse the new MetricGroup field
- Support JSON events with no event name, that have only MetricName.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c    | 24 ++++++++++++++++++------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  1 +
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index d51dc9ca8861..9eb7047bafe4 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -292,7 +292,7 @@ static int print_events_table_entry(void *data, char *name, char *event,
 				    char *desc, char *long_desc,
 				    char *pmu, char *unit, char *perpkg,
 				    char *metric_expr,
-				    char *metric_name)
+				    char *metric_name, char *metric_group)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -304,8 +304,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	 */
 	fprintf(outfp, "{\n");
 
-	fprintf(outfp, "\t.name = \"%s\",\n", name);
-	fprintf(outfp, "\t.event = \"%s\",\n", event);
+	if (name)
+		fprintf(outfp, "\t.name = \"%s\",\n", name);
+	if (event)
+		fprintf(outfp, "\t.event = \"%s\",\n", event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
 	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
 	if (long_desc && long_desc[0])
@@ -320,6 +322,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.metric_expr = \"%s\",\n", metric_expr);
 	if (metric_name)
 		fprintf(outfp, "\t.metric_name = \"%s\",\n", metric_name);
+	if (metric_group)
+		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -357,6 +361,9 @@ static char *real_event(const char *name, char *event)
 {
 	int i;
 
+	if (!name)
+		return NULL;
+
 	for (i = 0; fixed[i].name; i++)
 		if (!strcasecmp(name, fixed[i].name))
 			return (char *)fixed[i].event;
@@ -369,7 +376,7 @@ int json_events(const char *fn,
 		      char *long_desc,
 		      char *pmu, char *unit, char *perpkg,
 		      char *metric_expr,
-		      char *metric_name),
+		      char *metric_name, char *metric_group),
 	  void *data)
 {
 	int err = -EIO;
@@ -397,6 +404,7 @@ int json_events(const char *fn,
 		char *unit = NULL;
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
+		char *metric_group = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
@@ -476,6 +484,8 @@ int json_events(const char *fn,
 				addfield(map, &perpkg, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
 				addfield(map, &metric_name, "", "", val);
+			} else if (json_streq(map, field, "MetricGroup")) {
+				addfield(map, &metric_group, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
 				addfield(map, &metric_expr, "", "", val);
 				for (s = metric_expr; *s; s++)
@@ -501,10 +511,11 @@ int json_events(const char *fn,
 			addfield(map, &event, ",", filter, NULL);
 		if (msr != NULL)
 			addfield(map, &event, ",", msr->pname, msrval);
-		fixname(name);
+		if (name)
+			fixname(name);
 
 		err = func(data, name, real_event(name, event), desc, long_desc,
-				pmu, unit, perpkg, metric_expr, metric_name);
+			   pmu, unit, perpkg, metric_expr, metric_name, metric_group);
 		free(event);
 		free(desc);
 		free(name);
@@ -516,6 +527,7 @@ int json_events(const char *fn,
 		free(unit);
 		free(metric_expr);
 		free(metric_name);
+		free(metric_group);
 		if (err)
 			break;
 		tok += j;
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 611fac01913d..557994754410 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -6,7 +6,7 @@ int json_events(const char *fn,
 				char *long_desc,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name),
+				char *metric_name, char *metric_group),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 569eab3688dd..94fa1720f6fd 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -15,6 +15,7 @@ struct pmu_event {
 	const char *perpkg;
 	const char *metric_expr;
 	const char *metric_name;
+	const char *metric_group;
 };
 
 /*
-- 
2.13.5
