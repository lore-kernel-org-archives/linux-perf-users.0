From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/33] libperf: Add PERF_RECORD_LOST 'struct lost_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:23 -0300
Message-ID: <20190827013634.3173-23-acme@kernel.org>
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

Move the lost_event event definition to libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values as stated
in the linux/types.h comment:

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
Link: http://lkml.kernel.org/r/20190825181752.722-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c          | 2 +-
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.c             | 2 +-
 tools/perf/util/event.h             | 6 ------
 tools/perf/util/machine.c           | 2 +-
 tools/perf/util/python.c            | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0d6b4c3b1a51..025151dcb651 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2643,7 +2643,7 @@ static int process_lost(struct perf_tool *tool __maybe_unused,
 
 	timestamp__scnprintf_usec(sample->time, tstr, sizeof(tstr));
 	printf("%15s ", tstr);
-	printf("lost %" PRIu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
+	printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
 
 	return 0;
 }
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index c7cae58d2535..71045ea8214c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -50,4 +50,10 @@ struct fork_event {
 	__u64			 time;
 };
 
+struct lost_event {
+	struct perf_event_header header;
+	__u64			 id;
+	__u64			 lost;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0954f980574f..3bd9fc2a3ae8 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1480,7 +1480,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 
 static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
+	return fprintf(fp, " lost %" PRI_lu64 "\n", event->lost.lost);
 }
 
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 38b258cbbd90..4a3f50203d04 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,12 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct lost_event {
-	struct perf_event_header header;
-	u64 id;
-	u64 lost;
-};
-
 struct lost_samples_event {
 	struct perf_event_header header;
 	u64 lost;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 47430afd3c2d..1ad6e984c2f5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -645,7 +645,7 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 int machine__process_lost_event(struct machine *machine __maybe_unused,
 				union perf_event *event, struct perf_sample *sample __maybe_unused)
 {
-	dump_printf(": id:%" PRIu64 ": lost:%" PRIu64 "\n",
+	dump_printf(": id:%" PRI_lu64 ": lost:%" PRI_lu64 "\n",
 		    event->lost.id, event->lost.lost);
 	return 0;
 }
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8bdadb24f6ba..5be85f50cd1c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -263,8 +263,8 @@ static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
 	PyObject *ret;
 	char *s;
 
-	if (asprintf(&s, "{ type: lost, id: %#" PRIx64 ", "
-			 "lost: %#" PRIx64 " }",
+	if (asprintf(&s, "{ type: lost, id: %#" PRI_lx64 ", "
+			 "lost: %#" PRI_lx64 " }",
 		     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-- 
2.21.0
