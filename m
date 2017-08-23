From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/15] perf tools: Expression parser enhancements for metrics
Date: Wed, 23 Aug 2017 16:36:04 -0300
Message-ID: <20170823193614.20394-6-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Enhance the expression parser for more complex metric formulas.

- Support python style IF ELSE operators
- Add an #SMT_On magic variable for formulas that depend on the SMT
status.

Example: 4 *( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles

- Support MIN/MAX operations

Example: min(1 , IDQ.MITE_UOPS / ( UPI * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )

This is useful to fix up problems caused by multiplexing.

- Support | & ^ operators
- Minor cleanups and fixes
- Support an \ escape for operators. This allows to specify event names
like c2-residency
- Support @ as an alternative for / to be able to specify pmus without
conflicts with operators (like msr/tsc/ as msr@tsc@)

Example: (cstate_core@c3\\-residency@ / msr@tsc@) * 100

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170811232634.30465-8-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c |  5 ++++
 tools/perf/util/expr.y  | 61 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index e93903295532..cb251bf523e7 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -31,6 +31,11 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	ret |= test(&ctx, "(BAR/2)%2", 1);
 	ret |= test(&ctx, "1 - -4",  5);
 	ret |= test(&ctx, "(FOO-1)*2 + (BAR/2)%2 - -4",  5);
+	ret |= test(&ctx, "1-1 | 1", 1);
+	ret |= test(&ctx, "1-1 & 1", 0);
+	ret |= test(&ctx, "min(1,2) + 1", 2);
+	ret |= test(&ctx, "max(1,2) + 1", 3);
+	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
 
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 953e65ba2cc7..5753c4f21534 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -4,6 +4,7 @@
 #include "util/debug.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
+#include "smt.h"
 #include <string.h>
 
 #define MAXIDLEN 256
@@ -22,13 +23,15 @@
 
 %token <num> NUMBER
 %token <id> ID
+%token MIN MAX IF ELSE SMT_ON
+%left MIN MAX IF
 %left '|'
 %left '^'
 %left '&'
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
-%type <num> expr
+%type <num> expr if_expr
 
 %{
 static int expr__lex(YYSTYPE *res, const char **pp);
@@ -57,7 +60,12 @@ static int lookup_id(struct parse_ctx *ctx, char *id, double *val)
 %}
 %%
 
-all_expr: expr			{ *final_val = $1; }
+all_expr: if_expr			{ *final_val = $1; }
+	;
+
+if_expr:
+	expr IF expr ELSE expr { $$ = $3 ? $1 : $5; }
+	| expr
 	;
 
 expr:	  NUMBER
@@ -66,13 +74,19 @@ expr:	  NUMBER
 					YYABORT;
 				  }
 				}
+	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
+	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
+	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
 	| expr '+' expr		{ $$ = $1 + $3; }
 	| expr '-' expr		{ $$ = $1 - $3; }
 	| expr '*' expr		{ $$ = $1 * $3; }
 	| expr '/' expr		{ if ($3 == 0) YYABORT; $$ = $1 / $3; }
 	| expr '%' expr		{ if ((long)$3 == 0) YYABORT; $$ = (long)$1 % (long)$3; }
 	| '-' expr %prec NEG	{ $$ = -$2; }
-	| '(' expr ')'		{ $$ = $2; }
+	| '(' if_expr ')'	{ $$ = $2; }
+	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
+	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
+	| SMT_ON		 { $$ = smt_on() > 0; }
 	;
 
 %%
@@ -82,13 +96,47 @@ static int expr__symbol(YYSTYPE *res, const char *p, const char **pp)
 	char *dst = res->id;
 	const char *s = p;
 
-	while (isalnum(*p) || *p == '_' || *p == '.') {
+	if (*p == '#')
+		*dst++ = *p++;
+
+	while (isalnum(*p) || *p == '_' || *p == '.' || *p == ':' || *p == '@' || *p == '\\') {
 		if (p - s >= MAXIDLEN)
 			return -1;
-		*dst++ = *p++;
+		/*
+		 * Allow @ instead of / to be able to specify pmu/event/ without
+		 * conflicts with normal division.
+		 */
+		if (*p == '@')
+			*dst++ = '/';
+		else if (*p == '\\')
+			*dst++ = *++p;
+		else
+			*dst++ = *p;
+		p++;
 	}
 	*dst = 0;
 	*pp = p;
+	dst = res->id;
+	switch (dst[0]) {
+	case 'm':
+		if (!strcmp(dst, "min"))
+			return MIN;
+		if (!strcmp(dst, "max"))
+			return MAX;
+		break;
+	case 'i':
+		if (!strcmp(dst, "if"))
+			return IF;
+		break;
+	case 'e':
+		if (!strcmp(dst, "else"))
+			return ELSE;
+		break;
+	case '#':
+		if (!strcasecmp(dst, "#smt_on"))
+			return SMT_ON;
+		break;
+	}
 	return ID;
 }
 
@@ -102,6 +150,7 @@ static int expr__lex(YYSTYPE *res, const char **pp)
 		p++;
 	s = p;
 	switch (*p++) {
+	case '#':
 	case 'a' ... 'z':
 	case 'A' ... 'Z':
 		return expr__symbol(res, p - 1, pp);
@@ -151,7 +200,7 @@ int expr__find_other(const char *p, const char *one, const char ***other,
 			err = 0;
 			break;
 		}
-		if (tok == ID && strcasecmp(one, val.id)) {
+		if (tok == ID && (!one || strcasecmp(one, val.id))) {
 			if (num_other >= EXPR_MAX_OTHER - 1) {
 				pr_debug("Too many extra events in %s\n", orig);
 				break;
-- 
2.13.5
