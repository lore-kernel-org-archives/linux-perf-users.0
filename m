From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/37] libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:06 -0300
Message-ID: <20190829143917.29745-27-acme@kernel.org>
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

Move the PERF_RECORD_STAT_CONFIG event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 18 ++++++++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 18 ------------------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index fe0ce655af17..ba6ed243a31f 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -264,4 +264,22 @@ struct thread_map_event {
 	struct thread_map_event_entry	 entries[];
 };
 
+enum {
+	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
+	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
+	PERF_STAT_CONFIG_TERM__SCALE		= 2,
+	PERF_STAT_CONFIG_TERM__MAX		= 3,
+};
+
+struct stat_config_event_entry {
+	__u64			 tag;
+	__u64			 val;
+};
+
+struct stat_config_event {
+	struct perf_event_header	 header;
+	__u64				 nr;
+	struct stat_config_event_entry	 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index b048e6084612..b711019a9ed2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1235,7 +1235,7 @@ void perf_event__read_stat_config(struct perf_stat_config *config,
 		CASE(INTERVAL,  interval)
 #undef CASE
 		default:
-			pr_warning("unknown stat config term %" PRIu64 "\n",
+			pr_warning("unknown stat config term %" PRI_lu64 "\n",
 				   event->data[i].tag);
 		}
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 3a856696c6b1..68531d08dcec 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,24 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-enum {
-	PERF_STAT_CONFIG_TERM__AGGR_MODE	= 0,
-	PERF_STAT_CONFIG_TERM__INTERVAL		= 1,
-	PERF_STAT_CONFIG_TERM__SCALE		= 2,
-	PERF_STAT_CONFIG_TERM__MAX		= 3,
-};
-
-struct stat_config_event_entry {
-	u64	tag;
-	u64	val;
-};
-
-struct stat_config_event {
-	struct perf_event_header	header;
-	u64				nr;
-	struct stat_config_event_entry	data[];
-};
-
 struct stat_event {
 	struct perf_event_header	header;
 
-- 
2.21.0
