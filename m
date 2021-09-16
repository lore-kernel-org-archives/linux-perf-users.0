Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3535C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BB360F8F
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbhIPMk6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:40:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3837 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbhIPMku (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:50 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H9Gn36xDkz67gYW;
        Thu, 16 Sep 2021 20:37:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 14:39:28 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 13:39:23 +0100
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
Subject: [PATCH 1/5] perf parse-events: Set numeric term config
Date:   Thu, 16 Sep 2021 20:34:21 +0800
Message-ID: <1631795665-240946-2-git-send-email-john.garry@huawei.com>
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

For numeric terms, the config field may be NULL as it is not set from the
l+y parsing.

Fix by setting the term config from the term type name.

Also fix up the pmu-events test to set the alias strings to set the period
term properly, and fix up parse-events test to check the term config
string.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/parse-events.c | 8 ++++----
 tools/perf/tests/pmu-events.c   | 6 +++---
 tools/perf/util/parse-events.c  | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index fd3556cc9ad4..8875e388563e 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -605,7 +605,7 @@ static int test__checkterms_simple(struct list_head *terms)
 	TEST_ASSERT_VAL("wrong type val",
 			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 	TEST_ASSERT_VAL("wrong val", term->val.num == 10);
-	TEST_ASSERT_VAL("wrong config", !term->config);
+	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config"));
 
 	/* config1 */
 	term = list_entry(term->list.next, struct parse_events_term, list);
@@ -614,7 +614,7 @@ static int test__checkterms_simple(struct list_head *terms)
 	TEST_ASSERT_VAL("wrong type val",
 			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 	TEST_ASSERT_VAL("wrong val", term->val.num == 1);
-	TEST_ASSERT_VAL("wrong config", !term->config);
+	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config1"));
 
 	/* config2=3 */
 	term = list_entry(term->list.next, struct parse_events_term, list);
@@ -623,7 +623,7 @@ static int test__checkterms_simple(struct list_head *terms)
 	TEST_ASSERT_VAL("wrong type val",
 			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 	TEST_ASSERT_VAL("wrong val", term->val.num == 3);
-	TEST_ASSERT_VAL("wrong config", !term->config);
+	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config2"));
 
 	/* umask=1*/
 	term = list_entry(term->list.next, struct parse_events_term, list);
@@ -661,7 +661,7 @@ static int test__checkterms_simple(struct list_head *terms)
 	TEST_ASSERT_VAL("wrong type val",
 			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 	TEST_ASSERT_VAL("wrong val", term->val.num == 0xead);
-	TEST_ASSERT_VAL("wrong config", !term->config);
+	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config"));
 	return 0;
 }
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 43743cf719ef..8c5a6ba1cb14 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -67,7 +67,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
 		.desc = "Number of segment register loads",
 		.topic = "other",
 	},
-	.alias_str = "umask=0x80,(null)=0x30d40,event=0x6",
+	.alias_str = "umask=0x80,period=0x30d40,event=0x6",
 	.alias_long_desc = "Number of segment register loads",
 };
 
@@ -78,7 +78,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
 		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
 		.topic = "other",
 	},
-	.alias_str = "umask=0x20,(null)=0x30d40,event=0x9",
+	.alias_str = "umask=0x20,period=0x30d40,event=0x9",
 	.alias_long_desc = "Memory cluster signals to block micro-op dispatch for any reason",
 };
 
@@ -89,7 +89,7 @@ static const struct perf_pmu_test_event eist_trans = {
 		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 		.topic = "other",
 	},
-	.alias_str = "umask=0,(null)=0x30d40,event=0x3a",
+	.alias_str = "umask=0,period=0x30d40,event=0x3a",
 	.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 };
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 51a2219df601..e10243454e8b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -3083,7 +3083,7 @@ int parse_events_term__num(struct parse_events_term **term,
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
-		.config    = config,
+		.config    = config ? : strdup(config_term_names[type_term]),
 		.no_value  = no_value,
 		.err_term  = loc_term ? loc_term->first_column : 0,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
-- 
2.26.2

