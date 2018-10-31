From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/28] perf tools: Don't clone maps from parent when synthesizing forks
Date: Wed, 31 Oct 2018 13:45:06 -0300
Message-ID: <20181031164508.4784-27-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Miller <davem@davemloft.net>, Don Zickus <dzickus@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Joe Mario <jmario@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Miller <davem@davemloft.net>

When synthesizing FORK events, we are trying to create thread objects
for the already running tasks on the machine.

Normally, for a kernel FORK event, we want to clone the parent's maps
because that is what the kernel just did.

But when synthesizing, this should not be done.  If we do, we end up
with overlapping maps as we process the sythesized MMAP2 events that
get delivered shortly thereafter.

Use the FORK event misc flags in an internal way to signal this
situation, so we can elide the map clone when appropriate.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Link: http://lkml.kernel.org/r/20181030.222404.2085088822877051075.davem@davemloft.net
[ Added comment about flag use in machine__process_fork_event(),
  use ternary op in thread__clone_map_groups() as suggested by Jiri ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/uapi/linux/perf_event.h       |  2 ++
 tools/include/uapi/linux/perf_event.h |  2 ++
 tools/perf/util/event.c               |  1 +
 tools/perf/util/machine.c             | 19 ++++++++++++++++++-
 tools/perf/util/thread.c              | 13 +++++--------
 tools/perf/util/thread.h              |  2 +-
 6 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f35eb72739c0..9de8780ac8d9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -646,10 +646,12 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
  *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
+ *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
  *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
  */
 #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
+#define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
  * These PERF_RECORD_MISC_* flags below are safely reused
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f35eb72739c0..9de8780ac8d9 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -646,10 +646,12 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
  *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
+ *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
  *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
  */
 #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
+#define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
  * These PERF_RECORD_MISC_* flags below are safely reused
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bc646185f8d9..e9c108a6b1c3 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -308,6 +308,7 @@ static int perf_event__synthesize_fork(struct perf_tool *tool,
 	event->fork.pid  = tgid;
 	event->fork.tid  = pid;
 	event->fork.header.type = PERF_RECORD_FORK;
+	event->fork.header.misc = PERF_RECORD_MISC_FORK_EXEC;
 
 	event->fork.header.size = (sizeof(event->fork) + machine->id_hdr_size);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8ee8ab39d8ac..8f36ce813bc5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1708,6 +1708,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 	struct thread *parent = machine__findnew_thread(machine,
 							event->fork.ppid,
 							event->fork.ptid);
+	bool do_maps_clone = true;
 	int err = 0;
 
 	if (dump_trace)
@@ -1736,9 +1737,25 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 
 	thread = machine__findnew_thread(machine, event->fork.pid,
 					 event->fork.tid);
+	/*
+	 * When synthesizing FORK events, we are trying to create thread
+	 * objects for the already running tasks on the machine.
+	 *
+	 * Normally, for a kernel FORK event, we want to clone the parent's
+	 * maps because that is what the kernel just did.
+	 *
+	 * But when synthesizing, this should not be done.  If we do, we end up
+	 * with overlapping maps as we process the sythesized MMAP2 events that
+	 * get delivered shortly thereafter.
+	 *
+	 * Use the FORK event misc flags in an internal way to signal this
+	 * situation, so we can elide the map clone when appropriate.
+	 */
+	if (event->fork.header.misc & PERF_RECORD_MISC_FORK_EXEC)
+		do_maps_clone = false;
 
 	if (thread == NULL || parent == NULL ||
-	    thread__fork(thread, parent, sample->time) < 0) {
+	    thread__fork(thread, parent, sample->time, do_maps_clone) < 0) {
 		dump_printf("problem processing PERF_RECORD_FORK, skipping event.\n");
 		err = -1;
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 2048d393ece6..3d9ed7d0e281 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -330,7 +330,8 @@ static int thread__prepare_access(struct thread *thread)
 }
 
 static int thread__clone_map_groups(struct thread *thread,
-				    struct thread *parent)
+				    struct thread *parent,
+				    bool do_maps_clone)
 {
 	/* This is new thread, we share map groups for process. */
 	if (thread->pid_ == parent->pid_)
@@ -341,15 +342,11 @@ static int thread__clone_map_groups(struct thread *thread,
 			 thread->pid_, thread->tid, parent->pid_, parent->tid);
 		return 0;
 	}
-
 	/* But this one is new process, copy maps. */
-	if (map_groups__clone(thread, parent->mg) < 0)
-		return -ENOMEM;
-
-	return 0;
+	return do_maps_clone ? map_groups__clone(thread, parent->mg) : 0;
 }
 
-int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
+int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone)
 {
 	if (parent->comm_set) {
 		const char *comm = thread__comm_str(parent);
@@ -362,7 +359,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
 	}
 
 	thread->ppid = parent->tid;
-	return thread__clone_map_groups(thread, parent);
+	return thread__clone_map_groups(thread, parent, do_maps_clone);
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 36c09a9904e6..30e2b4c165fe 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -89,7 +89,7 @@ struct comm *thread__comm(const struct thread *thread);
 struct comm *thread__exec_comm(const struct thread *thread);
 const char *thread__comm_str(const struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
-int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp);
+int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
-- 
2.14.4
