From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/27] perf machine: Add threads__get_last_match function
Date: Wed, 25 Jul 2018 14:59:55 -0300
Message-ID: <20180725180001.15108-22-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Separating threads::last_match cache read/check into separate
threads__get_last_match function. This will be useful in following
patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180719143345.12963-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 22dbb6612b41..df41aa1a4cf9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -408,23 +408,16 @@ static void machine__update_thread_pid(struct machine *machine,
 }
 
 /*
- * Caller must eventually drop thread->refcnt returned with a successful
- * lookup/new thread inserted.
+ * Front-end cache - TID lookups come in blocks,
+ * so most of the time we dont have to look up
+ * the full rbtree:
  */
-static struct thread *____machine__findnew_thread(struct machine *machine,
-						  struct threads *threads,
-						  pid_t pid, pid_t tid,
-						  bool create)
+static struct thread*
+threads__get_last_match(struct threads *threads, struct machine *machine,
+			int pid, int tid)
 {
-	struct rb_node **p = &threads->entries.rb_node;
-	struct rb_node *parent = NULL;
 	struct thread *th;
 
-	/*
-	 * Front-end cache - TID lookups come in blocks,
-	 * so most of the time we dont have to look up
-	 * the full rbtree:
-	 */
 	th = threads->last_match;
 	if (th != NULL) {
 		if (th->tid == tid) {
@@ -435,6 +428,26 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		threads->last_match = NULL;
 	}
 
+	return NULL;
+}
+
+/*
+ * Caller must eventually drop thread->refcnt returned with a successful
+ * lookup/new thread inserted.
+ */
+static struct thread *____machine__findnew_thread(struct machine *machine,
+						  struct threads *threads,
+						  pid_t pid, pid_t tid,
+						  bool create)
+{
+	struct rb_node **p = &threads->entries.rb_node;
+	struct rb_node *parent = NULL;
+	struct thread *th;
+
+	th = threads__get_last_match(threads, machine, pid, tid);
+	if (th)
+		return th;
+
 	while (*p != NULL) {
 		parent = *p;
 		th = rb_entry(parent, struct thread, rb_node);
-- 
2.14.4
