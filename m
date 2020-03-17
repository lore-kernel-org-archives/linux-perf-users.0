From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v5 01/11] perf expr: Add expr_ prefix for parse_ctx and parse_id
Date: Tue, 17 Mar 2020 11:53:23 +0530
Message-ID: <20200317062333.14555-2-kjain@linux.ibm.com>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317062333.14555-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding expr_ prefix for parse_ctx and parse_id,
to straighten out the expr* namespace.

There's no functional change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 0fd713d3674f..402af3e8d287 100644
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
2.18.1
