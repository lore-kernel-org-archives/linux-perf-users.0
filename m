From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/19] perf expr: Make expr__parse() return -1 on error
Date: Tue, 10 Mar 2020 08:15:47 -0300
Message-ID: <20200310111551.25160-16-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.garry@huawei.com>, Kajol Jain <kjain@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To match the error value of the expr__find_other function, so all
exported expr functions return the same values:
0 on success, -1 on error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c | 4 ++--
 tools/perf/util/expr.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 755d73c86c68..28313e59d6f6 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -45,11 +45,11 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	p = "FOO/0";
 	ret = expr__parse(&val, &ctx, p);
-	TEST_ASSERT_VAL("division by zero", ret == 1);
+	TEST_ASSERT_VAL("division by zero", ret == -1);
 
 	p = "BAR/";
 	ret = expr__parse(&val, &ctx, p);
-	TEST_ASSERT_VAL("missing operand", ret == 1);
+	TEST_ASSERT_VAL("missing operand", ret == -1);
 
 	TEST_ASSERT_VAL("find other",
 			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other) == 0);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 45b25530db5b..fd192ddf93c1 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -54,7 +54,7 @@ __expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
 
 int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr)
 {
-	return __expr__parse(final_val, ctx, expr, EXPR_PARSE);
+	return __expr__parse(final_val, ctx, expr, EXPR_PARSE) ? -1 : 0;
 }
 
 static bool
-- 
2.21.1
