Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A08C77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjEXWUb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbjEXWTs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8910DA
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561f6e63decso29234397b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966759; x=1687558759;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eS5iHSDHpFh4XdVaHBCbrVny8PCbF73cyIUIzaUWEw=;
        b=NOCz+nx/NdHrPcizU4MdSkA0WBYp0H9Nf+F0NieGY60JSYl6AF2S+CnMb/dlfziqBk
         SNH4dssbJwRHXcvUoZ75cIaneT6FAyO+RD40b3bYt/ivPRlyaUhPjcWffNE4plZNHk7B
         85Pk3dn4eV7+z9VbZe3ftQwYaRLvlEoPyUrJecJI4zZjFdpsXLXrNFLGCCTR8yD47+lw
         1lDf48a8NZvNawqoBz8WAQLdrQLFWRHgitHfKcAoqr17q16mRxGZ8JMqhlJB2UzXb7N8
         oDKXnLY5ppa/bPZUkg0E5pzMtux5QWv/od7FtU+msEMoASarZrFObKcNTb6XkZJNtm8l
         F4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966759; x=1687558759;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eS5iHSDHpFh4XdVaHBCbrVny8PCbF73cyIUIzaUWEw=;
        b=A0c4o1uVnzInYn2KgbXCFgkZ2C5pPZjRWgBcADwrLVjxO9ot+HcPDczcGRixrqWc2g
         iX6pP8jk9CybTqmK7MichBXDLQNjdHBtpih5BCxjfGJzRsGEBk1S2OP1REkx37f+0kbe
         evInHYOOYoQFGgYSyFrVVqh5+lNkwwEzC/xjy55SHcl7RjPlycuoc6e1d2Pb1quxo6Pi
         v6DzUcNj8FZ00J/BN9x8MHQKlLTatYCHx8Amm+h1AWm4EHCYh6BvDKiyQglG5WR4PKDG
         ZaLqMXHNIpqRs1/355t2LDLpeaECm4xlBVI0fD1j4zqBngepOiWR6ZdYDN5eHsvV+iUy
         luLQ==
X-Gm-Message-State: AC+VfDzU5LUCTska+n3H5esz4vepwD08WuKWEnkjN9RkKhpT5T5b3go2
        C6aLq8dfYzykBpQ5eJ+gWPgSyY8uz7hO
X-Google-Smtp-Source: ACHHUZ5rsi2pKjCTlzd+MdEj65Y6PrSrlVw2S+xS+bJJXjv14kZ8uWv5F1wr1NxRMs43HWII98fVEDfi8AHZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:de06:0:b0:55d:955b:360 with SMTP id
 k6-20020a81de06000000b0055d955b0360mr11554971ywj.5.1684966759076; Wed, 24 May
 2023 15:19:19 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:15 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-20-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 19/35] perf topology: Avoid hybrid list for hybrid topology
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

