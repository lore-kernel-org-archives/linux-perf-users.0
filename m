Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF3334C05
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394513; cv=none; b=RndJVIfuJCWnkUTBQQA9Z8wjQVMZpcJS0vo+fW4lUq5HC88yGNaV0MYJ/RVNehwayNrGpolOIHPEmoc6jEjRUZUFdafm2YE6EW7Yajx3sKs7d/Mylm6jqwzANe/HQ2Di8/4i5wh6pcY0ubh8ZDWGPgVMMDl++exdTYA005smnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394513; c=relaxed/simple;
	bh=tWsiwu15VnarFDruHYWrHHWkVFpU9VGKDkGj9dx/iWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FS0S1v9LAP6OttIEroHC2sPNtinWkLRnsnTKHbpACo9Eeyn912yzUBzgL3ZmIbKDbycArZlZl2ZV1Qzyh1+AKNcovyM2M1A7TDqv4pIH/kUPV2SpJgV/kuOIUgyBE+zxmat/nvB5eBIedNni2E343GYRIa1CLxH7NH24UYCMrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udBehjyZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udBehjyZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso73315795ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779394511; x=1779999311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SJnEbRx6oHTv348uZbIC/z7mpNIK5u7l+aOQXx1vq8=;
        b=udBehjyZtXH2EHROtdllw3IzEviaFFoF+m6kIy3e+OMkyx+TEUUYTBGxPUL/pE4IHV
         rvAM7D3+LrwiS7FBdXX1QCKjJaUklDUtg4T3pzXg6Edk65lSPLnaVqcXa2IaVkfaKS/j
         S/xXc/BHTNIds2ZQ+ApraBl8P8GwitF3W6jT81z1EBdQHpzNvfSqck40tTSjsL/0hqrL
         96fysogrfFaHR5al6L9vsdLWdciTG5qe8SyCSHdeUh99vjx2BcKb6Sktz7okhJZAOdsv
         lZ1jhOnk7ERL8SDGe003FT2PCYrSJ5wdXDQJL9lI4GhqmHFnrpjcXBSLL149C9MJGEcN
         Dy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779394511; x=1779999311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SJnEbRx6oHTv348uZbIC/z7mpNIK5u7l+aOQXx1vq8=;
        b=eNAGeN1xUB3+VRhEA3B8jz8URX8q6c7j1hVcr2nib7POXjL5pPFvh7fnf/jfycJ7vV
         tU+JpiqOwb4yZVHTqg7/xuleldWuUU+gn33vulG9LkiCrhFSNZm4MTaJkbP03XrHm5vB
         k6wJUvucVZTalQeCvhKINGzHoZsc7mjTTUKIDotTbZLyulcaO3Ln43qS3R6I1ex4rBMm
         llmDwPzVSwWsp2aIIclbYO38JRJpXJQ6VtBIlLqC1pSCVuRikOiyw7PlcgAjkzmQTo2+
         FWZeahGIB1BiFDqC+qrVErslvY2T5IM3J9V0Q+ibiOJZO5a9pUPaMDosw+dberqJt5gd
         PeVA==
X-Forwarded-Encrypted: i=1; AFNElJ8ofchEUTQh0khz9nbyQshvrhrdGZ3GIoCqosWYH8IR0CNdJkQggwzncdex2XKpjbv6VojjeXMsm89+kbYmNuEK@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJNlmgjt1xzhGDbsj+lllqkBs2qy+9Jbni+jJ1jj7p1kVVQP0
	2edpscw05Pnw2jPj7s5jG5cZfun3zneAiOwNyIj0JcT3V6vnD99G9qXmQ4Z9JE+pGgAQuiNl344
	aK13JFw==
X-Received: from pls13.prod.google.com ([2002:a17:903:448d:b0:2bd:93e0:bc08])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1245:b0:2bd:8c9a:a684
 with SMTP id d9443c01a7336-2beb069c63cmr4169555ad.4.1779394511286; Thu, 21
 May 2026 13:15:11 -0700 (PDT)
