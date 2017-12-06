From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/36] perf pmu: Pass pmu as a parameter to get_cpuid_str()
Date: Wed,  6 Dec 2017 11:40:58 -0300
Message-ID: <20171206144115.15097-20-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Jayachandran C <jnair@caviumnetworks.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Robert Richter <robert.richter@cavium.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

The cpuid string will not be same on all CPUs on heterogeneous platforms
like ARM's big.LITTLE, adding provision(using pmu->cpus) to find cpuid
string from associated CPUs of PMU CORE device.

Also optimise arguments to function pmu_add_cpu_aliases.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@cavium.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Link: http://lkml.kernel.org/r/20171016183222.25750-2-ganapatrao.kulkarni@cavium.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/header.c |  2 +-
 tools/perf/arch/x86/util/header.c     |  2 +-
 tools/perf/util/header.h              |  3 ++-
 tools/perf/util/metricgroup.c         |  4 ++--
 tools/perf/util/pmu.c                 | 22 +++++++++++-----------
 tools/perf/util/pmu.h                 |  2 +-
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 7a4cf80c207a..0b242664f5ea 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -35,7 +35,7 @@ get_cpuid(char *buffer, size_t sz)
 }
 
 char *
-get_cpuid_str(void)
+get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *bufp;
 
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 33027c5e6f92..b626d2bad9f1 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -66,7 +66,7 @@ get_cpuid(char *buffer, size_t sz)
 }
 
 char *
-get_cpuid_str(void)
+get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *buf = malloc(128);
 
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 91befc3b550d..317fb901e47f 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include "event.h"
 #include "env.h"
+#include "pmu.h"
 
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
@@ -171,5 +172,5 @@ int write_padded(struct feat_fd *fd, const void *bf,
  */
 int get_cpuid(char *buffer, size_t sz);
 
-char *get_cpuid_str(void);
+char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6fd709017bbc..e48410c99b39 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -274,7 +274,7 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw)
 {
-	struct pmu_events_map *map = perf_pmu__find_map();
+	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
 	int i;
 	struct rblist groups;
@@ -372,7 +372,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
-	struct pmu_events_map *map = perf_pmu__find_map();
+	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
 	int ret = -EINVAL;
 	int i, j;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 80fb1593913a..4e7dd3a0f123 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -542,12 +542,12 @@ static bool pmu_is_uncore(const char *name)
  * Each architecture should provide a more precise id string that
  * can be use to match the architecture's "mapfile".
  */
-char * __weak get_cpuid_str(void)
+char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	return NULL;
 }
 
-static char *perf_pmu__getcpuid(void)
+static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 {
 	char *cpuid;
 	static bool printed;
@@ -556,7 +556,7 @@ static char *perf_pmu__getcpuid(void)
 	if (cpuid)
 		cpuid = strdup(cpuid);
 	if (!cpuid)
-		cpuid = get_cpuid_str();
+		cpuid = get_cpuid_str(pmu);
 	if (!cpuid)
 		return NULL;
 
@@ -567,10 +567,10 @@ static char *perf_pmu__getcpuid(void)
 	return cpuid;
 }
 
-struct pmu_events_map *perf_pmu__find_map(void)
+struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 {
 	struct pmu_events_map *map;
-	char *cpuid = perf_pmu__getcpuid();
+	char *cpuid = perf_pmu__getcpuid(pmu);
 	int i;
 
 	i = 0;
@@ -593,13 +593,14 @@ struct pmu_events_map *perf_pmu__find_map(void)
  * to the current running CPU. Then, add all PMU events from that table
  * as aliases.
  */
-static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
+static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
 	int i;
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
+	const char *name = pmu->name;
 
-	map = perf_pmu__find_map();
+	map = perf_pmu__find_map(pmu);
 	if (!map)
 		return;
 
@@ -661,21 +662,20 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
-	pmu_add_cpu_aliases(&aliases, name);
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(name);
-
+	pmu->name = strdup(name);
+	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
 	list_splice(&format, &pmu->format);
 	list_splice(&aliases, &pmu->aliases);
-	pmu->name = strdup(name);
-	pmu->type = type;
 	list_add_tail(&pmu->list, &pmus);
 
 	pmu->default_config = perf_pmu__get_default_config(pmu);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 27c75e635866..76fecec7b3f9 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -92,6 +92,6 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
-struct pmu_events_map *perf_pmu__find_map(void);
+struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
 #endif /* __PMU_H */
-- 
2.13.6
