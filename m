From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/37] libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:07 -0300
Message-ID: <20190829143917.29745-28-acme@kernel.org>
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

Move the PERF_RECORD_STAT event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 17 +++++++++++++++++
 tools/perf/util/event.h             | 17 -----------------
 tools/perf/util/stat.c              |  4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ba6ed243a31f..7d1834f558d6 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -282,4 +282,21 @@ struct stat_config_event {
 	struct stat_config_event_entry	 data[];
 };
 
+struct stat_event {
+	struct perf_event_header header;
+
+	__u64			 id;
+	__u32			 cpu;
+	__u32			 thread;
+
+	union {
+		struct {
+			__u64	 val;
+			__u64	 ena;
+			__u64	 run;
+		};
+		__u64		 values[3];
+	};
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 68531d08dcec..f3a02e01852a 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,23 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct stat_event {
-	struct perf_event_header	header;
-
-	u64	id;
-	u32	cpu;
-	u32	thread;
-
-	union {
-		struct {
-			u64 val;
-			u64 ena;
-			u64 run;
-		};
-		u64 values[3];
-	};
-};
-
 enum {
 	PERF_STAT_ROUND_TYPE__INTERVAL	= 0,
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f985336b3a22..c0cd9f9bb0ea 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -405,9 +405,9 @@ size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp)
 	struct stat_event *st = (struct stat_event *) event;
 	size_t ret;
 
-	ret  = fprintf(fp, "\n... id %" PRIu64 ", cpu %d, thread %d\n",
+	ret  = fprintf(fp, "\n... id %" PRI_lu64 ", cpu %d, thread %d\n",
 		       st->id, st->cpu, st->thread);
-	ret += fprintf(fp, "... value %" PRIu64 ", enabled %" PRIu64 ", running %" PRIu64 "\n",
+	ret += fprintf(fp, "... value %" PRI_lu64 ", enabled %" PRI_lu64 ", running %" PRI_lu64 "\n",
 		       st->val, st->ena, st->run);
 
 	return ret;
-- 
2.21.0
