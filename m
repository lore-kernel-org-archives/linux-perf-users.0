From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/37] libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:38:56 -0300
Message-ID: <20190829143917.29745-17-acme@kernel.org>
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

Move the PERF_RECORD_HEADER_TRACING_DATA event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ecd1536a3a0c..fa81fea8dc02 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -175,4 +175,9 @@ struct event_type_event {
 	struct perf_trace_event_type	 event_type;
 };
 
+struct tracing_data_event {
+	struct perf_event_header header;
+	__u32			 size;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 00725a1b602b..67f6a67ad3b4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,11 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct tracing_data_event {
-	struct perf_event_header header;
-	u32 size;
-};
-
 struct id_index_entry {
 	u64 id;
 	u64 idx;
-- 
2.21.0
