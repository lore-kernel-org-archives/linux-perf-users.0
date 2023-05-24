Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF60C77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjEXWVY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjEXWVD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:21:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11041E4C
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:20:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eadd916fso29867437b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966777; x=1687558777;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/uSoOkKrLV2P01KOT7/05nAwNtg1NZmOZIVSrGqD1k=;
        b=AnKvdlUdQjQEEAq6HeZq7zmB6gXv01G0cNNgNxVh13Iy+L8MK0uM/sSyX8zOpVJzzj
         LtvtAjrsF6ZUkNcumXtEBBqhAtaTXivZg5uh9HUG3ggoCvT1KBDP5u6fGhM2uPhybH+0
         IRPtuFglOvFjuOWq6/CbvzlITCjdA4TyXBPz19kXSoq7VcI4CYMwdBQxFdBnjnbjoL6P
         LxSPLWqi5o7mHIUqLRxbYbRi/kTwfvbWyjhyeaTnIYhge/LAYfV6+KLEKMuPY3zpQM0A
         43v2qjCsMWYwXQDEQ08GdcQRHh9y9JvpJizhR5eGNt/mVktDaKoGL7OMDri5nQHfF3mJ
         WXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966777; x=1687558777;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/uSoOkKrLV2P01KOT7/05nAwNtg1NZmOZIVSrGqD1k=;
        b=SgPGvAUmesRNskqKPBvR5bD/nojk7rMA3WSvUvjLf/NVMOWvzz4HPUJ2DhpXXn9G7p
         gmo0yKpkjJ9jBfHvLMEtvQlyabAo/8gQULYTmcKJFqZ1kULcUdpNSUm/pfeqKRk94Y7o
         qCbKYq0yL+8OhfRFES+YIS8TV0dgCa5v1kKM3EDQwWmZcJVQTH93MWVSw3FykvSM5G/T
         wXk6+9AjHWFlrpnacywBsRR/cxMcuhb8RiAk+XTt4z9WvonBaPCeue5mJMu9dW10ZNgw
         +V9TrTuZ4C/xoN76gYK9xrxxaDSxo03cjPqnjGv8agntc3gd8y/9FQRmTd2othgQ423U
         ME5g==
X-Gm-Message-State: AC+VfDwo3PrCIcjgKu5FOd0bl8Jc8pznyJZuqO6++ibaO3X1f7ZjyYBZ
        YIuTzfFJo4trWE7sqM5FDaBncTM9Z+Ky
X-Google-Smtp-Source: ACHHUZ7sEtK0LR8WwQQK9cpyIqNh6Pc7ybEP8C6sxaWdG4+eXpOeGFVug3xou45ngKes3xW1FpxdzJYoO/4m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:441b:0:b0:55d:9484:f153 with SMTP id
 r27-20020a81441b000000b0055d9484f153mr11963093ywa.7.1684966777192; Wed, 24
 May 2023 15:19:37 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:23 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-28-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 27/35] perf x86 mem: minor refactor to is_mem_loads_aux_event
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

