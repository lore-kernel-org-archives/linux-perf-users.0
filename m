Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04092C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44FB60ED5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhKDGrK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhKDGpx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B3C061A0B
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso7393201ybm.22
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QUI3hZYXvI78WFqblkOEI4nv4sPjthYOTOzOfWXxRnY=;
        b=gMdJnD3ST5xjfe0CI8qXeeg9elYjEdLqBZYfWTL02umiR2CtMMBFL/evjfoJWrpzox
         mXWpXTJX0a6RkTACmMVY6v+1C7iMNk+cZ1o46CNN0hl3P79/Bo6k0cgpbwOTKVZN1Ant
         tB4WmQilyPISpndzkW11YZTWp4yL7epA4S52dlcTUGn85rZsivYoW1JD7QErzb0PXvqT
         yMMO1TAU6mYQxs5mBcu2kRJ6zPAJGXqLs43mmn+xSgiZynvJ6nzrRHU59QPel1c3Ds4N
         XmFEGmaRnaVj9Ign2j5XdkAnSgv5p2BZfF4khKRCrN0qXGvrbvp+/eTEYRzWW9Szp6Ds
         yFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QUI3hZYXvI78WFqblkOEI4nv4sPjthYOTOzOfWXxRnY=;
        b=TFYZTrHbRVJovwm8zE31vlT1QN/x1mYsi9fp8AvAE3G2G/GhHdpCi3+JmloXvMigZS
         STxcsV7bFPYVnd5N/fBzQi03XR62BKDFwZXd1rvh8BFnjN5SqUP8Ir6z6tOVkWIuSrQ7
         bWbo6MV4ff3XwBjJqedm51ZMoZBHF23UgomSafu+vJHSIeGPOYTOJS+jGlbO/XLrnsQj
         mFVDpCj0Em0A2mavRfak1xAfH9lOhfXj9egPMahxgJ2jtjOe5Uu4RNN1z1Ie93j6R/ag
         HQKSfJ0FKGCPnApGU570iUVrQlESvNCS3SfS7V9oLl+fzB1kEh3HSmeo2NmMf9FULYeS
         jhJg==
X-Gm-Message-State: AOAM530nEONpjBuUEYh9mKu7rB7/Kt3iowPMFbXiT4mCkl6YPJu/gLwQ
        3ygx+PDy4auHard5drBt4G0wMsx/pvst
X-Google-Smtp-Source: ABdhPJxOoyt8KvgNv9Gie8FpeQbl88z6WFavgeTCKCDAyPvf2+ZKg8TSn6T3DbyQZMrB8dGAG0HuTB1/ztq6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a5b:98e:: with SMTP id c14mr34614779ybq.458.1636008166642;
 Wed, 03 Nov 2021 23:42:46 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:59 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-14-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 13/22] perf test: Convert bpf tests to test cases.
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

Use null terminated array of test cases rather than the previous sub
test functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bpf.c | 72 +++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 274fdd5318a5..e86a77ce93ef 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -62,7 +62,6 @@ static int llseek_loop(void)
 
 static struct {
 	enum test_llvm__testcase prog_id;
-	const char *desc;
 	const char *name;
 	const char *msg_compile_fail;
 	const char *msg_load_fail;
@@ -72,7 +71,6 @@ static struct {
 } bpf_testcase_table[] = {
 	{
 		.prog_id	  = LLVM_TESTCASE_BASE,
-		.desc		  = "Basic BPF filtering",
 		.name		  = "[basic_bpf_test]",
 		.msg_compile_fail = "fix 'perf test LLVM' first",
 		.msg_load_fail	  = "load bpf object failed",
@@ -81,7 +79,6 @@ static struct {
 	},
 	{
 		.prog_id	  = LLVM_TESTCASE_BASE,
-		.desc		  = "BPF pinning",
 		.name		  = "[bpf_pinning]",
 		.msg_compile_fail = "fix kbuild first",
 		.msg_load_fail	  = "check your vmlinux setting?",
@@ -92,7 +89,6 @@ static struct {
 #ifdef HAVE_BPF_PROLOGUE
 	{
 		.prog_id	  = LLVM_TESTCASE_BPF_PROLOGUE,
-		.desc		  = "BPF prologue generation",
 		.name		  = "[bpf_prologue_test]",
 		.msg_compile_fail = "fix kbuild first",
 		.msg_load_fail	  = "check your vmlinux setting?",
@@ -282,18 +278,6 @@ static int __test__bpf(int idx)
 	return ret;
 }
 
-static int test__bpf_subtest_get_nr(void)
-{
-	return (int)ARRAY_SIZE(bpf_testcase_table);
-}
-
-static const char *test__bpf_subtest_get_desc(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(bpf_testcase_table))
-		return NULL;
-	return bpf_testcase_table[i].desc;
-}
-
 static int check_env(void)
 {
 	int err;
@@ -324,7 +308,7 @@ static int check_env(void)
 	return 0;
 }
 
-static int test__bpf(struct test_suite *test __maybe_unused, int i)
+static int test__bpf(int i)
 {
 	int err;
 
@@ -342,31 +326,61 @@ static int test__bpf(struct test_suite *test __maybe_unused, int i)
 	err = __test__bpf(i);
 	return err;
 }
+#endif
 
-#else
-static int test__bpf_subtest_get_nr(void)
+static int test__basic_bpf_test(struct test_suite *test __maybe_unused,
+				int subtest __maybe_unused)
 {
-	return 0;
+#ifdef HAVE_LIBBPF_SUPPORT
+	return test__bpf(0);
+#else
+	pr_debug("Skip BPF test because BPF support is not compiled\n");
+	return TEST_SKIP;
+#endif
 }
 
-static const char *test__bpf_subtest_get_desc(int i __maybe_unused)
+static int test__bpf_pinning(struct test_suite *test __maybe_unused,
+			     int subtest __maybe_unused)
 {
-	return NULL;
+#ifdef HAVE_LIBBPF_SUPPORT
+	return test__bpf(1);
+#else
+	pr_debug("Skip BPF test because BPF support is not compiled\n");
+	return TEST_SKIP;
+#endif
 }
 
-static int test__bpf(struct test_suite *test __maybe_unused, int i __maybe_unused)
+static int test__bpf_prologue_test(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
 {
+#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_BPF_PROLOGUE)
+	return test__bpf(2);
+#else
 	pr_debug("Skip BPF test because BPF support is not compiled\n");
 	return TEST_SKIP;
+#endif
 }
+
+
+static struct test_case bpf_tests[] = {
+#ifdef HAVE_LIBBPF_SUPPORT
+	TEST_CASE("Basic BPF filtering", basic_bpf_test),
+	TEST_CASE("BPF pinning", bpf_pinning),
+#ifdef HAVE_BPF_PROLOGUE
+	TEST_CASE("BPF prologue generation", bpf_prologue_test),
+#else
+	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
 #endif
+#else
+	TEST_CASE_REASON("Basic BPF filtering", basic_bpf_test, "not compiled in"),
+	TEST_CASE_REASON("BPF pinning", bpf_pinning, "not compiled in"),
+	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
+#endif
+	{ .name = NULL, }
+};
 
 struct test_suite suite__bpf = {
 	.desc = "BPF filter",
-	.func = test__bpf,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__bpf_subtest_get_nr,
-		.get_desc	= test__bpf_subtest_get_desc,
-	},
+	.test_cases = bpf_tests,
+	.subtest = { .skip_if_fail = true, },
 };
-- 
2.33.1.1089.g2158813163f-goog

