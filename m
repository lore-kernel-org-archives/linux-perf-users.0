From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/60] perf expr: Add expr_ prefix for parse_ctx and parse_id
Date: Mon, 20 Apr 2020 08:52:37 -0300
Message-ID: <20200420115316.18781-22-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jin Yao <yao.jin@linux.intel.com>, Joe Mario <jmario@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Petlan <mpetlan@redhat.com>, Paul
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding expr_ prefix for parse_ctx and parse_id, to straighten out the
expr* namespace.

There's no functional change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20200401203340.31402-2-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c       |  4 ++--
 tools/perf/util/expr.c        | 10 +++++-----
 tools/perf/util/expr.h        | 12 ++++++------
 tools/perf/util/expr.y        |  6 +++---
 tools/perf/util/stat-shadow.c |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 28313e59d6f6..ea10fc4412c4 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <linux/zalloc.h>
 
-static int test(struct parse_ctx *ctx, const char *e, double val2)
+static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 {
 	double val;
 
@@ -22,7 +22,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	const char **other;
 	double val;
 	int i, ret;
-	struct parse_ctx ctx;
+	struct expr_parse_ctx ctx;
 	int num_other;
 
 	expr__ctx_init(&ctx);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index fd192ddf93c1..c8ccc548a585 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -11,7 +11,7 @@ extern int expr_debug;
 #endif
 
 /* Caller must make sure id is allocated */
-void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
+void expr__add_id(struct expr_parse_ctx *ctx, const char *name, double val)
 {
 	int idx;
 
@@ -21,13 +21,13 @@ void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
 	ctx->ids[idx].val = val;
 }
 
-void expr__ctx_init(struct parse_ctx *ctx)
+void expr__ctx_init(struct expr_parse_ctx *ctx)
 {
 	ctx->num_ids = 0;
 }
 
 static int
-__expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
+__expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	      int start)
 {
 	YY_BUFFER_STATE buffer;
@@ -52,7 +52,7 @@ __expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
 	return ret;
 }
 
-int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr)
+int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr)
 {
 	return __expr__parse(final_val, ctx, expr, EXPR_PARSE) ? -1 : 0;
 }
@@ -75,7 +75,7 @@ int expr__find_other(const char *expr, const char *one, const char ***other,
 		     int *num_other)
 {
 	int err, i = 0, j = 0;
-	struct parse_ctx ctx;
+	struct expr_parse_ctx ctx;
 
 	expr__ctx_init(&ctx);
 	err = __expr__parse(NULL, &ctx, expr, EXPR_OTHER);
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 9377538f4097..b9e53f2b5844 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -5,19 +5,19 @@
 #define EXPR_MAX_OTHER 20
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
-struct parse_id {
+struct expr_parse_id {
 	const char *name;
 	double val;
 };
 
-struct parse_ctx {
+struct expr_parse_ctx {
 	int num_ids;
-	struct parse_id ids[MAX_PARSE_ID];
+	struct expr_parse_id ids[MAX_PARSE_ID];
 };
 
-void expr__ctx_init(struct parse_ctx *ctx);
-void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
-int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr);
+void expr__ctx_init(struct expr_parse_ctx *ctx);
+void expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
+int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr);
 int expr__find_other(const char *expr, const char *one, const char ***other,
 		int *num_other);
 
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 4720cbe79357..cd17486c1c5d 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -15,7 +15,7 @@
 %define api.pure full
 
 %parse-param { double *final_val }
-%parse-param { struct parse_ctx *ctx }
+%parse-param { struct expr_parse_ctx *ctx }
 %parse-param {void *scanner}
 %lex-param {void* scanner}
 
@@ -39,14 +39,14 @@
 
 %{
 static void expr_error(double *final_val __maybe_unused,
-		       struct parse_ctx *ctx __maybe_unused,
+		       struct expr_parse_ctx *ctx __maybe_unused,
 		       void *scanner,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
 }
 
-static int lookup_id(struct parse_ctx *ctx, char *id, double *val)
+static int lookup_id(struct expr_parse_ctx *ctx, char *id, double *val)
 {
 	int i;
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 03ecb8cd0eec..1ad5c5be7e97 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -729,7 +729,7 @@ static void generic_metric(struct perf_stat_config *config,
 			   struct runtime_stat *st)
 {
 	print_metric_t print_metric = out->print_metric;
-	struct parse_ctx pctx;
+	struct expr_parse_ctx pctx;
 	double ratio, scale;
 	int i;
 	void *ctxp = out->ctx;
-- 
2.21.1
