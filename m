From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/24] perf test: Add pmu-events test
Date: Wed, 25 Mar 2020 09:41:19 -0300
Message-ID: <20200325124124.32648-20-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@arm.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linuxarm@huawei.com
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

The initial test will verify that the test tables in generated pmu-events.c
match against known, expected values.

For known events added in pmu-events/arch/test, we need to add an entry
in test_cpu_aliases_events[] or test_uncore_events[].

A sample run is as follows for x86:

  john@linux-3c19:~/linux> tools/perf/perf test -vv 10
  10: PMU event aliases                                     :
  --- start ---
  test child forked, pid 5316
  testing event table bp_l1_btb_correct: pass
  testing event table bp_l2_btb_correct: pass
  testing event table segment_reg_loads.any: pass
  testing event table dispatch_blocked.any: pass
  testing event table eist_trans: pass
  testing event table uncore_hisi_ddrc.flux_wcmd: pass
  testing event table unc_cbo_xsnp_response.miss_eviction: pass
  test child finished with 0
  ---- end ----
  PMU event aliases: Ok

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
[ Fixup test_cpu_events[] and test_uncore_events[] sentinels to initialize one of its members to NULL, fixing the build in older compilers ]
Link: http://lore.kernel.org/lkml/1584442939-8911-5-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 +
 tools/perf/tests/pmu-events.c   | 233 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 239 insertions(+)
 create mode 100644 tools/perf/tests/pmu-events.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 1692529639b0..b3d1bf13ca07 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -14,6 +14,7 @@ perf-y += evsel-roundtrip-name.o
 perf-y += evsel-tp-sched.o
 perf-y += fdarray.o
 perf-y += pmu.o
+perf-y += pmu-events.o
 perf-y += hists_common.o
 perf-y += hists_link.o
 perf-y += hists_filter.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54d9516c9839..b6322eb0f423 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -72,6 +72,10 @@ static struct test generic_tests[] = {
 		.desc = "Parse perf pmu format",
 		.func = test__pmu,
 	},
