From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/15] perf map: Combine maps__fixup_overlappings with its only use
Date: Tue, 12 Nov 2019 15:37:54 -0300
Message-ID: <20191112183757.28660-13-acme@kernel.org>
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

In the process we can kill some of the struct map->groups usage, trying
to get rid of this per-full struct map fields getting in the way of
sharing a map across father/parent processes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-e50eqtqw3za24vmbjnqmmcs6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6c59f55026c1..27d8508f8a44 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -752,8 +752,9 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 	map->groups = mg;
 }
 
-static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
+int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
 {
+	struct maps *maps = &mg->maps;
 	struct rb_root *root;
 	struct rb_node *next, *first;
 	int err = 0;
@@ -818,7 +819,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 			}
 
 			before->end = map->start;
-			__map_groups__insert(pos->groups, before);
+			__map_groups__insert(mg, before);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
 			map__put(before);
@@ -835,7 +836,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 			after->start = map->end;
 			after->pgoff += map->end - pos->start;
 			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
-			__map_groups__insert(pos->groups, after);
+			__map_groups__insert(mg, after);
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
 			map__put(after);
@@ -853,12 +854,6 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 	return err;
 }
 
-int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
-				   FILE *fp)
-{
-	return maps__fixup_overlappings(&mg->maps, map, fp);
-}
-
 /*
  * XXX This should not really _copy_ te maps, but refcount them.
  */
-- 
2.21.0
