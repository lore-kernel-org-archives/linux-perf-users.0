Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F6BC64EBC
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23E522240
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgKQOtS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:49:18 -0500
Received: from foss.arm.com ([217.140.110.172]:59274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgKQOtS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 09:49:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D1C11D4;
        Tue, 17 Nov 2020 06:49:17 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9AAB3F85F;
        Tue, 17 Nov 2020 06:49:15 -0800 (PST)
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
Subject: [PATCH v5 08/12] perf tools: Add separate node member
Date:   Tue, 17 Nov 2020 16:48:41 +0200
Message-Id: <20201117144845.13714-9-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117144845.13714-1-james.clark@arm.com>
References: <20201117144845.13714-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add node as a separate member so that it doesn't have to be
packed into the int value.

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
 tools/perf/builtin-stat.c      |  2 +-
 tools/perf/tests/topology.c    |  6 +++++-
 tools/perf/util/cpumap.c       | 16 +++++++++++-----
 tools/perf/util/cpumap.h       |  1 +
 tools/perf/util/stat-display.c |  2 +-
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index afe9fa6112b6..2db2550eef9e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1437,7 +1437,7 @@ static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx,
 	int cpu = perf_env__get_cpu(data, map, idx);
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
-	id.id = perf_env__numa_node(data, cpu);
+	id.node = perf_env__numa_node(data, cpu);
 	return id;
 }
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index aeca2510dea8..f0c0fc6e243d 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -119,6 +119,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
+		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
 	}
 
 	// Test that die ID contains socket and die
@@ -130,6 +131,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
+		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 	}
 
 	// Test that socket ID contains only socket
@@ -138,13 +140,15 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id ==
 				cpu_map__id_to_socket(id.id));
+		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 	}
 
 	// Test that node ID contains only node
 	for (i = 0; i < map->nr; i++) {
 		id = cpu_map__get_node(map, i, NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
-			cpu__get_node(map->map[i]) == id.id);
+			cpu__get_node(map->map[i]) == id.node);
+		TEST_ASSERT_VAL("Node map - ID is set", id.id == -1);
 	}
 	perf_session__delete(session);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b50609b9a585..5f9e98ddbe34 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -148,7 +148,10 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
 	struct aggr_cpu_id *b = (struct aggr_cpu_id *)b_pointer;
 
-	return a->id - b->id;
+	if (a->id != b->id)
+		return a->id - b->id;
+	else
+		return a->node - b->node;
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
@@ -275,7 +278,7 @@ struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *da
 	if (idx < 0 || idx >= map->nr)
 		return id;
 
-	id.id = cpu_map__get_node_id(map->map[idx]);
+	id.node = cpu_map__get_node_id(map->map[idx]);
 	return id;
 }
 
@@ -620,18 +623,21 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 
 bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
 {
-	return a.id == b.id;
+	return a.id == b.id &&
+		a.node == b.node;
 }
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
 {
-	return a.id == -1;
+	return a.id == -1 &&
+		a.node == -1;
 }
 
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
 {
 	struct aggr_cpu_id ret = {
-		.id = -1
+		.id = -1,
+		.node = -1
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index d8fc265bc762..f79e92603024 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -9,6 +9,7 @@
 
 struct aggr_cpu_id {
 	int id;
+	int node;
 };
 
 struct cpu_aggr_map {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index da0766403d3b..46c288e8bde7 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -104,7 +104,7 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_NODE:
 		fprintf(config->output, "N%*d%s%*d%s",
 			config->csv_output ? 0 : -5,
-			id.id,
+			id.node,
 			config->csv_sep,
 			config->csv_output ? 0 : 4,
 			nr,
-- 
2.28.0

