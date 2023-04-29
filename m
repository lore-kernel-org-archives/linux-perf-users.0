Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880CFC77B60
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 05:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjD2Fhl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 01:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjD2Fhi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 01:37:38 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FBA40C8
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:37:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24749db972cso320840a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746618; x=1685338618;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0dr9db51Jq/RsQdl+jWHc6lduK3C41zW9xfdl5Qlv8=;
        b=IF32jJtlKt0mk4VFHHYiUoKdPwSbXXo5THaU6vN6gcZwZdOO9fqvBctRSkjOXbmk8y
         foL7NH9qqPTewZii7QQyaOT0sG6ifb5sCGsN5HyMFLSgMll429tDb/VGalOs24AKQ9jO
         L8a6qC2XHUl22iuGzo4VcGoyI856HYfxO47DHiFu66SIZyzVr0tHBNuQtPGzxePIN1tk
         DfIAgOVmtVem73q6IVcNMU6fRXPGvxgqwQXP86PSuPrno/zY13opEhmlSdo1lWG4LZcX
         ulbtRs8tLWET9R7eh60Wkq3/NRen+417PJVRWRntKrP/fjsii9an5JBSBgpVNQL1EUPv
         nYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746618; x=1685338618;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0dr9db51Jq/RsQdl+jWHc6lduK3C41zW9xfdl5Qlv8=;
        b=SeBs/C4MlNjW5n/CmkDEZEklLU8k4hm/L53gzhfmJ6+i0DlhBo369QZpKo+rx0MtsZ
         odw722ZEyWxWRla03+3wH8I3DSYFTFBOvQiqW6f8Hwg/8KZ9U8bdXtVLHdewUzgASBqv
         7x2wN/5knZC3V0L/Q/m10Tm0CIjuyp+oz97vBvEw+mg0DdP2XQnU6jftRjJ5vh8h3gaG
         zSmMev8N7n6NRWyQVeNYrgrpmwzIIj2pdl1Vhyv2AonJl6vOYQj8v3opQ6x5CCNXizgE
         MdNlGCrKPU55z87XwVxhwtbj5xDLaHUHDzxLt/fWsb/d7WwKJgtZ4Pj1Paysae92yzYu
         QyFQ==
X-Gm-Message-State: AC+VfDx74tCRJABN2mT1lELC9Oh3jRKvj3mFnWyovPUNhwPJPgYvCZtU
        wkmeakq/1w0nGcs2Y4gmGG+8nYSREhZ4
X-Google-Smtp-Source: ACHHUZ7IJhypSFLhRVcDsg+58GYj4OCkxSY0PP2OFKoKv56nBgbDRLjq5/5OwcsVTFEKiwjZcJxb7PIGRa0U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a17:90a:73cb:b0:24d:df34:a8f5 with SMTP id
 n11-20020a17090a73cb00b0024ddf34a8f5mr66928pjk.5.1682746618680; Fri, 28 Apr
 2023 22:36:58 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:32 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-13-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 12/46] perf test: Test more sysfs events
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
 tools/perf/tests/parse-events.c | 121 +++++++++++++++++---------------
 1 file changed, 65 insertions(+), 56 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8068cfd89b84..35b35a5c795c 100644
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
@@ -2225,74 +2226,82 @@ static int test_pmu(void)
 
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct stat st;
-	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
-	int ret;
+	struct perf_pmu *pmu;
+	int ret = TEST_OK;
 
-	if (!test_pmu())
-		return TEST_SKIP;
+	perf_pmus__for_each_pmu(pmu) {
+		struct stat st;
+		char path[PATH_MAX];
+		struct dirent *ent;
+		DIR *dir;
+		int err;
 
-	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/",
-		 sysfs__mountpoint());
+		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/",
+			sysfs__mountpoint(), pmu->name);
 
