From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 054/107] libperf: Add debug output support
Date: Mon, 29 Jul 2019 23:55:17 -0300
Message-ID: <20190730025610.22603-55-acme@kernel.org>
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

Add the perf_set_print() function to allow setting an output function
for warn/info/debug messages.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-28-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/core.c              | 34 ++++++++++++++++++++++++++++++
 tools/perf/lib/include/perf/core.h | 13 ++++++++++++
 tools/perf/lib/internal.h          | 18 ++++++++++++++++
 tools/perf/lib/libperf.map         |  2 ++
 4 files changed, 67 insertions(+)
 create mode 100644 tools/perf/lib/internal.h

diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
index e69de29bb2d1..29d5e3348718 100644
--- a/tools/perf/lib/core.c
+++ b/tools/perf/lib/core.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define __printf(a, b)  __attribute__((format(printf, a, b)))
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <perf/core.h>
+#include "internal.h"
+
+static int __base_pr(enum libperf_print_level level, const char *format,
+		     va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
+static libperf_print_fn_t __libperf_pr = __base_pr;
+
+void libperf_set_print(libperf_print_fn_t fn)
+{
+	__libperf_pr = fn;
+}
+
+__printf(2, 3)
+void libperf_print(enum libperf_print_level level, const char *format, ...)
+{
+	va_list args;
+
+	if (!__libperf_pr)
+		return;
+
+	va_start(args, format);
+	__libperf_pr(level, format, args);
+	va_end(args);
+}
diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index e2e4b43c9131..c341a7b2c874 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -2,8 +2,21 @@
 #ifndef __LIBPERF_CORE_H
 #define __LIBPERF_CORE_H
 
+#include <stdarg.h>
+
 #ifndef LIBPERF_API
 #define LIBPERF_API __attribute__((visibility("default")))
 #endif
 
+enum libperf_print_level {
+	LIBPERF_WARN,
+	LIBPERF_INFO,
+	LIBPERF_DEBUG,
+};
+
+typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
+				  const char *, va_list ap);
+
+LIBPERF_API void libperf_set_print(libperf_print_fn_t fn);
+
 #endif /* __LIBPERF_CORE_H */
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
new file mode 100644
index 000000000000..dc92f241732e
--- /dev/null
+++ b/tools/perf/lib/internal.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_H
+#define __LIBPERF_INTERNAL_H
+
+void libperf_print(enum libperf_print_level level,
+		   const char *format, ...)
+	__attribute__((format(printf, 2, 3)));
+
+#define __pr(level, fmt, ...)   \
+do {                            \
+	libperf_print(level, "libperf: " fmt, ##__VA_ARGS__);     \
+} while (0)
+
+#define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
+#define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
+#define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
+
+#endif /* __LIBPERF_INTERNAL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index a8e913988edf..3536242c545c 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,4 +1,6 @@
 LIBPERF_0.0.1 {
+	global:
+		libperf_set_print;
 	local:
 		*;
 };
-- 
2.21.0
