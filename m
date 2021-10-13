Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF58C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A360F4A
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhJMRug (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbhJMRuY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986BC0613F0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so4008782ybb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qd8yfvf1tsu8pyYgjgw0dwDMJ8bNdB+xGQEacBsai/o=;
        b=enY+7wo79cNAfEy8DpQDTnsQhGMZ7AgPnHn3gejKwqwMajmLenk78uty8hCTY4ZCfz
         SlXMIc0MfZ2Tq7ozQ06zCq8nyre8pU2432hFZ6gMvS7Qfmwuz3oCp5kcESIaoX2Z4dYF
         2BW7KN1ig5P7dIyuW98nJq8gT9WoSf0I+/+d7js2TwbPTohjMsDk7pcJ0u0E+Ds0Ic6F
         aSjc4o1xRibMLykEZR0nbe1f4M4SAV1sTgT5/uv4n/8GZTIO/tnbTo5vIA7AJ1s5qw4T
         6XlphhiRQS6JKsSZqblRTIMppNZtRjDLSrln7995kpRj5rL8uiqp32bt+Gqzy43gR2QA
         /quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qd8yfvf1tsu8pyYgjgw0dwDMJ8bNdB+xGQEacBsai/o=;
        b=BoTrLal7vpYfOIB6Q2/RE2Be3Ie1g+R/8l1GiuV8pK8Rdxw/U8B5mjI+x7fmXpfT85
         oBETtbj5vUbZ6AXPca5DmMi6ptZGt4QtkS2AGOsg93G1AktZJRjBOt4voHqun/f/Sczj
         A3s7o0/z/nqq2zKH5W2K7DdNv7PcOtCku+P1E7C3YHtbBJLDvz8tmmIxRLU0pPCIh04Z
         Nj/7xyWi0nLTHwbWGvHYQMcf2OFlUBowzbb22wLd2BXk+wUZWhfAZ01mWFSJCsWslh9e
         fnykcIuIxEinsRfY1HqtbsQIdqZMKrOcYNoSIEZFrAOR7YVGfLvpnAcnQQudfwkqIpV5
         UdRQ==
X-Gm-Message-State: AOAM533U6oseUVSDAHmSve5J9QpfurmR5WpTKlyeNF0RnDU+/iLNUPnD
        svPEu66b3LYDLZE5ZcGR4Vw/O40BMdmT
X-Google-Smtp-Source: ABdhPJwniRM3H/bw+qTNvCxBfmzQkI5bnpfy/c5ptf3TRbO8NSt09jY3XBix9TfMWyH2EESWHAt9sk2wl1An
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a05:6902:154b:: with SMTP id
 r11mr981686ybu.208.1634147227488; Wed, 13 Oct 2021 10:47:07 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:46:01 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-20-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 19/22] perf test: BP tests, remove is_supported use
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

Migrate the is_supported functionality to returning TEST_SKIP.
Motivation is kunit has no is_supported function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bp_account.c         | 45 +++++++++++----------------
 tools/perf/tests/bp_signal.c          | 43 ++++---------------------
 tools/perf/tests/bp_signal_overflow.c | 16 ++++------
 tools/perf/tests/tests.h              | 21 ++++++++++++-
 4 files changed, 51 insertions(+), 74 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index e4f7b635ffef..d1ebb5561e5b 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -19,6 +19,19 @@
 #include "../perf-sys.h"
 #include "cloexec.h"
 
+/*
+ * PowerPC and S390 do not support creation of instruction breakpoints using the
+ * perf_event interface.
+ *
+ * Just disable the test for these architectures until these issues are
+ * resolved.
+ */
+#if defined(__powerpc__) || defined(__s390x__)
+#define BP_ACCOUNT_IS_SUPPORTED 0
+#else
+#define BP_ACCOUNT_IS_SUPPORTED 1
+#endif
+
 static volatile long the_var;
 
 static noinline int test_function(void)
