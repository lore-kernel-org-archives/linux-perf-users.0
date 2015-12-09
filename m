From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 09/22] perf: Make cpu_map to use refcnt for debug
Date: Wed, 09 Dec 2015 11:11:07 +0900
Message-ID: <20151209021107.10245.33413.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Make 'cpu_map' object to use refcnt interface for debug.
This can find refcnt related memory leaks.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/cpumap.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 10af1e7..cca94d3 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -23,7 +23,7 @@ static struct cpu_map *cpu_map__default_new(void)
 			cpus->map[i] = i;
 
 		cpus->nr = nr_cpus;
-		atomic_set(&cpus->refcnt, 1);
+		refcnt__init_as(cpus, refcnt, 1, "cpu_map");
 	}
 
 	return cpus;
@@ -37,7 +37,7 @@ static struct cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 	if (cpus != NULL) {
 		cpus->nr = nr_cpus;
 		memcpy(cpus->map, tmp_cpus, payload_size);
-		atomic_set(&cpus->refcnt, 1);
+		refcnt__init_as(cpus, refcnt, 1, "cpu_map");
 	}
 
 	return cpus;
@@ -197,7 +197,7 @@ struct cpu_map *cpu_map__dummy_new(void)
 	if (cpus != NULL) {
 		cpus->nr = 1;
 		cpus->map[0] = -1;
-		atomic_set(&cpus->refcnt, 1);
+		refcnt__init_as(cpus, refcnt, 1, "cpu_map");
 	}
 
 	return cpus;
@@ -214,32 +214,33 @@ struct cpu_map *cpu_map__empty_new(int nr)
 		for (i = 0; i < nr; i++)
 			cpus->map[i] = -1;
 
-		atomic_set(&cpus->refcnt, 1);
+		refcnt__init_as(cpus, refcnt, 1, "cpu_map");
 	}
 
 	return cpus;
 }
 
-static void cpu_map__delete(struct cpu_map *map)
+static void cpu_map__delete(struct cpu_map *cpus)
 {
-	if (map) {
-		WARN_ONCE(atomic_read(&map->refcnt) != 0,
+	if (cpus) {
+		WARN_ONCE(atomic_read(&cpus->refcnt) != 0,
 			  "cpu_map refcnt unbalanced\n");
-		free(map);
+		refcnt__exit(cpus, refcnt);
+		free(cpus);
 	}
 }
 
-struct cpu_map *cpu_map__get(struct cpu_map *map)
+struct cpu_map *cpu_map__get(struct cpu_map *cpus)
 {
-	if (map)
-		atomic_inc(&map->refcnt);
-	return map;
+	if (cpus)
+		refcnt__get(cpus, refcnt);
+	return cpus;
 }
 
-void cpu_map__put(struct cpu_map *map)
+void cpu_map__put(struct cpu_map *cpus)
 {
-	if (map && atomic_dec_and_test(&map->refcnt))
-		cpu_map__delete(map);
+	if (cpus && refcnt__put(cpus, refcnt))
+		cpu_map__delete(cpus);
 }
 
 static int cpu__get_topology_int(int cpu, const char *name, int *value)
@@ -302,7 +303,7 @@ int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(int), cmp_ids);
 
-	atomic_set(&c->refcnt, 1);
+	refcnt__init_as(c, refcnt, 1, "cpu_map");
 	*res = c;
 	return 0;
 }
