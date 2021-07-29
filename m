Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94273C43216
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A69061058
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhG2OJV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3524 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbhG2OCh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 10:02:37 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBfg1ZPLz6J9rs;
        Thu, 29 Jul 2021 21:47:23 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:02:32 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:02:28 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 01/11] perf test: Factor out pmu-events event comparison
Date:   Thu, 29 Jul 2021 21:56:16 +0800
Message-ID: <1627566986-30605-2-git-send-email-john.garry@huawei.com>
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

Factor out event comparison which will be used in multiple places.

Also test "pmu" and "compat" fields.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/pmu-events.c | 119 +++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index b8aff8fb50d8..c064f08c63c9 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -161,6 +161,71 @@ static struct pmu_events_map *__test_pmu_get_events_map(void)
 	return NULL;
 }
 
+static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
+{
+	if (!is_same(e1->desc, e2->desc)) {
+		pr_debug2("testing event e1 %s: mismatched desc, %s vs %s\n",
+			  e1->name, e1->desc, e2->desc);
+		return -1;
+	}
+
+	if (!is_same(e1->topic, e2->topic)) {
+		pr_debug2("testing event e1 %s: mismatched topic, %s vs %s\n",
+			  e1->name, e1->topic, e2->topic);
+		return -1;
+	}
+
+	if (!is_same(e1->long_desc, e2->long_desc)) {
+		pr_debug2("testing event e1 %s: mismatched long_desc, %s vs %s\n",
+			  e1->name, e1->long_desc, e2->long_desc);
+		return -1;
+	}
+
+	if (!is_same(e1->unit, e2->unit)) {
+		pr_debug2("testing event e1 %s: mismatched unit, %s vs %s\n",
+			  e1->name, e1->unit, e2->unit);
+		return -1;
+	}
+
+	if (!is_same(e1->perpkg, e2->perpkg)) {
+		pr_debug2("testing event e1 %s: mismatched perpkg, %s vs %s\n",
+			  e1->name, e1->perpkg, e2->perpkg);
+		return -1;
+	}
+
+	if (!is_same(e1->metric_expr, e2->metric_expr)) {
+		pr_debug2("testing event e1 %s: mismatched metric_expr, %s vs %s\n",
+			  e1->name, e1->metric_expr, e2->metric_expr);
+		return -1;
+	}
+
+	if (!is_same(e1->metric_name, e2->metric_name)) {
+		pr_debug2("testing event e1 %s: mismatched metric_name, %s vs %s\n",
+			  e1->name,	e1->metric_name, e2->metric_name);
+		return -1;
+	}
+
+	if (!is_same(e1->deprecated, e2->deprecated)) {
+		pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
+			  e1->name, e1->deprecated, e2->deprecated);
+		return -1;
+	}
+
+	if (!is_same(e1->pmu, e2->pmu)) {
+		pr_debug2("testing event e1 %s: mismatched pmu string, %s vs %s\n",
+			  e1->name, e1->pmu, e2->pmu);
+		return -1;
+	}
+
+	if (!is_same(e1->compat, e2->compat)) {
+		pr_debug2("testing event e1 %s: mismatched compat string, %s vs %s\n",
+			  e1->name, e1->compat, e2->compat);
+		return -1;
+	}
+
+	return 0;
+}
+
 /* Verify generated events from pmu-events.c is as expected */
 static int test_pmu_event_table(void)
 {
@@ -193,60 +258,8 @@ static int test_pmu_event_table(void)
 			found = true;
 			map_events++;
 
-			if (!is_same(table->desc, te->desc)) {
-				pr_debug2("testing event table %s: mismatched desc, %s vs %s\n",
-					  table->name, table->desc, te->desc);
-				return -1;
-			}
-
-			if (!is_same(table->topic, te->topic)) {
-				pr_debug2("testing event table %s: mismatched topic, %s vs %s\n",
-					  table->name, table->topic,
-					  te->topic);
-				return -1;
-			}
-
-			if (!is_same(table->long_desc, te->long_desc)) {
-				pr_debug2("testing event table %s: mismatched long_desc, %s vs %s\n",
-					  table->name, table->long_desc,
-					  te->long_desc);
-				return -1;
-			}
-
-			if (!is_same(table->unit, te->unit)) {
-				pr_debug2("testing event table %s: mismatched unit, %s vs %s\n",
-					  table->name, table->unit,
-					  te->unit);
-				return -1;
-			}
-
-			if (!is_same(table->perpkg, te->perpkg)) {
-				pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
-					  table->name, table->perpkg,
-					  te->perpkg);
-				return -1;
-			}
-
-			if (!is_same(table->metric_expr, te->metric_expr)) {
-				pr_debug2("testing event table %s: mismatched metric_expr, %s vs %s\n",
-					  table->name, table->metric_expr,
-					  te->metric_expr);
+			if (compare_pmu_events(table, te))
 				return -1;
-			}
-
-			if (!is_same(table->metric_name, te->metric_name)) {
-				pr_debug2("testing event table %s: mismatched metric_name, %s vs %s\n",
-					  table->name,  table->metric_name,
-					  te->metric_name);
-				return -1;
-			}
-
-			if (!is_same(table->deprecated, te->deprecated)) {
-				pr_debug2("testing event table %s: mismatched deprecated, %s vs %s\n",
-					  table->name, table->deprecated,
-					  te->deprecated);
-				return -1;
-			}
 
 			pr_debug("testing event table %s: pass\n", table->name);
 		}
-- 
2.26.2

