Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B07C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbjEXWUH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbjEXWTr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8982E4E
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eb6c66f6so17355357b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966757; x=1687558757;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjAbWq1xZ7aD31R1h5+Cy8ZSDZyyIBasEI10DVMtL4M=;
        b=p0AhpgXvZl8O7RhTTMtAr534BDXoiK4d/HxTufbtoGDKujmUAJho6GTXP8kd6FAbKl
         HVIdVGezNvfTcmbLbZIj2zZRsM4FsEy6iN6IWt+evEgx8S8XI1x1ZtfRltJRmPu30hd2
         kkIFB/josxZHZWjTz//UdEi3TZqb4OnOn0EaVu0FhPE27c1gkvWp2B//EcHGDg8e3ThF
         18xvAzudf0X9+XnMuE1fC9PiNi2n3flAM7q+czmWCENi/N7vYvEuMdKO9wSmKo2uIPTt
         qNVxvbOW/fw4VVdd7cR50euAcg7TmYSqKPksPwCwGrzvRiekbPTPwzxLgP+w+CclTopP
         dvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966757; x=1687558757;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjAbWq1xZ7aD31R1h5+Cy8ZSDZyyIBasEI10DVMtL4M=;
        b=NJQCVJGrybaNUvvfeLNd8PV2hDaPjy4GHA7Oyz9jq+bulavf6E98p1B/ESt95AywnT
         wZVQ4D8p/JvO+eFozPNCXW4xcyMCQKqrot705EY6K4Zrib0gZWjWB2NqLGGPQt1F8XyT
         DD+R4xSRIvurtVXLY1WsR6qbgCdn2jpowg+UViUCbaRYAOzvpvB+5YUwXF6ZmxJQh9Zm
         kKTQI66uXgm1CuuKhjqJSryJGnLY/g9jB2j1nWq81aZeQBhqBESi21qmgiuhVDRlXQA0
         Uex2xH4/ZWQXRl7COieij0Q+Fy5jz3XZ8P0VzUpXQEuQw4lybA+NLcJ0kavFMOU4bU9v
         hLGg==
X-Gm-Message-State: AC+VfDx2+DuemtbclPYFJRceMGsp0h8SQipEvp+nWVBbL6gcSVojhwFn
        hlY6wLGrFuGP89YmPZStAR5aVWqikwKi
X-Google-Smtp-Source: ACHHUZ7A/zgz61i+jDQae5egqZTZUd2asN0Lc32kLdqF4kB08b2NQcqeXPmsMs8FXQsh8XavrY8B6mFmujRA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:a749:0:b0:565:51b:c6f0 with SMTP id
 e70-20020a81a749000000b00565051bc6f0mr7187150ywh.6.1684966757019; Wed, 24 May
 2023 15:19:17 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:14 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-19-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 18/35] perf x86: Iterate hybrid PMUs as core PMUs
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

Rather than iterating over a separate hybrid list, iterate all PMUs
with the hybrid ones having is_core as true.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c   |  2 +-
 tools/perf/arch/x86/util/evlist.c    | 25 +++++++++++++++++--------
 tools/perf/arch/x86/util/perf_regs.c | 14 ++++++++++----
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 941a9edfed4e..944bd1b4bab6 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -3,7 +3,7 @@
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 #include "tests/tests.h"
 
 static bool test_config(const struct evsel *evsel, __u64 expected_config)
diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 1b6065841fb0..03f7eb4cf0a4 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -4,7 +4,6 @@
 #include "util/evlist.h"
 #include "util/parse-events.h"
 #include "util/event.h"
-#include "util/pmu-hybrid.h"
 #include "topdown.h"
 #include "evsel.h"
 
@@ -12,9 +11,6 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 					struct perf_event_attr *attrs,
 					size_t nr_attrs)
 {
-	struct perf_cpu_map *cpus;
-	struct evsel *evsel, *n;
-	struct perf_pmu *pmu;
 	LIST_HEAD(head);
 	size_t i = 0;
 
@@ -25,15 +21,24 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 		return evlist__add_attrs(evlist, attrs, nr_attrs);
 
 	for (i = 0; i < nr_attrs; i++) {
+		struct perf_pmu *pmu = NULL;
+
 		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
-			evsel = evsel__new(attrs + i);
+			struct evsel *evsel = evsel__new(attrs + i);
+
 			if (evsel == NULL)
 				goto out_delete_partial_list;
 			list_add_tail(&evsel->core.node, &head);
 			continue;
 		}
 
-		perf_pmu__for_each_hybrid_pmu(pmu) {
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			struct perf_cpu_map *cpus;
+			struct evsel *evsel;
+
+			if (!pmu->is_core)
+				continue;
+
 			evsel = evsel__new(attrs + i);
 			if (evsel == NULL)
 				goto out_delete_partial_list;
@@ -51,8 +56,12 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 	return 0;
 
 out_delete_partial_list:
-	__evlist__for_each_entry_safe(&head, n, evsel)
-		evsel__delete(evsel);
+	{
+		struct evsel *evsel, *n;
+
+		__evlist__for_each_entry_safe(&head, n, evsel)
+			evsel__delete(evsel);
+	}
 	return -1;
 }
 
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 0ed177991ad0..26abc159fc0e 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -10,7 +10,6 @@
 #include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/pmu.h"
-#include "../../../util/pmu-hybrid.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
@@ -286,7 +285,6 @@ uint64_t arch__intr_reg_mask(void)
 		.disabled 		= 1,
 		.exclude_kernel		= 1,
 	};
-	struct perf_pmu *pmu;
 	int fd;
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
@@ -294,12 +292,20 @@ uint64_t arch__intr_reg_mask(void)
 	attr.sample_period = 1;
 
 	if (perf_pmu__has_hybrid()) {
+		struct perf_pmu *pmu = NULL;
+		__u64 type = PERF_TYPE_RAW;
+
 		/*
 		 * The same register set is supported among different hybrid PMUs.
 		 * Only check the first available one.
 		 */
-		pmu = list_first_entry(&perf_pmu__hybrid_pmus, typeof(*pmu), hybrid_list);
-		attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			if (pmu->is_core) {
+				type = pmu->type;
+				break;
+			}
+		}
+		attr.config |= type << PERF_PMU_TYPE_SHIFT;
 	}
 
 	event_attr_init(&attr);
-- 
2.40.1.698.g37aff9b760-goog

