From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/23] perf evsel: Add functions to enable/disable for a specific CPU
Date: Tue,  3 Dec 2019 10:55:52 -0300
Message-ID: <20191203135606.24902-10-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Refactor the existing functions to use these functions internally.

Used in the next patch.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-12-andi@firstfloor.org
Link: http://lore.kernel.org/lkml/20191127232657.GL84886@tassilo.jf.intel.com # Fix
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 49 +++++++++++++++++++++--------
 tools/perf/lib/include/perf/evsel.h |  2 ++
 tools/perf/util/evsel.c             | 13 +++++++-
 tools/perf/util/evsel.h             |  2 ++
 4 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index ea775dacbd2d..4dc06289f4c7 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -198,38 +198,61 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg)
+				 int ioc,  void *arg,
+				 int cpu)
 {
-	int cpu, thread;
+	int thread;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-			int fd = FD(evsel, cpu, thread),
-			    err = ioctl(fd, ioc, arg);
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+		int fd = FD(evsel, cpu, thread),
+		    err = ioctl(fd, ioc, arg);
 
-			if (err)
-				return err;
-		}
+		if (err)
+			return err;
 	}
 
 	return 0;
 }
 
+int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu);
+}
+
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
+	return err;
+}
+
+int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+	return err;
 }
 
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
-	return perf_evsel__run_ioctl(evsel,
+	int err = 0, i;
+
+	for (i = 0; i < evsel->cpus->nr && !err; i++)
+		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter);
+				     (void *)filter, i);
+	return err;
 }
 
 struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index e7add554f861..c82ec39a4ad0 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -30,7 +30,9 @@ LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index aa180d1df50f..a69e64236120 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1223,16 +1223,27 @@ int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 	return perf_evsel__append_filter(evsel, "%s,%s", filter);
 }
 
+/* Caller has to clear disabled after going through all CPUs. */
+int evsel__enable_cpu(struct evsel *evsel, int cpu)
+{
+	return perf_evsel__enable_cpu(&evsel->core, cpu);
+}
+
 int evsel__enable(struct evsel *evsel)
 {
 	int err = perf_evsel__enable(&evsel->core);
 
 	if (!err)
 		evsel->disabled = false;
-
 	return err;
 }
 
+/* Caller has to set disabled after going through all CPUs. */
+int evsel__disable_cpu(struct evsel *evsel, int cpu)
+{
+	return perf_evsel__disable_cpu(&evsel->core, cpu);
+}
+
 int evsel__disable(struct evsel *evsel)
 {
 	int err = perf_evsel__disable(&evsel->core);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c8af4bc23f8f..dc14f4a823cd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -222,8 +222,10 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
+int evsel__enable_cpu(struct evsel *evsel, int cpu);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
+int evsel__disable_cpu(struct evsel *evsel, int cpu);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus,
-- 
2.21.0
