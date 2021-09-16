Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D96C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B2260FA0
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbhIPMlE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:41:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3840 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbhIPMlD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 08:41:03 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H9GnM0KHsz67bPy;
        Thu, 16 Sep 2021 20:37:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 14:39:40 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 13:39:36 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <irogers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <liuqi115@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/5] perf test: Add pmu-event test for event described as "config="
Date:   Thu, 16 Sep 2021 20:34:24 +0800
Message-ID: <1631795665-240946-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1631795665-240946-1-git-send-email-john.garry@huawei.com>
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a new test event for a system event whose event member is in form
"config=".

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/test/test_soc/sys/uncore.json        |  7 ++++++
 tools/perf/tests/pmu-events.c                 | 25 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
index 0f681a6e10ea..c7e7528db315 100644
--- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
+++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
@@ -6,4 +6,11 @@
            "Unit": "sys_ddr_pmu",
            "Compat": "v8"
    },
+   {
+           "BriefDescription": "ccn read-cycles event",
+           "ConfigCode": "0x2c",
+           "EventName": "sys_ccn_pmu.read_cycles",
+           "Unit": "sys_ccn_pmu",
+           "Compat": "0x01"
+   }
 ]
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index adfc17f51c7b..f14266a4c513 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -208,8 +208,23 @@ static const struct perf_pmu_test_event sys_ddr_pmu_write_cycles = {
 	.matching_pmu = "uncore_sys_ddr_pmu",
 };
 
+static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
+	.event = {
+		.name = "sys_ccn_pmu.read_cycles",
+		.event = "config=0x2c",
+		.desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
+		.topic = "uncore",
+		.pmu = "uncore_sys_ccn_pmu",
+		.compat = "0x01",
+	},
+	.alias_str = "config=0x2c",
+	.alias_long_desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
+	.matching_pmu = "uncore_sys_ccn_pmu",
+};
+
 static const struct perf_pmu_test_event *sys_events[] = {
 	&sys_ddr_pmu_write_cycles,
+	&sys_ccn_pmu_read_cycles,
 	NULL
 };
 
@@ -677,6 +692,16 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 			&sys_ddr_pmu_write_cycles,
 		},
 	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_sys_ccn_pmu4",
+			.is_uncore = 1,
+			.id = (char *)"0x01",
+		},
+		.aliases = {
+			&sys_ccn_pmu_read_cycles,
+		},
+	},
 };
 
 /* Test that aliases generated are as expected */
-- 
2.26.2

