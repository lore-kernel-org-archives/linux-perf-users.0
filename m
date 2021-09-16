Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845D0C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6939C60F92
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhIPMlB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:41:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3839 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbhIPMk6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:58 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H9Gn11D5Yz67LCv;
        Thu, 16 Sep 2021 20:37:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 14:39:36 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 13:39:32 +0100
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
Subject: [PATCH 3/5] perf test: Verify more event members in pmu-events test
Date:   Thu, 16 Sep 2021 20:34:23 +0800
Message-ID: <1631795665-240946-4-git-send-email-john.garry@huawei.com>
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

Function compare_pmu_events() does not compare all struct pmu-events
members, so add tests for missing members "name", "event", "aggr_mod",
"event", "metric_constraint", and "metric_group", and re-order the tests
to match current struct pmu-events member ordering.

Also fix uncore_hisi_l3c_rd_hit_cpipe.event member, now that we're actually
testing it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/pmu-events.c | 50 ++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 8c5a6ba1cb14..adfc17f51c7b 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -146,7 +146,7 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
 	.event = {
 		.name = "uncore_hisi_l3c.rd_hit_cpipe",
-		.event = "event=0x2",
+		.event = "event=0x7",
 		.desc = "Total read hits. Unit: hisi_sccl,l3c ",
 		.topic = "uncore",
 		.long_desc = "Total read hits",
@@ -255,6 +255,24 @@ static struct pmu_event *__test_pmu_get_sys_events_table(void)
 
 static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
 {
+	if (!is_same(e1->name, e2->name)) {
+		pr_debug2("testing event e1 %s: mismatched name string, %s vs %s\n",
+			  e1->name, e1->name, e2->name);
+		return -1;
+	}
+
+	if (!is_same(e1->compat, e2->compat)) {
+		pr_debug2("testing event e1 %s: mismatched compat string, %s vs %s\n",
+			  e1->name, e1->compat, e2->compat);
+		return -1;
+	}
+
+	if (!is_same(e1->event, e2->event)) {
+		pr_debug2("testing event e1 %s: mismatched event, %s vs %s\n",
+			  e1->name, e1->event, e2->event);
+		return -1;
+	}
+
 	if (!is_same(e1->desc, e2->desc)) {
 		pr_debug2("testing event e1 %s: mismatched desc, %s vs %s\n",
 			  e1->name, e1->desc, e2->desc);
@@ -273,6 +291,12 @@ static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
 		return -1;
 	}
 
+	if (!is_same(e1->pmu, e2->pmu)) {
+		pr_debug2("testing event e1 %s: mismatched pmu string, %s vs %s\n",
+			  e1->name, e1->pmu, e2->pmu);
+		return -1;
+	}
+
 	if (!is_same(e1->unit, e2->unit)) {
 		pr_debug2("testing event e1 %s: mismatched unit, %s vs %s\n",
 			  e1->name, e1->unit, e2->unit);
@@ -285,6 +309,12 @@ static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
 		return -1;
 	}
 
+	if (!is_same(e1->aggr_mode, e2->aggr_mode)) {
+		pr_debug2("testing event e1 %s: mismatched aggr_mode, %s vs %s\n",
+			  e1->name, e1->aggr_mode, e2->aggr_mode);
+		return -1;
+	}
+
 	if (!is_same(e1->metric_expr, e2->metric_expr)) {
 		pr_debug2("testing event e1 %s: mismatched metric_expr, %s vs %s\n",
 			  e1->name, e1->metric_expr, e2->metric_expr);
@@ -297,21 +327,21 @@ static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
 		return -1;
 	}
 
-	if (!is_same(e1->deprecated, e2->deprecated)) {
-		pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
-			  e1->name, e1->deprecated, e2->deprecated);
+	if (!is_same(e1->metric_group, e2->metric_group)) {
+		pr_debug2("testing event e1 %s: mismatched metric_group, %s vs %s\n",
+			  e1->name, e1->metric_group, e2->metric_group);
 		return -1;
 	}
 
-	if (!is_same(e1->pmu, e2->pmu)) {
-		pr_debug2("testing event e1 %s: mismatched pmu string, %s vs %s\n",
-			  e1->name, e1->pmu, e2->pmu);
+	if (!is_same(e1->deprecated, e2->deprecated)) {
+		pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
+			  e1->name, e1->deprecated, e2->deprecated);
 		return -1;
 	}
 
-	if (!is_same(e1->compat, e2->compat)) {
-		pr_debug2("testing event e1 %s: mismatched compat string, %s vs %s\n",
-			  e1->name, e1->compat, e2->compat);
+	if (!is_same(e1->metric_constraint, e2->metric_constraint)) {
+		pr_debug2("testing event e1 %s: mismatched metric_constant, %s vs %s\n",
+			  e1->name, e1->metric_constraint, e2->metric_constraint);
 		return -1;
 	}
 
-- 
2.26.2

