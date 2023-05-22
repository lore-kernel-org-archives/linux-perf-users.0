Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D5AC77B73
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEVGpV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjEVGoc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:44:32 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD712D
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:03 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ae3f6df1afso57268105ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737843; x=1687329843;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FXlJjlrAGttKZp5HRCBcxE0XLHUZdESbTdmHXPLxLA=;
        b=uQtwox96BxP135Bg+/OnbOh3t08WB231lF5dBoWs7XQck3bMUZTrhASU7PKQAgggKP
         jSpsuc5XfKDqSPJHqPONlBMeCiCuAYxyq9G13gocGHbCjwrVKS8GQeoPc2GKmmE8Tx1C
         NRfTkZIEXeREFqZkO4pPRJOEYBVsDEHzQ7odWrerf1XOVIWDvBKpEIqp8oa3ghLjEz7r
         AXgpmpnzyuu/aPMZidML9SMkQTKmt7mO0sJFG22Q3FSry6nzENTgDrmFt7B97wbsyw70
         6sXgYPTuRLxVZlDUpldlsI8ciPex4R9nYB55AxN8N0WAGBn+9wScSF40AGy1FM5W+EXe
         FCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737843; x=1687329843;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FXlJjlrAGttKZp5HRCBcxE0XLHUZdESbTdmHXPLxLA=;
        b=JSox6GovY6S1RwjO7JSWUSBsLNiSmcnyoHJ2fd5D4vRK1F+rWtMS+EhjDYJvfvvxQb
         HcRhuxYw7UnUx6ABR1TCBhptG/lbNRe4TgPzr1/yyYnv3UCo6L1fh9vHpghLDegUjNKK
         1UKQB6/dLoOaiW0OzeTlDda0FHPjSYKlDyZmwBqOqitOTrUYCpx4Bd/ER5xIEzhZobbR
         Vr5fRETmC3R500Tg2R2uK213t4RyLeHlQmbZbTuZkQB0uHtF74b0ScL66InRuNPDx0Wc
         hUyGo7BOJ7UIE+1jh2SCXNaqjG0JAi6ug8pDCgLXoFlFwxwu1WkkIijqGFJiawzAA6Du
         YqjA==
X-Gm-Message-State: AC+VfDwV/7AmlYmGyb7SrOTdKpNV5gUeApw3VOqpZFrNiXR8URJ/EW+m
        mXwN4HHBORX/E2gv7eCIIWuPmoMeW2zc
X-Google-Smtp-Source: ACHHUZ55HBbHoyydmqJrkbpfG3EYrND8RbS1855ZiyjfgI4tGdjEHQmraCmjxhBrJZkKd5Ar5y0srVkir//K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a17:902:f152:b0:1a6:c58e:9b9e with SMTP id
 d18-20020a170902f15200b001a6c58e9b9emr2177250plb.7.1684737843278; Sun, 21 May
 2023 23:44:03 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:19 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-13-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 12/23] perf header: Avoid hybrid PMU list in write_pmu_caps
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
2.40.1.698.g37aff9b760-goog

