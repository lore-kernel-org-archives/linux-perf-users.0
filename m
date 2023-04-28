Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A1DC77B61
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjD1Hkz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbjD1Hki (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE64234
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:40:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a75194eebso2098691276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667607; x=1685259607;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qq4G/Esc0Oue6FYAx7cV0j1FiAAwFCfIaU2APuStCt4=;
        b=wl+uGpYkga/+gsi520y+IfuDtokWE1MMn/hq9MWVqwzovUkgbz1YO+jXELauNVj+Wm
         fhyn8C7fb8k7K2RS/hHmOhpWlud19czD5ZjDU603nmVdDm4ALQ9+ouqC89AmbXXaFyuX
         vshhMgMW5e1AcIxcqZZA8qF8/gnc+V2DdDTS9x7XH8Rs2BFd8SdqDxHTU21n0BTiZbAa
         jKqB7u9FMOaNgwxVsbkCRJsnYLVlhcbdxy+6nYM9QmjEHPhiONVnEpyFspuNszc2gJC9
         /5C+Wg2H65ry1nV8+TREbFZubQnBaRFQt3CIFENePpNj89hgLUjWcTTBPQx7rwqh7Iej
         3Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667607; x=1685259607;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qq4G/Esc0Oue6FYAx7cV0j1FiAAwFCfIaU2APuStCt4=;
        b=PSGyHhmbTHcrdEEj6eTjrHh8ELVzzSMqZ6GPHCfQr1jeP1ep7LwzMX4e2AM/NVY9tg
         MTlSNzWaqoVwTjRRGN1fh7B9xKd6l9CytRnovWBnU9RyO/tJogkOkVGCb3TbypBJieQt
         +8kMvVWn0MgIf3735oJC0NZKPAC2k7Evz1nBU7X3r8LD8NtjaSNUfJsHMjxt4iUuKXku
         8PnVsdVaXHn40aA8d6pLh10mxQjBktClLWb6nPGpEJLOgGA+FmaCM6OPd5JLCEm0dTI3
         blh07rEctufu87sEYStjuEyQ12vRdo3n8SOX5R4M2mQIfVojQPOTuqXIBSAWEkVES5SJ
         r/0w==
X-Gm-Message-State: AC+VfDwKYh5Iluv9hJauFckSQT5T8gvTwe06PlxiUvmC+ccaHNzbwXaZ
        IFGfkKdvkakUhEpjxmndc/xMqg+40V0r
X-Google-Smtp-Source: ACHHUZ6E2vk6xSJry54MCPzGwPR+YrYXjS9lrElpk9ypg3Ac51kL8KYyoucQ9SyRwjdCFU77p/FYg19XCAaU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a81:ef04:0:b0:543:bbdb:8c2b with SMTP id
 o4-20020a81ef04000000b00543bbdb8c2bmr2672792ywm.10.1682667606810; Fri, 28 Apr
 2023 00:40:06 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:37 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-12-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 11/43] perf test: Use valid for PMU tests
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

Rather than skip all tests in test__events_pmu if PMU cpu isn't
present, use the per-test valid test. This allows the running of
software PMU tests on hybrid and arm systems.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 35b35a5c795c..767b296b91e4 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1430,6 +1430,11 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static bool test__pmu_cpu_valid(void)
+{
+	return !!perf_pmu__find("cpu");
+}
+
 static bool test__intel_pt_valid(void)
 {
 	return !!perf_pmu__find("intel_pt");
@@ -1979,21 +1984,25 @@ static const struct evlist_test test__events[] = {
 static const struct evlist_test test__events_pmu[] = {
 	{
 		.name  = "cpu/config=10,config1,config2=3,period=1000/u",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_pmu,
 		/* 0 */
 	},
 	{
 		.name  = "cpu/config=1,name=krava/u,cpu/config=2/u",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_pmu_name,
 		/* 1 */
 	},
 	{
 		.name  = "cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_pmu_partial_time_callgraph,
 		/* 2 */
 	},
 	{
 		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
@@ -2209,21 +2218,6 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
 	return test_terms(test__terms, ARRAY_SIZE(test__terms));
 }
 
-static int test_pmu(void)
-{
-	struct stat st;
-	char path[PATH_MAX];
-	int ret;
-
-	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/format/",
-		 sysfs__mountpoint());
-
-	ret = stat(path, &st);
-	if (ret)
-		pr_debug("omitting PMU cpu tests\n");
-	return !ret;
-}
-
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_pmu *pmu;
@@ -2307,9 +2301,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 
 static int test__pmu_events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	if (!test_pmu())
-		return TEST_SKIP;
-
 	return test_events(test__events_pmu, ARRAY_SIZE(test__events_pmu));
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

