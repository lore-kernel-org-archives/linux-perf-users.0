From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 12/22] perf: Make thread_map to use refcnt for
 debug
Date: Wed, 09 Dec 2015 11:11:14 +0900
Message-ID: <20151209021114.10245.78998.stgit@localhost.localdomain>
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

Make 'thread_map' object to use refcnt interface for debug.
This can find refcnt related memory leaks.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/thread_map.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 6ec3c5c..a87eae4 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -13,6 +13,7 @@
 #include "thread_map.h"
 #include "util.h"
 #include "debug.h"
+#include "refcnt.h"
 
 /* Skip "." and ".." directories */
 static int filter(const struct dirent *dir)
@@ -65,7 +66,7 @@ struct thread_map *thread_map__new_by_pid(pid_t pid)
 		for (i = 0; i < items; i++)
 			thread_map__set_pid(threads, i, atoi(namelist[i]->d_name));
 		threads->nr = items;
-		atomic_set(&threads->refcnt, 1);
+		refcnt__init_as(threads, refcnt, 1, "thread_map");
 	}
 
 	for (i=0; i<items; i++)
@@ -82,7 +83,7 @@ struct thread_map *thread_map__new_by_tid(pid_t tid)
 	if (threads != NULL) {
 		thread_map__set_pid(threads, 0, tid);
 		threads->nr = 1;
-		atomic_set(&threads->refcnt, 1);
+		refcnt__init_as(threads, refcnt, 1, "thread_map");
 	}
 
 	return threads;
@@ -104,7 +105,7 @@ struct thread_map *thread_map__new_by_uid(uid_t uid)
 		goto out_free_threads;
 
 	threads->nr = 0;
-	atomic_set(&threads->refcnt, 1);
+	refcnt__init_as(threads, refcnt, 1, "thread_map");
 
 	while (!readdir_r(proc, &dirent, &next) && next) {
 		char *end;
@@ -234,7 +235,7 @@ static struct thread_map *thread_map__new_by_pid_str(const char *pid_str)
 out:
 	strlist__delete(slist);
 	if (threads)
-		atomic_set(&threads->refcnt, 1);
+		refcnt__init_as(threads, refcnt, 1, "thread_map");
 	return threads;
 
 out_free_namelist:
@@ -254,7 +255,7 @@ struct thread_map *thread_map__new_dummy(void)
 	if (threads != NULL) {
 		thread_map__set_pid(threads, 0, -1);
 		threads->nr = 1;
-		atomic_set(&threads->refcnt, 1);
+		refcnt__init_as(threads, refcnt, 1, "thread_map");
 	}
 	return threads;
 }
@@ -299,7 +300,7 @@ static struct thread_map *thread_map__new_by_tid_str(const char *tid_str)
 	}
 out:
 	if (threads)
-		atomic_set(&threads->refcnt, 1);
+		refcnt__init_as(threads, refcnt, 1, "thread_map");
 	return threads;
 
 out_free_threads:
@@ -328,21 +329,22 @@ static void thread_map__delete(struct thread_map *threads)
 			  "thread map refcnt unbalanced\n");
 		for (i = 0; i < threads->nr; i++)
 			free(thread_map__comm(threads, i));
+		refcnt__exit(threads, refcnt);
 		free(threads);
 	}
 }
 
-struct thread_map *thread_map__get(struct thread_map *map)
+struct thread_map *thread_map__get(struct thread_map *threads)
 {
-	if (map)
-		atomic_inc(&map->refcnt);
-	return map;
+	if (threads)
+		refcnt__get(threads, refcnt);
+	return threads;
 }
 
-void thread_map__put(struct thread_map *map)
+void thread_map__put(struct thread_map *threads)
 {
-	if (map && atomic_dec_and_test(&map->refcnt))
-		thread_map__delete(map);
+	if (threads && refcnt__put(threads, refcnt))
+		thread_map__delete(threads);
 }
 
 size_t thread_map__fprintf(struct thread_map *threads, FILE *fp)
