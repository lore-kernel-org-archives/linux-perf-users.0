Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77853C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbhLHCtz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbhLHCtv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:49:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096FCC0617A1
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso2128316ybl.7
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zMEkydFBMN/BA7SE7sHLq3Joul9UySGeCM7liCkybYI=;
        b=f4+Cj0UmxA2OpbHxI0D+bIEmWaew5sg2qlHgLmgCLHHrBezqMLZnNrmPaGVhBeswZT
         TKAV3cZucbeLNeDY222ukTDY6XyqQxvdmCeQwQD/g2aJbuDrXSlGchRCNcXlr/OS6M4c
         XHpkjk3yi+TL7HPBR9EnnbeC7M7Qr2Wm+6ukP6na48YjVirCBpX9krobQUpcIWrbFvni
         kc1ZTMxDopb8xJbYR0zGoInhonWjNLltO5KN1B2DAk/eODY1qonjfIVlc/x80Ca86/yw
         3z9i9VN7KQ9nSUSaiqE/KQFuZfoYc10HifXn5f27tNnbr87VUVuxYOOaXLSdWwNqCwNb
         DzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zMEkydFBMN/BA7SE7sHLq3Joul9UySGeCM7liCkybYI=;
        b=Rquf0ycHUlAxHsecCnV5/8QmpMeicz7eVq2MYlpM4ioPd4C+YQNADbx50tihBDJ2Am
         zGuSCcysJiQt9wx10Le1lFjaDU2Z5Xz8SscYPFdp7f3Rd7FOCQLF2xeAbHPNFXDOnD0T
         dsTV1zmc1CktXJxN4MtpJj4NGdvAnHxfzgzZB+1GCOhzyjMWSA5gRSqqAKv/8ymKydUP
         NkmdbEN6xGOrkTNxambbgFmC0AbwS1Kfalf+R6vhCQ/MiY+fTsZy1NNtVadLhHuI0BqE
         nuNTiD6Sxew44SULy1LYfksYVAa2TydhvU+nlHg5eaIP2Ua16vWNtID6RFkqd3eXcGqa
         5Chg==
X-Gm-Message-State: AOAM5316qHkBbroK4KdG2bYUpF7VKreVfuZ6bT/QrvAhi1dsTAiCZ0ER
        EM11ecZh9U/AWdniP8vVdQ5AEQDwSQSS
X-Google-Smtp-Source: ABdhPJwc9sxh7ugQxNud40eLJctUJdMoouTvRV1pFyHt5VyMR73mV8xpmEJ60QembUURThQCN3K3ADJNsEel
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:d987:: with SMTP id
 q129mr52982547ybg.331.1638931579179; Tue, 07 Dec 2021 18:46:19 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:48 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-4-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 03/22] perf stat: Switch aggregation to use for_each loop
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

Tidy up the use of cpu and index to hopefully make the code less error
prone. Avoid unused warnings with (void) which will be removed in a
later patch.

In aggr_update_shadow, the perf_cpu_map is switched from
the evlist to the counter's cpu map, so the index is appropriate. This
addresses a problem where uncore counts, with a cpumap like:
$ cat /sys/devices/uncore_imc_0/cpumask
0,18
Don't aggregate counts in CPUs based on the index of those values in the
cpumap (0 and 1) but on the actual CPU (0 and 18). Thereby correcting
metric calculations in per-socket mode for counters with without a full
cpumask.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 48 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 588601000f3f..efab39a759ff 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -330,8 +330,8 @@ static void print_metric_header(struct perf_stat_config *config,
 static int first_shadow_cpu(struct perf_stat_config *config,
 			    struct evsel *evsel, struct aggr_cpu_id id)
 {
-	struct evlist *evlist = evsel->evlist;
-	int i;
+	struct perf_cpu_map *cpus;
+	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
 		return id.core;
@@ -339,14 +339,11 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (!config->aggr_get_id)
 		return 0;
 
-	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
-		int cpu2 = evsel__cpus(evsel)->map[i];
-
-		if (cpu_map__compare_aggr_cpu_id(
-					config->aggr_get_id(config, evlist->core.cpus, cpu2),
-					id)) {
-			return cpu2;
-		}
+	cpus = evsel__cpus(evsel);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
+						 id))
+			return cpu;
 	}
 	return 0;
 }
@@ -516,20 +513,23 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 static void aggr_update_shadow(struct perf_stat_config *config,
 			       struct evlist *evlist)
 {
-	int cpu, s;
+	int cpu, idx, s;
 	struct aggr_cpu_id s2, id;
 	u64 val;
 	struct evsel *counter;
+	struct perf_cpu_map *cpus;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
+			cpus = evsel__cpus(counter);
 			val = 0;
-			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
+			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+				(void)cpu;
+				s2 = config->aggr_get_id(config, cpus, idx);
 				if (!cpu_map__compare_aggr_cpu_id(s2, id))
 					continue;
-				val += perf_counts(counter->counts, cpu, 0)->val;
+				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
 					first_shadow_cpu(config, counter, id),
@@ -634,18 +634,21 @@ static void aggr_cb(struct perf_stat_config *config,
 		    struct evsel *counter, void *data, bool first)
 {
 	struct aggr_data *ad = data;
-	int cpu;
+	int idx, cpu;
+	struct perf_cpu_map *cpus;
 	struct aggr_cpu_id s2;
 
-	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
+	cpus = evsel__cpus(counter);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		struct perf_counts_values *counts;
 
-		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
+		(void)cpu;
+		s2 = config->aggr_get_id(config, cpus, idx);
 		if (!cpu_map__compare_aggr_cpu_id(s2, ad->id))
 			continue;
 		if (first)
 			ad->nr++;
-		counts = perf_counts(counter->counts, cpu, 0);
+		counts = perf_counts(counter->counts, idx, 0);
 		/*
 		 * When any result is bad, make them all to give
 		 * consistent output in interval mode.
@@ -1208,10 +1211,13 @@ static void print_percore_thread(struct perf_stat_config *config,
 {
 	int s;
 	struct aggr_cpu_id s2, id;
+	struct perf_cpu_map *cpus;
 	bool first = true;
+	int idx, cpu;
 
-	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
-		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
+	cpus = evsel__cpus(counter);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		s2 = config->aggr_get_id(config, cpus, idx);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
 			if (cpu_map__compare_aggr_cpu_id(s2, id))
@@ -1220,7 +1226,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, false,
-				       &first, i);
+				       &first, cpu);
 	}
 }
 
-- 
2.34.1.400.ga245620fadb-goog

