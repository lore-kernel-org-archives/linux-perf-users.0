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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E45C64E7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 05:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CCF246B2
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 05:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBrhGpGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgKRFDs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 00:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRFDr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Nov 2020 00:03:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A52C061A4D
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2020 21:03:47 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id fy23so509037pjb.9
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2020 21:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tNTJUhCWT15w2/EYzNFf2S52gcatU5DiUvwvdv94e+Y=;
        b=oBrhGpGxWLolmj1TvcwH4iT3HR8g3UE1beg/dn64qKHO3QxnHS+eisg35NfrCz82y3
         aON5X5DFFAZllMKFb08pCInDcaSjRxtdJEMVYyYGaog+ImHqQbgVR4vLoTGv6o3lEEfp
         n2Kf0v92UHbMc2uQxuSkaKmomCjcvG7VRvhHMi8dcZUxJJ2gUtcVUPCH6tEKTV+/WOQa
         7v1ZefxiZKC0aX1zvsoVWRbJ3OlHalqdeZfsm7inb7Pulv93SgNYz6+sK4LISO/HfD9E
         IFlXeaEoKMbvHQ/X0Qm8Ty7nuSFe9ZllvSv+6EJ3vozBDelOV2Zk6DkinRSVLydQ9ve+
         q4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tNTJUhCWT15w2/EYzNFf2S52gcatU5DiUvwvdv94e+Y=;
        b=QxR8CbBzOW+0ocGhds4jVGgOzzdEcZUuKKUWty+R7EJ4px5db7ZmwtTsGjhj77B+yM
         4Zfl25Qw1SNZwX6jX68mm8tjlhvBZnL7bQOsJFIllYQRUUBcZXdXpAcXqklWPPdssIPQ
         j0tgcnf5xid+6qsbUwFUJF5R0ATLOeCY5g7G8PWmi0WsbdlaLDZOkl+BRS6o5V1OScsw
         dP4GEJZUz0AU/+1vbe5TTYN5l4SaVh+bASt5kGnHG3aXbJ6rtub6dP7cs+V8DtKNN9mq
         ml+g1po1k8J/iVq+qDWX0OQZJ6fHORD2JabGmPtRQ5TaPpHKZ02ZXiX1RsOM+9MWEusm
         BzRA==
X-Gm-Message-State: AOAM531AiCE44DyioratlqOnA7gwSUyUqKps1R4yqZyIDZEa058y2NiQ
        IgSk/Y2JMGs6znTQJekHhr4JdBtDKO1S
X-Google-Smtp-Source: ABdhPJwlsrjbbL1Y03KGiX0GDREr6XM16RU2GAivRj07ZLXmEYuLDJIvAFuq/7EMGYTAQQ83kWd1JQ99BsIL
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90a:7e94:: with SMTP id
 j20mr2347720pjl.187.1605675827321; Tue, 17 Nov 2020 21:03:47 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:03:34 -0800
In-Reply-To: <20201118050335.2347358-1-irogers@google.com>
Message-Id: <20201118050335.2347358-5-irogers@google.com>
Mime-Version: 1.0
References: <20201118050335.2347358-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 4/5] perf metric: Add utilities to work on ids map.
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

Add utilities to new/free an ids hashmap, as well as to union. Add
testing of the union. Unioning hashmaps will be used when parsing the
metric, if a value is known then the hashmap is unnecessary, otherwise
we need to union together all the event ids to compute their values for
reporting.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 47 ++++++++++++++++++++++
 tools/perf/util/expr.c  | 87 +++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/expr.h  |  9 +++++
 3 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 9d7032041318..7c2a01cf0650 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -6,6 +6,51 @@
 #include <string.h>
 #include <linux/zalloc.h>
 
