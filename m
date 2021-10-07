Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FD8C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5F46113E
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbhJGQ7x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242990AbhJGQ7g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:36 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C199C061768
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:57:42 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ge6-20020a05621427c600b003830ee0213bso6212388qvb.10
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7GoPvdxxy8TnIhHIr0f6IPBu2Q+G5KjuRDNeD3JTriA=;
        b=sXzW45+y+Qmy0Br38InA2STuU4/XnZVNsef3FckT5jqX+OmaDFvnznuhookvZmg/1C
         3lP1LmJ+sr/y4+LmHAh+P6T7J/69CeTVuRRHIafNPtwxkNTPVMXoXHLESdjpiVJnpuxY
         cWiOS76AAWflv4HFCvSxL7oE2B8l35a7jmDqHbRAbLozVPHfn2fCT8heVpWWJzaioyWk
         7y4w+I6+xfsa79rvMlAGewVRwE17wuW4Wl+aUCB289dF2MkvLVOcAPhyiy5hKHN9uFyv
         u/ay3dDlabrlpSTIbZ+E0cJf2kD/Jd8RraYVPts4gcOwN/Rne0YA3jPqviCL74j3sTH/
         IkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7GoPvdxxy8TnIhHIr0f6IPBu2Q+G5KjuRDNeD3JTriA=;
        b=wNbI+IrzGOj1YHnkqftLtUqz5i5Q1tY1O0Nozl3xIFNgUd8lk+9rKuST7brbsDDM3G
         +y6qFdGsQ9thyz8sB0tzFaBCFBRyp4GlZ8nKZbPhDA6g/a3atrtU42WcjO5n525L0F5p
         pLncBUodfE9dkXxyS+XPwxdxQM1/PeGWDZTqpqNJiSk/pQaqoTMyeTDVBEo2/Qp4dBs3
         CvGvr1RJdEnbfRjL4Gp2boqWywReu9lPBchqTswmeoJ1yrAS79QfVxUJanyIM/LhNH+g
         EWhAkdZSPPgaX/EoVqDSVfQ3plNt3ilsTKQYSg8zyfng0ri1AJo/v2FnE5UhtzGCxaiL
         lEHA==
X-Gm-Message-State: AOAM532xZz4Ydv5bi2y6H+KowiGoBNc4hD2ssOY+5KF2C4bGN6B8JdL2
        4bkGru39AI16dx69qSRH8iNZApB9NsQZ
X-Google-Smtp-Source: ABdhPJz8bJeP7Yqg9qAzMGr9PkwzSX8R+uMORtsbBMM16ujyb/jRwRpJEOH9b7U2AAUo2zxmG9GQjW9GCtz2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:aed:278b:: with SMTP id
 a11mr6164906qtd.326.1633625861409; Thu, 07 Oct 2021 09:57:41 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:31 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-6-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 05/21] perf metric: Move runtime value to the expr context
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The runtime value is needed when recursively parsing metrics, currently
a value of 1 is passed which is incorrect. Rather than add more
arguments to the bison parser, add runtime to the context. Fix call
sites not to pass a value. The runtime value is defaulted to 0, which is
arbitrary. In some places this replaces a value of 1, which was also
arbitrary. This shouldn't affect anything other than PPC. The use of
0 or 1 shouldn't matter as a proper runtime value would be needed in a
case that it did matter.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 15 ++++++++-------
 tools/perf/tests/pmu-events.c | 10 +++++-----
 tools/perf/util/expr.c        | 15 ++++++++-------
 tools/perf/util/expr.h        |  5 +++--
 tools/perf/util/metricgroup.c |  7 +++----
 tools/perf/util/stat-shadow.c |  7 ++++---
 6 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index f1d8411fce12..3c16f3df1980 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -56,7 +56,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 {
 	double val;
 
-	if (expr__parse(&val, ctx, e, 1))
+	if (expr__parse(&val, ctx, e))
 		TEST_ASSERT_VAL("parse test failed", 0);
 	TEST_ASSERT_VAL("unexpected value", val == val2);
 	return 0;
@@ -104,17 +104,17 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	}
 
 	p = "FOO/0";
