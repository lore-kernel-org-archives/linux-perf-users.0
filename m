Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E7EC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4698361019
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhIWHsw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbhIWHsa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C62C0613D3
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:59 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h9-20020a05621413a900b0037a2d3eaf8fso19246243qvz.8
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TlXn39hgRVo014P6/ubf0rJfKLCepg77+m6hAn6GiHQ=;
        b=RcEDM8UzIYgAoz/QW6IYLTAP5om1TGmPDrtgAo5kR/1TLBYKlUsaVuTgK6a9y3ikEL
         Loi9sNXQLuLL33ucVsYF8gCPrdUI2ynBBgdj9moslgWYehbRRfojwUFR00FaGnzvn/Vy
         v4/ElrkwFLOEEG9Ed9VZG9KYEOfleU4pF7K0vx9fFzCTH7xTwqzeqOx1irVLUtxa7a10
         FbjJXcdkrxe7nh2OnJTaS7R5TbfG8KC6jhn6snGOrTA/P9HpHJmM8BgIveWxonNrLPW1
         GKDPL2DGHJJBgP+c7lNHunBcAlAPoWC0DsEwfFzD6OznL4ndOSqddINJA9kW92N3l9DY
         Dd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TlXn39hgRVo014P6/ubf0rJfKLCepg77+m6hAn6GiHQ=;
        b=TuAg1PWma3sCs2Itv7oIy/VlzJK92ETSh28FppR2XvBuWK+oiLgPgEKKOmPfeyS3/c
         xsBHmDoTfvORMtV7Og6l5mEaMOEaFG+X+w6hiNlTimQXIGSmbLwj4S5sEetPb6Lhc3JB
         31KPnGSv2M3X5LkYYyMnfvIsDJUUa9Py8Zva11Lc7H+GYpS4hsvZNLPl0gq8llnF/jJU
         EHH8SNAFNz2zM5Qwui0QbiigoV/zxESxYDd1mwayt2zWzK5WyijhCfn8iDgKDEubeHiv
         tV7CyaYw23q9LCOP9YzRgMMKl0Jxtux8sEqQyWtDwy7Er0wzCi8F6rWvyYsmcruXqa0q
         nIcg==
X-Gm-Message-State: AOAM5300zb4h4PD3T1xUHpNX2jynifA9JxVvLDa2lsRL3cNQVW0JETLt
        mXvju1ylecsxCScd5Py6LeNulL/bhkrC
X-Google-Smtp-Source: ABdhPJz/pkOmz0Hh2jBVMwAMzaIvrqKyjJsiW29ODRdwG940tekXq+6M54HkQNwqCWiHK1PrBxnOM8413U7l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:4ea:: with SMTP id
 cl10mr3229152qvb.58.1632383218604; Thu, 23 Sep 2021 00:46:58 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:13 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-11-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 10/13] perf expr: Merge find_ids and regular parsing
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
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a new option to parsing that the set of IDs being used should be
computed, this means every action needs to handle the compute_ids and
regular case. This means actions yield a new ids type is a set of ids or
the value being computed. Use the compute_ids case to replace find IDs
parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c |   9 +--
 tools/perf/util/expr.h |   1 -
 tools/perf/util/expr.l |   9 ---
 tools/perf/util/expr.y | 176 ++++++++++++++++++++++++++++++-----------
 4 files changed, 136 insertions(+), 59 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 81101be51044..db2445677c8c 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -314,10 +314,9 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 
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
@@ -337,7 +336,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	expr_set_debug(1, scanner);
 #endif
 
-	ret = expr_parse(val, ctx, scanner);
+	ret = expr_parse(val, ctx, compute_ids, scanner);
 
 	expr__flush_buffer(buffer, scanner);
 	expr__delete_buffer(buffer, scanner);
@@ -348,13 +347,13 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
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
index 4ed186bd1f13..b20513f0ae59 100644
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
index 78cbe377eb0e..6aeead54760a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,7 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <assert.h>
 #include <math.h>
 #include "util/debug.h"
 #include "smt.h"
@@ -12,15 +13,31 @@
 
 %parse-param { double *final_val }
 %parse-param { struct expr_parse_ctx *ctx }
+%parse-param { bool compute_ids }
 %parse-param {void *scanner}
 %lex-param {void* scanner}
 
 %union {
 	double	 num;
 	char	*str;
+	struct ids {
+		/*
+		 * When creating ids, holds the working set of event ids. NULL
+		 * implies the set is empty.
+		 */
+		struct hashmap *ids;
+		/*
+		 * The metric value. When not creating ids this is the value
+		 * read from a counter, a constant or some computed value. When
+		 * creating ids the value is either a constant or BOTTOM. NAN is
+		 * used as the special BOTTOM value, representing a "set of all
+		 * values" case.
+		 */
+		double val;
+	} ids;
 }
 
-%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR EXPR_PARSE EXPR_OTHER
+%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -32,65 +49,109 @@
 %type <num> NUMBER
 %type <str> ID
 %destructor { free ($$); } <str>
-%type <num> expr if_expr
+%type <ids> expr if_expr
+%destructor { ids__free($$.ids); } <ids>
 
 %{
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
+		       bool compute_ids __maybe_unused,
 		       void *scanner,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
 }
 
+/*
+ * During compute ids, the special "bottom" value uses NAN to represent the set
+ * of all values. NAN is selected as it isn't a useful constant value.
+ */
+#define BOTTOM NAN
+
+static struct ids union_expr(struct ids ids1, struct ids ids2)
+{
+	struct ids result = {
+		.val = BOTTOM,
+		.ids = ids__union(ids1.ids, ids2.ids),
+	};
+	return result;
+}
+
 #define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
