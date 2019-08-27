From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/33] libperf: Add PERF_RECORD_BPF_EVENT 'struct bpf_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:28 -0300
Message-ID: <20190827013634.3173-28-acme@kernel.org>
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

Move the PERF_RECORD_BPF_EVENT event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/event.h             | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 8c367931cecc..585c9d82dba3 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -5,6 +5,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <linux/limits.h>
+#include <linux/bpf.h>
 
 struct mmap_event {
 	struct perf_event_header header;
@@ -93,4 +94,14 @@ struct ksymbol_event {
 	char			 name[KSYM_NAME_LEN];
 };
 
+struct bpf_event {
+	struct perf_event_header header;
+	__u16			 type;
+	__u16			 flags;
+	__u32			 id;
+
+	/* for bpf_prog types */
+	__u8			 tag[BPF_TAG_SIZE];  // prog tag
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index c4eec1f164ba..091a0690a280 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,16 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct bpf_event {
-	struct perf_event_header header;
-	u16 type;
-	u16 flags;
-	u32 id;
-
-	/* for bpf_prog types */
-	u8 tag[BPF_TAG_SIZE];  // prog tag
-};
-
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
-- 
2.21.0
