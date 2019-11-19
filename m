From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/25] perf maps: Purge the entries from maps->names in __maps__purge()
Date: Tue, 19 Nov 2019 08:32:25 -0300
Message-ID: <20191119113245.19593-6-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to iterate via the ->names rbtree, as all the entries there
as in maps->entries as well, reuse __maps__purge() for that.

Doing it this way we can kill maps__for_each_entry_by_name(),
maps__for_each_entry_by_name_safe(), maps__{first,next}_by_name().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ps0nrio8pydyo23rr2s696ue@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c        | 34 +---------------------------------
 tools/perf/util/map_groups.h |  8 --------
 2 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 359846833a00..69b9e9b3d915 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -589,15 +589,7 @@ static void __maps__purge(struct maps *maps)
 	maps__for_each_entry_safe(maps, pos, next) {
 		rb_erase_init(&pos->rb_node,  &maps->entries);
 		map__put(pos);
-	}
-}
-
-static void __maps__purge_names(struct maps *maps)
-{
-	struct map *pos, *next;
-
-	maps__for_each_entry_by_name_safe(maps, pos, next) {
-		rb_erase_init(&pos->rb_node_name,  &maps->names);
+		rb_erase_init(&pos->rb_node_name, &maps->names);
 		map__put(pos);
 	}
 }
@@ -606,7 +598,6 @@ static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
-	__maps__purge_names(maps);
 	up_write(&maps->lock);
 }
 
@@ -994,29 +985,6 @@ struct map *map__next(struct map *map)
 	return map ? __map__next(map) : NULL;
 }
 
-struct map *maps__first_by_name(struct maps *maps)
-{
-	struct rb_node *first = rb_first(&maps->names);
-
-	if (first)
-		return rb_entry(first, struct map, rb_node_name);
-	return NULL;
-}
-
-static struct map *__map__next_by_name(struct map *map)
-{
-	struct rb_node *next = rb_next(&map->rb_node_name);
-
-	if (next)
-		return rb_entry(next, struct map, rb_node_name);
-	return NULL;
-}
-
-struct map *map__next_by_name(struct map *map)
-{
-	return map ? __map__next_by_name(map) : NULL;
-}
-
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 99cb810acc7c..3f361405a4d4 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -33,14 +33,6 @@ struct map *map__next(struct map *map);
 	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
 
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
-struct map *maps__first_by_name(struct maps *maps);
-struct map *map__next_by_name(struct map *map);
-
-#define maps__for_each_entry_by_name(maps, map) \
-	for (map = maps__first_by_name(maps); map; map = map__next_by_name(map))
-
-#define maps__for_each_entry_by_name_safe(maps, map, next) \
-	for (map = maps__first_by_name(maps), next = map__next_by_name(map); map; map = next, next = map__next_by_name(map))
 
 struct map_groups {
 	struct maps	 maps;
-- 
2.21.0
