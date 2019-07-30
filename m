From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 088/107] libperf: Adopt perf_evsel__alloc_fd() function from tools/perf
Date: Mon, 29 Jul 2019 23:55:51 -0300
Message-ID: <20190730025610.22603-89-acme@kernel.org>
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

Move the perf_evsel__alloc_fd() function from perf to libperf.

It's not exported.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-62-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c                  | 21 +++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h |  2 ++
 tools/perf/util/evsel.c                 | 18 +-----------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index ddc3ad447bfb..027f1edb4e8e 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <internal/xyarray.h>
+#include <linux/string.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -25,3 +28,21 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 {
 	free(evsel);
 }
+
+#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
+{
+	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
+
+	if (evsel->fd) {
+		int cpu, thread;
+		for (cpu = 0; cpu < ncpus; cpu++) {
+			for (thread = 0; thread < nthreads; thread++) {
+				FD(evsel, cpu, thread) = -1;
+			}
+		}
+	}
+
+	return evsel->fd != NULL ? 0 : -ENOMEM;
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 29eca9576546..3cb9a0f5f32e 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -20,4 +20,6 @@ struct perf_evsel {
 	int			 nr_members;
 };
 
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8b9a00598677..d3c8488f7069 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1153,22 +1153,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-static int perf_evsel__alloc_fd(struct evsel *evsel, int ncpus, int nthreads)
-{
-	evsel->core.fd = xyarray__new(ncpus, nthreads, sizeof(int));
-
-	if (evsel->core.fd) {
-		int cpu, thread;
-		for (cpu = 0; cpu < ncpus; cpu++) {
-			for (thread = 0; thread < nthreads; thread++) {
-				FD(evsel, cpu, thread) = -1;
-			}
-		}
-	}
-
-	return evsel->core.fd != NULL ? 0 : -ENOMEM;
-}
-
 static int perf_evsel__run_ioctl(struct evsel *evsel,
 			  int ioc,  void *arg)
 {
@@ -1866,7 +1850,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		nthreads = threads->nr;
 
 	if (evsel->core.fd == NULL &&
-	    perf_evsel__alloc_fd(evsel, cpus->nr, nthreads) < 0)
+	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
 		return -ENOMEM;
 
 	if (evsel->cgrp) {
-- 
2.21.0
