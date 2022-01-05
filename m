Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A87EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiAEGPR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiAEGPD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2641C06139C
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a256706000000b0060aa7315dd9so58380005ybc.9
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2sPeS5hD6XhbS/KjXnNo0OQBT3AjJJ8ohyesk40XqcA=;
        b=ldL8BW7gXh8/9KepY71ByDsGGstCJarcy50vIMcVFnZKjvzBX+dRGoIyDerlIKW4rW
         6rABwnELy5rSo1pp/Q99GJl+XnxUAazw2aNjlOojoVUgyAqFOGD/aaRTsmDE+wkdiN5b
         bAHucWTUtDB67Xe8KWx+FdhrzkJ0qZesS/9ktiIOkC0smNI+d/atdz8QxpuRGm7YtkV5
         3CUiTjlT4j9xZTy+fi+UcHXFXOEnrPVgJ5uTUcxQ00w8QcS5FRO/m6dD/FM0323XLF+b
         9Bvrc57fURO1zkIibDDyki8tocY/BjYzSPzE3+uXneZ0dnSaJlaN6ZS3dAS39JrdTti3
         8k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2sPeS5hD6XhbS/KjXnNo0OQBT3AjJJ8ohyesk40XqcA=;
        b=Pj+iG0ajE7OmaSHidFhPKYe9JKp78F4xzcmRwRVpMlZhN9yldMW0K6fv2BJ0Ek5adu
         eRbh57z9GIx7oT76qKQAzuewJ1i/zshn2b50eluYAKSwdg4TGEhCkMB981aJSY6Q0yTl
         JVvOBblrjQ45EaV5QnN3lVR51sM6im8h4BmbQYm+KFGaRHYz7yr4XRWMZsInuUUoEZUS
         KaaamkN1TF9tjqSAEdNNZdUtjpuOXKs1U/omkNwrVbBem2ujfYOFFkLwQ14U9k1ipvwG
         pwJdAmQIWaEwrdtpHLqMG2yLEROe/FBOXrxF6zJ483djrZ3BcfB6sXModlSd4Jml7Mbk
         L4TQ==
X-Gm-Message-State: AOAM531OuLANQg/0UwAggd3UARQ2fUj3fnlL7a2/ZrQcAqMZXBbQEIuN
        L/DrZGdbgY7NQD3J0SsM/Sv0S/REXlRy
X-Google-Smtp-Source: ABdhPJzvI9mgKC7c2QxXrfa3gLX0pRbsDuozoT96UbLbPrMM+EDLylMN2bvvKGEcj9eV3UaYYOxVEHXpmHcQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:5008:: with SMTP id
 e8mr36319518ybb.522.1641363302068; Tue, 04 Jan 2022 22:15:02 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:29 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-27-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 26/48] perf evsel: Derive CPUs and threads in alloc_counts
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

