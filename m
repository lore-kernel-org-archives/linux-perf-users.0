Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A9EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501BA6113E
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhJMRup (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbhJMRuZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968DC061786
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so2485908ybh.10
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MixijYGN9CCr0NyW9vqbakC6HS4crj7i5quLcsx+Fb0=;
        b=eKU3CFgL7gCHQVaMSAE6b77FN9kg7Bb0NBx1AexacLmXJu2gMs2+BEWG/3C8qrrm5v
         vp1r9RGFi67/9z08rVDTpXfeGa6NGehaki9LR6TgeBTOZfWjlKrU4jEKwhzqfA5kyD78
         F6eurtm+QntTU+jiIfNfVAm2gTtYsriKgGrekdLIlG4n4EYh3JmP0vsvdh7QDyh0gsJ7
         5QF4Bday20CzT0DiQQoLItrQ93kRi4xmIpFqrtNN9y26RgMtMK5DHQxHU3b+Tp5hHGIw
         bF/kShoEj6NgMckrdgEXK9AVtiaxtOw8bUlMgyn0JMVUG5FtlkxjjuFyPW+oT1sC7X6r
         v3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MixijYGN9CCr0NyW9vqbakC6HS4crj7i5quLcsx+Fb0=;
        b=PlSWkq3BsQAHEVUsZgsNQsFVCb6xP2z0rCNu8xNjRNMwaowMkD7WJxxS5C6taFGRqE
         LZP0kuyM/YcMKvzZQMeKvRbCKWUDxbkEabdruq+QMsHd5AjdDTaXG8ibsyuNa0omkQMZ
         FfCdFuMTAy8FUSfZRVRAw33pNrtSVxIFPbm2mnRwz1WFJtrXwV/22g1F7+oFdxd2Y6X5
         tte3YYUblyZteLDYb3tZvEdq4H04FuW2XDlW2Kuvrmf3LGpov/MlNR2ELkM4Z6NTRyQ2
         UwV+ZCGYvaNA6y1OeSD9qgW35WOMP7BxG/LrLBe5W6vqHmWll8+67VwVWg8LjfuV4kMf
         IaFg==
X-Gm-Message-State: AOAM5323J06H85I5ZTkWMOgFStgdIS/4SZYq5PcXGdCVXdQLp9/e+ZBP
        a1Vzi07u/poM1rYo4oLY8+gmOJCFGjoJ
X-Google-Smtp-Source: ABdhPJyuRL6g2+TpFuUr4jKuay4VgorUL0tffk4/e6QnyklAgbKifQA+oP4iDVAwwmxwr4nwUGOo9H6aTLvc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:7146:: with SMTP id
 m67mr769128ybc.353.1634147229946; Wed, 13 Oct 2021 10:47:09 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:46:02 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-21-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 20/22] perf test: TSC test, remove is_supported use
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
2.33.0.882.g93a45727a2-goog

