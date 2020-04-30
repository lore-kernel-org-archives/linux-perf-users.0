From: Ian Rogers <irogers@google.com>
Subject: [PATCH v3 10/12] perf expr: print a debug message for division by zero
Date: Thu, 30 Apr 2020 00:51:42 -0700
Message-ID: <20200430075144.132716-11-irogers@google.com>
References: <20200430075144.132716-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

If an expression yields 0 and is then divided-by/modulus-by then the
parsing aborts. Add a debug error message to better enable debugging
when this happens.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 54260094b947..21e82a1e11a2 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -103,8 +103,18 @@ expr:	  NUMBER
 	| expr '+' expr		{ $$ = $1 + $3; }
 	| expr '-' expr		{ $$ = $1 - $3; }
 	| expr '*' expr		{ $$ = $1 * $3; }
-	| expr '/' expr		{ if ($3 == 0) YYABORT; $$ = $1 / $3; }
-	| expr '%' expr		{ if ((long)$3 == 0) YYABORT; $$ = (long)$1 % (long)$3; }
+	| expr '/' expr		{ if ($3 == 0) {
+					pr_debug("division by zero\n");
+					YYABORT;
+				  }
+				  $$ = $1 / $3;
+	                        }
+	| expr '%' expr		{ if ((long)$3 == 0) {
+					pr_debug("division by zero\n");
+					YYABORT;
+				  }
+				  $$ = (long)$1 % (long)$3;
+	                        }
 	| '-' expr %prec NEG	{ $$ = -$2; }
 	| '(' if_expr ')'	{ $$ = $2; }
 	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
-- 
2.26.2.303.gf8c07b1a785-goog
