Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F844C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D35460F4A
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhJMRuY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbhJMRth (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:49:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B82C061764
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so3918331ybm.18
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z2OcCRUvnaTF0XXoo+0opwWMuFzb6rVbgkzabboWxgI=;
        b=N6E57iQ6NHyl2pXW3P9Ww5vk0+94VXFNYbkf7fZ7AkmnOjSB7BwyP4YLiyqZxeavr9
         BM4R62D8z04g/GII9Vt0aDZfVHw49PNxe8inTXxMLju8ospba9Q05Q0/neihmIpAWVo8
         sVINV9TKXxh6rFHbyoiquRQuO6qgiTQEejbuv6Y7VGAc6olrxHCLnHroFlrLV1TWujbD
         Az27BF+iYt5Zwsb7Saz1QbGoyXuBaSuhVTrvucldEXlIdrL70QVU1MHbN2YBXXMltMzc
         kW47ZUbQhh5RNiM32SA55bRXkUSOzUrRLeScA4hXV74Zv+vOHdWgGCQDCBGIqzIFsZQ5
         J5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z2OcCRUvnaTF0XXoo+0opwWMuFzb6rVbgkzabboWxgI=;
        b=FhtQhKEOzkzUnoSNhU/DMW3k32W5LFlJGWqs8mVQf9heIzXMP7CuDixTOa+KMln6TP
         iSnf9Lfm1eHJxyZZbVsxrTsACXe2BjZaPWTRWiK+sjFG9zUmg0rcADa5uEesIaTvZb2D
         3hC6NN+Doj/EdNiVRdfrZQZvhPciDVhyGQuYBQrFnghuB3wkrfxhMIthdwY6YdsuE93i
         7F7NVo19LtAlPo5tLmdzSMSZcerc+9XQdT73VcFoP3uzsL4wZ+PCi+pQv7r877AO2YOR
         Xzb0e4EdygSx+xWu4ZaR6mPuHTn2I3XPSBR3OVp0qNrFF//Yc/TmAz1nlJJEZcSmr49I
         W/eg==
X-Gm-Message-State: AOAM531GRim+XhBdKcK4eLNIXKo+LHq4OttOJHlDVJqaronnA0x+WBDF
        3occGjKcVb0HElrjvlLha42EGVUTrt2k
X-Google-Smtp-Source: ABdhPJy6Kk8Vy6cslBLQ90nwJOF1BtyH7FoXz9nONFdveSBBHxXBrl30dm8HwOhuJNlJ8CfW28v7mn7C/si8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:5545:: with SMTP id
 j66mr781411ybb.288.1634147215360; Wed, 13 Oct 2021 10:46:55 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:56 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-15-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 14/22] perf test: Convert llvm tests to test cases.
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
2.33.0.882.g93a45727a2-goog

