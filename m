From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  07/22] perf: Make map_groups to use refcnt
Date: Wed, 09 Dec 2015 11:11:03 +0900
Message-ID: <20151209021103.10245.95658.stgit@localhost.localdomain>
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

Make 'map_groups' object to use refcnt interface for debug.
This can find refcnt related memory leaks.
 E.g.
  ----
  # ./perf top --stdio
  ^q
  REFCNT: BUG: Unreclaimed objects found.
  REFCNT: Total 3615 objects are not reclaimed.
    "map" leaks 3373 objects
    "dso" leaks 232 objects
    "map_groups" leaks 10 objects
     To see all backtraces, rerun with -v option
  ----

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/map.c |    5 +++--
 tools/perf/util/map.h |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 72fcc54..7859216 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -471,7 +471,7 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 		maps__init(&mg->maps[i]);
 	}
 	mg->machine = machine;
-	atomic_set(&mg->refcnt, 1);
+	refcnt__init_as(mg, refcnt, 1, "map_groups");
 }
 
 static void __maps__purge(struct maps *maps)
@@ -501,6 +501,7 @@ void map_groups__exit(struct map_groups *mg)
 
 	for (i = 0; i < MAP__NR_TYPES; ++i)
 		maps__exit(&mg->maps[i]);
+	refcnt__exit(mg, refcnt);
 }
 
 bool map_groups__empty(struct map_groups *mg)
@@ -533,7 +534,7 @@ void map_groups__delete(struct map_groups *mg)
 
 void map_groups__put(struct map_groups *mg)
 {
-	if (mg && atomic_dec_and_test(&mg->refcnt))
+	if (mg && refcnt__put(mg, refcnt))
 		map_groups__delete(mg);
 }
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index fcdc7d6..4667d67 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -78,7 +78,7 @@ bool map_groups__empty(struct map_groups *mg);
 static inline struct map_groups *map_groups__get(struct map_groups *mg)
 {
 	if (mg)
-		atomic_inc(&mg->refcnt);
+		refcnt__get(mg, refcnt);
 	return mg;
 }
 
