Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD8C43214
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBF9610A2
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhG2OJL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3533 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbhG2OEv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 10:04:51 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBp86Yvnz6FG4l;
        Thu, 29 Jul 2021 21:53:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:03:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:03:06 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 11/11] perf test: Add pmu-events sys event support
Date:   Thu, 29 Jul 2021 21:56:26 +0800
Message-ID: <1627566986-30605-12-git-send-email-john.garry@huawei.com>
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

Add support for system events, along with core and uncore events.

Support for a sample PMU is also added.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/test/test_soc/sys/uncore.json        |  9 +++
 tools/perf/tests/pmu-events.c                 | 77 ++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json

diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
new file mode 100644
index 000000000000..0f681a6e10ea
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
@@ -0,0 +1,9 @@
+[
+  {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "sys_ddr_pmu.write_cycles",
+           "Unit": "sys_ddr_pmu",
+           "Compat": "v8"
+   },
+]
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 0fcdeeda00ec..43743cf719ef 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -194,6 +194,25 @@ static const struct perf_pmu_test_event *uncore_events[] = {
 	NULL
 };
 
+static const struct perf_pmu_test_event sys_ddr_pmu_write_cycles = {
+	.event = {
+		.name = "sys_ddr_pmu.write_cycles",
+		.event = "event=0x2b",
+		.desc = "ddr write-cycles event. Unit: uncore_sys_ddr_pmu ",
+		.topic = "uncore",
+		.pmu = "uncore_sys_ddr_pmu",
+		.compat = "v8",
+	},
+	.alias_str = "event=0x2b",
+	.alias_long_desc = "ddr write-cycles event. Unit: uncore_sys_ddr_pmu ",
+	.matching_pmu = "uncore_sys_ddr_pmu",
+};
+
+static const struct perf_pmu_test_event *sys_events[] = {
+	&sys_ddr_pmu_write_cycles,
+	NULL
+};
+
 static bool is_same(const char *reference, const char *test)
 {
 	if (!reference && !test)
@@ -222,6 +241,18 @@ static struct pmu_events_map *__test_pmu_get_events_map(void)
 	return NULL;
 }
 
+static struct pmu_event *__test_pmu_get_sys_events_table(void)
+{
+	struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+
+	for ( ; tables->name; tables++) {
+		if (!strcmp("pme_test_soc_sys", tables->name))
+			return tables->table;
+	}
+
+	return NULL;
+}
+
 static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
 {
 	if (!is_same(e1->desc, e2->desc)) {
@@ -344,15 +375,17 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 /* Verify generated events from pmu-events.c are as expected */
 static int test_pmu_event_table(void)
 {
+	struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
 	struct pmu_events_map *map = __test_pmu_get_events_map();
 	struct pmu_event *table;
 	int map_events = 0, expected_events;
 
-	/* ignore 2x sentinels */
+	/* ignore 3x sentinels */
 	expected_events = ARRAY_SIZE(core_events) +
-			  ARRAY_SIZE(uncore_events) - 2;
+			  ARRAY_SIZE(uncore_events) +
+			  ARRAY_SIZE(sys_events) - 3;
 
-	if (!map)
+	if (!map || !sys_event_tables)
 		return -1;
 
 	for (table = map->table; table->name; table++) {
@@ -386,6 +419,33 @@ static int test_pmu_event_table(void)
 		}
 	}
 
+	for (table = sys_event_tables; table->name; table++) {
+		struct perf_pmu_test_event const **test_event_table;
+		bool found = false;
+
+		test_event_table = &sys_events[0];
+
+		for (; *test_event_table; test_event_table++) {
+			struct perf_pmu_test_event const *test_event = *test_event_table;
+			struct pmu_event const *event = &test_event->event;
+
+			if (strcmp(table->name, event->name))
+				continue;
+			found = true;
+			map_events++;
+
+			if (compare_pmu_events(table, event))
+				return -1;
+
+			pr_debug("testing sys event table %s: pass\n", table->name);
+		}
+		if (!found) {
+			pr_debug("testing event table: could not find event %s\n",
+				   table->name);
+			return -1;
+		}
+	}
+
 	if (map_events != expected_events) {
 		pr_err("testing event table: found %d, but expected %d\n",
 		       map_events, expected_events);
@@ -474,6 +534,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	if (!map)
 		return -1;
 	pmu_add_cpu_aliases_map(&aliases, pmu, map);
+	pmu_add_sys_aliases(&aliases, pmu);
 
 	/* Count how many aliases we generated */
 	list_for_each_entry(alias, &aliases, list)
@@ -576,6 +637,16 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 			&uncore_imc_cache_hits,
 		},
 	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_sys_ddr_pmu0",
+			.is_uncore = 1,
+			.id = (char *)"v8",
+		},
+		.aliases = {
+			&sys_ddr_pmu_write_cycles,
+		},
+	},
 };
 
 /* Test that aliases generated are as expected */
-- 
2.26.2

