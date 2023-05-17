Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6171C77B7F
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 15:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjEQPAH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjEQO7h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 10:59:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F4A5C5
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:59:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8217b3d30so999547276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335545; x=1686927545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfPINWQ70tKE2oQZ4a089MC2MrpK2HVQ5LFJHLrDnLo=;
        b=RjY72mZrh3tbCojZgyLmOIuA3HnkY7ChcacoaTo3LyHlFIjA6R0dt4k7fvJu0lRqKg
         6w2dGt4RDaj+cdxT8/OT+5rqP5BpHXkJNbD7ckLJy0leTiGjwM9+R+q9pj4FQiklIOvB
         ThnM8jzgGn6gKDTLdtQjU+T5h9q+BZLNWe+B+I23mnduNJ9XO+/TAsfcsWmG78HIMpvX
         H9nIED6Vx7wxULb6YEVn/KBzyiCGN3fwXuyfq0vznDDKJ/je9VUxnX/EoxGGffSwMXiF
         dCtuePtLeQIKdmK/GDr1TL94ROfYUmlw9Spe+k70KVWQR9hhHSswy22rBnM9H20IVKHj
         2Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335545; x=1686927545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfPINWQ70tKE2oQZ4a089MC2MrpK2HVQ5LFJHLrDnLo=;
        b=Ae4pwSrqNm6Za97X5ZIAFOR1pLzVcSGjgrIN2HY//HRa4ZFv+W1KLUwRc+PCRHdiKb
         jdKalhtzKzIF/5HNtciMKEZFSZvhsTsOml/eLSTaeLNTDfSVrEc9eQfhLbSrg1SlF5Z3
         jOaJoKxLUdhPuRtzB7R70l8RvCGcQ4eEsLYpI4vt827VG/0yyOh5yW0sTIc0XL3IE9Ig
         wggb0MtlGneNgTKX9dF/lKsWAyhHv4zw47VGcH2VXljZ2nnINX3FUbolb730sdT7Grju
         baCTU0GcumZkxC57u5m6ELpfAyeDEeHborg+0V72SQ4nd8KoO5ZPl/LuWDTZGXAwHzcX
         yYBQ==
X-Gm-Message-State: AC+VfDzLtRv4E5xSYE7Wm+ft9GvmVw9EufiYYjnClfGlH8oY/bkDxAk5
        gSEWHzhGZhEyw8nACKYkJhM6O4eII3s2
X-Google-Smtp-Source: ACHHUZ6Yw0szBeMFtJeTPLuEd4Khb/Vry8Fn1wOc9bL6aAM7eU9JIjaTmhnF6uOApdPbx6ynjKo0Es/0C9G/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:2fd7:0:b0:ba8:3e2d:58f8 with SMTP id
 v206-20020a252fd7000000b00ba83e2d58f8mr2707513ybv.5.1684335544964; Wed, 17
 May 2023 07:59:04 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:53 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-14-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 13/23] perf metrics: Remove perf_pmu__is_hybrid use
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
2.40.1.606.ga4b1b128d6-goog

