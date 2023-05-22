Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D460C7EE26
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjEVGpT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjEVGo3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:44:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18CE76
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561deb0b6efso101638727b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737841; x=1687329841;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIGkjMa1wc+2YqtFlHRehMAQM+xcg0ilJ/4qFtAGVUY=;
        b=giCC+5/4EUcXQRjSQC89cXvki8U/QoJ9QC39UFUvlE9YhMX8kXt+mGCgtOVL2fwtXj
         9RRXs0XsNodd8TFub2bKATVyzVjUmQlK1P0rhHHp9wE9dfKGXVKfCAURZsNDk7WxcP2D
         h835LQNtW3Wd2tuIudgPGE8KyNR2JwIotugDRzykL7GBLizoZIaz68fYsOGB9C8T8DI+
         jc0l/pmDf9LnEOzNcFcYNFZ/XzEU7ymU25rBjR5MV69SzbT7VmAi3dtlFxAhCZv60fcq
         gIoVZ/moxoftYgJuPbyGRDIm/09CXqJaVW7KiOsI4rnR824BsuEbwA4eCd0bOg17T/YW
         WTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737841; x=1687329841;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIGkjMa1wc+2YqtFlHRehMAQM+xcg0ilJ/4qFtAGVUY=;
        b=QegiHNGRy4QQAML2pI4T5NgJmZlwQP7/leE0DAESaV0+XIWaXFttlHAoMirQaiKjKP
         9tUpAiLfwqshO91nejYdzTQWfzVIAn9Ndpt/B6ep1G0eR2p7KGEffOu24cqPmvYtsknF
         g04HI4laYWiTqos0Gh7TqWyH3LpsLym9WV/5tAVhNUrwrV/l0t4S4ydVV5r9TGTEL/Ko
         CWZMWAcG3xhdow0YG01cOdc1yUjs8dQ+S8iJWFTHfXYuQ/EVmTjRDpKjpQlCmch7QNg5
         mroURWhieQN1H4VJygfbSDtbV1akaCViPJrjPw4UbmZkW2reUZ31TRde9MtBo/lauMXa
         wT4g==
X-Gm-Message-State: AC+VfDxLuIWHSAFbm493eOoveBQXaaUTFErlfj0vPWr7x166T3sZKHuh
        MlBhZkIr7RXx8ViCuyuyC4je+jaZB4yi
X-Google-Smtp-Source: ACHHUZ4nAbzyYcfkbGak1Sz9NF7WumnGusg226YGZEcoPxxDT3NS3cnRH1HvigWM5JuF2sxAF410WFubqFPH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a81:b54f:0:b0:561:1d3b:af3f with SMTP id
 c15-20020a81b54f000000b005611d3baf3fmr6010864ywk.8.1684737840821; Sun, 21 May
 2023 23:44:00 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:18 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-12-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 11/23] perf evsel: Compute is_hybrid from PMU being core
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
2.40.1.698.g37aff9b760-goog

