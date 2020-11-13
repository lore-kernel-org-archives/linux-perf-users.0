Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DFFC55ABD
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6765C21D1A
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKMRUI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:20:08 -0500
Received: from foss.arm.com ([217.140.110.172]:42030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgKMRTo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Nov 2020 12:19:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6615A1042;
        Fri, 13 Nov 2020 09:19:57 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92F1F3F718;
        Fri, 13 Nov 2020 09:19:55 -0800 (PST)
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
Subject: [PATCH 10/13 v3] perf tools: Add separate socket member
Date:   Fri, 13 Nov 2020 19:19:20 +0200
Message-Id: <20201113171923.29721-11-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113171923.29721-1-james.clark@arm.com>
References: <20201113171923.29721-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add socket as a separate member so that it doesn't have to be
packed into the int value. When the socket ID was larger than
8 bits the output appeared corrupted or incomplete.

For example, here on ThunderX2 perf stat reports a socket
of -1 and an invalid die number:

  ./perf stat -a --per-die
  The socket id number is too big.

  Performance counter stats for 'system wide':

  S-1-D255       128             687.99 msec cpu-clock                 #   57.240 CPUs utilized
  ...
  S36-D0         128             842.34 msec cpu-clock                 #   70.081 CPUs utilized
  ...

And with --per-core there is an entry with an invalid core ID:

  ./perf stat record -a --per-core
  The socket id number is too big.

  Performance counter stats for 'system wide':
  S-1-D255-C65535     128             671.04 msec cpu-clock                 #   54.112 CPUs utilized
  ...
  S36-D0-C0           4              28.27 msec cpu-clock                 #    2.279 CPUs utilized
  ...

This fixes the "Session topology" self test on ThunderX2.

After this fix the output contains the correct socket and die
IDs and no longer prints a warning about the size of the
socket ID:

  ./perf stat --per-die -a

  Performance counter stats for 'system wide':

  S36-D0         128         169,869.39 msec cpu-clock                 #  127.501 CPUs utilized
  ...
  S3612-D0         128         169,733.05 msec cpu-clock                 #  127.398 CPUs utilized

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
 tools/perf/builtin-stat.c      | 22 +++++++----------
 tools/perf/tests/topology.c    | 10 ++++----
 tools/perf/util/cpumap.c       | 44 +++++++++++++++++-----------------
 tools/perf/util/cpumap.h       |  6 +----
 tools/perf/util/stat-display.c |  8 +++----
 tools/perf/util/stat.c         |  2 +-
 6 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2db2550eef9e..193e7a4e0c7b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1371,7 +1371,7 @@ static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
 	if (cpu != -1)
-		id.id = env->cpu[cpu].socket_id;
+		id.socket = env->cpu[cpu].socket_id;
 
 	return id;
 }
@@ -1384,18 +1384,16 @@ static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, v
 
 	if (cpu != -1) {
 		/*
-		 * Encode socket in bit range 15:8
-		 * die_id is relative to socket,
-		 * we need a global id. So we combine
-		 * socket + die id
+		 * die_id is relative to socket, so start
+		 * with the socket ID and then add die to
+		 * make a unique ID.
 		 */
-		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8, "The socket id number is too big.\n"))
-			return cpu_map__empty_aggr_cpu_id();
+		id.socket = env->cpu[cpu].socket_id;
 
 		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
 			return cpu_map__empty_aggr_cpu_id();
 
-		id.id = (env->cpu[cpu].socket_id << 8) | (env->cpu[cpu].die_id & 0xff);
+		id.id = env->cpu[cpu].die_id & 0xff;
 	}
 
 	return id;
@@ -1409,23 +1407,19 @@ static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx,
 
 	if (cpu != -1) {
 		/*
-		 * Encode socket in bit range 31:24
 		 * encode die id in bit range 23:16
 		 * core_id is relative to socket and die,
 		 * we need a global id. So we combine
 		 * socket + die id + core id
 		 */
-		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8, "The socket id number is too big.\n"))
-			return cpu_map__empty_aggr_cpu_id();
-
 		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
 			return cpu_map__empty_aggr_cpu_id();
 
 		if (WARN_ONCE(env->cpu[cpu].core_id >> 16, "The core id number is too big.\n"))
 			return cpu_map__empty_aggr_cpu_id();
 
-		id.id = (env->cpu[cpu].socket_id << 24) |
-		       (env->cpu[cpu].die_id << 16) |
+		id.socket = env->cpu[cpu].socket_id;
+		id.id = (env->cpu[cpu].die_id << 16) |
 		       (env->cpu[cpu].core_id & 0xffff);
 	}
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 90d9c259d258..afefe7456385 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -114,8 +114,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			session->header.env.cpu[map->map[i]].core_id == cpu_map__id_to_cpu(id.id));
 
 		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i]].socket_id ==
-				cpu_map__id_to_socket(id.id));
+			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
@@ -126,8 +125,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	for (i = 0; i < map->nr; i++) {
 		id = cpu_map__get_die(map, i, NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i]].socket_id ==
-				cpu_map__id_to_socket(id.id));
+			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
@@ -138,9 +136,9 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	for (i = 0; i < map->nr; i++) {
 		id = cpu_map__get_socket(map, i, NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i]].socket_id ==
