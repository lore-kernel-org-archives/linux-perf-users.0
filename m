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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD89BC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36E361038
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbhIWHs1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239843AbhIWHsX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:23 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59EC061756
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:52 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x28-20020ac8701c000000b0029f4b940566so15347596qtm.19
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lr2HRrbHvz7n2QY5hsKJ6KsHqsKizEogqtvX3VlhgsE=;
        b=sPEAR1bw5Lpx6UH+lclnXFhbBKe7HpEweNC5hCparH2Bnhb4F9mIMCz5UqRLtCibJQ
         hf/essIUnM+9WTlLEi1tnXQgsLS7eYpwDEdH446rdN2czxStrQ/z0tHGlOtv3YMMyA2F
         32DgyCDvTjgCbMenHTaLbtKi+Tlg+C6APTo/iiynSpliqvdMlr0oAc0ESjkrPKtQEctI
         4pJUJa3Oa3UttDfb+m7IaKgoCTHPZXnT0ujxlGH2Pw0us6fMX9G4qqXFkIIrRlSpFRud
         Sqd4whLFoal32SBhDDUAbB7WKN553sGiGY/ZpVQcFeIhYKdYsl5aAZU9T714Y7LiDHVF
         4ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lr2HRrbHvz7n2QY5hsKJ6KsHqsKizEogqtvX3VlhgsE=;
        b=CsWLMVgFXSO4Ffwt58Bbk0n+jdCK5RgxoX7wL/8qdH250gQXmjUBEG2cqkK4jogFE2
         P4ACXVUcbQKteypC16sAo9hw/yvodHrANZQ1T0kwyp/3YuiVnbNFtN3NuTJdveEjDNTd
         CewUdurECrct/IrElsHEfsF9xSrFuRkBNOKGWREOCus3n1eOo8vJVIi9IXdY0IQAQRKy
         eN25/zUD/SrGvYoVjiAGfsvMxTjQw8DiZmuFZD2gQkyIUrxm5FG3Awz2okC/fBVAQN2e
         yfvPO/MWMrTNVqivpAxCjclq8bpyONOQ/sT4sYrs8lVG/eH9ZXXzI1QVbW4RNGJqp1oM
         wbMQ==
X-Gm-Message-State: AOAM531nXCGV7cOGyfFn+zkRFtGdmsKxc9XCVQLPMpu507brVhLbQ9Al
        rWifjNlkVsmjFtvkNY/Q/A47bSMwH5Ae
X-Google-Smtp-Source: ABdhPJzKexFbPS0v9tWWjbC1eCX1w4KjcXlBNkJMTu3PMvjhqMQhjEhqse1qIYFTTeza/u66cO0tv9Lbk/nk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:ad4:5594:: with SMTP id
 e20mr3154908qvx.62.1632383211214; Thu, 23 Sep 2021 00:46:51 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:10 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-8-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 07/13] perf metric: Rename expr__find_other.
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

A later change will remove the notion of other, rename the function to
expr__find_ids as this is what it populates.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 26 +++++++++++++-------------
 tools/perf/tests/pmu-events.c | 11 +++++------
 tools/perf/util/expr.c        |  4 ++--
 tools/perf/util/expr.h        |  2 +-
 tools/perf/util/metricgroup.c |  2 +-
 tools/perf/util/stat-shadow.c |  6 +++---
 6 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index b0a3b5fd0c00..7ccb97c73347 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -64,25 +64,25 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("missing operand", ret == -1);
 
 	expr__ctx_clear(ctx);
-	TEST_ASSERT_VAL("find other",
-			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO",
-					 ctx, 1) == 0);
-	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 3);
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BAR",
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
+					ctx, 1) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAR",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BAZ",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAZ",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BOZO",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BOZO",
 						    (void **)&val_ptr));
 
 	expr__ctx_clear(ctx);
-	TEST_ASSERT_VAL("find other",
-			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
-					 NULL, ctx, 3) == 0);
-	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 2);
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT1,param=3/",
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
+					NULL, ctx, 3) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3/",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT2,param=3/",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3/",
 						    (void **)&val_ptr));
 
 	expr__ctx_free(ctx);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ff3b2e5e6141..73ec2123b99e 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -811,7 +811,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 			ref->metric_expr = pe->metric_expr;
 			list_add_tail(&metric->list, compound_list);
 
-			rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
+			rc = expr__find_ids(pe->metric_expr, NULL, pctx, 0);
 			if (rc)
 				goto out_err;
 			break; /* The hashmap has been modified, so restart */
@@ -861,9 +861,8 @@ static int test_parsing(void)
 			if (!pe->metric_expr)
 				continue;
 			expr__ctx_clear(ctx);
-			if (expr__find_other(pe->metric_expr, NULL, ctx, 0)
-				  < 0) {
-				expr_failure("Parse other failed", map, pe);
+			if (expr__find_ids(pe->metric_expr, NULL, ctx, 0) < 0) {
+				expr_failure("Parse find ids failed", map, pe);
 				ret++;
 				continue;
 			}
@@ -935,8 +934,8 @@ static int metric_parse_fake(const char *str)
 		pr_debug("expr__ctx_new failed");
 		return TEST_FAIL;
 	}
-	if (expr__find_other(str, NULL, ctx, 0) < 0) {
-		pr_err("expr__find_other failed\n");
+	if (expr__find_ids(str, NULL, ctx, 0) < 0) {
+		pr_err("expr__find_ids failed\n");
 		return -1;
 	}
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7b1c06772a49..adf16bb7571a 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -288,8 +288,8 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
 }
 
-int expr__find_other(const char *expr, const char *one,
-		     struct expr_parse_ctx *ctx, int runtime)
+int expr__find_ids(const char *expr, const char *one,
+		   struct expr_parse_ctx *ctx, int runtime)
 {
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 5fa394f10418..de109c2ab917 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -43,7 +43,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime);
-int expr__find_other(const char *expr, const char *one,
+int expr__find_ids(const char *expr, const char *one,
 		struct expr_parse_ctx *ids, int runtime);
 
 double expr_id_data__value(const struct expr_id_data *data);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b7924a2f1f45..046fb3fe1700 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -857,7 +857,7 @@ static int __add_metric(struct list_head *metric_list,
 	 * For both the parent and referenced metrics, we parse
 	 * all the metric's IDs and add it to the parent context.
 	 */
-	if (expr__find_other(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
+	if (expr__find_ids(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
 		if (m->metric_refs_cnt == 0) {
 			expr__ctx_free(m->pctx);
 			free(m);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index c9fa07e49e72..9bc841e09a0c 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -392,9 +392,9 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 		expr__ctx_clear(ctx);
 		metric_events = counter->metric_events;
 		if (!metric_events) {
-			if (expr__find_other(counter->metric_expr,
-					     counter->name,
-					     ctx, 1) < 0)
+			if (expr__find_ids(counter->metric_expr,
+					   counter->name,
+					   ctx, 1) < 0)
 				continue;
 
 			metric_events = calloc(sizeof(struct evsel *),
-- 
2.33.0.464.g1972c5931b-goog

