From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/37] libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:08 -0300
Message-ID: <20190829143917.29745-29-acme@kernel.org>
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

Move the PERF_RECORD_STAT_ROUND event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 tools/perf/util/stat.c              | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 7d1834f558d6..34d365bd2c5c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -299,4 +299,10 @@ struct stat_event {
 	};
 };
 
+struct stat_round_event {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 time;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f3a02e01852a..ec76412afba1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,12 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct stat_round_event {
-	struct perf_event_header	header;
-	u64				type;
-	u64				time;
-};
-
 struct time_conv_event {
 	struct perf_event_header header;
 	u64 time_shift;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c0cd9f9bb0ea..4c7957496e7c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -418,7 +418,7 @@ size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp)
 	struct stat_round_event *rd = (struct stat_round_event *)event;
 	size_t ret;
 
-	ret = fprintf(fp, "\n... time %" PRIu64 ", type %s\n", rd->time,
+	ret = fprintf(fp, "\n... time %" PRI_lu64 ", type %s\n", rd->time,
 		      rd->type == PERF_STAT_ROUND_TYPE__FINAL ? "FINAL" : "INTERVAL");
 
 	return ret;
-- 
2.21.0
