Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43DC77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 15:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjEQPAF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 11:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjEQO7c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 10:59:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EBE869E
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so1011190276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335538; x=1686927538;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iZ6qGB4BkCweU32BlOkjB5bl2jv6IU485B2b23bYK4=;
        b=Y5dnDT484VQ3r2JO431q20oRcF9/rj7TSNXpH4/0Kyp5Dt+SnjjC+8qa4M5OcMhBoj
         /zLspjFTDjvzok4DL4jD7SfowhYnDxsXAFz10HpKBxCi9Dfljw5HnajrReBjr3NlGas0
         sLLIlAPW/ldwHcslWQnRTU/AFheuuk5Vk1aMohxf1yX9HDSCq7OEwWs9xqwEUJi9R79h
         RLqa8I/xWWK2JZ99ctC1JDjBP8iWhe7e/5QGlPnM5VBPJCRnVQ2Nqva0Oi10skXA9Mth
         wSD6mJEVkAADrmMb9smfPkLZVchBMcoioHvMYln/ecP7CWvO+KWeLMqvNmxiNVCwgJGU
         DAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335538; x=1686927538;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iZ6qGB4BkCweU32BlOkjB5bl2jv6IU485B2b23bYK4=;
        b=fZuCY8+uBv1Lklmw+orlL7HP/TTVOk1zDCRuIYS1HIHjpEKPpk3thEU8NT0bPSNxVQ
         MKdmM3rlxtStjdOkF6inTLr7oKboAzUh7Js5bCKZNHmazWETmtm/XbFZSPMGeQ57aazk
         K7TCcoFHxMCqZdEG7yVrMtiEJMdcTtykaeKEKUoUHJKhV0hXIBnR2yyF6flTz9kz/wrv
         3DhroiY3gwSwmqoHQrSBZ7952ki15dDnIrLeaLmGoZcKcWeuctqUk897S/hiwj2eVfpY
         zMhzMyMMtO38KtKHUgoGK7Sj8k9J/7UeLQ/0O8uptDPpLdXmBsGdCKFmr6uuncd5e34q
         UIxw==
X-Gm-Message-State: AC+VfDxNO063L1fgOw9w6kLemNzrDeY8xYv4qdUAu6QDhRwZmHsCeWuW
        LlorSYq4H71I0Sjba9GceluwHtlmZKzp
X-Google-Smtp-Source: ACHHUZ4oMCQZTlliNKp8TzSxbb5PnBuH2tMzAOtI6hD/zQSxkSAp6vw6sP7G2D7vxCfKuH3Ijj6KOxUjy7c3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a5b:e86:0:b0:ba8:4489:74c0 with SMTP id
 z6-20020a5b0e86000000b00ba8448974c0mr2466852ybr.6.1684335538014; Wed, 17 May
 2023 07:58:58 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:50 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-11-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 10/23] perf topology: Avoid hybrid list for hybrid topology
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
        Raul Silvera <rsilvera@google.com>,
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

Avoid perf_pmu__for_each_hybrid_pmu in hybrid_topology__new by
scanning all PMUs and processing the is_core ones. Add early exit for
non-hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index ca1d833a0c26..a5c259bd5cc0 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -12,7 +12,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "env.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 
 #define PACKAGE_CPUS_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/package_cpus_list"
@@ -469,11 +469,17 @@ static int load_hybrid_node(struct hybrid_topology_node *node,
 
 struct hybrid_topology *hybrid_topology__new(void)
 {
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
 	struct hybrid_topology *tp = NULL;
-	u32 nr, i = 0;
+	u32 nr = 0, i = 0;
 
-	nr = perf_pmu__hybrid_pmu_num();
+	if (!perf_pmu__has_hybrid())
+		return NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->is_core)
+			nr++;
+	}
 	if (nr == 0)
 		return NULL;
 
@@ -482,7 +488,10 @@ struct hybrid_topology *hybrid_topology__new(void)
 		return NULL;
 
 	tp->nr = nr;
-	perf_pmu__for_each_hybrid_pmu(pmu) {
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!pmu->is_core)
+			continue;
+
 		if (load_hybrid_node(&tp->nodes[i], pmu)) {
 			hybrid_topology__delete(tp);
 			return NULL;
-- 
2.40.1.606.ga4b1b128d6-goog

