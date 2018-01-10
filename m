From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/27] perf: Update PERF_RECORD_MISC_* comment for perf_event_header::misc bit 13
Date: Wed, 10 Jan 2018 18:28:36 -0300
Message-ID: <20180110212844.12441-20-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The perf_event_header::misc bit 13 is shared on different events and
next patch is adding yet another bit 13 user.  Updating the comment to
make it more structured and clear which events use bit 13.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-8-jolsa@kernel.org
[ Update the tools/include/uapi/linux copy ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/uapi/linux/perf_event.h       | 9 ++++++---
 tools/include/uapi/linux/perf_event.h | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 8bb66e8da945..c77c9a2ebbbb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -612,9 +612,12 @@ struct perf_event_mmap_page {
  */
 #define PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT	(1 << 12)
 /*
- * PERF_RECORD_MISC_MMAP_DATA and PERF_RECORD_MISC_COMM_EXEC are used on
- * different events so can reuse the same bit position.
- * Ditto PERF_RECORD_MISC_SWITCH_OUT.
+ * Following PERF_RECORD_MISC_* are used on different
+ * events, so can reuse the same bit position:
+ *
+ *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
+ *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
+ *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
  */
 #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 8bb66e8da945..c77c9a2ebbbb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -612,9 +612,12 @@ struct perf_event_mmap_page {
  */
 #define PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT	(1 << 12)
 /*
- * PERF_RECORD_MISC_MMAP_DATA and PERF_RECORD_MISC_COMM_EXEC are used on
- * different events so can reuse the same bit position.
- * Ditto PERF_RECORD_MISC_SWITCH_OUT.
+ * Following PERF_RECORD_MISC_* are used on different
+ * events, so can reuse the same bit position:
+ *
+ *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
+ *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
+ *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
  */
 #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
-- 
2.14.3
