From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/53] perf tools: Add fallback versions for CPU_{OR,EQUAL}()
Date: Wed,  6 Feb 2019 15:48:39 -0300
Message-ID: <20190206184903.24054-30-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

From the glibc sources, so that we can keep the tooling buildable in
older systems while using recent sched.h CPU_ macros.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-hvm9ysmrjip75ebdzhzoh429@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpu-set-sched.h | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/perf/util/cpu-set-sched.h

diff --git a/tools/perf/util/cpu-set-sched.h b/tools/perf/util/cpu-set-sched.h
new file mode 100644
index 000000000000..8cf4e40d322a
--- /dev/null
+++ b/tools/perf/util/cpu-set-sched.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: LGPL-2.1
+// Definitions taken from glibc for use with older systems, same licensing.
+#ifndef _CPU_SET_SCHED_PERF_H
+#define _CPU_SET_SCHED_PERF_H
+
+#include <features.h>
+#include <sched.h>
+
+#ifndef CPU_EQUAL
+#ifndef __CPU_EQUAL_S
+#if __GNUC_PREREQ (2, 91)
+# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
+  (__builtin_memcmp (cpusetp1, cpusetp2, setsize) == 0)
+#else
+# define __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2) \
+  (__extension__							      \
+   ({ const __cpu_mask *__arr1 = (cpusetp1)->__bits;			      \
+      const __cpu_mask *__arr2 = (cpusetp2)->__bits;			      \
+      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
+      size_t __i;							      \
+      for (__i = 0; __i < __imax; ++__i)				      \
+	if (__arr1[__i] != __arr2[__i])					      \
+	  break;							      \
+      __i == __imax; }))
+#endif
+#endif // __CPU_EQUAL_S
+
+#define CPU_EQUAL(cpusetp1, cpusetp2) \
+  __CPU_EQUAL_S (sizeof (cpu_set_t), cpusetp1, cpusetp2)
+#endif // CPU_EQUAL
+
+#ifndef CPU_OR
+#ifndef __CPU_OP_S
+#define __CPU_OP_S(setsize, destset, srcset1, srcset2, op) \
+  (__extension__							      \
+   ({ cpu_set_t *__dest = (destset);					      \
+      const __cpu_mask *__arr1 = (srcset1)->__bits;			      \
+      const __cpu_mask *__arr2 = (srcset2)->__bits;			      \
+      size_t __imax = (setsize) / sizeof (__cpu_mask);			      \
+      size_t __i;							      \
+      for (__i = 0; __i < __imax; ++__i)				      \
+	((__cpu_mask *) __dest->__bits)[__i] = __arr1[__i] op __arr2[__i];    \
+      __dest; }))
+#endif // __CPU_OP_S
+
+#define CPU_OR(destset, srcset1, srcset2) \
+  __CPU_OP_S (sizeof (cpu_set_t), destset, srcset1, srcset2, |)
+#endif // CPU_OR
+
+#endif // _CPU_SET_SCHED_PERF_H
-- 
2.20.1
