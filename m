Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5365C77B60
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 07:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbjDZHD2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbjDZHCo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 03:02:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC651FF2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:02:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b98ef5b557fso11905217276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492527; x=1685084527;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq0rkxZ+nzigWeul/fQuTIxJ14+0rSKTHQhzwukpkHY=;
        b=Wz5+bOP4poXGvDFuRQ90lq8R1aluz/0G9u+ErkTJ0ioEr+nlJ9oiliW4mYtD65TY/t
         FFtpm/W7NfDKodNa84YATE7RvBKry00RZczZK0vScGvW+vJgUBCxPzBM3sql/EN3l16z
         sW5FeGp0tFflf2OLSmv7noYWqd15zuQeH4aQpGU994RD4idq3f6jWApPMm5F1snGRL4f
         vVXYRzhXPwnd0D4yW3hOy3y4/pLkmxmDaBtK4LvLx4RpLN0lNXcFBtFRKoeQvNSmtwgq
         jaJ3tyHymdm2H/zcV3VMqI9igrXxPnkX2m9/MzKJ1DPlacL2KhDS9M4sw3jvSt4aLi5T
         wTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492527; x=1685084527;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq0rkxZ+nzigWeul/fQuTIxJ14+0rSKTHQhzwukpkHY=;
        b=eZ0MIu0QQq8vxK3peAZIBu6V6nJaC3x/WzgJYqvYkifuvo6aoM4QpRmfk6D/AUW+sZ
         LD9R5VVV8B/ySF/kJjcREk60TQu7/LUZRmlPBlH5IEctWZ3C6IL/VEWpM3SfF7TpkyBR
         bJbr+7zVSa+5YYqHURTqhEcQctS/SNe5NrGSCTapitwvdggrwxvzEOTG6RRK//HeGd9I
         QR4K/b1jds0MudzpzkpJcB7RJGpyrc2R9EFsNZNtRP5AY5JDikRmzm0fg8Uhoindppln
         oQiKE3uJJ3u7CClnCQs4jMu8vYnqaKSGRHVOebR5rzExtBcHrk27S25FymHA3CRtCUZH
         o4Ug==
X-Gm-Message-State: AC+VfDwf1dOBO69lf/mMCvE6naLYoLW/gLqq04r4f1mcVDJhdRrukleO
        ldPUoSkgE6QrFS2gaCcG79I8syeECbF4
X-Google-Smtp-Source: ACHHUZ5v2Ejn/Bj7HpudP7hkJxO2DT5BN+Vz8IjHKYpG17aSw7aVvJaQGRzoc10Rx9irrgVmqKdcxB3v9KOM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:d091:0:b0:b99:b753:342d with SMTP id
 h139-20020a25d091000000b00b99b753342dmr5249850ybg.7.1682492526946; Wed, 26
 Apr 2023 00:02:06 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:18 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-9-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 08/40] perf test: Test more sysfs events
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Parse events for all PMUs, and not just cpu, in test "Parsing of all
PMU events from sysfs".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 103 +++++++++++++++++---------------
 1 file changed, 55 insertions(+), 48 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8068cfd89b84..385bbbc4a409 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -7,6 +7,7 @@
 #include "debug.h"
 #include "pmu.h"
 #include "pmu-hybrid.h"
+#include "pmus.h"
 #include <dirent.h>
 #include <errno.h>
 #include "fncache.h"
@@ -2225,49 +2226,24 @@ static int test_pmu(void)
 
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct stat st;
-	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
-	int ret;
-
-	if (!test_pmu())
-		return TEST_SKIP;
-
-	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/",
-		 sysfs__mountpoint());
-
-	ret = stat(path, &st);
-	if (ret) {
-		pr_debug("omitting PMU cpu events tests: %s\n", path);
-		return TEST_OK;
-	}
+	struct perf_pmu *pmu;
+	int ret = TEST_OK;
 
-	dir = opendir(path);
-	if (!dir) {
-		pr_debug("can't open pmu event dir: %s\n", path);
-		return TEST_FAIL;
-	}
+	perf_pmus__for_each_pmu(pmu) {
+		struct stat st;
+		char path[PATH_MAX];
+		struct dirent *ent;
+		DIR *dir;
+		int err;
 
-	ret = TEST_OK;
-	while ((ent = readdir(dir))) {
-		struct evlist_test e = { .name = NULL, };
-		char name[2 * NAME_MAX + 1 + 12 + 3];
-		int test_ret;
+		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/",
+			sysfs__mountpoint(), pmu->name);
 
-		/* Names containing . are special and cannot be used directly */
-		if (strchr(ent->d_name, '.'))
+		err = stat(path, &st);
+		if (err) {
+			pr_debug("skipping PMU %s events tests: %s\n", pmu->name, path);
+			ret = combine_test_results(ret, TEST_SKIP);
 			continue;
-
-		snprintf(name, sizeof(name), "cpu/event=%s/u", ent->d_name);
-
-		e.name  = name;
-		e.check = test__checkevent_pmu_events;
-
-		test_ret = test_event(&e);
-		if (test_ret != TEST_OK) {
-			pr_debug("Test PMU event failed for '%s'", name);
-			ret = combine_test_results(ret, test_ret);
 		}
 		/*
 		 * Names containing '-' are recognized as prefixes and suffixes
@@ -2282,17 +2258,48 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 		if (strchr(ent->d_name, '-'))
 			continue;
 
-		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
-		e.name  = name;
-		e.check = test__checkevent_pmu_events_mix;
-		test_ret = test_event(&e);
-		if (test_ret != TEST_OK) {
-			pr_debug("Test PMU event failed for '%s'", name);
-			ret = combine_test_results(ret, test_ret);
+		dir = opendir(path);
+		if (!dir) {
+			pr_debug("can't open pmu event dir: %s\n", path);
+			ret = combine_test_results(ret, TEST_SKIP);
+			continue;
 		}
-	}
 
-	closedir(dir);
+		while ((ent = readdir(dir))) {
+			struct evlist_test e = { .name = NULL, };
+			char name[2 * NAME_MAX + 1 + 12 + 3];
+			int test_ret;
+
+			/* Names containing . are special and cannot be used directly */
+			if (strchr(ent->d_name, '.'))
+				continue;
+
+			snprintf(name, sizeof(name), "%s/event=%s/u", pmu->name, ent->d_name);
+
+			e.name  = name;
+			e.check = test__checkevent_pmu_events;
+
+			test_ret = test_event(&e);
+			if (test_ret != TEST_OK) {
+				pr_debug("Test PMU event failed for '%s'", name);
+				ret = combine_test_results(ret, test_ret);
+			}
+
+			if (!is_pmu_core(pmu->name))
+				continue;
+
+			snprintf(name, sizeof(name), "%s:u,%s/event=%s/u", ent->d_name, pmu->name, ent->d_name);
+			e.name  = name;
+			e.check = test__checkevent_pmu_events_mix;
+			test_ret = test_event(&e);
+			if (test_ret != TEST_OK) {
+				pr_debug("Test PMU event failed for '%s'", name);
+				ret = combine_test_results(ret, test_ret);
+			}
+		}
+
+		closedir(dir);
+	}
 	return ret;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

