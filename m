From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 064/107] libperf: Add perf_evsel__init function
Date: Mon, 29 Jul 2019 23:55:27 -0300
Message-ID: <20190730025610.22603-65-acme@kernel.org>
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

Add the perf_evsel__init() function to initialize perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-38-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 5 +++++
 tools/perf/lib/include/perf/evsel.h | 4 ++++
 tools/perf/lib/libperf.map          | 1 +
 tools/perf/util/evsel.c             | 3 ++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 12e86de1994b..9a87e867a7ec 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -2,3 +2,8 @@
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
+
+void perf_evsel__init(struct perf_evsel *evsel)
+{
+	INIT_LIST_HEAD(&evsel->node);
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 162bffd43409..b4d074a3684b 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_EVSEL_H
 #define __LIBPERF_EVSEL_H
 
+#include <perf/core.h>
+
 struct perf_evsel;
 
+LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel);
+
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index c4f611010ccc..54f8503c6d82 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -9,6 +9,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__comm;
 		perf_thread_map__get;
 		perf_thread_map__put;
+		perf_evsel__init;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8fed22d889a4..172bcc2e198f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -22,6 +22,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <perf/evsel.h>
 #include "asm/bug.h"
 #include "callchain.h"
 #include "cgroup.h"
@@ -226,6 +227,7 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 void evsel__init(struct evsel *evsel,
 		 struct perf_event_attr *attr, int idx)
 {
+	perf_evsel__init(&evsel->core);
 	evsel->idx	   = idx;
 	evsel->tracking	   = !idx;
 	evsel->attr	   = *attr;
@@ -236,7 +238,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->evlist	   = NULL;
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
-	INIT_LIST_HEAD(&evsel->core.node);
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
-- 
2.21.0
