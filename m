Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD242C77B7C
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjE0HYf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjE0HYO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:24:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2A319C
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:45 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2553b096ddfso1864582a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172195; x=1687764195;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csOWTo951DO4baytRGvCV+AGtywhGll+tnrLNxjPQY0=;
        b=C38tR/1RFw0fe/o2q2Trv6vb+/sMetouZoKl5RczGdJM3c1q+o0U0BjC1i4bjBEKJp
         1kl1gmNWPAOBXqn6I0TNfCIMKwnjrZjs6cPn2QyuUn6JbfCpZJHcH0qvK7k3zgqebmNa
         wyeJAAUdvWDt6l+i/HTcTREnsvQceX9qf1SsL2sxNY+gSImIlHhCgsEpESOZnCTkY61J
         Kx3LgdBvGB3Zx04lgA0PGpIJlbuaQl7NM0vBAz6mKL34dgisX3IhdnRHMAx9l/Xha2SM
         +6PGm+rdGLE82h4UgqVT8Ec2sxJnVJt8KcC16c8KEPDj6YAwyJP8SL++upz8V9gOB8Hi
         aGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172195; x=1687764195;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csOWTo951DO4baytRGvCV+AGtywhGll+tnrLNxjPQY0=;
        b=akCOlNLucFToKWB3vM6sRqjW5yMcWI/uzWdhaByvkXVRtgJWuEI7vdXpCcK1hJtTxQ
         y5lB7OSkq/QmQRArB5VlWkCw4sJDoImNKRiYSrd4aWPuq9wJ9Wwy/utoXLNr+2+hQ+Z9
         6vvJ6IXmb0Yxt1GGfA43u+I23hPBET5dG/vzjoopv+/DGZ2AVdrN7tH7Xam6X45iEe0Z
         udj9TcgS/D3WP03OUuGj2+o/+z/lUbyLtHSq46MkgF0QkwDPCah4MyKEleUcPmYvWkPm
         o1heHMrAjQLaXArxYijs6CiAuEghtN7cGadmDD6ruHOzxUg5BGh2NJ8DMBWuaIqZ94cZ
         /2xA==
X-Gm-Message-State: AC+VfDz72qi2jj7/Oi0dAR29+daDNoK9KOLWUIHDmKbuyXLkZS3sn731
        wWsFsixM4R8c11eVm8VxV5aSIYyFKUPL
X-Google-Smtp-Source: ACHHUZ59aNA295e+X2wN34vRuIkRjmQcb7D1ba3SouitqOJ7T+jMAKDbBahYAHewEIQxxz1Zy9wxB9qyvPAj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:90a:5782:b0:253:4800:438b with SMTP id
 g2-20020a17090a578200b002534800438bmr249539pji.2.1685172195498; Sat, 27 May
 2023 00:23:15 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:54 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-19-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 18/34] perf topology: Avoid hybrid list for hybrid topology
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
2.41.0.rc0.172.g3f132b7071-goog

