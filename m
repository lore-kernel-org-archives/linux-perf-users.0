From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/26] perf map: Pass a dso_id to map__new()
Date: Fri, 22 Nov 2019 11:56:47 -0300
Message-ID: <20191122145711.3171-3-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of the 4 fields, a step in the direction of moving this to
struct dso.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-gp5s1xgxacurmih5d1l94ymy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 15 ++++++++-------
 tools/perf/util/map.c     | 13 +++++++------
 tools/perf/util/map.h     |  3 +--
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 71ee078d30f4..41b4263c073d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1651,6 +1651,12 @@ int machine__process_mmap2_event(struct machine *machine,
 {
 	struct thread *thread;
 	struct map *map;
+	struct dso_id dso_id = {
+		.maj = event->mmap2.maj,
+		.min = event->mmap2.min,
+		.ino = event->mmap2.ino,
+		.ino_generation = event->mmap2.ino_generation,
+	};
 	int ret = 0;
 
 	if (dump_trace)
@@ -1671,10 +1677,7 @@ int machine__process_mmap2_event(struct machine *machine,
 
 	map = map__new(machine, event->mmap2.start,
 			event->mmap2.len, event->mmap2.pgoff,
-			event->mmap2.maj,
-			event->mmap2.min, event->mmap2.ino,
-			event->mmap2.ino_generation,
-			event->mmap2.prot,
+			&dso_id, event->mmap2.prot,
 			event->mmap2.flags,
 			event->mmap2.filename, thread);
 
@@ -1727,9 +1730,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 
 	map = map__new(machine, event->mmap.start,
 			event->mmap.len, event->mmap.pgoff,
-			0, 0, 0, 0, prot, 0,
-			event->mmap.filename,
-			thread);
+			NULL, prot, 0, event->mmap.filename, thread);
 
 	if (map == NULL)
 		goto out_problem_map;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 4f50b1b2961f..812d663ebb57 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -144,8 +144,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
-		     u64 ino_gen, u32 prot, u32 flags, char *filename,
+		     u64 pgoff, struct dso_id *id,
+		     u32 prot, u32 flags, char *filename,
 		     struct thread *thread)
 {
 	struct map *map = malloc(sizeof(*map));
@@ -162,10 +162,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
 
-		map->dso_id.maj = d_maj;
-		map->dso_id.min = d_min;
-		map->dso_id.ino = ino;
-		map->dso_id.ino_generation = ino_gen;
+		if (id)
+			map->dso_id = *id;
+		else
+			map->dso_id.min = map->dso_id.ino = map->dso_id.ino_generation = 0;
+
 		map->prot = prot;
 		map->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 70d87dcbe35d..f962eb9035c7 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -117,8 +117,7 @@ struct thread;
 void map__init(struct map *map,
 	       u64 start, u64 end, u64 pgoff, struct dso *dso);
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
-		     u64 ino_gen, u32 prot, u32 flags,
+		     u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
 		     char *filename, struct thread *thread);
 struct map *map__new2(u64 start, struct dso *dso);
 void map__delete(struct map *map);
-- 
2.21.0
