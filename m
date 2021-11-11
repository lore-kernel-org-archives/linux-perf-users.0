Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7EC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4365661247
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhKKAYj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhKKAY0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:26 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FEEC06120D
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:31 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j18-20020a63fc12000000b002dd2237eb1cso2356240pgi.5
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ysfAt0727wYQ+HJ8KRibxWLngludw4JaiIow3mYs7B0=;
        b=kCFIPIuqd68E9OmujGRT/TOQFQdeEVYZQPBJVWch2zEVTL+fgLb6fHKGItZtIcRoGI
         9Fmvp9YHLDTcNzzcN06928mfJ1/naY3dD9bI84xoFho9vUh+GS4P9/IEA7ZrFmVmh+Wq
         Zm2gdLtPOBSxk7444xgW9ATFuWbiYp4VbN+wiLHkDL3IXVPl8Apfx9A4MpEZJWLYO803
         eDnSz6kjlgdUBRg5spHe9PLRdRnlgO/yn1LDk8h5RpHAAbUMrmrVjaeF5Eg33O59sSTR
         vAYLdRj7Y/N8uLo/NMUdrhn3esT48DuC6JZzGJliDQwuHaK468E+sEh3oVtcocnFxc7d
         ZS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ysfAt0727wYQ+HJ8KRibxWLngludw4JaiIow3mYs7B0=;
        b=6sMtGktyzvY75JMPrT4GenDNOAuSu744/soOQF9ejgiIKPXjZ6eqm2fmf+ycrg06fe
         H2TVEGvjlO2xmn3KcmZWp/DNxKlfRozGZMaYFcYPLl/7K5tLRitPjZlNGVYTgbuT+8s6
         ef52XJez06vx7yv43B3AovYqc7ji6GtQ6/sPnb2jeRGZYFYX8+jsrO1kbUO4tFfewP2U
         lEqsxcNZAjl8LdqLSTtrvbrdeFkfKLKklKC/FBenLDG6ZidVUm6xyhHYpNVAvSwbjXlb
         9vJiAhcJXPzTHTyz6/oCsIjhsQBSkLD8aIZ5vc6ITKIMUZ+CdQaMVOQLZheiDGXoEyo/
         414g==
X-Gm-Message-State: AOAM531s76XqrGeuuHQKIi7e79LMYizsTYdfIUxojXhLbznYTPn6nvv9
        8DMOJwObMURJt181R2REjoDCXP1HiBhO
X-Google-Smtp-Source: ABdhPJzU9ItlPGVTvjpgVmparPnj71P3walgNi8rt3SCDoCdsnpQMLpNCZPs05oYFAWEIEfTc32/XQ3jmunT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a17:90b:3509:: with SMTP id
 ls9mr21661347pjb.99.1636590091392; Wed, 10 Nov 2021 16:21:31 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:09 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-9-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 8/8] perf expr: Add source_count for aggregating events
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Events like uncore_imc/cas_count_read/ on Skylake open multiple events
and then aggregate in the metric leader. To determine the average value
per event the number of these events is needed. Add a source_count
function that returns this value by counting the number of events with
the given metric leader. For most events the value is 1 but for
uncore_imc/cas_count_read/ it can yield values like 6.

Add a generic test, but manually tested with a test metric that uses
the function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 12 ++++++++++++
 tools/perf/util/evsel.c       | 12 ++++++++++++
 tools/perf/util/evsel.h       |  1 +
 tools/perf/util/expr.c        | 27 ++++++++++++++++++++++-----
 tools/perf/util/expr.h        |  3 +++
 tools/perf/util/expr.l        |  1 +
 tools/perf/util/expr.y        | 15 +++++++++------
 tools/perf/util/stat-shadow.c |  7 ++++++-
 8 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 0c09ccc76665..f14d11ac353e 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -171,6 +171,18 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
 	TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
+	/*
+	 * Source count returns the number of events aggregating in a leader
+	 * event including the leader. Check parsing yields an id.
+	 */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("source count",
+			expr__find_ids("source_count(EVENT1)",
+			NULL, ctx) == 0);
+	TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, "EVENT1",
+							(void **)&val_ptr));
+
 	expr__ctx_free(ctx);
 
 	return 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ec967fb8d7d9..a59fb2ecb84e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3037,3 +3037,15 @@ void evsel__set_leader(struct evsel *evsel, struct evsel *leader)
 {
 	evsel->core.leader = &leader->core;
 }
+
+int evsel__source_count(const struct evsel *evsel)
+{
+	struct evsel *pos;
+	int count = 0;
+
+	evlist__for_each_entry(evsel->evlist, pos) {
+		if (pos->metric_leader == evsel)
+			count++;
+	}
+	return count;
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3ea687141afa..29d49a8c1e92 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -489,6 +489,7 @@ struct evsel *evsel__leader(struct evsel *evsel);
 bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
 bool evsel__is_leader(struct evsel *evsel);
 void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
+int evsel__source_count(const struct evsel *evsel);
 
 /*
  * Macro to swap the bit-field postition and size.
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 15af8b8ef5e7..1d532b9fed29 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -23,7 +23,10 @@ extern int expr_debug;
 
 struct expr_id_data {
 	union {
-		double val;
+		struct {
+			double val;
+			int source_count;
+		} val;
 		struct {
 			double val;
 			const char *metric_name;
@@ -140,6 +143,13 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
 
 /* Caller must make sure id is allocated */
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
+{
+	return expr__add_id_val_source_count(ctx, id, val, /*source_count=*/1);
+}
+
+/* Caller must make sure id is allocated */
+int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
+				  double val, int source_count)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
@@ -148,7 +158,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	data_ptr = malloc(sizeof(*data_ptr));
 	if (!data_ptr)
 		return -ENOMEM;
