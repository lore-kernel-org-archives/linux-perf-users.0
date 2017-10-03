From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/8] perf tools: Lock to protect namespaces and comm list
Date: Tue,  3 Oct 2017 09:55:36 -0300
Message-ID: <20171003125540.331-5-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Add two locks to protect namespaces_list and comm_list.

The lock is only needed for multithreaded code, so using mutex wrappers
provided by perf tool.

Not all the comm_list/namespaces_list accessing are protected, e.g.
thread__exec_comm. Because the multithread code for perf top event
synthesizing does not touch them. They don't need a lock.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1506696477-146932-2-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 53 +++++++++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/thread.h |  3 +++
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c09bdb509d82..bf73117b4822 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -45,6 +45,8 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread->cpu = -1;
 		INIT_LIST_HEAD(&thread->namespaces_list);
 		INIT_LIST_HEAD(&thread->comm_list);
+		init_rwsem(&thread->namespaces_lock);
+		init_rwsem(&thread->comm_lock);
 
 		comm_str = malloc(32);
 		if (!comm_str)
@@ -83,18 +85,26 @@ void thread__delete(struct thread *thread)
 		map_groups__put(thread->mg);
 		thread->mg = NULL;
 	}
+	down_write(&thread->namespaces_lock);
 	list_for_each_entry_safe(namespaces, tmp_namespaces,
 				 &thread->namespaces_list, list) {
 		list_del(&namespaces->list);
 		namespaces__free(namespaces);
 	}
+	up_write(&thread->namespaces_lock);
+
+	down_write(&thread->comm_lock);
 	list_for_each_entry_safe(comm, tmp_comm, &thread->comm_list, list) {
 		list_del(&comm->list);
 		comm__free(comm);
 	}
+	up_write(&thread->comm_lock);
+
 	unwind__finish_access(thread);
 	nsinfo__zput(thread->nsinfo);
 
+	exit_rwsem(&thread->namespaces_lock);
+	exit_rwsem(&thread->comm_lock);
 	free(thread);
 }
 
@@ -125,8 +135,8 @@ struct namespaces *thread__namespaces(const struct thread *thread)
 	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
 }
 
-int thread__set_namespaces(struct thread *thread, u64 timestamp,
-			   struct namespaces_event *event)
+static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
+				    struct namespaces_event *event)
 {
 	struct namespaces *new, *curr = thread__namespaces(thread);
 
@@ -149,6 +159,17 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 	return 0;
 }
 
+int thread__set_namespaces(struct thread *thread, u64 timestamp,
+			   struct namespaces_event *event)
+{
+	int ret;
+
+	down_write(&thread->namespaces_lock);
+	ret = __thread__set_namespaces(thread, timestamp, event);
+	up_write(&thread->namespaces_lock);
+	return ret;
+}
+
 struct comm *thread__comm(const struct thread *thread)
 {
 	if (list_empty(&thread->comm_list))
@@ -170,8 +191,8 @@ struct comm *thread__exec_comm(const struct thread *thread)
 	return last;
 }
 
-int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
-		       bool exec)
+static int ____thread__set_comm(struct thread *thread, const char *str,
+				u64 timestamp, bool exec)
 {
 	struct comm *new, *curr = thread__comm(thread);
 
@@ -195,6 +216,17 @@ int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
 	return 0;
 }
 
+int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
+		       bool exec)
+{
+	int ret;
+
+	down_write(&thread->comm_lock);
+	ret = ____thread__set_comm(thread, str, timestamp, exec);
+	up_write(&thread->comm_lock);
+	return ret;
+}
+
 int thread__set_comm_from_proc(struct thread *thread)
 {
 	char path[64];
@@ -212,7 +244,7 @@ int thread__set_comm_from_proc(struct thread *thread)
 	return err;
 }
 
-const char *thread__comm_str(const struct thread *thread)
+static const char *__thread__comm_str(const struct thread *thread)
 {
 	const struct comm *comm = thread__comm(thread);
 
@@ -222,6 +254,17 @@ const char *thread__comm_str(const struct thread *thread)
 	return comm__str(comm);
 }
 
+const char *thread__comm_str(const struct thread *thread)
+{
+	const char *str;
+
+	down_read((struct rw_semaphore *)&thread->comm_lock);
+	str = __thread__comm_str(thread);
+	up_read((struct rw_semaphore *)&thread->comm_lock);
+
+	return str;
+}
+
 /* CHECKME: it should probably better return the max comm len from its comm list */
 int thread__comm_len(struct thread *thread)
 {
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index cb1a5dd5c2b9..10555d6a0b86 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -9,6 +9,7 @@
 #include "symbol.h"
 #include <strlist.h>
 #include <intlist.h>
+#include "rwsem.h"
 
 struct thread_stack;
 struct unwind_libunwind_ops;
@@ -29,7 +30,9 @@ struct thread {
 	int			comm_len;
 	bool			dead; /* if set thread has exited */
 	struct list_head	namespaces_list;
+	struct rw_semaphore	namespaces_lock;
 	struct list_head	comm_list;
+	struct rw_semaphore	comm_lock;
 	u64			db_id;
 
 	void			*priv;
-- 
2.13.6
