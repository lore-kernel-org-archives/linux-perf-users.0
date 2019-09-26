From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/66] perf evsel: Move config terms to a separate header
Date: Wed, 25 Sep 2019 21:32:37 -0300
Message-ID: <20190926003244.13962-60-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Further reducing the size of util/evsel.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-20zr7di9eynm0272mtjfdhfc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c |  1 +
 tools/perf/builtin-top.c          |  1 +
 tools/perf/util/evsel.c           |  1 +
 tools/perf/util/evsel.h           | 43 --------------------------
 tools/perf/util/evsel_config.h    | 50 +++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.c    |  1 +
 6 files changed, 54 insertions(+), 43 deletions(-)
 create mode 100644 tools/perf/util/evsel_config.h

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2e4de211d881..ede040cf82ad 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -23,6 +23,7 @@
 #include "../../util/event.h"
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
+#include "../../util/evsel_config.h"
 #include "../../util/pmu.h"
 #include "../../util/cs-etm.h"
 #include <internal/lib.h> // page_size
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 30d8eb614377..1f60124eb19b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -27,6 +27,7 @@
 #include "util/dso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evsel_config.h"
 #include "util/event.h"
 #include "util/machine.h"
 #include "util/map.h"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6323b0c60f6c..5591af81a070 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -30,6 +30,7 @@
 #include "counts.h"
 #include "event.h"
 #include "evsel.h"
+#include "util/evsel_config.h"
 #include "util/evsel_fprintf.h"
 #include "evlist.h"
 #include <perf/cpumap.h>
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 48183b5f5f83..ddc5ee6f6592 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -12,49 +12,6 @@
 #include "symbol_conf.h"
 #include <internal/cpumap.h>
 
-/*
- * The 'struct perf_evsel_config_term' is used to pass event
- * specific configuration data to perf_evsel__config routine.
- * It is allocated within event parsing and attached to
- * perf_evsel::config_terms list head.
-*/
-enum term_type {
-	PERF_EVSEL__CONFIG_TERM_PERIOD,
-	PERF_EVSEL__CONFIG_TERM_FREQ,
-	PERF_EVSEL__CONFIG_TERM_TIME,
-	PERF_EVSEL__CONFIG_TERM_CALLGRAPH,
-	PERF_EVSEL__CONFIG_TERM_STACK_USER,
-	PERF_EVSEL__CONFIG_TERM_INHERIT,
-	PERF_EVSEL__CONFIG_TERM_MAX_STACK,
-	PERF_EVSEL__CONFIG_TERM_MAX_EVENTS,
-	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
-	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
-	PERF_EVSEL__CONFIG_TERM_BRANCH,
-	PERF_EVSEL__CONFIG_TERM_PERCORE,
-	PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT,
-};
-
-struct perf_evsel_config_term {
-	struct list_head	list;
-	enum term_type	type;
-	union {
-		u64	period;
-		u64	freq;
-		bool	time;
-		char	*callgraph;
-		char	*drv_cfg;
-		u64	stack_user;
-		int	max_stack;
-		bool	inherit;
-		bool	overwrite;
-		char	*branch;
-		unsigned long max_events;
-		bool	percore;
-		bool	aux_output;
-	} val;
-	bool weak;
-};
-
 struct bpf_object;
 struct cgroup;
 struct perf_counts;
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
new file mode 100644
index 000000000000..8a7648037c18
--- /dev/null
+++ b/tools/perf/util/evsel_config.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __PERF_EVSEL_CONFIG_H
+#define __PERF_EVSEL_CONFIG_H 1
+
+#include <linux/types.h>
+#include <stdbool.h>
+
+/*
+ * The 'struct perf_evsel_config_term' is used to pass event
+ * specific configuration data to perf_evsel__config routine.
+ * It is allocated within event parsing and attached to
+ * perf_evsel::config_terms list head.
+*/
+enum evsel_term_type {
+	PERF_EVSEL__CONFIG_TERM_PERIOD,
+	PERF_EVSEL__CONFIG_TERM_FREQ,
+	PERF_EVSEL__CONFIG_TERM_TIME,
+	PERF_EVSEL__CONFIG_TERM_CALLGRAPH,
+	PERF_EVSEL__CONFIG_TERM_STACK_USER,
+	PERF_EVSEL__CONFIG_TERM_INHERIT,
+	PERF_EVSEL__CONFIG_TERM_MAX_STACK,
+	PERF_EVSEL__CONFIG_TERM_MAX_EVENTS,
+	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
+	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
+	PERF_EVSEL__CONFIG_TERM_BRANCH,
+	PERF_EVSEL__CONFIG_TERM_PERCORE,
+	PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT,
+};
+
+struct perf_evsel_config_term {
+	struct list_head      list;
+	enum evsel_term_type  type;
+	union {
+		u64	      period;
+		u64	      freq;
+		bool	      time;
+		char	      *callgraph;
+		char	      *drv_cfg;
+		u64	      stack_user;
+		int	      max_stack;
+		bool	      inherit;
+		bool	      overwrite;
+		char	      *branch;
+		unsigned long max_events;
+		bool	      percore;
+		bool	      aux_output;
+	} val;
+	bool weak;
+};
+#endif // __PERF_EVSEL_CONFIG_H
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d69ff746cda5..50737046fa63 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -34,6 +34,7 @@
 #include "asm/bug.h"
 #include "util/parse-branch-options.h"
 #include "metricgroup.h"
+#include "util/evsel_config.h"
 #include "util/mmap.h"
 
 #define MAX_NAME_LEN 100
-- 
2.21.0
