From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/37] libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:38:54 -0300
Message-ID: <20190829143917.29745-15-acme@kernel.org>
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

Move the PERF_RECORD_EVENT_UPDATE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 22 ++++++++++++++++++++++
 tools/perf/util/event.h             | 23 -----------------------
 tools/perf/util/header.c            |  2 +-
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 469be778fdc1..3d99818077d8 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -141,4 +141,26 @@ struct cpu_map_event {
 	struct cpu_map_data	 data;
 };
 
+enum {
+	PERF_EVENT_UPDATE__UNIT  = 0,
+	PERF_EVENT_UPDATE__SCALE = 1,
+	PERF_EVENT_UPDATE__NAME  = 2,
+	PERF_EVENT_UPDATE__CPUS  = 3,
+};
+
+struct event_update_event_cpus {
+	struct cpu_map_data	 cpus;
+};
+
+struct event_update_event_scale {
+	double			 scale;
+};
+
+struct event_update_event {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 id;
+	char			 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 84bf67353635..a579e6b439d6 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,29 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-enum {
-	PERF_EVENT_UPDATE__UNIT  = 0,
-	PERF_EVENT_UPDATE__SCALE = 1,
-	PERF_EVENT_UPDATE__NAME  = 2,
-	PERF_EVENT_UPDATE__CPUS  = 3,
-};
-
-struct event_update_event_cpus {
-	struct cpu_map_data cpus;
-};
-
-struct event_update_event_scale {
-	double scale;
-};
-
-struct event_update_event {
-	struct perf_event_header header;
-	u64 type;
-	u64 id;
-
-	char data[];
-};
-
 #define MAX_EVENT_NAME 64
 
 struct perf_trace_event_type {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8e67faf4fe88..629bdb150cb9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3893,7 +3893,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 	struct perf_cpu_map *map;
 	size_t ret;
 
-	ret = fprintf(fp, "\n... id:    %" PRIu64 "\n", ev->id);
+	ret = fprintf(fp, "\n... id:    %" PRI_lu64 "\n", ev->id);
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__SCALE:
-- 
2.21.0