@@ -180,6 +193,11 @@ static int test__bp_accounting(struct test_suite *test __maybe_unused, int subte
 	int bp_cnt = detect_cnt(true);
 	int share  = detect_share(wp_cnt, bp_cnt);
 
+	if (!BP_ACCOUNT_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture");
+		return TEST_SKIP;
+	}
+
 	pr_debug("watchpoints count %d, breakpoints count %d, has_ioctl %d, share %d\n",
 		 wp_cnt, bp_cnt, has_ioctl, share);
 
@@ -189,29 +207,4 @@ static int test__bp_accounting(struct test_suite *test __maybe_unused, int subte
 	return bp_accounting(wp_cnt, share);
 }
 
-static bool test__bp_account_is_supported(void)
-{
-	/*
-	 * PowerPC and S390 do not support creation of instruction
-	 * breakpoints using the perf_event interface.
-	 *
-	 * Just disable the test for these architectures until these
-	 * issues are resolved.
-	 */
-#if defined(__powerpc__) || defined(__s390x__)
-	return false;
-#else
-	return true;
-#endif
-}
-
-static struct test_case bp_accounting_tests[] = {
-	TEST_CASE("Breakpoint accounting", bp_accounting),
-	{ .name = NULL, }
-};
-
-struct test_suite suite__bp_accounting = {
-	.desc = "Breakpoint accounting",
-	.test_cases = bp_accounting_tests,
-	.is_supported = test__bp_account_is_supported,
-};
+DEFINE_SUITE("Breakpoint accounting", bp_accounting);
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 1676e3a11906..1f2908f02389 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -166,6 +166,11 @@ static int test__bp_signal(struct test_suite *test __maybe_unused, int subtest _
 	struct sigaction sa;
 	long long count1, count2, count3;
 
+	if (!BP_SIGNAL_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture");
+		return TEST_SKIP;
+	}
+
 	/* setup SIGIO signal handler */
 	memset(&sa, 0, sizeof(struct sigaction));
 	sa.sa_sigaction = (void *) sig_handler;
@@ -285,40 +290,4 @@ static int test__bp_signal(struct test_suite *test __maybe_unused, int subtest _
 		TEST_OK : TEST_FAIL;
 }
 
-bool test__bp_signal_is_supported(void)
-{
-	/*
-	 * PowerPC and S390 do not support creation of instruction
-	 * breakpoints using the perf_event interface.
-	 *
-	 * ARM requires explicit rounding down of the instruction
-	 * pointer in Thumb mode, and then requires the single-step
-	 * to be handled explicitly in the overflow handler to avoid
-	 * stepping into the SIGIO handler and getting stuck on the
-	 * breakpointed instruction.
-	 *
-	 * Since arm64 has the same issue with arm for the single-step
-	 * handling, this case also gets stuck on the breakpointed
-	 * instruction.
-	 *
-	 * Just disable the test for these architectures until these
-	 * issues are resolved.
-	 */
-#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || \
-    defined(__aarch64__)
-	return false;
-#else
-	return true;
-#endif
-}
-
-static struct test_case bp_signal_tests[] = {
-	TEST_CASE("Breakpoint overflow signal handler", bp_signal),
-	{ .name = NULL, }
-};
-
-struct test_suite suite__bp_signal = {
-	.desc = "Breakpoint overflow signal handler",
-	.test_cases = bp_signal_tests,
-	.is_supported = test__bp_signal_is_supported,
-};
+DEFINE_SUITE("Breakpoint overflow signal handler", bp_signal);
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index bc1f13851750..4e897c2cf26b 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -66,6 +66,11 @@ static int test__bp_signal_overflow(struct test_suite *test __maybe_unused, int
 	long long count;
 	int fd, i, fails = 0;
 
+	if (!BP_SIGNAL_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture");
+		return TEST_SKIP;
+	}
+
 	/* setup SIGIO signal handler */
 	memset(&sa, 0, sizeof(struct sigaction));
 	sa.sa_sigaction = (void *) sig_handler;
@@ -134,13 +139,4 @@ static int test__bp_signal_overflow(struct test_suite *test __maybe_unused, int
 	return fails ? TEST_FAIL : TEST_OK;
 }
 
-static struct test_case bp_signal_overflow_tests[] = {
-	TEST_CASE("Breakpoint overflow sampling", bp_signal_overflow),
-	{ .name = NULL, }
-};
-
-struct test_suite suite__bp_signal_overflow = {
-	.desc = "Breakpoint overflow sampling",
-	.test_cases = bp_signal_overflow_tests,
-	.is_supported = test__bp_signal_is_supported,
-};
+DEFINE_SUITE("Breakpoint overflow sampling", bp_signal_overflow);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cae33c375d55..958f94dcc94c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -151,7 +151,26 @@ DECLARE_SUITE(expand_cgroup_events);
 DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 
-bool test__bp_signal_is_supported(void);
+/*
+ * PowerPC and S390 do not support creation of instruction breakpoints using the
+ * perf_event interface.
+ *
+ * ARM requires explicit rounding down of the instruction pointer in Thumb mode,
+ * and then requires the single-step to be handled explicitly in the overflow
+ * handler to avoid stepping into the SIGIO handler and getting stuck on the
+ * breakpointed instruction.
+ *
+ * Since arm64 has the same issue with arm for the single-step handling, this
+ * case also gets stuck on the breakpointed instruction.
+ *
+ * Just disable the test for these architectures until these issues are
+ * resolved.
+ */
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || defined(__aarch64__)
+#define BP_SIGNAL_IS_SUPPORTED 0
+#else
+#define BP_SIGNAL_IS_SUPPORTED 1
+#endif
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
-- 
2.33.0.882.g93a45727a2-goog

