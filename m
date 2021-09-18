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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1998C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F9D611C8
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhIRGhF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 18 Sep 2021 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbhIRGhB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 18 Sep 2021 02:37:01 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59BC061757
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j23-20020ac86657000000b0029cb70967ebso103479328qtp.14
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tyFMwnI6y9FcQXpb24VEVVWcGbqWCmrjC6BsWMJxuIk=;
        b=FF/+nikOyke9TlPO3qubq2xKjjxSIJuh8XPB6fAW5I72AEB6GJYk2CeLoxfBSO6juM
         h8qXzECDReY/qn+MExEDdbqKJC3pnUd5kby4fw1lUzoGY4L+sETDlPp+WsOswymBXs1K
         aSmENcltfIv2gZ7EXGibNvg2PjzB72IqIXwXKnXtL1Mgg7bYjPDL5bB0PK3evyFSiTz2
         E0rKlnIlC6pRm2EzaGRlzEcifwwgWeMvDL6pOVdMmCO2gKR+V40wjVoo+nFsbaRfw3tk
         FamMTKuQrVR/2XGZjQlguv5pLO2dXN0V+FMMP1r31fSzBLIIpSJ6+OLnYiPFgSIlPHVj
         vDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tyFMwnI6y9FcQXpb24VEVVWcGbqWCmrjC6BsWMJxuIk=;
        b=3OhgLZGLxrtBtVRrJ2nGpim7BbPmzXcjkS0ZXJDFlSAacyuRZcw2BPX6/5jkMZEUCa
         hoJnpEWeizC7VvntDH26C/LoG+HPmPBy0jEoVC7cfiFPt1r8J1OZX5Dz80B2dE90OYqo
         HfcW6h5EqOCn3TOjvI+GtJ9pWMKyaYJ6MtYHh/YoX7zdieJ5tdyZvw7m4QGP3aDJq/YP
         1uvtqmzEHsWONJu4UjOV1OO5vojvp7uvTS+iZPDuM2zpFqxlDVo/1q3m2nImBnQd9U7X
         5igczNRP87lFW77HiHepfU+wxONxNmrkkcgBn/NbVhYokTXMfeyx3Qk+XikDoyaFFu5m
         aFrg==
X-Gm-Message-State: AOAM533JKJ6WolUl69X9sPU8WIGX1v5OxgDJAL6t0pMHyoAdsxjDwNOx
        8sc3Zbk3PhvuPxH8XJpzh/7bsWWHZJDy
X-Google-Smtp-Source: ABdhPJy4vavHJ3mJtBPSuAMRZW49bTZf/VL1yJ0Ikibh3tJ69oluxNwnnA5goZYlzoHXgerPTnm4kFRHLbz1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:a05:6902:1546:: with SMTP id
 r6mr19622632ybu.268.1631946930795; Fri, 17 Sep 2021 23:35:30 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:35:08 -0700
In-Reply-To: <20210918063513.2356923-1-irogers@google.com>
Message-Id: <20210918063513.2356923-4-irogers@google.com>
Mime-Version: 1.0
References: <20210918063513.2356923-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 3/8] perf expr: Modify code layout
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

No functional change. Alter whitespace. Use helper macros that will be
made more complex in a later change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 149 +++++++++++++++++++++++------------------
 1 file changed, 85 insertions(+), 64 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 41c9cd4efadd..51f4f0aa1955 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -2,23 +2,10 @@
 %{
 #define YYDEBUG 1
 #include <math.h>
-#include <stdio.h>
-#include "util.h"
 #include "util/debug.h"
-#include <stdlib.h> // strtod()
+#include "smt.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
-#include "smt.h"
-#include <string.h>
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
@@ -33,11 +20,7 @@ static double d_ratio(double val0, double val1)
 	char	*str;
 }
 
-%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
-%token <num> NUMBER
-%token <str> ID
-%destructor { free ($$); } <str>
-%token MIN MAX IF ELSE SMT_ON D_RATIO
+%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR EXPR_PARSE EXPR_OTHER
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -46,6 +29,9 @@ static double d_ratio(double val0, double val1)
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
+%type <num> NUMBER
+%type <str> ID
+%destructor { free ($$); } <str>
 %type <num> expr if_expr
 
 %{
@@ -57,6 +43,12 @@ static void expr_error(double *final_val __maybe_unused,
 	pr_debug("%s\n", s);
 }
 
+#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
+	RESULT = (long)LHS OP (long)RHS;
+
+#define BINARY_OP(RESULT, OP, LHS, RHS)					\
+	RESULT = LHS OP RHS;
+
 %}
 %%
 
@@ -78,49 +70,78 @@ MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/
 '<' | '>' | D_RATIO
 
 all_expr: if_expr			{ *final_val = $1; }
-	;
-
-if_expr:
-	expr IF expr ELSE expr { $$ = $3 ? $1 : $5; }
-	| expr
-	;
-
-expr:	  NUMBER
-	| ID			{
-					struct expr_id_data *data;
-
-					$$ = NAN;
-					if (expr__resolve_id(ctx, $1, &data) == 0)
-						$$ = expr_id_data__value(data);
-
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
 
-%%
+if_expr: expr IF expr ELSE expr
+{
+	$$ = $3 ? $1 : $5;
+}
+| expr
+;
+
+expr: NUMBER
+{
+	$$ = $1;
+}
+| ID
+{
+	struct expr_id_data *data;
+
+	$$ = NAN;
+	if (expr__resolve_id(ctx, $1, &data) == 0)
+		$$ = expr_id_data__value(data);
+
+	free($1);
+}
+| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
+| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
+| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
+| expr '<' expr { BINARY_OP($$, <, $1, $3); }
+| expr '>' expr { BINARY_OP($$, >, $1, $3); }
+| expr '+' expr { BINARY_OP($$, +, $1, $3); }
+| expr '-' expr { BINARY_OP($$, -, $1, $3); }
+| expr '*' expr { BINARY_OP($$, *, $1, $3); }
+| expr '/' expr
+{
+	if ($3 == 0) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	}
+	$$ = $1 / $3;
+}
+| expr '%' expr
+{
+	if ((long)$3 == 0) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	}
+	$$ = (long)$1 % (long)$3;
+}
+| D_RATIO '(' expr ',' expr ')'
+{
+	if ($5 == 0) {
+		$$ = 0;
+	} else {
+		$$ = $3 / $5;
+	}
+}
+| '-' expr %prec NEG
+{
+	$$ = -$2;
+}
+| '(' if_expr ')'
+{
+	$$ = $2;
+}
+| MIN '(' expr ',' expr ')'
+{
+	$$ = $3 < $5 ? $3 : $5;
+}
+| MAX '(' expr ',' expr ')'
+{
+	$$ = $3 > $5 ? $3 : $5;
+}
+| SMT_ON
+{
+	$$ = smt_on() > 0 ? 1.0 : 0.0;
+}
+;
-- 
2.33.0.464.g1972c5931b-goog

