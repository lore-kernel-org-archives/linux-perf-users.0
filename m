From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 092/107] libperf: Adopt perf_evsel__enable()/disable()/apply_filter() functions
Date: Mon, 29 Jul 2019 23:55:55 -0300
Message-ID: <20190730025610.22603-93-acme@kernel.org>
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

Move the following functions:

  evsel__enable()
  evsel__disable()
  evsel__apply_filter()

to libperf with the following names:

  perf_evsel__enable()
  perf_evsel__disable()
  perf_evsel__apply_filter()

Export only perf_evsel__enable()/disable(), keeping the
perf_evsel__apply_filter() one private for the moment.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-66-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c                  | 36 +++++++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/lib/include/perf/evsel.h     |  2 ++
 tools/perf/lib/libperf.map              |  2 ++
 tools/perf/util/evlist.c                |  2 +-
 tools/perf/util/evsel.c                 | 29 ++------------------
 tools/perf/util/evsel.h                 |  1 -
 7 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 390fcf9107c1..c3f3722e9f91 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -14,6 +14,7 @@
 #include <internal/threadmap.h>
 #include <internal/lib.h>
 #include <linux/string.h>
+#include <sys/ioctl.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -179,3 +180,38 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 
 	return 0;
 }
+
+static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
+				 int ioc,  void *arg)
+{
+	int cpu, thread;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+			int fd = FD(evsel, cpu, thread),
+			    err = ioctl(fd, ioc, arg);
+
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+int perf_evsel__enable(struct perf_evsel *evsel)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+int perf_evsel__disable(struct perf_evsel *evsel)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+}
+
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_FILTER,
+				     (void *)filter);
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 89bae3720d67..8b854d1c9b45 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -24,5 +24,6 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
 int perf_evsel__read_size(struct perf_evsel *evsel);
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 16ae3f873280..0db18dfabdb8 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -30,5 +30,7 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
+LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 2e23cf420cce..5bd491ac1762 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -13,6 +13,8 @@ LIBPERF_0.0.1 {
 		perf_thread_map__put;
 		perf_evsel__new;
 		perf_evsel__delete;
+		perf_evsel__enable;
+		perf_evsel__disable;
 		perf_evsel__init;
 		perf_evsel__open;
 		perf_evsel__close;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c6b4883b2d49..c4489a1ad6bc 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1109,7 +1109,7 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
 		 */
-		err = evsel__apply_filter(evsel, evsel->filter);
+		err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
 		if (err) {
 			*err_evsel = evsel;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0957ec24f518..64bc32ed6dfa 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1153,31 +1153,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-static int perf_evsel__run_ioctl(struct evsel *evsel,
-			  int ioc,  void *arg)
-{
-	int cpu, thread;
-
-	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->core.fd); thread++) {
-			int fd = FD(evsel, cpu, thread),
-			    err = ioctl(fd, ioc, arg);
-
-			if (err)
-				return err;
-		}
-	}
-
-	return 0;
-}
-
-int evsel__apply_filter(struct evsel *evsel, const char *filter)
-{
-	return perf_evsel__run_ioctl(evsel,
-				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter);
-}
-
 int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
 {
 	char *new_filter = strdup(filter);
@@ -1220,7 +1195,7 @@ int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 
 int evsel__enable(struct evsel *evsel)
 {
-	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+	int err = perf_evsel__enable(&evsel->core);
 
 	if (!err)
 		evsel->disabled = false;
@@ -1230,7 +1205,7 @@ int evsel__enable(struct evsel *evsel)
 
 int evsel__disable(struct evsel *evsel)
 {
-	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+	int err = perf_evsel__disable(&evsel->core);
 	/*
 	 * We mark it disabled here so that tools that disable a event can
 	 * ignore events after they disable it. I.e. the ring buffer may have
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 57e315d8158e..0989fb2eb1ec 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -287,7 +287,6 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
-int evsel__apply_filter(struct evsel *evsel, const char *filter);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 
-- 
2.21.0