-	data_ptr->val = val;
+	data_ptr->val.val = val;
+	data_ptr->val.source_count = source_count;
 	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
 	ret = hashmap__set(ctx->ids, id, data_ptr,
@@ -244,7 +255,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 
 	switch (data->kind) {
 	case EXPR_ID_DATA__VALUE:
-		pr_debug2("lookup(%s): val %f\n", id, data->val);
+		pr_debug2("lookup(%s): val %f\n", id, data->val.val);
 		break;
 	case EXPR_ID_DATA__REF:
 		pr_debug2("lookup(%s): ref metric name %s\n", id,
@@ -255,7 +266,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 			pr_debug("%s failed to count\n", id);
 			return -1;
 		}
-		pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
+		pr_debug("processing metric: %s EXIT: %f\n", id, data->ref.val);
 		break;
 	case EXPR_ID_DATA__REF_VALUE:
 		pr_debug2("lookup(%s): ref val %f metric name %s\n", id,
@@ -370,11 +381,17 @@ int expr__find_ids(const char *expr, const char *one,
 double expr_id_data__value(const struct expr_id_data *data)
 {
 	if (data->kind == EXPR_ID_DATA__VALUE)
-		return data->val;
+		return data->val.val;
 	assert(data->kind == EXPR_ID_DATA__REF_VALUE);
 	return data->ref.val;
 }
 
+double expr_id_data__source_count(const struct expr_id_data *data)
+{
+	assert(data->kind == EXPR_ID_DATA__VALUE);
+	return data->val.source_count;
+}
+
 double expr__get_literal(const char *literal)
 {
 	static struct cpu_topology *topology;
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index a6ab7f2b23d1..bd2116983bbb 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -40,6 +40,8 @@ void expr__ctx_free(struct expr_parse_ctx *ctx);
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
+int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
+				double val, int source_count);
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data);
@@ -55,6 +57,7 @@ int expr__find_ids(const char *expr, const char *one,
 		   struct expr_parse_ctx *ids);
 
 double expr_id_data__value(const struct expr_id_data *data);
+double expr_id_data__source_count(const struct expr_id_data *data);
 double expr__get_literal(const char *literal);
 
 #endif
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index cf6e3c710502..0a13eb20c814 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -107,6 +107,7 @@ max		{ return MAX; }
 min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
+source_count	{ return SOURCE_COUNT; }
 {literal}	{ return literal(yyscanner); }
 {number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index d90addf9b937..d5d10f21097a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -37,7 +37,7 @@
 	} ids;
 }
 
-%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO EXPR_ERROR
+%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -84,7 +84,7 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 }
 
 static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
-			    bool compute_ids)
+			    bool compute_ids, bool source_count)
 {
 	struct ids result;
 	if (!compute_ids) {
@@ -95,9 +95,11 @@ static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
 		struct expr_id_data *data;
 
 		result.val = NAN;
-		if (expr__resolve_id(ctx, id, &data) == 0)
-			result.val = expr_id_data__value(data);
-
+		if (expr__resolve_id(ctx, id, &data) == 0) {
+			result.val = source_count
+				? expr_id_data__source_count(data)
+				: expr_id_data__value(data);
+		}
 		result.ids = NULL;
 		free(id);
 	} else {
@@ -200,7 +202,8 @@ expr: NUMBER
 	$$.val = $1;
 	$$.ids = NULL;
 }
-| ID		{ $$ = handle_id(ctx, $1, compute_ids); }
+| ID				{ $$ = handle_id(ctx, $1, compute_ids, /*source_count=*/false); }
+| SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, /*source_count=*/true); }
 | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
 | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
 | expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e4fb02b05130..5c7308efa768 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -829,10 +829,12 @@ static int prepare_metric(struct evsel **metric_events,
 		struct saved_value *v;
 		struct stats *stats;
 		u64 metric_total = 0;
+		int source_count;
 
 		if (!strcmp(metric_events[i]->name, "duration_time")) {
 			stats = &walltime_nsecs_stats;
 			scale = 1e-9;
+			source_count = 1;
 		} else {
 			v = saved_value_lookup(metric_events[i], cpu, false,
 					       STAT_NONE, 0, st,
@@ -841,6 +843,7 @@ static int prepare_metric(struct evsel **metric_events,
 				break;
 			stats = &v->stats;
 			scale = 1.0;
+			source_count = evsel__source_count(metric_events[i]);
 
 			if (v->metric_other)
 				metric_total = v->metric_total;
@@ -849,7 +852,9 @@ static int prepare_metric(struct evsel **metric_events,
 		if (!n)
 			return -ENOMEM;
 
-		expr__add_id_val(pctx, n, metric_total ? : avg_stats(stats) * scale);
+		expr__add_id_val_source_count(pctx, n,
+					metric_total ? : avg_stats(stats) * scale,
+					source_count);
 	}
 
 	for (j = 0; metric_refs && metric_refs[j].metric_name; j++) {
-- 
2.34.0.rc1.387.gb447b232ab-goog

