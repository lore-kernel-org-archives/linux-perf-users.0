From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 76/86] perf header: Change FEAT_OP* macros
Date: Wed, 19 Jul 2017 11:29:40 -0300
Message-ID: <20170719142950.3747-77-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

There are three FEAT_OP* macros:
  - FEAT_OPA: for features without process record.
  - FEAT_OPP: for features with process record.
  - FEAT_OPF: like FEAT_OPP but to show only if show_full_info flags
    is set.

To add pipe-mode headers we need yet another variation of the macros
(one to specify whether a feature generates an auxiliar record).

Instead, we redefine macros so that:
  - show_full_info is specified as an argument (to remove the
  FEAT_OPF variation) and,
  - it always sets "process" handler (to remove the FEAT_OPA variation).
  Individual process handlers can be NULLed individually.

This allows to define two variations only:
  - FEAT_OPR: synthesizes auxiliar event record.
  - FEAT_OPN: doesn't synthesize an auxiliar event record.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170718042549.145161-14-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 72 +++++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5e6d4d29a7a3..0fdbf7554ea3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/stringify.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/utsname.h>
@@ -2139,42 +2140,57 @@ struct feature_ops {
 	int (*process)(struct feat_fd *ff, void *data);
 	const char *name;
 	bool full_only;
+	bool synthesize;
 };
 
-#define FEAT_OPA(n, func) \
-	[n] = { .name = #n, .write = write_##func, .print = print_##func }
-#define FEAT_OPP(n, func) \
-	[n] = { .name = #n, .write = write_##func, .print = print_##func, \
-		.process = process_##func }
-#define FEAT_OPF(n, func) \
-	[n] = { .name = #n, .write = write_##func, .print = print_##func, \
-		.process = process_##func, .full_only = true }
+#define FEAT_OPR(n, func, __full_only) \
+	[HEADER_##n] = {					\
+		.name	    = __stringify(n),			\
+		.write	    = write_##func,			\
+		.print	    = print_##func,			\
+		.full_only  = __full_only,			\
+		.process    = process_##func,			\
+		.synthesize = true				\
+	}
+
+#define FEAT_OPN(n, func, __full_only) \
+	[HEADER_##n] = {					\
+		.name	    = __stringify(n),			\
+		.write	    = write_##func,			\
+		.print	    = print_##func,			\
+		.full_only  = __full_only,			\
+		.process    = process_##func			\
+	}
 
 /* feature_ops not implemented: */
 #define print_tracing_data	NULL
 #define print_build_id		NULL
 
+#define process_branch_stack	NULL
+#define process_stat		NULL
+
+
 static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
-	FEAT_OPP(HEADER_TRACING_DATA,	tracing_data),
-	FEAT_OPP(HEADER_BUILD_ID,	build_id),
-	FEAT_OPP(HEADER_HOSTNAME,	hostname),
-	FEAT_OPP(HEADER_OSRELEASE,	osrelease),
-	FEAT_OPP(HEADER_VERSION,	version),
-	FEAT_OPP(HEADER_ARCH,		arch),
-	FEAT_OPP(HEADER_NRCPUS,		nrcpus),
-	FEAT_OPP(HEADER_CPUDESC,	cpudesc),
-	FEAT_OPP(HEADER_CPUID,		cpuid),
-	FEAT_OPP(HEADER_TOTAL_MEM,	total_mem),
-	FEAT_OPP(HEADER_EVENT_DESC,	event_desc),
-	FEAT_OPP(HEADER_CMDLINE,	cmdline),
-	FEAT_OPF(HEADER_CPU_TOPOLOGY,	cpu_topology),
-	FEAT_OPF(HEADER_NUMA_TOPOLOGY,	numa_topology),
-	FEAT_OPA(HEADER_BRANCH_STACK,	branch_stack),
-	FEAT_OPP(HEADER_PMU_MAPPINGS,	pmu_mappings),
-	FEAT_OPP(HEADER_GROUP_DESC,	group_desc),
-	FEAT_OPP(HEADER_AUXTRACE,	auxtrace),
-	FEAT_OPA(HEADER_STAT,		stat),
-	FEAT_OPF(HEADER_CACHE,		cache),
+	FEAT_OPN(TRACING_DATA,	tracing_data,	false),
+	FEAT_OPN(BUILD_ID,	build_id,	false),
+	FEAT_OPR(HOSTNAME,	hostname,	false),
+	FEAT_OPR(OSRELEASE,	osrelease,	false),
+	FEAT_OPR(VERSION,	version,	false),
+	FEAT_OPR(ARCH,		arch,		false),
+	FEAT_OPR(NRCPUS,	nrcpus,		false),
+	FEAT_OPR(CPUDESC,	cpudesc,	false),
+	FEAT_OPR(CPUID,		cpuid,		false),
+	FEAT_OPR(TOTAL_MEM,	total_mem,	false),
+	FEAT_OPR(EVENT_DESC,	event_desc,	false),
+	FEAT_OPR(CMDLINE,	cmdline,	false),
+	FEAT_OPR(CPU_TOPOLOGY,	cpu_topology,	true),
+	FEAT_OPR(NUMA_TOPOLOGY,	numa_topology,	true),
+	FEAT_OPN(BRANCH_STACK,	branch_stack,	false),
+	FEAT_OPR(PMU_MAPPINGS,	pmu_mappings,	false),
+	FEAT_OPN(GROUP_DESC,	group_desc,	false),
+	FEAT_OPN(AUXTRACE,	auxtrace,	false),
+	FEAT_OPN(STAT,		stat,		false),
+	FEAT_OPN(CACHE,		cache,		true),
 };
 
 struct header_print_data {
-- 
2.9.4
