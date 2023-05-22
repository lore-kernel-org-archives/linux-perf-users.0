Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DBFC77B75
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjEVGpT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjEVGoX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:44:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602FE6D
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:43:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8338f2103so10521414276.1
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737838; x=1687329838;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eS5iHSDHpFh4XdVaHBCbrVny8PCbF73cyIUIzaUWEw=;
        b=CgHDDcC/bqqMU21nt7St6njPl7Rn53Y47s5fIwnhxiq0CxfpVDxjt0xXLXOSODasdE
         Tk92JdTJATwtUezQWA6Z3gAwX+/ec7MKOKi800MmW7EPwUD5McVn2WEkSU4FYIwhjsio
         bw2hdH9lbS+rBKpwWxSbj+5Q73Lr8QN+jiM9/Oe9R90fCdPuAH7vTos2YCQ3N+S79Eu0
         BA+PakRJh0qnm3y+jvU9D/MpI1oRvkom0oF/O6tCx18sSb18tnGsaRyfw1RCfP4TVMxv
         JNQ8+aMDPkUf8byLtKJtCqK+oHpyDMG9NStLm93IyJNFOzz5AQdPIM4QueYCtzvzDvMS
         qzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737838; x=1687329838;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eS5iHSDHpFh4XdVaHBCbrVny8PCbF73cyIUIzaUWEw=;
        b=ZPXeIUa1OLRIhnB+e/aFNJRPQlbpSKwuev+NH/QwD9vaLMhBlODJKUg4cSfH58BhGx
         TQIWieUZT/WWnwkG7k/nxseHmUuWo4C/zdD0hbkl8MpM8bdq9Kvt6OXixKuHLyfhNsYe
         mIhUnz2QXDCx3SqFXc6xsrm6X/71PKR4Bpgtc5RQFwLXbs5iyLSEr3yslZIo9SrPhcZN
         53FkbwGtn9ODyikBW5+DvQew4l7Q3kZrfCl3lM0VRG/lRkl0lcXoWEAg30hBk3bmZFiB
         C/sWmcRyXkqD1GqJ+CVvgbBIciNrZevrUVsrj3MDHh/AEwRBhIUXy9DhRj5EjFcV2Wy8
         ha+w==
X-Gm-Message-State: AC+VfDx4Q0jfr9JOhzPn0A4tjXH97QhVoBummqKFxYAm73Yaj+jtfFt8
        /EV9yKLayx5ofltu2al3OXzPszbmbV4t
X-Google-Smtp-Source: ACHHUZ4CGsfKcHUrmkLQzmUyhJN0XIWwtaPsa/Q19mBM+K+hLEXsAmiFVhHxp8qWU/VEY2xhQQxccmo/4t6P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a25:ac20:0:b0:ba8:91c0:3c50 with SMTP id
 w32-20020a25ac20000000b00ba891c03c50mr4043339ybi.7.1684737838276; Sun, 21 May
 2023 23:43:58 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:17 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-11-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 10/23] perf topology: Avoid hybrid list for hybrid topology
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
2.40.1.698.g37aff9b760-goog

