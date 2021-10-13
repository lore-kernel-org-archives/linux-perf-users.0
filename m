Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F2C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED4E6101D
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbhJMRuc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbhJMRuN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD0C0613EB
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so3918747ybm.18
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=REGzgN8X9fN5ply/7E9LzsjfVW7yuXTByGhaPBFWXJ8=;
        b=ZqQS2v6Gvj7W6vqT+l6CnXf0/429EV/FmKYWJoQk3z/OJjNs8yYDXelfCmR8gyGBHf
         5eARzKnRe3ifVPaKze8MgTqnfewQMF+VOTysTM84BOOsVJpLq5OCaqgmZoQUZW85zLEB
         G2y60+XlSwTBEbG2Vk9abyiZwrminvwZfdEFjFX/V6fYat3Xiu7qiq1nKt9VPBmQcN8F
         RuPeAUANgyM3EgpjRduUdf1F12oLNDSS7xjptGXT4o6L5cfYej06J7EL0Kl4vSFpeVaQ
         mKviXpYGsdTd1VYI/qPxKXctWSwf7r138Ve5REaledWO4M/Nzl3Rr9CIVnyUhTnxHVBh
         TP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=REGzgN8X9fN5ply/7E9LzsjfVW7yuXTByGhaPBFWXJ8=;
        b=nyy6DFxQcFdFqLuBzV9Zx9zFeMx8fr0HW9nOUri57d/yCTehKjJUNXbeNdkxo6jUTs
         Lfc34+v3DjMIUZ4QzoZoNYwBfi2dT5HgE3cr20USlv8uBELveOiYdXY7SDC4OOQPYkaD
         phURXzIkMkZI0EIlL9IJJmx0hDLkWuqoB4flQuV2HKp34/p1f2mdpMQwmuCGqGV+OQqL
         F47hEFUhsZpkmA9DrDorrLRDLRGaO5WQTWXLfthJcnPThURi88p9TYi2RVkTXtQe0stW
         xBf/dwvYwLEp2PaYFtaAa51h9kpRn/koT1Y71UJ0fCk+JT6k/+yYXRaYfveaV/OdHytQ
         SLGw==
X-Gm-Message-State: AOAM530nQ+KqaS+B0UVKGYihGUW4tUuTpfZf1yfsa59O8zzDcN65YcBF
        sSb7zhuLc9q8rM1/9tWujXQlZUoF+8qZ
X-Google-Smtp-Source: ABdhPJxNrLzJkPIGwA+4X/MvjvvKSL77JIKLUZKEBVpGLqExQRgP3F6yQoa/WWJseRM1ayX1zW92qcEBQgAK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:ab61:: with SMTP id
 u88mr738884ybi.241.1634147224865; Wed, 13 Oct 2021 10:47:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:46:00 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-19-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 18/22] perf test: Remove non test case style support.
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

Convert shell tests to also run using test case style.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 25 ++++++++++++++++---------
 tools/perf/tests/tests.h        |  1 -
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c98c7134b552..966948cacba3 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -157,9 +157,6 @@ static bool is_supported(const struct test_suite *t)
 
 static test_fnptr test_function(const struct test_suite *t, int subtest)
 {
-	if (t->func)
-		return t->func;
-
 	if (subtest <= 0)
 		return t->test_cases[0].run_case;
 
@@ -413,24 +410,34 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
 		int curr = i++;
 		char desc[256];
-		struct test_suite test = {
-			.desc = shell_test__description(desc, sizeof(desc), st.dir, ent->d_name),
-			.func = shell_test__run,
+		struct test_case test_cases[] = {
+			{
+				.desc = shell_test__description(desc,
+								sizeof(desc),
+								st.dir,
+								ent->d_name),
+				.run_case = shell_test__run,
+			},
+			{ .name = NULL, }
+		};
+		struct test_suite test_suite = {
+			.desc = test_cases[0].desc,
+			.test_cases = test_cases,
 			.priv = &st,
 		};
 
-		if (!perf_test__matches(test.desc, curr, argc, argv))
+		if (!perf_test__matches(test_suite.desc, curr, argc, argv))
 			continue;
 
 		st.file = ent->d_name;
-		pr_info("%2d: %-*s:", i, width, test.desc);
+		pr_info("%2d: %-*s:", i, width, test_suite.desc);
 
 		if (intlist__find(skiplist, i)) {
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 			continue;
 		}
 
-		test_and_print(&test, false, -1);
+		test_and_print(&test_suite, false, 0);
 	}
 
 	for (e = 0; e < n_dirs; e++)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9bf448f7429a..cae33c375d55 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -40,7 +40,6 @@ struct test_case {
 
 struct test_suite {
 	const char *desc;
-	test_fnptr func;
 	struct {
 		bool skip_if_fail;
 	} subtest;
-- 
2.33.0.882.g93a45727a2-goog

