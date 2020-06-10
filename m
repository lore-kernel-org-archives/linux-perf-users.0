From: Ian Rogers <irogers@google.com>
Subject: [PATCH v2 2/2] perf expr: Add < and > operators
Date: Wed, 10 Jun 2020 16:58:23 -0700
Message-ID: <20200610235823.52557-2-irogers@google.com>
References: <20200610235823.52557-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200610235823.52557-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

These are broadly useful but required to handle TMA metrics. For
example encoding Ports_Utilization from:
https://download.01.org/perfmon/TMA_Metrics.csv
requires '<'.

{
  "BriefDescription": "This metric estimates fraction of cycles the CPU per=
formance was potentially limited due to Core computation issues (non divide=
r-related).  Two distinct categories can be attributed into this metric: (1=
) heavy data-dependency among contiguous instructions would manifest in thi=
s metric - such cases are often referred to as low Instruction Level Parall=
elism (ILP). (2) Contention on some hardware execution unit other than Divi=
der. For example; when there are too many multiply operations.",
  "MetricExpr": "( ( cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY=
.1_PORTS_UTIL@ + ( cpu@EXE_ACTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.=
RETIRE_SLOTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.0=
00000 ) ) ) ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) if ( cpu@ARITH.DIVIDER_ACT=
IVE\\,cmask\\=3D1@ < cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ ) else ( ( cpu@EXE=
_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY.1_PORTS_UTIL@ + ( cpu@EXE_A=
CTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.RETIRE_SLOTS@ ) / ( cpu@CPU_=
CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.000000 ) ) ) ) - cpu@EXE_ACTI=
VITY.EXE_BOUND_0_PORTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) )",
  "MetricGroup": "Topdown_Group_Ports_Utilization",
  "MetricName": "Topdown_Metric_Ports_Utilization"
},

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 6 ++++++
 tools/perf/util/expr.l  | 2 ++
 tools/perf/util/expr.y  | 5 ++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index c4877b36ab58..b7e5ef3007fc 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -41,6 +41,12 @@ int test__expr(struct test *t __maybe_unused, int subtes=
t __maybe_unused)
 	ret |=3D test(&ctx, ".1 + 2.", 2.1);
 	ret |=3D test(&ctx, "d_ratio(1, 2)", 0.5);
 	ret |=3D test(&ctx, "d_ratio(2.5, 0)", 0);
+	ret |=3D test(&ctx, "1.1 < 2.2", 1);
+	ret |=3D test(&ctx, "2.2 > 1.1", 1);
+	ret |=3D test(&ctx, "1.1 < 1.1", 0);
+	ret |=3D test(&ctx, "2.2 > 2.2", 0);
+	ret |=3D test(&ctx, "2.2 < 1.1", 0);
+	ret |=3D test(&ctx, "1.1 > 2.2", 0);
=20
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 298d86660a96..13e5e3c75f56 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -111,6 +111,8 @@ else		{ return ELSE; }
 "|"		{ return '|'; }
 "^"		{ return '^'; }
 "&"		{ return '&'; }
+"<"		{ return '<'; }
+">"		{ return '>'; }
 "-"		{ return '-'; }
 "+"		{ return '+'; }
 "*"		{ return '*'; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index fe145344bb39..5fcb98800f9c 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -41,6 +41,7 @@ static double d_ratio(double val0, double val1)
 %left '|'
 %left '^'
 %left '&'
+%left '<' '>'
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
@@ -73,7 +74,7 @@ other: ID
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*=
' | '/' | '%' | '(' | ')' | ','
 |
-D_RATIO
+'<' | '>' | D_RATIO
=20
 all_expr: if_expr			{ *final_val =3D $1; }
 	;
@@ -94,6 +95,8 @@ expr:	  NUMBER
 	| expr '|' expr		{ $$ =3D (long)$1 | (long)$3; }
 	| expr '&' expr		{ $$ =3D (long)$1 & (long)$3; }
 	| expr '^' expr		{ $$ =3D (long)$1 ^ (long)$3; }
+	| expr '<' expr		{ $$ =3D $1 < $3; }
+	| expr '>' expr		{ $$ =3D $1 > $3; }
 	| expr '+' expr		{ $$ =3D $1 + $3; }
 	| expr '-' expr		{ $$ =3D $1 - $3; }
 	| expr '*' expr		{ $$ =3D $1 * $3; }
--=20
2.27.0.278.ge193c7cf3a9-goog
