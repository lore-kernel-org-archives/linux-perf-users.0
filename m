Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657AAC4320A
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F06760EBD
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhG2OJP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3528 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbhG2OCv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 10:02:51 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBnk0yMyz6FG2m;
        Thu, 29 Jul 2021 21:53:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:02:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:02:43 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 05/11] perf test: Test pmu-events core aliases separately
Date:   Thu, 29 Jul 2021 21:56:20 +0800
Message-ID: <1627566986-30605-6-git-send-email-john.garry@huawei.com>
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

The current method to test uncore event aliasing is limited, as it relies
on the uncore PMU being present in the host system to test.

As such, breakages of uncore PMU aliases goes unnoticed. To make this more
robust, a new method of testing uncore PMUs with fake PMUs will be used in
future. This will be separate to testing core PMU aliases.

So make the current test function core PMU only. Uncore PMU alias support
will be re-added later.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/pmu-events.c | 45 +++++++++++++----------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 8fb5df6ee500..9537bbdd09f0 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -352,26 +352,19 @@ static struct perf_pmu_alias *find_alias(const char *test_event, struct list_hea
 }
 
 /* Verify aliases are as expected */
-static int __test__pmu_event_aliases(char *pmu_name, int *count)
+static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 {
 	struct perf_pmu_test_event const **test_event_table;
 	struct perf_pmu *pmu;
 	LIST_HEAD(aliases);
 	int res = 0;
-	bool use_uncore_table;
 	struct pmu_events_map *map = __test_pmu_get_events_map();
 	struct perf_pmu_alias *a, *tmp;
 
 	if (!map)
 		return -1;
 
-	if (is_pmu_core(pmu_name)) {
-		test_event_table = &core_events[0];
-		use_uncore_table = false;
-	} else {
-		test_event_table = &uncore_events[0];
-		use_uncore_table = true;
-	}
+	test_event_table = &core_events[0];
 
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
@@ -384,20 +377,10 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 	for (; *test_event_table; test_event_table++) {
 		struct perf_pmu_test_event const *test_event = *test_event_table;
 		struct pmu_event const *event = &test_event->event;
-
 		struct perf_pmu_alias *alias = find_alias(event->name, &aliases);
 
 		if (!alias) {
-			bool uncore_match = pmu_uncore_alias_match(pmu_name,
-								   event->pmu);
-
-			if (use_uncore_table && !uncore_match) {
-				pr_debug3("testing aliases PMU %s: skip matching alias %s\n",
-					  pmu_name, event->name);
-				continue;
-			}
-
-			pr_debug2("testing aliases PMU %s: no alias, alias_table->name=%s\n",
+			pr_debug("testing aliases core PMU %s: no alias, alias_table->name=%s\n",
 				  pmu_name, event->name);
 			res = -1;
 			break;
@@ -409,7 +392,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 		}
 
 		(*count)++;
-		pr_debug2("testing aliases PMU %s: matched event %s\n",
+		pr_debug2("testing aliases core PMU %s: matched event %s\n",
 			  pmu_name, alias->name);
 	}
 
@@ -421,7 +404,6 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 	return res;
 }
 
-
 /* Test that aliases generated are as expected */
 static int test_aliases(void)
 {
@@ -430,21 +412,26 @@ static int test_aliases(void)
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		int count = 0;
 
+		if (!is_pmu_core(pmu->name))
+			continue;
+
 		if (list_empty(&pmu->format)) {
-			pr_debug2("skipping testing PMU %s\n", pmu->name);
+			pr_debug2("skipping testing core PMU %s\n", pmu->name);
 			continue;
 		}
 
-		if (__test__pmu_event_aliases(pmu->name, &count)) {
-			pr_debug("testing PMU %s aliases: failed\n", pmu->name);
+		if (__test_core_pmu_event_aliases(pmu->name, &count)) {
+			pr_debug("testing core PMU %s aliases: failed\n", pmu->name);
 			return -1;
 		}
 
-		if (count == 0)
-			pr_debug3("testing PMU %s aliases: no events to match\n",
+		if (count == 0) {
+			pr_debug("testing core PMU %s aliases: no events to match\n",
 				  pmu->name);
-		else
-			pr_debug("testing PMU %s aliases: pass\n", pmu->name);
+			return -1;
+		}
+
+		pr_debug("testing core PMU %s aliases: pass\n", pmu->name);
 	}
 
 	return 0;
-- 
2.26.2

