From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/37] libperf: Move 'enum perf_user_event_type' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:14 -0300
Message-ID: <20190829143917.29745-35-acme@kernel.org>
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

So it's available for libperf's users.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 23 +++++++++++++++++++++++
 tools/perf/util/event.h             | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 1655c744ec2b..18106899cb4e 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -323,6 +323,29 @@ struct perf_record_compressed {
 	char			 data[];
 };
 
+enum perf_user_event_type { /* above any possible kernel type */
+	PERF_RECORD_USER_TYPE_START		= 64,
+	PERF_RECORD_HEADER_ATTR			= 64,
+	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
+	PERF_RECORD_HEADER_TRACING_DATA		= 66,
+	PERF_RECORD_HEADER_BUILD_ID		= 67,
+	PERF_RECORD_FINISHED_ROUND		= 68,
+	PERF_RECORD_ID_INDEX			= 69,
+	PERF_RECORD_AUXTRACE_INFO		= 70,
+	PERF_RECORD_AUXTRACE			= 71,
+	PERF_RECORD_AUXTRACE_ERROR		= 72,
+	PERF_RECORD_THREAD_MAP			= 73,
+	PERF_RECORD_CPU_MAP			= 74,
+	PERF_RECORD_STAT_CONFIG			= 75,
+	PERF_RECORD_STAT			= 76,
+	PERF_RECORD_STAT_ROUND			= 77,
+	PERF_RECORD_EVENT_UPDATE		= 78,
+	PERF_RECORD_TIME_CONV			= 79,
+	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
+	PERF_RECORD_HEADER_MAX
+};
+
 union perf_event {
 	struct perf_event_header		header;
 	struct perf_record_mmap			mmap;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a7341e14eb48..4c0c5232bd41 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -146,29 +146,6 @@ struct perf_sample {
 	 PERF_MEM_S(LOCK, NA) |\
 	 PERF_MEM_S(TLB, NA))
 
-enum perf_user_event_type { /* above any possible kernel type */
-	PERF_RECORD_USER_TYPE_START		= 64,
-	PERF_RECORD_HEADER_ATTR			= 64,
-	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
-	PERF_RECORD_HEADER_TRACING_DATA		= 66,
-	PERF_RECORD_HEADER_BUILD_ID		= 67,
-	PERF_RECORD_FINISHED_ROUND		= 68,
-	PERF_RECORD_ID_INDEX			= 69,
-	PERF_RECORD_AUXTRACE_INFO		= 70,
-	PERF_RECORD_AUXTRACE			= 71,
-	PERF_RECORD_AUXTRACE_ERROR		= 72,
-	PERF_RECORD_THREAD_MAP			= 73,
-	PERF_RECORD_CPU_MAP			= 74,
-	PERF_RECORD_STAT_CONFIG			= 75,
-	PERF_RECORD_STAT			= 76,
-	PERF_RECORD_STAT_ROUND			= 77,
-	PERF_RECORD_EVENT_UPDATE		= 78,
-	PERF_RECORD_TIME_CONV			= 79,
-	PERF_RECORD_HEADER_FEATURE		= 80,
-	PERF_RECORD_COMPRESSED			= 81,
-	PERF_RECORD_HEADER_MAX
-};
-
 enum auxtrace_error_type {
 	PERF_AUXTRACE_ERROR_ITRACE  = 1,
 	PERF_AUXTRACE_ERROR_MAX
-- 
2.21.0
