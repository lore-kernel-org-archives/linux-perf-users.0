Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhL3HXS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbhL3HWh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A194C06175F
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g130-20020a255288000000b0060ba07af29eso25855447ybb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=on9cMkVsbDIIWgmJUXNGZPB7xxaMgvNoxu0hM4zjpQ4=;
        b=sQovDeSS1jmqBxyi8qxJA+KJCHl0AO0LQutJiPf1kHryt/x0gH4bjxri2JsVCBPicu
         nRLqgEPUcnDXxQihf5alINa23pgAV3UpQPVPSM9DyzZv7Ul6K1ERcTDvkyY4FGzIfssJ
         LeSLcbVvmAM9/jD4nJeYrtx3SMM2OgZs3GZD7ZabjfJ6EZin/unbSFqWcTNca5Q532wq
         svLlxXJlSCgicDaH4twPedwjgrimmZo6ocAzh0yED6ASiT74eqBTRjgRwuWnBlonGnLG
         jPXmsMiRgsUVaqjuC73QMBbcCgyRBQ7H540aQX16AaHAqwH+SXvLBbqOdKNnu/mMoOPJ
         0t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=on9cMkVsbDIIWgmJUXNGZPB7xxaMgvNoxu0hM4zjpQ4=;
        b=8OEDD7zObusx5KvtQ9xwW8BxFImKWf30+ok3parwygXY5FKWaUBpKPwkisPrxYoumk
         eA1uMbqgBZoOiBT344QVNinT6GmN/aomDWMiB864F/BsR3Zd6m8RYX5zo9io/Xti3CRI
         v8ftDPmN+nC0FklwOTlQXzk6SnruxWwwJCpdykLOL1CU6NPm/000WvRRfZo6j5kqnVQJ
         sFGG7SuPnljq2g/uYk8FJAOLMoQETqPvWhNAfHf9j8qWx8nmkztzFIXpOalIT+wfG3dY
         QJpbpIjrXw+kBkcNwqpOn6up0aWc3GrYkZLZe3aGV4ud9Wf27BHGqWevAoPCv4m6PXwc
         bs/Q==
X-Gm-Message-State: AOAM532yv1QZnfsip9TFoMF7RZiUEmjX2CTL/BQRdMyuwfiFo5uCOwfl
        ab1KiqFdPDLSr2MecssVDBqtD5mL2eMi
X-Google-Smtp-Source: ABdhPJzqq/QW5bQnoe90buoTODwyR2SzuN0kDoT9thVbRJhpcfDXrVUv+7YeJTwa7LJD/r1+V+Jdxh6BSnki
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:3716:: with SMTP id
 e22mr22191982yba.57.1640848956645; Wed, 29 Dec 2021 23:22:36 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:29 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-49-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 47/48] perf stat: Correct first_shadow_cpu to return index
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_stat__update_shadow_stats and perf_stat__print_shadow_stats use a
cpu map index rather than a CPU, but first_shadow_cpu is returning the
wrong value for this. Change first_shadow_cpu to
first_shadow_cpu_map_idx to make things agree.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0f192360b6c6..ba95379efcfb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -327,24 +327,23 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static int first_shadow_cpu(struct perf_stat_config *config,
-			    struct evsel *evsel, const struct aggr_cpu_id *id)
+static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
+				struct evsel *evsel, const struct aggr_cpu_id *id)
 {
-	struct perf_cpu_map *cpus;
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
 	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id->cpu;
+		return perf_cpu_map__idx(cpus, id->cpu);
 
 	if (!config->aggr_get_id)
 		return 0;
 
-	cpus = evsel__cpus(evsel);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
 
 		if (aggr_cpu_id__equal(&cpu_id, id))
-			return cpu;
+			return idx;
 	}
 	return 0;
 }
@@ -503,7 +502,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu(config, counter, &id),
+				first_shadow_cpu_map_idx(config, counter, &id),
 				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
@@ -532,7 +531,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu(config, counter, &id),
+					first_shadow_cpu_map_idx(config, counter, &id),
 					&rt_stat);
 		}
 	}
-- 
2.34.1.448.ga2b2bfdf31-goog