Date: Thu, 21 May 2026 13:15:04 -0700
In-Reply-To: <20260521201505.124690-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521201505.124690-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521201505.124690-2-ctshao@google.com>
Subject: [PATCH v3 1/2] perf stat: Add aggr_nr metric parser support
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	sandipan.das@amd.com, leo.yan@arm.com, thomas.falcon@intel.com, 
	yang.lee@linux.alibaba.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the `aggr_nr` function to the metric expression parser.
`aggr_nr` allows metric formulas to dynamically utilize the number of
aggregated targets (`aggr->nr`) instead of relying on the static
`source_count` (which represents the static socket or node count).

This adds the `AGGR_NR` token to the lexer and parser, updates the
expression parsing context helpers to store `aggr_nr`, and feeds
`aggr->nr` from the aggregation structure in `prepare_metric`.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/util/expr.c        | 26 ++++++++++++++++++++++----
 tools/perf/util/expr.h        |  6 +++++-
 tools/perf/util/expr.l        |  1 +
 tools/perf/util/expr.y        | 24 +++++++++++++++++-------
 tools/perf/util/stat-shadow.c |  6 +++++-
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 644769e92708..232998fef72b 100644
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
@@ -171,12 +173,20 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 	} else if (old_data) {
 		data_ptr->val.val += old_data->val.val;
 		data_ptr->val.source_count += old_data->val.source_count;
+		data_ptr->val.aggr_nr += old_data->val.aggr_nr;
 	}
 	free(old_key);
 	free(old_data);
 	return ret;
 }

+/* Caller must make sure id is allocated */
+int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
+				  double val, int source_count)
+{
+	return expr__add_id_val_source_count_aggr_nr(ctx, id, val, source_count, 1);
+}
+
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
@@ -390,8 +400,16 @@ double expr_id_data__value(const struct expr_id_data *data)

 double expr_id_data__source_count(const struct expr_id_data *data)
 {
-	assert(data->kind == EXPR_ID_DATA__VALUE);
-	return data->val.source_count;
+	if (data->kind == EXPR_ID_DATA__VALUE)
+		return data->val.source_count;
+	return 1.0;
+}
+
+double expr_id_data__aggr_nr(const struct expr_id_data *data)
+{
+	if (data->kind == EXPR_ID_DATA__VALUE)
+		return data->val.aggr_nr;
+	return 1.0;
 }

 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index c0cec29ddc29..ed12e4007d2d 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -36,7 +36,9 @@ void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
-				double val, int source_count);
+				  double val, int source_count);
+int expr__add_id_val_source_count_aggr_nr(struct expr_parse_ctx *ctx, const char *id,
+					  double val, int source_count, int aggr_nr);
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
index bc2d44df7baf..c17373bb0e1e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -53,6 +53,7 @@ static int prepare_metric(struct perf_stat_config *config,

 	for (i = 0; metric_events[i]; i++) {
 		int source_count = 0, tool_aggr_idx;
+		int aggr_nr = 1;
 		bool is_tool_time =
 			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
 		struct perf_stat_evsel *ps = metric_events[i]->stats;
@@ -89,6 +90,7 @@ static int prepare_metric(struct perf_stat_config *config,
 			 */
 			val = NAN;
 			source_count = 0;
+			aggr_nr = 0;
 		} else {
 			struct perf_stat_aggr *aggr =
 				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
@@ -96,6 +98,7 @@ static int prepare_metric(struct perf_stat_config *config,
 			if (aggr->counts.run == 0) {
 				val = NAN;
 				source_count = 0;
+				aggr_nr = 0;
 			} else {
 				val = aggr->counts.val;
 				if (is_tool_time) {
@@ -104,13 +107,14 @@ static int prepare_metric(struct perf_stat_config *config,
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
2.54.0.746.g67dd491aae-goog

