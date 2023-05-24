Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92CCC77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjEXWV6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjEXWVY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:21:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88915E5A
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:20:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5654c7f991bso34664757b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966782; x=1687558782;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMM9vMp4aqYytcqLPDz/iiJMs6KDe9Jl9sq1ptTjl+0=;
        b=MvmCy8eCu3J+48fIwJySu6/NGqr6B+GI7lxSpQxNvyJQhdn/XJGu3tRQms8lXbb/mp
         fMXKKsCd5rbdAqCF1TmAHC2IcNQb8sG9HQlZs1Bwye+MlJl0dARXIlihtUJ5G9jn35vC
         n0bqk5RnApfckwFWdRl6CTxgRmShYFpM373VOmvX/4Bec6vOEjlIm8KscNwcB5MXLVXF
         HVuwl5z7sSqnm6fj2mh90+ZuwckfP6U/pUskAhby3ZSFzYnc4GKipfq/f4l1CpDL2/2Y
         7B/6Ln9k5Cy61FE653HTiPUaHr2pBf+pxWhi7I2eKCQzggaAzXPVLm1SNAYK0n9q51Ym
         /dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966782; x=1687558782;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMM9vMp4aqYytcqLPDz/iiJMs6KDe9Jl9sq1ptTjl+0=;
        b=luuCVcaT6xmIMnE6vnqwbhucQY40BHXIf+GCiIhqNP6tF6kqOWX9buaI6hNVZoua+n
         QqqFvLuDn+7MsLLaI3jFyeYMfButEuc5232VL00wuiYbFv8A1yfay3NfmP7qxOkZl+tN
         aMI50TyYur0mfJMwcsJB6Ev+NQNYI2In2XGFYm0oioa8vmLZGdtvBX2LBOL61H2JenfT
         TK8wJBe7UFWDZKLxCKn/kyur57GXoBYsTXYfazMGKE/kCvA290XI8gyLJDv1Nm1iYJ/l
         cqMwZg/WFZ47JuFvpRTmPBGfzJ4/6n4fExTOLgohPQfpj318Hm3R5Ky8pGdDdB7GbpOh
         +inQ==
X-Gm-Message-State: AC+VfDzVo/ZwFdrYyvb44bk7ArCx5eqT3Xoh+5UPaEZgNgZXA9c4hroy
        46RdwaTiiWlIao9l+934zLd3hBPTr315
X-Google-Smtp-Source: ACHHUZ4Hie0jo3VkTqExA880N8d0gJAH1peyWNkf3rk0bbCBNfDD3lXI4p8YwUqyZJmk9SodS9Mg7Lbe60em
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ae21:0:b0:54c:7a1:ef50 with SMTP id
 m33-20020a81ae21000000b0054c07a1ef50mr11781823ywh.6.1684966782088; Wed, 24
 May 2023 15:19:42 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:25 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-30-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 29/35] perf pmus: Split pmus list into core and other
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

Split the pmus list into core and other. This will later allow for
the core and other pmus to be populated separately.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 58ff7937e9b7..4ef4fecd335f 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -12,13 +12,19 @@
 #include "pmu.h"
 #include "print-events.h"
 
-static LIST_HEAD(pmus);
+static LIST_HEAD(core_pmus);
+static LIST_HEAD(other_pmus);
 
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
 
-	list_for_each_entry_safe(pmu, tmp, &pmus, list) {
+	list_for_each_entry_safe(pmu, tmp, &core_pmus, list) {
+		list_del(&pmu->list);
+
+		perf_pmu__delete(pmu);
+	}
+	list_for_each_entry_safe(pmu, tmp, &other_pmus, list) {
 		list_del(&pmu->list);
 
 		perf_pmu__delete(pmu);
@@ -29,7 +35,12 @@ static struct perf_pmu *pmu_find(const char *name)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &pmus, list) {
+	list_for_each_entry(pmu, &core_pmus, list) {
+		if (!strcmp(pmu->name, name) ||
+		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
+			return pmu;
+	}
+	list_for_each_entry(pmu, &other_pmus, list) {
 		if (!strcmp(pmu->name, name) ||
 		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
@@ -53,7 +64,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 		return pmu;
 
 	dirfd = perf_pmu__event_source_devices_fd();
-	pmu = perf_pmu__lookup(&pmus, dirfd, name);
+	pmu = perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
 	close(dirfd);
 
 	return pmu;
@@ -72,7 +83,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	if (pmu)
 		return pmu;
 
-	return perf_pmu__lookup(&pmus, dirfd, name);
+	return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -93,7 +104,7 @@ static void pmu_read_sysfs(void)
 	while ((dent = readdir(dir))) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
-		/* add to static LIST_HEAD(pmus): */
+		/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
 		perf_pmu__find2(fd, dent->d_name);
 	}
 
@@ -104,24 +115,37 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &pmus, list)
+	list_for_each_entry(pmu, &core_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
-
+	}
+	list_for_each_entry(pmu, &other_pmus, list) {
+		if (pmu->type == type)
+			return pmu;
+	}
 	return NULL;
 }
 
+/*
+ * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
+ * next pmu. Returns NULL on end.
+ */
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 {
-	/*
-	 * pmu iterator: If pmu is NULL, we start at the begin,
-	 * otherwise return the next pmu. Returns NULL on end.
-	 */
+	bool use_core_pmus = !pmu || pmu->is_core;
+
 	if (!pmu) {
 		pmu_read_sysfs();
-		pmu = list_prepare_entry(pmu, &pmus, list);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list)
+			return pmu;
+
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &pmus, list)
+	list_for_each_entry_continue(pmu, &other_pmus, list)
 		return pmu;
 	return NULL;
 }
-- 
2.40.1.698.g37aff9b760-goog

