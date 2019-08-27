From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/33] libperf: Add PERF_RECORD_LOST_SAMPLES 'struct lost_samples_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:24 -0300
Message-ID: <20190827013634.3173-24-acme@kernel.org>
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

Move the PERF_RECORD_LOST_SAMPLES event definition into libperf's
event.h header include.

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
Link: http://lkml.kernel.org/r/20190825181752.722-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 tools/perf/util/machine.c           | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 71045ea8214c..86a779593405 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -56,4 +56,9 @@ struct lost_event {
 	__u64			 lost;
 };
 
+struct lost_samples_event {
+	struct perf_event_header header;
+	__u64			 lost;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4a3f50203d04..976a8f00d2a2 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,11 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct lost_samples_event {
-	struct perf_event_header header;
-	u64 lost;
-};
-
 /*
  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
  */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1ad6e984c2f5..823aaf7b1b83 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -653,7 +653,7 @@ int machine__process_lost_event(struct machine *machine __maybe_unused,
 int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
 					union perf_event *event, struct perf_sample *sample)
 {
-	dump_printf(": id:%" PRIu64 ": lost samples :%" PRIu64 "\n",
+	dump_printf(": id:%" PRIu64 ": lost samples :%" PRI_lu64 "\n",
 		    sample->id, event->lost_samples.lost);
 	return 0;
 }
-- 
2.21.0
