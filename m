From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/15] perf map: Remove ->groups from 'struct map'
Date: Tue, 12 Nov 2019 15:37:55 -0300
Message-ID: <20191112183757.28660-14-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With this 'struct map' uses a bit over 3 cachelines:

  $ pahole -C map ~/bin/perf
  <SNIP>
  	/* --- cacheline 2 boundary (128 bytes) --- */
  	u64                        (*unmap_ip)(struct map *, u64); /*   128     8 */
  	struct dso *               dso;                            /*   136     8 */
  	refcount_t                 refcnt;                         /*   144     4 */

  	/* size: 152, cachelines: 3, members: 18 */
  	/* sum members: 145, holes: 1, sum holes: 3 */
  	/* padding: 4 */
  	/* forced alignments: 2 */
  	/* last cacheline: 24 bytes */
  } __attribute__((__aligned__(8)));
  $

We probably can move map->map/unmap_ip() moved to 'struct map_groups',
that will shave more 16 bytes, getting this almost to two cachelines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ymlv3nzpofv2fugnjnizkrwy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 4 ----
 tools/perf/util/map.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 27d8508f8a44..359846833a00 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -140,7 +140,6 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->map_ip   = map__map_ip;
 	map->unmap_ip = map__unmap_ip;
 	RB_CLEAR_NODE(&map->rb_node);
-	map->groups   = NULL;
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
 }
@@ -388,7 +387,6 @@ struct map *map__clone(struct map *from)
 		refcount_set(&map->refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
 		dso__get(map->dso);
-		map->groups = NULL;
 	}
 
 	return map;
@@ -582,7 +580,6 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 void map_groups__insert(struct map_groups *mg, struct map *map)
 {
 	maps__insert(&mg->maps, map);
-	map->groups = mg;
 }
 
 static void __maps__purge(struct maps *maps)
@@ -749,7 +746,6 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 {
 	__maps__insert(&mg->maps, map);
 	__maps__insert_name(&mg->maps, map);
-	map->groups = mg;
 }
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c3614195ddc7..365deb6375ab 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -42,7 +42,6 @@ struct map {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
-	struct map_groups	*groups;
 	refcount_t		refcnt;
 };
 
-- 
2.21.0
