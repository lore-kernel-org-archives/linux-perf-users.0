From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/44] perf tools: Remove const from thread read accessors
Date: Mon, 27 May 2019 19:37:15 -0300
Message-ID: <20190527223730.11474-30-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Krister Johansen <kjlx@templeofstupid.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The namespaces and comm fields of a thread are protected by rwsem and
require write access for it.  So it ended up using a cast to remove
the const qualifier.  Let's get rid of the const then.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Link: http://lkml.kernel.org/r/20190527061149.168640-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c   |  2 +-
 tools/perf/util/thread.c | 12 ++++++------
 tools/perf/util/thread.h |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7ace7a10054d..fb3271fd420c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2561,7 +2561,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	char unit;
 	int printed;
 	const struct dso *dso = hists->dso_filter;
-	const struct thread *thread = hists->thread_filter;
+	struct thread *thread = hists->thread_filter;
 	int socket_id = hists->socket_filter;
 	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
 	u64 nr_events = hists->stats.total_period;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b413ba5b9835..aab7807d445f 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -141,13 +141,13 @@ static struct namespaces *__thread__namespaces(const struct thread *thread)
 	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread)
+struct namespaces *thread__namespaces(struct thread *thread)
 {
 	struct namespaces *ns;
 
-	down_read((struct rw_semaphore *)&thread->namespaces_lock);
+	down_read(&thread->namespaces_lock);
 	ns = __thread__namespaces(thread);
-	up_read((struct rw_semaphore *)&thread->namespaces_lock);
+	up_read(&thread->namespaces_lock);
 
 	return ns;
 }
@@ -271,13 +271,13 @@ static const char *__thread__comm_str(const struct thread *thread)
 	return comm__str(comm);
 }
 
-const char *thread__comm_str(const struct thread *thread)
+const char *thread__comm_str(struct thread *thread)
 {
 	const char *str;
 
-	down_read((struct rw_semaphore *)&thread->comm_lock);
+	down_read(&thread->comm_lock);
 	str = __thread__comm_str(thread);
-	up_read((struct rw_semaphore *)&thread->comm_lock);
+	up_read(&thread->comm_lock);
 
 	return str;
 }
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index cf8375c017a0..e97ef6977eb9 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -76,7 +76,7 @@ static inline void thread__exited(struct thread *thread)
 	thread->dead = true;
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread);
+struct namespaces *thread__namespaces(struct thread *thread);
 int thread__set_namespaces(struct thread *thread, u64 timestamp,
 			   struct namespaces_event *event);
 
@@ -93,7 +93,7 @@ int thread__set_comm_from_proc(struct thread *thread);
 int thread__comm_len(struct thread *thread);
 struct comm *thread__comm(const struct thread *thread);
 struct comm *thread__exec_comm(const struct thread *thread);
-const char *thread__comm_str(const struct thread *thread);
+const char *thread__comm_str(struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
-- 
2.20.1
