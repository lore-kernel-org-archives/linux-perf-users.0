From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/41] perf pmu: Extract function to get JSON alias map
Date: Tue, 12 Sep 2017 12:09:54 -0300
Message-ID: <20170912151029.6612-7-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Extract the code to get the per cpu JSON alias into a separate function
for reuse. No behavior changes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-6-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 49 +++++++++++++++++++++++++++++++++----------------
 tools/perf/util/pmu.h |  2 ++
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ac16a9db1fb5..ed25d7f88731 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -516,16 +516,8 @@ char * __weak get_cpuid_str(void)
 	return NULL;
 }
 
-/*
- * From the pmu_events_map, find the table of PMU events that corresponds
- * to the current running CPU. Then, add all PMU events from that table
- * as aliases.
- */
-static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
+static char *perf_pmu__getcpuid(void)
 {
-	int i;
-	struct pmu_events_map *map;
-	struct pmu_event *pe;
 	char *cpuid;
 	static bool printed;
 
@@ -535,22 +527,50 @@ static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
 	if (!cpuid)
 		cpuid = get_cpuid_str();
 	if (!cpuid)
-		return;
+		return NULL;
 
 	if (!printed) {
 		pr_debug("Using CPUID %s\n", cpuid);
 		printed = true;
 	}
+	return cpuid;
+}
+
+struct pmu_events_map *perf_pmu__find_map(void)
+{
+	struct pmu_events_map *map;
+	char *cpuid = perf_pmu__getcpuid();
+	int i;
 
 	i = 0;
-	while (1) {
+	for (;;) {
 		map = &pmu_events_map[i++];
-		if (!map->table)
-			goto out;
+		if (!map->table) {
+			map = NULL;
+			break;
+		}
 
 		if (!strcmp(map->cpuid, cpuid))
 			break;
 	}
+	free(cpuid);
+	return map;
+}
+
+/*
+ * From the pmu_events_map, find the table of PMU events that corresponds
+ * to the current running CPU. Then, add all PMU events from that table
+ * as aliases.
+ */
+static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
+{
+	int i;
+	struct pmu_events_map *map;
+	struct pmu_event *pe;
+
+	map = perf_pmu__find_map();
+	if (!map)
+		return;
 
 	/*
 	 * Found a matching PMU events table. Create aliases
@@ -575,9 +595,6 @@ static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
 				(char *)pe->metric_expr,
 				(char *)pe->metric_name);
 	}
-
-out:
-	free(cpuid);
 }
 
 struct perf_event_attr * __weak
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 389e9729331f..060f6abba8ed 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -90,4 +90,6 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
+struct pmu_events_map *perf_pmu__find_map(void);
+
 #endif /* __PMU_H */
-- 
2.13.5
