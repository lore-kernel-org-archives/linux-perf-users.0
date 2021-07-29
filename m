Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94307C4320A
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802CC610A2
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhG2OJF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3527 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbhG2OCr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 10:02:47 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBkb3TMDz6LBct;
        Thu, 29 Jul 2021 21:50:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:02:43 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:02:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 04/11] perf test: Factor out pmu-events alias comparison
Date:   Thu, 29 Jul 2021 21:56:19 +0800
Message-ID: <1627566986-30605-5-git-send-email-john.garry@huawei.com>
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

Factor out alias test which will be used in multiple places.

Also test missing fields.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/pmu-events.c | 80 ++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 0837f2c9d882..8fb5df6ee500 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -232,6 +232,60 @@ static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
 	return 0;
 }
 
+static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
+				struct perf_pmu_test_event const *test_event,
+				char const *pmu_name)
+{
+	struct pmu_event const *event = &test_event->event;
+
+	/* An alias was found, ensure everything is in order */
+	if (!is_same(alias->name, event->name)) {
+		pr_debug("testing aliases PMU %s: mismatched name, %s vs %s\n",
+			  pmu_name, alias->name, event->name);
+		return -1;
+	}
+
+	if (!is_same(alias->desc, event->desc)) {
+		pr_debug("testing aliases PMU %s: mismatched desc, %s vs %s\n",
+			  pmu_name, alias->desc, event->desc);
+		return -1;
+	}
+
+	if (!is_same(alias->long_desc, test_event->alias_long_desc)) {
+		pr_debug("testing aliases PMU %s: mismatched long_desc, %s vs %s\n",
+			  pmu_name, alias->long_desc,
+			  test_event->alias_long_desc);
+		return -1;
+	}
+
+	if (!is_same(alias->topic, event->topic)) {
+		pr_debug("testing aliases PMU %s: mismatched topic, %s vs %s\n",
+			  pmu_name, alias->topic, event->topic);
+		return -1;
+	}
+
+	if (!is_same(alias->str, test_event->alias_str)) {
+		pr_debug("testing aliases PMU %s: mismatched str, %s vs %s\n",
+			  pmu_name, alias->str, test_event->alias_str);
+		return -1;
+	}
+
+	if (!is_same(alias->long_desc, test_event->alias_long_desc)) {
+		pr_debug("testing aliases PMU %s: mismatched long desc, %s vs %s\n",
+			  pmu_name, alias->str, test_event->alias_long_desc);
+		return -1;
+	}
+
+
+	if (!is_same(alias->pmu_name, test_event->event.pmu)) {
+		pr_debug("testing aliases PMU %s: mismatched pmu_name, %s vs %s\n",
+			  pmu_name, alias->pmu_name, test_event->event.pmu);
+		return -1;
+	}
+
+	return 0;
+}
+
 /* Verify generated events from pmu-events.c are as expected */
 static int test_pmu_event_table(void)
 {
@@ -349,31 +403,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 			break;
 		}
 
-		if (!is_same(alias->desc, event->desc)) {
-			pr_debug2("testing aliases PMU %s: mismatched desc, %s vs %s\n",
-				  pmu_name, alias->desc, event->desc);
-			res = -1;
-			break;
-		}
-
-		if (!is_same(alias->long_desc, test_event->alias_long_desc)) {
-			pr_debug2("testing aliases PMU %s: mismatched long_desc, %s vs %s\n",
-				  pmu_name, alias->long_desc,
-				  test_event->alias_long_desc);
-			res = -1;
-			break;
-		}
-
-		if (!is_same(alias->str, test_event->alias_str)) {
-			pr_debug2("testing aliases PMU %s: mismatched str, %s vs %s\n",
-				  pmu_name, alias->str, test_event->alias_str);
-			res = -1;
-			break;
-		}
-
-		if (!is_same(alias->topic, event->topic)) {
-			pr_debug2("testing aliases PMU %s: mismatched topic, %s vs %s\n",
-				  pmu_name, alias->topic, event->topic);
+		if (compare_alias_to_test_event(alias, test_event, pmu_name)) {
 			res = -1;
 			break;
 		}
-- 
2.26.2

