From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/12] perf stat: Add event parsing error handling to add_default_attributes
Date: Mon, 11 Jun 2018 14:48:08 -0300
Message-ID: <20180611174810.14815-11-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add missing error handling for parse_events calls in add_default_attributes
functions. The error handler displays error details, like for transactions (-T):

Before:
  $ perf stat -T
  Cannot set up transaction events

After:
  $ perf stat -T
  Cannot set up transaction events
  event syntax error: '..cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}'
                                    \___ unknown term

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3fc1f5286d50..22547a490e1f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2442,14 +2442,13 @@ static int add_default_attributes(void)
 	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
 	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
 };
+	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
 	if (null_run)
 		return 0;
 
 	if (transaction_run) {
-		struct parse_events_error errinfo;
-
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
@@ -2460,6 +2459,7 @@ static int add_default_attributes(void)
 					   &errinfo);
 		if (err) {
 			fprintf(stderr, "Cannot set up transaction events\n");
+			parse_events_print_error(&errinfo, transaction_attrs);
 			return -1;
 		}
 		return 0;
@@ -2485,10 +2485,11 @@ static int add_default_attributes(void)
 		    pmu_have_event("msr", "smi")) {
 			if (!force_metric_only)
 				metric_only = true;
-			err = parse_events(evsel_list, smi_cost_attrs, NULL);
+			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
 		} else {
 			fprintf(stderr, "To measure SMI cost, it needs "
 				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
+			parse_events_print_error(&errinfo, smi_cost_attrs);
 			return -1;
 		}
 		if (err) {
@@ -2523,12 +2524,13 @@ static int add_default_attributes(void)
 		if (topdown_attrs[0] && str) {
 			if (warn)
 				arch_topdown_group_warn();
-			err = parse_events(evsel_list, str, NULL);
+			err = parse_events(evsel_list, str, &errinfo);
 			if (err) {
 				fprintf(stderr,
 					"Cannot set up top down events %s: %d\n",
 					str, err);
 				free(str);
+				parse_events_print_error(&errinfo, str);
 				return -1;
 			}
 		} else {
-- 
2.14.3