-	ret = expr__parse(&val, ctx, p, 1);
+	ret = expr__parse(&val, ctx, p);
 	TEST_ASSERT_VAL("division by zero", ret == -1);
 
 	p = "BAR/";
-	ret = expr__parse(&val, ctx, p, 1);
+	ret = expr__parse(&val, ctx, p);
 	TEST_ASSERT_VAL("missing operand", ret == -1);
 
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
-					ctx, 1) == 0);
+					ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAR",
 						    (void **)&val_ptr));
@@ -124,9 +124,10 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 						    (void **)&val_ptr));
 
 	expr__ctx_clear(ctx);
+	ctx->runtime = 3;
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
-					NULL, ctx, 3) == 0);
+					NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3/",
 						    (void **)&val_ptr));
@@ -137,7 +138,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1 if #smt_on else EVENT2",
-				NULL, ctx, 0) == 0);
+				NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
 						  smt_on() ? "EVENT1" : "EVENT2",
@@ -147,7 +148,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("1.0 if EVENT1 > 100.0 else 1.0",
-			NULL, ctx, 0) == 0);
+			NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
 
 	expr__ctx_free(ctx);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index cc5cea141beb..71b08c296410 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -866,7 +866,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 			ref->metric_expr = pe->metric_expr;
 			list_add_tail(&metric->list, compound_list);
 
-			rc = expr__find_ids(pe->metric_expr, NULL, pctx, 0);
+			rc = expr__find_ids(pe->metric_expr, NULL, pctx);
 			if (rc)
 				goto out_err;
 			break; /* The hashmap has been modified, so restart */
@@ -916,7 +916,7 @@ static int test_parsing(void)
 			if (!pe->metric_expr)
 				continue;
 			expr__ctx_clear(ctx);
-			if (expr__find_ids(pe->metric_expr, NULL, ctx, 0) < 0) {
+			if (expr__find_ids(pe->metric_expr, NULL, ctx) < 0) {
 				expr_failure("Parse find ids failed", map, pe);
 				ret++;
 				continue;
@@ -949,7 +949,7 @@ static int test_parsing(void)
 				free(metric);
 			}
 
-			if (expr__parse(&result, ctx, pe->metric_expr, 0)) {
+			if (expr__parse(&result, ctx, pe->metric_expr)) {
 				expr_failure("Parse failed", map, pe);
 				ret++;
 			}
@@ -989,7 +989,7 @@ static int metric_parse_fake(const char *str)
 		pr_debug("expr__ctx_new failed");
 		return TEST_FAIL;
 	}
-	if (expr__find_ids(str, NULL, ctx, 0) < 0) {
+	if (expr__find_ids(str, NULL, ctx) < 0) {
 		pr_err("expr__find_ids failed\n");
 		return -1;
 	}
@@ -1010,7 +1010,7 @@ static int metric_parse_fake(const char *str)
 		}
 	}
 
-	if (expr__parse(&result, ctx, str, 0))
+	if (expr__parse(&result, ctx, str))
 		pr_err("expr__parse failed\n");
 	else
 		ret = 0;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index db2445677c8c..62fb39fd4d9d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -246,7 +246,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 			data->ref.metric_name);
 		pr_debug("processing metric: %s ENTRY\n", id);
 		data->kind = EXPR_ID_DATA__REF_VALUE;
-		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr, 1)) {
+		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr)) {
 			pr_debug("%s failed to count\n", id);
 			return -1;
 		}
@@ -284,6 +284,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 
 	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
 	ctx->parent = NULL;
+	ctx->runtime = 0;
 	return ctx;
 }
 
@@ -314,10 +315,10 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 
 static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
