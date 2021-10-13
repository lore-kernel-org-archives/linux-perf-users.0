Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE3C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225D86101D
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbhJMRsv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbhJMRsr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D36C061762
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a254506000000b005b6b6434cd6so3934106yba.9
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MdVNg7KPc55lwyVX7zGR3vWGbK06a6SEnmxPUjqIOmQ=;
        b=A/RQJn5brYT66lX6lAaIuEiWo4+Z7GyClF9p1lbjwnjsWnjSvIMYzLTTxDojkiKic5
         4WdAepynf2c1sz3ygumMRQ3EzZS/y7xLNgOefLH2iAk0PAY6ZYr4kIOP1Hf7ucbJP6DS
         gPsn41GrzjYLR1L0RMtJt8FvzrZSfNDBr2O8Zme06d6XczFWtScFXiPzvJA56NLLRjQe
         RBjn5Tv1nhug9qXFjjFuJjdTLmlSvQbC7czewS/O0qlsdjdVClF7WEybhfONAvCZPRny
         xHxKwZUEwrqB2PvxGVOidt0iN816JTDRKJPE4Bga4MhjxDWikGoGBiyKDkL7ZshmD5qr
         fBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MdVNg7KPc55lwyVX7zGR3vWGbK06a6SEnmxPUjqIOmQ=;
        b=AfKv/51v6bewTbm/qCpXYGOPzyptgjEASH12mhPbXYos4xYTekZIy8Q9VwGhROuvEI
         iav1jqSDHIbcbgmVeYDYkyOjW0bLLzaNmPZ9u+ILqAHkxKYmimFoOXK4X+u5V4aabm7x
         ogzffgkQxEZ+LxpZyyXsPvmBISO5wb1ZbQVsxnlnpnW4cMo8UqNz3vJam63OyUOIAqe7
         0qWRQVUB/NqZrwwddHMZHjaHdHxLn0un1tSN+/pgg0DaQCK11VNcWDxEVCHlAEOKvLXS
         RpsYiitZJ37G9m9NQXtZANBV3oparignqbGCBGbo3m/YrElmrSnc7j5cTJ5u7fQWkB2S
         7lnA==
X-Gm-Message-State: AOAM533bhZy29I/IywYWWYTXq8VhmT5Ep+DGKOtGyXBb1SZV+dEy5IDk
        FOpvCWnzOBV+iaLCOTPW9FmkCN9K8M9R
X-Google-Smtp-Source: ABdhPJyGG6ugpcALKyXNJw0EjZO8gGpxGgK/cyOlUwbsrC+L1BYnlG/xp0gaphNdl220Ql+hT13xn9YjN0UT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:b309:: with SMTP id
 l9mr839346ybj.188.1634147202942; Wed, 13 Oct 2021 10:46:42 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:51 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-10-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 09/22] perf test: Convert pfm tests to use test cases.
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

Use null terminated array of test cases rather than the previous sub
test functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pfm.c | 66 ++++++++++++------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index f55e4ecdda71..651fee4ef819 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -11,27 +11,6 @@
 
 #include <linux/kernel.h>
 
-#ifdef HAVE_LIBPFM
-static int test__pfm_events(void);
-static int test__pfm_group(void);
-#endif
-
-static const struct {
-	int (*func)(void);
-	const char *desc;
-} pfm_testcase_table[] = {
-#ifdef HAVE_LIBPFM
-	{
-		.func = test__pfm_events,
-		.desc = "test of individual --pfm-events",
-	},
-	{
-		.func = test__pfm_group,
-		.desc = "test groups of --pfm-events",
-	},
-#endif
-};
-
 #ifdef HAVE_LIBPFM
 static int count_pfm_events(struct perf_evlist *evlist)
 {
@@ -44,7 +23,8 @@ static int count_pfm_events(struct perf_evlist *evlist)
 	return count;
 }
 
-static int test__pfm_events(void)
+static int test__pfm_events(struct test_suite *test __maybe_unused,
+			    int subtest __maybe_unused)
 {
 	struct evlist *evlist;
 	struct option opt;
@@ -104,7 +84,8 @@ static int test__pfm_events(void)
 	return 0;
 }
 
-static int test__pfm_group(void)
+static int test__pfm_group(struct test_suite *test __maybe_unused,
+			   int subtest __maybe_unused)
 {
 	struct evlist *evlist;
 	struct option opt;
@@ -187,37 +168,28 @@ static int test__pfm_group(void)
 	}
 	return 0;
 }
-#endif
-
-static const char *test__pfm_subtest_get_desc(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(pfm_testcase_table))
-		return NULL;
-	return pfm_testcase_table[i].desc;
-}
-
-static int test__pfm_subtest_get_nr(void)
+#else
+static int test__pfm_events(struct test_suite *test __maybe_unused,
+			    int subtest __maybe_unused)
 {
-	return (int)ARRAY_SIZE(pfm_testcase_table);
+	return TEST_SKIP;
 }
 
-static int test__pfm(struct test_suite *test __maybe_unused, int i __maybe_unused)
+static int test__pfm_group(struct test_suite *test __maybe_unused,
+			   int subtest __maybe_unused)
 {
-#ifdef HAVE_LIBPFM
-	if (i < 0 || i >= (int)ARRAY_SIZE(pfm_testcase_table))
-		return TEST_FAIL;
-	return pfm_testcase_table[i].func();
-#else
 	return TEST_SKIP;
-#endif
 }
+#endif
+
+static struct test_case pfm_tests[] = {
+	TEST_CASE_REASON("test of individual --pfm-events", pfm_events, "not compiled in"),
+	TEST_CASE_REASON("test groups of --pfm-events", pfm_group, "not compiled in"),
+	{ .name = NULL, }
+};
 
 struct test_suite suite__pfm = {
 	.desc = "Test libpfm4 support",
-	.func = test__pfm,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__pfm_subtest_get_nr,
-		.get_desc	= test__pfm_subtest_get_desc,
-	}
+	.test_cases = pfm_tests,
+	.subtest = { .skip_if_fail   = true }
 };
-- 
2.33.0.882.g93a45727a2-goog

