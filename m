Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC7C7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244323AbjEZV4J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbjEZVzp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:55:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B5E7C
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564f6099813so24405647b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138101; x=1687730101;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JhuPa0yYdr5XE/axPY0rbTmGM2hgd+SHnXF4ixe3X8=;
        b=p0hBHqS/kbJjbfJGwxuRUo04ZHzZbtiNWdu0VCN16lg2GCJKFhldQ3gID0UCNDrGb1
         JOWxsmzR3ywCY/Gm3Pl4YYD/zV4eBhbkic6TCsvAflXi4lTIB61pRixmuNxGz8vI/qkf
         yyjNMq9HSpljKwvyxhiZhmK2eWeI33/fERKy4D1iHYrlE8l2KpG1UK6pqoShCsXX0vB7
         XzVUxo2tDj66XT77zGSdnRNR2gw3KzJJCdlpmTB3UHpxKKMYfZGvkp1ul1/VX0nANezt
         wyAB/4em/wmseHezl+U2xh+KsmCgIkQFD1MHX051cfvrYUKz6dfR1r8WtHXKO5Hvh6Ed
         ZVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138101; x=1687730101;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JhuPa0yYdr5XE/axPY0rbTmGM2hgd+SHnXF4ixe3X8=;
        b=Zhz7qV/uQYCsRezcDCcety3GyovhM+3X2j6y6QBHDmPiyHchRD/cvurp7McBlsbFhY
         G4tqFkfrTN45sbgjTA59Q0xhtiYS+7QxeA3g7+vdgSjbUWganFKjsVWwi6J4D7/F2I6V
         Q3V/0+I501yApIka+ju8BO++Yi1F7d0bbsXUE3SR3xVAvAIZ/4ho5yle3+Yn03TOFZhJ
         2dFNdv6MI6QriT8dUdV9DmoFqV3J6oyOyidDsZfbbRgU4KaP+Y1fvYzPbk+N6kSc/VeB
         LkK7aL3a2BbMS5mkUSYl5MWTksmECR5094IGLDUBIE92FHjzGTybjZZB5yD4OF4PSJfv
         Qn3A==
X-Gm-Message-State: AC+VfDzIqjQjVVHHoEgh4urNL5A4/zTSLomck6XUeFG98Nyfr6nHNqDj
        edG0G9O4cVbDHA4rSAmrx8Ch1xm1hAaT
X-Google-Smtp-Source: ACHHUZ4A0QwFGk16QfrxzwtIBAupC8GjSkfGg2PYWQQdvdXEGuWw24/+woiJ/4Rrhd0rgNdBl/p0Z5U9NhWo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ce01:0:b0:565:9e73:f92f with SMTP id
 t1-20020a81ce01000000b005659e73f92fmr1805177ywi.10.1685138100933; Fri, 26 May
 2023 14:55:00 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:56 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-22-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 21/35] perf header: Avoid hybrid PMU list in write_pmu_caps
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
index 276870221ce0..e24cc8f316cd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -51,7 +51,6 @@
 #include "bpf-event.h"
 #include "bpf-utils.h"
 #include "clockid.h"
-#include "pmu-hybrid.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -1589,17 +1588,21 @@ static int write_pmu_caps(struct feat_fd *ff,
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

