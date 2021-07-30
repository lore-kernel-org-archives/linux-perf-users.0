Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE516C4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 07:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DCD61055
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 07:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhG3HIz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 03:08:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:47755 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhG3HIz (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 03:08:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="193323625"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="193323625"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 00:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="476869169"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2021 00:08:48 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/2] perf tests: Test for PMU alias
Date:   Fri, 30 Jul 2021 15:07:17 +0800
Message-Id: <20210730070717.30997-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210730070717.30997-1-yao.jin@linux.intel.com>
References: <20210730070717.30997-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A perf uncore PMU may have two PMU names, a real name and an alias
name. Add one test case to verify the real name and alias name having
the same effect.

Iterate the sysfs to get one event which has an alias and create
evlist by adding two evsels. Evsel1 is created by event and evsel2
is created by alias.

Test asserts:
evsel1->core.attr.type == evsel2->core.attr.type
evsel1->core.attr.config == evsel2->core.attr.config

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Use fgets to read alias string from sysfs.
 - Resource cleanup.

v2:
 - New in v2.

 tools/perf/tests/parse-events.c | 92 +++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 56a7b6a14195..68c2e58861e1 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -6,6 +6,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "pmu.h"
+#include "fncache.h"
 #include <dirent.h>
 #include <errno.h>
 #include <sys/types.h>
@@ -2190,9 +2191,91 @@ static int test_pmu_events(void)
 	return ret;
 }
 
+static bool test_alias(char **event, char **alias)
+{
+	char path[PATH_MAX];
+	DIR *dir;
+	struct dirent *dent;
+	const char *sysfs = sysfs__mountpoint();
+	char buf[128];
+	FILE *file;
+
+	if (!sysfs)
+		return false;
+
+	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/", sysfs);
+	dir = opendir(path);
+	if (!dir)
+		return false;
+
+	while ((dent = readdir(dir))) {
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/alias",
+			 sysfs, dent->d_name);
+
+		if (!file_available(path))
+			continue;
+
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+
+		if (!fgets(buf, sizeof(buf), file)) {
+			fclose(file);
+			continue;
+		}
+
+		/* Remove the last '\n' */
+		buf[strlen(buf) - 1] = 0;
+
+		fclose(file);
+		*event = strdup(dent->d_name);
+		*alias = strdup(buf);
+		closedir(dir);
+
+		if (*event == NULL || *alias == NULL) {
+			free(*event);
+			free(*alias);
+			return false;
+		}
+
+		return true;
+	}
+
+	closedir(dir);
+	return false;
+}
+
+static int test__checkevent_pmu_events_alias(struct evlist *evlist)
+{
+	struct evsel *evsel1 = evlist__first(evlist);
+	struct evsel *evsel2 = evlist__last(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel1->core.attr.type == evsel2->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", evsel1->core.attr.config == evsel2->core.attr.config);
+	return 0;
+}
+
+static int test_pmu_events_alias(char *event, char *alias)
+{
+	struct evlist_test e = { .id = 0, };
+	char name[2 * NAME_MAX + 20];
+
+	snprintf(name, sizeof(name), "%s/event=1/,%s/event=1/",
+		 event, alias);
+
+	e.name  = name;
+	e.check = test__checkevent_pmu_events_alias;
+	return test_event(&e);
+}
+
 int test__parse_events(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret1, ret2 = 0;
+	char *event, *alias;
 
 #define TEST_EVENTS(tests)				\
 do {							\
@@ -2217,6 +2300,15 @@ do {							\
 			return ret;
 	}
 
+	if (test_alias(&event, &alias)) {
+		int ret = test_pmu_events_alias(event, alias);
+
+		free(event);
+		free(alias);
+		if (ret)
+			return ret;
+	}
+
 	ret1 = test_terms(test__terms, ARRAY_SIZE(test__terms));
 	if (!ret2)
 		ret2 = ret1;
-- 
2.27.0