-	ret = stat(path, &st);
-	if (ret) {
-		pr_debug("omitting PMU cpu events tests: %s\n", path);
-		return TEST_OK;
-	}
+		err = stat(path, &st);
+		if (err) {
+			pr_debug("skipping PMU %s events tests: %s\n", pmu->name, path);
+			ret = combine_test_results(ret, TEST_SKIP);
+			continue;
+		}
 
-	dir = opendir(path);
-	if (!dir) {
-		pr_debug("can't open pmu event dir: %s\n", path);
-		return TEST_FAIL;
-	}
+		dir = opendir(path);
+		if (!dir) {
+			pr_debug("can't open pmu event dir: %s\n", path);
+			ret = combine_test_results(ret, TEST_SKIP);
+			continue;
+		}
 
-	ret = TEST_OK;
-	while ((ent = readdir(dir))) {
-		struct evlist_test e = { .name = NULL, };
-		char name[2 * NAME_MAX + 1 + 12 + 3];
-		int test_ret;
+		while ((ent = readdir(dir))) {
+			struct evlist_test e = { .name = NULL, };
+			char name[2 * NAME_MAX + 1 + 12 + 3];
+			int test_ret;
 
-		/* Names containing . are special and cannot be used directly */
-		if (strchr(ent->d_name, '.'))
-			continue;
+			/* Names containing . are special and cannot be used directly */
+			if (strchr(ent->d_name, '.'))
+				continue;
 
-		snprintf(name, sizeof(name), "cpu/event=%s/u", ent->d_name);
+			snprintf(name, sizeof(name), "%s/event=%s/u", pmu->name, ent->d_name);
 
-		e.name  = name;
-		e.check = test__checkevent_pmu_events;
+			e.name  = name;
+			e.check = test__checkevent_pmu_events;
 
-		test_ret = test_event(&e);
-		if (test_ret != TEST_OK) {
-			pr_debug("Test PMU event failed for '%s'", name);
-			ret = combine_test_results(ret, test_ret);
-		}
-		/*
-		 * Names containing '-' are recognized as prefixes and suffixes
-		 * due to '-' being a legacy PMU separator. This fails when the
-		 * prefix or suffix collides with an existing legacy token. For
-		 * example, branch-brs has a prefix (branch) that collides with
-		 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
-		 * isn't expected after this. As event names in the config
-		 * slashes are allowed a '-' in the name we check this works
-		 * above.
-		 */
-		if (strchr(ent->d_name, '-'))
-			continue;
+			test_ret = test_event(&e);
+			if (test_ret != TEST_OK) {
+				pr_debug("Test PMU event failed for '%s'", name);
+				ret = combine_test_results(ret, test_ret);
+			}
 
-		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
-		e.name  = name;
-		e.check = test__checkevent_pmu_events_mix;
-		test_ret = test_event(&e);
-		if (test_ret != TEST_OK) {
-			pr_debug("Test PMU event failed for '%s'", name);
-			ret = combine_test_results(ret, test_ret);
+			if (!is_pmu_core(pmu->name))
+				continue;
+
+			/*
+			 * Names containing '-' are recognized as prefixes and suffixes
+			 * due to '-' being a legacy PMU separator. This fails when the
+			 * prefix or suffix collides with an existing legacy token. For
+			 * example, branch-brs has a prefix (branch) that collides with
+			 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
+			 * isn't expected after this. As event names in the config
+			 * slashes are allowed a '-' in the name we check this works
+			 * above.
+			 */
+			if (strchr(ent->d_name, '-'))
+				continue;
+
+			snprintf(name, sizeof(name), "%s:u,%s/event=%s/u",
+				 ent->d_name, pmu->name, ent->d_name);
+			e.name  = name;
+			e.check = test__checkevent_pmu_events_mix;
+			test_ret = test_event(&e);
+			if (test_ret != TEST_OK) {
+				pr_debug("Test PMU event failed for '%s'", name);
+				ret = combine_test_results(ret, test_ret);
+			}
 		}
-	}
 
-	closedir(dir);
+		closedir(dir);
+	}
 	return ret;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

