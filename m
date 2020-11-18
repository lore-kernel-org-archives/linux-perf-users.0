Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F9C6369E
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 05:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D799E221FC
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 05:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o999mDQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKRFDx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 00:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRFDv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Nov 2020 00:03:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4DC0613D4
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2020 21:03:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e19so716828ybc.5
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2020 21:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wmrtKHOWYLFXKzMdt8Vz+H9Wa4XoucRZAWHc9EZsoXY=;
        b=o999mDQZaWOLqnGxuKmw19XF1LuGbdTpp778RitF/LyrTzCbybU6jErfa+jYPpIfWp
         xdYHCDr4N2h9DnldnrlFa53cV288Kwqrersfdo6mSwkgp/5f6J43ZBg1l1aoPG1mFx1T
         DDhkE80pdEJ9T4gNmgbzIxEwIJkI8FPXUO1wJqFmeAnC/o5j07Ucn9nHB7z0irB2UASU
         WaqShSsPNOIg6VgDpQc6dPctVwD5vS75n00mLNYXmOjHI8c6757u7I0ftnb29y/wrEPr
         15tUsillKuJOC6/2OF760EJyCUDmbWrm8Kfpg85+Hcx/Gz5Wu2QZCKIxQo/GB4KeTRLf
         II6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wmrtKHOWYLFXKzMdt8Vz+H9Wa4XoucRZAWHc9EZsoXY=;
        b=T+4WnjO/Hdo8gNYcrsLtLRhqcRxWtkpUKqc5QqiBWaQAZSKnly6IMfV7REM6Lr6OoZ
         DpKdxZKo6SpU6M1i2clzNSoIcZ+hvhCLdH+ZDRTqG9k1SD54TJ9/axK3p+/gmybA+Tvd
         L4es+GEz9wR/T45fqsCYUL0XSeh3eNgkvhIHx96JnsV1MxB29t3e4bd94zEE5Jr5cZ0X
         dXJixUkcRYrDfiplq4iTxfAjet2385a84IEZ7NBW5yS7vFnX5C/YXOhZ8PbaML0FNx2o
         VaaEZMHfWWMvUVriIz4KGGDhddoFtuIxEA9SO57SVNUUfQXKYTMwv6MKEEl2JGBoJCAT
         wBAA==
X-Gm-Message-State: AOAM532jvrURn572UG8OR5k41j5gIdUNXuQgfxLpDfYC89cCx9TrMM5/
        rxAAW4cKnNXMSfQyt3hOt2R3hIK+baK9
X-Google-Smtp-Source: ABdhPJz1lnJKSRnB6iuMZC3+09QIzZTsnFmwsdtorPnYLrR3zeFM7di/F/dvKIsMx82E1r4uyGIuioeG8Ea0
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:fc01:: with SMTP id
 v1mr4488661ybd.241.1605675829373; Tue, 17 Nov 2020 21:03:49 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:03:35 -0800
In-Reply-To: <20201118050335.2347358-1-irogers@google.com>
Message-Id: <20201118050335.2347358-6-irogers@google.com>
Mime-Version: 1.0
References: <20201118050335.2347358-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 5/5] perf metric: Don't compute unused events.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For a metric like:
  EVENT1 if #smt_on else EVENT2

currently EVENT1 and EVENT2 will be measured and then when the metric is
reported EVENT1 or EVENT2 will be printed depending on the value from
smt_on() during the expr parsing. Computing both events is unnecessary and
can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies the expression parsing code by:
 - getting rid of the "other" parsing and introducing a boolean argument
   to say whether ids should be computed or not.
 - expressions are changed so that a pair of value and ids are returned.
 - when computing the metric value the ids are unused.
 - when computing the ids, constant values and smt_on are assigned to
   the value.
 - If the value is from an event ID then the event is added to the ids
   hashmap and the value set to NAN.
 - Typically operators union IDs for their inputs and set the value to
   NAN, however, if the inputs are constant then these are computed and
   propagated as the value.
 - If the input is constant to certain operators like:
 IDS1 if CONST else IDS2
   then the result will be either IDS1 or IDS2 depending on CONST which
   may be evaluated from an entire expression.
 - The ids at the end of parsing are added to the context.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c |  10 ++
 tools/perf/util/expr.c  |   9 +-
 tools/perf/util/expr.h  |   1 -
 tools/perf/util/expr.l  |   9 --
 tools/perf/util/expr.y  | 341 +++++++++++++++++++++++++++++++---------
 5 files changed, 284 insertions(+), 86 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 7c2a01cf0650..94ddd01b29fc 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/smt.h"
 #include "tests.h"
 #include <stdlib.h>
 #include <string.h>
