Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73475C55ABD
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2999521D1A
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKMRUD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:20:03 -0500
Received: from foss.arm.com ([217.140.110.172]:42048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgKMRTq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Nov 2020 12:19:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 723ED1534;
        Fri, 13 Nov 2020 09:19:59 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A139A3F718;
        Fri, 13 Nov 2020 09:19:57 -0800 (PST)
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
Subject: [PATCH 11/13 v3] perf tools: Add separate die member
Date:   Fri, 13 Nov 2020 19:19:21 +0200
Message-Id: <20201113171923.29721-12-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113171923.29721-1-james.clark@arm.com>
References: <20201113171923.29721-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add die as a separate member so that it doesn't have to be
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
 tools/perf/builtin-stat.c      | 14 +++-----------
 tools/perf/tests/topology.c    |  7 +++++--
 tools/perf/util/cpumap.c       | 28 ++++++++++++++--------------
 tools/perf/util/cpumap.h       |  6 +-----
 tools/perf/util/stat-display.c |  6 +++---
 5 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 193e7a4e0c7b..514144dad8b1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1389,11 +1389,7 @@ static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, v
 		 * make a unique ID.
 		 */
 		id.socket = env->cpu[cpu].socket_id;
-
-		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
-			return cpu_map__empty_aggr_cpu_id();
-
-		id.id = env->cpu[cpu].die_id & 0xff;
+		id.die = env->cpu[cpu].die_id;
 	}
 
 	return id;
@@ -1407,20 +1403,16 @@ static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx,
 
 	if (cpu != -1) {
 		/*
-		 * encode die id in bit range 23:16
 		 * core_id is relative to socket and die,
 		 * we need a global id. So we combine
 		 * socket + die id + core id
 		 */
-		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
-			return cpu_map__empty_aggr_cpu_id();
-
 		if (WARN_ONCE(env->cpu[cpu].core_id >> 16, "The core id number is too big.\n"))
 			return cpu_map__empty_aggr_cpu_id();
 
 		id.socket = env->cpu[cpu].socket_id;
-		id.id = (env->cpu[cpu].die_id << 16) |
-		       (env->cpu[cpu].core_id & 0xffff);
+		id.die = env->cpu[cpu].die_id;
+		id.id = env->cpu[cpu].core_id & 0xffff;
 	}
 
 	return id;
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index afefe7456385..1256cf63d4d0 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -117,7 +117,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
+			session->header.env.cpu[map->map[i]].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
 	}
 
@@ -128,8 +128,9 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
+			session->header.env.cpu[map->map[i]].die_id == id.die);
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
+		TEST_ASSERT_VAL("Die map - ID is set", id.id == -1);
 	}
 
 	// Test that socket ID contains only socket
@@ -138,6 +139,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
+		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Socket map - ID is set", id.id == -1);
 	}
 
@@ -147,6 +149,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
 			cpu__get_node(map->map[i]) == id.node);
 		TEST_ASSERT_VAL("Node map - ID shouldn't be set", id.id == -1);
+		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 	}
 	perf_session__delete(session);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 233b752cb469..c1d3539222f2 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -152,8 +152,10 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 		return a->id - b->id;
 	else if (a->node != b->node)
 		return a->node - b->node;
-	else
+	else if (a->socket != b->socket)
 		return a->socket - b->socket;
+	else
+		return a->die - b->die;
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
@@ -221,10 +223,7 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
 	if (cpu_map__aggr_cpu_id_is_empty(id))
 		return id;
 
-	if (WARN_ONCE(die >> 8, "The die id number is too big.\n"))
-		return cpu_map__empty_aggr_cpu_id();
-
-	id.id = (die & 0xff);
+	id.die = die;
 	return id;
 }
 
@@ -251,21 +250,19 @@ struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *da
 
 	cpu = cpu_map__get_core_id(cpu);
 
-	/* cpu_map__get_die returns the combination of socket + die id */
+	/* cpu_map__get_die returns a struct with socket and die set*/
 	id = cpu_map__get_die(map, idx, data);
 	if (cpu_map__aggr_cpu_id_is_empty(id))
 		return id;
 
 	/*
-	 * encode die id in bit range 23:16
-	 * core_id is relative to socket and die,
-	 * we need a global id. So we combine
-	 * socket + die id + core id
+	 * core_id is relative to socket and die, we need a global id.
+	 * So we combine the result from cpu_map__get_die with the core id
 	 */
 	if (WARN_ONCE(cpu >> 16, "The core id number is too big.\n"))
 		return cpu_map__empty_aggr_cpu_id();
 
-	id.id = (id.id << 16) | (cpu & 0xffff);
+	id.id = (cpu & 0xffff);
 	return id;
 }
 
@@ -623,14 +620,16 @@ bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
 {
 	return a.id == b.id &&
 		a.node == b.node &&
-		a.socket == b.socket;
+		a.socket == b.socket &&
+		a.die == b.die;
 }
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
 {
 	return a.id == -1 &&
 		a.node == -1 &&
-		a.socket == -1;
+		a.socket == -1 &&
+		a.die == -1;
 }
 
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
@@ -638,7 +637,8 @@ struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
 	struct aggr_cpu_id ret = {
 		.id = -1,
 		.node = -1,
-		.socket = -1
+		.socket = -1,
+		.die = -1
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 0123ecc90694..51bbe1eca3f4 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -11,6 +11,7 @@ struct aggr_cpu_id {
 	int id;
 	int node;
 	int socket;
+	int die;
 };
 
 struct cpu_aggr_map {
@@ -49,11 +50,6 @@ static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
 	return sock->map[s];
 }
 
-static inline int cpu_map__id_to_die(int id)
-{
-	return (id >> 16) & 0xff;
-}
-
 static inline int cpu_map__id_to_cpu(int id)
 {
 	return id & 0xffff;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 625a0c44a11c..bbd6c95104c7 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -74,7 +74,7 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_CORE:
 		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
 			id.socket,
-			cpu_map__id_to_die(id.id),
+			id.die,
 			config->csv_output ? 0 : -8,
 			cpu_map__id_to_cpu(id.id),
 			config->csv_sep,
@@ -86,7 +86,7 @@ static void aggr_printout(struct perf_stat_config *config,
 		fprintf(config->output, "S%d-D%*d%s%*d%s",
 			id.socket,
 			config->csv_output ? 0 : -8,
-			cpu_map__id_to_die(id.id << 16),
+			id.die,
 			config->csv_sep,
 			config->csv_output ? 0 : 4,
 			nr,
@@ -114,7 +114,7 @@ static void aggr_printout(struct perf_stat_config *config,
 		if (evsel->percore && !config->percore_show_thread) {
 			fprintf(config->output, "S%d-D%d-C%*d%s",
 				id.socket,
-				cpu_map__id_to_die(id.id),
+				id.die,
 				config->csv_output ? 0 : -3,
 				cpu_map__id_to_cpu(id.id), config->csv_sep);
 		} else if (id.id > -1) {
-- 
2.28.0

