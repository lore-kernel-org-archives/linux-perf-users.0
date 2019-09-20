From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/31] libperf: Adopt perf_cpu_map__max() function
Date: Fri, 20 Sep 2019 11:25:15 -0300
Message-ID: <20190920142542.12047-5-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Joe Mario <jmario@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

From 'perf stat', so that it can be used from multiple places.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190902121255.536-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c            | 14 +-------------
 tools/perf/lib/cpumap.c              | 12 ++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  1 +
 tools/perf/lib/libperf.map           |  1 +
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7e17bf9f700a..5bc0c570b7b6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -822,18 +822,6 @@ static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 	return cpu_map__get_core(map, cpu, NULL);
 }
 
-static int cpu_map__get_max(struct perf_cpu_map *map)
-{
-	int i, max = -1;
-
-	for (i = 0; i < map->nr; i++) {
-		if (map->map[i] > max)
-			max = map->map[i];
-	}
-
-	return max;
-}
-
 static int perf_stat__get_aggr(struct perf_stat_config *config,
 			       aggr_get_id_t get_id, struct perf_cpu_map *map, int idx)
 {
@@ -928,7 +916,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = cpu_map__get_max(evsel_list->core.cpus);
+	nr = perf_cpu_map__max(evsel_list->core.cpus);
 	stat_config.cpus_aggr_map = perf_cpu_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 1f0e6f334237..2ca1fafa620d 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -260,3 +260,15 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
 
 	return -1;
 }
+
+int perf_cpu_map__max(struct perf_cpu_map *map)
+{
+	int i, max = -1;
+
+	for (i = 0; i < map->nr; i++) {
+		if (map->map[i] > max)
+			max = map->map[i];
+	}
+
+	return max;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index 8aa995c59498..ac9aa497f84a 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -16,6 +16,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
+LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index dc4d66363bc4..cd0d17b996c8 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -9,6 +9,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__empty;
+		perf_cpu_map__max;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
-- 
2.21.0