@@ -132,6 +133,15 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT2,param=3/",
 						    (void **)&val_ptr));
 
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 if #smt_on else EVENT2",
+				NULL, ctx, 0) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+						  smt_on() ? "EVENT1" : "EVENT2",
+						  (void **)&val_ptr));
+
 	expr__ctx_free(ctx);
 
 	return 0;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1adb6cd202e0..28aaa50c6c68 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -329,10 +329,9 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 
 static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
-	      int start, int runtime)
+	      bool compute_ids, int runtime)
 {
 	struct expr_scanner_ctx scanner_ctx = {
-		.start_token = start,
 		.runtime = runtime,
 	};
 	YY_BUFFER_STATE buffer;
@@ -352,7 +351,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	expr_set_debug(1, scanner);
 #endif
 
-	ret = expr_parse(val, ctx, scanner);
+	ret = expr_parse(val, ctx, compute_ids, scanner);
 
 	expr__flush_buffer(buffer, scanner);
 	expr__delete_buffer(buffer, scanner);
@@ -363,13 +362,13 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime)
 {
-	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
+	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false, runtime) ? -1 : 0;
 }
 
 int expr__find_ids(const char *expr, const char *one,
 		   struct expr_parse_ctx *ctx, int runtime)
 {
-	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
+	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true, runtime);
 
 	if (one)
 		expr__del_id(ctx, one);
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 62d3ae5ddfba..cefeb2c8d85e 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,7 +26,6 @@ struct expr_parse_ctx {
 struct expr_id_data;
 
 struct expr_scanner_ctx {
-	int start_token;
 	int runtime;
 };
 
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 13e5e3c75f56..702fdf6456ca 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -91,15 +91,6 @@ symbol		({spec}|{sym})+
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
 
-	{
-		int start_token = sctx->start_token;
-
-		if (sctx->start_token) {
-			sctx->start_token = 0;
-			return start_token;
-		}
-	}
-
 d_ratio		{ return D_RATIO; }
 max		{ return MAX; }
 min		{ return MIN; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index c22e3500a40f..931c1dc2bd26 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -10,34 +10,29 @@
 #include "expr.h"
 #include "smt.h"
 #include <string.h>
-
-static double d_ratio(double val0, double val1)
-{
-	if (val1 == 0) {
-		return 0;
-	}
-	return  val0 / val1;
-}
-
 %}
 
 %define api.pure full
 
 %parse-param { double *final_val }
 %parse-param { struct expr_parse_ctx *ctx }
+%parse-param { bool compute_ids }
 %parse-param {void *scanner}
 %lex-param {void* scanner}
 
 %union {
 	double	 num;
 	char	*str;
+	struct ids {
+		/* When creating ids, holds the working set of event ids. */
+		struct hashmap *ids;
+		/* The metric value. When computing ids NAN is used to indicate
+		 * that all event ids are necessary. */
+		double val;
+	} ids;
 }
 
-%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
-%token <num> NUMBER
-%token <str> ID
-%destructor { free ($$); } <str>
-%token MIN MAX IF ELSE SMT_ON D_RATIO
+%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -46,11 +41,16 @@ static double d_ratio(double val0, double val1)
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
-%type <num> expr if_expr
+%type <num> NUMBER
+%type <str> ID
+%destructor { free ($$); } <str>
+%type <ids> expr if_expr
+%destructor { ids__free($$.ids); } <ids>
 
 %{
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
+		       bool compute_ids __maybe_unused,
 		       void *scanner,
 		       const char *s)
 {
@@ -60,68 +60,267 @@ static void expr_error(double *final_val __maybe_unused,
 %}
 %%
 
-start:
-EXPR_PARSE all_expr
-|
-EXPR_OTHER all_other
+start: if_expr
+{
+	if (compute_ids)
+		ctx->ids = ids__union($1.ids, ctx->ids);
 
-all_other: all_other other
-|
+	if (final_val)
+		*final_val = $1.val;
+}
+;
 
-other: ID
+if_expr: expr IF expr ELSE expr
 {
-	expr__add_id(ctx, $1);
+        if (fpclassify($3.val) == FP_ZERO) {
+		$$.val = $5.val;
+		$$.ids = $5.ids;
+		ids__free($1.ids);
+		ids__free($3.ids);
+	} else if (isfinite($3.val)) {
+		$$.val = $1.val;
+		$$.ids = $1.ids;
+		ids__free($3.ids);
+		ids__free($5.ids);
+	} else if (!compute_ids) {
+		$$.val = $5.val;
+		$$.ids = NULL;
+	} else {
+		$$.ids = ids__union(ids__union($1.ids, $3.ids), $5.ids);
+		$$.val = NAN;
+	}
 }
-|
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-|
-'<' | '>' | D_RATIO
-
-all_expr: if_expr			{ *final_val = $1; }
-	;
-
-if_expr:
-	expr IF expr ELSE expr { $$ = $3 ? $1 : $5; }
-	| expr
-	;
+| expr
+;
 
-expr:	  NUMBER
-	| ID			{
-					struct expr_id_data *data;
+expr: NUMBER
+{
+	$$.val = $1;
+	$$.ids = NULL;
+}
+| ID
+{
+	if (!compute_ids) {
+		struct expr_id_data *data;
 
-					if (expr__resolve_id(ctx, $1, &data)) {
-						$$ = NAN;
-					}
+		$$.val = NAN;
+		if (expr__resolve_id(ctx, $1, &data) == 0)
+			$$.val = expr_id_data__value(data);
 
-					$$ = expr_id_data__value(data);
-					free($1);
-				}
-	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
-	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
-	| expr '<' expr		{ $$ = $1 < $3; }
-	| expr '>' expr		{ $$ = $1 > $3; }
-	| expr '+' expr		{ $$ = $1 + $3; }
-	| expr '-' expr		{ $$ = $1 - $3; }
-	| expr '*' expr		{ $$ = $1 * $3; }
-	| expr '/' expr		{ if ($3 == 0) {
-					pr_debug("division by zero\n");
-					YYABORT;
-				  }
-				  $$ = $1 / $3;
-	                        }
-	| expr '%' expr		{ if ((long)$3 == 0) {
-					pr_debug("division by zero\n");
-					YYABORT;
-				  }
-				  $$ = (long)$1 % (long)$3;
-	                        }
-	| '-' expr %prec NEG	{ $$ = -$2; }
-	| '(' if_expr ')'	{ $$ = $2; }
-	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
-	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
-	| SMT_ON		 { $$ = smt_on() > 0; }
-	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
-	;
+		$$.ids = NULL;
+		free($1);
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__new();
+		if (!$$.ids || ids__insert($$.ids, $1, ctx->parent))
+			YYABORT;
+	}
+}
+| expr '|' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = (long)$1.val | (long)$3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '&' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = (long)$1.val & (long)$3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '^' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = (long)$1.val ^ (long)$3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '<' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = $1.val < $3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '>' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = $1.val > $3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '+' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = $1.val + $3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '-' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = $1.val - $3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '*' expr
+{
+	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = $1.val * $3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| expr '/' expr
+{
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = $1.val / $3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| D_RATIO '(' expr ',' expr ')'
+{
+	if (fpclassify($5.val) == FP_ZERO) {
+		$$.val = 0.0;
+		$$.ids = NULL;
+		ids__free($3.ids);
+		ids__free($5.ids);
+	} else if (!compute_ids || (isfinite($3.val) && isfinite($5.val))) {
+		$$.val = $3.val / $5.val;
+		$$.ids = NULL;
+		ids__free($3.ids);
+		ids__free($5.ids);
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($3.ids, $5.ids);
+	}
+}
+| expr '%' expr
+{
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
+		$$.val = (long)$1.val % (long)$3.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($1.ids);
+			ids__free($3.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($1.ids, $3.ids);
+	}
+}
+| '-' expr %prec NEG
+{
+	$$.val = -$2.val;
+	$$.ids = $2.ids;
+}
+| '(' if_expr ')'
+{
+	$$ = $2;
+}
+| MIN '(' expr ',' expr ')'
+{
+	if (!compute_ids || (isfinite($3.val) && isfinite($5.val))) {
+		$$.val = $3.val < $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($3.ids);
+			ids__free($5.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($3.ids, $5.ids);
+	}
+}
+| MAX '(' expr ',' expr ')'
+{
+	if (!compute_ids || (isfinite($3.val) && isfinite($5.val))) {
+		$$.val = $3.val > $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+		if (compute_ids) {
+			ids__free($3.ids);
+			ids__free($5.ids);
+		}
+	} else {
+		$$.val = NAN;
+		$$.ids = ids__union($3.ids, $5.ids);
+	}
+}
+| SMT_ON
+{
+	$$.val = smt_on() > 0 ? 1.0 : 0.0;
+	$$.ids = NULL;
+}
+;
 
 %%
-- 
2.29.2.299.gdc1121823c-goog

