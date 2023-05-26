Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728BDC77B73
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbjEZV4l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbjEZV4I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:56:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE6189
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5657f376d8dso30411627b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138115; x=1687730115;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6J3cKUGVc8jbchvN9nhXCNUg1ciZv4CLd2svHk2zTKw=;
        b=0X2D2xRpKNyCid4P4x9RXrBU+RCykPnm8OQdKJb/p+h88BXPtIdg0V1cIUJPoL8Bon
         XE7+Ilxkyiwu+dG6j2vD3qx7i+aF/lOf9Tm8p6zFRlQ9gA9Uoq5cklXR42MSRw42u9rg
         iuOU73vk6hnV/3n5sUxVvoJTikWYj04nNJBPjjO76WvLHolSdnlXcvRGgqfi1U6dzbb1
         3PhALv4QQYg8MimZHnZL2T1iYGv+5Wby/hbaszTs8iq6kSgFS+L4tSM/Yuis6HPYjKb4
         0eNHrVCAZghSMW4StovwWK715oWI2TXcbrF//ywS8Kr6XYtK+HuyvG622KLor4E//e/X
         k6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138115; x=1687730115;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J3cKUGVc8jbchvN9nhXCNUg1ciZv4CLd2svHk2zTKw=;
        b=dlBVAGuhgQbxm2ToBVHZ1cbMSuhByeQKOzEdxZxq8OFm8CMLroSkeEYlpkfCAgFlkT
         KL7ub8RGQAufd9WQbMxN+J/RiyP+MCXz0JRcwH8Nkr0AD3nR6HhaedpO+i/0+9vnSjQU
         1BggiUM6VWnRbk0D3kxdRHIZEW4+h4z3biKna4oitZGlPmqiFwjlBSaI8b9nu2fq9eWQ
         81l7GqJNYCKcBfpiBEKzqj79xPfEVxcCfU9Zq5DI33/Z8v+RKcrbE3dsFEKIFH9hKUdI
         3pezna/68MA9NHNFv0GN1fry+/KFhLjkp1d65QqbZROKqibWvTW7qKNz5TV9isFfX0oK
         XK3w==
X-Gm-Message-State: AC+VfDzD5nnJIAqt/D5JFmkdAFe30bPmIaA/4k1hgV8KAfm/NrcmDXQv
        rTF6/FlBGI8CzlmWj8yY899TRKfWXEQT
X-Google-Smtp-Source: ACHHUZ5fh+g0oWPOYU4V3fSHO16qS0KDLFwGEPTlYVs6dT6fSSrv1wCW/h7+SM/BMmcHAg03PYVCPvRnq/uv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ed0a:0:b0:565:bf4b:de20 with SMTP id
 k10-20020a81ed0a000000b00565bf4bde20mr1243298ywm.2.1685138114815; Fri, 26 May
 2023 14:55:14 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:02 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-28-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 27/35] perf x86 mem: minor refactor to is_mem_loads_aux_event
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

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
2.41.0.rc0.172.g3f132b7071-goog

