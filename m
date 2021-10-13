Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1594C43219
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69E36101D
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhJMRst (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbhJMRsq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A72C061749
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso3895019ybj.21
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C89KxJXK2AmfC41UKgGo8vF4MhXi7J9MAY9rM2xkdyE=;
        b=V0Z/L1CaFQ+Z9lO9MhkZJlid8IqMjTmndnLxS8iY9dm8uNOzzLjWFeaf8yGsQoKsuL
         g33GE97zKHXXi0Cz9W8C2q6+ZmSJH8vJnt7nvVaf6c6VVsof2/NPCXrCe6ITlU3egAju
         7gi1GNUi4R2CfX6Z5Hj2tgW7e0oo+MXz87WryrwxgEcsPH+79s74a8VbNzHZNBZQloFs
         a2zghpoJHYqhPxKC+d4lYsuuyXgwdfkmDxLx7pxiH8xqG9vvs9n/SAM1rHRIOtP4b6GT
         iavelPHfv/ocX3mW3N87ehsr8CDj3HZWKbmB3Yb3Zt35aIPrV+i1p5DGBaFI/UBa+2b9
         +orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C89KxJXK2AmfC41UKgGo8vF4MhXi7J9MAY9rM2xkdyE=;
        b=U5v0x4kt1FVOvV9XkjslMXvS6r0XVRqgjJNunfvJz3y/ottlXTgjXi+M5miMAJk62w
         eyEm913hWGZWQRAGKSvy/z/YO/2YpsWth+suRBhfUt9px7+j7g8612nL0OQ3spU3kLjV
         ikk/yAzsdjVKRKG47SvcwqgXm8DrxY/uP6rRjNapU81fNnRHjpuDo9OXq/nJd6leA2k7
         IPbi5c+WSIDuUdAPlOdGgeAOhPmqEjo5DR6xTB5Yazwl4vsZVmpG50BNl2+QglXnvFc7
         9Ttb0t8c2QY2686Rg49kXGo8vs6l4CIEHtlGgATS7SMHtgBPEn9KTC2qQqiOWUJsGhGa
         iK/w==
X-Gm-Message-State: AOAM531f8aUgj02AloTrTWeXiwqjoOUyHIjaSIo3wGwWwZm7TnxcC1YR
        pal8JHGicPcq888J0GksWRPiWvd5N3Vw
X-Google-Smtp-Source: ABdhPJwOf9IMke9cKQ5Vp83R+oNhjfapQ+6q+MPZmx6pAvoK5alRGMdUUO9gx/UDC3WRwJeR4rSEMVkw2srd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a05:6902:709:: with SMTP id
 k9mr914170ybt.317.1634147198268; Wed, 13 Oct 2021 10:46:38 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:49 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-8-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 07/22] perf test: Add test case struct.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a test case struct mirroring the 'struct kunit_case'. Use the struct
with the DEFINE_SUITE macro, where the single test is turned into a test
case. Update the helpers in builtin-test to handle test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 30 ++++++++++++++++++++++++------
 tools/perf/tests/tests.h        | 26 ++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 96eb486ffbc9..a6d84feba483 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -117,10 +117,19 @@ static struct test_suite **tests[] = {
 
 static int num_subtests(const struct test_suite *t)
 {
+	int num;
+
 	if (t->subtest.get_nr)
 		return t->subtest.get_nr();
 
-	return 0;
+	if (!t->test_cases)
+		return 0;
+
+	num = 0;
+	while (t->test_cases[num].name)
+		num++;
+
+	return num;
 }
 
 static bool has_subtests(const struct test_suite *t)
@@ -138,10 +147,13 @@ static const char *skip_reason(const struct test_suite *t, int subtest)
 
 static const char *test_description(const struct test_suite *t, int subtest)
 {
-	if (subtest < 0 || !t->subtest.get_desc)
-		return t->desc;
+	if (t->test_cases && subtest >= 0)
+		return t->test_cases[subtest].desc;
 
-	return t->subtest.get_desc(subtest);
+	if (t->subtest.get_desc && subtest >= 0)
+		return t->subtest.get_desc(subtest);
+
+	return t->desc;
 }
 
 static bool is_supported(const struct test_suite *t)
@@ -149,9 +161,15 @@ static bool is_supported(const struct test_suite *t)
 	return !t->is_supported || t->is_supported();
 }
 
-static test_fnptr test_function(const struct test_suite *t, int subtest __maybe_unused)
+static test_fnptr test_function(const struct test_suite *t, int subtest)
 {
-	return t->func;
+	if (t->func)
+		return t->func;
+
+	if (subtest <= 0)
+		return t->test_cases[0].run_case;
+
+	return t->test_cases[subtest].run_case;
 }
 
 static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5139e24973cc..71b8d2c88e5c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -31,6 +31,12 @@ struct test_suite;
 
 typedef int (*test_fnptr)(struct test_suite *, int);
 
+struct test_case {
+	const char *name;
+	const char *desc;
+	test_fnptr run_case;
+};
+
 struct test_suite {
 	const char *desc;
 	test_fnptr func;
@@ -40,6 +46,7 @@ struct test_suite {
 		const char *(*get_desc)(int subtest);
 		const char *(*skip_reason)(int subtest);
 	} subtest;
+	struct test_case *test_cases;
 	bool (*is_supported)(void);
 	void *priv;
 };
@@ -47,10 +54,21 @@ struct test_suite {
 #define DECLARE_SUITE(name) \
 	extern struct test_suite suite__##name;
 
-#define DEFINE_SUITE(description, name)		\
-	struct test_suite suite__##name = {		\
-		.desc = description,		\
-		.func = test__##name,		\
+#define TEST_CASE(description, _name)			\
+	{						\
+		.name = #_name,				\
+		.desc = description,			\
+		.run_case = test__##_name,		\
+	}
+
+#define DEFINE_SUITE(description, _name)			\
+	struct test_case tests__##_name[] = {           \
+		TEST_CASE(description, _name),		\
+		{	.name = NULL, }			\
+	};						\
+	struct test_suite suite__##_name = {		\
+		.desc = description,			\
+		.test_cases = tests__##_name,		\
 	}
 
 /* Tests */
-- 
2.33.0.882.g93a45727a2-goog

