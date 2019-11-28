From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/22] perf map: Remove unused functions
Date: Thu, 28 Nov 2019 10:40:09 -0300
Message-ID: <20191128134027.23726-5-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At some point those stopped being used, prune them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p2k98mj3ff2uk1z95sbl5r6e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c        | 30 ++++++++----------------------
 tools/perf/util/map_groups.h |  5 -----
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b59944eb469e..267d951b5dfd 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -568,6 +568,12 @@ void map_groups__insert(struct map_groups *mg, struct map *map)
 	up_write(&maps->lock);
 }
 
+static void __maps__remove(struct maps *maps, struct map *map)
+{
+	rb_erase_init(&map->rb_node, &maps->entries);
+	map__put(map);
+}
+
 void map_groups__remove(struct map_groups *mg, struct map *map)
 {
 	struct maps *maps = &mg->maps;
@@ -654,8 +660,8 @@ static bool map__contains_symbol(struct map *map, struct symbol *sym)
 	return ip >= map->start && ip < map->end;
 }
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
-					 struct map **mapp)
+static struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
+						struct map **mapp)
 {
 	struct symbol *sym;
 	struct map *pos;
@@ -890,26 +896,6 @@ static void __maps__insert(struct maps *maps, struct map *map)
 	map__get(map);
 }
 
-void maps__insert(struct maps *maps, struct map *map)
-{
-	down_write(&maps->lock);
-	__maps__insert(maps, map);
-	up_write(&maps->lock);
-}
-
-void __maps__remove(struct maps *maps, struct map *map)
-{
-	rb_erase_init(&map->rb_node, &maps->entries);
-	map__put(map);
-}
-
-void maps__remove(struct maps *maps, struct map *map)
-{
-	down_write(&maps->lock);
-	__maps__remove(maps, map);
-	up_write(&maps->lock);
-}
-
 struct map *maps__find(struct maps *maps, u64 ip)
 {
 	struct rb_node *p;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 63ed211fe241..f6270243ac4b 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -19,9 +19,6 @@ struct maps {
 	struct rw_semaphore lock;
 };
 
-void maps__insert(struct maps *maps, struct map *map);
-void maps__remove(struct maps *maps, struct map *map);
-void __maps__remove(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 struct map *maps__first(struct maps *maps);
 struct map *map__next(struct map *map);
@@ -32,8 +29,6 @@ struct map *map__next(struct map *map);
 #define maps__for_each_entry_safe(maps, map, next) \
 	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
-
 struct map_groups {
 	struct maps	 maps;
 	struct machine	 *machine;
-- 
2.21.0
