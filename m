Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17BC64E90
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AD2223C7
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgKQOtO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:49:14 -0500
Received: from foss.arm.com ([217.140.110.172]:59258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgKQOtO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 09:49:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DE64101E;
        Tue, 17 Nov 2020 06:49:13 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F3893F718;
        Tue, 17 Nov 2020 06:49:11 -0800 (PST)
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
Subject: [PATCH v5 06/12] perf tools: drop in cpu_aggr_map struct
Date:   Tue, 17 Nov 2020 16:48:39 +0200
Message-Id: <20201117144845.13714-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117144845.13714-1-james.clark@arm.com>
References: <20201117144845.13714-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Replace usages of perf_cpu_map with cpu_aggr map in
places that are involved with perf stat aggregation.

This will then later be changed to be a map of
cpu_aggr_id rather than an int so that more data can
be stored.

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
 tools/perf/builtin-stat.c | 29 ++++++++++++++++++++++-------
 tools/perf/util/cpumap.c  | 12 ++++++------
 tools/perf/util/cpumap.h  | 10 +++++-----
 tools/perf/util/stat.h    |  4 ++--
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f10c67a26472..344e50651b55 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1322,14 +1322,29 @@ static int perf_stat_init_aggr_mode(void)
 	 * the aggregation translate cpumap.
 	 */
 	nr = perf_cpu_map__max(evsel_list->core.cpus);
-	stat_config.cpus_aggr_map = perf_cpu_map__empty_new(nr + 1);
+	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
 
+static void cpu_aggr_map__delete(struct cpu_aggr_map *map)
+{
+	if (map) {
+		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+			  "cpu_aggr_map refcnt unbalanced\n");
+		free(map);
+	}
+}
+
+static void cpu_aggr_map__put(struct cpu_aggr_map *map)
+{
+	if (map && refcount_dec_and_test(&map->refcnt))
+		cpu_aggr_map__delete(map);
+}
+
 static void perf_stat__exit_aggr_mode(void)
 {
-	perf_cpu_map__put(stat_config.aggr_map);
-	perf_cpu_map__put(stat_config.cpus_aggr_map);
+	cpu_aggr_map__put(stat_config.aggr_map);
+	cpu_aggr_map__put(stat_config.cpus_aggr_map);
 	stat_config.aggr_map = NULL;
 	stat_config.cpus_aggr_map = NULL;
 }
@@ -1427,25 +1442,25 @@ static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx,
 }
 
 static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				      struct perf_cpu_map **sockp)
+				      struct cpu_aggr_map **sockp)
 {
 	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
 }
 
 static int perf_env__build_die_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				   struct perf_cpu_map **diep)
+				   struct cpu_aggr_map **diep)
 {
 	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
 }
 
 static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				    struct perf_cpu_map **corep)
+				    struct cpu_aggr_map **corep)
 {
 	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
 }
 
 static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				    struct perf_cpu_map **nodep)
+				    struct cpu_aggr_map **nodep)
 {
 	return cpu_map__build_map(cpus, nodep, perf_env__get_node, env);
 }
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b18e53506656..ea81586305f4 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -151,12 +151,12 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 	return a->id - b->id;
 }
 
-int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
+int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
 		       void *data)
 {
 	int nr = cpus->nr;
-	struct perf_cpu_map *c = perf_cpu_map__empty_new(nr);
+	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(nr);
 	int cpu, s2;
 	struct aggr_cpu_id s1;
 
@@ -279,22 +279,22 @@ struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *da
 	return id;
 }
 
-int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct perf_cpu_map **sockp)
+int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
 {
 	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
 }
 
-int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct perf_cpu_map **diep)
+int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep)
 {
 	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
 }
 
-int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct perf_cpu_map **corep)
+int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep)
 {
 	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
 }
 
-int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct perf_cpu_map **numap)
+int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **numap)
 {
 	return cpu_map__build_map(cpus, numap, cpu_map__get_node, NULL);
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index ebd65c4f431b..b112069038be 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -34,10 +34,10 @@ int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id  cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
-int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct perf_cpu_map **sockp);
-int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct perf_cpu_map **diep);
-int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct perf_cpu_map **corep);
-int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct perf_cpu_map **nodep);
+int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
+int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
+int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep);
+int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **nodep);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
 static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
@@ -69,7 +69,7 @@ int cpu__max_cpu(void);
 int cpu__max_present_cpu(void);
 int cpu__get_node(int cpu);
 
-int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
+int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
 		       void *data);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 888a78bef014..15b88c2c5101 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -139,9 +139,9 @@ struct perf_stat_config {
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
-	struct perf_cpu_map		*aggr_map;
+	struct cpu_aggr_map	*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
-	struct perf_cpu_map		*cpus_aggr_map;
+	struct cpu_aggr_map	*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
 	int			 ctl_fd;
-- 
2.28.0

