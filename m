Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864EC7EE26
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjEVGqf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjEVGps (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:45:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF51BC
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed50a6so13502245276.0
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737858; x=1687329858;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/uSoOkKrLV2P01KOT7/05nAwNtg1NZmOZIVSrGqD1k=;
        b=Hsaqh04sZH/6Axr8ud/gVY1mROhs8Rgqfgn3Y6WJCmxYCSI7DaGYNAhEuMcZgVnSI4
         IQR6K++KxTf6MIelXu6H8ZQLGME/L+HPhjveHZLKnPA191Tl+09GgrGKkqPWt8TmlvHo
         jeVR+5yWMZzereK4/fMT3bLb2G8m7w8726xoO/zepx/JtlKitnPX+61eYsxkuUrnRVU6
         wSJN3wccgS72kCUEAtjLu4A8Oa23qTc8IiMin5sw1NImbyJAqwPLcuLN2veTrRx4MDwF
         l16tIVZoj/7USrIbJVfBWqY6dDVnkVbZgvW1X/t4ZlhijkBPzzOBVdpYx+gGvPGIzrZ2
         j4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737858; x=1687329858;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/uSoOkKrLV2P01KOT7/05nAwNtg1NZmOZIVSrGqD1k=;
        b=gYbbL/QOYaAuwZz62ZCvEPY7zGm3XqCVqMQq3UoN+RHhb6B0IwZXFXnAo+br9awy8S
         2Hw9z+zdswQHDZkUSCEDPPzr9f2fsfp87hKmWhzICH6ekYO1Su7o/o/sHK9HrUoAW6JL
         PKFTMavqoWaaPhN42KCZFwAhmT1rqbXYFbJ8XiBQmYUisGnr0QhyWMvc0cZplYrdxXI5
         rilOSp6xncuhmV76bXAs0LkirGfhGQzxizFHO7RsQfZPNZZewwFPWHAY3DAEqp0bul2t
         fdumNEpCav7DRgp57szGVbtpy/sjwrJTYYzEmjVSWR521btlsLYgkoCru9JwEpz+IPU7
         GMtA==
X-Gm-Message-State: AC+VfDxalAPU7ZvjHki728VfDzWQROTiAK53Sz9ZxIst1vu6cjS0KGBd
        k7WgGkn84/Jxbr6sycq6wmxw1vlpU2wI
X-Google-Smtp-Source: ACHHUZ4uNM8OVXJ/aKWdYng9uyMorPPzwcRVbMIZHNe3K1lLGLszwH0/SAAzHzeBkaQpq1TeMKuVgHtITpHE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a25:689:0:b0:ba8:3401:a466 with SMTP id
 131-20020a250689000000b00ba83401a466mr3789212ybg.6.1684737858138; Sun, 21 May
 2023 23:44:18 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:25 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-19-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 18/23] perf x86 mem: minor refactor to is_mem_loads_aux_event
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

Find the PMU and then the event off of it.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/mem-events.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index f683ac702247..02d65e446f46 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -55,13 +55,13 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
 
 bool is_mem_loads_aux_event(struct evsel *leader)
 {
-	if (perf_pmu__find("cpu")) {
-		if (!pmu_have_event("cpu", "mem-loads-aux"))
-			return false;
-	} else if (perf_pmu__find("cpu_core")) {
-		if (!pmu_have_event("cpu_core", "mem-loads-aux"))
-			return false;
-	}
+	struct perf_pmu *pmu = perf_pmu__find("cpu");
+
+	if (!pmu)
+		pmu = perf_pmu__find("cpu_core");
+
+	if (pmu && !pmu_have_event(pmu->name, "mem-loads-aux"))
+		return false;
 
 	return leader->core.attr.config == MEM_LOADS_AUX;
 }
-- 
2.40.1.698.g37aff9b760-goog

