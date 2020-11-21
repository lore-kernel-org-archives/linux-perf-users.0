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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774E4C6379D
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F0822403
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hV6WSXRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKUDLb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 22:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKUDLb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Nov 2020 22:11:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E59C061A47
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:31 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b4so7847316plr.15
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=c7ylYkXg+Wq4kHcwpXY8Kwg0nOcNAwjZ1t+TgIWVj0g=;
        b=hV6WSXRbGQdYgGjpCBPVu1Jp7+8tXMbkz3hNFWFKkDuBOD19WiALfv5rlf4NfOutuU
         Cp9d+asazG9OeixzP+mypV6WtMPFR9PeesXkFA2vYxm5xcS8fWF1n3DyfxCXbA9uKdrJ
         M8D1BOJ+nzJVvj+/Jl0HCtW5xV2gX8xHbN5IuI9Z5+HDpQAja0Xx/h8SoKc/iWKmNIyX
         DKmDzCfbaBaRt6bXbQR5LP/C8CgMzOC0aX3NKuxW6cpGb/0tU2cNiNLIMK2a1qPnGwcL
         D04X7Gri0dapOoGB6vKWMWCyVIdQbBMgEsqcaSjtRFtwVwxsnWq6ZGVny/npttWNvTAK
         kN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c7ylYkXg+Wq4kHcwpXY8Kwg0nOcNAwjZ1t+TgIWVj0g=;
        b=gOzICQTBGdo5ABep3+7Tp3P1AiqkOkqP78/OWKjGXNfKPBc73l1JZQfi/wMVtAFVAN
         3XuAm/EC544FxOBAdyqEvFD8CtvRbpUy38MnqjHo0CTid5eQHdbU1ChGL0dWaVLBGuDd
         s+BMLoHZ2/MMDHCKoq32Zo7uBC0N9qll93obbSckTCszO9ePXBt2oY3tfdqC78vx0053
         9Kkd+KqaG38Epq0u3rqbfbT2ZJ0Urlj5YEy+YvsO2WApKSoetR9ZM6Jg/APF37wUf9yf
         JjftnSRh/iS2loiXqkvumIyBLBxpoWlMfLUTDu92YpYM5j5BO0FpSX5U/r3tD7CnCooH
         g42g==
X-Gm-Message-State: AOAM533eIKYcKZJqAOahzIamaRxk1RU7wo6A97M+0rnScMG+lcDFjBXX
        CmTRAlOSdEp2sewCybecl+nxbGCrptDZ
X-Google-Smtp-Source: ABdhPJwPXaWCa4Cb02joPe2aCoMmiI1wZRGVQGLkuRk8EM0gjYdERWm0VQ5BCUxPJQcAyzsiYCkJoImUCSpc
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a63:f64c:: with SMTP id
 u12mr20717483pgj.325.1605928290850; Fri, 20 Nov 2020 19:11:30 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:11:18 -0800
In-Reply-To: <20201121031119.3554769-1-irogers@google.com>
Message-Id: <20201121031119.3554769-5-irogers@google.com>
Mime-Version: 1.0
References: <20201121031119.3554769-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 4/5] perf metric: Add utilities to work on ids map.
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
index 7ccb97c73347..1c881bea7fca 100644
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
2.29.2.454.gaff20da3a2-goog

