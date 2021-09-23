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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC024C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C758861038
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhIWHtD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbhIWHsr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F0C0613DE
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:47:01 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w17-20020ae9e511000000b00431497430b7so17886078qkf.12
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qlR5bzlOU/WjUFDG+HHwrsg3nYPORqGbaBaAZ8CvHrw=;
        b=nFr0Rc3HWv7Hyn7I+BZEmAagANmmJKrbjwLeQzvsKr5RGysFzKJil0w6Xylo/ACSjU
         G+DbAaUI4GM9h440leKCcbLtwz83sidh38yF8Xo+e3ycWa6vptOmXYDZNoq0OxKRQK7D
         AFYNG8sRYhcUaUqk+VlCcjJqm5cEpb8Wi355WVhYxXq1ijf6Nzm3mgxwEET++q6G0enR
         F8NyB+e+VHgIBexSNTB41S+IsF0TBZwriRV+paXgTdLGg/7wuA5jHeOlLAIhZfcQOdsa
         4hBWDAv7XAtQSzcZhgpgANU+h/l3ZIfw7ZlhAk3OsoBIygjeZilf6D+oqs4JOezkOuC5
         sHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qlR5bzlOU/WjUFDG+HHwrsg3nYPORqGbaBaAZ8CvHrw=;
        b=PNBjNqu7L4930sXqB6l2i151De3zZ2Hq6u6NTMP1VID+60CAc5rASI59imZNzEgoJq
         2L02EbcC4aYqJ30tpO3PDhNl6TAkBAhHaW8L1/ozeiwiB0YIYkPWpPrfFBARu7wxV7i3
         X8o1QAqcTzkL8G96AYK/JYgB4gWJ3yYG6KselJshsZFqw/CPXoIFVwBTBiCRSpHckGpd
         aovUMPUkddlpFE8D+zB3yXqZW9WvXK9xS+u+9ERvAiTqonFxnBFpiUoPvf0roGNzWVn/
         sS4ixiQlc64JDenWR3SXn5oIW7lnjxveYJCVi+I8QRDxzCl8IA3N6vNFTfejqL2fRmgK
         yQtQ==
X-Gm-Message-State: AOAM5327Ufv7h1HFrzaiW6t1WPgNdMkXkbNhTNfvwFL7hWkkx6Yx7R3U
        +GT/1U0G6z1qbR/moFm3SdL2Lg31b8zN
X-Google-Smtp-Source: ABdhPJx8EbBywems0yzB+iMD8n/p1IntNrwGGx/ijNsUbvOH2vjE4/2dcjAlH+TLMmO5/Nzbmhw05wE0M7Wf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:1444:: with SMTP id
 b4mr3024129qvy.33.1632383220886; Thu, 23 Sep 2021 00:47:00 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:14 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-12-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 11/13] perf expr: Propagate constants for binary operations
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

When we're computing ID values, if we have constant values then compute
the constant result. For example:
  1 + 2
Previously .val would be set to BOTTOM by union_expr, meaning that
all values are possible. With this change .val is set to 3.
Later changes will use the constant values to hopefully eliminate ID
values that don't need to be computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 63 ++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 6aeead54760a..5a295e385914 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -68,6 +68,12 @@ static void expr_error(double *final_val __maybe_unused,
  */
 #define BOTTOM NAN
 
+/* During computing ids, does val represent a constant (non-BOTTOM) value? */
+static bool is_const(double val)
+{
+	return isfinite(val);
+}
+
 static struct ids union_expr(struct ids ids1, struct ids ids2)
 {
 	struct ids result = {
@@ -77,8 +83,15 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 	return result;
 }
 
+/*
+ * If we're not computing ids or $1 and $3 are constants, compute the new
+ * constant value using OP. Its invariant that there are no ids.  If computing
+ * ids for non-constants union the set of IDs that must be computed.
+ */
 #define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
-	if (!compute_ids) {						\
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
 		RESULT.val = (long)LHS.val OP (long)RHS.val;		\
 		RESULT.ids = NULL;					\
 	} else {							\
@@ -86,7 +99,9 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 	}
 
 #define BINARY_OP(RESULT, OP, LHS, RHS)					\
-	if (!compute_ids) {						\
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
 		RESULT.val = LHS.val OP RHS.val;			\
 		RESULT.ids = NULL;					\
 	} else {							\
@@ -163,40 +178,52 @@ expr: NUMBER
 | expr '*' expr { BINARY_OP($$, *, $1, $3); }
 | expr '/' expr
 {
-	if (!compute_ids) {
-		if (fpclassify($3.val) == FP_ZERO) {
-			pr_debug("division by zero\n");
-			YYABORT;
-		}
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
 		$$.val = $1.val / $3.val;
 		$$.ids = NULL;
 	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
 		$$ = union_expr($1, $3);
 	}
 }
 | expr '%' expr
 {
-	if (!compute_ids) {
-		if (fpclassify($3.val) == FP_ZERO) {
-			pr_debug("division by zero\n");
-			YYABORT;
-		}
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
 		$$.val = (long)$1.val % (long)$3.val;
 		$$.ids = NULL;
 	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
 		$$ = union_expr($1, $3);
 	}
 }
 | D_RATIO '(' expr ',' expr ')'
 {
-	if (!compute_ids) {
+	if (fpclassify($5.val) == FP_ZERO) {
+		/*
+		 * Division by constant zero always yields zero and no events
+		 * are necessary.
+		 */
+		assert($5.ids == NULL);
+		$$.val = 0.0;
+		$$.ids = NULL;
+		ids__free($3.ids);
+	} else if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val / $5.val;
 		$$.ids = NULL;
-		if (fpclassify($5.val) == FP_ZERO) {
-			$$.val = 0.0;
-		} else {
-			$$.val = $3.val / $5.val;
-		}
 	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
 		$$ = union_expr($3, $5);
 	}
 }
-- 
2.33.0.464.g1972c5931b-goog

