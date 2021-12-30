Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD8C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhL3HW3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhL3HWB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD840C06175C
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s83-20020a255e56000000b0060c46cc1890so21974769ybb.16
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2sPeS5hD6XhbS/KjXnNo0OQBT3AjJJ8ohyesk40XqcA=;
        b=tJn/3vBsNja0qeXl883/xxbHELrwxgKo1sNalJX4VKGqHdMaQAmQO/shvgknHoc20k
         Wy1h3O8ZkUEHFeaMx+GRIgsVrhVg3yzTjiRwQN15CqIvWj5r4hIiGXcXYqvmCDPH7YRa
         H/7PFZClYW2AgkrSUm7TwyNEOcb5qMG05dElb/aPW+0zYDh0IQ5dBH79SjlQQlQ6O2RU
         HU/GGDRaz5cfQxdixtftY16QfhgaiWR4rs4hW6qsHHCHReWoLBa6f0J15X0NSTVnOfZM
         mWvweMatEKnK385MFfoXm4IqO7ZV+yVGamaWCXo2jWQ4NjUmtjf5+g81KRofdroW2HOp
         8mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2sPeS5hD6XhbS/KjXnNo0OQBT3AjJJ8ohyesk40XqcA=;
        b=dBH1T8Dvngz1Sz7nzwkhUaqHc/GJKGOCd1AUrYU8XSy4m/4G4XJBIyipXKxv0K1+8O
         T5z5m0sYMo547ARoKigN+4qTmi3WGD+4X5/JhaDVo0Sp6Ecdh4u2iBeKL+m2RJhbr8QV
         tm4qz8fpbVEKB6QuN3Xd/mUP19eviddKvka3m2evntIUKjSuxvb1gve3R9LY/ic9TK3B
         pntTZQ7Qs2KadfuGOgWXGj5W7hxXU2HoCM3lZltQCHo8hZuw8K0qshLbXukkFARzoicY
         QrE3PwL2XO0KjdJg4pU/y5WAPzS8FnLQLTrLC9YggzvDXkNd9XnMQYYvbWuzELcoJjGB
         1wmg==
X-Gm-Message-State: AOAM533R4NnUEfsOZ4HiNdt/rKTbHCCuAP1JK0SR0kHq3j0Oy6F26nQe
        RYgf4dFI70nRrZwELl07VdkDz/MjQQg1
X-Google-Smtp-Source: ABdhPJxIJGv5f32bbnWDxoBjOZ4z6bbGu5gRAbrpbKMmKOETGNeJLi2vdjFJ5lE/6B3uh3efUR3ZLq/xtbT7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:9b02:: with SMTP id
 y2mr1548457ybn.210.1640848903013; Wed, 29 Dec 2021 23:21:43 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:08 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-28-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 26/48] perf evsel: Derive CPUs and threads in alloc_counts
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Passing the number of CPUs and threads allows for an evsel's counts to
be mismatched to its cpu map. To avoid this always derive the counts
size from the cpu map. Change openat-syscall-all-cpus to set the cpus
to allow for this to work.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 10 +---------
 tools/perf/util/counts.c                   |  8 ++++++--
 tools/perf/util/counts.h                   |  2 +-
 tools/perf/util/evsel.c                    |  2 +-
 tools/perf/util/stat.c                     | 13 ++++++-------
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index cd3dd463783f..544db0839b3b 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -85,15 +85,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		CPU_CLR(cpus->map[cpu], &cpu_set);
 	}
 
-	/*
-	 * Here we need to explicitly preallocate the counts, as if
-	 * we use the auto allocation it will allocate just for 1 cpu,
-	 * as we start by cpu 0.
-	 */
-	if (evsel__alloc_counts(evsel, cpus->nr, 1) < 0) {
-		pr_debug("evsel__alloc_counts(ncpus=%d)\n", cpus->nr);
-		goto out_close_fd;
-	}
+	evsel->core.cpus = perf_cpu_map__get(cpus);
 
 	err = 0;
 
diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 582f3aeaf5e4..2b81707b9dba 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include "evsel.h"
 #include "counts.h"
+#include <perf/threadmap.h>
 #include <linux/zalloc.h>
 
 struct perf_counts *perf_counts__new(int ncpus, int nthreads)
@@ -55,9 +56,12 @@ void evsel__reset_counts(struct evsel *evsel)
 	perf_counts__reset(evsel->counts);
 }
 
-int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads)
+int evsel__alloc_counts(struct evsel *evsel)
 {
-	evsel->counts = perf_counts__new(ncpus, nthreads);
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
+	int nthreads = perf_thread_map__nr(evsel->core.threads);
+
+	evsel->counts = perf_counts__new(cpus ? cpus->nr : 1, nthreads);
 	return evsel->counts != NULL ? 0 : -ENOMEM;
 }
 
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 7ff36bf6d644..3e275e9c60d1 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -40,7 +40,7 @@ void perf_counts__delete(struct perf_counts *counts);
 void perf_counts__reset(struct perf_counts *counts);
 
 void evsel__reset_counts(struct evsel *evsel);
-int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
+int evsel__alloc_counts(struct evsel *evsel);
 void evsel__free_counts(struct evsel *evsel);
 
 #endif /* __PERF_COUNTS_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 656c30b988ce..6c9af21776e6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1578,7 +1578,7 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;
 
-	if (evsel->counts == NULL && evsel__alloc_counts(evsel, cpu + 1, thread + 1) < 0)
+	if (evsel->counts == NULL && evsel__alloc_counts(evsel) < 0)
 		return -ENOMEM;
 
 	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c69b221f5e3e..995cb5003133 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -152,11 +152,13 @@ static void evsel__free_stat_priv(struct evsel *evsel)
 	zfree(&evsel->stats);
 }
 
-static int evsel__alloc_prev_raw_counts(struct evsel *evsel, int ncpus, int nthreads)
+static int evsel__alloc_prev_raw_counts(struct evsel *evsel)
 {
+	int cpu_map_nr = evsel__nr_cpus(evsel);
+	int nthreads = perf_thread_map__nr(evsel->core.threads);
 	struct perf_counts *counts;
 
-	counts = perf_counts__new(ncpus, nthreads);
+	counts = perf_counts__new(cpu_map_nr, nthreads);
 	if (counts)
 		evsel->prev_raw_counts = counts;
 
@@ -177,12 +179,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
 
 static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 {
-	int ncpus = evsel__nr_cpus(evsel);
-	int nthreads = perf_thread_map__nr(evsel->core.threads);
-
 	if (evsel__alloc_stat_priv(evsel) < 0 ||
-	    evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
-	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel, ncpus, nthreads) < 0))
+	    evsel__alloc_counts(evsel) < 0 ||
+	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
 		return -ENOMEM;
 
 	return 0;
-- 
2.34.1.448.ga2b2bfdf31-goog

