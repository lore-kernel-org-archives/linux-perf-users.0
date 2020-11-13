Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C61C61DD8
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7054E20A8B
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKMR1b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:27:31 -0500
Received: from foss.arm.com ([217.140.110.172]:42376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgKMR13 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706B41534;
        Fri, 13 Nov 2020 09:27:28 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E7373F718;
        Fri, 13 Nov 2020 09:27:26 -0800 (PST)
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
Subject: [PATCH 07/13 v4] perf tools: restrict visibility of functions
Date:   Fri, 13 Nov 2020 19:26:48 +0200
Message-Id: <20201113172654.989-8-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113172654.989-1-james.clark@arm.com>
References: <20201113172654.989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These cpu_aggr_map refcounting functions are only used in
builtin-stat.c so their visibilty can be reduced to just
that file.

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
 tools/perf/builtin-stat.c | 15 +++++++++++++++
 tools/perf/util/cpumap.c  | 15 ---------------
 tools/perf/util/cpumap.h  |  2 --
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7daac139f6cc..344e50651b55 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1326,6 +1326,21 @@ static int perf_stat_init_aggr_mode(void)
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
 	cpu_aggr_map__put(stat_config.aggr_map);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e831a18ec95e..e90270f0be57 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -112,21 +112,6 @@ struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
 	return cpus;
 }
 
-void cpu_aggr_map__delete(struct cpu_aggr_map *map)
-{
-	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
-			  "cpu_aggr_map refcnt unbalanced\n");
-		free(map);
-	}
-}
-
-void cpu_aggr_map__put(struct cpu_aggr_map *map)
-{
-	if (map && refcount_dec_and_test(&map->refcnt))
-		cpu_aggr_map__delete(map);
-}
-
 static int cpu__get_topology_int(int cpu, const char *name, int *value)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index d82822ddcbce..b112069038be 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -21,8 +21,6 @@ struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
 struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
-void cpu_aggr_map__delete(struct cpu_aggr_map *map);
-void cpu_aggr_map__put(struct cpu_aggr_map *map);
 
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
-- 
2.28.0

