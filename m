Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9AC77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjEXWT5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbjEXWTa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FA1B4
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso2008749276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966745; x=1687558745;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sOBUMwNNCEoqzsDPVQsAi+V2ZTdHisiz6s6WUsWey4=;
        b=IUAL4nxf95HA/L6zeo7fXaZVJqZqwpz32+FkVl/s9ls/CHo3bOYqB/L4VNQ8e0/tUI
         s/29FyrZuJObJpQFmg96C3gGsMHuU6411j3fVUS2xrGr/0gHOBNNWDEQyAexq6HUEqMD
         8JitU105N/s59aUBBQ9V5qt8KX3GVE+p++6feXSvRCwe/q0vHphsyE58EcrEnLu4HWb0
         A8etjsub1iBPBDbM9dVL8eUI12U6cnC+J1R5qzcJZFkHQ/eUFH+i6G0yJ4gxwQMqUI1l
         I5OAFfgR3qPN/ZMiLH8iPJ2VIEd1Savg2SLL0gy9mFGoQA2dW+gIcEsyzPQN9yUzcBZI
         M5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966745; x=1687558745;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sOBUMwNNCEoqzsDPVQsAi+V2ZTdHisiz6s6WUsWey4=;
        b=dNnuyaN6tsJJhc58QkzPmz4gyLR02P2GRZe2aPmTCK1FxfY7iGiz89G9SZ4xMlQhGx
         7uSE4Erad55ESYmAD2aPIs8ICveNothtD1LLU22FEDSbxhEyap/qs/uHtwFr+JsCg85f
         9YwCUgtRG3piPIS4J760TCnY1uxXCQKZQWgtFSLOdd2ShEXJFQVT2EcuthlOcBTd3xh/
         Aup226nN+5+AxpTUYvUa7cjz6GYP1WN9dhGdNOj8u1ZeXLcTLdDJffz5pzz0+7okTcQS
         uCJBom9ht1uO9zXTxAUWryzczSUw/htkAK2KSgpX3pa1vNCbP8Xa0S0m02UhjHg6w0OB
         2yfg==
X-Gm-Message-State: AC+VfDwiMbFF/AHITe0nDEiSfTDmNPnO7mCFpdwxfNjwNwoT/tYFA205
        Q6vwYkNrQ+24Lkju+T60gIJAme45K7it
X-Google-Smtp-Source: ACHHUZ7/3ZvdsVAhmVmEq3HnZSBR2aiwjKzN8YLQjODHD8I+5EewidQMppMVSUcAfCNg4IiAWIB90XU5luau
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:e786:0:b0:ba8:93c3:393b with SMTP id
 e128-20020a25e786000000b00ba893c3393bmr781880ybh.2.1684966745054; Wed, 24 May
 2023 15:19:05 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:09 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-14-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 13/35] perf evlist: Remove evlist__warn_hybrid_group
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

Parse events now corrects PMU groups in
parse_events__sort_events_and_fix_groups and so this warning is no
longer possible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c       |  3 ---
 tools/perf/util/evlist-hybrid.c | 32 --------------------------------
 tools/perf/util/evlist-hybrid.h |  1 -
 3 files changed, 36 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 04c9289e6ceb..cc4d96de1851 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -187,9 +187,6 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 {
 	struct evsel *evsel, *warned_leader = NULL;
 
-	if (evlist__has_hybrid(evlist))
-		evlist__warn_hybrid_group(evlist);
-
 	evlist__for_each_entry(evlist, evsel) {
 		struct evsel *leader = evsel__leader(evsel);
 
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index db3f5fbdebe1..0f59c80f27b2 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -41,38 +41,6 @@ int evlist__add_default_hybrid(struct evlist *evlist, bool precise)
 	return 0;
 }
 
-static bool group_hybrid_conflict(struct evsel *leader)
-{
-	struct evsel *pos, *prev = NULL;
-
-	for_each_group_evsel(pos, leader) {
-		if (!evsel__is_hybrid(pos))
-			continue;
-
-		if (prev && strcmp(prev->pmu_name, pos->pmu_name))
-			return true;
-
-		prev = pos;
-	}
-
-	return false;
-}
-
-void evlist__warn_hybrid_group(struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_group_leader(evsel) &&
-		    evsel->core.nr_members > 1 &&
-		    group_hybrid_conflict(evsel)) {
-			pr_warning("WARNING: events in group from "
-				   "different hybrid PMUs!\n");
-			return;
-		}
-	}
-}
-
 bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
index 19f74b4c340a..4b000eda6626 100644
--- a/tools/perf/util/evlist-hybrid.h
+++ b/tools/perf/util/evlist-hybrid.h
@@ -8,7 +8,6 @@
 #include <unistd.h>
 
 int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
-void evlist__warn_hybrid_group(struct evlist *evlist);
 bool evlist__has_hybrid(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_HYBRID_H */
-- 
2.40.1.698.g37aff9b760-goog

