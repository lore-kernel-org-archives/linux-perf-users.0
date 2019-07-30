From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 093/107] libperf: Add perf_cpu_map__for_each_cpu() macro
Date: Mon, 29 Jul 2019 23:55:56 -0300
Message-ID: <20190730025610.22603-94-acme@kernel.org>
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

Add the following macro to libperf:

  perf_cpu_map__for_each_cpu()

And its related functions:

  perf_cpu_map__cpu()
  perf_cpu_map__nr()

That will allow hiding how it is implemented.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-67-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c              | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  7 +++++++
 tools/perf/lib/libperf.map           |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index a5d4f7ff7174..1ddb69e796e5 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -224,3 +224,16 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 out:
 	return cpus;
 }
+
+int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
+{
+	if (idx < cpus->nr)
+		return cpus->map[idx];
+
+	return -1;
+}
+
+int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
+{
+	return cpus ? cpus->nr : 1;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index b4a9283a5dfa..1b6e7db3fa2b 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -12,5 +12,12 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
+LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
+
+#define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
+	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
+	     (idx) < perf_cpu_map__nr(cpus);			\
+	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
 
 #endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5bd491ac1762..d4d34bea0b40 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -6,6 +6,8 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__put;
 		perf_cpu_map__new;
 		perf_cpu_map__read;
+		perf_cpu_map__nr;
+		perf_cpu_map__cpu;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
-- 
2.21.0
