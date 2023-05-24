Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF6FC77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbjEXWUn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbjEXWTz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CAE5B
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba9d8b01f82so3199403276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966765; x=1687558765;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LP27CftfdHYnLweWt0lX22v4lNIGIpmQh1ljDLrV4jA=;
        b=lYADs1VbYR/2zJtQXymNcu0XOzeLjuk2kW8pz8OEiHhfvUHQJh2Atn4PtH+6mAx8FM
         iYs86lOXb4OVWuHjuhHOXgtWOs9oKpr9ezh6cskrIOHTv/UssX/i7dMlopbgunerspC7
         h2/ymCj6IQ/Lrk9hfyUloxKOsD5s3zG0Iygd+8lhERAnPDD8++D5i7HBtkpxEJ4iC1rg
         vNCLff8bwWgFpYXRO1lDLFJ/rNciZmDSrji6mjomGnYqBHisbvWLkfnYTBqQ+3K5Naa0
         Cvf9AHBTpz+hi/c1c3jRw2tjeSUq3nv8Qm25Ek5YlVHftKpKiDk4+oTPtNBHD0srlDeB
         Maig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966765; x=1687558765;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP27CftfdHYnLweWt0lX22v4lNIGIpmQh1ljDLrV4jA=;
        b=inNGPl5cRh1lGgvdaZYcBkzGIDuGXAV2KfSzGevzLiGTYSS5X84/F2NzqXnhb4xgkD
         p7FUF8dlnIew1khmF2XAMisCgEw6hs5h8lBItNmSvYf0CwptC5ZA9KUTtll7t8gmHHb0
         pj5OhaX7ENGdoJiXOMSOA+y2KUoMpBJAKVxFKDPbpZqzvC3MvgQZNrb05RaX5uosg5fW
         XnBW4IG8y/bhEvwCIag/Qr99l01jsyCnNsQ9ROBkkYpx3svFDx29/EqW0rSaFH7Q8yde
         4E/Eh1a44WP7TEiI//uUrfZWH2LtKje0xjwFHJFpW6ZULTUJymJSSdtl3y4d9xd62pJp
         T1YQ==
X-Gm-Message-State: AC+VfDyyRJGXDaccEEBTjWzHCCLkwvjIH5tEPryz9VXw35XwosDxPPY0
        bQ8m6rKtZ8AVYil6ogl6MdB+k5o9kf6P
X-Google-Smtp-Source: ACHHUZ665i5nk9ovpEFzjxU1ohjxl63X2v7RPNE5lzH+XoYby7ipz6hZU7xMBGBWZkIBZfe03YbJ3muJ6Bn0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a5b:b45:0:b0:ba8:939b:6574 with SMTP id
 b5-20020a5b0b45000000b00ba8939b6574mr756838ybr.12.1684966765640; Wed, 24 May
 2023 15:19:25 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:18 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-23-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 22/35] perf metrics: Remove perf_pmu__is_hybrid use
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
---
 tools/perf/util/metricgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7de721e9d895..72583f62eda8 100644
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
2.40.1.698.g37aff9b760-goog

