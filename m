Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0529DC7EE33
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbjE0HZN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjE0HYX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:24:23 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9294FE51
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:59 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ae3f6df1afso17437705ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172202; x=1687764202;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOWg7xv6khXlnHXVYLJhfsnkHXaBKspybsIekBElbCY=;
        b=W29SobjZ3cxFDl6VPrkoh3+hTzmmIGuh7R+StRgY4VOHdhuKyzKkwyZMofIV5PSAlV
         thSNjUb7W65Ac4cQ3mGf/3uGYoT0ubzWmD/nplbJegxhjrg0WBRm+WKfo7kWkfrP2208
         GY1SZPN0kWlI1XYErt7mJ4ifDzZM6JBREiH8SMyzNL863KSEQTcgjjW8gawrvv05wdDI
         6LuMAeuMrH/rUpoZvFTbl6uYdNmPqGmkPhEx3mly1xjr2ILImG1JsZCmfa+ZBSOeBhZG
         A/F2jcJyEMI+wfU0s4kF7wyFChMECTr4YFuP6EkaiDFUAUbyQ1dN4Y4QL+8K11+k4GT4
         m9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172202; x=1687764202;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOWg7xv6khXlnHXVYLJhfsnkHXaBKspybsIekBElbCY=;
        b=AjgIP4xI4jIiEnrsd86gG9RivOYy3nDT3jxCRr/InlCUduJtrLlOMWDpNimpolRleK
         BzS2cvon/osHxC6sOKk5/tabZUhok8rhmOE05m1FXYYtE5zoGOcegFMCxolcaXlyuqrP
         1vn+AVuRKebRb8N2IM3ms5oHjJgTX+WaClkTa/WHQ1JvsJBPi8l0Lq1xMl3DFHfgQt2z
         BRlF9UnP/H2XkCxRa8gXyR7ttDOTuP9+/yOJS9pg9+5hW3pYRMuVKVGBljBIfyQpsvmE
         lQ8KEfqcUqdWnRyH1A9iE4lU4AKKRqtijEpuYRlJ5mr4IPFHotMPs+ytCEj3kzNe+Sru
         /1cA==
X-Gm-Message-State: AC+VfDx1pnSszsm3a41rvKJy0LlbeUL17jIXa4wpFqTssW269SK/T9O6
        OzriocKTH6HnwAwQeOBLV/medBc+VVv+
X-Google-Smtp-Source: ACHHUZ6RNizNSL0TjaGKE8dosgEQwUjtr4jO3iuEXZV/dZTTGfOtN0y6V9NX4mdM1uMWifNPU43MplbZN+VE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:903:1cf:b0:1a6:a899:fe78 with SMTP id
 e15-20020a17090301cf00b001a6a899fe78mr1208202plh.2.1685172202649; Sat, 27 May
 2023 00:23:22 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:57 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-22-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 21/34] perf metrics: Remove perf_pmu__is_hybrid use
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

Switch from perf_pmu__is_hybrid to avoid implicitly using the hybrid
PMU list.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/metricgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 80ffd6da70c7..3f04a686d1cd 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -11,7 +11,6 @@
 #include "evsel.h"
 #include "strbuf.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
 #include "print-events.h"
 #include "smt.h"
 #include "expr.h"
@@ -274,7 +273,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
-	bool all_pmus = !strcmp(pmu, "all") || !perf_pmu__is_hybrid(pmu);
+	bool all_pmus = !strcmp(pmu, "all") || !perf_pmu__has_hybrid() || !is_pmu_hybrid(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
@@ -288,8 +287,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		struct expr_id_data *val_ptr;
 
 		/* Don't match events for the wrong hybrid PMU. */
-		if (!all_pmus && ev->pmu_name &&
-		    perf_pmu__is_hybrid(ev->pmu_name) &&
+		if (!all_pmus && ev->pmu_name && evsel__is_hybrid(ev) &&
 		    strcmp(ev->pmu_name, pmu))
 			continue;
 		/*
-- 
2.41.0.rc0.172.g3f132b7071-goog

