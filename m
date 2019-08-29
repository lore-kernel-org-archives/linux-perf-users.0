From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/37] libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:02 -0300
Message-ID: <20190829143917.29745-23-acme@kernel.org>
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

Move the PERF_RECORD_AUX event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.c             | 2 +-
 tools/perf/util/event.h             | 7 -------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 6292b7c41bac..d453ac833a58 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -234,4 +234,11 @@ struct auxtrace_error_event {
 	char			 msg[MAX_AUXTRACE_ERROR_MSG];
 };
 
+struct aux_event {
+	struct perf_event_header header;
+	__u64			 aux_offset;
+	__u64			 aux_size;
+	__u64			 flags;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e33dd1a040cc..b048e6084612 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1449,7 +1449,7 @@ int perf_event__process_exit(struct perf_tool *tool __maybe_unused,
 
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " offset: %#"PRIx64" size: %#"PRIx64" flags: %#"PRIx64" [%s%s%s]\n",
+	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s]\n",
 		       event->aux.aux_offset, event->aux.aux_size,
 		       event->aux.flags,
 		       event->aux.flags & PERF_AUX_FLAG_TRUNCATED ? "T" : "",
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e334ecbe50a0..db901aea33af 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,13 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct aux_event {
-	struct perf_event_header header;
-	u64	aux_offset;
-	u64	aux_size;
-	u64	flags;
-};
-
 struct itrace_start_event {
 	struct perf_event_header header;
 	u32 pid, tid;
-- 
2.21.0
