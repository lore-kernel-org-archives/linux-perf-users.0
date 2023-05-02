Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71246C19F20
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEBWmr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjEBWmX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:42:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51EB3589
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:41:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a8023ccf1so8698306276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067315; x=1685659315;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4ljR53ZCaGFcHXQHUCt//riNKiVKOYfs1jr6/UH5IU=;
        b=GGjX+DbnIxT8t1a0kgOdx316hYjFIfzSSU1v/mga+roisnqY6RM/7DW3aIPt4BysKa
         EgR3MC88At6I9W19h+J4PLTaLaw0VLQbj2w+JM9yuFU3rZ6ND4m97q2j/zEkQMgmcqIB
         TqhfrrNrZYQBmwxU6fcVgeITVGHMwThcvEiZWe8n/pceTy1gRucFNZwsHyl+k8VFYpyD
         M3vflpYu/ebqASzpGIT+dw3iTI0hm9Za5c6gyyRtdfv4Ks7iibdRtSt0bpgegqc84tRn
         pjZ0MSi3exhs5Y4t0Jr9eYCMMvL/vXChsyjWJ4gpQ64hKawd58R8QUa3khK9m3m+rTiL
         RKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067315; x=1685659315;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4ljR53ZCaGFcHXQHUCt//riNKiVKOYfs1jr6/UH5IU=;
        b=Igl0xDhHzoqcgls1SBY2NgyaasDTUG/UabFGbZSSY/HZTDqmlj86r9QmYSD8ixeQe/
         jjs1g6hEhsudmihnEx++9Cd8PM6l/b9EdKGwEXN4uZap0F/1N/aHL77r91YMmJ5kk0im
         tNtGvt6UIx8dMdkWS1UErOiImlmswvt+VfIrMEa+EkalWIgJUz6sz34g4J3AsqKRansX
         TQUKTLBTlioKvp2GWbWSdqLZPQHHcpdQq+bD2YK8J4S82q7j3iZTjw/gavHhD4yfAsEP
         M9vlCWr/XUvnUsUaHxRdibofuQuFPHwxRhRFTmqN5wZ73VVSVENNDclP78aYymOyc33d
         I4UQ==
X-Gm-Message-State: AC+VfDx28+SLitvmbfGEI/s8jldm13xH8gtDC3tveKVe42P8Ks57hNcy
        IOHSLaDm08BGUMyNilWRwsxuUTateXD+
X-Google-Smtp-Source: ACHHUZ7FZwP1StSYgkqnayDzhLFCagX3C5YCZQYe9UMPBXhVAb9W2kaum8VNomZQymzs2BQ4ccahbOU2ovQi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:b8f:47c4:58ed with SMTP
 id w14-20020a056902100e00b00b8f47c458edmr11379278ybt.9.1683067315352; Tue, 02
 May 2023 15:41:55 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:29 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-23-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 22/44] perf test x86 hybrid: Add hybrid extended type checks
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

Assert hybrid extended types are as expected.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index d2a173ba3db9..941a9edfed4e 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -16,12 +16,18 @@ static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_conf
 	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
+static bool test_hybrid_type(const struct evsel *evsel, __u64 expected_config)
+{
+	return (evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT) == expected_config;
+}
+
 static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	return TEST_OK;
 }
@@ -33,11 +39,13 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
@@ -54,6 +62,7 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
@@ -66,6 +75,7 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
@@ -82,6 +92,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
@@ -89,6 +100,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-- 
2.40.1.495.gc816e09b53d-goog

