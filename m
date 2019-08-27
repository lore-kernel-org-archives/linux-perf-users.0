From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/33] perf cacheline: Move cacheline related routines to separate files
Date: Mon, 26 Aug 2019 22:36:05 -0300
Message-ID: <20190827013634.3173-5-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To disentangle util/sort.h a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6kbf2cauas06rbqp15pyter5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c    |  1 +
 tools/perf/util/Build       |  1 +
 tools/perf/util/cacheline.c | 26 ++++++++++++++++++++++++++
 tools/perf/util/cacheline.h | 21 +++++++++++++++++++++
 tools/perf/util/sort.c      |  1 +
 tools/perf/util/sort.h      | 12 ------------
 tools/perf/util/util.c      | 20 --------------------
 tools/perf/util/util.h      |  1 -
 8 files changed, 50 insertions(+), 33 deletions(-)
 create mode 100644 tools/perf/util/cacheline.c
 create mode 100644 tools/perf/util/cacheline.h

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 211143720078..73782d99ee5a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -26,6 +26,7 @@
 #include "hist.h"
 #include "sort.h"
 #include "tool.h"
+#include "cacheline.h"
 #include "data.h"
 #include "event.h"
 #include "evlist.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b922c8c297ca..2e3856471e61 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,6 +1,7 @@
 perf-y += annotate.o
 perf-y += block-range.o
 perf-y += build-id.o
+perf-y += cacheline.o
 perf-y += config.o
 perf-y += ctype.o
 perf-y += db-export.o
diff --git a/tools/perf/util/cacheline.c b/tools/perf/util/cacheline.c
new file mode 100644
index 000000000000..9361d3f61f75
--- /dev/null
+++ b/tools/perf/util/cacheline.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "cacheline.h"
+#include "../perf.h"
+#include <unistd.h>
+
+#ifdef _SC_LEVEL1_DCACHE_LINESIZE
+#define cache_line_size(cacheline_sizep) *cacheline_sizep = sysconf(_SC_LEVEL1_DCACHE_LINESIZE)
+#else
+#include <api/fs/fs.h>
+#include "debug.h"
+static void cache_line_size(int *cacheline_sizep)
+{
+	if (sysfs__read_int("devices/system/cpu/cpu0/cache/index0/coherency_line_size", cacheline_sizep))
+		pr_debug("cannot determine cache line size");
+}
+#endif
+
+int cacheline_size(void)
+{
+	static int size;
+
+	if (!size)
+		cache_line_size(&size);
+
+	return size;
+}
diff --git a/tools/perf/util/cacheline.h b/tools/perf/util/cacheline.h
new file mode 100644
index 000000000000..dec8c0fb1f4a
--- /dev/null
+++ b/tools/perf/util/cacheline.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_CACHELINE_H
+#define PERF_CACHELINE_H
+
+#include <linux/compiler.h>
+
+int __pure cacheline_size(void);
+
+static inline u64 cl_address(u64 address)
+{
+	/* return the cacheline of the address */
+	return (address & ~(cacheline_size() - 1));
+}
+
+static inline u64 cl_offset(u64 address)
+{
+	/* return the cacheline of the address */
+	return (address & (cacheline_size() - 1));
+}
+
+#endif // PERF_CACHELINE_H
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f9a38a1dd4d1..904ff4b2f57f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -6,6 +6,7 @@
 #include <linux/time64.h>
 #include "sort.h"
 #include "hist.h"
+#include "cacheline.h"
 #include "comm.h"
 #include "map.h"
 #include "symbol.h"
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5e34676a98e8..4ae155c6a808 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -204,18 +204,6 @@ static inline float hist_entry__get_percent_limit(struct hist_entry *he)
 	return period * 100.0 / total_period;
 }
 
-static inline u64 cl_address(u64 address)
-{
-	/* return the cacheline of the address */
-	return (address & ~(cacheline_size() - 1));
-}
-
-static inline u64 cl_offset(u64 address)
-{
-	/* return the cacheline of the address */
-	return (address & (cacheline_size() - 1));
-}
-
 enum sort_mode {
 	SORT_MODE__NORMAL,
 	SORT_MODE__BRANCH,
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 6fd130a5d8f2..44211e483fbf 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -43,26 +43,6 @@ void perf_set_multithreaded(void)
 
 unsigned int page_size;
 
-#ifdef _SC_LEVEL1_DCACHE_LINESIZE
-#define cache_line_size(cacheline_sizep) *cacheline_sizep = sysconf(_SC_LEVEL1_DCACHE_LINESIZE)
-#else
-static void cache_line_size(int *cacheline_sizep)
-{
-	if (sysfs__read_int("devices/system/cpu/cpu0/cache/index0/coherency_line_size", cacheline_sizep))
-		pr_debug("cannot determine cache line size");
-}
-#endif
-
-int cacheline_size(void)
-{
-	static int size;
-
-	if (!size)
-		cache_line_size(&size);
-
-	return size;
-}
-
 int sysctl_perf_event_max_stack = PERF_MAX_STACK_DEPTH;
 int sysctl_perf_event_max_contexts_per_stack = PERF_MAX_CONTEXTS_PER_STACK;
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 0dab140c6517..45a5c6f20197 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -34,7 +34,6 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 size_t hex_width(u64 v);
 
 extern unsigned int page_size;
-int __pure cacheline_size(void);
 
 int sysctl__max_stack(void);
 
-- 
2.21.0
