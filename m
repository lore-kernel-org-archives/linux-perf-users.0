From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/44] perf tools: Preserve eBPF maps when loading kcore
Date: Mon, 27 May 2019 19:37:23 -0300
Message-ID: <20190527223730.11474-38-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stanislav Fomichev <sdf@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need to preserve eBPF maps even if they are covered by kcore, because
we need to access eBPF dso for source data.

Add the map_groups__merge_in function to do that.  It merges a map into
map_groups by splitting the new map within the existing map regions.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 97 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5cbad55cd99d..29780fcd049c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1166,6 +1166,85 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
+/*
+ * Merges map into map_groups by splitting the new map
+ * within the existing map regions.
+ */
+static int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
+{
+	struct map *old_map;
+	LIST_HEAD(merged);
+
+	for (old_map = map_groups__first(kmaps); old_map;
+	     old_map = map_groups__next(old_map)) {
+
+		/* no overload with this one */
+		if (new_map->end < old_map->start ||
+		    new_map->start >= old_map->end)
+			continue;
+
+		if (new_map->start < old_map->start) {
+			/*
+			 * |new......
+			 *       |old....
+			 */
+			if (new_map->end < old_map->end) {
+				/*
+				 * |new......|     -> |new..|
+				 *       |old....| ->       |old....|
+				 */
+				new_map->end = old_map->start;
+			} else {
+				/*
+				 * |new.............| -> |new..|       |new..|
+				 *       |old....|    ->       |old....|
+				 */
+				struct map *m = map__clone(new_map);
+
+				if (!m)
+					return -ENOMEM;
+
+				m->end = old_map->start;
+				list_add_tail(&m->node, &merged);
+				new_map->start = old_map->end;
+			}
+		} else {
+			/*
+			 *      |new......
+			 * |old....
+			 */
+			if (new_map->end < old_map->end) {
+				/*
+				 *      |new..|   -> x
+				 * |old.........| -> |old.........|
+				 */
+				map__put(new_map);
+				new_map = NULL;
+				break;
+			} else {
+				/*
+				 *      |new......| ->         |new...|
+				 * |old....|        -> |old....|
+				 */
+				new_map->start = old_map->end;
+			}
+		}
+	}
+
+	while (!list_empty(&merged)) {
+		old_map = list_entry(merged.next, struct map, node);
+		list_del_init(&old_map->node);
+		map_groups__insert(kmaps, old_map);
+		map__put(old_map);
+	}
+
+	if (new_map) {
+		map_groups__insert(kmaps, new_map);
+		map__put(new_map);
+	}
+	return 0;
+}
+
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
@@ -1222,7 +1301,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 
-		if (old_map != map)
+		/*
+		 * We need to preserve eBPF maps even if they are
+		 * covered by kcore, because we need to access
+		 * eBPF dso for source data.
+		 */
+		if (old_map != map && !__map__is_bpf_prog(old_map))
 			map_groups__remove(kmaps, old_map);
 		old_map = next;
 	}
@@ -1256,11 +1340,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			map_groups__remove(kmaps, map);
 			map_groups__insert(kmaps, map);
 			map__put(map);
+			map__put(new_map);
 		} else {
-			map_groups__insert(kmaps, new_map);
+			/*
+			 * Merge kcore map into existing maps,
+			 * and ensure that current maps (eBPF)
+			 * stay intact.
+			 */
+			if (map_groups__merge_in(kmaps, new_map))
+				goto out_err;
 		}
-
-		map__put(new_map);
 	}
 
 	if (machine__is(machine, "x86_64")) {
-- 
2.20.1
