From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/25] perf maps: Do not use an rbtree to sort by map name
Date: Tue, 19 Nov 2019 08:32:26 -0300
Message-ID: <20191119113245.19593-7-acme@kernel.org>
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

This is only used for the kernel maps, shave 24 bytes out 'struct map'
and just traverse the existing per ip rbtree to look for maps by name,
use a front end cache to reuse the last search if its the same name.

After this 'struct map' is down to just two cachelines:

  $ pahole -C map ~/bin/perf
  struct map {
  	union {
  		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
  		struct list_head node;                   /*     0    16 */
  	} __attribute__((__aligned__(8)));                                               /*     0    24 */
  	u64                        start;                /*    24     8 */
  	u64                        end;                  /*    32     8 */
  	_Bool                      erange_warned;        /*    40     1 */

  	/* XXX 3 bytes hole, try to pack */

  	u32                        priv;                 /*    44     4 */
  	u32                        prot;                 /*    48     4 */
  	u32                        flags;                /*    52     4 */
  	u64                        pgoff;                /*    56     8 */
  	/* --- cacheline 1 boundary (64 bytes) --- */
  	u64                        reloc;                /*    64     8 */
  	u32                        maj;                  /*    72     4 */
  	u32                        min;                  /*    76     4 */
  	u64                        ino;                  /*    80     8 */
  	u64                        ino_generation;       /*    88     8 */
  	u64                        (*map_ip)(struct map *, u64); /*    96     8 */
  	u64                        (*unmap_ip)(struct map *, u64); /*   104     8 */
  	struct dso *               dso;                  /*   112     8 */
  	refcount_t                 refcnt;               /*   120     4 */

  	/* size: 128, cachelines: 2, members: 17 */
  	/* sum members: 121, holes: 1, sum holes: 3 */
  	/* padding: 4 */
  	/* forced alignments: 1 */
  } __attribute__((__aligned__(8)));
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bvr8fqfgzxtgnhnwt5sssx5g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/map_groups.c |  2 +-
 tools/perf/util/map.c         | 30 ------------------------------
 tools/perf/util/map.h         |  1 -
 tools/perf/util/map_groups.h  |  1 -
 tools/perf/util/symbol.c      | 16 ++--------------
 5 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index b52adad55f8d..6b9f1cdcbe5b 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -25,7 +25,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct map_grou
 		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
 		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
 		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
-		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 2);
+		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
 
 		i++;
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 69b9e9b3d915..49e353eaa337 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -26,7 +26,6 @@
 #include "ui/ui.h"
 
 static void __maps__insert(struct maps *maps, struct map *map);
-static void __maps__insert_name(struct maps *maps, struct map *map);
 
 static inline int is_anon_memory(const char *filename, u32 flags)
 {
@@ -566,7 +565,6 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 static void maps__init(struct maps *maps)
 {
 	maps->entries = RB_ROOT;
-	maps->names = RB_ROOT;
 	init_rwsem(&maps->lock);
 }
 
@@ -589,8 +587,6 @@ static void __maps__purge(struct maps *maps)
 	maps__for_each_entry_safe(maps, pos, next) {
 		rb_erase_init(&pos->rb_node,  &maps->entries);
 		map__put(pos);
-		rb_erase_init(&pos->rb_node_name, &maps->names);
-		map__put(pos);
 	}
 }
 
@@ -736,7 +732,6 @@ size_t map_groups__fprintf(struct map_groups *mg, FILE *fp)
 static void __map_groups__insert(struct map_groups *mg, struct map *map)
 {
 	__maps__insert(&mg->maps, map);
-	__maps__insert_name(&mg->maps, map);
 }
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
@@ -893,32 +888,10 @@ static void __maps__insert(struct maps *maps, struct map *map)
 	map__get(map);
 }
 
-static void __maps__insert_name(struct maps *maps, struct map *map)
-{
-	struct rb_node **p = &maps->names.rb_node;
-	struct rb_node *parent = NULL;
-	struct map *m;
-	int rc;
-
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map, rb_node_name);
-		rc = strcmp(m->dso->short_name, map->dso->short_name);
-		if (rc < 0)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
-	rb_link_node(&map->rb_node_name, parent, p);
-	rb_insert_color(&map->rb_node_name, &maps->names);
-	map__get(map);
-}
-
 void maps__insert(struct maps *maps, struct map *map)
 {
 	down_write(&maps->lock);
 	__maps__insert(maps, map);
-	__maps__insert_name(maps, map);
 	up_write(&maps->lock);
 }
 
@@ -926,9 +899,6 @@ static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
-
-	rb_erase_init(&map->rb_node_name, &maps->names);
-	map__put(map);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 365deb6375ab..a31e80991189 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -23,7 +23,6 @@ struct map {
 		struct rb_node	rb_node;
 		struct list_head node;
 	};
-	struct rb_node          rb_node_name;
 	u64			start;
 	u64			end;
 	bool			erange_warned;
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 3f361405a4d4..26fc68bd4f60 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -16,7 +16,6 @@ struct thread;
 
 struct maps {
 	struct rb_root      entries;
-	struct rb_root	    names;
 	struct rw_semaphore lock;
 };
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 88f4cfbdb69a..0fb9bd8bcf0d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1764,24 +1764,12 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 {
 	struct maps *maps = &mg->maps;
 	struct map *map;
-	struct rb_node *node;
 
 	down_read(&maps->lock);
 
-	for (node = maps->names.rb_node; node; ) {
-		int rc;
-
-		map = rb_entry(node, struct map, rb_node_name);
-
-		rc = strcmp(map->dso->short_name, name);
-		if (rc < 0)
-			node = node->rb_left;
-		else if (rc > 0)
-			node = node->rb_right;
-		else
-
+	maps__for_each_entry(maps, map)
+		if (strcmp(map->dso->short_name, name) == 0)
 			goto out_unlock;
-	}
 
 	map = NULL;
 
-- 
2.21.0
