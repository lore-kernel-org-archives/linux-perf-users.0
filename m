Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E1C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D81461176
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhG2OJG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3531 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbhG2ODD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 10:03:03 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBnx5hrdz6FG8j;
        Thu, 29 Jul 2021 21:53:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:02:58 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:02:54 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 08/11] perf test: Add more pmu-events uncore aliases
Date:   Thu, 29 Jul 2021 21:56:23 +0800
Message-ID: <1627566986-30605-9-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add more events to cover the scenarios fixed and also inadvertently broken
by commit c47a5599eda3 ("perf tools: Fix pattern matching for same
substring in different PMU type").

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/test/test_soc/cpu/uncore.json        | 23 +++++-
 tools/perf/tests/pmu-events.c                 | 72 +++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
index d0a890cc814d..788766f45dbc 100644
--- a/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
+++ b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
@@ -17,5 +17,26 @@
 	    "CounterMask": "0",
 	    "Invert": "0",
 	    "EdgeDetect": "0"
-  }
+  },
+  {
+	    "EventCode": "0x7",
+	    "EventName": "uncore_hisi_l3c.rd_hit_cpipe",
+	    "BriefDescription": "Total read hits",
+	    "PublicDescription": "Total read hits",
+	    "Unit": "hisi_sccl,l3c"
+  },
+  {
+	    "EventCode": "0x12",
+	    "EventName": "uncore_imc_free_running.cache_miss",
+	    "BriefDescription": "Total cache misses",
+	    "PublicDescription": "Total cache misses",
+	    "Unit": "imc_free_running"
+  },
+  {
+	    "EventCode": "0x34",
+	    "EventName": "uncore_imc.cache_hits",
+	    "BriefDescription": "Total cache hits",
+	    "PublicDescription": "Total cache hits",
+	    "Unit": "imc"
+  },
 ]
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 74c7dfe0a97f..0fcdeeda00ec 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -143,9 +143,54 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 	.matching_pmu = "uncore_cbox_0",
 };
 
+static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
+	.event = {
+		.name = "uncore_hisi_l3c.rd_hit_cpipe",
+		.event = "event=0x2",
+		.desc = "Total read hits. Unit: hisi_sccl,l3c ",
+		.topic = "uncore",
+		.long_desc = "Total read hits",
+		.pmu = "hisi_sccl,l3c",
+	},
+	.alias_str = "event=0x7",
+	.alias_long_desc = "Total read hits",
+	.matching_pmu = "hisi_sccl3_l3c7",
+};
+
+static const struct perf_pmu_test_event uncore_imc_free_running_cache_miss = {
+	.event = {
+		.name = "uncore_imc_free_running.cache_miss",
+		.event = "event=0x12",
+		.desc = "Total cache misses. Unit: uncore_imc_free_running ",
+		.topic = "uncore",
+		.long_desc = "Total cache misses",
+		.pmu = "uncore_imc_free_running",
+	},
+	.alias_str = "event=0x12",
+	.alias_long_desc = "Total cache misses",
+	.matching_pmu = "uncore_imc_free_running_0",
+};
+
+static const struct perf_pmu_test_event uncore_imc_cache_hits = {
+	.event = {
+		.name = "uncore_imc.cache_hits",
+		.event = "event=0x34",
+		.desc = "Total cache hits. Unit: uncore_imc ",
+		.topic = "uncore",
+		.long_desc = "Total cache hits",
+		.pmu = "uncore_imc",
+	},
+	.alias_str = "event=0x34",
+	.alias_long_desc = "Total cache hits",
+	.matching_pmu = "uncore_imc_0",
+};
+
 static const struct perf_pmu_test_event *uncore_events[] = {
 	&uncore_hisi_ddrc_flux_wcmd,
 	&unc_cbo_xsnp_response_miss_eviction,
+	&uncore_hisi_l3c_rd_hit_cpipe,
+	&uncore_imc_free_running_cache_miss,
+	&uncore_imc_cache_hits,
 	NULL
 };
 
@@ -504,6 +549,33 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 			&unc_cbo_xsnp_response_miss_eviction,
 		},
 	},
+	{
+		.pmu = {
+			.name = (char *)"hisi_sccl3_l3c7",
+			.is_uncore = 1,
+		},
+		.aliases = {
+			&uncore_hisi_l3c_rd_hit_cpipe,
+		},
+	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_imc_free_running_0",
+			.is_uncore = 1,
+		},
+		.aliases = {
+			&uncore_imc_free_running_cache_miss,
+		},
+	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_imc_0",
+			.is_uncore = 1,
+		},
+		.aliases = {
+			&uncore_imc_cache_hits,
+		},
+	},
 };
 
 /* Test that aliases generated are as expected */
-- 
2.26.2

