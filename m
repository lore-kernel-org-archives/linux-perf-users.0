Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51321C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbhLHCuR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbhLHCuM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADBDC0617A2
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso2091431ybi.12
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6bfD8x34jOu5STn3NXUaEPwFcmbhjjhBehQ2X1HJoSA=;
        b=rQtaP4gi3e6Dv+wHxnW8Hgdduk/1xXb7TlZkEDWLQU6EAUYl08n++hRg89Ovq63ONT
         mYqRtJRMavmHhnx3zlA1cDy164MkoDmSSixfW3EeA5ScfXYWikRwN8iKFBU3Z5AsGFni
         hK8dlWt5KIzzNzpQPJs9KNVKhRyybHDZuooM+o3rFpRuaoT9dpJ3emvpSzd9Og4BBfKT
         PEJnQhK/yL6c/cycO49EP/CkE6HlxFUv7eH1gsCGcup9K6Yfks0uhP9LPM3BYz/USEfx
         jCQQMwaQZtvBgoTxIO5PjL5lKwPufkah1sto6YzBIpnA3SIQIDospFLJPI5vqt3JrwFs
         OkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6bfD8x34jOu5STn3NXUaEPwFcmbhjjhBehQ2X1HJoSA=;
        b=RKDssWDQUH2cs7609WbnX9GlDNHeozlKypvALzdHr1K+ut0zpFMZuQpgb9UvK+LCV6
         nrt6G1EpfUHngiKLaYLBG14vgcfc4UkYYXorX2QOT/6FesnpI0bhm138HGkHpIxqS4u6
         MhrJ0Wc5ymFqRlX76lo00zGf0MV/4QT+NCHNhFAk4hubpluYo7Jj174SLpzOlBc1yHue
         K7csx1qWNJkcivkTPrNp7Xc1MHBSXhLrGEUBezCtaruleXtdoAGGht0y9ENNJ8hJMfex
         7/8bwPGGxEe47Tdy8p7/SqF2Kk7WBouJC4Xt1+3GisuiwJR2Mr7QQlLCOv/VcpbL1yq3
         jRog==
X-Gm-Message-State: AOAM531q/dgmKw6VNvnW/bIdVtRYyK60tlX9PgVupaOjNCI3qBp5mGj+
        ctMhZgF2uwv+99ACi4KHegfOoVr8zYvQ
X-Google-Smtp-Source: ABdhPJyMeejuWR0xQam+GCeLps0asjGdcIzjS1hCgvwzi902/LzP/O0V2yVxVPtp2jnDcuFovXeB/7xTRFRV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:d9c9:: with SMTP id
 q192mr56088806ybg.550.1638931600938; Tue, 07 Dec 2021 18:46:40 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:57 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-13-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 12/22] perf cpumap: Simplify equal function name.
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

Rename cpu_map__compare_aggr_cpu_id to aggr_cpu_id__equal, the cpu_map
part of the name is misleading. Equal better describes the function than
compare.
Switch to const pointer rather than value as struct given the number of
variables in aggr_cpu_id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c       | 14 +++++++-------
 tools/perf/util/cpumap.h       |  2 +-
 tools/perf/util/stat-display.c | 18 ++++++++++--------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index f67b2e7aac13..8fa00a6221c8 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -171,7 +171,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	for (cpu = 0; cpu < nr; cpu++) {
 		s1 = f(cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
-			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
+			if (aggr_cpu_id__equal(&s1, &c->map[s2]))
 				break;
 		}
 		if (s2 == c->nr) {
@@ -593,13 +593,13 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 	return online;
 }
 
-bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
+bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b)
 {
-	return a.thread == b.thread &&
-		a.node == b.node &&
-		a.socket == b.socket &&
-		a.die == b.die &&
-		a.core == b.core;
+	return a->thread == b->thread &&
+		a->node == b->node &&
+		a->socket == b->socket &&
+		a->die == b->die &&
+		a->core == b->core;
 }
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 22e53fd54657..652b76c69376 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -67,7 +67,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
-bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b);
+bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a);
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void);
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6c40b91d5e32..0241436bb1fb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -328,20 +328,22 @@ static void print_metric_header(struct perf_stat_config *config,
 }
 
 static int first_shadow_cpu(struct perf_stat_config *config,
-			    struct evsel *evsel, struct aggr_cpu_id id)
+			    struct evsel *evsel, const struct aggr_cpu_id *id)
 {
 	struct perf_cpu_map *cpus;
 	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id.core;
+		return id->core;
 
 	if (!config->aggr_get_id)
 		return 0;
 
 	cpus = evsel__cpus(evsel);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpu), id))
+		struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
+
+		if (aggr_cpu_id__equal(&cpu_id, id))
 			return cpu;
 	}
 	return 0;
@@ -501,7 +503,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu(config, counter, id),
+				first_shadow_cpu(config, counter, &id),
 				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
@@ -525,12 +527,12 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 			val = 0;
 			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 				s2 = config->aggr_get_id(config, cpu);
-				if (!cpu_map__compare_aggr_cpu_id(s2, id))
+				if (!aggr_cpu_id__equal(&s2, &id))
 					continue;
 				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu(config, counter, id),
+					first_shadow_cpu(config, counter, &id),
 					&rt_stat);
 		}
 	}
@@ -641,7 +643,7 @@ static void aggr_cb(struct perf_stat_config *config,
 		struct perf_counts_values *counts;
 
 		s2 = config->aggr_get_id(config, cpu);
-		if (!cpu_map__compare_aggr_cpu_id(s2, ad->id))
+		if (!aggr_cpu_id__equal(&s2, &ad->id))
 			continue;
 		if (first)
 			ad->nr++;
@@ -1217,7 +1219,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 		s2 = config->aggr_get_id(config, cpu);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
-			if (cpu_map__compare_aggr_cpu_id(s2, id))
+			if (aggr_cpu_id__equal(&s2, &id))
 				break;
 		}
 
-- 
2.34.1.400.ga245620fadb-goog

