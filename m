Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0343C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8429360E98
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhKDGsD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhKDGqo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:46:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C9C0797B8
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v7-20020a25ab87000000b005c2130838beso7585388ybi.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N51ftPci49QHKXv2EdIL5CFt1D7hBmKrru2lMDQQtvY=;
        b=QVoOer+wqH/YvEnUkcOwR0PNk03Nk0XhxZCfr2uXHXbivu9rJjuuSm8YH/FU2dbL9x
         R1yqQTSm/jzPrw5XToNxUmTF4zuDwmFJUKbUBLwCNsN+JjuqgowGpES4GbW+PQgZPdpt
         l3DvpV8pulz1ADx9gXpqCr9CnXqmn1tMm8nL7pT1GTisXfOWE9LJ7G0dSghKC3ahZWPi
         iJ3J1Jx2jJSLe6RvV3saOwEBRrXoRlK582+tTMAMHZsttA7iXo2NVqKAgxiqnqYjAsKm
         sRUr9kG0ylE3zszWw3m+LrcNzZ83oNmWx9s6NqLVhqsuk4D7/b3Kb9146v2XhfrUnWNI
         MUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N51ftPci49QHKXv2EdIL5CFt1D7hBmKrru2lMDQQtvY=;
        b=kC3ILfz1GPBl54RFIX7VJo3qonA2igXIyoTii4iPNp4xv21JBSEzYtqwPfeKhDg32g
         lWQt6ma/QV5Q5aS53BbJxibzk4HdvhuF+7eBv6CPXQjs5aqBcxb+MNqhX7QsdBgzMJr9
         e7+mBwN+wSBkQxqPcZEOvsNxCVs4ANh4bZKcKVxbw3sJ4bRa/KvTG+ZIlkIWZ3eGOy1O
         NRvRlBwvIeAwAKbLWTrENeqhNnZdzfe6o/1oZqEQcdS3QQe1cirJJZtDIoIaOZuJO3Z5
         D8uAIFNvvYLwqHyMaroWEXZGe46+9e0a2YiMhDAM9CiLdVZSXt/r3sJyRiVIXn79SB6x
         nPvQ==
X-Gm-Message-State: AOAM533A2MZwGLbpUG5oKFrMj+gpukjUsGgKzM4nfuVtC0fdT52rewMu
        nsBTrrTmtbRvyE4nGs2PpdcY18ZbH7s/
X-Google-Smtp-Source: ABdhPJycCwf0B7S+81Xu18NbtkeCjAKRQFz1bUrjGVuh8YXsAB4KNq+s5MvEyKd5flMupFqPfcY2tFJQgGhl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:ac0b:: with SMTP id
 w11mr46441245ybi.163.1636008179000; Wed, 03 Nov 2021 23:42:59 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:04 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-19-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 18/22] perf test: Remove non test case style support.
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
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
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
index 62e97faa90f0..1d9c0e03b8db 100644
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
2.33.1.1089.g2158813163f-goog

