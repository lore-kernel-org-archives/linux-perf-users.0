Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3120BC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbhLWHs1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbhLWHrq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5454C061375
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso8697504ybl.7
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5tVJzNTPrT5Mz019UGpMqh4/y+iJ54XVPfgHv8yLcW0=;
        b=TQyU/YpVCjIz2BUqO2jBW/aSe8SJJ8OhQe20TBnnnPqLK1vyy6hwJqBFl3KfwmlYdF
         kD8Yp3uDQNG55m7ttdUsfgTh8YBvFgmISS0eQOzVZuCs3MCyQ6FwIRN2GEJMsnZO2+y/
         B/6sX6cO+5HDmbyv5nFF1nn+IJEXKPnTy5G3fNKJP3peVoN+dU3OdYCVo3LEKCM/adaI
         mKYh9jZwDzP1lcdT/R6LTuzVqw4QwPsQ23imyiDTX7JWhGl1ckosjrz5t61r7O31brcT
         TLM1yiQYq2u+SX3cObKOaTaHRcVmysUTAIWeZUSOT86CUn8i4H+kDPOgudioV70LLyPu
         HyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5tVJzNTPrT5Mz019UGpMqh4/y+iJ54XVPfgHv8yLcW0=;
        b=bcvraayuP4HLWF+P2aEw3pn2YoJncAeaBLzIgnkknHm/uJzylpbBJrLOG1sYcHz+gB
         j5Y5Aad0wt+HZj7N8R9e0rALtJoo2MhDqy0exPw+DTMTUf6QjetpXb62GpJkMZcaxJZZ
         gUN2I4PIPa/3o4RIrUdcooLcFOFdIPfCXOUz6sQA98tEIbuDC9WrtQyAzlwRrEPU1p3X
         aPLojyuU7RBkzxxk/xeb+X++wkeOMC3+IlfVadl8OaozMCVlgBCcgEClB6bLJShUPSA8
         Xy9zpl3NjHhVun4EJM2F+XyePxNFFDJA/Nvul50Gq/nMA08P4B5h61DUbuOyiMHIue04
         UUzA==
X-Gm-Message-State: AOAM533kwPZ7NKiBYVay1l6fXTC4qCS7+ixDRMOShMnElhGqqaaHPT1k
        tWC9Wcv3q/jubJrIdBAFuj5oRLsJeLwN
X-Google-Smtp-Source: ABdhPJyftWeLHeEAE1+KjGOdTuxDKZVxQ6Lm+rFn/DSubwAQ+QTEgxV94xTRIHGTQT/w4ZG4G93EWVCQd/mW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:504d:: with SMTP id
 e74mr1602226ybb.685.1640245647040; Wed, 22 Dec 2021 23:47:27 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:24 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-32-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 31/48] perf stat: Use perf_cpu_map__for_each_cpu
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Correct in print_counter where an index was being used as a cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4f93591aaa76..9be74e907352 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -4,6 +4,7 @@
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <math.h>
+#include <perf/cpumap.h>
 #include "color.h"
 #include "counts.h"
 #include "evlist.h"
@@ -732,7 +733,7 @@ static void print_aggr(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, s,
 					       prefix, metric_only,
-					       &first, -1);
+					       &first, /*cpu=*/-1);
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -893,11 +894,11 @@ static void print_counter(struct perf_stat_config *config,
 	FILE *output = config->output;
 	u64 ena, run, val;
 	double uval;
-	int cpu;
+	int idx, cpu;
 	struct aggr_cpu_id id;
 
-	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-		struct aggr_data ad = { .cpu_map_idx = cpu };
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
+		struct aggr_data ad = { .cpu_map_idx = idx };
 
 		if (!collect_data(config, counter, counter_cb, &ad))
 			return;
@@ -921,10 +922,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 char *prefix)
 {
-	int cpu, nrcpus;
+	int all_idx, cpu;
 
-	nrcpus = evlist->core.cpus->nr;
-	for (cpu = 0; cpu < nrcpus; cpu++) {
+	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.cpus) {
 		struct evsel *counter;
 		bool first = true;
 
@@ -1249,7 +1249,7 @@ static void print_percore(struct perf_stat_config *config,
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, metric_only,
-				       &first, -1);
+				       &first, /*cpu=*/-1);
 	}
 
 	if (metric_only)
-- 
2.34.1.307.g9b7440fafd-goog

