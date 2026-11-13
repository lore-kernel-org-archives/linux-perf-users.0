Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606593;
	b=UX7YBvN1o2VQ8+g2QqeA8HJPK4xWh6ujh0afXFpVvuaKR27UT47Rb3dj9d6OxbKwkZlA
	 2XtO0NLkncLzpEIFxF9YxJHv3ywnlcR2AO4/bdZRijfHVT27AXluu8cqIm6gNUtgtzTmg
	 6O3qMYSnWb+9PGW+c2HD9v62xDd6MxlWre0zyoGtaOSmMn9sYiKDr1yg3tz2Lu7rUAXKH
	 oMnpLa1GabW3fDGCPxFgm39l8hTDFLf+iLzo1UeFszLzl3pDkqmuYeUfX+5yZOJfCu98L
	 wLPQcCFp/uZLvui3URMnCz7V0MKx/GhJmk0tzdEynntVAI3zlIPuzII9fwlv6uuG0tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=c+7zLXOrmUphNbf9h9h/8yXxs9IXtStNi40R1Gp1tC8=;
	b=VKGgabthuQBx2R/gI6RGdAEsoxU0vpzFFUGfGzvezWZxZkhuovZsnnNJ8p8owu6gHgS9
	 VudjsMxvFpQKBoQG736EuFxEz04/0IpPaEsH1NaFi3hLlBRtf5kQ0p8LAFkoJA9gmP0g3
	 1PkA/EHAxS5UIe6eYKepj65BT5/xWC85MKmQNcARvRhtBllK1NOTY+xVBOkrtJsNKXVGu
	 YJtXBRfMRNvGvNptS9mLTYXHBZrX7uBCJYNWytlAlbm1es2bkPe/l493ZZpYaxjsOiiTt
	 ocLoiQYsf38bf3D1IyW8eFpA1Gwfjpcv3QIBM870c3zA4X4qFe7sBtmGVIBZTd+PX4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZEY76RZS;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC160A6F6A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39DC160A6F6A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZEY76RZS
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b3b5b49cabso1350460c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606591; x=1795211391; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+7zLXOrmUphNbf9h9h/8yXxs9IXtStNi40R1Gp1tC8=;
        b=ZEY76RZSMKUoh5ZrzbnM2pYQrc2VTPKK5J+KBiwEX/PE+p6sUlobAfiiTtbSYjVV5O
         sXG33iNISwQRvAhZSB9HvD/pULVVokjMx1toJNViMNp3jMhabF2V5HytLDNiMyPE4ufI
         RnxmBjFBEUnclmucIC6dg+WH/5BifimOVFgEKS3aXCJ12yPOoQhumercvp1NUw2OdN/o
         keR+lZrx/QGqDRHpHnH/d9pLl0YB67Nbw2TMgPPRfeeLrfHWQP5+7SgBpXca8Ra9nwzW
         +iloPIay1EvxIsURw/tXtXP3YaRCyLYLDgitQIPXHuSoo80cRMDAViUfCfFAgoeJoRYc
         LeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606591; x=1795211391;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+7zLXOrmUphNbf9h9h/8yXxs9IXtStNi40R1Gp1tC8=;
        b=g2PNwAd7d9PEJvmC2K3FmdEgJKRASXTnlK9JCu0IO5ufMN3SoMjmOWC65Or0pXbNT2
         Z58A/6BpnZ5FIhLRitwDn/RGHeBmeAyUlHBKwWMaPKPRzAUnieWkz9wo9IgvnHv0Jwmk
         0nf8E5TUKf+1bie2fMrQFXuG+yVf/kEnkn1h9SOBtpm5TA4PcAXUxmsahJHQHqOuvgYr
         6dvVh+D1e8pAxPBJj8dFPCPZpeKVT3JFVnlsjpprpAJCUM/ZunxJtEUsFuRh20b8g/nZ
         FMfbmZAupMJKLemcQ8qMAtUDLgRVWJhGt73iJHISbh3/NG/yDMIfDYWt8x2sr+C5Sp5x
         pwYw==
