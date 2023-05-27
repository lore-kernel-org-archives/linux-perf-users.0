Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53851C77B73
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjE0HX5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjE0HXp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:23:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEA10EB
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c3186735so3209819276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172200; x=1687764200;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqP1dRbi0z833EHF751vl8giti0HXs5ukSY7qCN1g0w=;
        b=2kBMBGQCNCVPXKwPpkHyJBWvUoRDkBN/sKyHrI22HZN4kVsv1tjrWZ1+1PyWumUUv4
         zmyxWFFQEX4TwMCeQWgZjlKqEpQjscS8OTAupUoKjx/2DHjLKJNLeoMJi5KX7li4KSUB
         Qp8tHNHvi7EPYLlOLpYoisV7UZnQn3yaT34IxQELV4ljKiJtnZ7Jz3JCT+nEcA0v6wLT
         yccndEwXdPCDPf4b5HVj0nCugelJgh2HQ15UGQ1KG+2lof65+sVsjhmxPnVqM319BNo7
         AOfSZKbKkHM3SZGtatcGRyMz2X/CrAZsvykgUcZU2AZ8wWEbboqeuvprtTZefHOQ9L1b
         XfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172200; x=1687764200;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqP1dRbi0z833EHF751vl8giti0HXs5ukSY7qCN1g0w=;
        b=UJHTa1oqqxUpGsyoXNfDZvd5s07XCM9/IWwAKFh2vEKwrwCozMA8LCWXdqD1YyitKL
         LCzsOIR/dHQ5AO1w5L25/p3xbjazie9cSq6VM4zV6N9I+IbBxO/NtsLt3M39CVKv7dLg
         PUg3i9D6PCsqXUNrk9z+7Ak0MVm6Gh3LykfDlM/lS5okvmlJZewLhvkpx2DSTw+EwqnL
         20B2HNYAx/k1I7Pmv84BAtgDqQswfv2bObuv1aT/Mt+EY8hBX0pms/sak4Ilzdh5tnDv
         E5mRgO2R1HqgCn7gavxs/DAq/xUEDeT7J6rgtFpW86dcvbloe4JLBriqWz3Te2DB1QHi
         bR2w==
X-Gm-Message-State: AC+VfDx20WyAoZERgxnJ607AV6dDPkRTExEywrSgQ6NivBsYENawF/jT
        fYoJJVfg1vDgzAd6uq1ajdktcS+kVxCQ
X-Google-Smtp-Source: ACHHUZ76o+c/sYmGbWvbAaIBR4uAUeBzaLsvkyOeiJjP693g36lTy8NpDAqBGh9DNxkz1LfXqYWApOmzVF7I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:5ca:0:b0:bad:252:9f73 with SMTP id
 193-20020a2505ca000000b00bad02529f73mr1645263ybf.0.1685172200050; Sat, 27 May
 2023 00:23:20 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:56 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-21-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 20/34] perf header: Avoid hybrid PMU list in write_pmu_caps
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

Avoid perf_pmu__for_each_hybrid_pmu by iterating all PMUs are dumping
the core ones. This will eventually allow removal of the hybrid PMU
list.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/header.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 560871736764..37fa66b1ca77 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -51,7 +51,6 @@
 #include "bpf-event.h"
 #include "bpf-utils.h"
 #include "clockid.h"
-#include "pmu-hybrid.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -1605,17 +1604,21 @@ static int write_pmu_caps(struct feat_fd *ff,
 	 * Write hybrid pmu caps first to maintain compatibility with
 	 * older perf tool.
 	 */
-	pmu = NULL;
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		ret = __write_pmu_caps(ff, pmu, true);
-		if (ret < 0)
-			return ret;
+	if (perf_pmu__has_hybrid()) {
+		pmu = NULL;
+		while ((pmu = perf_pmu__scan(pmu))) {
+			if (!pmu->is_core)
+				continue;
+
+			ret = __write_pmu_caps(ff, pmu, true);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	pmu = NULL;
 	while ((pmu = perf_pmu__scan(pmu))) {
-		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-		    !pmu->nr_caps || perf_pmu__is_hybrid(pmu->name))
+		if (pmu->is_core || !pmu->nr_caps)
 			continue;
 
 		ret = __write_pmu_caps(ff, pmu, true);
-- 
2.41.0.rc0.172.g3f132b7071-goog

