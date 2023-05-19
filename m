Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB5FC77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 06:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjESGho (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 02:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGhn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 02:37:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D634E4D
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2023 23:37:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561f1c2af16so18420197b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2023 23:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684478261; x=1687070261;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=POR3nD2hZh2mgrvjJBel/KBPGvBrYJdGRQz+avV/aPk=;
        b=jfy86rUx/iJHAPc8wLaNfjNWI7svQmVPT7Xjv8DRM3U1gG1A2UIFxcsCE7T4x0l2XB
         k+7FKpo9UxSFPnhqhIDZVKJdatqWKY978V7cj0QdXBjclZX9QQQHgHKOBj8cxet8GAz1
         bu6JKToCuaxtYQGWjU9INTEqGzOzBvr+AK0v3n+I4q51CQiEp/UnjGOQIKPd1zdCKyHz
         5StcjNITo0JGppTM24lVk0oIkvciIHIeEn8m7NPH0JrXuR25yNm4VgK1iSV1qC9ioWOD
         dXSviXwhAfz0f7Kg0zgTY4QfeRLlt8qfG5e6n4NbsD+X5I+dVgD3XhL1zBVqun1xGiu1
         hQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684478261; x=1687070261;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POR3nD2hZh2mgrvjJBel/KBPGvBrYJdGRQz+avV/aPk=;
        b=E4IGj+XNXTmUXLySyvnVHQuL9IQ6bpw41wfgneWK5Bparwa90R+Wiju1Cc+rJaOPQb
         ksrQtfV6SN4MUzpzkgvh3Y3Y0YHH97R25K9p8CohnajdXqV1dPTrzOFy5zjTcC5lDLi7
         Sea/+fA1RXwUplSi+/oNdcbP2L3A8zQykSH3pHaDIWBKXTRQ+vZ2H3OErl6deUHYBi1R
         iAeZqjy/RzunbH/d77CcyE52eiisD8a6RCp6NmcasRDr28+n+/edUP4/NQUQXOYA7qON
         ayx6ZBXeaJUiXRpIDBZZHvycZqnirwDyOfHpB966Q/xjL/n3CgBb0nQVI4kkaEwehWX1
         beAg==
X-Gm-Message-State: AC+VfDx8uSMk0KyCK8hw7UBHN0FAVqJ7DswEQfkBAfmVhUFoBGFg2KBe
        b6RSXTIlMtPqzsSlL8mQ1e6mILDcApKn
X-Google-Smtp-Source: ACHHUZ4bJOrxfPSPY5F/uvdEopv62sFPa0XQxManJyy2pxqQ8iDd1t32WsDDd13/MucFue6f0kHusE2GniYn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a7c2:2c4c:d716:50e2])
 (user=irogers job=sendgmr) by 2002:a81:4311:0:b0:561:8ff6:fb5b with SMTP id
 q17-20020a814311000000b005618ff6fb5bmr623232ywa.10.1684478261588; Thu, 18 May
 2023 23:37:41 -0700 (PDT)
Date:   Thu, 18 May 2023 23:37:18 -0700
Message-Id: <20230519063719.1029596-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 1/2] perf expr: Make the evaluation of & and | logical and lazy
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the & and | operators are only used in metric thresholds
like (from the tma_retiring metric):
tma_retiring > 0.7 | tma_heavy_operations > 0.1

Thresholds are always computed when present, but a lack events may
mean the threshold can't be computed. This happens with the option
--metric-no-threshold for say the metric tma_retiring on Tigerlake
model CPUs. To fully compute the threshold tma_heavy_operations is
needed and it needs the extra events of IDQ.MS_UOPS,
UOPS_DECODED.DEC0, cpu/UOPS_DECODED.DEC0,cmask=1/ and
IDQ.MITE_UOPS. So --metric-no-threshold is a useful option to reduce
the number of events needed and potentially multiplexing of events.

