From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 058/107] libperf: Add perf_thread_map struct
Date: Mon, 29 Jul 2019 23:55:21 -0300
Message-ID: <20190730025610.22603-59-acme@kernel.org>
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

Add perf_thread_map struct to libperf.

It's added as a declaration into into:

  include/perf/threadmap.h

which will be included by users.

The perf_thread_map struct definition is added into:

  include/internal/threadmap.h

which is not to be included by users, but shared within perf and
libperf.

We tried the total separation of the perf_thread_map struct in libperf,
but it lead to complications and much bigger changes in perf code, so we
decided to share the declaration.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-32-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                        |  1 +
 tools/perf/lib/include/internal/threadmap.h | 21 +++++++++++++++++++++
 tools/perf/lib/include/perf/threadmap.h     |  7 +++++++
 tools/perf/lib/threadmap.c                  |  5 +++++
 tools/perf/util/thread_map.h                | 13 +------------
 5 files changed, 35 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/threadmap.h
 create mode 100644 tools/perf/lib/include/perf/threadmap.h
 create mode 100644 tools/perf/lib/threadmap.c

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 195b274db49a..9beadfc81a71 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -1,2 +1,3 @@
 libperf-y += core.o
 libperf-y += cpumap.o
+libperf-y += threadmap.o
diff --git a/tools/perf/lib/include/internal/threadmap.h b/tools/perf/lib/include/internal/threadmap.h
new file mode 100644
index 000000000000..c8088005a9ab
--- /dev/null
+++ b/tools/perf/lib/include/internal/threadmap.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_THREADMAP_H
+#define __LIBPERF_INTERNAL_THREADMAP_H
+
+#include <linux/refcount.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+struct thread_map_data {
+	pid_t	 pid;
+	char	*comm;
+};
+
+struct perf_thread_map {
+	refcount_t	refcnt;
+	int		nr;
+	int		err_thread;
+	struct thread_map_data map[];
+};
+
+#endif /* __LIBPERF_INTERNAL_THREADMAP_H */
diff --git a/tools/perf/lib/include/perf/threadmap.h b/tools/perf/lib/include/perf/threadmap.h
new file mode 100644
index 000000000000..dc3a3837b56f
--- /dev/null
+++ b/tools/perf/lib/include/perf/threadmap.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_THREADMAP_H
+#define __LIBPERF_THREADMAP_H
+
+struct perf_thread_map;
+
+#endif /* __LIBPERF_THREADMAP_H */
diff --git a/tools/perf/lib/threadmap.c b/tools/perf/lib/threadmap.c
new file mode 100644
index 000000000000..163dc609b909
--- /dev/null
+++ b/tools/perf/lib/threadmap.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/threadmap.h>
+#include <stdlib.h>
+#include <linux/refcount.h>
+#include <internal/threadmap.h>
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 9358b1b6e657..5a7be6f8934f 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -5,18 +5,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <linux/refcount.h>
-
-struct thread_map_data {
-	pid_t    pid;
-	char	*comm;
-};
-
-struct perf_thread_map {
-	refcount_t refcnt;
-	int nr;
-	int err_thread;
-	struct thread_map_data map[];
-};
+#include <internal/threadmap.h>
 
 struct thread_map_event;
 
-- 
2.21.0
