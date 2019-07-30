From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 076/107] libperf: Add perf_evsel__delete() function
Date: Mon, 29 Jul 2019 23:55:39 -0300
Message-ID: <20190730025610.22603-77-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evsel__delete() function to delete a perf_evsel instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-50-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 6 ++++++
 tools/perf/lib/include/perf/evsel.h | 1 +
 tools/perf/lib/libperf.map          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 8e91738c5c38..ddc3ad447bfb 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -3,6 +3,7 @@
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
+#include <stdlib.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -19,3 +20,8 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 
 	return evsel;
 }
+
+void perf_evsel__delete(struct perf_evsel *evsel)
+{
+	free(evsel);
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 21b66fc1937f..a57efc0f5c8b 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -10,5 +10,6 @@ struct perf_event_attr;
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
+LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 153e77cd6739..28ed04cbd223 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__new;
+		perf_evsel__delete;
 		perf_evsel__init;
 		perf_evlist__new;
 		perf_evlist__delete;
-- 
2.21.0
