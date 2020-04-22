From: Ian Rogers <irogers@google.com>
Subject: [PATCH v2 11/11] perf test: add expr test for pmu metrics
Date: Wed, 22 Apr 2020 15:04:30 -0700
Message-ID: <20200422220430.254014-12-irogers@google.com>
References: <20200422220430.254014-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Add basic floating point number test.
Verify that all pmu metrics, for the current architecture, parse.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  5 ++
 tools/perf/tests/expr.c         | 96 ++++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |  2 +
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b6322eb0f423..28d547951f6b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -63,6 +63,11 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Simple expression parser",
 		.func = test__expr,
+		.subtest = {
+			.get_nr		= test__expr_subtest_get_nr,
+			.get_desc	= test__expr_subtest_get_desc,
+		},
+
 	},
 	{
 		.desc = "PERF_RECORD_* events & perf_sample fields",
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index ea10fc4412c4..35af232eb01d 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "pmu-events/pmu-events.h"
 #include "util/debug.h"
 #include "util/expr.h"
 #include "tests.h"
 #include <stdlib.h>
 #include <string.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 
 static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
@@ -16,7 +18,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 	return 0;
 }
 
-int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int parse_tests(void)
 {
 	const char *p;
 	const char **other;
@@ -39,6 +41,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	ret |= test(&ctx, "min(1,2) + 1", 2);
 	ret |= test(&ctx, "max(1,2) + 1", 3);
 	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
+	ret |= test(&ctx, "1.1 + 2.1", 3.2);
 
 	if (ret)
 		return ret;
@@ -65,3 +68,94 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	return 0;
 }
+
+static int pmu_tests(void)
+{
+	struct pmu_events_map *map;
+	struct pmu_event *pe;
+	int i, j, k;
+	const char **ids;
+	int idnum;
+	int ret = 0;
+	struct expr_parse_ctx ctx;
+	double result;
+
+	i = 0;
+	for (;;) {
+		map = &pmu_events_map[i++];
+		if (!map->table) {
+			map = NULL;
+			break;
+		}
+		j = 0;
+		for (;;) {
+			pe = &map->table[j++];
+			if (!pe->name && !pe->metric_group && !pe->metric_name)
+				break;
+			if (!pe->metric_expr)
+				continue;
+			if (expr__find_other(pe->metric_expr, NULL,
+						&ids, &idnum) < 0) {
+				pr_debug("Parse other failed for map %s %s %s\n",
+					map->cpuid, map->version, map->type);
+				pr_debug("On metric %s\n", pe->metric_name);
+				pr_debug("On expression %s\n", pe->metric_expr);
+				ret++;
+				continue;
+			}
+			expr__ctx_init(&ctx);
+			/*
+			 * Add all ids with a made up value. The value may
+			 * trigger divide by zero when subtracted and so try to
+			 * make them unique.
+			 */
+			for (k = 0; k < idnum; k++)
+				expr__add_id(&ctx, ids[k], k + 1);
+
+			if (expr__parse(&result, &ctx, pe->metric_expr)) {
+				pr_debug("Parse failed for map %s %s %s\n",
+					map->cpuid, map->version, map->type);
+				pr_debug("On metric %s\n", pe->metric_name);
+				pr_debug("On expression %s\n", pe->metric_expr);
+				ret++;
+			}
+			for (k = 0; k < idnum; k++)
+				zfree(&ids[k]);
+			free(ids);
+		}
+	}
+	return ret;
+}
+
+static const struct {
+	int (*func)(void);
+	const char *desc;
+} expr_testcase_table[] = {
+	{
+		.func = parse_tests,
+		.desc = "Basic expressions",
+	},
+	{
+		.func = pmu_tests,
+		.desc = "Parsing of pmu metrics",
+	},
+};
+
+const char *test__expr_subtest_get_desc(int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(expr_testcase_table))
+		return NULL;
+	return expr_testcase_table[i].desc;
+}
+
+int test__expr_subtest_get_nr(void)
+{
+	return (int)ARRAY_SIZE(expr_testcase_table);
+}
+
+int test__expr(struct test *test __maybe_unused, int i __maybe_unused)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(expr_testcase_table))
+		return TEST_FAIL;
+	return expr_testcase_table[i].func();
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 61a1ab032080..315d64ffd14c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -72,6 +72,8 @@ int test__keep_tracking(struct test *test, int subtest);
 int test__parse_no_sample_id_all(struct test *test, int subtest);
 int test__dwarf_unwind(struct test *test, int subtest);
 int test__expr(struct test *test, int subtest);
+const char *test__expr_subtest_get_desc(int subtest);
+int test__expr_subtest_get_nr(void);
 int test__hists_filter(struct test *test, int subtest);
 int test__mmap_thread_lookup(struct test *test, int subtest);
 int test__thread_maps_share(struct test *test, int subtest);
-- 
2.26.2.303.gf8c07b1a785-goog
