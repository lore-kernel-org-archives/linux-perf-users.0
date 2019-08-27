From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/33] libperf: Add PERF_RECORD_READ 'struct read_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:25 -0300
Message-ID: <20190827013634.3173-25-acme@kernel.org>
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

Move the PERF_RECORD_READ event definition to libperf's event.h header
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

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_' to
ease up the reading and differentiate them from standard PRI*64 macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 12 ++++++++++++
 tools/perf/util/event.h             | 12 ------------
 tools/perf/util/session.c           |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 86a779593405..f1830702e49a 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -61,4 +61,16 @@ struct lost_samples_event {
 	__u64			 lost;
 };
 
+/*
+ * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
+ */
+struct read_event {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 value;
+	__u64			 time_enabled;
+	__u64			 time_running;
+	__u64			 id;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 976a8f00d2a2..008a2839d667 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,18 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-/*
- * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
- */
-struct read_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 value;
-	u64 time_enabled;
-	u64 time_running;
-	u64 id;
-};
-
 struct throttle_event {
 	struct perf_event_header header;
 	u64 time;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 82e0438a9160..cb1d8dcd0c19 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1260,7 +1260,7 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 	if (!dump_trace)
 		return;
 
-	printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
+	printf(": %d %d %s %" PRI_lu64 "\n", event->read.pid, event->read.tid,
 	       perf_evsel__name(evsel),
 	       event->read.value);
 
@@ -1270,13 +1270,13 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 	read_format = evsel->core.attr.read_format;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		printf("... time enabled : %" PRIu64 "\n", read_event->time_enabled);
+		printf("... time enabled : %" PRI_lu64 "\n", read_event->time_enabled);
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		printf("... time running : %" PRIu64 "\n", read_event->time_running);
+		printf("... time running : %" PRI_lu64 "\n", read_event->time_running);
 
 	if (read_format & PERF_FORMAT_ID)
-		printf("... id           : %" PRIu64 "\n", read_event->id);
+		printf("... id           : %" PRI_lu64 "\n", read_event->id);
 }
 
 static struct machine *machines__find_for_cpumode(struct machines *machines,
-- 
2.21.0
