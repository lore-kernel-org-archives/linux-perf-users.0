Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D4C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Feb 2022 10:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348940AbiBKKeb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:34:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348945AbiBKKe1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F16EB0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a88-20020a25a1e1000000b00615c588ab22so18035512ybi.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zZqjerFyUzn9J1iLxHpLoHFf7aGVnScfvGTlvzc2WOA=;
        b=kZbSx2/JG2RC+HrevtaSHlt+chqBCEgACB3vxiIuRd8ty5sIjcAakIpIdDs2A7fZM7
         fG9q8IRjuhPtWmnte6QNtaoki3X87mjjo51QAsIFmUW9CAJY+zdB0syIWQ4bxTdLbIrH
         W5gyqVXceGN+I7V3c4dgPvu5MGDk6/0gSH3mg5eOZcPJ8BLZHWkwMGGnaLeziiw8ZnGi
         0hPYMmyZv0XhufzooHJC4L7R7ppAIoLfhBdK47TFJs+N1tOoV7m0I+OVQVODEqF5q0k8
         dmyHczuH5c9T3LeGTA4Uh4SlOggn6wf8yXNmuXEGDMM27jEEwuAKMkGyUH63Bp1vjXcM
         5eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zZqjerFyUzn9J1iLxHpLoHFf7aGVnScfvGTlvzc2WOA=;
        b=T9yKWbMNZI3Fr5TqeqDLZbbBZCuNtTItLwAbkQG1mk8N9hXP7TTSJL6MKZnXQ20VhS
         0AObIFKKclzDgKU8GaRWpvYnONT2wh27smIv8u8TTbB3CTgOJ0hBHd/XGNKJOcuXANUX
         tiQOgFLlj9D48FzPTtOfUUIdmMczJIC3JfaVMMcPGu2Lpe8+H1OGVfxArg83895CavqY
         BVzaNk+q8vj5bbYxAmaVZxA04rVG9OwobjpywyOZL5xUVgg6i3L2cneg5uV1v/EIX0ac
         rTBl8Yflu7ec1D29CRW4PRQtJl/nxp+sMThPvPUraCkslZIkciL3lUYOn4XywGHIeG44
         sySw==
X-Gm-Message-State: AOAM530QAMA/ikp0mtOFbhB/glnJYT30Tdj9tUhn2mrzi1BKH3De9btg
        KhYcVQzWqKeifgs0GFNTJQ93bwStRDf7
X-Google-Smtp-Source: ABdhPJzVflHjs1qka6WQPmyROhtJTQf9pViBPc/+f9TWgA1LiYueSSAE/42s1WoomHEliWcXiN2OuPqCw/Mt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a81:a403:: with SMTP id
 b3mr903675ywh.310.1644575665364; Fri, 11 Feb 2022 02:34:25 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:33:55 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-3-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 02/22] perf cpumap: Use for each loop
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Improve readability in perf_pmu__cpus_match by using
perf_cpu_map__for_each_cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8dfbba15aeb8..9a1c7e63e663 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1998,7 +1998,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 {
 	struct perf_cpu_map *pmu_cpus = pmu->cpus;
 	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
-	int matched_nr = 0, unmatched_nr = 0;
+	struct perf_cpu cpu;
+	int i, matched_nr = 0, unmatched_nr = 0;
 
 	matched_cpus = perf_cpu_map__default_new();
 	if (!matched_cpus)
@@ -2010,14 +2011,11 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 		return -1;
 	}
 
-	for (int i = 0; i < cpus->nr; i++) {
-		int cpu;
-
-		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
-		if (cpu == -1)
-			unmatched_cpus->map[unmatched_nr++] = cpus->map[i];
+	perf_cpu_map__for_each_cpu(cpu, i, cpus) {
+		if (!perf_cpu_map__has(pmu_cpus, cpu))
+			unmatched_cpus->map[unmatched_nr++] = cpu;
 		else
-			matched_cpus->map[matched_nr++] = cpus->map[i];
+			matched_cpus->map[matched_nr++] = cpu;
 	}
 
 	unmatched_cpus->nr = unmatched_nr;
-- 
2.35.1.265.g69c8d7142f-goog