+	{
+		.desc = "PMU events",
+		.func = test__pmu_events,
+	},
 	{
 		.desc = "DSO data read",
 		.func = test__dso_data,
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
new file mode 100644
index 000000000000..12fc29746a09
--- /dev/null
+++ b/tools/perf/tests/pmu-events.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "parse-events.h"
+#include "pmu.h"
+#include "tests.h"
+#include <errno.h>
+#include <stdio.h>
+#include <linux/kernel.h>
+
+#include "debug.h"
+#include "../pmu-events/pmu-events.h"
+
+struct perf_pmu_test_event {
+	struct pmu_event event;
+};
+static struct perf_pmu_test_event test_cpu_events[] = {
+	{
+		.event = {
+			.name = "bp_l1_btb_correct",
+			.event = "event=0x8a",
+			.desc = "L1 BTB Correction",
+			.topic = "branch",
+		},
+	},
+	{
+		.event = {
+			.name = "bp_l2_btb_correct",
+			.event = "event=0x8b",
+			.desc = "L2 BTB Correction",
+			.topic = "branch",
+		},
+	},
+	{
+		.event = {
+			.name = "segment_reg_loads.any",
+			.event = "umask=0x80,period=200000,event=0x6",
+			.desc = "Number of segment register loads",
+			.topic = "other",
+		},
+	},
+	{
+		.event = {
+			.name = "dispatch_blocked.any",
+			.event = "umask=0x20,period=200000,event=0x9",
+			.desc = "Memory cluster signals to block micro-op dispatch for any reason",
+			.topic = "other",
+		},
+	},
+	{
+		.event = {
+			.name = "eist_trans",
+			.event = "umask=0x0,period=200000,event=0x3a",
+			.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
+			.topic = "other",
+		},
+	},
+	{ /* sentinel */
+		.event = {
+			.name = NULL,
+		},
+	},
+};
+
+static struct perf_pmu_test_event test_uncore_events[] = {
+	{
+		.event = {
+			.name = "uncore_hisi_ddrc.flux_wcmd",
+			.event = "event=0x2",
+			.desc = "DDRC write commands. Unit: hisi_sccl,ddrc ",
+			.topic = "uncore",
+			.long_desc = "DDRC write commands",
+			.pmu = "hisi_sccl,ddrc",
+		},
+	},
+	{
+		.event = {
+			.name = "unc_cbo_xsnp_response.miss_eviction",
+			.event = "umask=0x81,event=0x22",
+			.desc = "Unit: uncore_cbox A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+			.topic = "uncore",
+			.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+			.pmu = "uncore_cbox",
+		},
+	},
+	{ /* sentinel */
+		.event = {
+			.name = NULL,
+		},
+	}
+};
+
+const int total_test_events_size = ARRAY_SIZE(test_uncore_events);
+
+static bool is_same(const char *reference, const char *test)
+{
+	if (!reference && !test)
+		return true;
+
+	if (reference && !test)
+		return false;
+
+	if (!reference && test)
+		return false;
+
+	return !strcmp(reference, test);
+}
+
+static struct pmu_events_map *__test_pmu_get_events_map(void)
+{
+	struct pmu_events_map *map;
+
+	for (map = &pmu_events_map[0]; map->cpuid; map++) {
+		if (!strcmp(map->cpuid, "testcpu"))
+			return map;
+	}
+
+	pr_err("could not find test events map\n");
+
+	return NULL;
+}
+
+/* Verify generated events from pmu-events.c is as expected */
+static int __test_pmu_event_table(void)
+{
+	struct pmu_events_map *map = __test_pmu_get_events_map();
+	struct pmu_event *table;
+	int map_events = 0, expected_events;
+
+	/* ignore 2x sentinels */
+	expected_events = ARRAY_SIZE(test_cpu_events) +
+			  ARRAY_SIZE(test_uncore_events) - 2;
+
+	if (!map)
+		return -1;
+
+	for (table = map->table; table->name; table++) {
+		struct perf_pmu_test_event *test;
+		struct pmu_event *te;
+		bool found = false;
+
+		if (table->pmu)
+			test = &test_uncore_events[0];
+		else
+			test = &test_cpu_events[0];
+
+		te = &test->event;
+
+		for (; te->name; test++, te = &test->event) {
+			if (strcmp(table->name, te->name))
+				continue;
+			found = true;
+			map_events++;
+
+			if (!is_same(table->desc, te->desc)) {
+				pr_debug2("testing event table %s: mismatched desc, %s vs %s\n",
+					  table->name, table->desc, te->desc);
+				return -1;
+			}
+
+			if (!is_same(table->topic, te->topic)) {
+				pr_debug2("testing event table %s: mismatched topic, %s vs %s\n",
+					  table->name, table->topic,
+					  te->topic);
+				return -1;
+			}
+
+			if (!is_same(table->long_desc, te->long_desc)) {
+				pr_debug2("testing event table %s: mismatched long_desc, %s vs %s\n",
+					  table->name, table->long_desc,
+					  te->long_desc);
+				return -1;
+			}
+
+			if (!is_same(table->unit, te->unit)) {
+				pr_debug2("testing event table %s: mismatched unit, %s vs %s\n",
+					  table->name, table->unit,
+					  te->unit);
+				return -1;
+			}
+
+			if (!is_same(table->perpkg, te->perpkg)) {
+				pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
+					  table->name, table->perpkg,
+					  te->perpkg);
+				return -1;
+			}
+
+			if (!is_same(table->metric_expr, te->metric_expr)) {
+				pr_debug2("testing event table %s: mismatched metric_expr, %s vs %s\n",
+					  table->name, table->metric_expr,
+					  te->metric_expr);
+				return -1;
+			}
+
+			if (!is_same(table->metric_name, te->metric_name)) {
+				pr_debug2("testing event table %s: mismatched metric_name, %s vs %s\n",
+					  table->name,  table->metric_name,
+					  te->metric_name);
+				return -1;
+			}
+
+			if (!is_same(table->deprecated, te->deprecated)) {
+				pr_debug2("testing event table %s: mismatched deprecated, %s vs %s\n",
+					  table->name, table->deprecated,
+					  te->deprecated);
+				return -1;
+			}
+
+			pr_debug("testing event table %s: pass\n", table->name);
+		}
+
+		if (!found) {
+			pr_err("testing event table: could not find event %s\n",
+			       table->name);
+			return -1;
+		}
+	}
+
+	if (map_events != expected_events) {
+		pr_err("testing event table: found %d, but expected %d\n",
+		       map_events, expected_events);
+		return -1;
+	}
+
+	return 0;
+}
+int test__pmu_events(struct test *test __maybe_unused,
+		     int subtest __maybe_unused)
+{
+	if (__test_pmu_event_table())
+		return -1;
+
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a160fef47c9..61a1ab032080 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -49,6 +49,7 @@ int test__perf_evsel__roundtrip_name_test(struct test *test, int subtest);
 int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
 int test__syscall_openat_tp_fields(struct test *test, int subtest);
 int test__pmu(struct test *test, int subtest);
+int test__pmu_events(struct test *test, int subtest);
 int test__attr(struct test *test, int subtest);
 int test__dso_data(struct test *test, int subtest);
 int test__dso_data_cache(struct test *test, int subtest);
-- 
2.21.1
