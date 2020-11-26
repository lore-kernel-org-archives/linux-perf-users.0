Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D3C64E90
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D756820B80
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 14:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390613AbgKZONt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 09:13:49 -0500
Received: from foss.arm.com ([217.140.110.172]:34172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390599AbgKZONt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Nov 2020 09:13:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0087F153B;
        Thu, 26 Nov 2020 06:13:49 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.53.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE7493F71F;
        Thu, 26 Nov 2020 06:13:45 -0800 (PST)
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
Subject: [PATCH v6 02/12] perf tools: Use allocator for perf_cpu_map
Date:   Thu, 26 Nov 2020 16:13:18 +0200
Message-Id: <20201126141328.6509-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201126141328.6509-1-james.clark@arm.com>
References: <20201126141328.6509-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the existing allocator for perf_cpu_map to avoid use
of raw malloc. This could cause an issue in later commits
where the size of perf_cpu_map is changed.

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
 tools/perf/util/cpumap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index dc5c5e6fc502..20e3a75953fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -132,15 +132,16 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 		       int (*f)(struct perf_cpu_map *map, int cpu, void *data),
 		       void *data)
 {
-	struct perf_cpu_map *c;
 	int nr = cpus->nr;
+	struct perf_cpu_map *c = perf_cpu_map__empty_new(nr);
 	int cpu, s1, s2;
 
-	/* allocate as much as possible */
-	c = calloc(1, sizeof(*c) + nr * sizeof(int));
 	if (!c)
 		return -1;
 
+	/* Reset size as it may only be partially filled */
+	c->nr = 0;
+
 	for (cpu = 0; cpu < nr; cpu++) {
 		s1 = f(cpus, cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
@@ -155,7 +156,6 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(int), cmp_ids);
 
-	refcount_set(&c->refcnt, 1);
 	*res = c;
 	return 0;
 }
-- 
2.28.0