-	RESULT = (long)LHS OP (long)RHS;
+	if (!compute_ids) {						\
+		RESULT.val = (long)LHS.val OP (long)RHS.val;		\
+		RESULT.ids = NULL;					\
+	} else {							\
+	        RESULT = union_expr(LHS, RHS);				\
+	}
 
 #define BINARY_OP(RESULT, OP, LHS, RHS)					\
-	RESULT = LHS OP RHS;
+	if (!compute_ids) {						\
+		RESULT.val = LHS.val OP RHS.val;			\
+		RESULT.ids = NULL;					\
+	} else {							\
+	        RESULT = union_expr(LHS, RHS);				\
+	}
 
 %}
 %%
 
-start:
-EXPR_PARSE all_expr
-|
-EXPR_OTHER all_other
-
-all_other: all_other other
-|
-
-other: ID
+start: if_expr
 {
-	expr__add_id(ctx, $1);
-}
-|
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-|
-'<' | '>' | D_RATIO
+	if (compute_ids)
+		ctx->ids = ids__union($1.ids, ctx->ids);
 
-all_expr: if_expr			{ *final_val = $1; }
+	if (final_val)
+		*final_val = $1.val;
+}
+;
 
 if_expr: expr IF expr ELSE expr
 {
-	$$ = $3 ? $1 : $5;
+	if (!compute_ids) {
+		$$.ids = NULL;
+		if (fpclassify($3.val) == FP_ZERO) {
+			$$.val = $5.val;
+		} else {
+			$$.val = $1.val;
+		}
+	} else {
+		$$ = union_expr($1, union_expr($3, $5));
+	}
 }
 | expr
 ;
 
 expr: NUMBER
 {
-	$$ = $1;
+	$$.val = $1;
+	$$.ids = NULL;
 }
 | ID
 {
-	struct expr_id_data *data;
-
-	$$ = NAN;
-	if (expr__resolve_id(ctx, $1, &data) == 0)
-		$$ = expr_id_data__value(data);
-
-	free($1);
+	if (!compute_ids) {
+		/*
+		 * Compute the event's value from ID. If the ID isn't known then
+		 * it isn't used to compute the formula so set to NAN.
+		 */
+		struct expr_id_data *data;
+
+		$$.val = NAN;
+		if (expr__resolve_id(ctx, $1, &data) == 0)
+			$$.val = expr_id_data__value(data);
+
+		$$.ids = NULL;
+		free($1);
+	} else {
+		/*
+		 * Set the value to BOTTOM to show that any value is possible
+		 * when the event is computed. Create a set of just the ID.
+		 */
+		$$.val = BOTTOM;
+		$$.ids = ids__new();
+		if (!$$.ids || ids__insert($$.ids, $1, ctx->parent))
+			YYABORT;
+	}
 }
 | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
 | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
@@ -102,31 +163,47 @@ expr: NUMBER
 | expr '*' expr { BINARY_OP($$, *, $1, $3); }
 | expr '/' expr
 {
-	if ($3 == 0) {
-		pr_debug("division by zero\n");
-		YYABORT;
+	if (!compute_ids) {
+		if (fpclassify($3.val) == FP_ZERO) {
+			pr_debug("division by zero\n");
+			YYABORT;
+		}
+		$$.val = $1.val / $3.val;
+		$$.ids = NULL;
+	} else {
+		$$ = union_expr($1, $3);
 	}
-	$$ = $1 / $3;
 }
 | expr '%' expr
 {
-	if ((long)$3 == 0) {
-		pr_debug("division by zero\n");
-		YYABORT;
+	if (!compute_ids) {
+		if (fpclassify($3.val) == FP_ZERO) {
+			pr_debug("division by zero\n");
+			YYABORT;
+		}
+		$$.val = (long)$1.val % (long)$3.val;
+		$$.ids = NULL;
+	} else {
+		$$ = union_expr($1, $3);
 	}
-	$$ = (long)$1 % (long)$3;
 }
 | D_RATIO '(' expr ',' expr ')'
 {
-	if ($5 == 0) {
-		$$ = 0;
+	if (!compute_ids) {
+		$$.ids = NULL;
+		if (fpclassify($5.val) == FP_ZERO) {
+			$$.val = 0.0;
+		} else {
+			$$.val = $3.val / $5.val;
+		}
 	} else {
-		$$ = $3 / $5;
+		$$ = union_expr($3, $5);
 	}
 }
 | '-' expr %prec NEG
 {
-	$$ = -$2;
+	$$.val = -$2.val;
+	$$.ids = $2.ids;
 }
 | '(' if_expr ')'
 {
@@ -134,15 +211,26 @@ expr: NUMBER
 }
 | MIN '(' expr ',' expr ')'
 {
-	$$ = $3 < $5 ? $3 : $5;
+	if (!compute_ids) {
+		$$.val = $3.val < $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+	} else {
+		$$ = union_expr($3, $5);
+	}
 }
 | MAX '(' expr ',' expr ')'
 {
-	$$ = $3 > $5 ? $3 : $5;
+	if (!compute_ids) {
+		$$.val = $3.val > $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+	} else {
+		$$ = union_expr($3, $5);
+	}
 }
 | SMT_ON
 {
-	$$ = smt_on() > 0 ? 1.0 : 0.0;
+	$$.val = smt_on() > 0 ? 1.0 : 0.0;
+	$$.ids = NULL;
 }
 ;
 
-- 
2.33.0.464.g1972c5931b-goog

