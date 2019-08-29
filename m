From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/37] libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:01 -0300
Message-ID: <20190829143917.29745-22-acme@kernel.org>
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

Move the PERF_RECORD_AUXTRACE_ERROR event definition to libperf's
event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 15 +++++++++++++++
 tools/perf/util/auxtrace.c          |  2 +-
 tools/perf/util/event.h             | 15 ---------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 78001c2973b6..6292b7c41bac 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -219,4 +219,19 @@ struct auxtrace_event {
 	__u32			 reserved__; /* For alignment */
 };
 
+#define MAX_AUXTRACE_ERROR_MSG 64
+
+struct auxtrace_error_event {
+	struct perf_event_header header;
+	__u32			 type;
+	__u32			 code;
+	__u32			 cpu;
+	__u32			 pid;
+	__u32			 tid;
+	__u32			 fmt;
+	__u64			 ip;
+	__u64			 time;
+	char			 msg[MAX_AUXTRACE_ERROR_MSG];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 5edec7123328..c3da8a0e66b2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1189,7 +1189,7 @@ size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 	if (!e->fmt)
 		msg = (const char *)&e->time;
 
-	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRIx64" code %u: %s\n",
+	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRI_lx64" code %u: %s\n",
 		       e->cpu, e->pid, e->tid, e->ip, e->code, msg);
 	return ret;
 }
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 60895a3b2c85..e334ecbe50a0 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,21 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-#define MAX_AUXTRACE_ERROR_MSG 64
-
-struct auxtrace_error_event {
-	struct perf_event_header header;
-	u32 type;
-	u32 code;
-	u32 cpu;
-	u32 pid;
-	u32 tid;
-	u32 fmt;
-	u64 ip;
-	u64 time;
-	char msg[MAX_AUXTRACE_ERROR_MSG];
-};
-
 struct aux_event {
 	struct perf_event_header header;
 	u64	aux_offset;
-- 
2.21.0
