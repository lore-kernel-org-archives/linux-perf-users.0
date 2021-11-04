Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5FCC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A7560EB4
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhKDGsL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhKDGrZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:47:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA267C0797BC
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:43:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so7445714ybe.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KzZeBe+O8SKYymb2H1BN3nOBX8ztzQBCRsWikxLb7wk=;
        b=FZQUUxZNWSDvNS/BTKjZQZBIBSViNnqULGO4e40pX+85w5Sgftch/C5Q+XlgjaN+yE
         tVk4mDPczi+6CD6z/mioI5JA+cY4GjomN4DsPvUbl4rwqzty+DXJLZVw0BMQIYMAX7q2
         CMYIpzj9dynUgfe4RV7W7Qia+3T01gS6D3HzN2JKM2IM0aQQw7654rSCmyOt/3RpRObx
         1HFQpxD40lPYJJtfa+yGovEnTdWSpYlVIUPBT+1Knq/BFlM9UeHJPAZXD7rTUSY2HyQf
         xvpejjJqX5Des1veW1pBVjPjvZJzMmz+Dgp52sqPbcUOykAyiCB1/8ZUksMBJd/UWj9y
         +zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KzZeBe+O8SKYymb2H1BN3nOBX8ztzQBCRsWikxLb7wk=;
        b=Kd/inB6yrBYzvzHmzBwSJ5rnGgKPUX81QqtJpfEHcD41AltHkuD/U1wlfLkgzhzhI3
         hO0IiMeaWP5TafBmN1OJjdaXnHbm1NdocXTnJEfd9kkatu9Bul/zGgGBgDf3gm/wsKbg
         2qSAE/sIjql7KHHxU97hUZpDFAzLJONR6bcuxlhmYepjq9l70F/52d54kwubu+ZE/GCZ
         a/PU1RXIDvxjaJD+BTQkasw2EvA2ct6I7wBCeG3loguultRUGzNYB0qlU4d9tWVwmtiI
         Rib/pg68WeigcA92+z6R0lmuy6+oo5B8wXnmC97CIWmdM7vYIGXF1vKwQvZeLUCOIDqQ
         EMqg==
X-Gm-Message-State: AOAM533iyKm2fhgnvkU6A6OCxr+61dfLo8kc+JfpAJVNZ76jCy5G/LAg
        uXCUl5i8UDxpEjRmmcAk/WSUqX6L/KY9
X-Google-Smtp-Source: ABdhPJzvzyAhGmbbAYoN8rpH+tUKmRC0oOVd9ipehXN0lpWYMc9oAjXdjOmQkYD3C3LWW2fVeNQDXfRVkmDk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:9c02:: with SMTP id
 c2mr32564801ybo.137.1636008183976; Wed, 03 Nov 2021 23:43:03 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:06 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-21-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 20/22] perf test: TSC test, remove is_supported use
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
 tools/perf/tests/perf-time-to-tsc.c | 39 ++++++++++++-----------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 594013e94ed0..d12d0ad81801 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -23,6 +23,16 @@
 #include "pmu.h"
 #include "pmu-hybrid.h"
 
+/*
+ * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.  Just
+ * enable the test for x86_64/i386 and Arm64 archs.
+ */
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
+#define TSC_IS_SUPPORTED 1
+#else
+#define TSC_IS_SUPPORTED 0
+#endif
+
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
 		pr_debug(#x " failed!\n");	\
@@ -69,6 +79,11 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	u64 test_time, comm1_time = 0, comm2_time = 0;
 	struct mmap *md;
 
+	if (!TSC_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture");
+		return TEST_SKIP;
+	}
+
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
 
@@ -185,26 +200,4 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	return err;
 }
 
-static bool test__tsc_is_supported(void)
-{
-	/*
-	 * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.
-	 * Just enable the test for x86_64/i386 and Arm64 archs.
-	 */
-#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
-	return true;
-#else
-	return false;
-#endif
-}
-
-static struct test_case perf_time_to_tsc_tests[] = {
-	TEST_CASE("Convert perf time to TSC", perf_time_to_tsc),
-	{ .name = NULL, }
-};
-
-struct test_suite suite__perf_time_to_tsc = {
-	.desc = "Convert perf time to TSC",
-	.test_cases = perf_time_to_tsc_tests,
-	.is_supported = test__tsc_is_supported,
-};
+DEFINE_SUITE("Convert perf time to TSC", perf_time_to_tsc);
-- 
2.33.1.1089.g2158813163f-goog

