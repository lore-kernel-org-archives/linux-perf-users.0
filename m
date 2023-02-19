Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BD1C6379F
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBSJgm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBSJgk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:36:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762D12860
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:35:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53688fe539aso16842837b3.16
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1iaZVlYNhiAOA5cs/+UwDX1JeW2DyTfNmupgRycGXY=;
        b=GXX1CCWTT7DpChHpiAo8vxK/43ddF9gck9mQoSZ2hA08LIJ0U1Cu7/SFYa9EJvJFxe
         m8KaqG9d0IPv1H+awLg+uCW+JyHffDXi8RxqbbHwMymD1tyKhcsbVu23oOmaI7vI3Ggo
         A8m02HvwUYluQ/hwtU5heVipo9Wh/I0ByZJ263Ywidlya5sIiWqmTKfXXSjdJB+GukoV
         TUk+iK3GL6mVBoiR/DsqTD45H27yUEHyxZf4toav9JGdIbqj/1fHLuj6CnEuBf5HvRQU
         AhDI6PM1KMSvWtTcjBjzp7iRHFEfMo2PY+iby22NhQ0i2XGrdBrVZdFwwu7jGnEkvvA1
         P5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1iaZVlYNhiAOA5cs/+UwDX1JeW2DyTfNmupgRycGXY=;
        b=C0AXH92mpEh/uKVyDukTXNJcAgqlVvs3/jwp9q/W6YFTYKAwc2EhRme35EOqMPC4Q5
         VIbF8PdTTOmGCjwpXD76evBqqgyd49Yy7i5dYLYMDWsdSoVfcYYryrALur5CVSx8Gseb
         6BRF7jxuJeJPsv3PW9sCZWngp1R4WBvrGEntTtwy+D6tilA8+4y0QQNdDBzCnrZP5hPC
         JB83dss64Uqn8rqEs/cF5fXOjLhLmqT0KsMdr5z2wB1jjhLdaaVIrmJYrlLTLCHdiMar
         vXz+etQokQu6GEWhHSQprzPUIzu+900RsvkwLC9KqgrCGkidSZdMjwI9CKD8+XkpKcqt
         Acug==
X-Gm-Message-State: AO0yUKWOCDUsN9u2kRWLUjuluyfF9qFVzSz6oiDKuEbuYXSlFsmm49Ba
        p2cip4P2YO7PvlrXhPeDouA4jv1sPpt+
X-Google-Smtp-Source: AK7set+1MTqVPBeVJ1iYyp/8DZ7MkvnpE8pT6AIUM7vIfURx7AFVUwdj5cGYtnDmeFMNAIrj/Jd0CiKRDfkv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a0d:ee44:0:b0:52e:e6ed:30a1 with SMTP id
 x65-20020a0dee44000000b0052ee6ed30a1mr1338109ywe.545.1676799225232; Sun, 19
 Feb 2023 01:33:45 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:31 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-35-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 34/51] perf pmu-events: Test parsing metric thresholds with
 the fake PMU
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Test the correctness of metric thresholds by testing them all with the
fake PMU logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 521557c396bc..db2fed0c6993 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1021,12 +1021,34 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
 	return pmu_for_each_sys_metric(test__parsing_fake_callback, NULL);
 }
 
+static int test__parsing_threshold_callback(const struct pmu_metric *pm,
+					const struct pmu_metrics_table *table __maybe_unused,
+					void *data __maybe_unused)
+{
+	if (!pm->metric_threshold)
+		return 0;
+	return metric_parse_fake(pm->metric_name, pm->metric_threshold);
+}
+
+static int test__parsing_threshold(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
+{
+	int err = 0;
+
+	err = pmu_for_each_core_metric(test__parsing_threshold_callback, NULL);
+	if (err)
+		return err;
+
+	return pmu_for_each_sys_metric(test__parsing_threshold_callback, NULL);
+}
+
 static struct test_case pmu_events_tests[] = {
 	TEST_CASE("PMU event table sanity", pmu_event_table),
 	TEST_CASE("PMU event map aliases", aliases),
 	TEST_CASE_REASON("Parsing of PMU event table metrics", parsing,
 			 "some metrics failed"),
 	TEST_CASE("Parsing of PMU event table metrics with fake PMUs", parsing_fake),
+	TEST_CASE("Parsing of metric thresholds with fake PMUs", parsing_threshold),
 	{ .name = NULL, }
 };
 
-- 
2.39.2.637.g21b0678d19-goog

