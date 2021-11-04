Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78B6C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9236F61139
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhKDGtP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhKDGpz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED09C079782
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z21-20020ac87f95000000b002acada0d7d1so2125872qtj.5
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hcRtetVuTOoQ725MyIBgP5sReM3VS+5M9xApQA3DY+c=;
        b=SuIWmdQZ7ZPsG2xzeoHwM0MtB7RQHLVJhWjxOBvP5oZ4ncG7/CdTvPaO2BkPDqcAuL
         jIO899OVU/zoA7Jl/ZVOqyxec4vzIq4Y8z7Gc3Nys8VgizIW7XNostfxnTTdgLpVXibA
         wzz6IUC/Zc4mK3GyLClR3BHzfzXpbT8uKiCXv2Bcz4mPd/cv7TZPf3cWvhdriDnoIMKr
         4BV0bHElOXBvBD4P8tBV011klUDfaZldnaa1qnRsZlaqtqdp9ipFl7Nkr4TQNXb1w/mR
         4rUscsTtXuf064n4ax30HpQJBXBhWGKPw7FBezwUKnb6rCVmv2+Y8KmIokBj6UhiEYs1
         oIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hcRtetVuTOoQ725MyIBgP5sReM3VS+5M9xApQA3DY+c=;
        b=yE4Veo/mUgKu3A/yNlVl7wHplRBBXM4i7TqiP6tSTku63/KIy8Q71whtszgldtFT5x
         Ur+jtCh0KGXDtZjA2e0CCWF9ujbj4KMCQy1YiX9HWziwiKeKBdcwV5dpWmxSnjDCdHzM
         fCDTwpug6sA0Ey+p8Bzs061MBxdr0XLK24u0IXrlFHAVuG1A7NPdENS5e6SscwYpwkSf
         aKSIFcrFCPE2csPfvBLcS1ycRKRrHo0f0KdZ7HmNOkY6JY4SO/eS4XDDHZcF6Rw0GCTQ
         Da3qYo19Nn2gHo+mdPrNAJiMf8uAeyZWgjGflintVUGDvxy90apw2wMc4S0vyhb2JTsT
         FYNw==
X-Gm-Message-State: AOAM533PfQp3y+hW8IEJRCXMiphJZt9i3rzv8Ofjmo6i0fwO5PYKv7c8
        YHA6QO/tVpbzsYTQ+LXGzY03rQhyJO4t
X-Google-Smtp-Source: ABdhPJzAP3ULuOJOOBBXCttLaYBlJ7IaAPEaIMz50fOzTC4v4KNHDM1NinAwMS7IWnSvuFmh839JYPlH9aMP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a05:622a:593:: with SMTP id
 c19mr52225390qtb.240.1636008169248; Wed, 03 Nov 2021 23:42:49 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:00 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-15-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 14/22] perf test: Convert llvm tests to test cases.
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
 tools/perf/tests/llvm.c | 77 +++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 057d6a59a8ea..f27ef00d65e9 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -124,7 +124,7 @@ test_llvm__fetch_bpf_obj(void **p_obj_buf,
 	return ret;
 }
 
-static int test__llvm(struct test_suite *test __maybe_unused, int subtest)
+static int test__llvm(int subtest)
 {
 	int ret;
 	void *obj_buf = NULL;
@@ -148,42 +148,73 @@ static int test__llvm(struct test_suite *test __maybe_unused, int subtest)
 
 	return ret;
 }
+#endif //HAVE_LIBBPF_SUPPORT
 
-static int test__llvm_subtest_get_nr(void)
+static int test__llvm__bpf_base_prog(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
 {
-	return __LLVM_TESTCASE_MAX;
+#ifdef HAVE_LIBBPF_SUPPORT
+	return test__llvm(LLVM_TESTCASE_BASE);
+#else
+	pr_debug("Skip LLVM test because BPF support is not compiled\n");
+	return TEST_SKIP;
+#endif
 }
 
-static const char *test__llvm_subtest_get_desc(int subtest)
-{
-	if ((subtest < 0) || (subtest >= __LLVM_TESTCASE_MAX))
-		return NULL;
-
-	return bpf_source_table[subtest].desc;
-}
-#else //HAVE_LIBBPF_SUPPORT
-static int test__llvm(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static int test__llvm__bpf_test_kbuild_prog(struct test_suite *test __maybe_unused,
+					    int subtest __maybe_unused)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
+	return test__llvm(LLVM_TESTCASE_KBUILD);
+#else
+	pr_debug("Skip LLVM test because BPF support is not compiled\n");
 	return TEST_SKIP;
+#endif
 }
 
-static int test__llvm_subtest_get_nr(void)
+static int test__llvm__bpf_test_prologue_prog(struct test_suite *test __maybe_unused,
+					      int subtest __maybe_unused)
 {
-	return 0;
+#ifdef HAVE_LIBBPF_SUPPORT
+	return test__llvm(LLVM_TESTCASE_BPF_PROLOGUE);
+#else
+	pr_debug("Skip LLVM test because BPF support is not compiled\n");
+	return TEST_SKIP;
+#endif
 }
 
-static const char *test__llvm_subtest_get_desc(int subtest __maybe_unused)
+static int test__llvm__bpf_test_relocation(struct test_suite *test __maybe_unused,
+					   int subtest __maybe_unused)
 {
-	return NULL;
+#ifdef HAVE_LIBBPF_SUPPORT
+	return test__llvm(LLVM_TESTCASE_BPF_RELOCATION);
+#else
+	pr_debug("Skip LLVM test because BPF support is not compiled\n");
+	return TEST_SKIP;
+#endif
 }
-#endif // HAVE_LIBBPF_SUPPORT
+
+
+static struct test_case llvm_tests[] = {
+#ifdef HAVE_LIBBPF_SUPPORT
+	TEST_CASE("Basic BPF llvm compile", llvm__bpf_base_prog),
+	TEST_CASE("kbuild searching", llvm__bpf_test_kbuild_prog),
+	TEST_CASE("Compile source for BPF prologue generation",
+		  llvm__bpf_test_prologue_prog),
+	TEST_CASE("Compile source for BPF relocation", llvm__bpf_test_relocation),
+#else
+	TEST_CASE_REASON("Basic BPF llvm compile", llvm__bpf_base_prog, "not compiled in"),
+	TEST_CASE_REASON("kbuild searching", llvm__bpf_test_kbuild_prog, "not compiled in"),
+	TEST_CASE_REASON("Compile source for BPF prologue generation",
+			llvm__bpf_test_prologue_prog, "not compiled in"),
+	TEST_CASE_REASON("Compile source for BPF relocation",
+			llvm__bpf_test_relocation, "not compiled in"),
+#endif
+	{ .name = NULL, }
+};
 
 struct test_suite suite__llvm = {
 	.desc = "LLVM search and compile",
-	.func = test__llvm,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__llvm_subtest_get_nr,
-		.get_desc	= test__llvm_subtest_get_desc,
-	},
+	.test_cases = llvm_tests,
+	.subtest = { .skip_if_fail = true, },
 };
-- 
2.33.1.1089.g2158813163f-goog

