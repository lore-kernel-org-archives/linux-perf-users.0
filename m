From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/33] libperf: Add PERF_RECORD_FORK 'struct fork_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:22 -0300
Message-ID: <20190827013634.3173-22-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the fork_event event definition into libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Using extra '_'
to ease up the reading and differentiate them from standard PRI*64
macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/python.c            | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index b90a8a21e613..c7cae58d2535 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -43,4 +43,11 @@ struct namespaces_event {
 	struct perf_ns_link_info link_info[];
 };
 
+struct fork_event {
+	struct perf_event_header header;
+	__u32			 pid, ppid;
+	__u32			 tid, ptid;
+	__u64			 time;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 0d3ac4fd3ecf..38b258cbbd90 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,13 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct fork_event {
-	struct perf_event_header header;
-	u32 pid, ppid;
-	u32 tid, ptid;
-	u64 time;
-};
-
 struct lost_event {
 	struct perf_event_header header;
 	u64 id;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 55ff0c3182d6..8bdadb24f6ba 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -170,7 +170,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
 {
 	return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
-				   "ptid: %u, time: %" PRIu64 "}",
+				   "ptid: %u, time: %" PRI_lu64 "}",
 				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
 				   pevent->event.fork.pid,
 				   pevent->event.fork.ppid,
-- 
2.21.0