-	      bool compute_ids, int runtime)
+	      bool compute_ids)
 {
 	struct expr_scanner_ctx scanner_ctx = {
-		.runtime = runtime,
+		.runtime = ctx->runtime,
 	};
 	YY_BUFFER_STATE buffer;
 	void *scanner;
@@ -345,15 +346,15 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 }
 
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
-		const char *expr, int runtime)
+		const char *expr)
 {
-	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false, runtime) ? -1 : 0;
+	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false) ? -1 : 0;
 }
 
 int expr__find_ids(const char *expr, const char *one,
-		   struct expr_parse_ctx *ctx, int runtime)
+		   struct expr_parse_ctx *ctx)
 {
-	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true, runtime);
+	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true);
 
 	if (one)
 		expr__del_id(ctx, one);
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index b20513f0ae59..124475a4f245 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -21,6 +21,7 @@ struct expr_id {
 struct expr_parse_ctx {
 	struct hashmap	*ids;
 	struct expr_id	*parent;
+	int runtime;
 };
 
 struct expr_id_data;
@@ -52,10 +53,10 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
 
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
-		const char *expr, int runtime);
+		const char *expr);
 
 int expr__find_ids(const char *expr, const char *one,
-		struct expr_parse_ctx *ids, int runtime);
+		   struct expr_parse_ctx *ids);
 
 double expr_id_data__value(const struct expr_id_data *data);
 struct expr_id *expr_id_data__parent(struct expr_id_data *data);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b60ccbbf0829..139f4a793f92 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -124,7 +124,6 @@ struct metric {
 	const char *metric_unit;
 	struct list_head metric_refs;
 	int metric_refs_cnt;
-	int runtime;
 	bool has_constraint;
 };
 
@@ -391,7 +390,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		expr->metric_name = m->metric_name;
 		expr->metric_unit = m->metric_unit;
 		expr->metric_events = metric_events;
-		expr->runtime = m->runtime;
+		expr->runtime = m->pctx->runtime;
 		list_add(&expr->nd, &me->head);
 	}
 
@@ -812,7 +811,7 @@ static int __add_metric(struct list_head *metric_list,
 		m->metric_name = pe->metric_name;
 		m->metric_expr = pe->metric_expr;
 		m->metric_unit = pe->unit;
-		m->runtime = runtime;
+		m->pctx->runtime = runtime;
 		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 		INIT_LIST_HEAD(&m->metric_refs);
 		m->metric_refs_cnt = 0;
@@ -862,7 +861,7 @@ static int __add_metric(struct list_head *metric_list,
 	 * For both the parent and referenced metrics, we parse
 	 * all the metric's IDs and add it to the parent context.
 	 */
-	if (expr__find_ids(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
+	if (expr__find_ids(pe->metric_expr, NULL, m->pctx) < 0) {
 		if (m->metric_refs_cnt == 0) {
 			expr__ctx_free(m->pctx);
 			free(m);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9bc841e09a0c..20f1b9d0f272 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -394,7 +394,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 		if (!metric_events) {
 			if (expr__find_ids(counter->metric_expr,
 					   counter->name,
-					   ctx, 1) < 0)
+					   ctx) < 0)
 				continue;
 
 			metric_events = calloc(sizeof(struct evsel *),
@@ -894,13 +894,14 @@ static void generic_metric(struct perf_stat_config *config,
 	if (!pctx)
 		return;
 
+	pctx->runtime = runtime;
 	i = prepare_metric(metric_events, metric_refs, pctx, cpu, st);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
 	}
 	if (!metric_events[i]) {
-		if (expr__parse(&ratio, pctx, metric_expr, runtime) == 0) {
+		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
 			char *unit;
 			char metric_bf[64];
 
@@ -951,7 +952,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
 	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu, st) < 0)
 		goto out;
 
-	if (expr__parse(&ratio, pctx, mexp->metric_expr, 1))
+	if (expr__parse(&ratio, pctx, mexp->metric_expr))
 		ratio = 0.0;
 
 out:
-- 
2.33.0.882.g93a45727a2-goog

