Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AD3F23CC
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299579; cv=none; b=HBlfqdDUTwlFEoV4qPFF+QTGrCdh+ijsWiPg2qdpdn/jjbntB3tdKTf62a97G0Ng3uU9dblB/P7zRDtKoFu6E4NMwnuTyPGOv1Vik7uaEOuZVCTRUQmNiHmbhd55n5UalwZtHDyafrCemRdTa+TCrTdqszIr+zyxyg0uhnX2EC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299579; c=relaxed/simple;
	bh=OS3008zGLwUOKKIsK3vtpNAmQKxbJKFl5BJxi/9EXAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OvItmXbOv3cqd3jmQyDSJCLK/LqVuDRvMlp9uBNcEgqyMvmdq/vf1DNZUPgR6seh6fG+yOxzedFpFDTx1jc2h+UcWD6Q4Fv9mtGdGTRMXYW5MoulXWuHsBuB4lFSw5PIF3xHbmbnNkA4fCunKn53rFfCrJAgbMFHfBMyJrkdnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgfNeMy0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgfNeMy0"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba15e384c7so34599855ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779299576; x=1779904376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fAbeuY/X7a3OvYFxc1eBN5OzRIWxaMmyQceN+ybrxw=;
        b=DgfNeMy0NOWbJ5qgE5vZTy/ZUSHEmkrwKBGrzy6Ow8u7lpjFNw/eVFaTNPT3rO+hXv
         JYFtvNQIXdN1PV3xhvc1XGny2q6/8+uvF4W5cjhwzYwNwRhgriqzCrhwO7mAFd1KhdKs
         q2JZc82gWQ0CXJn5CbfmdYg4IaUhhBjG+SE2R+1SZ0JBqkf3zCnlEf8vsDIpMkoYe6ol
         S9dyt4gPPgyMAP9MYcIA5dl3JP2dWt0pDA31+dhb1mRGce2HZVf3hJpAW3pwYdWl9Shw
         Y0xwCXoChXedJiPxvjdu4Psv3hyLHAGhh07r7KSeKhSWsAIHHdeavoK25XgoEcj7sTXt
         3ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299576; x=1779904376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fAbeuY/X7a3OvYFxc1eBN5OzRIWxaMmyQceN+ybrxw=;
        b=dCgkHdwvh6v3QfjyA+pZ0jK7cHppl+R65sIwmQfc+fAjKq3vqiamaSCwtYxyaCC9Ik
         P5o3qLAtJ9xYbGEDamerHNZEfIOrUFF1cFodqXcgl75SFjsjRnZ5EYGtR+gRS5EV/XrZ
         9i/DGZ0X9IKN8ShMqErmX9v8fbOAOJiSk3BfeBHOZiB0j1fqZKt/kdiD8WFCrg7PvBBO
         Ay6lySY3g/szHXvKjeD4yeQYeOQWkgEOjDodjEf2SfwT7ODYncLw5pnUwNM+TQak24qr
         J0B+GRQb+OMPuk0Lo/t2Vb+l/hr3s4lN5rKvLUSN6XTkAjP4aM2P4ksVeejh1o24sZmg
         C2Ow==
X-Forwarded-Encrypted: i=1; AFNElJ+CntkPYgMFhXf2xgcPRK1Haq3mdPCoVc9J6qXLickZUbYU3T7lXl3VqGSJzbwAp3aq6OKuQb1X5IUE3zCo+lCD@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFkHvWPh5pbnOboGV/8QgxLDqhXKwE/eUqepsnvpBdY4ns7fe
	H4ufdeG3VKJrrQJp1DkisUwJ+XZoDzFCrTeRrU/DX0GT0XAuat+eK7JZq82BNT71svKuJwY/JIE
	czFH8Qw==
X-Received: from pliq11.prod.google.com ([2002:a17:903:390b:b0:2bc:e1c5:af57])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db09:b0:2b9:fc68:d8bc
 with SMTP id d9443c01a7336-2bd7e247d55mr251402265ad.0.1779299576148; Wed, 20
 May 2026 10:52:56 -0700 (PDT)
Date: Wed, 20 May 2026 10:47:44 -0700
In-Reply-To: <20260520175038.3039546-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520175038.3039546-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520175038.3039546-2-ctshao@google.com>
Subject: [PATCH 1/2] perf stat: Add aggr_nr metric parser support
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, sandipan.das@amd.com, 
	leo.yan@arm.com, thomas.falcon@intel.com, yang.lee@linux.alibaba.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce the `aggr_nr` function to the metric expression parser.
`aggr_nr` allows metric formulas to dynamically utilize the number of
aggregated targets (`aggr->nr`) instead of relying on the static
`source_count` (which represents the static socket or node count).

This adds the `AGGR_NR` token to the lexer and parser, updates the
expression parsing context helpers to store `aggr_nr`, and feeds
`aggr->nr` from the aggregation structure in `prepare_metric`.
---
 tools/perf/util/expr.c        | 27 +++++++++++++++++++++++----
 tools/perf/util/expr.h        |  4 ++++
 tools/perf/util/expr.l        |  1 +
 tools/perf/util/expr.y        | 24 +++++++++++++++++-------
 tools/perf/util/stat-shadow.c |  4 +++-
 5 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 644769e92708..8d00805f93c4 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -27,6 +27,7 @@ struct expr_id_data {
 		struct {
 			double val;
 			int source_count;
+			int aggr_nr;
 		} val;
 		struct {
 			double val;
@@ -151,8 +152,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 }

 /* Caller must make sure id is allocated */
-int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
-				  double val, int source_count)
+int expr__add_id_val_source_count_aggr_nr(struct expr_parse_ctx *ctx, const char *id,
+					  double val, int source_count, int aggr_nr)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
@@ -163,6 +164,7 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 		return -ENOMEM;
 	data_ptr->val.val = val;
 	data_ptr->val.source_count = source_count;