+static int test_ids_union(void)
+{
+	struct hashmap *ids1, *ids2;
+
+	/* Empty union. */
+	ids1 = ids__new();
+	TEST_ASSERT_VAL("ids__new", ids1);
+	ids2 = ids__new();
+	TEST_ASSERT_VAL("ids__new", ids2);
+
+	ids1 = ids__union(ids1, ids2);
+	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 0);
+
+	/* Union {foo, bar} against {}. */
+	ids2 = ids__new();
+	TEST_ASSERT_VAL("ids__new", ids2);
+
+	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids1, strdup("foo"), NULL), 0);
+	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids1, strdup("bar"), NULL), 0);
+
+	ids1 = ids__union(ids1, ids2);
+	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 2);
+
+	/* Union {foo, bar} against {foo}. */
+	ids2 = ids__new();
+	TEST_ASSERT_VAL("ids__new", ids2);
+	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids2, strdup("foo"), NULL), 0);
+
+	ids1 = ids__union(ids1, ids2);
+	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 2);
+
+	/* Union {foo, bar} against {bar,baz}. */
+	ids2 = ids__new();
+	TEST_ASSERT_VAL("ids__new", ids2);
+	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids2, strdup("bar"), NULL), 0);
+	TEST_ASSERT_EQUAL("ids__insert", ids__insert(ids2, strdup("baz"), NULL), 0);
+
+	ids1 = ids__union(ids1, ids2);
+	TEST_ASSERT_EQUAL("union", (int)hashmap__size(ids1), 3);
+
+	ids__free(ids1);
+
+	return 0;
+}
+
 static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 {
 	double val;
@@ -24,6 +69,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	int ret;
 	struct expr_parse_ctx *ctx;
 
+	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
+
 	ctx = expr__ctx_new();
 	TEST_ASSERT_VAL("expr__ctx_new", ctx);
 	expr__add_id_val(ctx, strdup("FOO"), 1);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index a248d14882cc..1adb6cd202e0 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -59,8 +59,48 @@ static bool key_equal(const void *key1, const void *key2,
 	return !strcmp((const char *)key1, (const char *)key2);
 }
 
-/* Caller must make sure id is allocated */
-int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
+struct hashmap *ids__new(void)
+{
+	return hashmap__new(key_hash, key_equal, NULL);
+}
+
+void ids__free(struct hashmap *ids)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	if (ids == NULL)
+		return;
+
+#ifdef PARSER_DEBUG
+	fprintf(stderr, "freeing ids: ");
+	ids__print(ids);
+	fprintf(stderr, "\n");
+#endif
+
+	hashmap__for_each_entry(ids, cur, bkt) {
+		free((char *)cur->key);
+		free(cur->value);
+	}
+
+	hashmap__free(ids);
+}
+
+void ids__print(struct hashmap *ids)
+{
+	size_t bkt;
+	struct hashmap_entry *cur;
+
+	if (!ids)
+		return;
+
+	hashmap__for_each_entry(ids, cur, bkt) {
+		fprintf(stderr, "key:%s, ", (const char *)cur->key);
+	}
+}
+
+int ids__insert(struct hashmap *ids, const char *id,
+		struct expr_id *parent)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
@@ -70,10 +110,10 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
 	if (!data_ptr)
 		return -ENOMEM;
 
-	data_ptr->parent = ctx->parent;
+	data_ptr->parent = parent;
 	data_ptr->kind = EXPR_ID_DATA__PARENT;
 
-	ret = hashmap__set(ctx->ids, id, data_ptr,
+	ret = hashmap__set(ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
 	if (ret)
 		free(data_ptr);
@@ -82,6 +122,45 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
 	return ret;
 }
 
+struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
+{
+	size_t bkt;
+	struct hashmap_entry *cur;
+	int ret;
+	struct expr_id_data *old_data = NULL;
+	char *old_key = NULL;
+
+	if (!ids1)
+		return ids2;
+
+	if (!ids2)
+		return ids1;
+
+	if (hashmap__size(ids1) <  hashmap__size(ids2)) {
+		struct hashmap *tmp = ids1;
+
+		ids1 = ids2;
+		ids2 = tmp;
+	}
+	hashmap__for_each_entry(ids2, cur, bkt) {
+		ret = hashmap__set(ids1, cur->key, cur->value,
+				(const void **)&old_key, (void **)&old_data);
+		free(old_key);
+		free(old_data);
+
+		if (ret)
+			break;
+	}
+	hashmap__free(ids2);
+	return ids1;
+}
+
+/* Caller must make sure id is allocated */
+int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
+{
+	return ids__insert(ctx->ids, id, ctx->parent);
+}
+
 /* Caller must make sure id is allocated */
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 {
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 955d5adb7ca4..62d3ae5ddfba 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -30,9 +30,16 @@ struct expr_scanner_ctx {
 	int runtime;
 };
 
+struct hashmap *ids__new(void);
+void ids__free(struct hashmap *ids);
+void ids__print(struct hashmap *ids);
+int ids__insert(struct hashmap *ids, const char *id, struct expr_id *parent);
+struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2);
+
 struct expr_parse_ctx *expr__ctx_new(void);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
 void expr__ctx_free(struct expr_parse_ctx *ctx);
+
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
@@ -41,8 +48,10 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data);
 int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
+
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime);
+
 int expr__find_ids(const char *expr, const char *one,
 		struct expr_parse_ctx *ids, int runtime);
 
-- 
2.29.2.299.gdc1121823c-goog

