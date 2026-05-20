Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973383FB7D5
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300309; cv=none; b=dy3VJuJJMLsMRhsE2/rXQ2R6M1YE29s81/0agRHjAr4CBtWSDGScPWAuhAuJU5FVVJIUbndqrkKNb9LL1OJ9aCssNP+pXM7o7qABcb07MN6BAi9swXkOA1nbTq0s1ZPI42RbSwc4a8aKSxlksuNfGu/kmRNw0g6RGXz3A2/k5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300309; c=relaxed/simple;
	bh=f8FByKZr79DkT6BMcGWxy/na+rDZcXlfSk9L5YebsZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VfM0X1wWOJ5hnZ58QbM4v02uP38PUGnfpkBo6bHulZ0NZxIQ24zPg0fegApKX64MD94dMaMLA367s7fEgce5NivbFeOyDPUX51wjN8N01Tb+QEG67ymPc1cym7USt+WeIq0wTLyVzH+jNnOf1aTyfMgOwoZnZ+JtXrVJomYRXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehLW3q8J; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehLW3q8J"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3684cb22502so4900396a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300307; x=1779905107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUmAxNctkKaSoLQjMgfyesaS+Z3sI58rwiPX1y4bp8o=;
        b=ehLW3q8JIB/yZIWuBUumckTfSH06Tyb2nigF4a9CWdPcmj/gHwhk8acqZFX9k3PjnO
         VWsRQ8xPC1Q7P77d2HPoxszQ0z6XPiX/xQDXpogNivDpVDzz1FxXbamZjozXF0bXs3ju
         o/Xy9mkTjdCrT6J6JVzOrWzrZU/NekfeHM0W0To7SwkCO+5Kwd3KRsNbYshbpo1U5EhM
         6L873hukvzsakn+8jF5RdpIUOOxnyGsm1LMInEd58T6J3mQXsUaHmmJDrj0taMWO2OuU
         vtoy0t70NRor5G3AjcDdZCDSePtrE6wxfxZOWxZJZtc8Hh5tJ23tyC/RcVUubKhOK2JC
         QDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300307; x=1779905107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUmAxNctkKaSoLQjMgfyesaS+Z3sI58rwiPX1y4bp8o=;
        b=OI4VK382igqITqHtg7CzLVzaRc6xD5RoULXokUG1/uQRpzpT7zamOsrE+m/9WI4tUL
         yPyZDSoxKEN4KDQOe5sWASG+C615Jve1Dq5HhRxAppOh3s2SXJWBinki8stPpbQaKjAu
         wVITS4Ggqyv01kvlOYRneP0/EIv6m0vUYdEI5lN5mVVEb2m/rJXxEtFvGXE3I0XXEhpG
         7+AfYU/5yKbrfDMOFCDlgtBvyxEIV1TDbp2Mrul8tHA+IuLy0mBICIwtv8nacFJ+ecjf
         DD2bte2aKQOx6jkZW/QiJ6NPu/eoBnhIkL0q4ga6/1YiP37uxRSjQ0kiBu2qHEr3Fksc
         qkyg==
X-Forwarded-Encrypted: i=1; AFNElJ8SjFVupiSbOM6sPApeW+GJo0FJqh4oeCurSV8F8rDPwxHoxk2NZNwEaKRYmrumUmpLgs3zVb4Me4lUcohaiu5R@vger.kernel.org
X-Gm-Message-State: AOJu0YztlFBm7LBsqm/dD/qgTfh5nE47zi6+9uOFHRPS6LUtbqyMM/Qh
	DQKb8XAZ9izMhr8HX1MIw5Z498k7lfQu2rQf5ggE9mhu/kDS/8tKlWnjaojUu4gqhEBQ+hDp/8Y
	cU2D+Kw==
X-Received: from pjvf3.prod.google.com ([2002:a17:90a:da83:b0:369:3fa4:a760])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2703:b0:368:7327:6326
 with SMTP id 98e67ed59e1d1-369519e207cmr25146102a91.1.1779300306674; Wed, 20
 May 2026 11:05:06 -0700 (PDT)
Date: Wed, 20 May 2026 10:58:21 -0700
In-Reply-To: <20260520180032.3045144-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520180032.3045144-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520180032.3045144-2-ctshao@google.com>
Subject: [PATCH 1/2] perf stat: Add aggr_nr metric parser support
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, leo.yan@arm.com, 
	thomas.falcon@intel.com, yang.lee@linux.alibaba.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce the `aggr_nr` function to the metric expression parser.
`aggr_nr` allows metric formulas to dynamically utilize the number of
aggregated targets (`aggr->nr`) instead of relying on the static
`source_count` (which represents the static socket or node count).

This adds the `AGGR_NR` token to the lexer and parser, updates the
expression parsing context helpers to store `aggr_nr`, and feeds
`aggr->nr` from the aggregation structure in `prepare_metric`.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
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

