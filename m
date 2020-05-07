From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH v2 06/23] perf expr: parse numbers as doubles
Date: Thu,  7 May 2020 07:08:02 -0700
Message-ID: <20200507140819.126960-7-irogers@google.com>
References: <20200507140819.126960-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

This is expected in expr.y and metrics use floating point values such as
x86 broadwell IFetch_Line_Utilization.

Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 73db6a9ef97e..ceab11bea6f9 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -10,12 +10,12 @@
 char *expr_get_text(yyscan_t yyscanner);
 YYSTYPE *expr_get_lval(yyscan_t yyscanner);
 
-static int __value(YYSTYPE *yylval, char *str, int base, int token)
+static double __value(YYSTYPE *yylval, char *str, int token)
 {
-	u64 num;
+	double num;
 
 	errno = 0;
-	num = strtoull(str, NULL, base);
+	num = strtod(str, NULL);
 	if (errno)
 		return EXPR_ERROR;
 
@@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
 	return token;
 }
 
-static int value(yyscan_t scanner, int base)
+static int value(yyscan_t scanner)
 {
 	YYSTYPE *yylval = expr_get_lval(scanner);
 	char *text = expr_get_text(scanner);
 
-	return __value(yylval, text, base, NUMBER);
+	return __value(yylval, text, NUMBER);
 }
 
 /*
@@ -81,7 +81,7 @@ static int str(yyscan_t scanner, int token, int runtime)
 }
 %}
 
-number		[0-9]+
+number		[0-9]*\.?[0-9]+
 
 sch		[-,=]
 spec		\\{sch}
@@ -105,7 +105,7 @@ min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
 #smt_on		{ return SMT_ON; }
-{number}	{ return value(yyscanner, 10); }
+{number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
 "|"		{ return '|'; }
 "^"		{ return '^'; }
-- 
2.26.2.526.g744177e7f7-goog
