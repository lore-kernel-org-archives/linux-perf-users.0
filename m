From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/33] libperf: Add PERF_RECORD_KSYMBOL 'struct ksymbol_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:27 -0300
Message-ID: <20190827013634.3173-27-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_KSYMBOL event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_' to
ease up the reading and differentiate them from standard PRI*64 macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 13 +++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 13 -------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ef5ec66b566e..8c367931cecc 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -80,4 +80,17 @@ struct throttle_event {
 	__u64			 stream_id;
 };
 
+#ifndef KSYM_NAME_LEN
+#define KSYM_NAME_LEN 256
+#endif
+
+struct ksymbol_event {
+	struct perf_event_header header;
+	__u64			 addr;
+	__u32			 len;
+	__u16			 ksym_type;
+	__u16			 flags;
+	char			 name[KSYM_NAME_LEN];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 3bd9fc2a3ae8..4447cd25e3f2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1485,7 +1485,7 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " addr %" PRIx64 " len %u type %u flags 0x%x name %s\n",
+	return fprintf(fp, " addr %" PRI_lx64 " len %u type %u flags 0x%x name %s\n",
 		       event->ksymbol_event.addr, event->ksymbol_event.len,
 		       event->ksymbol_event.ksym_type,
 		       event->ksymbol_event.flags, event->ksymbol_event.name);
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 40020f5b0484..c4eec1f164ba 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,19 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-#ifndef KSYM_NAME_LEN
-#define KSYM_NAME_LEN 256
-#endif
-
-struct ksymbol_event {
-	struct perf_event_header header;
-	u64 addr;
-	u32 len;
-	u16 ksym_type;
-	u16 flags;
-	char name[KSYM_NAME_LEN];
-};
-
 struct bpf_event {
 	struct perf_event_header header;
 	u16 type;
-- 
2.21.0
