From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 49/57] libperf: Keep count of failed tests
Date: Mon, 21 Oct 2019 10:38:26 -0300
Message-ID: <20191021133834.25998-50-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Keep the count of failed tests, so we get better output with failures,
like:

  # make tests
  ...
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...FAILED test-evlist.c:53 failed to create evsel2
  FAILED test-evlist.c:163 failed to create evsel2
  FAILED test-evlist.c:287 failed count
    FAILED (3)
  - running test-evsel.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...FAILED test-evlist.c:53 failed to create evsel2
  FAILED test-evlist.c:163 failed to create evsel2
  FAILED test-evlist.c:287 failed count
    FAILED (3)
  - running test-evsel.c...OK
 ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/tests.h | 20 +++++++++++++++++---
 tools/perf/lib/tests/test-cpumap.c      |  2 +-
 tools/perf/lib/tests/test-evlist.c      |  2 +-
 tools/perf/lib/tests/test-evsel.c       |  2 +-
 tools/perf/lib/tests/test-threadmap.c   |  2 +-
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/internal/tests.h b/tools/perf/lib/include/internal/tests.h
index b7a20cd24ee1..2093e8868a67 100644
--- a/tools/perf/lib/include/internal/tests.h
+++ b/tools/perf/lib/include/internal/tests.h
@@ -4,14 +4,28 @@
 
 #include <stdio.h>
 
-#define __T_START fprintf(stdout, "- running %s...", __FILE__)
-#define __T_OK    fprintf(stdout, "OK\n")
-#define __T_FAIL  fprintf(stdout, "FAIL\n")
+int tests_failed;
+
+#define __T_START					\
+do {							\
+	fprintf(stdout, "- running %s...", __FILE__);	\
+	fflush(NULL);					\
+	tests_failed = 0;				\
+} while (0)
+
+#define __T_END								\
+do {									\
+	if (tests_failed)						\
+		fprintf(stdout, "  FAILED (%d)\n", tests_failed);	\
+	else								\
+		fprintf(stdout, "OK\n");				\
+} while (0)
 
 #define __T(text, cond)                                                          \
 do {                                                                             \
 	if (!(cond)) {                                                           \
 		fprintf(stderr, "FAILED %s:%d %s\n", __FILE__, __LINE__, text);  \
+		tests_failed++;                                                  \
 		return -1;                                                       \
 	}                                                                        \
 } while (0)
diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
index aa34c20df07e..c8d45091e7c2 100644
--- a/tools/perf/lib/tests/test-cpumap.c
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -26,6 +26,6 @@ int main(int argc, char **argv)
 	perf_cpu_map__put(cpus);
 	perf_cpu_map__put(cpus);
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index 741bc1bb4524..6d8ebe0c2504 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -408,6 +408,6 @@ int main(int argc, char **argv)
 	test_mmap_thread();
 	test_mmap_cpus();
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
index 1b6c4285ac2b..135722ac965b 100644
--- a/tools/perf/lib/tests/test-evsel.c
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -130,6 +130,6 @@ int main(int argc, char **argv)
 	test_stat_thread();
 	test_stat_thread_enable();
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
index 8c5f47247d9e..7dc4d6fbedde 100644
--- a/tools/perf/lib/tests/test-threadmap.c
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -26,6 +26,6 @@ int main(int argc, char **argv)
 	perf_thread_map__put(threads);
 	perf_thread_map__put(threads);
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
-- 
2.21.0
