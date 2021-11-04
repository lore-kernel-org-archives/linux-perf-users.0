Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA1C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D08460ED5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhKDGsE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhKDGqr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:46:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4FC0797BA
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:43:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so7505756ybt.15
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CdsFmOlyWsgFjgfelguAA5y36BVgm/9S1PvBQhMMmRk=;
        b=G+8ddQqZrpC+bfwfQal+H3uEdG5bbtUrNADJZg1gXhcBuO7AlQFpehucxrqKf0sQaD
         0rClpnXmIiojfHncf/8s0PF+/IuNs/L9wlh5nUwm1QOwJQQJ8onj/KZQQYRURedc8o9+
         B48cvkTfGLtbPLwLNAUoSyfc4zO3A0b0iFxfcL/GkcScW3zzOIZPxUSCWhV7SAGKYCY/
         pLJeE6qcBhine5BRG/pIyZ+ghiozkl32N3OMu4fftkUBl6D67JghtgAIc31iaRMMWgiB
         WiPGOFodWY0iI/UJbey/SkNvMshmq8F3YKys0drPzOGAPwCMDWqeZidBNSw+lCUPQLkO
         NWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CdsFmOlyWsgFjgfelguAA5y36BVgm/9S1PvBQhMMmRk=;
        b=jO8Fiu4r/02/kSJAY40TkN1vRJmCgvB8N2BXYXo1VUNP+4G3wGuhJ1lBJq307m0a0Q
         leG0yGRLZAH2c08UuLxAPfnK1gpAxyFQhcnYFcgsSULAqcRazIMSkioymmej8cuzyOPR
         ncPgSTW+Xb7U+u4PSnHV1LzVEbb1a52XPo51gCbaLRzIt96gjk1LKbtnOBkZqVw0UyGI
         9CDR9JsHPVjpAk/gyGcv5peaSoJpAm2iFAKHu2TZ5Kfp/EfbMCtDIZcstftCzZEap1rJ
         Kg/U+JkI1oQivX8WnbaJDJOYFpBSFmu2Px6ngnnEHmZumg5TMt/UKIIR2j3godMdK+cZ
         82Cg==
X-Gm-Message-State: AOAM5321xcYWmljrw7un8PcjwaPA8iVintXjh8Mp8M53fVgsdkFdL9/Q
        zKDOFq5oWNkZ8mX/cHLJKOMPTkE2ln1o
X-Google-Smtp-Source: ABdhPJz9IkpPyxsTr362ho+MUfInRifsp6szpn7KwxkP0W/s4scJT7V20NeNNG4z3FTxQVe/enBFZQ5R6O1i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:2703:: with SMTP id
 n3mr52159027ybn.276.1636008181600; Wed, 03 Nov 2021 23:43:01 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:05 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-20-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 19/22] perf test: BP tests, remove is_supported use
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
2.33.1.1089.g2158813163f-goog