+	data_ptr->val.aggr_nr = aggr_nr;
 	data_ptr->kind = EXPR_ID_DATA__VALUE;

 	ret = hashmap__set(ctx->ids, id, data_ptr, &old_key, &old_data);
@@ -177,6 +179,14 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 	return ret;
 }

+/* Caller must make sure id is allocated */
+int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
+				  double val, int source_count)
+{
+	return expr__add_id_val_source_count_aggr_nr(ctx, id, val, source_count, 1);
+}
+
+
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
@@ -390,10 +400,19 @@ double expr_id_data__value(const struct expr_id_data *data)

 double expr_id_data__source_count(const struct expr_id_data *data)
 {
-	assert(data->kind == EXPR_ID_DATA__VALUE);
-	return data->val.source_count;
+	if (data->kind == EXPR_ID_DATA__VALUE)
+		return data->val.source_count;
+	return 1.0;
 }

+double expr_id_data__aggr_nr(const struct expr_id_data *data)
+{
+	if (data->kind == EXPR_ID_DATA__VALUE)
+		return data->val.aggr_nr;
+	return 1.0;
+}
+
+
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
 {
 	double result = NAN;
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index c0cec29ddc29..865bb63cdb03 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -37,6 +37,8 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 				double val, int source_count);
+int expr__add_id_val_source_count_aggr_nr(struct expr_parse_ctx *ctx, const char *id,
+					double val, int source_count, int aggr_nr);
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data);
@@ -53,6 +55,8 @@ int expr__find_ids(const char *expr, const char *one,

 double expr_id_data__value(const struct expr_id_data *data);
 double expr_id_data__source_count(const struct expr_id_data *data);
+double expr_id_data__aggr_nr(const struct expr_id_data *data);
+
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx);
 double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
 double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index a2fc43159ee9..f16ccff278d0 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -121,6 +121,7 @@ min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
 source_count	{ return SOURCE_COUNT; }
+aggr_nr		{ return AGGR_NR; }
 has_event	{ return HAS_EVENT; }
 strcmp_cpuid_str	{ return STRCMP_CPUID_STR; }
 NaN		{ return nan_value(yyscanner); }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index e364790babb5..e20f649354cf 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -41,7 +41,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
 	} ids;
 }

-%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT STRCMP_CPUID_STR EXPR_ERROR
+%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT AGGR_NR HAS_EVENT STRCMP_CPUID_STR EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -87,8 +87,14 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 	return result;
 }

+enum expr_id_kind {
+	EXPR_ID_KIND__VALUE,
+	EXPR_ID_KIND__SOURCE_COUNT,
+	EXPR_ID_KIND__AGGR_NR,
+};
+
 static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
-			    bool compute_ids, bool source_count)
+			    bool compute_ids, enum expr_id_kind kind)
 {
 	struct ids result;

@@ -101,9 +107,12 @@ static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,

 		result.val = NAN;
 		if (expr__resolve_id(ctx, id, &data) == 0) {
-			result.val = source_count
-				? expr_id_data__source_count(data)
-				: expr_id_data__value(data);
+			if (kind == EXPR_ID_KIND__SOURCE_COUNT)
+				result.val = expr_id_data__source_count(data);
+			else if (kind == EXPR_ID_KIND__AGGR_NR)
+				result.val = expr_id_data__aggr_nr(data);
+			else
+				result.val = expr_id_data__value(data);
 		}
 		result.ids = NULL;
 		free(id);
@@ -201,8 +210,9 @@ expr: NUMBER
 	$$.val = $1;
 	$$.ids = NULL;
 }
-| ID				{ $$ = handle_id(ctx, $1, compute_ids, /*source_count=*/false); }
-| SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, /*source_count=*/true); }
+| ID				{ $$ = handle_id(ctx, $1, compute_ids, EXPR_ID_KIND__VALUE); }
+| SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, EXPR_ID_KIND__SOURCE_COUNT); }
+| AGGR_NR '(' ID ')'		{ $$ = handle_id(ctx, $3, compute_ids, EXPR_ID_KIND__AGGR_NR); }
 | HAS_EVENT '(' ID ')'
 {
 	$$.val = expr__has_event(ctx, compute_ids, $3);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index bc2d44df7baf..e375f6f942be 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -53,6 +53,7 @@ static int prepare_metric(struct perf_stat_config *config,

 	for (i = 0; metric_events[i]; i++) {
 		int source_count = 0, tool_aggr_idx;
+		int aggr_nr = 1;
 		bool is_tool_time =
 			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
 		struct perf_stat_evsel *ps = metric_events[i]->stats;
@@ -104,13 +105,14 @@ static int prepare_metric(struct perf_stat_config *config,
 				}
 				if (!source_count)
 					source_count = evsel__source_count(metric_events[i]);
+				aggr_nr = aggr->nr ?: 1;
 			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
 			return -ENOMEM;

-		expr__add_id_val_source_count(pctx, n, val, source_count);
+		expr__add_id_val_source_count_aggr_nr(pctx, n, val, source_count, aggr_nr);
 	}

 	for (int j = 0; metric_refs && metric_refs[j].metric_name; j++) {
--
2.54.0.669.g59709faab0-goog

