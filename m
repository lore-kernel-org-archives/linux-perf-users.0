From: Matheus Marchini <mmarchini@netflix.com>
Subject: [PATCH] perf map: fix infinite loop on map_groups__fixup_overlappings
Date: Wed, 11 Dec 2019 08:07:31 -0800
Message-ID: <20191211160734.18087-1-mmarchini@netflix.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: jkoch@netflix.com, khlebnikov@yandex-team.ru, Matheus Marchini <mmarchini@netflix.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Changbin Du <changbin.du@intel.com>, Song Liu <songliubraving@fb.com>, John Keeping <john@metanate.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

In some cases, when using perf inject and there are JIT_CODE_MOVE
records in the jitdump file, perf will end up in an infinite loop on
map_groups__fixup_overlappings, which will keep allocating memory
indefinitely. This issue was observed on Node.js (with changes to
generate JIT_CODE_MOVE records) and on Java.

This issue started to occur after 6a9405b56c274 (perf map:
Optimize maps__fixup_overlappings()). To prevent it from happening,
partially revert those changes without losing the optimizations
introduced in it.

Signed-off-by: Matheus Marchini <mmarchini@netflix.com>
---
 tools/perf/util/map.c | 17 +++++++++++++++++
 tools/perf/util/map.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 744bfbaf35cf..8918fdb8ddab 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -781,6 +781,21 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 	__maps__insert(&mg->maps, map);
 }
 
+int map__overlap(struct map *l, struct map *r)
+{
+	if (l->start > r->start) {
+		struct map *t = l;
+
+		l = r;
+		r = t;
+	}
+
+	if (l->end > r->start)
+		return 1;
+
+	return 0;
+}
+
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
 {
 	struct maps *maps = &mg->maps;
@@ -821,6 +836,8 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE
 		 */
 		if (pos->start >= map->end)
 			break;
+		if (!map__overlap(map, pos))
+			continue;
 
 		if (verbose >= 2) {
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 5e8899883231..1383571437aa 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -132,6 +132,7 @@ static inline void __map__zput(struct map **map)
 
 #define map__zput(map) __map__zput(&map)
 
+int map__overlap(struct map *l, struct map *r);
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
-- 
2.17.1
