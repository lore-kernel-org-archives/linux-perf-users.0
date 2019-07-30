From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 089/107] libperf: Adopt simplified perf_evsel__open() function from tools/perf
Date: Mon, 29 Jul 2019 23:55:52 -0300
Message-ID: <20190730025610.22603-90-acme@kernel.org>
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

Add a perf_evsel__open() function to libperf.

It's a simplified version of evsel__open() without the fallback
mechanism.

We can try to merge it in the future to libperf, but it has many
details, lets start simple, requiring the latest kernel, perf should
continue using its evsel__open() version, continuing to support running
on older kernels when possible.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-63-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 65 +++++++++++++++++++++++++++++
 tools/perf/lib/include/perf/evsel.h |  4 ++
 tools/perf/lib/libperf.map          |  1 +
 3 files changed, 70 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 027f1edb4e8e..7027dacb50f6 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -1,11 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <unistd.h>
+#include <sys/syscall.h>
 #include <perf/evsel.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <internal/xyarray.h>
+#include <internal/cpumap.h>
+#include <internal/threadmap.h>
 #include <linux/string.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
@@ -46,3 +52,62 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 
 	return evsel->fd != NULL ? 0 : -ENOMEM;
 }
+
+static int
+sys_perf_event_open(struct perf_event_attr *attr,
+		    pid_t pid, int cpu, int group_fd,
+		    unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+		     struct perf_thread_map *threads)
+{
+	int cpu, thread, err = 0;
+
+	if (cpus == NULL) {
+		static struct perf_cpu_map *empty_cpu_map;
+
+		if (empty_cpu_map == NULL) {
+			empty_cpu_map = perf_cpu_map__dummy_new();
+			if (empty_cpu_map == NULL)
+				return -ENOMEM;
+		}
+
+		cpus = empty_cpu_map;
+	}
+
+	if (threads == NULL) {
+		static struct perf_thread_map *empty_thread_map;
+
+		if (empty_thread_map == NULL) {
+			empty_thread_map = perf_thread_map__new_dummy();
+			if (empty_thread_map == NULL)
+				return -ENOMEM;
+		}
+
+		threads = empty_thread_map;
+	}
+
+	if (evsel->fd == NULL &&
+	    perf_evsel__alloc_fd(evsel, cpus->nr, threads->nr) < 0)
+		return -ENOMEM;
+
+	for (cpu = 0; cpu < cpus->nr; cpu++) {
+		for (thread = 0; thread < threads->nr; thread++) {
+			int fd;
+
+			fd = sys_perf_event_open(&evsel->attr,
+						 threads->map[thread].pid,
+						 cpus->map[cpu], -1, 0);
+
+			if (fd < 0)
+				return -errno;
+
+			FD(evsel, cpu, thread) = fd;
+		}
+	}
+
+	return err;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index a57efc0f5c8b..e9fbaa8fb51a 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -6,10 +6,14 @@
 
 struct perf_evsel;
 struct perf_event_attr;
+struct perf_cpu_map;
+struct perf_thread_map;
 
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+				 struct perf_thread_map *threads);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 9b6e8f165014..7594d3d89c5f 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -14,6 +14,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__new;
 		perf_evsel__delete;
 		perf_evsel__init;
+		perf_evsel__open;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__init;
-- 
2.21.0
