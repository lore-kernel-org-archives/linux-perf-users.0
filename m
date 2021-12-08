Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95193C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhLHCt7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbhLHCtz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:49:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C74C061748
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so1998889ybf.23
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vvxFKCm32FDKBVVT+Y4SzOdfXNhc6rbvWIXEF6jE6DQ=;
        b=Dv9Dc8PlF0JH4ig6YwA/rBf+Gtw9KHcOtjiP+SWGVa/jFtmFbc4EnhZJj2nnJzJtW3
         idxhpR+Y+eMQluTVVALLMySCSG+fgBJtGwWPdni5EHVxhJ0C8BZ+/DnJ9JJOVObtSR3d
         keliP6Ac5xD9HHkBzDB+yrZxjKPrboIuen3u82ibrUFDvu7iasd8BvpTCRyzAb6hH5vn
         lkLRtODNObcqZj05lgdJYzwuM7wobvA2O9aq/PsGzVT7EcTz7W3dTyN0lfbtpMoRTK1a
         NsPFK7eKY846XdiugOmAFmSsvHhRle6yNOfHTX7I3t6oTp2/AeyE22WmYsCuUETnB6a3
         UFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vvxFKCm32FDKBVVT+Y4SzOdfXNhc6rbvWIXEF6jE6DQ=;
        b=BF40j1hK6vE4Aj5axtHW9eiXFClxH+cFlcuA0zLncv3P98afRN9PhTqK1KtLXIkfZp
         UWU2AeOTpmJLvs2+hSg5cwKlAK+pxMryPqONkKLpB/RzDMnG9/dTBeOYmsqJRJCenqYq
         zsY2ShQBCmcvOq8aEPxu/S9YX+7M3X+nK2KK45tSHUIggIaqse+2ow5aMYxEuy9/AlyV
         khwW/hLcqomeY0hWcGMNuSKxTbenkn/DnZO3eeqnrtoEQGpS6BUAkUU+qpPWmlfcdi22
         Sw7nL15cXgybDQ9t5tpqtQvIBVdatw3C4Z10lcAR6/5gwvj0NVkn6rqtwLdj+vxwM59Q
         7ozg==
X-Gm-Message-State: AOAM530h48fl6yiPkr8bLiT1txPhkAargnJXQbkOTGcbfHQAdc2L3PzH
        UI6olcHNwglMtNzx/RzSI9FIbzHGWZaa
X-Google-Smtp-Source: ABdhPJwSTlW5v0EAE95vi17bUWEMT7Z/p0SM0/bFVLeSlvg2MLnPsFe6v8FqReJztfz854YuOPi+dLKqFjfg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:6b4d:: with SMTP id
 o13mr56247851ybm.291.1638931584015; Tue, 07 Dec 2021 18:46:24 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:50 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-6-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 05/22] perf cpumap: Switch cpu_map__build_map to cpu function
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
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Avoid error prone cpu_map + idx variant. Remove now unused functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 28 ++++------------------------
 tools/perf/util/cpumap.c  | 12 ++++++------
 tools/perf/util/cpumap.h  |  2 +-
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cbccd6038109..79a435573b44 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1480,11 +1480,6 @@ static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_socket_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1503,11 +1498,6 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_die_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1527,11 +1517,6 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_core_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 {
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
@@ -1540,33 +1525,28 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_node_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				      struct cpu_aggr_map **sockp)
 {
-	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
+	return cpu_map__build_map(cpus, sockp, perf_env__get_socket_aggr_by_cpu, env);
 }
 
 static int perf_env__build_die_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				   struct cpu_aggr_map **diep)
 {
-	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
+	return cpu_map__build_map(cpus, diep, perf_env__get_die_aggr_by_cpu, env);
 }
 
 static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				    struct cpu_aggr_map **corep)
 {
-	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
+	return cpu_map__build_map(cpus, corep, perf_env__get_core_aggr_by_cpu, env);
 }
 
 static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				    struct cpu_aggr_map **nodep)
 {
-	return cpu_map__build_map(cpus, nodep, perf_env__get_node, env);
+	return cpu_map__build_map(cpus, nodep, perf_env__get_node_aggr_by_cpu, env);
 }
 
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 49fba2c53822..feaf34b25efc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -163,7 +163,7 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
+		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data)
 {
 	int nr = cpus->nr;
@@ -178,7 +178,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	c->nr = 0;
 
 	for (cpu = 0; cpu < nr; cpu++) {
-		s1 = f(cpus, cpu, data);
+		s1 = f(cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
 			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
 				break;
@@ -290,22 +290,22 @@ struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *da
 
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
 {
-	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
+	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep)
 {
-	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
+	return cpu_map__build_map(cpus, diep, cpu_map__get_die_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep)
 {
-	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
+	return cpu_map__build_map(cpus, corep, cpu_map__get_core_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **numap)
 {
-	return cpu_map__build_map(cpus, numap, cpu_map__get_node, NULL);
+	return cpu_map__build_map(cpus, numap, cpu_map__get_node_aggr_by_cpu, NULL);
 }
 
 /* setup simple routines to easily access node numbers given a cpu number */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c62d67704425..9648816c4255 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -63,7 +63,7 @@ int cpu__max_present_cpu(void);
 int cpu__get_node(int cpu);
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
+		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data);
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
-- 
2.34.1.400.ga245620fadb-goog

