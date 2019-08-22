From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/25] libperf: Move perf's cpu_map__idx() to perf_cpu_map__idx()
Date: Thu, 22 Aug 2019 18:00:39 -0300
Message-ID: <20190822210100.3461-5-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

As an internal function that will be used by both perf and libperf, but
is not exported at this point.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190822111141.25823-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c                  | 12 ++++++++++++
 tools/perf/lib/include/internal/cpumap.h |  2 ++
 tools/perf/util/cpumap.c                 | 14 +-------------
 tools/perf/util/cpumap.h                 |  1 -
 tools/perf/util/evlist.c                 |  2 +-
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 63f7df7e47ff..2834753576b2 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -242,3 +242,15 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 {
 	return map ? map->map[0] == -1 : true;
 }
+
+int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
+{
+	int i;
+
+	for (i = 0; i < cpus->nr; ++i) {
+		if (cpus->map[i] == cpu)
+			return i;
+	}
+
+	return -1;
+}
diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/perf/lib/include/internal/cpumap.h
index 3306319f7df8..840d4032587b 100644
--- a/tools/perf/lib/include/internal/cpumap.h
+++ b/tools/perf/lib/include/internal/cpumap.h
@@ -14,4 +14,6 @@ struct perf_cpu_map {
 #define MAX_NR_CPUS	2048
 #endif
 
+int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
+
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 4402e67445a4..8e6c2cbffedc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -458,19 +458,7 @@ int cpu__setup_cpunode_map(void)
 
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
 {
-	return cpu_map__idx(cpus, cpu) != -1;
-}
-
-int cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
-{
-	int i;
-
-	for (i = 0; i < cpus->nr; ++i) {
-		if (cpus->map[i] == cpu)
-			return i;
-	}
-
-	return -1;
+	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx)
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 3e068090612f..8dbedda7af45 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -62,5 +62,4 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
-int cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ba49b5ecffd0..8582560b59af 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -758,7 +758,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		if (evsel->system_wide && thread)
 			continue;
 
-		cpu = cpu_map__idx(evsel->core.cpus, evlist_cpu);
+		cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
 		if (cpu == -1)
 			continue;
 
-- 
2.21.0
