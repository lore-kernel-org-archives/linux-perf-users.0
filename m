Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F38C7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbjEZV4R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244270AbjEZVzt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:55:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE88E4F
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24b8a4so1598862276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138103; x=1687730103;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOWg7xv6khXlnHXVYLJhfsnkHXaBKspybsIekBElbCY=;
        b=W0sbXBZjTNC5elb4bFAzWrSj03V+jXeRptyRfgeZBFfYPiQ/kEzaCQ7ecf978AgSai
         7dK1N5NXfuK1R9jZezbIg9o5SyfFUKxumw+dUzdIhalmB74iFOxurgajxQuXAZAb/dRP
         oDMO6/hPF58YGXDmNCIjdv26YtzsU7CLgiqPkgFHcYlf8Gj5dCs2oj2wC+yXLvPxVUSt
         1M0AyuCe82OcLft1ytjm52Sxl6YZcYlxUf2ldW7RjcEBeRXxJgGg59inv3KhNfknnJUv
         1hyUVVzxLc2ZmQ0kJ52A36IGJPJ9wc+hKSDW/zqy3tffkBZWKsoIldeGy2inRZ+2gdl1
         AYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138103; x=1687730103;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOWg7xv6khXlnHXVYLJhfsnkHXaBKspybsIekBElbCY=;
        b=j792ch//Oibs9IAX3pQGIs5NEj+pxocKdzBQVoAW/vjWzO1wdhc2qgZ8OVj1CTL8PM
         xLrLtXHXIDEDQ5T3BFKCBOQJ6PP9mXbwxz60lqo2dpuBlPj5wd+tFCdl5VBWEU0khtR8
         c3SfWMfuwK+NY6tjDMJw1b+EeRVCYeSgiYso7MMHCEu7iY8Dmc2ZlKT+xr4kO1lOKKFl
         U/6WHJPgyegTKRNBUX/q2m8PICfKdyUucFWKXdqvG+xlzzA1Vnax1NIVp9VBqH8wH8j+
         URgPKNGxXNTk2tok+sq5c882BHdF5zKnnIZYgx4QLmlTWXsWykw3Dp9rPMa20F0MAt0G
         TOuw==
X-Gm-Message-State: AC+VfDwmjq/t6Mt4QOjDzhO2K/MpPDqywZHjC7UdvuxZkeI39VEqpEhx
        UGfI0nDeIbTl8sIB8vmU6yKbR4xXxObh
X-Google-Smtp-Source: ACHHUZ43XEAJO3f00pn7wWSBbjxBs6NDSOWGch/bUqBzmufYwYUeVNJDfIIp13hDPrkPN+Pth1/fwjjLgClD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:ad93:0:b0:ba8:37f6:a586 with SMTP id
 z19-20020a25ad93000000b00ba837f6a586mr1668359ybi.3.1685138103181; Fri, 26 May
 2023 14:55:03 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:57 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-23-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 22/35] perf metrics: Remove perf_pmu__is_hybrid use
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

