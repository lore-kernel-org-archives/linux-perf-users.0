From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/37] libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:38:55 -0300
Message-ID: <20190829143917.29745-16-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_HEADER_EVENT_TYPE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 12 ++++++++++++
 tools/perf/util/event.h             | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3d99818077d8..ecd1536a3a0c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -163,4 +163,16 @@ struct event_update_event {
 	char			 data[];
 };
 
+#define MAX_EVENT_NAME 64
+
+struct perf_trace_event_type {
+	__u64			 event_id;
+	char			 name[MAX_EVENT_NAME];
+};
+
+struct event_type_event {
+	struct perf_event_header	 header;
+	struct perf_trace_event_type	 event_type;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a579e6b439d6..00725a1b602b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,18 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-#define MAX_EVENT_NAME 64
-
-struct perf_trace_event_type {
-	u64	event_id;
-	char	name[MAX_EVENT_NAME];
-};
-
-struct event_type_event {
-	struct perf_event_header header;
-	struct perf_trace_event_type event_type;
-};
-
 struct tracing_data_event {
 	struct perf_event_header header;
 	u32 size;
-- 
2.21.0
