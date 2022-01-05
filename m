Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C501C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiAEGRV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbiAEGQO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A739C0698E1
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u130-20020a254788000000b0060a9645f781so58771992yba.19
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=on9cMkVsbDIIWgmJUXNGZPB7xxaMgvNoxu0hM4zjpQ4=;
        b=cCPa+SHUCrMw8an8q45ZtRv/i64BmCmjROSrKJPgOM2PlHDZB4+gvUCwJ1zG+hj8fU
         IGxUB7AKkBFoSB9Iq/g5ay3aE4WzGhPsoWQn26bxpPYxsG8MFY2yG2H0Rn0JwycHgoMM
         f+Yu6rhevihqhazqUEML2fUjYVtCw0GRBAa/Jtuvu0haKFsRyHQdnq20hXmax0lUfN60
         JyS6G7j64n3+q1DAcdkOdPw35XZCVVJPVoX9dWmjAdM8FDDYcFwCJkF/wmuJcE/8OOhS
         kcXb95CGgvWhzwN9Gjyj2OWN1UkZrO3kbC7uP7QgfmWOpEpSNx7iFR3WtmpOfoWT+vc6
         4bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=on9cMkVsbDIIWgmJUXNGZPB7xxaMgvNoxu0hM4zjpQ4=;
        b=ZRncpPdr+jJuv3NOaAke2uHjelIqeAZ2Wk/enNcBg7cMPFuUV5EVMA4MoZCngTn76U
         SR6dxZr8Ic9Q7B0S0Li0y/3OuzzMajc48ZJ4nPzzatFSuTQwf1Z82toY52JH6zQw02dx
         XfxfWFfeNSXpr6zFHcoSvd1FStj78kM61TttMS2XAYWc4ZmijiorC2OiDN4dnphfGKbh
         KLFXZQrXRvPY8Z3slk+xbbI+t+PKr94r4WuuBtFETDhgPJqF4yJXa5aFHMHPAzjLyHde
         EsOVnG0tmg/+5379qAdHiT1u4guE0pZcJq37wN8G3tQ37/GJch4YEB6u8nIbazBlLQYv
         QoZg==
X-Gm-Message-State: AOAM533Iy8Q2yv2IrfmFM5Hxp5m4DBk610ZMrBDE4uuVlXrvjswcALba
        J7SiOBDhOVkvyS5qVU7Z59kep2kw/qb2
X-Google-Smtp-Source: ABdhPJyMIB+6RXZ4fgulTItYs0MJRIuoDNybHTF5irVS16tYmpzKDDP+9Nut1QNjJ9zINgchGiHA954cHJ4D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:9b45:: with SMTP id
 u5mr24170194ybo.76.1641363354738; Tue, 04 Jan 2022 22:15:54 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:50 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-48-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 47/48] perf stat: Correct first_shadow_cpu to return index
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

