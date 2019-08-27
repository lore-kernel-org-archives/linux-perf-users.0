From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/33] libperf: Add PERF_RECORD_MMAP 'struct mmap_event' to perf/event.h
Date: Mon, 26 Aug 2019 22:36:18 -0300
Message-ID: <20190827013634.3173-18-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the mmap_event event definition to libperf's event.h header
include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values as stated
in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Add  and use new PRI_lu64 and PRI_lx64 macros for that.  Use extra '_'
to ease up reading and differentiate them from standard PRI*64 macros.

Committer notes:

Fixup the PRI_l[ux]64 macros on 32-bit arches, conditionally defining it
with that extra 'l' modifier only on arches where __u64 is long long,
leaving it aside on 32-bit arches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 18 ++++++++++++++++++
 tools/perf/util/event.c             |  2 +-
 tools/perf/util/event.h             | 22 ++++++++++++++--------
 tools/perf/util/python.c            |  4 ++--
 4 files changed, 35 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/lib/include/perf/event.h

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
new file mode 100644
index 000000000000..13fe15a2fe7f
--- /dev/null
+++ b/tools/perf/lib/include/perf/event.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVENT_H
+#define __LIBPERF_EVENT_H
+
+#include <linux/perf_event.h>
+#include <linux/types.h>
+#include <linux/limits.h>
+
+struct mmap_event {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 start;
+	__u64			 len;
+	__u64			 pgoff;
+	char			 filename[PATH_MAX];
+};
+
+#endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 332edef8d394..43c86257e7fa 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1353,7 +1353,7 @@ int perf_event__process_bpf_event(struct perf_tool *tool __maybe_unused,
 
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]: %c %s\n",
+	return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64 "]: %c %s\n",
 		       event->mmap.pid, event->mmap.tid, event->mmap.start,
 		       event->mmap.len, event->mmap.pgoff,
 		       (event->header.misc & PERF_RECORD_MISC_MMAP_DATA) ? 'r' : 'x',
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 0e164e8ae28d..f43eff2fba2d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -7,19 +7,25 @@
 #include <linux/kernel.h>
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
+#include <perf/event.h>
 
 #include "../perf.h"
 #include "build-id.h"
 #include "perf_regs.h"
 
-struct mmap_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 start;
-	u64 len;
-	u64 pgoff;
-	char filename[PATH_MAX];
-};
+#ifdef __LP64__
+/*
+ * /usr/include/inttypes.h uses just 'lu' for PRIu64, but we end up defining
+ * __u64 as long long unsigned int, and then -Werror=format= kicks in and
+ * complains of the mismatched types, so use these two special extra PRI
+ * macros to overcome that.
+ */
+#define PRI_lu64 "l" PRIu64
+#define PRI_lx64 "l" PRIx64
+#else
+#define PRI_lu64 PRIu64
+#define PRI_lx64 PRIx64
+#endif
 
 struct mmap2_event {
 	struct perf_event_header header;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 75ecc32a4427..55ff0c3182d6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -130,8 +130,8 @@ static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
 	PyObject *ret;
 	char *s;
 
-	if (asprintf(&s, "{ type: mmap, pid: %u, tid: %u, start: %#" PRIx64 ", "
-			 "length: %#" PRIx64 ", offset: %#" PRIx64 ", "
+	if (asprintf(&s, "{ type: mmap, pid: %u, tid: %u, start: %#" PRI_lx64 ", "
+			 "length: %#" PRI_lx64 ", offset: %#" PRI_lx64 ", "
 			 "filename: %s }",
 		     pevent->event.mmap.pid, pevent->event.mmap.tid,
 		     pevent->event.mmap.start, pevent->event.mmap.len,
-- 
2.21.0
