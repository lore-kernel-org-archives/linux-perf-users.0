From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/15] perf tools: Add utility function to detect SMT status
Date: Wed, 23 Aug 2017 16:36:03 -0300
Message-ID: <20170823193614.20394-5-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add an smt_on() function to return if SMT is enabled or disabled.  Used
in the next patch.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170811232634.30465-7-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build |  1 +
 tools/perf/util/smt.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/smt.h |  6 ++++++
 3 files changed, 51 insertions(+)
 create mode 100644 tools/perf/util/smt.c
 create mode 100644 tools/perf/util/smt.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8d49a989f193..94518c1bf8b6 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -22,6 +22,7 @@ libperf-y += rbtree.o
 libperf-y += libstring.o
 libperf-y += bitmap.o
 libperf-y += hweight.o
+libperf-y += smt.o
 libperf-y += quote.o
 libperf-y += strbuf.o
 libperf-y += string.o
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
new file mode 100644
index 000000000000..453f6f6f29f3
--- /dev/null
+++ b/tools/perf/util/smt.c
@@ -0,0 +1,44 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/bitops.h>
+#include "api/fs/fs.h"
+#include "smt.h"
+
+int smt_on(void)
+{
+	static bool cached;
+	static int cached_result;
+	int cpu;
+	int ncpu;
+
+	if (cached)
+		return cached_result;
+
+	ncpu = sysconf(_SC_NPROCESSORS_CONF);
+	for (cpu = 0; cpu < ncpu; cpu++) {
+		unsigned long long siblings;
+		char *str;
+		size_t strlen;
+		char fn[256];
+
+		snprintf(fn, sizeof fn,
+			"devices/system/cpu/cpu%d/topology/thread_siblings",
+			cpu);
+		if (sysfs__read_str(fn, &str, &strlen) < 0)
+			continue;
+		/* Entry is hex, but does not have 0x, so need custom parser */
+		siblings = strtoull(str, NULL, 16);
+		free(str);
+		if (hweight64(siblings) > 1) {
+			cached_result = 1;
+			cached = true;
+			break;
+		}
+	}
+	if (!cached) {
+		cached_result = 0;
+		cached = true;
+	}
+	return cached_result;
+}
diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
new file mode 100644
index 000000000000..b8414b7bcbc8
--- /dev/null
+++ b/tools/perf/util/smt.h
@@ -0,0 +1,6 @@
+#ifndef SMT_H
+#define SMT_H 1
+
+int smt_on(void);
+
+#endif
-- 
2.13.5
