Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC9C5519F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00E6223AB
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgKQOtV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:49:21 -0500
Received: from foss.arm.com ([217.140.110.172]:59302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbgKQOtV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 09:49:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE6811FB;
        Tue, 17 Nov 2020 06:49:20 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0EF23F718;
        Tue, 17 Nov 2020 06:49:13 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Cc:     james.clark@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v5 07/12] perf tools: Start using cpu_aggr_id in map
Date:   Tue, 17 Nov 2020 16:48:40 +0200
Message-Id: <20201117144845.13714-8-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117144845.13714-1-james.clark@arm.com>
References: <20201117144845.13714-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the new cpu_aggr_id struct in the cpu map
instead of int so that it can store more data.

No functional changes.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>
---
 tools/perf/builtin-stat.c      | 6 +++---
 tools/perf/util/cpumap.c       | 8 ++++----
 tools/perf/util/cpumap.h       | 2 +-
 tools/perf/util/stat-display.c | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 344e50651b55..afe9fa6112b6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1223,10 +1223,10 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 
 	cpu = map->map[idx];
 
-	if (config->cpus_aggr_map->map[cpu] == -1)
-		config->cpus_aggr_map->map[cpu] = get_id(config, map, idx).id;
+	if (cpu_map__aggr_cpu_id_is_empty(config->cpus_aggr_map->map[cpu]))
+		config->cpus_aggr_map->map[cpu] = get_id(config, map, idx);
 
-	id.id = config->cpus_aggr_map->map[cpu];
+	id = config->cpus_aggr_map->map[cpu];
 	return id;
 }
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index ea81586305f4..b50609b9a585 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -97,14 +97,14 @@ struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 
 struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
 {
-	struct cpu_aggr_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
+	struct cpu_aggr_map *cpus = malloc(sizeof(*cpus) + sizeof(struct aggr_cpu_id) * nr);
 
 	if (cpus != NULL) {
 		int i;
 
 		cpus->nr = nr;
 		for (i = 0; i < nr; i++)
-			cpus->map[i] = -1;
+			cpus->map[i] = cpu_map__empty_aggr_cpu_id();
 
 		refcount_set(&cpus->refcnt, 1);
 	}
@@ -169,11 +169,11 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	for (cpu = 0; cpu < nr; cpu++) {
 		s1 = f(cpus, cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
-			if (s1.id == c->map[s2])
+			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
 				break;
 		}
 		if (s2 == c->nr) {
-			c->map[c->nr] = s1.id;
+			c->map[c->nr] = s1;
 			c->nr++;
 		}
 	}
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index b112069038be..d8fc265bc762 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -14,7 +14,7 @@ struct aggr_cpu_id {
 struct cpu_aggr_map {
 	refcount_t refcnt;
 	int nr;
-	int map[];
+	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1a3d66329d73..da0766403d3b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -509,7 +509,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 	struct evsel *counter;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		id.id = config->aggr_map->map[s];
+		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
@@ -641,7 +641,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 	double uval;
 
-	ad.id.id = id.id = config->aggr_map->map[s];
+	ad.id = id = config->aggr_map->map[s];
 	ad.val = ad.ena = ad.run = 0;
 	ad.nr = 0;
 	if (!collect_data(config, counter, aggr_cb, &ad))
@@ -1169,7 +1169,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
 		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
 		for (s = 0; s < config->aggr_map->nr; s++) {
-			id.id = config->aggr_map->map[s];
+			id = config->aggr_map->map[s];
 			if (cpu_map__compare_aggr_cpu_id(s2, id))
 				break;
 		}
-- 
2.28.0

