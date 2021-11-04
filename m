Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D82C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89246120F
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKDGpS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKDGpI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807AC061714
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so7364528ybe.21
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R7HV7BpOK2/zbpms0umQQLIfkIb0LaOF7Kwr4m5UCuc=;
        b=pMvvqUheeYmTova9HGKlGpXLVuOF0+PY76YDmv6WeecCc/pRfnp+hzLPpl/jya97PH
         dhyRYsEUpxz3v3TuyyQylzUjUQShrbS/RiKrw2E5PoVcrsXV0uc36X/4LOR0G185/VMb
         MwTEix0DwYLaSnwBL9pPfXkNDVmZg8X+jjP7Cyy7b1CikPfNXZoPz0ek/qcgh0wfXxkB
         MPs5l7t5jwVzBbTDg4F+5L0WLQ89snQ48VEd0QgV5rutPxpNZAqKkt0BmGAbcfV42zGc
         2oSE+4hNhkkWmSr31tpVicQWfpsggEnDgvKZkCfTNxrpESxZjnzPGRIzXGPSGZ2qpELi
         rjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R7HV7BpOK2/zbpms0umQQLIfkIb0LaOF7Kwr4m5UCuc=;
        b=1+2xNe5MusBjjngnQ4PBCWY11K8d2RTzJVVYSEQTt8V/rHZvmhmM16dy6ZLg9qtQ39
         5JJ9iKbUWwvXvSTXOI6WBQoWhzd9i9/axJN0kxbnZX+0asnmj4e1EvezHsNPg44WZNIh
         x7SmHweB4Tip0BxN+2LfaFr4mS0etEwmxnViZnwFortpCdkrBgZHVe/XwHAB05lHxyWk
         EQ+G5IvE4FjfCKKA3x2MpTjXYHEx4qoI+l8fo2UgEhq+uJ73n7cBxLHvhZlPoXvk9eRW
         lSeLvBKxSX+87jAzBojUiT4oDb93DjcUGjDYHvoLKhuwNwqA1PTqHnmwOTzxni4JY/c5
         PKaQ==
X-Gm-Message-State: AOAM530Mp75kWFFEIQOS9iq3+yAd9UKBV2Or8yI56RqFlA5m/DwOVCe+
        VItDtHg3w79JkeoAyUiOOYawiqHHFEir
X-Google-Smtp-Source: ABdhPJzSXQwjWsFyV1xv+nQ0X3yldPs/mbJpi9I/XEutBOm+qZcz3eHfMuXEFE4HplIT/jRZkjR69jkVQV6F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a05:6902:4e7:: with SMTP id
 w7mr37579459ybs.77.1636008149553; Wed, 03 Nov 2021 23:42:29 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:52 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-7-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 06/22] perf test: Add helper functions for abstraction.
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

Abstract certain test features so that they can be refactored in later
changes. No functional change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 94 +++++++++++++++++++++++----------
 tools/perf/tests/tests.h        |  6 ++-
 2 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7d52e2eb8147..96eb486ffbc9 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -115,6 +115,45 @@ static struct test_suite **tests[] = {
 	arch_tests,
 };
 
+static int num_subtests(const struct test_suite *t)
+{
+	if (t->subtest.get_nr)
+		return t->subtest.get_nr();
+
+	return 0;
+}
+
+static bool has_subtests(const struct test_suite *t)
+{
+	return t->subtest.get_nr || num_subtests(t) > 1;
+}
+
+static const char *skip_reason(const struct test_suite *t, int subtest)
+{
+	if (t->subtest.skip_reason)
+		return t->subtest.skip_reason(subtest);
+
+	return NULL;
+}
+
+static const char *test_description(const struct test_suite *t, int subtest)
+{
+	if (subtest < 0 || !t->subtest.get_desc)
+		return t->desc;
+
+	return t->subtest.get_desc(subtest);
+}
+
+static bool is_supported(const struct test_suite *t)
+{
+	return !t->is_supported || t->is_supported();
+}
+
+static test_fnptr test_function(const struct test_suite *t, int subtest __maybe_unused)
+{
+	return t->func;
+}
+
 static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
 {
 	int i;
@@ -171,7 +210,7 @@ static int run_test(struct test_suite *test, int subtest)
 			}
 		}
 
-		err = test->func(test, subtest);
+		err = test_function(test, subtest)(test, subtest);
 		if (!dont_fork)
 			exit(err);
 	}
@@ -208,7 +247,7 @@ static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
 		err = TEST_SKIP;
 	}
 
