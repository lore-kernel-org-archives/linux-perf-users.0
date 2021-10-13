Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCAC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CF060F4A
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhJMRuN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbhJMRtT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:49:19 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED5C061773
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:53 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t15-20020ac8588f000000b002a777ee14d0so2630833qta.14
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6s7UDaUWqWxOB0gkOYGBtnicqL2UK9wFtrA9e+9ezHc=;
        b=K3LzWBcp8jclzYs4g8blDoMVJKnJojoegDMmR+QXeZ17DzY9BeS5A4U6VEXcbLi3Om
         nAdjS7roJUIBDi++TSWGVvGPHtNlA4WUqbvzPNwio2bq3nYRT51WMJ1LRvPpPaHk2jBY
         +LyUqpNiv9GmyidiT36JA2LiB7yYBGLEhSiqgoSinBvmGj625soM21Zon0oePf7EnVm7
         FYEox3x53R2XwBceutzcOdAvi3PU6Y5hdHEQHl63ICYQTrsZXciPGssJnRloR40n8NsR
         CZbkn4S5MRvLX4YL4cJF2Ywq1HgYOV0+2xZQZPx2e+XixqeT9SuKZfwa6iyalH3t0KBf
         ZUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6s7UDaUWqWxOB0gkOYGBtnicqL2UK9wFtrA9e+9ezHc=;
        b=UCWydBYOR87lFeSFbIfLkJIBDAjGqRiOwNRNQyxAa7xedO8/nesfnnXRG9h+TYUFbl
         /TdWnJD9KbgAV9Mt65AiKh2YEv9ui0K47M0RJnKVF9R1uotfy6/NSCedukoJDpKhqjNJ
         TZoTlC9/C8H6vNlrIOLtqGubseHSYC8HbYd1XxvfrGQjq+tMbJ+NqjXBatuEV1zEdqdF
         QO9vCmGsd65d9vhIbT0NvipfMF0oKp80R7UQwcY9dQLYb1U768vlraLmHEkkEpjeAH6O
         7LyoYgN2nD0MG36hkgXsCeKA9D9uYP+0lR+7MIWgJujkBvUefn+tuHN8ozwxavUkt48y
         e6uw==
X-Gm-Message-State: AOAM532eulX6Ep++meMOTy2pQVRMyQiTPrfvgM8cqbl3zJnNoVNakR5v
        sveDb3yxxUmGA0N15KEG1M08txWzKBMF
X-Google-Smtp-Source: ABdhPJwwyWV5YTbj8yZhf281xwaGPjV2KsvGGvQ/dc12/yjCbDVUSjOVzgoQ9oWHHMl5ubCaUUj1M7AiyR/I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a05:622a:52:: with SMTP id
 y18mr828851qtw.300.1634147212836; Wed, 13 Oct 2021 10:46:52 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:55 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-14-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 13/22] perf test: Convert bpf tests to test cases.
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
2.33.0.882.g93a45727a2-goog

