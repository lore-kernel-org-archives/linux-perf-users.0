Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B55C77B60
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjD1Hm7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjD1Hm2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:42:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268334C03
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:41:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a8023ccf1so2862112276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667685; x=1685259685;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub3nsWvIc7LdAE08OZJfmvPZS6krUrWnEa75g5zW2eY=;
        b=zH5NPw45FPWDbFBzIoqrrHxfNMYl+/FHzLVh0VUHKYD1CL4iTfOzqnEkpdOovP6vBd
         6ErMgXHS9hpP2qMo7FzUXGsigmGmfSCy99b+PdKiMcZthLBsAbaO6fPaDuH5bMiSMmBR
         gPpBCZ+E5NY7BoZl+BeioNOKv55swavDGlg7ZDSkeysj0i8JahYcvFsNakhCWtQQGb4E
         lATqVkZ0m+nNVRelNw4pxzjGaGRFjlCyOL1ZBu8W8DaZE9NGgh9B5sW9f0WKSMqrId/S
         wJcxFsxmETboujij0bvGzgDNgEclbz/Uwnj9Eb1lEMRfC/LZpe8h8/X2vit6afFEFWaU
         vxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667685; x=1685259685;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub3nsWvIc7LdAE08OZJfmvPZS6krUrWnEa75g5zW2eY=;
        b=LJcY5GbKTOyyFQV3mYnGFLtorTwPHJy48cq1J7Vo5mspxHRhNU9tKNB2/CInhOxE1i
         TmHNN+NWze7viIzfSDd4N+jDXErr6hD4U0jqd2kRiFsZoZQM5MuKP7eLPlrr/6dnILpI
         vZIzSMnfl9Q7j3QfTxJIl24fBsRAhrKhHySFiQu+5Cxtf3iFzvZMZz91IXLE2xNtv1y9
         U9wnFkMaJbx5ZXjSHJUWJguXi5y1fzdRlDOnMAUBrMTIYb9BHnxIVWml4vOqpD07Agmc
         oD0HC3uoqQ6AId812Fm2F3OnVcMH06izaxHMyYTgrkkMfKemC9TCtEoBfB/rsSv6LRqN
         VLUQ==
X-Gm-Message-State: AC+VfDziA68fzRZgCdSSIJWxkpn8GsUgs1TgjCj5QyCd5TVof7K79F1B
        2UllyTDaFV6WW9I/81q9IYrg36pcCr0b
X-Google-Smtp-Source: ACHHUZ76a/SyFQYp91knAgDgs/R4eCGFacKq/tFh4C6q/uZx5bCT9c1RaemuDlwxMlcmM6x7Bxy2gkYM/dgI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:154b:b0:b8f:6ab7:9328 with SMTP
 id r11-20020a056902154b00b00b8f6ab79328mr2574601ybu.2.1682667684841; Fri, 28
 Apr 2023 00:41:24 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:47 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-22-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 21/43] perf test x86 hybrid: Update test expectations
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Don't assume evlist order. Switch to a loop rather than depend on
evlist order for raw events test.

Update hybrid event expectations. Previous values were based on
parsing legacy hardware events from sysfs, update to the correct PMU
specific legacy values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 54 ++++++++++++++----------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 0f99cfd116ee..d2a173ba3db9 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -11,13 +11,18 @@ static bool test_config(const struct evsel *evsel, __u64 expected_config)
 	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
+static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
+{
+	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
+}
+
 static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	return TEST_OK;
 }
 
@@ -27,13 +32,13 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -48,8 +53,8 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -60,8 +65,8 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
@@ -76,15 +81,15 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -93,22 +98,15 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 
 static int test__hybrid_raw1(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
 
-	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
-		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-		return TEST_OK;
-	}
-
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+	perf_evlist__for_each_evsel(&evlist->core, evsel) {
+		struct perf_pmu *pmu = perf_pmu__find_by_type(evsel->attr.type);
 
-	/* The type of second event is randome value */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+		TEST_ASSERT_VAL("missing pmu", pmu);
+		TEST_ASSERT_VAL("unexpected pmu", !strncmp(pmu->name, "cpu_", 4));
+		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
+	}
 	return TEST_OK;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

