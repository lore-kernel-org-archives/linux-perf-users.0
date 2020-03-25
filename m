From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/24] perf pmu: Refactor pmu_add_cpu_aliases()
Date: Wed, 25 Mar 2020 09:41:18 -0300
Message-ID: <20200325124124.32648-19-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@arm.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

Create pmu_add_cpu_aliases_map() from pmu_add_cpu_aliases(), so the caller
can pass the map; the pmu-events test would use this since there would
be no CPUID matching to a mapfile there.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-4-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 21 +++++++++++++--------
 tools/perf/util/pmu.h |  3 +++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b99fd312aae..c616a06a34a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -21,7 +21,6 @@
 #include "pmu.h"
 #include "parse-events.h"
 #include "header.h"
-#include "pmu-events/pmu-events.h"
 #include "string2.h"
 #include "strbuf.h"
 #include "fncache.h"
@@ -744,16 +743,11 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
  * to the current running CPU. Then, add all PMU events from that table
  * as aliases.
  */
-static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
+void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
+			     struct pmu_events_map *map)
 {
 	int i;
-	struct pmu_events_map *map;
 	const char *name = pmu->name;
-
-	map = perf_pmu__find_map(pmu);
-	if (!map)
-		return;
-
 	/*
 	 * Found a matching PMU events table. Create aliases
 	 */
@@ -788,6 +782,17 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	}
 }
 
+static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
+{
+	struct pmu_events_map *map;
+
+	map = perf_pmu__find_map(pmu);
+	if (!map)
+		return;
+
+	pmu_add_cpu_aliases_map(head, pmu, map);
+}
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6737e3d5d568..0b4a0efae38e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -7,6 +7,7 @@
 #include <linux/perf_event.h>
 #include <stdbool.h>
 #include "parse-events.h"
+#include "pmu-events/pmu-events.h"
 
 struct perf_evsel_config_term;
 
@@ -97,6 +98,8 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
+void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
+			     struct pmu_events_map *map);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
-- 
2.21.1
