Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD4C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A38361056
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhKDGqB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhKDGpS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016BDC061230
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v133-20020a25c58b000000b005c20153475dso7434212ybe.17
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qnFYYK7h/c1igs5tdI3kMiUJ6Hx680HhSyVDm1AaQaA=;
        b=fWPVrzjLiBMcc16C6/V64pohYCNREA+KxPx+n4qD+JQA7JQh2P52C1PNH/1aN3vBs/
         lkjG5yr1aaIUvZRGvgGPiSsBvSsDBxoVOOVGIC24Ni+iaxNJmK/vTFCJEbTYvxGsFhIZ
         CYTMv9P4st0jX4qmyiGGVazCt7zwEo1DPXZnI0Boy2T0GfAZlp7+CQp88jV15URL/k2q
         /nT9+Wc+TQ/W58YJ5f86RH3QlP7YRn1srNRP/AzI2UmbD8el5x8mKfMKaW5ZK7Wdw9OA
         Xj3ecaAOSAVliicPU9F6DxBv7NMZh+smPuJ1/kb6qzX4ptZUvPg0uDkc58cVY3l4Aj/n
         AI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qnFYYK7h/c1igs5tdI3kMiUJ6Hx680HhSyVDm1AaQaA=;
        b=iH8b8odjYRtwPMDnP80uK2iYF3/Ms018/0D3he3b8kbFmoNvhH87OIlYy+0qTmrcnF
         Sds2PfP6zMrVrAuekzqxYUbGaUIuDZN6RAuSm82O65aGMxukaAdu21qoKtO5MnVd2N1X
         BwOpQDHiINVWAW0cikwbDHCNciu2KY3PEkBmCZVTLHfdMQyUum85HMp4QG7ncIB5QROv
         l9zkPtJuK7hDlYgpqoT8JCylCFHEIHMoZxyDQeyQS6eiQVRqLn7QIwoXISs+xrdWrWCa
         pjsjKbfi7gW4Q/Hwg3hhVkn6GKwMoxmqg29suc2N9nXdOrLTAQxmazdm1Dj/X7iLEtxL
         Zeuw==
X-Gm-Message-State: AOAM531wUQR95O6Mo3kY3NqbbKlqaEpfIrNFqr6SXu6P0y1AuUobAAi5
        Rq+mwboXVt+oPJA328Bv9zNMwoJInBVs
X-Google-Smtp-Source: ABdhPJxdev99AB3uQgaZnet7SwloRxNUURFK8tJjR60YR/v3H4Ax91xdwmBeFsIwQFdARE9Hrx+acmCYRwDp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:bdce:: with SMTP id
 g14mr51808732ybk.352.1636008159192; Wed, 03 Nov 2021 23:42:39 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:56 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-11-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 10/22] perf test: Convert pmu event tests to test cases.
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
 tools/perf/tests/pmu-events.c | 78 +++++++----------------------------
 1 file changed, 16 insertions(+), 62 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 669eea831793..104de7ba1a93 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -418,7 +418,8 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 }
 
 /* Verify generated events from pmu-events.c are as expected */
-static int test_pmu_event_table(void)
+static int test__pmu_event_table(struct test_suite *test __maybe_unused,
+				 int subtest __maybe_unused)
 {
 	const struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
 	const struct pmu_events_map *map = __test_pmu_get_events_map();
@@ -705,7 +706,8 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 };
 
 /* Test that aliases generated are as expected */
-static int test_aliases(void)
+static int test__aliases(struct test_suite *test __maybe_unused,
+			int subtest __maybe_unused)
 {
 	struct perf_pmu *pmu = NULL;
 	unsigned long i;
@@ -894,7 +896,8 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 
 }
 
-static int test_parsing(void)
+static int test__parsing(struct test_suite *test __maybe_unused,
+			 int subtest __maybe_unused)
 {
 	const struct pmu_events_map *cpus_map = pmu_events_map__find();
 	const struct pmu_events_map *map;
@@ -1036,7 +1039,8 @@ static int metric_parse_fake(const char *str)
  * or all defined cpus via the 'fake_pmu'
  * in parse_events.
  */
-static int test_parsing_fake(void)
+static int test__parsing_fake(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
 {
 	const struct pmu_events_map *map;
 	const struct pmu_event *pe;
@@ -1070,66 +1074,16 @@ static int test_parsing_fake(void)
 	return 0;
 }
 
-static const struct {
-	int (*func)(void);
-	const char *desc;
-} pmu_events_testcase_table[] = {
-	{
-		.func = test_pmu_event_table,
-		.desc = "PMU event table sanity",
-	},
-	{
-		.func = test_aliases,
-		.desc = "PMU event map aliases",
-	},
-	{
-		.func = test_parsing,
-		.desc = "Parsing of PMU event table metrics",
-	},
-	{
-		.func = test_parsing_fake,
-		.desc = "Parsing of PMU event table metrics with fake PMUs",
-	},
+static struct test_case pmu_events_tests[] = {
+	TEST_CASE("PMU event table sanity", pmu_event_table),
+	TEST_CASE("PMU event map aliases", aliases),
+	TEST_CASE_REASON("Parsing of PMU event table metrics", parsing,
+			 "some metrics failed"),
+	TEST_CASE("Parsing of PMU event table metrics with fake PMUs", parsing_fake),
+	{ .name = NULL, }
 };
 
-static const char *test__pmu_events_subtest_get_desc(int subtest)
-{
-	if (subtest < 0 ||
-	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
-		return NULL;
-	return pmu_events_testcase_table[subtest].desc;
-}
-
-static const char *test__pmu_events_subtest_skip_reason(int subtest)
-{
-	if (subtest < 0 ||
-	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
-		return NULL;
-	if (pmu_events_testcase_table[subtest].func != test_parsing)
-		return NULL;
-	return "some metrics failed";
-}
-
-static int test__pmu_events_subtest_get_nr(void)
-{
-	return (int)ARRAY_SIZE(pmu_events_testcase_table);
-}
-
-static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest)
-{
-	if (subtest < 0 ||
-	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
-		return TEST_FAIL;
-	return pmu_events_testcase_table[subtest].func();
-}
-
 struct test_suite suite__pmu_events = {
 	.desc = "PMU events",
-	.func = test__pmu_events,
-	.subtest = {
-		.skip_if_fail	= false,
-		.get_nr		= test__pmu_events_subtest_get_nr,
-		.get_desc	= test__pmu_events_subtest_get_desc,
-		.skip_reason	= test__pmu_events_subtest_skip_reason,
-	},
+	.test_cases = pmu_events_tests,
 };
-- 
2.33.1.1089.g2158813163f-goog

