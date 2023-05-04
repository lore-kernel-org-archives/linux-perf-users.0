Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02330C77B78
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 20:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjEDUV3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 16:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjEDUVJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 16:21:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA22D1156E
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 13:07:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1aaff728c24so7011355ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683230757; x=1685822757;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/r9KGpkW5PSBM9D941BUL0+gJYwAE5n4IR7E5or+wxM=;
        b=A+F+1nGkKZNvXnCdhaSW0gZ2uEJuFYqqUUdbC3zWxTYzxgX6KVINf2otMJ8dqWRt99
         NKXrSOy62iASlHDMPWp19rygyNrbD6ndINRinFfJxJH1mqwtIk6wuiPvRwSjxpHcxl+H
         enjOC846aQGQXd3grzYaU7lM3JkgU3GWh10DyisJ9nxEexeZ4vTQNYImFY8V0KK4m7eN
         9ygmebTC9TU7jt80un3GIL0BtT56peh96lplLuDtYgdpzh4MrAB4v6jebrM93a5rhx2o
         1jwCB1lKAzqETCC5st9b0TuTeukiuyLOwVKZUXk8slTGaQhH/kDORhKh7qoKGF0KBnNf
         05cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683230757; x=1685822757;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r9KGpkW5PSBM9D941BUL0+gJYwAE5n4IR7E5or+wxM=;
        b=aqCq2wWC37hSKWMWCxdEWd8EM2WVh5KFEmRwXYBoc7UapOD0r4f/NHh+WBw6iXWiUO
         VL4/zEoW+On0YWhwkWmU/63phaVLlWWFEqn8fUNTLvk/ARHVpfMYBuF50Alyn+KT8Q0x
         KQo8EBGqobZRKFDh+ZkUqXqWVaPecryfTOW0EcCcoy9RaodV9pKHvrWCJNFZLLAZuYr5
         WSfMGWUKQ23Dm09SrSYfwNcrFoMFZRIes5pN1vLLugtU3SXi0a4/1cTmGj08bl4UsUWm
         6aSo2829QABGBwIzfNXmr/jURcrdjhqDwrnDp5bNBmbjdahpSI5G2tdZIL6fhqmJZpPa
         9uGQ==
X-Gm-Message-State: AC+VfDxyR9JdpYZoLZbSt0AZ1ZlremJtxfe6Y5d3dEWKp67XKEZ3k59l
        gOjTph1mH198RRQVirlN0WOFjP4wog0G
X-Google-Smtp-Source: ACHHUZ72tuOd4ycu57tLPZJN/WIH3wq4S5qp9AaiBLzc58+OfgrMXhnv3k26K2Uh8T+qFJeqz4q2QD8tP0yt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3367:2fed:395f:6f64])
 (user=irogers job=sendgmr) by 2002:a05:6902:1804:b0:b9d:c27c:3442 with SMTP
 id cf4-20020a056902180400b00b9dc27c3442mr452307ybb.9.1683230294858; Thu, 04
 May 2023 12:58:14 -0700 (PDT)
Date:   Thu,  4 May 2023 12:58:02 -0700
Message-Id: <20230504195803.3331775-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1 1/2] perf expr: Make the evaluation of & and | logical and lazy
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
---
 tools/perf/tests/expr.c | 40 +++++++++++++++++++
 tools/perf/util/expr.y  | 86 +++++++++++++++++++++++++++++++++--------
 2 files changed, 109 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index cbf0e0c74906..45c7fedb797a 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -184,6 +184,46 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
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
index 250e444bf032..6b110f9f95c9 100644
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
2.40.1.521.gf1e218fcd8-goog