X-Forwarded-Encrypted: i=1; AL+hErFnDP8iKD0MB/TuA+MxRwvUsMN6e+azDxFnIlDwYdB60uVnnS92P2XfOg8uOgS2GgM9uNutgWCXmeCEfq11Krak@vger.kernel.org
X-Gm-Message-State: APuU4Z+iNHFzm6GNfyEEO8xw+S2f5n+xl19wq5MCTot/cL3DB+vBuQKH
	8hWmFdJ+0CjNquJ4Ti+tkHCAhRkw01cCyu60ttkwCOFaazyy9SsBvnvdX341u0hGbYS26nbEKYM
	vroolNZnGTQ==
X-Received: from dlbph19.prod.google.com ([2002:a05:7022:3713:b0:1b2:649c:7a14])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b04b:20b0:1b5:e9d:c662
 with SMTP id a92af1059eb24-1b50e9dd144mr1341818c88.9.1794606590908; Fri, 13
 Nov 2026 13:49:50 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:39 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-16-irogers@google.com>
Subject: [PATCH v1 15/26] perf expr: Use generic hashmap for expr_ids
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert expr_parse_ctx::ids and ids__* helpers across util/expr.{c,h,y},
util/metricgroup.c, tests/expr.c, and tests/pmu-events.c to
DECLARE_HASHMAP(expr_ids_map, const char *, struct expr_id_data *).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       |  2 +-
 tools/perf/tests/pmu-events.c | 16 +++---
 tools/perf/util/expr.c        | 99 +++++++++++++++++------------------
 tools/perf/util/expr.h        | 18 ++++---
 tools/perf/util/expr.y        |  2 +-
 tools/perf/util/metricgroup.c | 28 +++++-----
 6 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 726cf8d4da28..a2c7dc4d71c9 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -15,7 +15,7 @@
 
 static int test_ids_union(void)
 {
-	struct hashmap *ids1, *ids2;
+	struct expr_ids_map *ids1, *ids2;
 
 	/* Empty union. */
 	ids1 = ids__new();
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index e6e4f4cf1fa2..42862501f0bf 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -964,10 +964,10 @@ static struct test_metric metrics[] = {
 static int metric_parse_fake(const char *metric_name, const char *str)
 {
 	struct expr_parse_ctx *ctx;
-	struct hashmap_entry *cur;
+	const char *key;
+	struct expr_id_data *val;
 	double result;
 	int ret = -1;
-	size_t bkt;
 	int i;
 
 	pr_debug("parsing '%s': '%s'\n", metric_name, str);
@@ -989,11 +989,11 @@ static int metric_parse_fake(const char *metric_name, const char *str)
 	 * make them unique.
 	 */
 	i = 1;
-	hashmap__for_each_entry(ctx->ids, cur, bkt)
-		expr__add_id_val(ctx, strdup(cur->pkey), i++);
+	hashmap__for_each(ctx->ids, key, val)
+		expr__add_id_val(ctx, strdup(key), i++);
 
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		if (check_parse_fake(cur->pkey)) {
+	hashmap__for_each(ctx->ids, key, val) {
+		if (check_parse_fake(key)) {
 			pr_err("check_parse_fake failed\n");
 			goto out;
 		}
@@ -1006,8 +1006,8 @@ static int metric_parse_fake(const char *metric_name, const char *str)
 		 * resolve divide by zero issues.
 		 */
 		i = 1024;
-		hashmap__for_each_entry(ctx->ids, cur, bkt)
-			expr__add_id_val(ctx, strdup(cur->pkey), i--);
+		hashmap__for_each(ctx->ids, key, val)
+			expr__add_id_val(ctx, strdup(key), i--);
 		if (expr__parse(&result, ctx, str)) {
 			pr_err("expr__parse failed for %s\n", metric_name);
 			/* The following have hard to avoid divide by zero. */
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index ac0243576def..d548ae5a4ec9 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -64,48 +64,46 @@ static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
 	return !strcmp((const char *)key1, (const char *)key2);
 }
 
-struct hashmap *ids__new(void)
+struct expr_ids_map *ids__new(void)
 {
-	return hashmap__new(key_hash, key_equal, NULL);
+	return expr_ids_map__new(key_hash, key_equal, NULL);
 }
 
-void ids__free(struct hashmap *ids)
+void ids__free(struct expr_ids_map *ids)
 {
-	struct hashmap_entry *cur;
-	size_t bkt;
+	const char *key;
+	struct expr_id_data *val;
 
 	if (ids == NULL)
 		return;
 
-	hashmap__for_each_entry(ids, cur, bkt) {
-		zfree(&cur->pkey);
-		zfree(&cur->pvalue);
+	hashmap__for_each(ids, key, val) {
+		free((char *)key);
+		free(val);
 	}
 
-	hashmap__free(ids);
+	expr_ids_map__free(ids);
 }
 
-int ids__insert(struct hashmap *ids, const char *id)
+int ids__insert(struct expr_ids_map *ids, const char *id)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
-	char *old_key = NULL;
+	const char *old_key = NULL;
 	int ret;
 
 	ret = hashmap__set(ids, id, data_ptr, &old_key, &old_data);
 	if (ret)
 		free(data_ptr);
-	free(old_key);
+	free((char *)old_key);
 	free(old_data);
 	return ret;
 }
 
-struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
+struct expr_ids_map *ids__union(struct expr_ids_map *ids1, struct expr_ids_map *ids2)
 {
-	size_t bkt;
-	struct hashmap_entry *cur;
+	const char *key, *old_key = NULL;
+	struct expr_id_data *val, *old_data = NULL;
 	int ret;
-	struct expr_id_data *old_data = NULL;
-	char *old_key = NULL;
 
 	if (!ids1)
 		return ids2;
@@ -113,24 +111,24 @@ struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
 	if (!ids2)
 		return ids1;
 
-	if (hashmap__size(ids1) <  hashmap__size(ids2)) {
-		struct hashmap *tmp = ids1;
+	if (hashmap__size(ids1) < hashmap__size(ids2)) {
+		struct expr_ids_map *tmp = ids1;
 
 		ids1 = ids2;
 		ids2 = tmp;
 	}
-	hashmap__for_each_entry(ids2, cur, bkt) {
-		ret = hashmap__set(ids1, cur->key, cur->value, &old_key, &old_data);
-		free(old_key);
+	hashmap__for_each(ids2, key, val) {
+		ret = hashmap__set(ids1, key, val, &old_key, &old_data);
+		free((char *)old_key);
 		free(old_data);
 
 		if (ret) {
-			hashmap__free(ids1);
-			hashmap__free(ids2);
+			expr_ids_map__free(ids1);
+			expr_ids_map__free(ids2);
 			return NULL;
 		}
 	}
-	hashmap__free(ids2);
+	expr_ids_map__free(ids2);
 	return ids1;
 }
 
@@ -151,7 +149,7 @@ int expr__add_id_val_source_count_aggr_nr(struct expr_parse_ctx *ctx, const char
 					  double val, int source_count, int aggr_nr)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
-	char *old_key = NULL;
+	const char *old_key = NULL;
 	int ret;
 
 	data_ptr = malloc(sizeof(*data_ptr));
@@ -170,7 +168,7 @@ int expr__add_id_val_source_count_aggr_nr(struct expr_parse_ctx *ctx, const char
 		data_ptr->val.source_count += old_data->val.source_count;
 		data_ptr->val.aggr_nr += old_data->val.aggr_nr;
 	}
-	free(old_key);
+	free((char *)old_key);
 	free(old_data);
 	return ret;
 }
@@ -185,7 +183,7 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
-	char *old_key = NULL;
+	const char *old_key = NULL;
 	char *name;
 	int ret;
 
@@ -210,13 +208,15 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 	data_ptr->kind = EXPR_ID_DATA__REF;
 
 	ret = hashmap__set(ctx->ids, name, data_ptr, &old_key, &old_data);
-	if (ret)
+	if (ret) {
 		free(data_ptr);
+		free(name);
+	}
 
 	pr_debug2("adding ref metric %s: %s\n",
 		  ref->metric_name, ref->metric_expr);
 
-	free(old_key);
+	free((char *)old_key);
 	free(old_data);
 	return ret;
 }
@@ -232,12 +232,11 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
 			 struct expr_parse_ctx *needles)
 {
-	struct hashmap_entry *cur;
-	size_t bkt;
-	struct expr_id_data *data;
+	const char *key;
+	struct expr_id_data *val, *data;
 
-	hashmap__for_each_entry(needles->ids, cur, bkt) {
-		if (expr__get_id(haystack, cur->pkey, &data))
+	hashmap__for_each(needles->ids, key, val) {
+		if (expr__get_id(haystack, key, &data))
 			return false;
 	}
 	return true;
@@ -285,10 +284,10 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
 {
 	struct expr_id_data *old_val = NULL;
-	char *old_key = NULL;
+	const char *old_key = NULL;
 
 	hashmap__delete(ctx->ids, id, &old_key, &old_val);
-	free(old_key);
+	free((char *)old_key);
 	free(old_val);
 }
 
@@ -300,7 +299,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 	if (!ctx)
 		return NULL;
 
-	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
+	ctx->ids = expr_ids_map__new(key_hash, key_equal, NULL);
 	if (!ctx->ids) {
 		free(ctx);
 		return NULL;
@@ -311,30 +310,30 @@ struct expr_parse_ctx *expr__ctx_new(void)
 
 void expr__ctx_clear(struct expr_parse_ctx *ctx)
 {
-	struct hashmap_entry *cur;
-	size_t bkt;
+	const char *key;
+	struct expr_id_data *val;
 
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		zfree(&cur->pkey);
-		zfree(&cur->pvalue);
+	hashmap__for_each(ctx->ids, key, val) {
+		free((char *)key);
+		free(val);
 	}
 	hashmap__clear(ctx->ids);
 }
 
 void expr__ctx_free(struct expr_parse_ctx *ctx)
 {
-	struct hashmap_entry *cur;
-	size_t bkt;
+	const char *key;
+	struct expr_id_data *val;
 
 	if (!ctx)
 		return;
 
 	zfree(&ctx->sctx.user_requested_cpu_list);
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		zfree(&cur->pkey);
-		zfree(&cur->pvalue);
+	hashmap__for_each(ctx->ids, key, val) {
+		free((char *)key);
+		free(val);
 	}
-	hashmap__free(ctx->ids);
+	expr_ids_map__free(ctx->ids);
 	free(ctx);
 }
 
@@ -438,7 +437,7 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 	struct evlist *tmp;
 	double ret;
 
-	if (hashmap__find(ctx->ids, id, /*value=*/NULL))
+	if (hashmap__find(ctx->ids, id, /*value_ptr=*/NULL))
 		return 1.0;
 
 	if (!compute_ids)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index ed12e4007d2d..57edcb3f70ea 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,9 +2,13 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-struct hashmap;
+#include "hashmap.h"
+
+struct expr_id_data;
 struct metric_ref;
 
+DECLARE_HASHMAP(expr_ids_map, const char *, struct expr_id_data *);
+
 struct expr_scanner_ctx {
 	char *user_requested_cpu_list;
 	int runtime;
@@ -13,20 +17,18 @@ struct expr_scanner_ctx {
 };
 
 struct expr_parse_ctx {
-	struct hashmap	*ids;
+	struct expr_ids_map	*ids;
 	struct expr_scanner_ctx sctx;
 };
 
-struct expr_id_data;
-
-struct hashmap *ids__new(void);
-void ids__free(struct hashmap *ids);
-int ids__insert(struct hashmap *ids, const char *id);
+struct expr_ids_map *ids__new(void);
+void ids__free(struct expr_ids_map *ids);
+int ids__insert(struct expr_ids_map *ids, const char *id);
 /*
  * Union two sets of ids (hashmaps) and construct a third, freeing ids1 and
  * ids2.
  */
-struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2);
+struct expr_ids_map *ids__union(struct expr_ids_map *ids1, struct expr_ids_map *ids2);
 
 struct expr_parse_ctx *expr__ctx_new(void);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index e20f649354cf..d39ba27d75bc 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -29,7 +29,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
 		 * When creating ids, holds the working set of event ids. NULL
 		 * implies the set is empty.
 		 */
-		struct hashmap *ids;
+		struct expr_ids_map *ids;
 		/*
 		 * The metric value. When not creating ids this is the value
 		 * read from a counter, a constant or some computed value. When
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 779fe56fe8d0..41887fad4968 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -289,7 +289,7 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
  * @metric_evlist: the list of perf events.
  * @out_metric_events: holds the created metric events array.
  */
-static int setup_metric_events(const char *pmu, struct hashmap *ids,
+static int setup_metric_events(const char *pmu, struct expr_ids_map *ids,
 			       struct evlist *metric_evlist,
 			       struct evsel ***out_metric_events)
 {
@@ -563,16 +563,16 @@ static int metricgroup__build_event_string(struct strbuf *events,
 					   const char *modifier,
 					   bool group_events)
 {
-	struct hashmap_entry *cur;
-	size_t bkt;
+	const char *id;
+	struct expr_id_data *val;
 	bool no_group = true, has_tool_events = false;
 	bool tool_events[TOOL_PMU__EVENT_MAX] = {false};
 	int ret = 0;
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		const char *sep, *rsep, *id = cur->pkey;
+	hashmap__for_each(ctx->ids, id, val) {
+		const char *sep, *rsep;
 		enum tool_pmu_event ev;
 
 		pr_debug("found event %s\n", id);
@@ -748,8 +748,8 @@ static int resolve_metric(struct list_head *metric_list,
 			  const struct visited_metric *visited,
 			  const struct pmu_metrics_table *table)
 {
-	struct hashmap_entry *cur;
-	size_t bkt;
+	const char *key;
+	struct expr_id_data *val;
 	struct to_resolve {
 		/* The metric to resolve. */
 		struct pmu_metric pm;
@@ -765,10 +765,10 @@ static int resolve_metric(struct list_head *metric_list,
 	 * Iterate all the parsed IDs and if there's a matching metric and it to
 	 * the pending array.
 	 */
-	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
+	hashmap__for_each(root_metric->pctx->ids, key, val) {
 		struct pmu_metric pm;
 
-		if (pmu_metrics_table__find_metric(table, pmu, cur->pkey,
+		if (pmu_metrics_table__find_metric(table, pmu, key,
 						   metricgroup__find_metric_callback,
 						   &pm) != PMU_METRICS__NOT_FOUND) {
 			pending = realloc(pending,
@@ -777,7 +777,7 @@ static int resolve_metric(struct list_head *metric_list,
 				return -ENOMEM;
 
 			memcpy(&pending[pending_cnt].pm, &pm, sizeof(pm));
-			pending[pending_cnt].key = cur->pkey;
+			pending[pending_cnt].key = key;
 			pending_cnt++;
 		}
 	}
@@ -1229,8 +1229,8 @@ static void find_tool_events(const struct list_head *metric_list,
 static int build_combined_expr_ctx(const struct list_head *metric_list,
 				   struct expr_parse_ctx **combined)
 {
-	struct hashmap_entry *cur;
-	size_t bkt;
+	const char *key;
+	struct expr_id_data *val;
 	struct metric *m;
 	char *dup;
 	int ret;
@@ -1241,8 +1241,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 
 	list_for_each_entry(m, metric_list, nd) {
 		if (!m->group_events && !m->modifier) {
-			hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
-				dup = strdup(cur->pkey);
+			hashmap__for_each(m->pctx->ids, key, val) {
+				dup = strdup(key);
 				if (!dup) {
 					ret = -ENOMEM;
 					goto err_out;
-- 
2.56.1.703.gf848ed807c-goog

