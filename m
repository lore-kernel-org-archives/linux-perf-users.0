From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/57] perf stat: Support --all-kernel/--all-user
Date: Mon, 21 Oct 2019 10:37:50 -0300
Message-ID: <20191021133834.25998-14-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

'perf record' has supported --all-kernel / --all-user to configure all
used events to run in kernel space or run in user space. But 'perf stat'
doesn't support these options.

It would be useful to support these options in 'perf stat' too to keep
the same semantics available in both tools.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191011050545.3899-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  6 ++++++
 tools/perf/builtin-stat.c              |  6 ++++++
 tools/perf/util/stat.c                 | 10 ++++++++++
 tools/perf/util/stat.h                 |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 930c51c01201..a9af4e440e80 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -323,6 +323,12 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
 
 Users who wants to get the actual value can apply --no-metric-only.
 
+--all-kernel::
+Configure all used events to run in kernel space.
+
+--all-user::
+Configure all used events to run in user space.
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 468fc49420ce..c88d4e118409 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -803,6 +803,12 @@ static struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
+			 "Configure all used events to run in kernel space.",
+			 PARSE_OPT_EXCLUSIVE),
+	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
+			 "Configure all used events to run in user space.",
+			 PARSE_OPT_EXCLUSIVE),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index ebdd130557fb..6822e4ffe224 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -490,6 +490,16 @@ int create_perf_stat_counter(struct evsel *evsel,
 	if (config->identifier)
 		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
 
+	if (config->all_user) {
+		attr->exclude_kernel = 1;
+		attr->exclude_user   = 0;
+	}
+
+	if (config->all_kernel) {
+		attr->exclude_kernel = 0;
+		attr->exclude_user   = 1;
+	}
+
 	/*
 	 * Disabling all counters initially, they will be enabled
 	 * either manually by us or by kernel via enable_on_exec
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index edbeb2f63e8d..081c4a5113c6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -106,6 +106,8 @@ struct perf_stat_config {
 	bool			 big_num;
 	bool			 no_merge;
 	bool			 walltime_run_table;
+	bool			 all_kernel;
+	bool			 all_user;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.21.0
