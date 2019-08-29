From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/37] libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:05 -0300
Message-ID: <20190829143917.29745-26-acme@kernel.org>
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

Move the PERF_RECORD_THREAD_MAP event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/event.h             | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index a7b0344bb8b4..fe0ce655af17 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -253,4 +253,15 @@ struct itrace_start_event {
 	__u32			 tid;
 };
 
+struct thread_map_event_entry {
+	__u64			 pid;
+	char			 comm[16];
+};
+
+struct thread_map_event {
+	struct perf_event_header	 header;
+	__u64				 nr;
+	struct thread_map_event_entry	 entries[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 012b2ba9a9a8..3a856696c6b1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,17 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct thread_map_event_entry {
-	u64	pid;
-	char	comm[16];
-};
-
-struct thread_map_event {
-	struct perf_event_header	header;
-	u64				nr;
-	struct thread_map_event_entry	entries[];
-};
-
 enum {
 	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
 	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
-- 
2.21.0
