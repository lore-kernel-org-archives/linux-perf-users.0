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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16070C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC38261019
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbhIWHsX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbhIWHsV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:21 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9E7C061757
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p75-20020a0c90d1000000b0037efc8547d4so18552318qvp.16
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dTCV7YWIOb5NUrZqR0pgXW+ZL6gamk0NccGgryZgkiY=;
        b=D20W20c73dlsK/2BlqYB52FFagYFFzetx4U09I4lVDwriIZi2rtLgFCcWHK41Q7Cm1
         BgjIyeq/h3ueBegsmaurWbJ501T8WocP9CTC44yy5nZDdQ985aCH+8Rt7IjhfFrNeGFq
         mPXWdIS5l6jgs+tXHw4/5zbWwZE3QITlIm/KfZdStVcFOGrp3DaY/iUG8DHHA9m/WtQ9
         rGVhegtE8vIgFWUUfuPXZhebCDUAbq/nK+ISkYfbShJzYT4lN7yrbCqsmJk4q0SHXUVB
         gp38fA4BhsHUXLFDyJ9F9sBAFQU99gHEVdq+hmS8CzPRKNRdLNHLHF4yugcjZ//7q7ew
         hfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dTCV7YWIOb5NUrZqR0pgXW+ZL6gamk0NccGgryZgkiY=;
        b=bCH04QAkd609MiXLb/e6ImgDX7v7geNJFxGKRKY19DzWpkFLVwqtclFto7Y9jYBADY
         SyWPcqCqcRUaSrOUWjvlr9WJ+r/Ax0xW/frKgd0YWlnRkTxIeVTEaSOV5eUBXzU5fkTd
         U0AMEZKilku6gDXmov19QqSNpAAFnOzpW2JOiOVwzmBLmaM3Golqj+tPtKHglh2yhuaW
         gxKPlS2XHuqmTWhQxoXCwB8ggxADj984+jOQKKVjJXKF5DcdUzVvlag+eXySUfQ2rDHl
         GShozLOhYT1iyY7B24Ivyxv6eqFGSroHswjk3oTg2frMgO5GUvMk9tMs6FQ5Yb8SD8oc
         jfRQ==
X-Gm-Message-State: AOAM532nyxSplxsHaC2UQ6+HbbQxNUtvpn7bLTZk1Ixgg+FcGlZoiKGa
        Pprhv9yiFvoS4FhzrkhuWITigQzNq951
X-Google-Smtp-Source: ABdhPJwYOXb/bUVquxzTCQXoWai3VFLJ9Qlu6Z6viyB9trXkie2jQYT9M2XcpWDF3Kro7q1sGvmCqjdpJSbW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:9906:: with SMTP id
 z6mr4056639ybn.373.1632383208945; Thu, 23 Sep 2021 00:46:48 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:09 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-7-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 06/13] perf expr: Move actions to the left.
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

No functional change, just modifying whitespace. This creates additional
space for adding logic to actions in later changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 124 +++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 5535badeef0a..78cbe377eb0e 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -70,54 +70,80 @@ MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/
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
-	| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
-	| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
-	| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
-	| expr '<' expr { BINARY_OP($$, <, $1, $3); }
-	| expr '>' expr { BINARY_OP($$, >, $1, $3); }
-	| expr '+' expr { BINARY_OP($$, +, $1, $3); }
-	| expr '-' expr { BINARY_OP($$, -, $1, $3); }
-	| expr '*' expr { BINARY_OP($$, *, $1, $3); }
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
-	| D_RATIO '(' expr ',' expr ')' { if ($5 == 0) {
-						$$ = 0;
-					  } else {
-						$$ = $3 / $5;
-					  }
-					}
-	;
+
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
 
 %%
-- 
2.33.0.464.g1972c5931b-goog