Rather than just fail threshold computations like this, we may know a
result from just the left or right-hand side. So, for tma_retiring if
its value is "> 0.7" we know it is over the threshold. This allows the
metric to have the threshold coloring, when possible, without all the
counters being programmed.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/expr.c | 40 +++++++++++++++++++
 tools/perf/util/expr.y  | 86 +++++++++++++++++++++++++++++++++--------
 2 files changed, 109 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 733ead151c63..3d01eb5e2512 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -185,6 +185,46 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 			NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
 
+	/* The expression is a constant 0.0 without needing to evaluate EVENT1. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("0 & EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 & 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("1 & EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 & 1", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+
+	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("1 | EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 | 1", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("0 | EVENT1 > 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 > 0 | 0", NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
+
 	/* Test toplogy constants appear well ordered. */
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 4ce931cccb63..f04963eb6be0 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -123,20 +123,6 @@ static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
  * constant value using OP. Its invariant that there are no ids.  If computing
  * ids for non-constants union the set of IDs that must be computed.
  */
-#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
-	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
-		assert(LHS.ids == NULL);				\
-		assert(RHS.ids == NULL);				\
-		if (isnan(LHS.val) || isnan(RHS.val)) {			\
-			RESULT.val = NAN;				\
-		} else {						\
-			RESULT.val = (long)LHS.val OP (long)RHS.val;	\
-		}							\
-		RESULT.ids = NULL;					\
-	} else {							\
-	        RESULT = union_expr(LHS, RHS);				\
-	}
-
 #define BINARY_OP(RESULT, OP, LHS, RHS)					\
 	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
 		assert(LHS.ids == NULL);				\
@@ -213,9 +199,75 @@ expr: NUMBER
 }
 | ID				{ $$ = handle_id(ctx, $1, compute_ids, /*source_count=*/false); }
 | SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, /*source_count=*/true); }
-| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
-| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
-| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
+| expr '|' expr
+{
+	if (is_const($1.val) && is_const($3.val)) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.ids = NULL;
+		$$.val = (fpclassify($1.val) == FP_ZERO && fpclassify($3.val) == FP_ZERO) ? 0 : 1;
+	} else if (is_const($1.val)) {
+		assert($1.ids == NULL);
+		if (fpclassify($1.val) == FP_ZERO) {
+			$$ = $3;
+		} else {
+			$$.val = 1;
+			$$.ids = NULL;
+			ids__free($3.ids);
+		}
+	} else if (is_const($3.val)) {
+		assert($3.ids == NULL);
+		if (fpclassify($3.val) == FP_ZERO) {
+			$$ = $1;
+		} else {
+			$$.val = 1;
+			$$.ids = NULL;
+			ids__free($1.ids);
+		}
+	} else {
+		$$ = union_expr($1, $3);
+	}
+}
+| expr '&' expr
+{
+	if (is_const($1.val) && is_const($3.val)) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = (fpclassify($1.val) != FP_ZERO && fpclassify($3.val) != FP_ZERO) ? 1 : 0;
+		$$.ids = NULL;
+	} else if (is_const($1.val)) {
+		assert($1.ids == NULL);
+		if (fpclassify($1.val) != FP_ZERO) {
+			$$ = $3;
+		} else {
+			$$.val = 0;
+			$$.ids = NULL;
+			ids__free($3.ids);
+		}
+	} else if (is_const($3.val)) {
+		assert($3.ids == NULL);
+		if (fpclassify($3.val) != FP_ZERO) {
+			$$ = $1;
+		} else {
+			$$.val = 0;
+			$$.ids = NULL;
+			ids__free($1.ids);
+		}
+	} else {
+		$$ = union_expr($1, $3);
+	}
+}
+| expr '^' expr
+{
+	if (is_const($1.val) && is_const($3.val)) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = (fpclassify($1.val) == FP_ZERO) != (fpclassify($3.val) == FP_ZERO) ? 1 : 0;
+		$$.ids = NULL;
+	} else {
+		$$ = union_expr($1, $3);
+	}
+}
 | expr '<' expr { BINARY_OP($$, <, $1, $3); }
 | expr '>' expr { BINARY_OP($$, >, $1, $3); }
 | expr '+' expr { BINARY_OP($$, +, $1, $3); }
-- 
2.40.1.698.g37aff9b760-goog

