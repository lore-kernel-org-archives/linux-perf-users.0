From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  05/22] perf: make map to use refcnt
Date: Wed, 09 Dec 2015 11:10:59 +0900
Message-ID: <20151209021059.10245.76558.stgit@localhost.localdomain>
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

Make 'map' object to use refcnt interface for debug.
This can find refcnt related memory leaks.
E.g.

  ----
  ./perf probe vfs_read
  Added new event:
    probe:vfs_read       (on vfs_read)

  You can now use it in all perf tools, such as:

          perf record -e probe:vfs_read -aR sleep 1

  REFCNT: BUG: Unreclaimed objects found.
  REFCNT: Total 76 objects are not reclaimed.
     To see all backtraces, rerun with -v option
  ----

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 Changes from v1:
  - Update refcnt__init() call to pass initial value.
---
 tools/perf/util/map.c |    7 ++++---
 tools/perf/util/map.h |    3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 93d9f1c..72fcc54 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -138,7 +138,7 @@ void map__init(struct map *map, enum map_type type,
 	RB_CLEAR_NODE(&map->rb_node);
 	map->groups   = NULL;
 	map->erange_warned = false;
-	atomic_set(&map->refcnt, 1);
+	refcnt__init(map, refcnt, 1);
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
@@ -241,6 +241,7 @@ bool __map__is_kernel(const struct map *map)
 static void map__exit(struct map *map)
 {
 	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
+	refcnt__exit(map, refcnt);
 	dso__zput(map->dso);
 }
 
@@ -252,7 +253,7 @@ void map__delete(struct map *map)
 
 void map__put(struct map *map)
 {
-	if (map && atomic_dec_and_test(&map->refcnt))
+	if (map && refcnt__put(map, refcnt))
 		map__delete(map);
 }
 
@@ -353,7 +354,7 @@ struct map *map__clone(struct map *from)
 	struct map *map = memdup(from, sizeof(*map));
 
 	if (map != NULL) {
-		atomic_set(&map->refcnt, 1);
+		refcnt__init(map, refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
 		dso__get(map->dso);
 		map->groups = NULL;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 7309d64..fcdc7d6 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include "refcnt.h"
 
 enum map_type {
 	MAP__FUNCTION = 0,
@@ -153,7 +154,7 @@ struct map *map__clone(struct map *map);
 static inline struct map *map__get(struct map *map)
 {
 	if (map)
-		atomic_inc(&map->refcnt);
+		refcnt__get(map, refcnt);
 	return map;
 }
 
