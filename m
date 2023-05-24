Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08892C7EE32
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjEXWUB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjEXWTq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0BE49
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba81b24b8a4so1860984276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966755; x=1687558755;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1T7njr7JkWMvDDZnEk/t/BOuD5WuTu8PcvmdAEMrg8=;
        b=ySSNKtAZRkZfdrXUqJSOlEp1TXX2LZPRSt+VlUljfAOealn0tl+3yQPXwNviNIUsPS
         /n/9N1KdMBfE4JUt+jNy5w6m0tkFUcAF80uJX/6QzVwGMK5Sgdxm4VrH0miQn40xd9mm
         obprTgtKg0ThCaT4frbwOAHpDCGfwdLhpOpN4tjl/hLS5G+HCr/bOU6XDg2q5txLWA8B
         XlCHbKFm+gvuImcNx2BRCZo46+hcnOG5bzpPFuAVAU7r+79Bji2ZJpvkZo/xBbiasPMm
         83NgkjqwhAj6+KsKfrK2E1PIzavbOsWBD3FxzG6wQSbciTUpaHQp1nQW9OlVyOO9udiz
         GPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966755; x=1687558755;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1T7njr7JkWMvDDZnEk/t/BOuD5WuTu8PcvmdAEMrg8=;
        b=iFEzVBy/xaSXquX8fsjUc8rdnqpqWcXPeygjKRIgOiuKXRGkLkORYTix15QnHfLGjq
         TqPqcMpjyy4KMpr6ike27coxJTl7HXwJu5w0qucAOGEAoNPezQx0DXlfLXc87S89DyRb
         CaBnRhx9R710KjXVc0yQuef6c7FTop/c+ucCToNvdxQWsZmPC1mt9OoeBJsWMKnPyXG2
         n+uoUr+ZnnuBhdlaruuJh/n9e8Oisf3mcunMf5wG0ptcm76iYusGtDO0e8f+XhUgE7PF
         eP+WWE0T2pnHXsR/84FHRyg4f6Jitgr1S7g2/TZPaOj3hs9TOEpxM0JgJHWmxiEmuShM
         NjHw==
X-Gm-Message-State: AC+VfDxhHocSYJjmEpHX1zsrEPldyALq5OUN6x8DdfQnpXHKRWWNeflN
        cLsVKOvxrc7QaINnFP62vJ/ykq34/ps9
X-Google-Smtp-Source: ACHHUZ6qH9PCyRVFSAUQW8f9PmxZgpl8Yzylqljyq6W3cock0VJZmarcGXaRRN+3X5MziK1RwyHWEWWZ62UB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:5442:0:b0:ba8:8ab3:3806 with SMTP id
 i63-20020a255442000000b00ba88ab33806mr731563ybb.13.1684966754736; Wed, 24 May
 2023 15:19:14 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:13 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-18-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 17/35] perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
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

Rather than list empty on perf_pmu__hybrid_pmus, detect if any core
PMUs match the hybrid name. Computed values held in statics to avoid
recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e9f3e6a777c0..821cdd79db48 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -60,8 +60,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-static bool hybrid_scanned;
-
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
 
 /*
@@ -2026,12 +2024,20 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
 bool perf_pmu__has_hybrid(void)
 {
+	static bool hybrid_scanned, has_hybrid;
+
 	if (!hybrid_scanned) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			if (pmu->is_core && is_pmu_hybrid(pmu->name)) {
+				has_hybrid = true;
+				break;
+			}
+		}
 		hybrid_scanned = true;
-		perf_pmu__scan(NULL);
 	}
-
-	return !list_empty(&perf_pmu__hybrid_pmus);
+	return has_hybrid;
 }
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
-- 
2.40.1.698.g37aff9b760-goog

