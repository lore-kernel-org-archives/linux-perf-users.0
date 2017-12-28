From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/35] perf stat: Create the runtime_stat init/exit function
Date: Thu, 28 Dec 2017 11:29:55 -0300
Message-ID: <20171228143027.30547-4-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

It mainly initializes and releases the rblist which is defined in struct
runtime_stat.

For the original rblist 'runtime_saved_values', it's still kept there
for keeping the patch bisectable.

The rblist 'runtime_saved_values' will be removed in later patch at
switching time.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-4-git-send-email-yao.jin@linux.intel.com
[ Rename 'stat' variables to 'st' to build on centos:{5,6} and others where it shadows a global declaration ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 17 +++++++++++++++++
 tools/perf/util/stat.h        |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 528be3e8d13b..07cfbf613bdc 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -40,6 +40,7 @@ static struct stats runtime_aperf_stats[NUM_CTX][MAX_NR_CPUS];
 static struct rblist runtime_saved_values;
 static bool have_frontend_stalled;
 
+struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
 
 struct saved_value {
@@ -134,6 +135,21 @@ static struct saved_value *saved_value_lookup(struct perf_evsel *evsel,
 	return NULL;
 }
 
+void runtime_stat__init(struct runtime_stat *st)
+{
+	struct rblist *rblist = &st->value_list;
+
+	rblist__init(rblist);
+	rblist->node_cmp = saved_value_cmp;
+	rblist->node_new = saved_value_new;
+	rblist->node_delete = saved_value_delete;
+}
+
+void runtime_stat__exit(struct runtime_stat *st)
+{
+	rblist__exit(&st->value_list);
+}
+
 void perf_stat__init_shadow_stats(void)
 {
 	have_frontend_stalled = pmu_have_event("cpu", "stalled-cycles-frontend");
@@ -141,6 +157,7 @@ void perf_stat__init_shadow_stats(void)
 	runtime_saved_values.node_cmp = saved_value_cmp;
 	runtime_saved_values.node_new = saved_value_new;
 	runtime_saved_values.node_delete = saved_value_delete;
+	runtime_stat__init(&rt_stat);
 }
 
 static int evsel_context(struct perf_evsel *evsel)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index c685c41f1fb9..f20240037377 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -117,12 +117,15 @@ bool __perf_evsel_stat__is(struct perf_evsel *evsel,
 
 void perf_stat_evsel_id_init(struct perf_evsel *evsel);
 
+extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 
 typedef void (*print_metric_t)(void *ctx, const char *color, const char *unit,
 			       const char *fmt, double val);
 typedef void (*new_line_t )(void *ctx);
 
+void runtime_stat__init(struct runtime_stat *st);
+void runtime_stat__exit(struct runtime_stat *st);
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
 void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
-- 
2.13.6
