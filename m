From: Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf expr: Add d_ratio operation
Date: Tue,  9 Jun 2020 22:17:15 -0700
Message-ID: <20200610051717.170457-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

This simplifies computing ratios in json expressions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l |  1 +
 tools/perf/util/expr.y | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index f397bf8b1a48..298d86660a96 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -100,6 +100,7 @@ symbol		({spec}|{sym})+
 		}
 	}
 
+d_ratio		{ return D_RATIO; }
 max		{ return MAX; }
 min		{ return MIN; }
 if		{ return IF; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index bf3e898e3055..fe145344bb39 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -10,6 +10,14 @@
 #include "smt.h"
 #include <string.h>
 
+static double d_ratio(double val0, double val1)
+{
+	if (val1 == 0) {
+		return 0;
+	}
+	return  val0 / val1;
+}
+
 %}
 
 %define api.pure full
@@ -28,7 +36,7 @@
 %token <num> NUMBER
 %token <str> ID
 %destructor { free ($$); } <str>
-%token MIN MAX IF ELSE SMT_ON
+%token MIN MAX IF ELSE SMT_ON D_RATIO
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -64,7 +72,8 @@ other: ID
 }
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-
+|
+D_RATIO
 
 all_expr: if_expr			{ *final_val = $1; }
 	;
@@ -105,6 +114,7 @@ expr:	  NUMBER
 	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
 	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
 	| SMT_ON		 { $$ = smt_on() > 0; }
+	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
 	;
 
 %%
-- 
2.27.0.278.ge193c7cf3a9-goog
