Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20EC7EE23
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjEQPAI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjEQO7f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 10:59:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED4A9EEF
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:59:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba81b24b878so1649481276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335540; x=1686927540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85QXUmSzYQ7qJQE/KiBLPaTz0+VTd9+u5qwdQ9BqgEo=;
        b=IDUYTrDoXWwrrq3ucsv9m2Fp7hhTBFvwQiCG5BJ4RBTtjwcMSozRUM0FMQo2LCDSGs
         jX8yJaNCn8744PL6du8vEg4nx2zTGnfTpV5GxP6lOeFZHzZ/Y0UN1hT4042AGNJJsLxn
         /dN/jQDoQIWA+J4HcrtKyTce6f2gaT97DB52DEsAvuE3okght275WgiwR5hayl3HouRn
         cDjWShFZpT/50RrG2A3z4VKMKdfxW/8qwmMT67UheTsK9/5YPwhfVpljzupyA30d7b1P
         3tdlZ1BhlND5x7kpyLiQp4KwVjewMdh1I/l5GZ6ocAbhrutJ2I7eBw5PM0OAif+P4lgn
         7j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335540; x=1686927540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85QXUmSzYQ7qJQE/KiBLPaTz0+VTd9+u5qwdQ9BqgEo=;
        b=NgtrLgewYCvdE5IbSIc5rMgyP7Dzpj4NHp2n05D0GicLk8m8Tb/eW8Ok2t6IB1ch5o
         +xZk2dmhAFrF4gHdQYnAydg89oIBV4nWrPDwKPbrjbSsDcRieHJuKmxhU6Kqj7Zj7JyT
         ftk5Sp4MWkj55z6vDfCQVSNyOXRwnLm2Vw2kq7Xxl4f9FokM+4s/pVKiJHiU60xNT+/a
         C6RLQftDEv4tjSykVMOs6kahPmmT0rTVD0dzaqc6r719KeZmX0zljVv4v/w7JRU9pugT
         HSNANDuoRgSY1kETZX6BGe02ZkyhXgcQmN7sk0kVjn14EMfhtEolSyEx2kQUSsN+aOBF
         zNbw==
X-Gm-Message-State: AC+VfDw7HASUpAun4sHOFr2Ya6fEkXI/i2V8rQVAx029e1HGfUfjNLrw
        Y8EJE1x5aUIvPD49kYeXOZC8CbAZt0Te
X-Google-Smtp-Source: ACHHUZ5TwAkgVf6TwpeVN+nOLXdN7MV3y92amRDRD3tVQXRLC8B4atOH6VvndgKA2K+z5KD779f+YtHAi0Et
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:db07:0:b0:ba7:7478:195f with SMTP id
 g7-20020a25db07000000b00ba77478195fmr6028279ybf.13.1684335540478; Wed, 17 May
 2023 07:59:00 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:51 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-12-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 11/23] perf evsel: Compute is_hybrid from PMU being core
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

Short-cut when has_hybrid is false, otherwise return if the evsel's
PMU is core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b39615124672..2c0ed7d25466 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -46,8 +46,8 @@
 #include "memswap.h"
 #include "util.h"
 #include "util/hashmap.h"
-#include "pmu-hybrid.h"
 #include "off_cpu.h"
+#include "pmu.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include "util/bpf-filter.h"
@@ -3133,7 +3133,13 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+	struct perf_pmu *pmu;
+
+	if (!perf_pmu__has_hybrid())
+		return false;
+
+	pmu = evsel__find_pmu(evsel);
+	return pmu->is_core;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
-- 
2.40.1.606.ga4b1b128d6-goog

