From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/36] perf thread_map: Add method to map all threads in the system
Date: Wed,  6 Dec 2017 11:40:56 -0300
Message-ID: <20171206144115.15097-18-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reusing the thread_map__new_by_uid() proc scanning already in place to
return a map with all threads in the system.

Based-on-a-patch-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-khh28q0wwqbqtrk32bfe07hd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread_map.c | 22 ++++++++++++++++------
 tools/perf/util/thread_map.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index be0d5a736dea..2b653853eec2 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -92,7 +92,7 @@ struct thread_map *thread_map__new_by_tid(pid_t tid)
 	return threads;
 }
 
-struct thread_map *thread_map__new_by_uid(uid_t uid)
+static struct thread_map *__thread_map__new_all_cpus(uid_t uid)
 {
 	DIR *proc;
 	int max_threads = 32, items, i;
@@ -113,7 +113,6 @@ struct thread_map *thread_map__new_by_uid(uid_t uid)
 	while ((dirent = readdir(proc)) != NULL) {
 		char *end;
 		bool grow = false;
-		struct stat st;
 		pid_t pid = strtol(dirent->d_name, &end, 10);
 
 		if (*end) /* only interested in proper numerical dirents */
@@ -121,11 +120,12 @@ struct thread_map *thread_map__new_by_uid(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%s", dirent->d_name);
 
-		if (stat(path, &st) != 0)
-			continue;
+		if (uid != UINT_MAX) {
+			struct stat st;
 
-		if (st.st_uid != uid)
-			continue;
+			if (stat(path, &st) != 0 || st.st_uid != uid)
+				continue;
+		}
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
@@ -178,6 +178,16 @@ struct thread_map *thread_map__new_by_uid(uid_t uid)
 	goto out_closedir;
 }
 
+struct thread_map *thread_map__new_all_cpus(void)
+{
+	return __thread_map__new_all_cpus(UINT_MAX);
+}
+
+struct thread_map *thread_map__new_by_uid(uid_t uid)
+{
+	return __thread_map__new_all_cpus(uid);
+}
+
 struct thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
 {
 	if (pid != -1)
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index f15803985435..07a765fb22bb 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -23,6 +23,7 @@ struct thread_map *thread_map__new_dummy(void);
 struct thread_map *thread_map__new_by_pid(pid_t pid);
 struct thread_map *thread_map__new_by_tid(pid_t tid);
 struct thread_map *thread_map__new_by_uid(uid_t uid);
+struct thread_map *thread_map__new_all_cpus(void);
 struct thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid);
 struct thread_map *thread_map__new_event(struct thread_map_event *event);
 
-- 
2.13.6
