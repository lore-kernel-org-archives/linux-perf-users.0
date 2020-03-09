From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/6] perf parse-events: Fix reading of invalid memory in event parsing
Date: Mon,  9 Mar 2020 15:53:21 -0300
Message-ID: <20200309185323.22583-5-acme@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, clang-built-linux@googlegroups.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

ADD_CONFIG_TERM accesses term->weak, however, in get_config_chgs this
value is accessed outside of the list_for_each_entry and references
invalid memory. Add an argument for ADD_CONFIG_TERM for weak and set it
to false in the get_config_chgs case.

This bug was cause by clang's address sanitizer and libfuzzer. It can be
reproduced with a command line of:

  perf stat -a -e i/bs,tsc,L2/o

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200307073121.203816-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a14995835d85..a7dc0b096974 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1213,7 +1213,7 @@ static int config_attr(struct perf_event_attr *attr,
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused)
 {
-#define ADD_CONFIG_TERM(__type)					\
+#define ADD_CONFIG_TERM(__type, __weak)				\
 	struct perf_evsel_config_term *__t;			\
 								\
 	__t = zalloc(sizeof(*__t));				\
@@ -1222,18 +1222,18 @@ static int get_config_terms(struct list_head *head_config,
 								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
-	__t->weak	= term->weak;				\
+	__t->weak	= __weak;				\
 	list_add_tail(&__t->list, head_terms)
 
-#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
+#define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)	\
 do {								\
-	ADD_CONFIG_TERM(__type);				\
+	ADD_CONFIG_TERM(__type, __weak);			\
 	__t->val.__name = __val;				\
 } while (0)
 
-#define ADD_CONFIG_TERM_STR(__type, __val)			\
+#define ADD_CONFIG_TERM_STR(__type, __val, __weak)		\
 do {								\
-	ADD_CONFIG_TERM(__type);				\
+	ADD_CONFIG_TERM(__type, __weak);			\
 	__t->val.str = strdup(__val);				\
 	if (!__t->val.str) {					\
 		zfree(&__t);					\
@@ -1247,62 +1247,62 @@ do {								\
 	list_for_each_entry(term, head_config, list) {
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
+			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
+			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_TIME:
-			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
+			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str);
+			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
-			ADD_CONFIG_TERM_STR(BRANCH, term->val.str);
+			ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
 			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_INHERIT:
 			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
-					    term->val.num ? 1 : 0);
+					    term->val.num ? 1 : 0, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
 			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
-					    term->val.num ? 0 : 1);
+					    term->val.num ? 0 : 1, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
 			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
-					    term->val.num ? 1 : 0);
+					    term->val.num ? 1 : 0, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
-					    term->val.num ? 0 : 1);
+					    term->val.num ? 0 : 1, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str);
+			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
 			ADD_CONFIG_TERM_VAL(PERCORE, percore,
-					    term->val.num ? true : false);
+					    term->val.num ? true : false, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
-					    term->val.num ? 1 : 0);
+					    term->val.num ? 1 : 0, term->weak);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
-					    term->val.num);
+					    term->val.num, term->weak);
 			break;
 		default:
 			break;
@@ -1339,7 +1339,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	}
 
 	if (bits)
-		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
+		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
 
 #undef ADD_CONFIG_TERM
 	return 0;
-- 
2.21.1
