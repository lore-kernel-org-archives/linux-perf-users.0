Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA2C388F7
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DBB21D1A
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgKMR10 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:27:26 -0500
Received: from foss.arm.com ([217.140.110.172]:42340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgKMR1Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 525831534;
        Fri, 13 Nov 2020 09:27:24 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80FD73F718;
        Fri, 13 Nov 2020 09:27:22 -0800 (PST)
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
Subject: [PATCH 05/13 v4] perf tools: add new map type for aggregation
Date:   Fri, 13 Nov 2020 19:26:46 +0200
Message-Id: <20201113172654.989-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113172654.989-1-james.clark@arm.com>
References: <20201113172654.989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently this is a duplicate of perf_cpu_map so that
it can be used as a drop in replacement.

In a later commit it will be changed from a map of ints
to use the new cpu_aggr_id struct.

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
 tools/perf/util/cpumap.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/cpumap.h | 10 ++++++++++
 2 files changed, 42 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e777024c6676..7500225c8571 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -95,6 +95,38 @@ struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 	return cpus;
 }
 
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
+{
+	struct cpu_aggr_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
+
+	if (cpus != NULL) {
+		int i;
+
+		cpus->nr = nr;
+		for (i = 0; i < nr; i++)
+			cpus->map[i] = -1;
+
+		refcount_set(&cpus->refcnt, 1);
+	}
+
+	return cpus;
+}
+
+void cpu_aggr_map__delete(struct cpu_aggr_map *map)
+{
+	if (map) {
+		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+			  "cpu_aggr_map refcnt unbalanced\n");
+		free(map);
+	}
+}
+
+void cpu_aggr_map__put(struct cpu_aggr_map *map)
+{
+	if (map && refcount_dec_and_test(&map->refcnt))
+		cpu_aggr_map__delete(map);
+}
+
 static int cpu__get_topology_int(int cpu, const char *name, int *value)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index b8c2288a3f6d..ab6be8ef696f 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -11,9 +11,19 @@ struct aggr_cpu_id {
 	int id;
 };
 
+struct cpu_aggr_map {
+	refcount_t refcnt;
+	int nr;
+	int map[];
+};
+
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
+void cpu_aggr_map__delete(struct cpu_aggr_map *map);
+void cpu_aggr_map__put(struct cpu_aggr_map *map);
+
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
-- 
2.28.0

