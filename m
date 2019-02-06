From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/53] perf record: Apply affinity masks when reading mmap buffers
Date: Wed,  6 Feb 2019 15:48:40 -0300
Message-ID: <20190206184903.24054-31-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Build node cpu masks for mmap data buffers. Apply node cpu masks to tool
thread every time it references data buffers cross node or cross cpu.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/b25e4ebc-078d-2c7b-216c-f0bed108d073@linux.intel.com
[ Use cpu-set-sched.h to get the CPU_{EQUAL,OR}() fallbacks for older systems ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 15 +++++++++++++++
 tools/perf/util/cpumap.c    | 10 ++++++++++
 tools/perf/util/cpumap.h    |  1 +
 tools/perf/util/mmap.c      | 28 +++++++++++++++++++++++++++-
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7ced5f3e8100..3fdfbaebd95e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -38,6 +38,7 @@
 #include "util/bpf-loader.h"
 #include "util/trigger.h"
 #include "util/perf-hooks.h"
+#include "util/cpu-set-sched.h"
 #include "util/time-utils.h"
 #include "util/units.h"
 #include "util/bpf-event.h"
@@ -536,6 +537,9 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
 
+	if (opts->affinity != PERF_AFFINITY_SYS)
+		cpu__setup_cpunode_map();
+
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
@@ -719,6 +723,16 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
+{
+	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
+	    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
+		CPU_ZERO(&rec->affinity_mask);
+		CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
+		sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
+	}
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite)
 {
@@ -746,6 +760,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+			record__adjust_affinity(rec, map);
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 					rc = -1;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 383674f448fc..0bbc3feb0894 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -730,3 +730,13 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
 	buf[size - 1] = '\0';
 	return ptr - buf;
 }
+
+const struct cpu_map *cpu_map__online(void) /* thread unsafe */
+{
+	static const struct cpu_map *online = NULL;
+
+	if (!online)
+		online = cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
+
+	return online;
+}
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index ed8999d1a640..f00ce624b9f7 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -29,6 +29,7 @@ int cpu_map__get_core_id(int cpu);
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
 int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep);
+const struct cpu_map *cpu_map__online(void); /* thread unsafe */
 
 struct cpu_map *cpu_map__get(struct cpu_map *map);
 void cpu_map__put(struct cpu_map *map);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index d882f43148c3..cdc7740fc181 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -383,6 +383,32 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
+static void build_node_mask(int node, cpu_set_t *mask)
+{
+	int c, cpu, nr_cpus;
+	const struct cpu_map *cpu_map = NULL;
+
+	cpu_map = cpu_map__online();
+	if (!cpu_map)
+		return;
+
+	nr_cpus = cpu_map__nr(cpu_map);
+	for (c = 0; c < nr_cpus; c++) {
+		cpu = cpu_map->map[c]; /* map c index to online cpu index */
+		if (cpu__get_node(cpu) == node)
+			CPU_SET(cpu, mask);
+	}
+}
+
+static void perf_mmap__setup_affinity_mask(struct perf_mmap *map, struct mmap_params *mp)
+{
+	CPU_ZERO(&map->affinity_mask);
+	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
+		build_node_mask(cpu__get_node(map->cpu), &map->affinity_mask);
+	else if (mp->affinity == PERF_AFFINITY_CPU)
+		CPU_SET(map->cpu, &map->affinity_mask);
+}
+
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
@@ -412,7 +438,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 	map->fd = fd;
 	map->cpu = cpu;
 
-	CPU_ZERO(&map->affinity_mask);
+	perf_mmap__setup_affinity_mask(map, mp);
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
-- 
2.20.1
