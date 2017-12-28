From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/35] perf stat: Extend rbtree to support per-thread shadow stats
Date: Thu, 28 Dec 2017 11:29:54 -0300
Message-ID: <20171228143027.30547-3-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously the rbtree was used to link generic metrics.

This patches adds new ctx/type/stat into rbtree keys because we will use
this rbtree to maintain shadow metrics to replace original a couple of
static arrays for supporting per-thread shadow stats.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 93aac2788056..528be3e8d13b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -45,7 +45,10 @@ struct stats walltime_nsecs_stats;
 struct saved_value {
 	struct rb_node rb_node;
 	struct perf_evsel *evsel;
+	enum stat_type type;
+	int ctx;
 	int cpu;
+	struct runtime_stat *stat;
 	struct stats stats;
 };
 
@@ -58,6 +61,30 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
 
 	if (a->cpu != b->cpu)
 		return a->cpu - b->cpu;
+
+	/*
+	 * Previously the rbtree was used to link generic metrics.
+	 * The keys were evsel/cpu. Now the rbtree is extended to support
+	 * per-thread shadow stats. For shadow stats case, the keys
+	 * are cpu/type/ctx/stat (evsel is NULL). For generic metrics
+	 * case, the keys are still evsel/cpu (type/ctx/stat are 0 or NULL).
+	 */
+	if (a->type != b->type)
+		return a->type - b->type;
+
+	if (a->ctx != b->ctx)
+		return a->ctx - b->ctx;
+
+	if (a->evsel == NULL && b->evsel == NULL) {
+		if (a->stat == b->stat)
+			return 0;
+
+		if ((char *)a->stat < (char *)b->stat)
+			return -1;
+
+		return 1;
+	}
+
 	if (a->evsel == b->evsel)
 		return 0;
 	if ((char *)a->evsel < (char *)b->evsel)
-- 
2.13.6
