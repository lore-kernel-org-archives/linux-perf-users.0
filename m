Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B134C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Dec 2021 02:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbhLDChk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245064AbhLDChj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Dec 2021 21:37:39 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B59C061354
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Dec 2021 18:34:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id p1-20020aa79e81000000b004a82ea1b82bso3051138pfq.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Dec 2021 18:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4Ci0sRMJzuLU7V3ApoNCZ/NoeeTh2TBWFA1UKK1rdeE=;
        b=DHy+8Igq3mWlQBglekabtF7x4gZIF+rY8rSOU/BF/e0eWbp+bOMEJr+GCMyMNjqcBt
         1j49Ni9hVErvFykqGnDCW0+iuXdONZj7PwnmIoVXWJENU+fGp3NF56P3MLaoioBRvt6e
         KjMGfoxzVdZMc1g9dIG3v4p5zBSpQsLYfyR6dPes0lVy8gFnR+zToIfLXuO/KprLJ7hs
         /kFMPjlxoQQ+SYEFgk4/HeCBYRDbmpuzt4oO10tIgPW4V/ej1xfuw4+Yh7r2CECEN9Qq
         rdUjpnGv6WLJU1pxgAlIlj/3Vn7yrCdv6qgh2fDADopg+fRA70n2Ck8iKk14C2dTBl5X
         ZRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4Ci0sRMJzuLU7V3ApoNCZ/NoeeTh2TBWFA1UKK1rdeE=;
        b=IVFpWh6m/SyrjQiP9XJaux/T8GEGGyJqY3cZ8WgEAJ7OR44tfJ1S+TVvlSgNicWY+5
         DvjYtxhGlqnJCbfvjfsjDCyCHI0Oyc/CBNsSb1wuImVmbAo77vwUGhQEqF4M4MUASPWB
         ObJzxPDBu88C5oxWmwyvhxUs69I5ZMjj8Pvfn3OWvqR1c6Sa44/jnADUzc53kxg+uYAS
         P6MPWUICB9m2DHyWqQoIgbWTtoC9s1l2I1KEIgz+UkdeHts97sShlxeJAkrsavtt5czR
         sNoC46Pw3S39ZbTe5ikBsyKZKSRV2oW4OpH4RKH3r7VAY9v4gv5judIu8+9s9xyi9pUp
         1a8w==
X-Gm-Message-State: AOAM530VMmWUJ/REq0oXPRX7pf8sQlWQ/8nN0G/YTbb1RVTlFXJZmLj/
        NIS2TOkadHKVfjfcMg5ixmSBhirMdYfI
X-Google-Smtp-Source: ABdhPJyV9Ee5RttEz8aKJHUiD7FVP3vuSylfGOTM66Dxx+qlExDfWscNPnVleMWq5Tbq7fEMuhc4e5YJzPeX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6ed3:4caa:939f:d51c])
 (user=irogers job=sendgmr) by 2002:a17:903:285:b0:142:7a83:6dd2 with SMTP id
 j5-20020a170903028500b001427a836dd2mr26876166plr.59.1638585254467; Fri, 03
 Dec 2021 18:34:14 -0800 (PST)
Date:   Fri,  3 Dec 2021 18:34:09 -0800
Message-Id: <20211204023409.969668-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH] perf stat: Fix per socket shadow aggregation
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
        Vineet Singh <vineet.singh@intel.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

An uncore device may have a CPU mask that specifies one CPU per socket:
$ cat /sys/devices/uncore_imc_0/cpumask
0,18
The perf_stat_config aggr_map will map a CPU to the socket and other
aggregation values for it. Fix an error where the index into CPU mask
was being used as the index into the aggr_map. For the cpumask above the
indexes 0 and 1 are passed to aggr_map rather than the CPUs 0 and 18.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 588601000f3f..7cfad5cfec38 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -516,7 +516,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 static void aggr_update_shadow(struct perf_stat_config *config,
 			       struct evlist *evlist)
 {
-	int cpu, s;
+	int idx, cpu, s;
 	struct aggr_cpu_id s2, id;
 	u64 val;
 	struct evsel *counter;
@@ -525,11 +525,12 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
-			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
+			for (idx = 0; idx < evsel__nr_cpus(counter); idx++) {
+				cpu = perf_cpu_map__cpu(evsel__cpus(counter), idx);
 				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
 				if (!cpu_map__compare_aggr_cpu_id(s2, id))
 					continue;
-				val += perf_counts(counter->counts, cpu, 0)->val;
+				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
 					first_shadow_cpu(config, counter, id),
-- 
2.34.1.400.ga245620fadb-goog