-				cpu_map__id_to_socket(id.id));
+			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
+		TEST_ASSERT_VAL("Socket map - ID is set", id.id == -1);
 	}
 
 	// Test that node ID contains only node
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 9929ee5cf177..233b752cb469 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -139,7 +139,7 @@ struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
 
 	cpu = map->map[idx];
 
-	id.id = cpu_map__get_socket_id(cpu);
+	id.socket = cpu_map__get_socket_id(cpu);
 	return id;
 }
 
@@ -150,8 +150,10 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 
 	if (a->id != b->id)
 		return a->id - b->id;
-	else
+	else if (a->node != b->node)
 		return a->node - b->node;
+	else
+		return a->socket - b->socket;
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
@@ -197,7 +199,7 @@ int cpu_map__get_die_id(int cpu)
 
 struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
 {
-	int cpu, s;
+	int cpu, die;
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
 	if (idx > map->nr)
@@ -205,28 +207,24 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
 
 	cpu = map->map[idx];
 
-	id.id = cpu_map__get_die_id(cpu);
+	die = cpu_map__get_die_id(cpu);
 	/* There is no die_id on legacy system. */
-	if (id.id == -1)
-		id.id = 0;
-
-	s = cpu_map__get_socket(map, idx, data).id;
-	if (s == -1)
-		return cpu_map__empty_aggr_cpu_id();
+	if (die == -1)
+		die = 0;
 
 	/*
-	 * Encode socket in bit range 15:8
-	 * die_id is relative to socket, and
-	 * we need a global id. So we combine
-	 * socket + die id
+	 * die_id is relative to socket, so start
+	 * with the socket ID and then add die to
+	 * make a unique ID.
 	 */
-	if (WARN_ONCE(id.id >> 8, "The die id number is too big.\n"))
-		return cpu_map__empty_aggr_cpu_id();
+	id = cpu_map__get_socket(map, idx, data);
+	if (cpu_map__aggr_cpu_id_is_empty(id))
+		return id;
 
-	if (WARN_ONCE(s >> 8, "The socket id number is too big.\n"))
+	if (WARN_ONCE(die >> 8, "The die id number is too big.\n"))
 		return cpu_map__empty_aggr_cpu_id();
 
-	id.id = (s << 8) | (id.id & 0xff);
+	id.id = (die & 0xff);
 	return id;
 }
 
@@ -259,7 +257,6 @@ struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *da
 		return id;
 
 	/*
-	 * encode socket in bit range 31:24
 	 * encode die id in bit range 23:16
 	 * core_id is relative to socket and die,
 	 * we need a global id. So we combine
@@ -625,20 +622,23 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
 {
 	return a.id == b.id &&
-		a.node == b.node;
+		a.node == b.node &&
+		a.socket == b.socket;
 }
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
 {
 	return a.id == -1 &&
-		a.node == -1;
+		a.node == -1 &&
+		a.socket == -1;
 }
 
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
 {
 	struct aggr_cpu_id ret = {
 		.id = -1,
-		.node = -1
+		.node = -1,
+		.socket = -1
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f79e92603024..0123ecc90694 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -10,6 +10,7 @@
 struct aggr_cpu_id {
 	int id;
 	int node;
+	int socket;
 };
 
 struct cpu_aggr_map {
@@ -48,11 +49,6 @@ static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
 	return sock->map[s];
 }
 
-static inline int cpu_map__id_to_socket(int id)
-{
-	return id >> 24;
-}
-
 static inline int cpu_map__id_to_die(int id)
 {
 	return (id >> 16) & 0xff;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 36cec8e1e05e..625a0c44a11c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -73,7 +73,7 @@ static void aggr_printout(struct perf_stat_config *config,
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
-			cpu_map__id_to_socket(id.id),
+			id.socket,
 			cpu_map__id_to_die(id.id),
 			config->csv_output ? 0 : -8,
 			cpu_map__id_to_cpu(id.id),
@@ -84,7 +84,7 @@ static void aggr_printout(struct perf_stat_config *config,
 		break;
 	case AGGR_DIE:
 		fprintf(config->output, "S%d-D%*d%s%*d%s",
-			cpu_map__id_to_socket(id.id << 16),
+			id.socket,
 			config->csv_output ? 0 : -8,
 			cpu_map__id_to_die(id.id << 16),
 			config->csv_sep,
@@ -95,7 +95,7 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_SOCKET:
 		fprintf(config->output, "S%*d%s%*d%s",
 			config->csv_output ? 0 : -5,
-			id.id,
+			id.socket,
 			config->csv_sep,
 			config->csv_output ? 0 : 4,
 			nr,
@@ -113,7 +113,7 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_NONE:
 		if (evsel->percore && !config->percore_show_thread) {
 			fprintf(config->output, "S%d-D%d-C%*d%s",
-				cpu_map__id_to_socket(id.id),
+				id.socket,
 				cpu_map__id_to_die(id.id),
 				config->csv_output ? 0 : -3,
 				cpu_map__id_to_cpu(id.id), config->csv_sep);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 70c1634f4d62..d93e187f3fc4 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -313,7 +313,7 @@ static int check_per_pkg(struct evsel *counter,
 	if (!(vals->run && vals->ena))
 		return 0;
 
-	s = cpu_map__get_socket(cpus, cpu, NULL).id;
+	s = cpu_map__get_socket(cpus, cpu, NULL).socket;
 	if (s < 0)
 		return -1;
 
-- 
2.28.0

