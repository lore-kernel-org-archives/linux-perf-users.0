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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3464C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AAC60EC0
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhIWHs2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbhIWHsZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:25 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DCC061760
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z16-20020ac86b90000000b0029eec160182so16077879qts.9
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZKEm2+fPtTeUOSsx3MZoW72rKNaFJFzEhSDK32H57kY=;
        b=YYVSOuE77Iy1kOUcNM4lA21FviwQxHclX/tmjtORjBrpiVceAzrIty6yAk+rrXCFtn
         1FR3EgSPgmWF1bkD3DH3hpUqENNnLwCBPoeOhFRaCirUOnlEeb6KN0pvRnK3MZyyHySk
         xFlPmED0NZL6bERvTweXuYmGq4Uiw9adl8r/iOc3oiftcrwV7j4HYjsoyki8we2mpoZF
         RpfhS8cdC7fC7nylZe4CljkPeq2EMYF4ZNZGAJzoP+fr2z7qgkidIBs/QF28LZ5X1E5N
         YYz3EtvbGak5jqC1rI3BYIoiRADEcQiyUu2fV4WeQ5I3JZP4lAD+X0zkA0+zi6pb8M2+
         kdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZKEm2+fPtTeUOSsx3MZoW72rKNaFJFzEhSDK32H57kY=;
        b=XVKJJe1cZy50HdyJ6VshClRoVH9pLM2L/JusMpqhv5JsQHvTUdprfr6hLN7fLDxQMt
         No8AqqW1V2Nh6rUf0dtfVs8NTpuSQXeZyzjn97xMvlGvrtdWVnAPKbqDn7fh5O1AeBQ3
         ES3qBb329YXIa30L0bXe/E2csbtWzCDcQLS4asaPRehmauRYxLLfPjXO3EOG7gaacTzX
         pjyvWtaEyuARaNPFq/moaWDr8tGRaZn5zEPKRUXYjFYI9oT5mvmbiWNG1cLx9hD6TiJg
         55K75ydTEnQulnhkb1URZsD/XOGT5dUZt4htlFmH2lULWHg4ftKUP0ui0VGQcyRyM7dJ
         /9pQ==
X-Gm-Message-State: AOAM530GSE4a/romlLoy8GfgsK2yTfUUMSQneoNvjdXDfz9npSTXXPVl
        0H06UNLpbEKUSRqcE09PD1+/4scmodFz
X-Google-Smtp-Source: ABdhPJwhqo5RjPUMZHtA6hyUklsXX3xwzD5jXBu1aQrCJQi+NGNNPWCAkrx5oZru9qisQ8tpWW3s2c0JDWK2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:ad4:4872:: with SMTP id
 u18mr2888862qvy.20.1632383213658; Thu, 23 Sep 2021 00:46:53 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:11 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-9-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 08/13] perf metric: Add utilities to work on ids map.
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

Add utilities to new/free an ids hashmap, as well as to union. Add
testing of the union. Unioning hashmaps will be used when parsing the
metric, if a value is known then the hashmap is unnecessary, otherwise
we need to union together all the event ids to compute their values for
reporting.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 47 +++++++++++++++++++++++++++
 tools/perf/util/expr.c  | 71 ++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/expr.h  | 12 +++++++
 3 files changed, 126 insertions(+), 4 deletions(-)

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
index adf16bb7571a..81101be51044 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -59,8 +59,29 @@ static bool key_equal(const void *key1, const void *key2,
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
+	hashmap__for_each_entry(ids, cur, bkt) {
+		free((char *)cur->key);
+		free(cur->value);
+	}
+
+	hashmap__free(ids);
+}
+
+int ids__insert(struct hashmap *ids, const char *id,
+		struct expr_id *parent)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
@@ -70,10 +91,10 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
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
@@ -82,6 +103,48 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
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
+		if (ret) {
+			hashmap__free(ids1);
+			hashmap__free(ids2);
+			return NULL;
+		}
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
index de109c2ab917..4ed186bd1f13 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -30,9 +30,19 @@ struct expr_scanner_ctx {
 	int runtime;
 };
 
+struct hashmap *ids__new(void);
+void ids__free(struct hashmap *ids);
+int ids__insert(struct hashmap *ids, const char *id, struct expr_id *parent);
+/*
+ * Union two sets of ids (hashmaps) and construct a third, freeing ids1 and
+ * ids2.
+ */
+struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2);
+
 struct expr_parse_ctx *expr__ctx_new(void);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
 void expr__ctx_free(struct expr_parse_ctx *ctx);
+
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
@@ -41,8 +51,10 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
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
2.33.0.464.g1972c5931b-goog

