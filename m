From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/66] libperf: Add libperf_init() call to the tests
Date: Wed, 25 Sep 2019 21:32:29 -0300
Message-ID: <20190926003244.13962-52-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add libperf_init() call to the automated tests.

Committer notes:

Added missing stdarg.h and/or stdio.h to places using vfprintf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-34-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/test-cpumap.c    | 10 ++++++++++
 tools/perf/lib/tests/test-evlist.c    | 10 ++++++++++
 tools/perf/lib/tests/test-evsel.c     | 10 ++++++++++
 tools/perf/lib/tests/test-threadmap.c | 10 ++++++++++
 4 files changed, 40 insertions(+)

diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
index 76a43cfb83a1..aa34c20df07e 100644
--- a/tools/perf/lib/tests/test-cpumap.c
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -1,13 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
 #include <perf/cpumap.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 int main(int argc, char **argv)
 {
 	struct perf_cpu_map *cpus;
 
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	cpus = perf_cpu_map__dummy_new();
 	if (!cpus)
 		return -1;
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index 4e1407f20ffd..e6b2ab2e2bde 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdarg.h>
 #include <linux/perf_event.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
@@ -6,6 +8,12 @@
 #include <perf/evsel.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 static int test_stat_cpu(void)
 {
 	struct perf_cpu_map *cpus;
@@ -177,6 +185,8 @@ int main(int argc, char **argv)
 {
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
index 2c648fe5617e..1b6c4285ac2b 100644
--- a/tools/perf/lib/tests/test-evsel.c
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -1,10 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
 #include <linux/perf_event.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <perf/evsel.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 static int test_stat_cpu(void)
 {
 	struct perf_cpu_map *cpus;
@@ -116,6 +124,8 @@ int main(int argc, char **argv)
 {
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
index 10a4f4cbbdd5..8c5f47247d9e 100644
--- a/tools/perf/lib/tests/test-threadmap.c
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -1,13 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdarg.h>
+#include <stdio.h>
 #include <perf/threadmap.h>
 #include <internal/tests.h>
 
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
 int main(int argc, char **argv)
 {
 	struct perf_thread_map *threads;
 
 	__T_START;
 
+	libperf_init(libperf_print);
+
 	threads = perf_thread_map__new_dummy();
 	if (!threads)
 		return -1;
-- 
2.21.0
