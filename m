From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 055/107] libperf: Add perf_cpu_map struct
Date: Mon, 29 Jul 2019 23:55:18 -0300
Message-ID: <20190730025610.22603-56-acme@kernel.org>
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

Add perf_cpu_map struct to libperf.

It's added as a declaration into:

  include/perf/cpumap.h

which will be included by users.

The perf_cpu_map struct definition is added into:

  include/internal/cpumap.h

which is not to be included by users, but shared within perf and
libperf.

We tried the total separation of the perf_cpu_map struct in libperf, but
it lead to complications and much bigger changes in perf code, so we
decided to share the declaration.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-29-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                     |  1 +
 tools/perf/lib/cpumap.c                  |  5 +++++
 tools/perf/lib/include/internal/cpumap.h | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h     |  7 +++++++
 tools/perf/util/cpumap.h                 |  7 +------
 5 files changed, 27 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/lib/cpumap.c
 create mode 100644 tools/perf/lib/include/internal/cpumap.h
 create mode 100644 tools/perf/lib/include/perf/cpumap.h

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 5196958cec01..195b274db49a 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -1 +1,2 @@
 libperf-y += core.o
+libperf-y += cpumap.o
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
new file mode 100644
index 000000000000..86a199c26f20
--- /dev/null
+++ b/tools/perf/lib/cpumap.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <perf/cpumap.h>
+#include <stdlib.h>
+#include <linux/refcount.h>
+#include <internal/cpumap.h>
diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/perf/lib/include/internal/cpumap.h
new file mode 100644
index 000000000000..53ce95374b05
--- /dev/null
+++ b/tools/perf/lib/include/internal/cpumap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_CPUMAP_H
+#define __LIBPERF_INTERNAL_CPUMAP_H
+
+#include <linux/refcount.h>
+
+struct perf_cpu_map {
+	refcount_t	refcnt;
+	int		nr;
+	int		map[];
+};
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
new file mode 100644
index 000000000000..8355d3ce7d0c
--- /dev/null
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CPUMAP_H
+#define __LIBPERF_CPUMAP_H
+
+struct perf_cpu_map;
+
+#endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 22729beae959..c2ba9ae195f7 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -5,16 +5,11 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/refcount.h>
+#include <internal/cpumap.h>
 
 #include "perf.h"
 #include "util/debug.h"
 
-struct perf_cpu_map {
-	refcount_t refcnt;
-	int nr;
-	int map[];
-};
-
 struct perf_cpu_map *cpu_map__new(const char *cpu_list);
 struct perf_cpu_map *cpu_map__empty_new(int nr);
 struct perf_cpu_map *cpu_map__dummy_new(void);
-- 
2.21.0