-	if (!t->subtest.get_nr)
+	if (!has_subtests(t))
 		pr_debug("%s:", t->desc);
 	else
 		pr_debug("%s subtest %d:", t->desc, subtest + 1);
@@ -218,11 +257,10 @@ static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
 		pr_info(" Ok\n");
 		break;
 	case TEST_SKIP: {
-		const char *skip_reason = NULL;
-		if (t->subtest.skip_reason)
-			skip_reason = t->subtest.skip_reason(subtest);
-		if (skip_reason)
-			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", skip_reason);
+		const char *reason = skip_reason(t, subtest);
+
+		if (reason)
+			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n", reason);
 		else
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
 	}
@@ -397,7 +435,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	int width = shell_tests__max_desc_width();
 
 	for_each_test(j, k, t) {
-		int len = strlen(t->desc);
+		int len = strlen(test_description(t, -1));
 
 		if (width < len)
 			width = len;
@@ -407,17 +445,15 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		int curr = i++, err;
 		int subi;
 
-		if (!perf_test__matches(t->desc, curr, argc, argv)) {
+		if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
 			bool skip = true;
 			int subn;
 
-			if (!t->subtest.get_nr)
-				continue;
-
-			subn = t->subtest.get_nr();
+			subn = num_subtests(t);
 
 			for (subi = 0; subi < subn; subi++) {
-				if (perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
+				if (perf_test__matches(test_description(t, subi),
+							curr, argc, argv))
 					skip = false;
 			}
 
@@ -425,22 +461,23 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 				continue;
 		}
 
-		if (t->is_supported && !t->is_supported()) {
-			pr_debug("%2d: %-*s: Disabled\n", i, width, t->desc);
+		if (!is_supported(t)) {
+			pr_debug("%2d: %-*s: Disabled\n", i, width,
+				 test_description(t, -1));
 			continue;
 		}
 
-		pr_info("%2d: %-*s:", i, width, t->desc);
+		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
 
 		if (intlist__find(skiplist, i)) {
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 			continue;
 		}
 
-		if (!t->subtest.get_nr) {
+		if (!has_subtests(t)) {
 			test_and_print(t, false, -1);
 		} else {
-			int subn = t->subtest.get_nr();
+			int subn = num_subtests(t);
 			/*
 			 * minus 2 to align with normal testcases.
 			 * For subtest we print additional '.x' in number.
@@ -460,18 +497,19 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			pr_info("\n");
 
 			for (subi = 0; subi < subn; subi++) {
-				int len = strlen(t->subtest.get_desc(subi));
+				int len = strlen(test_description(t, subi));
 
 				if (subw < len)
 					subw = len;
 			}
 
 			for (subi = 0; subi < subn; subi++) {
-				if (!perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
+				if (!perf_test__matches(test_description(t, subi),
+							curr, argc, argv))
 					continue;
 
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
-					t->subtest.get_desc(subi));
+					test_description(t, subi));
 				err = test_and_print(t, skip, subi);
 				if (err != TEST_OK && t->subtest.skip_if_fail)
 					skip = true;
@@ -526,19 +564,19 @@ static int perf_test__list(int argc, const char **argv)
 	for_each_test(j, k, t) {
 		int curr = i++;
 
-		if (!perf_test__matches(t->desc, curr, argc, argv) ||
-		    (t->is_supported && !t->is_supported()))
+		if (!perf_test__matches(test_description(t, -1), curr, argc, argv) ||
+		    !is_supported(t))
 			continue;
 
-		pr_info("%2d: %s\n", i, t->desc);
+		pr_info("%2d: %s\n", i, test_description(t, -1));
 
-		if (t->subtest.get_nr) {
-			int subn = t->subtest.get_nr();
+		if (has_subtests(t)) {
+			int subn = num_subtests(t);
 			int subi;
 
 			for (subi = 0; subi < subn; subi++)
 				pr_info("%2d:%1d: %s\n", i, subi + 1,
-					t->subtest.get_desc(subi));
+					test_description(t, subi));
 		}
 	}
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index c95b0de9f822..5139e24973cc 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -27,9 +27,13 @@ enum {
 	TEST_SKIP = -2,
 };
 
+struct test_suite;
+
+typedef int (*test_fnptr)(struct test_suite *, int);
+
 struct test_suite {
 	const char *desc;
-	int (*func)(struct test_suite *test, int subtest);
+	test_fnptr func;
 	struct {
 		bool skip_if_fail;
 		int (*get_nr)(void);
-- 
2.33.1.1089.g2158813163f-goog

