From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/35] perf thread_map: Enumerate all threads from /proc
Date: Thu, 28 Dec 2017 11:30:01 -0300
Message-ID: <20171228143027.30547-10-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

This patch calls thread_map__new_all_cpus() to enumerate all threads
from /proc if per-thread flag is enabled.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-10-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/thread-map.c | 2 +-
 tools/perf/util/evlist.c      | 3 ++-
 tools/perf/util/thread_map.c  | 5 ++++-
 tools/perf/util/thread_map.h  | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index dbcb6a19b375..4de1939b58ba 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -105,7 +105,7 @@ int test__thread_map_remove(struct test *test __maybe_unused, int subtest __mayb
 	TEST_ASSERT_VAL("failed to allocate map string",
 			asprintf(&str, "%d,%d", getpid(), getppid()) >= 0);
 
-	threads = thread_map__new_str(str, NULL, 0);
+	threads = thread_map__new_str(str, NULL, 0, false);
 
 	TEST_ASSERT_VAL("failed to allocate thread_map",
 			threads);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3570355bcf39..f0a5e09c4071 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1105,7 +1105,8 @@ int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
 	struct cpu_map *cpus;
 	struct thread_map *threads;
 
-	threads = thread_map__new_str(target->pid, target->tid, target->uid);
+	threads = thread_map__new_str(target->pid, target->tid, target->uid,
+				      target->per_thread);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 2b653853eec2..3e1038f6491c 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -323,7 +323,7 @@ struct thread_map *thread_map__new_by_tid_str(const char *tid_str)
 }
 
 struct thread_map *thread_map__new_str(const char *pid, const char *tid,
-				       uid_t uid)
+				       uid_t uid, bool per_thread)
 {
 	if (pid)
 		return thread_map__new_by_pid_str(pid);
@@ -331,6 +331,9 @@ struct thread_map *thread_map__new_str(const char *pid, const char *tid,
 	if (!tid && uid != UINT_MAX)
 		return thread_map__new_by_uid(uid);
 
+	if (per_thread)
+		return thread_map__new_all_cpus();
+
 	return thread_map__new_by_tid_str(tid);
 }
 
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 07a765fb22bb..0a806b99e73c 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -31,7 +31,7 @@ struct thread_map *thread_map__get(struct thread_map *map);
 void thread_map__put(struct thread_map *map);
 
 struct thread_map *thread_map__new_str(const char *pid,
-		const char *tid, uid_t uid);
+		const char *tid, uid_t uid, bool per_thread);
 
 struct thread_map *thread_map__new_by_tid_str(const char *tid_str);
 
-- 
2.13.6
