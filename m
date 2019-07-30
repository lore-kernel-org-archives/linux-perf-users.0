From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 053/107] libperf: Add perf/core.h header
Date: Mon, 29 Jul 2019 23:55:16 -0300
Message-ID: <20190730025610.22603-54-acme@kernel.org>
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

Add perf/core.h header to be used in header files coming in the
following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/core.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 tools/perf/lib/include/perf/core.h

diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
new file mode 100644
index 000000000000..e2e4b43c9131
--- /dev/null
+++ b/tools/perf/lib/include/perf/core.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CORE_H
+#define __LIBPERF_CORE_H
+
+#ifndef LIBPERF_API
+#define LIBPERF_API __attribute__((visibility("default")))
+#endif
+
+#endif /* __LIBPERF_CORE_H */
-- 
2.21.0
