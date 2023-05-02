Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D0C7EE21
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjEBWlM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEBWlM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:41:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6285359C
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:40:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e65b34aso7799132276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067229; x=1685659229;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOnZ2OKjlCq2CMx90UX2ZPWCEDMEl/hBSCdauBOSwyg=;
        b=IoTJMyEobSDIJv1QyUDMmxGGV9wHG4+zMd6uosrqg//eIBbse9xgINyme8g2w9CntC
         DFPbZ3X8+n3aJsIiNC2/Ul7Bdojx6o5tVgszEn9B/qpRuVxKNt9Ow8hw1pKeqZLeYcd1
         IbJoq6P1NIS4QZEyvKfTKTSOANbl+4Bnau+JSClba+FF2atLEFMO2sAVnVw+Or5aZVRI
         2EfixSZzj+Q8A3CR0a47urNbRvtSK/ELNieLxZd5ikydlCWCZTF5VXkCR7GH503SqaoI
         8rESINzQAlxOqwcyWsxz/xdToKiviJMW16wIHCHkAJTqjmQrVWrfe+L0Z4A6iSbV3UTh
         JldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067229; x=1685659229;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOnZ2OKjlCq2CMx90UX2ZPWCEDMEl/hBSCdauBOSwyg=;
        b=aaHGp7zPbxf0cP8tP03L2ulfo1YDUP/O0vtrksjFYX4QZ7a23m0Ts6m9KEOQoFHQm9
         02rAIhxEbbM9BS+GpHCYTPx+1HNji0V9s1sjB1KrYy5SlIRO0Dhcfjnx0nji56KjQCeA
         Bj57FMa+HO9CPB38KIwMPelkUcFGJIf/X0cHMde8VdXfgWr5525g7GUWABc9q7MAbUIf
         jhFDlB8Q1m3n+zhEJ2nKi2f54KKr00B9gRWFQmJfJzd+CiER8sMkxPH5+lJ11ljau44N
         ChehUsM9Fwglr5QcbPYRVTC7WwPh+qp1MFdogkxSBK2XaDcHe5ZI0+8M0b56ML/WQpGB
         MhFw==
X-Gm-Message-State: AC+VfDxmPETMECWwhgOtPcHSKSQcw22Rch+eNbkoNVvVFt9ohxYG9Aic
        NdqKJtwBaQkudvbIftFFMrdHHmvbFbZ6
X-Google-Smtp-Source: ACHHUZ7bkS+Y09SwE9jvgupciznHDby6NANZZhdZ47txsHbvKXbziwG5oshPrZcmZcSd7aM/aAZ/WxBv1xJX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:d250:0:b0:b9e:2f92:52b with SMTP id
 j77-20020a25d250000000b00b9e2f92052bmr2684908ybg.2.1683067229666; Tue, 02 May
 2023 15:40:29 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:18 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-12-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 11/44] perf test: Use valid for PMU tests
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
index 3721a2182f45..c06fa7653ac2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1432,6 +1432,11 @@ static int test__checkevent_config_cache(struct evlist *evlist)
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
@@ -1981,21 +1986,25 @@ static const struct evlist_test test__events[] = {
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
@@ -2211,21 +2220,6 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
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
@@ -2311,9 +2305,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 
 static int test__pmu_events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	if (!test_pmu())
-		return TEST_SKIP;
-
 	return test_events(test__events_pmu, ARRAY_SIZE(test__events_pmu));
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

