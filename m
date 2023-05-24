Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96739C77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbjEXWVU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbjEXWUp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:20:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4843B1B6
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561f1c2af16so18744147b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966774; x=1687558774;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XP34/lTHk88aGi5g16tiqPPlFvPYUI/7slAn7kxjnhU=;
        b=e3QTDmJoeAun/x66qVBqgKH7fCw3cWk6avEC85L7N9Cg8LlgXzAtlioNM7cjPnq1gY
         a4SWY0Ah5jhpHg9uI5KbifN8N8KX8O8ZwDxTX7fDdgfY4LtKi9vRQKdi3KpOfuPyei/V
         +0VYoyOigrLvJBZVgHiG7ICrKnWrURTSkfMMJ1hsXfC5zlCmh/ZbIy/Xy6i/SWP6IXaw
         fN/r6zDvDBu9AHTBmLQfQYFqiG7nCrMRCOMAFvbA6aTyTqlH4XXAuo9AaU9JRDE0Ym3q
         UKF3Pgqjupvk7wL5YSz8RpDHbO5wh0h1ppMymLaIyJideR1C3C96K8H/eGGLsplQXWu4
         PBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966774; x=1687558774;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XP34/lTHk88aGi5g16tiqPPlFvPYUI/7slAn7kxjnhU=;
        b=dT18y9Gh6xEESSHYB5YocfuWC0Bbr95GG6mUhlAEacg9R/cT58h7JPxrmbk2CG1d1t
         2fDQ+WUbDHHScLO7P90kNCarWEz7ZyhOb6GpIgia3nrrm4TaAX48diU9L+XWDPq6iL0b
         +oO0Wyf0+EewxfECvSebS1lEUPNR3XXlr2N14TDS2GEYjtFFfkZUBVejFDOLdw/JDsRp
         CUTORL8igEi/vzNNFicyFwNLzKR7ik0SEzdZGvSp92WDo5fvQE+gopk4HowXp7X2tiM/
         yOpjWFpBfWTHf84hxfAEQ4/CPUhYip0SV0JKvpRAU02G7XzLIPi+rnqqQtQX1b4HVcZP
         jSzw==
X-Gm-Message-State: AC+VfDwqqKzSbZ7geMMoTcgR2D3hv+lSzrgXKbHA5e3QwtMlBb3VNPqn
        0eXzBXV4HyBkDjoYqXNs1Ect1B706O/6
X-Google-Smtp-Source: ACHHUZ7D9drqIRB2MyurLXcxiCePzmUOMC9VFsJ8EjeKLTVsgpR53rwm2NFY69hSSmDfa3llKWHekDfBwYID
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a5b:c03:0:b0:ba8:5bc9:80fe with SMTP id
 f3-20020a5b0c03000000b00ba85bc980femr795184ybq.1.1684966774678; Wed, 24 May
 2023 15:19:34 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:22 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-27-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 26/35] perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_pmus__for_each_pmu doesn't lazily initialize pmus making its use
error prone. Just use perf_pmu__scan as this only impacts
non-performance critical tests.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/pmu-scan.c     |  6 ++----
 tools/perf/tests/event_groups.c |  7 ++-----
 tools/perf/tests/parse-events.c | 11 ++++-------
 tools/perf/util/pmus.h          |  2 --
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index f0f007843bb8..f4a6c37cbe27 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -40,13 +40,11 @@ static struct pmu_scan_result *results;
 
 static int save_result(void)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	struct list_head *list;
 	struct pmu_scan_result *r;
 
-	perf_pmu__scan(NULL);
-
-	perf_pmus__for_each_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		r = realloc(results, (nr_pmus + 1) * sizeof(*r));
 		if (r == NULL)
 			return -ENOMEM;
diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
index 029442b4e9c6..3d9a2b524bba 100644
--- a/tools/perf/tests/event_groups.c
+++ b/tools/perf/tests/event_groups.c
@@ -50,13 +50,10 @@ static int event_open(int type, unsigned long config, int group_fd)
 
 static int setup_uncore_event(void)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	int i, fd;
 
-	if (list_empty(&pmus))
-		perf_pmu__scan(NULL);
-
-	perf_pmus__for_each_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		for (i = 0; i < NR_UNCORE_PMUS; i++) {
 			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
 				pr_debug("Using %s for uncore pmu event\n", pmu->name);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 72a10bed84fd..277607ede060 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -108,11 +108,11 @@ static int test__checkevent_raw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
 	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		struct perf_pmu *pmu;
+		struct perf_pmu *pmu = NULL;
 		bool type_matched = false;
 
 		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
-		perf_pmus__for_each_pmu(pmu) {
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 			if (pmu->type == evsel->attr.type) {
 				TEST_ASSERT_VAL("PMU type expected once", !type_matched);
 				type_matched = true;
@@ -2243,13 +2243,10 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
 
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	int ret = TEST_OK;
 
-	if (list_empty(&pmus))
-		perf_pmu__scan(NULL);
-
-	perf_pmus__for_each_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		struct stat st;
 		char path[PATH_MAX];
 		struct dirent *ent;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index d475e2960c10..257de10788e8 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -5,8 +5,6 @@
 extern struct list_head pmus;
 struct perf_pmu;
 
-#define perf_pmus__for_each_pmu(pmu) list_for_each_entry(pmu, &pmus, list)
-
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
 #endif /* __PMUS_H */
-- 
2.40.1.698.g37aff9b760-goog

