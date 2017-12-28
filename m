From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/35] perf stat: Define a structure for per-thread shadow stats
Date: Thu, 28 Dec 2017 11:29:53 -0300
Message-ID: <20171228143027.30547-2-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Perf has a set of static variables to record the runtime shadow metrics
stats.

While if we want to record the runtime shadow stats for per-thread, it
will be the limitation. This patch creates a structure and the next
patches will use this structure to update the runtime shadow stats for
per-thread.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 11 -----------
 tools/perf/util/stat.h        | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 57ec22513971..93aac2788056 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -9,17 +9,6 @@
 #include "expr.h"
 #include "metricgroup.h"
 
-enum {
-	CTX_BIT_USER	= 1 << 0,
-	CTX_BIT_KERNEL	= 1 << 1,
-	CTX_BIT_HV	= 1 << 2,
-	CTX_BIT_HOST	= 1 << 3,
-	CTX_BIT_IDLE	= 1 << 4,
-	CTX_BIT_MAX	= 1 << 5,
-};
-
-#define NUM_CTX CTX_BIT_MAX
-
 /*
  * AGGR_GLOBAL: Use CPU 0
  * AGGR_SOCKET: Use first CPU of socket
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index eefca5c981fd..c685c41f1fb9 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <stdio.h>
 #include "xyarray.h"
+#include "rblist.h"
 
 struct stats
 {
@@ -43,6 +44,47 @@ enum aggr_mode {
 	AGGR_UNSET,
 };
 
+enum {
+	CTX_BIT_USER	= 1 << 0,
+	CTX_BIT_KERNEL	= 1 << 1,
+	CTX_BIT_HV	= 1 << 2,
+	CTX_BIT_HOST	= 1 << 3,
+	CTX_BIT_IDLE	= 1 << 4,
+	CTX_BIT_MAX	= 1 << 5,
+};
+
+#define NUM_CTX CTX_BIT_MAX
+
+enum stat_type {
+	STAT_NONE = 0,
+	STAT_NSECS,
+	STAT_CYCLES,
+	STAT_STALLED_CYCLES_FRONT,
+	STAT_STALLED_CYCLES_BACK,
+	STAT_BRANCHES,
+	STAT_CACHEREFS,
+	STAT_L1_DCACHE,
+	STAT_L1_ICACHE,
+	STAT_LL_CACHE,
+	STAT_ITLB_CACHE,
+	STAT_DTLB_CACHE,
+	STAT_CYCLES_IN_TX,
+	STAT_TRANSACTION,
+	STAT_ELISION,
+	STAT_TOPDOWN_TOTAL_SLOTS,
+	STAT_TOPDOWN_SLOTS_ISSUED,
+	STAT_TOPDOWN_SLOTS_RETIRED,
+	STAT_TOPDOWN_FETCH_BUBBLES,
+	STAT_TOPDOWN_RECOVERY_BUBBLES,
+	STAT_SMI_NUM,
+	STAT_APERF,
+	STAT_MAX
+};
+
+struct runtime_stat {
+	struct rblist value_list;
+};
+
 struct perf_stat_config {
 	enum aggr_mode	aggr_mode;
 	bool		scale;
@@ -92,7 +134,6 @@ struct perf_stat_output_ctx {
 	bool force_header;
 };
 
-struct rblist;
 void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out,
-- 
2.13.6
