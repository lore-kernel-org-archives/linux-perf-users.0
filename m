Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785B6C77B73
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjEVGqV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjEVGpl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:45:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3EE40
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564feceb97dso13206407b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737847; x=1687329847;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTVXYQjQQATmf8Mkt9G679/N0B13fTOwc5aaHfZePg0=;
        b=iiAigpdsXnQfOAaO/v/Fv96nlaEAFhaaiUurcRIqIJTdcXk4yZT84UKPYZtT8gnXAl
         rrcTqe20TVqxTno06d806fmEBBSujg/yLqe6D5QSiSJzOa3tLfqxS8LxbCeNL5R2HOG2
         wP6M1Wb+0Yn0RrqnaHR1pvTYu4IWwIPuNBv/cMJilRLa7ju2TZAhD55yGnze+5INTpae
         huN1BhxYAcSrWnNTtXfdgLgNpfhGE0CZRhepAgkRlqWsUZ71tKCmJPcCEriyj97T6wcH
         QivLA0P58eOG42Re93b11WLQpl0JnX/4wAuQsaX1WvpK5OF0lpCB9UlGfCAkYBLJGbl4
         ngVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737847; x=1687329847;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTVXYQjQQATmf8Mkt9G679/N0B13fTOwc5aaHfZePg0=;
        b=NeH44/m7Y/GrJKUU7GOq75+m5vgywmoXXvuJ4P/DthY9uvKi1f6pHYKsZfpvYFr+xB
         uu4BP3ezvv4lF/+2C20PzfbH1167/I8RH7V3Y2dEJQoZ1CqxbWYU+1jY9I904VWNeWbz
         0WUxWoEUbDyXFJ1Ki0kuIAQ83KZa6kp31RLr4U+5o0ROi+CkeyhCp/sVw9w5AiUIbaIr
         XNvwjaDZ63YeQXg1ZvamicGw5zSexTP6ul0jfO34OGtkFGi8nnjZlRZaX09nq5fGE3wp
         azoAZmYGXxEjVl3STtQX9Lkjl7RnEZZzp5t7VE6R2D4mZ3aYrVIr9zBN/MNcBMIiyUai
         0NGg==
X-Gm-Message-State: AC+VfDxP+UjkSqsm5LY+XhsN/Fr6UG6twRVnfHiMlBXmWFsKSxd+EKOt
        gnL9UpZ2p3CVMZK2CxpO+5hRaJPAqZQ3
X-Google-Smtp-Source: ACHHUZ7Sf8g2b29rTvR7d1W+WDJ54MMM6khifbI9MGuLm1xPmEkEB6hz+aOq+v1LLmQ9r+uQjhqSIRv7LUwm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a81:a9c7:0:b0:564:c5fd:6d98 with SMTP id
 g190-20020a81a9c7000000b00564c5fd6d98mr3718059ywh.10.1684737847732; Sun, 21
 May 2023 23:44:07 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:21 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-15-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 14/23] perf stat: Avoid hybrid PMU list
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

perf_pmu__is_hybrid implicitly uses the hybrid PMU list. Instead
return false if hybrid isn't present, if it is then see if any evsel's
PMUs are core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ede0477d958a..164715113b9e 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -19,7 +19,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include "iostat.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -680,11 +680,14 @@ static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
+	if (!perf_pmu__has_hybrid())
+		return false;
+
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->pmu_name &&
-		    perf_pmu__is_hybrid(evsel->pmu_name)) {
+		struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+		if (pmu->is_core)
 			return true;
-		}
 	}
 
 	return false;
-- 
2.40.1.698.g37aff9b760-goog

