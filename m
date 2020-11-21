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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECEAC64E7A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB01223FD
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ado+uJCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgKUDLb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 22:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgKUDL3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Nov 2020 22:11:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919FAC061A47
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so14193382ybm.13
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TcMg2D4AR9XYjmITcmV1XG9smtxoIoKtYLDcV7haDhw=;
        b=Ado+uJCaoDYKbcx0IaKNBAaY7QJz23ovtZlsVrSa1DjIcsc/zu+Reuu9rFsPrtZd+a
         FWeUklnGcvexOrTy5cfmlHm6nPu06ol79pBJ4XbR0Kmo4AdbOq/1JIYlLAE6CJNqX5zr
         XE+ouxpYhCxy5Lgl4Vs7k47QBkzY5UElnFqVDFCAthRoSi/dzUUme2RE2tTz0whXwtAI
         O4s1mLJbfD/I/48B15u8RQrJwA816GeQ5K+BbR8Dnf9FEnF1ivXhnVx2rSoNyBMxKjMR
         cmAqgV4IRikUzXivCdD5J26KZo+F+tKrS3koIZUIAmyBGVNiX3MPte/EpbXGMlcg/5fA
         2/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TcMg2D4AR9XYjmITcmV1XG9smtxoIoKtYLDcV7haDhw=;
        b=gx83HjFlAVISK4tNXYAFMy7VGA3ljjowKRHdlsS2SS+SRlaHOjwzIlBn8Qh9HhOWar
         g59X8YBtpiVFLDYG5f1SqMEuFwGHjRGPRa5dN9eO6tkqd1A480umPvX8mR5jE7jJ//SS
         21l8zj6vbBYvED5ZKB0V476vvLsFRyQb5WN+9U/lCN3p7AuwR4eK5bWtzfGfeUoqvQuH
         5JJ3iyCp9y6WY0FI2EEsmXj/YPSg733ymqdCkT/AlgLve2ShQX2rGUb51NROxQIS7vm7
         4qvy+iBPPKrBJxbFdikyXNAgZ69JHG1ICPT/tmkTgxr/Yj0UQ1s7zHj3lOI6Q3bu2fLf
         t7jg==
X-Gm-Message-State: AOAM5336+dkBrTMkg0YGYwgLrAAj5bgW50oXs/JaBpGKFchGtjxYhuqR
        TAY8b+xY3WYPmF5RKF/wi9CVjSYCbdlV
X-Google-Smtp-Source: ABdhPJydzBQ0miBh8UjdMilHJqAMKVfeIl5xRP8cG+8g0YT/WGQ6kPYYRZywwZb6iw//ngFKroH9k2yiXt7X
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:be42:: with SMTP id
 d2mr32756749ybm.217.1605928288827; Fri, 20 Nov 2020 19:11:28 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:11:17 -0800
In-Reply-To: <20201121031119.3554769-1-irogers@google.com>
Message-Id: <20201121031119.3554769-4-irogers@google.com>
Mime-Version: 1.0
References: <20201121031119.3554769-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 3/5] perf metric: Rename expr__find_other.
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

A later change will remove the notion of other, rename the function to
expr__find_ids as this is what it populates.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 26 +++++++++++++-------------
 tools/perf/tests/pmu-events.c |  9 ++++-----
 tools/perf/util/expr.c        |  4 ++--
 tools/perf/util/expr.h        |  2 +-
 tools/perf/util/metricgroup.c |  2 +-
 tools/perf/util/stat-shadow.c |  6 +++---
 6 files changed, 24 insertions(+), 25 deletions(-)

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
index 294daf568bb6..3ac70fa31379 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -502,9 +502,8 @@ static int test_parsing(void)
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
@@ -559,8 +558,8 @@ static int metric_parse_fake(const char *str)
 	pr_debug("parsing '%s'\n", str);
 
 	ctx = expr__ctx_new();
-	if (expr__find_other(str, NULL, ctx, 0) < 0) {
-		pr_err("expr__find_other failed\n");
+	if (expr__find_ids(str, NULL, ctx, 0) < 0) {
+		pr_err("expr__find_ids failed\n");
 		return -1;
 	}
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index e0623d38e6ee..a248d14882cc 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -287,8 +287,8 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
 }
 
-int expr__find_other(const char *expr, const char *one,
-		     struct expr_parse_ctx *ctx, int runtime)
+int expr__find_ids(const char *expr, const char *one,
+		   struct expr_parse_ctx *ctx, int runtime)
 {
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 00b941cfe6a6..955d5adb7ca4 100644
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
index 342dcccb860f..0be684bb020f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -761,7 +761,7 @@ static int __add_metric(struct list_head *metric_list,
 	 * For both the parent and referenced metrics, we parse
 	 * all the metric's IDs and add it to the parent context.
 	 */
-	if (expr__find_other(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
+	if (expr__find_ids(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
 		if (m->metric_refs_cnt == 0) {
 			expr__ctx_free(m->pctx);
 			free(m);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index bea7b5c6b1c0..91bb7245f8b1 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -357,9 +357,9 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
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
2.29.2.454.gaff20da3a2-goog

