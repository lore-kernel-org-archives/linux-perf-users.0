Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC34C55ABD
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595C821D1A
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKMR1m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:27:42 -0500
Received: from foss.arm.com ([217.140.110.172]:42470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgKMR1l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C69781042;
        Fri, 13 Nov 2020 09:27:40 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2B1A3F718;
        Fri, 13 Nov 2020 09:27:38 -0800 (PST)
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
Subject: [PATCH 13/13 v4] perf tools: add thread field
Date:   Fri, 13 Nov 2020 19:26:54 +0200
Message-Id: <20201113172654.989-14-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113172654.989-1-james.clark@arm.com>
References: <20201113172654.989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A separate field isn't strictly required. The core
field could be re-used for thread IDs as a single
field was used previously.

But separating them will avoid confusion and catch
potential errors where core IDs are read as thread
IDs and vice versa.

Also remove the placeholder id field which is now
no longer used.

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
 tools/perf/tests/topology.c    |  8 ++++----
 tools/perf/util/cpumap.c       | 14 +++++++-------
 tools/perf/util/cpumap.h       |  2 +-
 tools/perf/util/stat-display.c |  8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 694f786a77f3..2276db0b1b6f 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -119,7 +119,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
-		TEST_ASSERT_VAL("Core map - ID is set", id.id == -1);
+		TEST_ASSERT_VAL("Core map - Thread is set", id.thread == -1);
 	}
 
 	// Test that die ID contains socket and die
@@ -131,7 +131,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == id.die);
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
-		TEST_ASSERT_VAL("Die map - ID is set", id.id == -1);
+		TEST_ASSERT_VAL("Die map - Thread is set", id.thread == -1);
 	}
 
 	// Test that socket ID contains only socket
@@ -141,7 +141,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
-		TEST_ASSERT_VAL("Socket map - ID is set", id.id == -1);
+		TEST_ASSERT_VAL("Socket map - Thread is set", id.thread == -1);
 	}
 
 	// Test that node ID contains only node
@@ -149,7 +149,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		id = cpu_map__get_node(map, i, NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
 			cpu__get_node(map->map[i]) == id.node);
-		TEST_ASSERT_VAL("Node map - ID shouldn't be set", id.id == -1);
+		TEST_ASSERT_VAL("Node map - Thread shouldn't be set", id.thread == -1);
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 	}
 	perf_session__delete(session);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index d988dfc4e6b6..5f824aa0311d 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -148,16 +148,16 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
 	struct aggr_cpu_id *b = (struct aggr_cpu_id *)b_pointer;
 
-	if (a->id != b->id)
-		return a->id - b->id;
-	else if (a->node != b->node)
+	if (a->node != b->node)
 		return a->node - b->node;
 	else if (a->socket != b->socket)
 		return a->socket - b->socket;
 	else if (a->die != b->die)
 		return a->die - b->die;
-	else
+	else if (a->core != b->core)
 		return a->core - b->core;
+	else
+		return a->thread - b->thread;
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
@@ -617,7 +617,7 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 
 bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
 {
-	return a.id == b.id &&
+	return a.thread == b.thread &&
 		a.node == b.node &&
 		a.socket == b.socket &&
 		a.die == b.die &&
@@ -626,7 +626,7 @@ bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
 {
-	return a.id == -1 &&
+	return a.thread == -1 &&
 		a.node == -1 &&
 		a.socket == -1 &&
 		a.die == -1 &&
@@ -636,7 +636,7 @@ bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
 {
 	struct aggr_cpu_id ret = {
-		.id = -1,
+		.thread = -1,
 		.node = -1,
 		.socket = -1,
 		.die = -1,
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 1bb8f7d47206..a27eeaf086e8 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -8,7 +8,7 @@
 #include <perf/cpumap.h>
 
 struct aggr_cpu_id {
-	int id;
+	int thread;
 	int node;
 	int socket;
 	int die;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6fb70a45afe3..fc741b569096 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -127,9 +127,9 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_THREAD:
 		fprintf(config->output, "%*s-%*d%s",
 			config->csv_output ? 0 : 16,
-			perf_thread_map__comm(evsel->core.threads, id.id),
+			perf_thread_map__comm(evsel->core.threads, id.thread),
 			config->csv_output ? 0 : -8,
-			perf_thread_map__pid(evsel->core.threads, id.id),
+			perf_thread_map__pid(evsel->core.threads, id.thread),
 			config->csv_sep);
 		break;
 	case AGGR_GLOBAL:
@@ -743,7 +743,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 
 		buf[i].counter = counter;
 		buf[i].id = cpu_map__empty_aggr_cpu_id();
-		buf[i].id.id = thread;
+		buf[i].id.thread = thread;
 		buf[i].uval = uval;
 		buf[i].val = val;
 		buf[i].run = run;
@@ -782,7 +782,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
 		if (config->stats)
 			printout(config, buf[thread].id, 0, buf[thread].counter, buf[thread].uval,
 				 prefix, buf[thread].run, buf[thread].ena, 1.0,
-				 &config->stats[buf[thread].id.id]);
+				 &config->stats[buf[thread].id.thread]);
 		else
 			printout(config, buf[thread].id, 0, buf[thread].counter, buf[thread].uval,
 				 prefix, buf[thread].run, buf[thread].ena, 1.0,
-- 
2.28.0

