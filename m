Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77500C63697
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D02C20B80
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbgKZONx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 09:13:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390599AbgKZONx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Nov 2020 09:13:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29EFA1597;
        Thu, 26 Nov 2020 06:13:52 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.53.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FB473F71F;
        Thu, 26 Nov 2020 06:13:49 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     james.clark@arm.com, john.garry@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v6 03/12] perf tools: Add new struct for cpu aggregation
Date:   Thu, 26 Nov 2020 16:13:19 +0200
Message-Id: <20201126141328.6509-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201126141328.6509-1-james.clark@arm.com>
References: <20201126141328.6509-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This struct currently has only a single int member so that
it can be used as a drop in replacement for the existing
behaviour.

Comparison and constructor functions have also been added
that will replace usages of '==' and '= -1'.

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
 tools/perf/util/cpumap.c | 18 ++++++++++++++++++
 tools/perf/util/cpumap.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 20e3a75953fc..8624948b4f1d 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -586,3 +586,21 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 
 	return online;
 }
+
+bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
+{
+	return a.id == b.id;
+}
+
+bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
+{
+	return a.id == -1;
+}
+
+struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
+{
+	struct aggr_cpu_id ret = {
+		.id = -1
+	};
+	return ret;
+}
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 3a442f021468..1cdccc69cd4b 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,6 +7,10 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
+struct aggr_cpu_id {
+	int id;
+};
+
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
@@ -64,4 +68,8 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
+bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b);
+bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a);
+struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void);
+
 #endif /* __PERF_CPUMAP_H */
-- 
2.28.0

