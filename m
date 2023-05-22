Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB8C77B75
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjEVGqc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEVGpp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:45:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF8171E
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55d9a9d19c9so106979527b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737855; x=1687329855;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XP34/lTHk88aGi5g16tiqPPlFvPYUI/7slAn7kxjnhU=;
        b=OY46Jgo7JQurCKnzauPQ47/oSJ0vOgQW7/xCwH9klbZgxX7c4l/YjZaz+gZzKJVM8w
         namx7v10lMVDPsl4OTwDTfjU7GogSy8YqSPRFC/9k0RNLcjNZXzch0aqy9rVu1GAk7MN
         hoQqi/3EnfHnv0SBLPRB8Bstd32Lql577boPt/pOqaQAxwaCJHRjqnI3r/hsGjWVFLCW
         DwJm7JAfd09zT2DhG7ADqvjy2iUwFSpSO41/sPXW8WQvNvn6fpwxPfUwUumdfpadTifr
         pWHQgMHsmpOWYLPl1ijEGa7e4zg1GYpQlqbWfjQ8+0XEgYO+GMPNMUJy1e3yiyqdSKyd
         tGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737855; x=1687329855;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XP34/lTHk88aGi5g16tiqPPlFvPYUI/7slAn7kxjnhU=;
        b=Pf4I3khfa56EV0QHz/ocNrgkhITcVnCobDpeG4n18iq4qO2Hje6HLX4Ly3JVsqOwoB
         yjQqOW0k037DwtBLJ51aIu1jN8bBFb5/Kwtg6IgIFqkTkD8s470rHxWKY2GVyuTiTAy4
         zevHfMjTOAx7DyqVl/lwAunUIyWVwZQg+j6Ze1I7hx/uirKXl1cV4fcMSFzHG7yMJR+9
         gUnhczHCUvG8qy5F/UQWcrVcxOBqzN3tL/kh7A8jgLMPmvHFnfei084Kka7Kyup4CSwF
         g9aFJpF1Cvmjj9XA8ajHxpec5NP85CDJ99LHXq/ss+BEJ9tBrSAF1gzxghEBKT8t1CAM
         Nn1g==
X-Gm-Message-State: AC+VfDwZOVzREwaL5tmdJ674hFeeYQv9GnqqO0Wof4zs1pVLEtxi4dus
        30Hk1kE0/ZL8gTrgQQboNFbMA3ZP/BTE
X-Google-Smtp-Source: ACHHUZ7X4vALKAJN8Hm4kK+hK6jc7G3nkp7UVAsNSWjonR+3UF14FYxQwQ/ABnx9rlRiM9YAPy7DUXkqHcCe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a0d:ec10:0:b0:561:4cde:92cc with SMTP id
 q16-20020a0dec10000000b005614cde92ccmr6170274ywn.8.1684737855588; Sun, 21 May
 2023 23:44:15 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:24 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-18-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 17/23] perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
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

