From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/27] perf: Add sample_id to PERF_RECORD_ITRACE_START event comment
Date: Wed, 10 Jan 2018 18:28:33 -0300
Message-ID: <20180110212844.12441-17-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding missing sample_id line into PERF_RECORD_ITRACE_START
event comment.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-5-jolsa@kernel.org
[ Update the tools/include/uapi/linux copy ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/uapi/linux/perf_event.h       | 1 +
 tools/include/uapi/linux/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b9a4953018ed..8bb66e8da945 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -864,6 +864,7 @@ enum perf_event_type {
 	 *	struct perf_event_header	header;
 	 *	u32				pid;
 	 *	u32				tid;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_ITRACE_START		= 12,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b9a4953018ed..8bb66e8da945 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -864,6 +864,7 @@ enum perf_event_type {
 	 *	struct perf_event_header	header;
 	 *	u32				pid;
 	 *	u32				tid;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_ITRACE_START		= 12,
-- 
2.14.3
